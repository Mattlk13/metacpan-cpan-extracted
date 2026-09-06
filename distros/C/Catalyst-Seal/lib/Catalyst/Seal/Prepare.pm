package Catalyst::Seal::Prepare;

use strict;
use warnings;

use Scalar::Util ();

use Catalyst::Seal ();
use Catalyst::Seal::Guard ();

our $VERSION = '0.04';

my $DONE = 0;

sub _is_strict_utf8 {
    my ($enc) = @_;
    return 0 unless $enc;
    my $name = eval { $enc->name };
    return defined $name && $name eq 'utf-8-strict';
}

sub _handle_param_unicode_decoding {
    my ( $self, $value, $check ) = @_;
    return unless defined $value;
    return $value if Scalar::Util::blessed($value);

    my $enc = $self->encoding;

    return $value unless $enc;

    if (_is_strict_utf8($enc)) {
        my @fast = Catalyst::Seal::_decode_param($value, 0, 1);
        return wantarray ? @fast : $fast[0] if @fast;
    }

    $check ||= $self->_encode_check;

    local $@;
    my @out = eval { $enc->decode( $value, $check ) };
    my $err = $@;
    return wantarray ? @out : $out[0] unless $err;

    return $self->handle_unicode_encoding_exception({
        param_value   => $value,
        error_msg     => $err,
        encoding_step => 'params',
    });
}

use constant _FIELD_MAX => 256;

my %FIELD;

sub _learn_field {
    my ($key) = @_;

    return 0 unless $key =~ /^(HTTP|CONTENT|COOKIE)/i;

    (my $field = $key) =~ s/^HTTPS?_//;
    $field =~ tr/_/-/;

    require HTTP::Headers;
    my $probe = HTTP::Headers->new;
    my $ok = eval { $probe->header($field => 'probe'); 1 };
    return 1 unless $ok;

    my $std = delete $probe->{'::std_case'};
    my @keys = keys %$probe;
    return 1 unless @keys == 1;

    my $stored = $probe->{ $keys[0] };
    return 1 if ref $stored;
    return 1 unless defined $stored && $stored eq 'probe';

    return 1 if $std && keys %$std != 1;
    return [ $keys[0], $std ? $std->{ $keys[0] } : undef ];
}

sub _prepare_headers {
    my ($self) = @_;

    my $env = $self->env;
    my $headers = HTTP::Headers->new();
    my %std;

    my $todo = ref $env eq 'HASH'
        ? Catalyst::Seal::_build_headers($env, \%FIELD, $headers, \%std)
        : [ keys %$env ];

    for my $key (@$todo) {
        my $field = $FIELD{$key};
        unless (defined $field) {
            if (keys(%FIELD) >= _FIELD_MAX) {
                next unless $key =~ /^(HTTP|CONTENT|COOKIE)/i;
                $field = 1;
            }
            else {
                $field = $FIELD{$key} = _learn_field($key);
            }
        }
        next unless $field;

        my $value = $env->{$key};

        if (!ref $field || !defined $value || ref $value) {
            (my $name = $key) =~ s/^HTTPS?_//;
            $name =~ tr/_/-/;
            $headers->header($name => $value);
            next;
        }

        $headers->{ $field->[0] } = $value;
        $std{ $field->[0] } = $field->[1] if defined $field->[1];
    }

    if (%std) {
        my $existing = $headers->{'::std_case'};
        @std{ keys %$existing } = values %$existing if $existing;
        $headers->{'::std_case'} = \%std;
    }

    return $headers;
}

my $FAST_CANONICAL = 0;

sub _probe_canonical {
    require URI;
    require URI::http;

    for my $str ('http://127.0.0.1/', 'http://example.com:8080/a/b?x=Y',
                 'https://example.com/') {
        my $uri = $str;
        my $obj = bless \$uri, 'URI::http';
        my $out = eval { $obj->canonical };
        return 0 unless $out && Scalar::Util::refaddr($out) == Scalar::Util::refaddr($obj);
    }

    for my $str ('http://EXAMPLE.com/', 'http://example.com:80/', 'http://example.com/%2f') {
        my $uri = $str;
        my $obj = bless \$uri, 'URI::http';
        my $out = eval { $obj->canonical };
        return 0 unless $out && Scalar::Util::refaddr($out) != Scalar::Util::refaddr($obj);
    }

    return 1;
}

sub _prepare_path {
    my ($self, $ctx) = @_;

    my $req = $ctx->request;
    my $env = $req->env;

    my $scheme    = $req->secure ? 'https' : 'http';
    my $host      = $env->{HTTP_HOST} || $env->{SERVER_NAME};
    my $port      = $env->{SERVER_PORT} || 80;
    my $base_path = $env->{SCRIPT_NAME} || "/";

    my $path;
    if (!$ctx->config->{use_request_uri_for_path}) {
        my $path_info = $env->{PATH_INFO};
        if ( exists $env->{REDIRECT_URL} ) {
            $base_path = $env->{REDIRECT_URL};
            $base_path =~ s/\Q$path_info\E$//;
        }
        $path = $base_path . $path_info;
        $path =~ s{^/+}{};
        $path =~ s/([^$URI::uric])/$URI::Escape::escapes{$1}/go;
        $path =~ s/\?/%3F/g;
    }
    else {
        my $req_uri = $env->{REQUEST_URI};
        $req_uri =~ s/\?.*$//;
        $path = $req_uri;
        $path =~ s{^/+}{};
    }

    my $uri_class = "URI::$scheme";

    $host =~ s/:(?:80|443)$//;

    if ($port !~ /^(?:80|443)$/ && $host !~ /:/) {
        $host .= ":$port";
    }

    my $query = $env->{QUERY_STRING} ? '?' . $env->{QUERY_STRING} : '';
    my $uri   = $scheme . '://' . $host . '/' . $path . $query;
    my $obj   = bless \$uri, $uri_class;

    $req->uri(
        (        $uri !~ /%[0-9A-Fa-f]{2}/
              && $uri =~ m{\A[a-z][a-z0-9+.\-]*://([^/?\#]*)}
              && $1 !~ /[A-Z:]/ )
            ? $obj
            : $obj->canonical
    );

    $base_path .= '/' unless $base_path =~ m{/$};

    my $base_uri = $scheme . '://' . $host . $base_path;

    $req->base( bless \$base_uri, $uri_class );

    return;
}

sub _prepare_query_parameters {
    my ($self, $c) = @_;

    my $stock = $Catalyst::Seal::Guard::ORIGINAL{
        'Catalyst::Engine::prepare_query_parameters'};

    my $req    = $c->request;
    my $config = $c->config;

    goto &$stock if $config->{do_not_decode_query}
                 || $config->{default_query_encoding}
                 || $config->{do_not_check_query_encoding}
                 || $req->_use_hash_multivalue;

    my $enc = $c->encoding;
    goto &$stock if $enc && !_is_strict_utf8($enc);

    my $env = $req->env;
    my $qs  = exists $env->{QUERY_STRING} ? $env->{QUERY_STRING} : '';

    my ($params, $keywords) = Catalyst::Seal::_parse_query($qs, $enc ? 1 : 0);
    goto &$stock unless $params;

    $req->query_keywords($keywords) if defined $keywords;
    $req->query_parameters($params);
    return;
}

Catalyst::Seal::register_step('prepare' => sub {
    return if $DONE++;

    require HTTP::Headers;
    require URI;
    require URI::Escape;

    Catalyst::Seal::Guard::replace(
        'Catalyst::_handle_param_unicode_decoding' => \&_handle_param_unicode_decoding);

    Catalyst::Seal::Guard::replace(
        'Catalyst::Engine::prepare_query_parameters' => \&_prepare_query_parameters);

    Catalyst::Seal::Guard::replace(
        'Catalyst::Request::prepare_headers' => \&_prepare_headers);

    if (_probe_canonical()) {
        $FAST_CANONICAL = 1;
        Catalyst::Seal::Guard::replace(
            'Catalyst::Engine::prepare_path' => \&_prepare_path);
    }
    else {
        Catalyst::Seal::note(
            'URI::canonical does not behave the way prepare_path relies on, path not patched');
    }

    return;
});

sub fast_canonical { $FAST_CANONICAL }

1;

__END__

=head1 NAME

Catalyst::Seal::Prepare - the request preparation path

=head1 DESCRIPTION

C<Catalyst::prepare> turns a PSGI environment into a request object. What that
costs, measured by replacing each part with a stub that answers from a constant
and timing the whole request, on a hello world application with phases 0 to 3
already applied:

    prepare_query_parameters   4.3 us on an empty query string
                              34.0 us on "a=1&b=two&c=caf%C3%A9&d=one+two"
    prepare_path               8.0 us
    prepare_headers            7.3 us

A stub is the ceiling: no implementation of a subroutine beats not running it.
Splitting the first of those again says where it goes, and it is not where the
plan for this phase expected:

    the whole unicode decoding step   23.7 us
      of which Try::Tiny              15.0 us
    percent and plus unescaping        2.7 us

So the largest single item in request preparation is not parsing. It is that
L<Catalyst> decodes every parameter name and every parameter value inside a
L<Try::Tiny> block, which builds two closures and names them, per string.

=head2 What this module does

=over 4

=item * C<Catalyst::_handle_param_unicode_decoding>, C<try> rewritten as
C<eval>. Query parameters, body parameters and path arguments all decode
through it, so it is paid once per string in the request.

=item * C<Catalyst::Request::prepare_headers>, building the
L<HTTP::Headers> hash directly instead of through 29 C<header> calls.

=item * C<Catalyst::Engine::prepare_path>, skipping C<URI::canonical> when the
URI it just built is already canonical, which is decidable with one regex and
costs three authority parses to ask L<URI>.

=back

=cut

=head2 The parameter decoder

C<Catalyst::_handle_param_unicode_decoding> is phase 0.4 applied to a third
site, with the same three things to preserve:

C<$@> is read immediately after the C<eval>, and C<local $@> restores the
caller's, which is what L<Try::Tiny> does and a bare C<eval> does not.

C<eval { ...; 1 }> is not used here because the value of the block is the
return value. C<@out> distinguishes a failed decode from one that returned
false, which testing C<$@> alone would not.

C<return unless defined $value> returns the empty list in list context, and
this subroutine is called from inside a C<map>. It stays exactly as it is.

=cut

=head2 The headers

L<HTTP::Headers> stores a header as C<$self-E<gt>{lc $field}>, plus an entry in
C<$self-E<gt>{'::std_case'}> naming the spelling to use on the way out for any
field it does not already know. Building that hash directly is a third of
C<prepare_headers>.

The spelling is not copied out of L<HTTP::Headers>. Its list of known headers
is a lexical, and a copy of it here would be wrong the day a header is added to
it, in a way that only shows up in the C<as_string> of a response. Instead the
first request that carries a given environment key sets that one header on a
throwaway L<HTTP::Headers> the ordinary way and remembers what came out. The
answer is HTTP::Headers' own, so there is nothing to keep in step, and the
probe is also the check: a field whose result is not one plain string under one
key is left to the stock path forever.

The memo is bounded. A client that sends a thousand distinct header names must
not be able to grow it, so past the cap an unrecognised key takes the stock
path and is not remembered.

=cut

=head2 The path

C<prepare_path> builds the request URI as a string, blesses a reference to it
into C<URI::http>, and calls C<canonical>. C<URI::_server::canonical> parses the
authority three times to decide whether anything needs canonicalising, and on a
URI that is already canonical it returns the object it was given.

That decision is one regex here: a lower case scheme, no percent escape
anywhere in the string, and an authority with no upper case and no port. Under
those three conditions L<URI> cannot find anything to change, and returns the
same object this would.

The conditions are checked against L<URI> itself at seal time rather than
against its source, because what matters is the behaviour and not the spelling.
A negative control is part of that: a probe that only ever confirms is a probe
that would pass against a C<canonical> that had stopped working.

=cut

=head2 fast_canonical

    my $bool = Catalyst::Seal::Prepare::fast_canonical();

Whether the C<prepare_path> patch was installed. For the test suite.

=cut

=head2 The query string

The stock C<prepare_query_parameters> builds a decoder closure, a
L<Hash::MultiValue> and a regex before it has looked at the query string,
splits it in Perl, and puts the name and the value of every pair through
C<unescape_uri> and then through C<_handle_param_unicode_decoding> - eight
calls a pair, each of them with an C<eval> in it. Measured, best of five:

    query string          stock      here
    (empty)             1.93 us   0.78 us
    a=1&b=2&c=3&d=4    12.90 us   1.29 us
    a=caf%C3%A9&b=one+two 8.86 us  1.08 us

The C parser does the split, the percent-decode and the UTF-8 decode in one
pass and hands back the hash Catalyst was going to build - a value for a name
that appeared once, an array reference for one that appeared more than once.

It hands the whole query to the stock parser rather than half-answering it,
for any of: C<do_not_decode_query>, C<default_query_encoding> or
C<do_not_check_query_encoding> in the configuration; an encoding that is not
UTF-8; a request asking for L<Hash::MultiValue>, whose key order this does not
promise to reproduce; or a byte sequence the decoder will not vouch for.

=head2 What the decoder calls UTF-8

Exactly what Encode calls UTF-8, which is not the same as what perl calls
C<utf8> and not quite what the encoding's shape alone would suggest. No
overlong form, no surrogate, nothing above U+10FFFF, nothing truncated - and
none of the sixty-six noncharacters, U+FDD0 to U+FDEF and U+xFFFE and U+xFFFF
in every plane, which Encode refuses and a validator written from the bit
patterns would accept.

That list was measured against Encode 3.21 rather than read off a
specification, and F<t/56-query.t> re-measures it: it walks the boundary of
every branch and asks both Encode and the decoder, and fails if they ever
disagree.

Being wrong in one direction costs a slow path, and in the other it admits a
request that should have been refused. Anything the decoder will not vouch for
goes to Encode, which refuses it and words the refusal the way Catalyst's
C<handle_unicode_encoding_exception> expects.

=cut

=head2 The header pass

C<prepare_headers> asks HTTP::Headers for the spelling of each field once, the
first time a request carries it, and remembers it. What is left after that is a
loop over the environment doing a hash lookup and two stores per key, and that
loop is in C: 1.54 us to 0.94, against the 4.28 the stock body costs.

The C pass hands back the keys it could not place - one never seen before, one
marked for the long way, or one whose value is not a plain string - and the
Perl above finishes those. After the first request of a given shape there are
none.

An environment that is not a hash reference at all is left to Perl too. Reading
C<parameters> off a bare L<Catalyst::Request> does exactly that, and what the
stock body does about it is what C<keys %$env> does: autovivify an empty one
and return empty headers.

=cut

=head1 AUTHOR

LNATION <email@lnation.org>

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2026 by LNATION <email@lnation.org>.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

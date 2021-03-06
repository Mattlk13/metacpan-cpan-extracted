#  Options.pm
#    - providing an object-oriented approach to GnuPG's options
#
#  Copyright (C) 2000 Frank J. Tobin <ftobin@cpan.org>
#
#  This module is free software; you can redistribute it and/or modify it
#  under the same terms as Perl itself.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
#  $Id: Options.pm,v 1.14 2001/08/21 13:31:50 ftobin Exp $
#

package GnuPG::Options;
use Moo;
use MooX::late;
use MooX::HandlesVia;
with qw(GnuPG::HashInit);

use constant BOOLEANS => qw(
    armor
    no_greeting
    verbose
    no_verbose
    quiet
    batch
    always_trust
    rfc1991
    openpgp
    force_v3_sigs
    no_options
    textmode
    meta_pgp_5_compatible
    meta_pgp_2_compatible
    meta_interactive
    ignore_mdc_error
    keyring
    no_default_keyring
);

use constant SCALARS => qw(
    homedir
    default_key
    comment
    status_fd
    logger_fd
    passphrase_fd
    command_fd
    compress_algo
    options
    meta_signing_key
    meta_signing_key_id
    debug_level
    logger_file
);

use constant LISTS => qw(
    encrypt_to
    recipients
    meta_recipients_keys
    meta_recipients_key_ids
    extra_args
);

has $_ => (
    isa     => 'Bool',
    is      => 'rw',
    clearer => 'clear_' . $_,
) for BOOLEANS;

has $_ => (
    isa     => 'Any',
    is      => 'rw',
    clearer => 'clear_' . $_,
) for SCALARS;

for my $list (LISTS) {
    my $ref = $list . "_ref";
    has $ref => (
        handles_via => 'Array',
        is          => 'rw',
        lazy        => 1,
        clearer     => "clear_$list",
        default     => sub { [] },
        handles     => {
            "push_$list" => 'push',
        },
    );

    no strict 'refs';
    *{$list} = sub {
        my $self = shift;
        return wantarray ? @{$self->$ref(@_)} : $self->$ref(@_);
    };
}

sub BUILD {
    my ( $self, $args ) = @_;
    # Newer GnuPG will force failure for old ciphertext unless set
    $args->{ignore_mdc_error} //= 1;

    $self->hash_init( meta_interactive => 1 );
    $self->hash_init(%$args);
}

sub copy {
    my ($self) = @_;

    my $new = ( ref $self )->new();

    foreach my $field ( BOOLEANS, SCALARS, LISTS ) {
        my $value = $self->$field();
        next unless defined $value;
        $new->$field($value);
    }

    return $new;
}

sub get_args {
    my ($self) = @_;

    return (
        $self->get_meta_args(),
        $self->get_option_args(),
        $self->extra_args(),
    );
}

sub get_option_args {
    my ($self) = @_;

    my @args = ();

    push @args, '--homedir', $self->homedir() if $self->homedir();
    push @args, '--options', $self->options() if $self->options();
    push @args, '--no-options' if $self->no_options();
    push @args, '--armor'      if $self->armor();
    push @args, '--textmode'   if $self->textmode();
    push @args, '--default-key', $self->default_key() if $self->default_key();
    push @args, '--no-greeting'  if $self->no_greeting();
    push @args, '--verbose'      if $self->verbose();
    push @args, '--no-verbose'   if $self->no_verbose();
    push @args, '--quiet'        if $self->quiet();
    push @args, '--batch'        if $self->batch();
    push @args, '--trust-model=always' if $self->always_trust();
    push @args, '--comment', $self->comment() if defined $self->comment();
    push @args, '--force-v3-sigs' if $self->force_v3_sigs();
    push @args, '--rfc1991'       if $self->rfc1991;
    push @args, '--openpgp'       if $self->openpgp();
    push @args, '--compress-algo', $self->compress_algo()
        if defined $self->compress_algo();

    push @args, '--status-fd', $self->status_fd()
        if defined $self->status_fd();
    push @args, '--logger-fd', $self->logger_fd()
        if defined $self->logger_fd();
    push @args, '--passphrase-fd', $self->passphrase_fd()
        if defined $self->passphrase_fd();
    push @args, '--command-fd', $self->command_fd()
        if defined $self->command_fd();

    push @args, map { ( '--recipient',  $_ ) } $self->recipients();
    push @args, map { ( '--encrypt-to', $_ ) } $self->encrypt_to();

    push @args, '--debug-level', $self->debug_level() if ($self->debug_level);
    push @args, '--logger-file', $self->logger_file() if ($self->logger_file());

    push @args, '--ignore-mdc-error' if ($self->ignore_mdc_error());
    push @args, '--keyring' if ( $self->keyring() );
    push @args, '--no-default-keyring' if ( $self->no_default_keyring() );

    return @args;
}

sub get_meta_args {
    my ($self) = @_;

    my @args = ();

    push @args, '--compress-algo', 1, '--force-v3-sigs'
        if $self->meta_pgp_5_compatible();
    push @args, '--rfc1991' if $self->meta_pgp_2_compatible();
    push @args, '--batch', '--no-tty' if not $self->meta_interactive();

    # To eliminate confusion, we'll move to having any options
    # that deal with keys end in _id(s) if they only take
    # an id; otherwise we assume that a GnuPG::Key
    push @args, '--default-key', $self->meta_signing_key_id()
        if $self->meta_signing_key_id();
    push @args, '--default-key', $self->meta_signing_key()->hex_id()
        if $self->meta_signing_key();

    push @args,
        map { ( '--recipient', $_ ) } $self->meta_recipients_key_ids();
    push @args,
        map { ( '--recipient', $_->hex_id() ) } $self->meta_recipients_keys();

    return @args;
}

1;

__END__

=head1 NAME

GnuPG::Options - GnuPG options embodiment

=head1 SYNOPSIS

  # assuming $gnupg is a GnuPG::Interface object
  $gnupg->options->armor( 1 );
  $gnupg->options->push_recipients( 'ftobin', '0xABCD1234ABCD1234ABCD1234ABCD1234ABCD1234' );

=head1 DESCRIPTION

GnuPG::Options objects are generally not instantiated on their
own, but rather as part of a GnuPG::Interface object.

=head1 OBJECT METHODS

=over 4

=item new( I<%initialization_args> )

This methods creates a new object.  The optional arguments are
initialization of data members.

=item hash_init( I<%args> ).


=item copy

Returns a copy of this object.  Useful for 'saving' options.

=item get_args

Returns a list of arguments to be passed to GnuPG based
on data members which are 'meta_' options, regular options,
and then I<extra_args>, in that order.

=back

=head1 OBJECT DATA MEMBERS

=over 4

=item homedir

=item armor

=item textmode

=item default_key

=item no_greeting

=item verbose

=item no_verbose

=item quiet

=item batch

=item always_trust

=item comment

=item status_fd

=item logger_fd

=item passphrase_fd

=item compress_algo

=item force_v3_sigs

=item rfc1991

=item openpgp

=item options

=item no_options

=item encrypt_to

=item recipients

=back

These options correlate directly to many GnuPG options.  For those that
are boolean to GnuPG, simply that argument is passed.  For those
that are associated with a scalar, that scalar is passed passed
as an argument appropriate.  For those that can be specified more
than once, such as B<recipients>, those are considered lists
and passed accordingly.  Each are undefined or false to begin.

=head2 Meta Options

Meta options are those which do not correlate directly to any
option in GnuPG, but rather are generally a bundle of options
used to accomplish a specific goal, such as obtaining
compatibility with PGP 5.  The actual arguments each of these
reflects may change with time.  Each defaults to false unless
otherwise specified.

These options are being designed and to provide a non-GnuPG-specific
abstraction, to help create compatibility with a possible
PGP::Interface module.

To help avoid confusion, methods with take a form of a key as
an object shall be prepended with I<_id(s)> if they only
take an id; otherwise assume an object of type GnuPG::Key
is required.

=over 4

=item meta_pgp_5_compatible

If true, arguments are generated to try to be compatible with PGP 5.x.

=item meta_pgp_2_compatible

If true, arguments are generated to try to be compatible with PGP 2.x.

=item meta_interactive

If false, arguments are generated to try to help the using program
use GnuPG in a non-interactive environment, such as CGI scripts.
Default is true.

=item meta_signing_key_id

This scalar reflects the key used to sign messages.
Currently this is synonymous with I<default-key>.

=item meta_signing_key

This GnuPG::Key object reflects the key used to sign messages.

=item meta_recipients_key_ids

This list of scalar key ids are used to generate the
appropriate arguments having these keys as recipients.

=item meta_recipients_keys

This list of keys of the type GnuPG::Key are used to generate the
appropriate arguments having these keys as recipients.
You probably want to have this list be of the inherited class
GnuPG::SubKey, as in most instances, OpenPGP keypairs have
the encyrption key as the subkey of the primary key, which is
used for signing.

=back

=head2 Other Data Members

=over 4

=item extra_args

This is a list of any other arguments used to pass to GnuPG.
Useful to pass an argument not yet covered in this package.

=back

=head1 SEE ALSO

L<GnuPG::Interface>,

=cut

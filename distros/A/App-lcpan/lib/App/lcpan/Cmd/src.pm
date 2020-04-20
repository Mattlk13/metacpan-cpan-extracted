package App::lcpan::Cmd::src;

our $DATE = '2020-04-20'; # DATE
our $VERSION = '1.051'; # VERSION

use 5.010;
use strict;
use warnings;

use Encode qw(decode);

require App::lcpan;
require App::lcpan::Cmd::doc;

our %SPEC;

my $args = { %{ $App::lcpan::Cmd::doc::SPEC{'handle_cmd'}{args} } }; # shallow clone
delete $args->{format};

$SPEC{'handle_cmd'} = {
    v => 1.1,
    summary => 'Show source of module/.pod/script',
    description => <<'_',

This command is a shortcut for:

    % lcpan doc --raw MODULE_OR_POD_OR_SCRIPT

_
    args => $args,
};
sub handle_cmd {
    my %args = @_;

    App::lcpan::Cmd::doc::handle_cmd(%args, format=>'raw');
}

1;
# ABSTRACT: Show source of module/.pod/script

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::src - Show source of module/.pod/script

=head1 VERSION

This document describes version 1.051 of App::lcpan::Cmd::src (from Perl distribution App-lcpan), released on 2020-04-20.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [status, msg, payload, meta]

Show source of moduleE<sol>.podE<sol>script.

This command is a shortcut for:

 % lcpan doc --raw MODULE_OR_POD_OR_SCRIPT

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. E<sol>pathE<sol>toE<sol>cpan.

Defaults to C<~/cpan>.

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

If C<index_name> is a filename without any path, e.g. C<index.db> then index will
be located in the top-level of C<cpan>. If C<index_name> contains a path, e.g.
C<./index.db> or C</home/ujang/lcpan.db> then the index will be located solely
using the C<index_name>.

=item * B<name>* => I<str>

Module or script name.

If the name matches both module name and script name, the module will be chosen.
To choose the script, use C<--script> (C<-s>).

=item * B<script> => I<bool>

Look for script first.

=item * B<use_bootstrap> => I<bool> (default: 1)

Whether to use bootstrap database from App-lcpan-Bootstrap.

If you are indexing your private CPAN-like repository, you want to turn this
off.


=back

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (payload) is optional, the actual result. Fourth
element (meta) is called result metadata and is optional, a hash
that contains extra information.

Return value:  (any)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/App-lcpan>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-lcpan>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-lcpan>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020, 2019, 2018, 2017, 2016, 2015 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

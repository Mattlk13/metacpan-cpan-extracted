package App::lcpan::Cmd::rdeps;

our $DATE = '2018-06-21'; # DATE
our $VERSION = '1.023'; # VERSION

use 5.010;
use strict;
use warnings;

require App::lcpan;

our %SPEC;

$SPEC{handle_cmd} = $App::lcpan::SPEC{rdeps};
*handle_cmd = \&App::lcpan::rdeps;

1;
# ABSTRACT: List reverse dependencies

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::rdeps - List reverse dependencies

=head1 VERSION

This document describes version 1.023 of App::lcpan::Cmd::rdeps (from Perl distribution App-lcpan), released on 2018-06-21.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [status, msg, result, meta]

List reverse dependencies.

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<authors> => I<array[str]>

Filter certain author.

This can be used to select certain author(s).

=item * B<authors_arent> => I<array[str]>

Filter out certain author.

This can be used to filter out certain author(s). For example if you want to
know whether a module is being used by another CPAN author instead of just
herself.

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. /path/to/cpan.

Defaults to C<~/cpan>.

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

If C<index_name> is a filename without any path, e.g. C<index.db> then index will
be located in the top-level of C<cpan>. If C<index_name> contains a path, e.g.
C<./index.db> or C</home/ujang/lcpan.db> then the index will be located solely
using the C<index_name>.

=item * B<level> => I<int> (default: 1)

Recurse for a number of levels (-1 means unlimited).

=item * B<modules>* => I<array[perl::modname]>

=item * B<phase> => I<str> (default: "ALL")

=item * B<rel> => I<str> (default: "ALL")

=back

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (result) is optional, the actual result. Fourth
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

This software is copyright (c) 2018, 2017, 2016, 2015 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

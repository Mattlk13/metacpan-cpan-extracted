package App::lcpan::Cmd::authors;

our $DATE = '2020-08-13'; # DATE
our $VERSION = '1.062'; # VERSION

use 5.010;
use strict;
use warnings;

require App::lcpan;

our %SPEC;

$SPEC{handle_cmd} = $App::lcpan::SPEC{authors};
*handle_cmd = \&App::lcpan::authors;

1;
# ABSTRACT: List authors

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::authors - List authors

=head1 VERSION

This document describes version 1.062 of App::lcpan::Cmd::authors (from Perl distribution App-lcpan), released on 2020-08-13.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [status, msg, payload, meta]

List authors.

Examples:

=over

=item * List all authors:

 handle_cmd();

=item * Find CPAN IDs which start with something:

 handle_cmd( query => ["MICHAEL%"]); # -> undef

=back

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<added_or_updated_since> => I<date>

Include only records that are addedE<sol>updated since a certain date.

=item * B<added_or_updated_since_last_index_update> => I<true>

Include only records that are addedE<sol>updated since the last index update.

=item * B<added_or_updated_since_last_n_index_updates> => I<posint>

Include only records that are addedE<sol>updated since the last N index updates.

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. E<sol>pathE<sol>toE<sol>cpan.

Defaults to C<~/cpan>.

=item * B<detail> => I<bool>

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

If C<index_name> is a filename without any path, e.g. C<index.db> then index will
be located in the top-level of C<cpan>. If C<index_name> contains a path, e.g.
C<./index.db> or C</home/ujang/lcpan.db> then the index will be located solely
using the C<index_name>.

=item * B<or> => I<bool>

When there are more than one query, perform OR instead of AND logic.

=item * B<query> => I<array[str]>

Search query.

=item * B<query_type> => I<str> (default: "any")

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


By default will return an array of CPAN ID's. If you set C<detail> to true, will
return array of records.

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

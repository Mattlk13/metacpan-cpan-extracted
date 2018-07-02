package App::lcpan::Cmd::dist_contents;

our $DATE = '2018-06-21'; # DATE
our $VERSION = '1.023'; # VERSION

use 5.010;
use strict;
use warnings;

require App::lcpan;
require App::lcpan::Cmd::contents;

our %SPEC;

my %cmd_args = (
    %{ $App::lcpan::Cmd::contents::SPEC{handle_cmd}{args} },
    %App::lcpan::dist_args,
);
delete $cmd_args{query};
delete $cmd_args{query_type};

$SPEC{'handle_cmd'} = {
    v => 1.1,
    summary => 'List contents inside a distribution',
    description => <<'_',

This subcommand lists files inside a distribution.

    % lcpan dist-contents Foo-Bar

is basically equivalent to:

    % lcpan contents --dist Foo-Bar

_
    args => \%cmd_args,
};
sub handle_cmd {
    my %args = @_;

    my $state = App::lcpan::_init(\%args, 'ro');
    my $dbh = $state->{dbh};

    my ($dist_id) = $dbh->selectrow_array(
        "SELECT id FROM dist WHERE name=?", {}, $args{dist});
    $dist_id or return [404, "No such dist '$args{dist}'"];

    App::lcpan::Cmd::contents::handle_cmd(%args);
}

1;
# ABSTRACT: List contents inside a distribution

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::dist_contents - List contents inside a distribution

=head1 VERSION

This document describes version 1.023 of App::lcpan::Cmd::dist_contents (from Perl distribution App-lcpan), released on 2018-06-21.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [status, msg, result, meta]

List contents inside a distribution.

This subcommand lists files inside a distribution.

 % lcpan dist-contents Foo-Bar

is basically equivalent to:

 % lcpan contents --dist Foo-Bar

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<author> => I<str>

Filter by author.

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. /path/to/cpan.

Defaults to C<~/cpan>.

=item * B<detail> => I<bool>

=item * B<dist>* => I<perl::distname>

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

If C<index_name> is a filename without any path, e.g. C<index.db> then index will
be located in the top-level of C<cpan>. If C<index_name> contains a path, e.g.
C<./index.db> or C</home/ujang/lcpan.db> then the index will be located solely
using the C<index_name>.

=item * B<or> => I<bool>

When there are more than one query, perform OR instead of AND logic.

=item * B<package> => I<str>

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

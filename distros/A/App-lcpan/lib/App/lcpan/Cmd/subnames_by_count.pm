package App::lcpan::Cmd::subnames_by_count;

our $DATE = '2019-10-05'; # DATE
our $VERSION = '1.041'; # VERSION

use 5.010;
use strict;
use warnings;

require App::lcpan;

our %SPEC;

$SPEC{'handle_cmd'} = {
    v => 1.1,
    summary => 'List subroutine names ranked by number of occurrences',
    description => <<'_',

_
    args => {
        %App::lcpan::common_args,
        # XXX include_method
        # XXX include_static_method
        # XXX include_function
        #packages => {
        #    'x.name.is_plural' => 1,
        #    summary => 'Filter by package name(s)',
        #    schema => ['array*', of=>'str*', min_len=>1],
        #    element_completion => \&App::lcpan::_complete_mod,
        #    tags => ['category:filtering'],
        #},
        #authors => {
        #    'x.name.is_plural' => 1,
        #    summary => 'Filter by author(s) of module',
        #    schema => ['array*', of=>'str*', min_len=>1],
        #    element_completion => \&App::lcpan::_complete_cpanid,
        #    tags => ['category:filtering'],
        #},
    },
};
sub handle_cmd {
    my %args = @_;

    my $state = App::lcpan::_init(\%args, 'ro');
    my $dbh = $state->{dbh};

    my $sql = "SELECT
  name sub,
  COUNT(name) count
FROM sub
GROUP BY name
ORDER BY COUNT(name) DESC";

    my @res;
    my $sth = $dbh->prepare($sql);
    $sth->execute;
    while (my $row = $sth->fetchrow_hashref) {
        push @res, $row;
    }
    my $resmeta = {};
    $resmeta->{'table.fields'} = [qw/sub count/];

    [200, "OK", \@res, $resmeta];
}

1;
# ABSTRACT: List subroutine names ranked by number of occurrences

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::subnames_by_count - List subroutine names ranked by number of occurrences

=head1 VERSION

This document describes version 1.041 of App::lcpan::Cmd::subnames_by_count (from Perl distribution App-lcpan), released on 2019-10-05.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [status, msg, payload, meta]

List subroutine names ranked by number of occurrences.

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. /path/to/cpan.

Defaults to C<~/cpan>.

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

If C<index_name> is a filename without any path, e.g. C<index.db> then index will
be located in the top-level of C<cpan>. If C<index_name> contains a path, e.g.
C<./index.db> or C</home/ujang/lcpan.db> then the index will be located solely
using the C<index_name>.

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

This software is copyright (c) 2019, 2018, 2017, 2016, 2015 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

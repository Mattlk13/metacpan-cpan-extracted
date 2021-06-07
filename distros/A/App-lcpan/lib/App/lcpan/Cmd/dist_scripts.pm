package App::lcpan::Cmd::dist_scripts;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2021-06-05'; # DATE
our $DIST = 'App-lcpan'; # DIST
our $VERSION = '1.068'; # VERSION

use 5.010;
use strict;
use warnings;

require App::lcpan;

our %SPEC;

$SPEC{'handle_cmd'} = {
    v => 1.1,
    summary => 'List scripts in a distribution',
    args => {
        %App::lcpan::common_args,
        %App::lcpan::dists_args,
        %App::lcpan::detail_args,
    },
};
sub handle_cmd {
    my %args = @_;

    my $state = App::lcpan::_init(\%args, 'ro');
    my $dbh = $state->{dbh};

    my @wheres;
    push @wheres, "file.dist_name IN (".join(",", map {$dbh->quote($_)} @{ $args{dists} }).")";
    my $detail = $args{detail};

    my $sth = $dbh->prepare("SELECT
  script.name name,
  file.dist_name dist,
  script.abstract abstract
FROM script
LEFT JOIN file ON script.file_id=file.id
WHERE ".join(" AND ", @wheres)."
ORDER BY name DESC");
    $sth->execute();
    my @res;
    while (my $row = $sth->fetchrow_hashref) {
        delete $row->{dist} unless @{ $args{dists} } > 1;
        push @res, $detail ? $row : $row->{name};
    }
    my $resmeta = {};
    $resmeta->{'table.fields'} = [qw/name dist abstract/]
        if $detail;
    [200, "OK", \@res, $resmeta];
}

1;
# ABSTRACT: List scripts in a distribution

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::dist_scripts - List scripts in a distribution

=head1 VERSION

This document describes version 1.068 of App::lcpan::Cmd::dist_scripts (from Perl distribution App-lcpan), released on 2021-06-05.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [$status_code, $reason, $payload, \%result_meta]

List scripts in a distribution.

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. E<sol>pathE<sol>toE<sol>cpan.

Defaults to C<~/cpan>.

=item * B<detail> => I<bool>

=item * B<dists>* => I<array[perl::distname]>

Distribution names (e.g. Foo-Bar).

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

First element ($status_code) is an integer containing HTTP-like status code
(200 means OK, 4xx caller error, 5xx function error). Second element
($reason) is a string containing error message, or something like "OK" if status is
200. Third element ($payload) is the actual result, but usually not present when enveloped result is an error response ($status_code is not 2xx). Fourth
element (%result_meta) is called result metadata and is optional, a hash
that contains extra information, much like how HTTP response headers provide additional metadata.

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

This software is copyright (c) 2021, 2020, 2019, 2018, 2017, 2016, 2015 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

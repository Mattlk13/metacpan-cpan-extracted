package App::lcpan::Cmd::authors_by_rdep_count;

our $DATE = '2017-02-03'; # DATE
our $VERSION = '1.017'; # VERSION

use 5.010;
use strict;
use warnings;

use Function::Fallback::CoreOrPP qw(clone_list);

require App::lcpan;

our %SPEC;

$SPEC{'handle_cmd'} = {
    v => 1.1,
    summary => 'List authors ranked by number of distributions using one of his/her modules',
    args => {
        %App::lcpan::common_args,
        clone_list(%App::lcpan::deps_phase_args),
        clone_list(%App::lcpan::deps_rel_args),
        exclude_same_author => {
            schema => 'bool',
        },
    },
};
delete $SPEC{'handle_cmd'}{args}{phase}{default};
delete $SPEC{'handle_cmd'}{args}{rel}{default};
sub handle_cmd {
    my %args = @_;

    my $state = App::lcpan::_init(\%args, 'ro');
    my $dbh = $state->{dbh};

    my @where;
    my @binds;
    if ($args{phase} && $args{phase} ne 'ALL') {
        push @where, "(phase=?)";
        push @binds, $args{phase};
    }
    if ($args{rel} && $args{rel} ne 'ALL') {
        push @where, "(rel=?)";
        push @binds, $args{rel};
    }
    push @where, "d.is_latest";
    push @where, "d.cpanid <> m.cpanid" if $args{exclude_same_author};
    @where = (1) if !@where;

    my $sql = "SELECT
  m.cpanid id,
  a.fullname name,
  COUNT(DISTINCT d.id) AS rdep_count
FROM module m
JOIN dep dp ON dp.module_id=m.id
LEFT JOIN author a ON a.cpanid=m.cpanid
LEFT JOIN dist d ON d.id=dp.dist_id
WHERE ".join(" AND ", @where)."
GROUP BY m.cpanid
ORDER BY rdep_count DESC
";

    my @res;
    my $sth = $dbh->prepare($sql);
    $sth->execute(@binds);
    while (my $row = $sth->fetchrow_hashref) {
        push @res, $row;
    }
    my $resmeta = {};
    $resmeta->{'table.fields'} = [qw/id name rdep_count/];
    [200, "OK", \@res, $resmeta];
}

1;
# ABSTRACT: List authors ranked by number of distributions using one of his/her modules

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::authors_by_rdep_count - List authors ranked by number of distributions using one of his/her modules

=head1 VERSION

This document describes version 1.017 of App::lcpan::Cmd::authors_by_rdep_count (from Perl distribution App-lcpan), released on 2017-02-03.

=head1 FUNCTIONS


=head2 handle_cmd(%args) -> [status, msg, result, meta]

List authors ranked by number of distributions using one of his/her modules.

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. /path/to/cpan.

Defaults to C<~/cpan>.

=item * B<exclude_same_author> => I<bool>

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

=item * B<phase> => I<str>

=item * B<rel> => I<str>

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

This software is copyright (c) 2015-2017 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

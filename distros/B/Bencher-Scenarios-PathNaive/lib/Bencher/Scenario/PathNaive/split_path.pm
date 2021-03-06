package Bencher::Scenario::PathNaive::split_path;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2020-02-12'; # DATE
our $DIST = 'Bencher-Scenarios-PathNaive'; # DIST
our $VERSION = '0.002'; # VERSION

our $scenario = {
    summary => 'Benchmark split_path()',
    participants => [
        {
            fcall_template => 'Path::Naive::split_path(<string>)',
            result_is_list => 1,
        },
        {
            name => 'split with /',
            code_template => 'split "/", <string>',
            result_is_list => 1,
        },
    ],
    datasets => [
        {args=>{string=>'/'}},
        {args=>{string=>'/a/b/c/d/e'}},
        {args=>{string=>'/a/b/////c/d/e'}},
    ],
};

1;
# ABSTRACT: Benchmark split_path()

__END__

=pod

=encoding UTF-8

=head1 NAME

Bencher::Scenario::PathNaive::split_path - Benchmark split_path()

=head1 VERSION

This document describes version 0.002 of Bencher::Scenario::PathNaive::split_path (from Perl distribution Bencher-Scenarios-PathNaive), released on 2020-02-12.

=head1 SYNOPSIS

To run benchmark with default option:

 % bencher -m PathNaive::split_path

To run module startup overhead benchmark:

 % bencher --module-startup -m PathNaive::split_path

For more options (dump scenario, list/include/exclude/add participants, list/include/exclude/add datasets, etc), see L<bencher> or run C<bencher --help>.

=head1 DESCRIPTION

Packaging a benchmark script as a Bencher scenario makes it convenient to include/exclude/add participants/datasets (either via CLI or Perl code), send the result to a central repository, among others . See L<Bencher> and L<bencher> (CLI) for more details.

=head1 BENCHMARKED MODULES

Version numbers shown below are the versions used when running the sample benchmark.

L<Path::Naive> 0.043

=head1 BENCHMARK PARTICIPANTS

=over

=item * Path::Naive::split_path (perl_code)

Function call template:

 Path::Naive::split_path(<string>)



=item * split with / (perl_code)

Code template:

 split "/", <string>



=back

=head1 BENCHMARK DATASETS

=over

=item * /

=item * /a/b/c/d/e

=item * /a/b/////c/d/e

=back

=head1 SAMPLE BENCHMARK RESULTS

Run on: perl: I<< v5.30.0 >>, CPU: I<< Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz (2 cores) >>, OS: I<< GNU/Linux Ubuntu version 19.04 >>, OS kernel: I<< Linux version 5.0.0-37-generic >>.

Benchmark with default options (C<< bencher -m PathNaive::split_path >>):

 #table1#
 +-------------------------+----------------+-----------+-----------+-----------------------+-----------------------+---------+---------+
 | participant             | dataset        | rate (/s) | time (μs) | pct_faster_vs_slowest | pct_slower_vs_fastest |  errors | samples |
 +-------------------------+----------------+-----------+-----------+-----------------------+-----------------------+---------+---------+
 | Path::Naive::split_path | /a/b/////c/d/e |    510000 |    1.96   |                 0.00% |              1697.07% | 6.9e-10 |      29 |
 | Path::Naive::split_path | /a/b/c/d/e     |    514000 |    1.95   |                 0.70% |              1684.65% | 7.8e-10 |      23 |
 | Path::Naive::split_path | /              |   1318000 |    0.759  |               158.33% |               595.64% | 2.3e-11 |      23 |
 | split with /            | /a/b/////c/d/e |   1321000 |    0.7572 |               158.95% |               593.97% | 2.3e-11 |      20 |
 | split with /            | /a/b/c/d/e     |   2100000 |    0.47   |               319.68% |               328.20% | 6.2e-10 |      20 |
 | split with /            | /              |   9165000 |    0.1091 |              1697.07% |                 0.00% | 5.8e-12 |      30 |
 +-------------------------+----------------+-----------+-----------+-----------------------+-----------------------+---------+---------+


Benchmark module startup overhead (C<< bencher -m PathNaive::split_path --module-startup >>):

 #table2#
 +---------------------+-----------+-------------------+-----------------------+-----------------------+----------+---------+
 | participant         | time (ms) | mod_overhead_time | pct_faster_vs_slowest | pct_slower_vs_fastest |  errors  | samples |
 +---------------------+-----------+-------------------+-----------------------+-----------------------+----------+---------+
 | Path::Naive         |        10 |                 3 |                 0.00% |                45.26% |   0.0001 |      20 |
 | perl -e1 (baseline) |         7 |                 0 |                45.26% |                 0.00% | 3.1e-05  |      20 |
 +---------------------+-----------+-------------------+-----------------------+-----------------------+----------+---------+


To display as an interactive HTML table on a browser, you can add option C<--format html+datatables>.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Bencher-Scenarios-PathNaive>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Bencher-Scenarios-PathNaive>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Bencher-Scenarios-PathNaive>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

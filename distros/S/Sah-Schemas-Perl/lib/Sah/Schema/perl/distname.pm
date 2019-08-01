package Sah::Schema::perl::distname;

our $DATE = '2019-07-26'; # DATE
our $VERSION = '0.023'; # VERSION

our $schema = [str => {
    summary => 'Perl distribution name',
    match => '\A[A-Za-z_][A-Za-z_0-9]*(-[A-Za-z_0-9]+)*\z',
    'x.perl.coerce_rules' => [
        'str_normalize_perl_distname',
    ],

    # provide a default completion which is from list of installed perl distributions
    'x.completion' => 'perl_distname',

}, {}];

1;
# ABSTRACT: Perl distribution name

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::Schema::perl::distname - Perl distribution name

=head1 VERSION

This document describes version 0.023 of Sah::Schema::perl::distname (from Perl distribution Sah-Schemas-Perl), released on 2019-07-26.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-Perl>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-Perl>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-Perl>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2019, 2018, 2017, 2016 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

package Sah::Schema::date::month::id;

our $DATE = '2019-07-21'; # DATE
our $VERSION = '0.002'; # VERSION

our $schema = [cistr => {
    summary => 'Month number/name (abbreviated or full, in Indonesian)',
    in => [
        1..12,
        qw/jan feb mar apr mei jun jul agu sep okt nov des/,
        qw/januari februari maret april juni juli agustus september oktober november desember/,
    ],
}, {}];

1;

# ABSTRACT: Month number/name (abbreviated or full, in Indonesian)

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::Schema::date::month::id - Month number/name (abbreviated or full, in Indonesian)

=head1 VERSION

This document describes version 0.002 of Sah::Schema::date::month::id (from Perl distribution Sah-Schemas-Date-ID), released on 2019-07-21.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-Date-ID>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-Date-ID>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-Date-ID>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

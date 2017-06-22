package Sah::Schema::date::month::en;

our $DATE = '2017-06-17'; # DATE
our $VERSION = '0.001'; # VERSION

our $schema = [cistr => {
    summary => 'Month number/name (abbreviated or full, in English)',
    in => [
        1..12,
        qw/jan feb mar apr may jun jul aug sep oct nov dec/,
        qw/january february march april june july august september october november december/,
    ],
}, {}];

1;

# ABSTRACT: Month number/name (abbreviated or full, in English)

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::Schema::date::month::en - Month number/name (abbreviated or full, in English)

=head1 VERSION

This document describes version 0.001 of Sah::Schema::date::month::en (from Perl distribution Sah-Schemas-Date), released on 2017-06-17.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-Date>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-Date>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-Date>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

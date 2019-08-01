package Sah::Schema::date::month_nums;

our $DATE = '2019-06-24'; # DATE
our $VERSION = '0.004'; # VERSION

our $schema = ['array' => {
    summary => 'Array of month numbers',
    of => ['date::month_num', {}, {}],
    'x.perl.coerce_rules' => ['str_comma_sep'],
}, {}];

1;

# ABSTRACT: Array of month numbers

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::Schema::date::month_nums - Array of month numbers

=head1 VERSION

This document describes version 0.004 of Sah::Schema::date::month_nums (from Perl distribution Sah-Schemas-Date), released on 2019-06-24.

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

This software is copyright (c) 2019 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

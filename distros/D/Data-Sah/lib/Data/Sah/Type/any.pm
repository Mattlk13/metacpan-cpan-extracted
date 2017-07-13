package Data::Sah::Type::any;

our $DATE = '2017-07-10'; # DATE
our $VERSION = '0.88'; # VERSION

use Data::Sah::Util::Role 'has_clause';
use Role::Tiny;
use Role::Tiny::With;

with 'Data::Sah::Type::BaseType';

has_clause 'of',
    v => 2,
    tags       => ['constraint'],
    schema     => ['array' => {req=>1, min_len=>1, each_elem => ['sah::schema', {req=>1}, {}]}, {}],
    subschema  => sub { @{ $_[0] } },
    allow_expr => 0,
    ;

1;
# ABSTRACT: any type

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Sah::Type::any - any type

=head1 VERSION

This document describes version 0.88 of Data::Sah::Type::any (from Perl distribution Data-Sah), released on 2017-07-10.

=for Pod::Coverage ^(clause_.+|clausemeta_.+)$

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Data-Sah>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Data-Sah>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Data-Sah>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017, 2016, 2015, 2014, 2013, 2012 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

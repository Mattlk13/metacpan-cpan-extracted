package Data::Sah::Type::int;

our $DATE = '2020-02-11'; # DATE
our $VERSION = '0.906'; # VERSION

use Data::Sah::Util::Role 'has_clause';
use Role::Tiny;
use Role::Tiny::With;

with 'Data::Sah::Type::num';

has_clause 'mod',
    v => 2,
    tags       => ['constraint'],
    schema     => ['array' => {req=>1, len=>2, elems => [
        ['int' => {req=>1, is=>0, 'is.op'=>'not'}, {}],
        ['int' => {req=>1}, {}],
    ]}, {}],
    allow_expr => 1,
    ;
has_clause 'div_by',
    v => 2,
    tags       => ['constraint'],
    schema     => ['int' => {req=>1, is=>0, 'is.op'=>'not'}, {}],
    allow_expr => 1,
    ;

1;
# ABSTRACT: int type

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Sah::Type::int - int type

=head1 VERSION

This document describes version 0.906 of Data::Sah::Type::int (from Perl distribution Data-Sah), released on 2020-02-11.

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

This software is copyright (c) 2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013, 2012 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

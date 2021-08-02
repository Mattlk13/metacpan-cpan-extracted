package Data::Sah::Type::str;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2021-08-01'; # DATE
our $DIST = 'Data-Sah'; # DIST
our $VERSION = '0.910'; # VERSION

use Data::Sah::Util::Role 'has_clause';
use Role::Tiny;
use Role::Tiny::With;

with 'Data::Sah::Type::BaseType';
with 'Data::Sah::Type::Comparable';
with 'Data::Sah::Type::Sortable';
with 'Data::Sah::Type::HasElems';

# currently we only support regex instead of hash of regexes
#my $t_re = 'regex*|{*=>regex*}';
my $t_re = ['regex', {req=>1}];

has_clause 'encoding',
    v => 2,
    tags       => ['constraint'],
    schema     => ['str', {req=>1}],
    allow_expr => 0,
    ;
has_clause 'match',
    v => 2,
    tags       => ['constraint'],
    schema     => $t_re,
    allow_expr => 1,
    ;
has_clause 'is_re',
    v => 2,
    tags       => ['constraint'],
    schema     => ['bool', {}],
    allow_expr => 1,
    ;

1;
# ABSTRACT: str type

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Sah::Type::str - str type

=head1 VERSION

This document describes version 0.910 of Data::Sah::Type::str (from Perl distribution Data-Sah), released on 2021-08-01.

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

This software is copyright (c) 2021, 2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013, 2012 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

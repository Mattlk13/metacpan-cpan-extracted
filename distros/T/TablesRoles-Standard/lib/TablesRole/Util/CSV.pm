package TablesRole::Util::CSV;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2020-11-10'; # DATE
our $DIST = 'TablesRoles-Standard'; # DIST
our $VERSION = '0.006'; # VERSION

use 5.010001;
use Role::Tiny;
requires 'get_column_names';
requires 'get_row_arrayref';
requires 'reset_iterator';

sub as_csv {
    require Text::CSV_XS;
    my $self = shift;

    $self->{csv_parser} //= Text::CSV_XS->new({binary=>1});
    my $csv = $self->{csv_parser};

    $self->reset_iterator;

    my $res = "";
    $csv->combine($self->get_column_names);
    $res .= $csv->string . "\n";
    while (my $row = $self->get_row_arrayref) {
        $csv->combine(@$row);
        $res .= $csv->string . "\n";
    }
    $res;
}

1;
# ABSTRACT: Provide as_csv() and other CSV-related methods

__END__

=pod

=encoding UTF-8

=head1 NAME

TablesRole::Util::CSV - Provide as_csv() and other CSV-related methods

=head1 VERSION

This document describes version 0.006 of TablesRole::Util::CSV (from Perl distribution TablesRoles-Standard), released on 2020-11-10.

=head1 PROVIDED METHODS

=head2 as_csv

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/TablesRoles-Standard>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-TablesRoles-Standard>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=TablesRoles-Standard>

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

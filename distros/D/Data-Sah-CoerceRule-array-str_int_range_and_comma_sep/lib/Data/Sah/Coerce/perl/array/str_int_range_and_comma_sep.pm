package Data::Sah::Coerce::perl::array::str_int_range_and_comma_sep;

our $DATE = '2019-07-26'; # DATE
our $VERSION = '0.004'; # VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 4,
        might_fail => 1,
        prio => 60, # a bit lower than normal
    };
}

sub coerce {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_match} = "!ref($dt)";

    $res->{expr_coerce} = join(
        "",
        "do { ",
        "my \$res; my \$ary = []; ",
        "for my \$elem (split /\\s*,\\s*/, $dt) { ",
        "  my (\$int1, \$int2) = \$elem =~ /\\A\\s*([+-]?\\d+)(?:\\s*(?:-|\\.\\.)\\s*([+-]?\\d+))?\\s*\\z/; ",
        "  if (!defined \$int1) { \$res = [\"Invalid elem '\$elem': must be INT or INT1-INT2\"]; last } ",
        "  if (defined \$int2) { ",
        "    if (\$int2 - \$int1 > 1_000_000) { \$res = [\"Elem '\$elem': Range too big\"]; last } ",
        "    push \@\$ary, \$int1+0 .. \$int2+0; ",
        "  } else { push \@\$ary, \$int1 } ",
        "}", # for
        "\$res ||= [undef, \$ary]; ",
        "\$res }",
    );

    $res;
}

1;
# ABSTRACT: Coerce array of ints from comma-separated ints/int ranges

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Sah::Coerce::perl::array::str_int_range_and_comma_sep - Coerce array of ints from comma-separated ints/int ranges

=head1 VERSION

This document describes version 0.004 of Data::Sah::Coerce::perl::array::str_int_range_and_comma_sep (from Perl distribution Data-Sah-CoerceRule-array-str_int_range_and_comma_sep), released on 2019-07-26.

=head1 DESCRIPTION

The rule is not enabled by default. You can enable it in a schema using e.g.:

 ["array*", of=>"int", "x.coerce_rules"=>["str_int_range_and_comma_sep"]]

=for Pod::Coverage ^(meta|coerce)$

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Data-Sah-CoerceRule-array-str_int_range_and_comma_sep>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Data-Sah-CoerceRule-array-str_int_range_and_comma_sep>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Data-Sah-CoerceRule-array-str_int_range_and_comma_sep>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2019, 2018 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

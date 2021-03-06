package Data::Sah::Coerce::perl::num::str_num_id;

our $DATE = '2019-07-26'; # DATE
our $VERSION = '0.003'; # VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 4,
        might_fail => 1,
        prio => 50,
        precludes => [qr/\Astr_num_(\w+)\z/],
    };
}

sub coerce {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_match} = "!ref($dt)";
    $res->{modules}{"Parse::Number::ID"} //= 0;
    $res->{expr_coerce} = join(
        "",
        "do { ",
        "  my \$text = $dt; my \$res = Parse::Number::ID::parse_number_id(text=>$dt); ",
        "  if (!defined \$res) { [qq(Invalid number: \$text)] } ",
        "  else { [undef, \$res] } ",
        "}",
    );

    $res;
}

1;
# ABSTRACT: Parse number using Parse::Number::ID

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Sah::Coerce::perl::num::str_num_id - Parse number using Parse::Number::ID

=head1 VERSION

This document describes version 0.003 of Data::Sah::Coerce::perl::num::str_num_id (from Perl distribution Data-Sah-CoerceBundle-Num-str_num_id), released on 2019-07-26.

=head1 DESCRIPTION

The rule is not enabled by default. You can enable it in a schema using e.g.:

 ["num", "x.perl.coerce_rules"=>["str_num_id"]]

=for Pod::Coverage ^(meta|coerce)$

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Data-Sah-CoerceBundle-Num-str_num_id>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Data-Sah-CoerceBundle-Num-str_num_id>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Data-Sah-CoerceBundle-Num-str_num_id>

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

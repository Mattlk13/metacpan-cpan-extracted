package Data::Sah::Compiler::perl::TH::re;

our $DATE = '2020-05-21'; # DATE
our $VERSION = '0.908'; # VERSION

use 5.010;
use strict;
use warnings;
#use Log::Any '$log';

use Mo qw(build default);
use Role::Tiny::With;

extends 'Data::Sah::Compiler::perl::TH';
with 'Data::Sah::Type::re';

# XXX prefilter to convert string to regex object

sub handle_type {
    my ($self, $cd) = @_;
    my $c = $self->compiler;

    my $dt = $cd->{data_term};
    $cd->{_ccl_check_type} = "ref($dt) eq 'Regexp' || !ref($dt) && ".
        "eval { my \$_sahv_re = $dt; qr/\$_sahv_re/; 1 }";
}

1;
# ABSTRACT: perl's type handler for type "re"

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Sah::Compiler::perl::TH::re - perl's type handler for type "re"

=head1 VERSION

This document describes version 0.908 of Data::Sah::Compiler::perl::TH::re (from Perl distribution Data-Sah), released on 2020-05-21.

=for Pod::Coverage ^(clause_.+|superclause_.+)$

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

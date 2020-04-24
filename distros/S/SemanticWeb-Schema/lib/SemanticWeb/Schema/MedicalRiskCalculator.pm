use utf8;

package SemanticWeb::Schema::MedicalRiskCalculator;

# ABSTRACT: A complex mathematical calculation requiring an online calculator

use Moo;

extends qw/ SemanticWeb::Schema::MedicalRiskEstimator /;


use MooX::JSON_LD 'MedicalRiskCalculator';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v7.0.4';




1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::MedicalRiskCalculator - A complex mathematical calculation requiring an online calculator

=head1 VERSION

version v7.0.4

=head1 DESCRIPTION

A complex mathematical calculation requiring an online calculator, used to
assess prognosis. Note: use the url property of Thing to record any URLs
for online calculators.

=head1 SEE ALSO

L<SemanticWeb::Schema::MedicalRiskEstimator>

=head1 SOURCE

The development version is on github at L<https://github.com/robrwo/SemanticWeb-Schema>
and may be cloned from L<git://github.com/robrwo/SemanticWeb-Schema.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/robrwo/SemanticWeb-Schema/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018-2020 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

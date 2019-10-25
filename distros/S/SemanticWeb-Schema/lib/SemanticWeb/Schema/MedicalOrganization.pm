use utf8;

package SemanticWeb::Schema::MedicalOrganization;

# ABSTRACT: A medical organization (physical or not)

use Moo;

extends qw/ SemanticWeb::Schema::Organization /;


use MooX::JSON_LD 'MedicalOrganization';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v4.0.1';


has health_plan_network_id => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'healthPlanNetworkId',
);



has is_accepting_new_patients => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'isAcceptingNewPatients',
);



has medical_specialty => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'medicalSpecialty',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::MedicalOrganization - A medical organization (physical or not)

=head1 VERSION

version v4.0.1

=head1 DESCRIPTION

A medical organization (physical or not), such as hospital, institution or
clinic.

=head1 ATTRIBUTES

=head2 C<health_plan_network_id>

C<healthPlanNetworkId>

Name or unique ID of network. (Networks are often reused across different
insurance plans).

A health_plan_network_id should be one of the following types:

=over

=item C<Str>

=back

=head2 C<is_accepting_new_patients>

C<isAcceptingNewPatients>

Whether the provider is accepting new patients.

A is_accepting_new_patients should be one of the following types:

=over

=item C<Bool>

=back

=head2 C<medical_specialty>

C<medicalSpecialty>

A medical specialty of the provider.

A medical_specialty should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::MedicalSpecialty']>

=back

=head1 SEE ALSO

L<SemanticWeb::Schema::Organization>

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

This software is Copyright (c) 2018-2019 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

package SemanticWeb::Schema::DeliveryChargeSpecification;

# ABSTRACT: The price for the delivery of an offer using a particular delivery method.

use Moo;

extends qw/ SemanticWeb::Schema::PriceSpecification /;


use MooX::JSON_LD 'DeliveryChargeSpecification';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v0.0.1';


has applies_to_delivery_method => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'appliesToDeliveryMethod',
);



has area_served => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'areaServed',
);



has eligible_region => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'eligibleRegion',
);



has ineligible_region => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'ineligibleRegion',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::DeliveryChargeSpecification - The price for the delivery of an offer using a particular delivery method.

=head1 VERSION

version v0.0.1

=head1 DESCRIPTION

The price for the delivery of an offer using a particular delivery method.

=head1 ATTRIBUTES

=head2 C<applies_to_delivery_method>

C<appliesToDeliveryMethod>

The delivery method(s) to which the delivery charge or payment charge
specification applies.

A applies_to_delivery_method should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::DeliveryMethod']>

=back

=head2 C<area_served>

C<areaServed>

The geographic area where a service or offered item is provided.

A area_served should be one of the following types:

=over

=item C<Str>

=item C<InstanceOf['SemanticWeb::Schema::GeoShape']>

=item C<InstanceOf['SemanticWeb::Schema::AdministrativeArea']>

=item C<InstanceOf['SemanticWeb::Schema::Place']>

=back

=head2 C<eligible_region>

C<eligibleRegion>

=for html The ISO 3166-1 (ISO 3166-1 alpha-2) or ISO 3166-2 code, the place, or the
GeoShape for the geo-political region(s) for which the offer or delivery
charge specification is valid.</p> <p>See also <a class="localLink"
href="http://schema.org/ineligibleRegion">ineligibleRegion</a>.

A eligible_region should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::GeoShape']>

=item C<Str>

=item C<InstanceOf['SemanticWeb::Schema::Place']>

=back

=head2 C<ineligible_region>

C<ineligibleRegion>

=for html The ISO 3166-1 (ISO 3166-1 alpha-2) or ISO 3166-2 code, the place, or the
GeoShape for the geo-political region(s) for which the offer or delivery
charge specification is not valid, e.g. a region where the transaction is
not allowed.</p> <p>See also <a class="localLink"
href="http://schema.org/eligibleRegion">eligibleRegion</a>.

A ineligible_region should be one of the following types:

=over

=item C<Str>

=item C<InstanceOf['SemanticWeb::Schema::Place']>

=item C<InstanceOf['SemanticWeb::Schema::GeoShape']>

=back

=head1 SEE ALSO

L<SemanticWeb::Schema::PriceSpecification>

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut


package Shipment::UPS::WSDL::RateElements::RateResponse;
$Shipment::UPS::WSDL::RateElements::RateResponse::VERSION = '3.10';
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Rate/v1.1' }

__PACKAGE__->__set_name('RateResponse');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Response_of :ATTR(:get<Response>);
my %RatedShipment_of :ATTR(:get<RatedShipment>);

__PACKAGE__->_factory(
    [ qw(        Response
        RatedShipment

    ) ],
    {
        'Response' => \%Response_of,
        'RatedShipment' => \%RatedShipment_of,
    },
    {
        'Response' => 'Shipment::UPS::WSDL::RateElements::Response',

        'RatedShipment' => 'Shipment::UPS::WSDL::RateTypes::RatedShipmentType',
    },
    {

        'Response' => '',
        'RatedShipment' => 'RatedShipment',
    }
);

} # end BLOCK






} # end of BLOCK



1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Shipment::UPS::WSDL::RateElements::RateResponse

=head1 VERSION

version 3.10

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
RateResponse from the namespace http://www.ups.com/XMLSchema/XOLTWS/Rate/v1.1.

=head1 NAME

Shipment::UPS::WSDL::RateElements::RateResponse

=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Response

 $element->set_Response($data);
 $element->get_Response();

Note: The name of this property has been altered, because it didn't match
perl's notion of variable/subroutine names. The altered name is used in
perl code only, XML output uses the original name:

=item * RatedShipment

 $element->set_RatedShipment($data);
 $element->get_RatedShipment();

=back

=head1 METHODS

=head2 new

 my $element = Shipment::UPS::WSDL::RateElements::RateResponse->new($data);

Constructor. The following data structure may be passed to new():

 {
   Response =>  { # Shipment::UPS::WSDL::RateTypes::ResponseType
     ResponseStatus =>  { # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Alert => {}, # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
     TransactionReference =>  { # Shipment::UPS::WSDL::RateTypes::TransactionReferenceType
       CustomerContext =>  $some_value, # string
       TransactionIdentifier =>  $some_value, # string
     },
   },
   RatedShipment =>  { # Shipment::UPS::WSDL::RateTypes::RatedShipmentType
     Service =>  { # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     RatedShipmentAlert =>  { # Shipment::UPS::WSDL::RateTypes::RatedShipmentInfoType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     BillingWeight =>  { # Shipment::UPS::WSDL::RateTypes::BillingWeightType
       UnitOfMeasurement => {}, # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
       Weight =>  $some_value, # string
     },
     TransportationCharges =>  { # Shipment::UPS::WSDL::RateTypes::ChargesType
       CurrencyCode =>  $some_value, # string
       MonetaryValue =>  $some_value, # string
     },
     FRSShipmentData =>  { # Shipment::UPS::WSDL::RateTypes::FRSShipmentType
       TransportationCharges =>  { # Shipment::UPS::WSDL::RateTypes::TransportationChargesType
         GrossCharge => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
         DiscountAmount => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
         DiscountPercentage =>  $some_value, # string
         NetCharge => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
       },
     },
     ServiceOptionsCharges => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
     TotalCharges => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
     NegotiatedRateCharges =>  { # Shipment::UPS::WSDL::RateTypes::TotalChargeType
       TotalCharge => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
     },
     GuaranteedDelivery =>  { # Shipment::UPS::WSDL::RateTypes::GuaranteedDeliveryType
       BusinessDaysInTransit =>  $some_value, # string
       DeliveryByTime =>  $some_value, # string
     },
     RatedPackage =>  { # Shipment::UPS::WSDL::RateTypes::RatedPackageType
       TransportationCharges => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
       ServiceOptionsCharges => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
       TotalCharges => {}, # Shipment::UPS::WSDL::RateTypes::ChargesType
       Weight =>  $some_value, # string
       BillingWeight => {}, # Shipment::UPS::WSDL::RateTypes::BillingWeightType
     },
   },
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=head1 AUTHOR

Andrew Baerg <baergaj@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Andrew Baerg.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

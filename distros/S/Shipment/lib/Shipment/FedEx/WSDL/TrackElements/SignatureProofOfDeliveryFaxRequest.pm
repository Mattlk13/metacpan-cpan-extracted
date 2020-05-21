
package Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryFaxRequest;
$Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryFaxRequest::VERSION = '3.04';
use strict;
use warnings;

{    # BLOCK to scope variables

    sub get_xmlns {'http://fedex.com/ws/track/v9'}

    __PACKAGE__->__set_name('SignatureProofOfDeliveryFaxRequest');
    __PACKAGE__->__set_nillable();
    __PACKAGE__->__set_minOccurs();
    __PACKAGE__->__set_maxOccurs();
    __PACKAGE__->__set_ref();
    use base qw(
      SOAP::WSDL::XSD::Typelib::Element
      Shipment::FedEx::WSDL::TrackTypes::SignatureProofOfDeliveryFaxRequest
    );

}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryFaxRequest

=head1 VERSION

version 3.04

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
SignatureProofOfDeliveryFaxRequest from the namespace http://fedex.com/ws/track/v9.

=head1 NAME

Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryFaxRequest

=head1 METHODS

=head2 new

 my $element = Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryFaxRequest->new($data);

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::TrackTypes::SignatureProofOfDeliveryFaxRequest
   WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail
     UserCredential =>  { # Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationCredential
       Key =>  $some_value, # string
       Password =>  $some_value, # string
     },
   },
   ClientDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::ClientDetail
     AccountNumber =>  $some_value, # string
     MeterNumber =>  $some_value, # string
     IntegratorId =>  $some_value, # string
     Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
       LanguageCode =>  $some_value, # string
       LocaleCode =>  $some_value, # string
     },
   },
   TransactionDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::TransactionDetail
     CustomerTransactionId =>  $some_value, # string
     Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
       LanguageCode =>  $some_value, # string
       LocaleCode =>  $some_value, # string
     },
   },
   Version =>  { # Shipment::FedEx::WSDL::TrackTypes::VersionId
     ServiceId =>  $some_value, # string
     Major =>  $some_value, # int
     Intermediate =>  $some_value, # int
     Minor =>  $some_value, # int
   },
   QualifiedTrackingNumber =>  { # Shipment::FedEx::WSDL::TrackTypes::QualifiedTrackingNumber
     TrackingNumber =>  $some_value, # string
     ShipDate =>  $some_value, # date
     AccountNumber =>  $some_value, # string
     Carrier => $some_value, # CarrierCodeType
     Destination =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       CountryName =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
   },
   AdditionalComments =>  $some_value, # string
   FaxSender =>  { # Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress
     Contact =>  { # Shipment::FedEx::WSDL::TrackTypes::Contact
       PersonName =>  $some_value, # string
       Title =>  $some_value, # string
       CompanyName =>  $some_value, # string
       PhoneNumber =>  $some_value, # string
       PhoneExtension =>  $some_value, # string
       TollFreePhoneNumber =>  $some_value, # string
       PagerNumber =>  $some_value, # string
       FaxNumber =>  $some_value, # string
       EMailAddress =>  $some_value, # string
     },
     Address =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       CountryName =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
   },
   FaxRecipient =>  { # Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress
     Contact =>  { # Shipment::FedEx::WSDL::TrackTypes::Contact
       PersonName =>  $some_value, # string
       Title =>  $some_value, # string
       CompanyName =>  $some_value, # string
       PhoneNumber =>  $some_value, # string
       PhoneExtension =>  $some_value, # string
       TollFreePhoneNumber =>  $some_value, # string
       PagerNumber =>  $some_value, # string
       FaxNumber =>  $some_value, # string
       EMailAddress =>  $some_value, # string
     },
     Address =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       CountryName =>  $some_value, # string
       Residential =>  $some_value, # boolean
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

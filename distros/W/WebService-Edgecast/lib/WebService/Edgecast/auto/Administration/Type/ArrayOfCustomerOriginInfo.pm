package WebService::Edgecast::auto::Administration::Type::ArrayOfCustomerOriginInfo;
BEGIN {
  $WebService::Edgecast::auto::Administration::Type::ArrayOfCustomerOriginInfo::VERSION = '0.01.00';
}
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'EC:WebServices' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %CustomerOriginInfo_of :ATTR(:get<CustomerOriginInfo>);

__PACKAGE__->_factory(
    [ qw(        CustomerOriginInfo

    ) ],
    {
        'CustomerOriginInfo' => \%CustomerOriginInfo_of,
    },
    {
        'CustomerOriginInfo' => 'WebService::Edgecast::auto::Administration::Type::CustomerOriginInfo',
    },
    {

        'CustomerOriginInfo' => 'CustomerOriginInfo',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

WebService::Edgecast::auto::Administration::Type::ArrayOfCustomerOriginInfo

=head1 VERSION

version 0.01.00

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ArrayOfCustomerOriginInfo from the namespace EC:WebServices.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * CustomerOriginInfo




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # WebService::Edgecast::auto::Administration::Type::ArrayOfCustomerOriginInfo
   CustomerOriginInfo =>  { # WebService::Edgecast::auto::Administration::Type::CustomerOriginInfo
     Id =>  $some_value, # int
     MediaTypeId =>  $some_value, # int
     DirectoryName =>  $some_value, # string
     HostHeader =>  $some_value, # string
     UseOriginShield =>  $some_value, # boolean
     HttpFullUrl =>  $some_value, # string
     HttpsFullUrl =>  $some_value, # string
     HttpLoadBalancing =>  $some_value, # string
     HttpsLoadBalancing =>  $some_value, # string
     HttpHostnames =>  { # WebService::Edgecast::auto::Administration::Type::ArrayOfHostname
       Hostname =>  { # WebService::Edgecast::auto::Administration::Type::Hostname
         Name =>  $some_value, # string
         IsPrimary =>  $some_value, # boolean
         Ordinal =>  $some_value, # int
       },
     },
     HttpsHostnames =>  { # WebService::Edgecast::auto::Administration::Type::ArrayOfHostname
       Hostname =>  { # WebService::Edgecast::auto::Administration::Type::Hostname
         Name =>  $some_value, # string
         IsPrimary =>  $some_value, # boolean
         Ordinal =>  $some_value, # int
       },
     },
     ShieldPOPs =>  { # WebService::Edgecast::auto::Administration::Type::ArrayOfShieldPOP
       ShieldPOP =>  { # WebService::Edgecast::auto::Administration::Type::ShieldPOP
         Name =>  $some_value, # string
         POPCode =>  $some_value, # string
         Region =>  $some_value, # string
       },
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut
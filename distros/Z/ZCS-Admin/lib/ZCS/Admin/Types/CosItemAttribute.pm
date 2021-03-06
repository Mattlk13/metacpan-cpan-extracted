package ZCS::Admin::Types::CosItemAttribute;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'urn:zimbraAdmin' };

our $XML_ATTRIBUTE_CLASS = 'ZCS::Admin::Types::CosItemAttribute::_CosItemAttribute::XmlAttr';

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use base qw(
    SOAP::WSDL::XSD::Typelib::ComplexType
    SOAP::WSDL::XSD::Typelib::Builtin::string
);

package ZCS::Admin::Types::CosItemAttribute::_CosItemAttribute::XmlAttr;
use base qw(SOAP::WSDL::XSD::Typelib::AttributeSet);

{ # BLOCK to scope variables

my %n_of :ATTR(:get<n>);
my %c_of :ATTR(:get<c>);

__PACKAGE__->_factory(
    [ qw(
        n
        c
    ) ],
    {

        n => \%n_of,

        c => \%c_of,
    },
    {
        n => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        c => 'ZCS::Admin::Types::IntBool',
    }
);

} # end BLOCK



1;


=pod

=head1 NAME

ZCS::Admin::Types::CosItemAttribute

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CosItemAttribute from the namespace urn:zimbraAdmin.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over



=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { value => $some_value },



=head2 attr

NOTE: Attribute documentation is experimental, and may be inaccurate.
See the correspondent WSDL/XML Schema if in question.

This class has additional attributes, accessibly via the C<attr()> method.

attr() returns an object of the class ZCS::Admin::Types::CosItemAttribute::_CosItemAttribute::XmlAttr.

The following attributes can be accessed on this object via the corresponding
get_/set_ methods:

=over

=item * n



This attribute is of type L<SOAP::WSDL::XSD::Typelib::Builtin::string|SOAP::WSDL::XSD::Typelib::Builtin::string>.

=item * c



This attribute is of type L<ZCS::Admin::Types::IntBool|ZCS::Admin::Types::IntBool>.


=back




=head1 AUTHOR

Generated by SOAP::WSDL

=cut


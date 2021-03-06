##----------------------------------------------------------------------------
## Stripe API - ~/lib/Net/API/Stripe/Tax/Rate.pm
## Version v0.100.0
## Copyright(c) 2019 DEGUEST Pte. Ltd.
## Author: Jacques Deguest <@sitael.tokyo.deguest.jp>
## Created 2019/11/02
## Modified 2020/05/15
## 
##----------------------------------------------------------------------------
package Net::API::Stripe::Tax::Rate;
BEGIN
{
	use strict;
	use parent qw( Net::API::Stripe::Generic );
	our( $VERSION ) = 'v0.100.0';
};

sub id { shift->_set_get_scalar( 'id', @_ ); }

sub object { shift->_set_get_scalar( 'object', @_ ); }

sub active { shift->_set_get_boolean( 'active', @_ ); }

sub created { shift->_set_get_datetime( 'created', @_ ); }

sub description { shift->_set_get_scalar( 'description', @_ ); }

sub display_name { shift->_set_get_scalar( 'display_name', @_ ); }

sub inclusive { shift->_set_get_boolean( 'inclusive', @_ ); }

sub jurisdiction { shift->_set_get_scalar( 'jurisdiction', @_ ); }

sub livemode { shift->_set_get_boolean( 'livemode', @_ ); }

sub metadata { shift->_set_get_hash( 'metadata', @_ ); }

sub percentage { return( shift->_set_get_number( 'percentage', @_ ) ); }

1;

__END__

=encoding utf8

=head1 NAME

Net::API::Stripe::Tax::Rate - A Stripe Tax Rate Object

=head1 SYNOPSIS

    my $rate = $stripe->tax_rate({
        active => $stripe->true,
        created => '2020-04-12T17:12:10',
        description => 'Japan VAT applicable to customers',
        display_name => 'Japan VAT',
        inclusive => $stripe->false,
        jurisdiction => 'jp',
        livemode => $stripe->false,
        metadata => { tax_id => 123, customer_id => 456 },
        percentage => 10,
    });

See documentation in L<Net::API::Stripe> for example to make api calls to Stripe to create those objects.

=head1 VERSION

    v0.100.0

=head1 DESCRIPTION

This is used in L<Net::API::Stripe::Billing::Invoice> to describe a list of tax rates, and also in L<Net::API::Stripe::Billing::Subscription::Schedule> in B<phases>->I<default_tax_rates>.

=head1 CONSTRUCTOR

=over 4

=item B<new>( %ARG )

Creates a new L<Net::API::Stripe::Tax::Rate> object.
It may also take an hash like arguments, that also are method of the same name.

=back

=head1 METHODS

=over 4

=item B<id> string

Unique identifier for the object.

=item B<object> string, value is "tax_rate"

String representing the object’s type. Objects of the same type share the same value.

=item B<active> boolean

Defaults to true. When set to false, this tax rate cannot be applied to objects in the API, but will still be applied to subscriptions and invoices that already have it set.

=item B<created> timestamp

Time at which the object was created. Measured in seconds since the Unix epoch.

=item B<description> string

An arbitrary string attached to the tax rate for your internal use only. It will not be visible to your customers.

=item B<display_name> string

The display name of the tax rates as it will appear to your customer on their receipt email, PDF, and the hosted invoice page.

=item B<inclusive> boolean

This specifies if the tax rate is inclusive or exclusive.

=item B<jurisdiction> string

The jurisdiction for the tax rate.

=item B<livemode> boolean

Has the value true if the object exists in live mode or the value false if the object exists in test mode.

=item B<metadata> hash

Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.

=item B<percentage> decimal

This represents the tax rate percent out of 100.

=back

=head1 API SAMPLE

	{
	  "id": "txr_1GWkAHCeyNCl6fY2QtB0BbzC",
	  "object": "tax_rate",
	  "active": true,
	  "created": 1586614713,
	  "description": "VAT Germany",
	  "display_name": "VAT",
	  "inclusive": false,
	  "jurisdiction": "DE",
	  "livemode": false,
	  "metadata": {},
	  "percentage": 19.0
	}

=head1 HISTORY

=head2 v0.1

Initial version

=head1 AUTHOR

Jacques Deguest E<lt>F<jack@deguest.jp>E<gt>

=head1 SEE ALSO

Stripe API documentation:

L<https://stripe.com/docs/api/tax_rates>

=head1 COPYRIGHT & LICENSE

Copyright (c) 2019-2020 DEGUEST Pte. Ltd.

You can use, copy, modify and redistribute this package and associated
files under the same terms as Perl itself.

=cut

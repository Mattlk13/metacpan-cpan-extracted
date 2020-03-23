use utf8;

package SemanticWeb::Schema::Invoice;

# ABSTRACT: A statement of the money due for goods or services; a bill.

use Moo;

extends qw/ SemanticWeb::Schema::Intangible /;


use MooX::JSON_LD 'Invoice';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v7.0.0';


has account_id => (
    is        => 'rw',
    predicate => '_has_account_id',
    json_ld   => 'accountId',
);



has billing_period => (
    is        => 'rw',
    predicate => '_has_billing_period',
    json_ld   => 'billingPeriod',
);



has broker => (
    is        => 'rw',
    predicate => '_has_broker',
    json_ld   => 'broker',
);



has category => (
    is        => 'rw',
    predicate => '_has_category',
    json_ld   => 'category',
);



has confirmation_number => (
    is        => 'rw',
    predicate => '_has_confirmation_number',
    json_ld   => 'confirmationNumber',
);



has customer => (
    is        => 'rw',
    predicate => '_has_customer',
    json_ld   => 'customer',
);



has minimum_payment_due => (
    is        => 'rw',
    predicate => '_has_minimum_payment_due',
    json_ld   => 'minimumPaymentDue',
);



has payment_due => (
    is        => 'rw',
    predicate => '_has_payment_due',
    json_ld   => 'paymentDue',
);



has payment_due_date => (
    is        => 'rw',
    predicate => '_has_payment_due_date',
    json_ld   => 'paymentDueDate',
);



has payment_method => (
    is        => 'rw',
    predicate => '_has_payment_method',
    json_ld   => 'paymentMethod',
);



has payment_method_id => (
    is        => 'rw',
    predicate => '_has_payment_method_id',
    json_ld   => 'paymentMethodId',
);



has payment_status => (
    is        => 'rw',
    predicate => '_has_payment_status',
    json_ld   => 'paymentStatus',
);



has provider => (
    is        => 'rw',
    predicate => '_has_provider',
    json_ld   => 'provider',
);



has references_order => (
    is        => 'rw',
    predicate => '_has_references_order',
    json_ld   => 'referencesOrder',
);



has scheduled_payment_date => (
    is        => 'rw',
    predicate => '_has_scheduled_payment_date',
    json_ld   => 'scheduledPaymentDate',
);



has total_payment_due => (
    is        => 'rw',
    predicate => '_has_total_payment_due',
    json_ld   => 'totalPaymentDue',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::Invoice - A statement of the money due for goods or services; a bill.

=head1 VERSION

version v7.0.0

=head1 DESCRIPTION

A statement of the money due for goods or services; a bill.

=head1 ATTRIBUTES

=head2 C<account_id>

C<accountId>

The identifier for the account the payment will be applied to.

A account_id should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_account_id>

A predicate for the L</account_id> attribute.

=head2 C<billing_period>

C<billingPeriod>

The time interval used to compute the invoice.

A billing_period should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Duration']>

=back

=head2 C<_has_billing_period>

A predicate for the L</billing_period> attribute.

=head2 C<broker>

An entity that arranges for an exchange between a buyer and a seller. In
most cases a broker never acquires or releases ownership of a product or
service involved in an exchange. If it is not clear whether an entity is a
broker, seller, or buyer, the latter two terms are preferred.

A broker should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Organization']>

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=back

=head2 C<_has_broker>

A predicate for the L</broker> attribute.

=head2 C<category>

A category for the item. Greater signs or slashes can be used to informally
indicate a category hierarchy.

A category should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::PhysicalActivityCategory']>

=item C<InstanceOf['SemanticWeb::Schema::Thing']>

=item C<Str>

=back

=head2 C<_has_category>

A predicate for the L</category> attribute.

=head2 C<confirmation_number>

C<confirmationNumber>

A number that confirms the given order or payment has been received.

A confirmation_number should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_confirmation_number>

A predicate for the L</confirmation_number> attribute.

=head2 C<customer>

Party placing the order or paying the invoice.

A customer should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Organization']>

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=back

=head2 C<_has_customer>

A predicate for the L</customer> attribute.

=head2 C<minimum_payment_due>

C<minimumPaymentDue>

The minimum payment required at this time.

A minimum_payment_due should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::MonetaryAmount']>

=item C<InstanceOf['SemanticWeb::Schema::PriceSpecification']>

=back

=head2 C<_has_minimum_payment_due>

A predicate for the L</minimum_payment_due> attribute.

=head2 C<payment_due>

C<paymentDue>

The date that payment is due.

A payment_due should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_payment_due>

A predicate for the L</payment_due> attribute.

=head2 C<payment_due_date>

C<paymentDueDate>

The date that payment is due.

A payment_due_date should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_payment_due_date>

A predicate for the L</payment_due_date> attribute.

=head2 C<payment_method>

C<paymentMethod>

The name of the credit card or other method of payment for the order.

A payment_method should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::PaymentMethod']>

=back

=head2 C<_has_payment_method>

A predicate for the L</payment_method> attribute.

=head2 C<payment_method_id>

C<paymentMethodId>

An identifier for the method of payment used (e.g. the last 4 digits of the
credit card).

A payment_method_id should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_payment_method_id>

A predicate for the L</payment_method_id> attribute.

=head2 C<payment_status>

C<paymentStatus>

The status of payment; whether the invoice has been paid or not.

A payment_status should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::PaymentStatusType']>

=item C<Str>

=back

=head2 C<_has_payment_status>

A predicate for the L</payment_status> attribute.

=head2 C<provider>

The service provider, service operator, or service performer; the goods
producer. Another party (a seller) may offer those services or goods on
behalf of the provider. A provider may also serve as the seller.

A provider should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Organization']>

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=back

=head2 C<_has_provider>

A predicate for the L</provider> attribute.

=head2 C<references_order>

C<referencesOrder>

The Order(s) related to this Invoice. One or more Orders may be combined
into a single Invoice.

A references_order should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Order']>

=back

=head2 C<_has_references_order>

A predicate for the L</references_order> attribute.

=head2 C<scheduled_payment_date>

C<scheduledPaymentDate>

The date the invoice is scheduled to be paid.

A scheduled_payment_date should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_scheduled_payment_date>

A predicate for the L</scheduled_payment_date> attribute.

=head2 C<total_payment_due>

C<totalPaymentDue>

The total amount due.

A total_payment_due should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::MonetaryAmount']>

=item C<InstanceOf['SemanticWeb::Schema::PriceSpecification']>

=back

=head2 C<_has_total_payment_due>

A predicate for the L</total_payment_due> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::Intangible>

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

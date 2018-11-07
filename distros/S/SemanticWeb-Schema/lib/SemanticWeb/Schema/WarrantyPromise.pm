use utf8;

package SemanticWeb::Schema::WarrantyPromise;

# ABSTRACT: A structured value representing the duration and scope of services that will be provided to a customer free of charge in case of a defect or malfunction of a product.

use Moo;

extends qw/ SemanticWeb::Schema::StructuredValue /;


use MooX::JSON_LD 'WarrantyPromise';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v0.0.4';


has duration_of_warranty => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'durationOfWarranty',
);



has warranty_scope => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'warrantyScope',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::WarrantyPromise - A structured value representing the duration and scope of services that will be provided to a customer free of charge in case of a defect or malfunction of a product.

=head1 VERSION

version v0.0.4

=head1 DESCRIPTION

A structured value representing the duration and scope of services that
will be provided to a customer free of charge in case of a defect or
malfunction of a product.

=head1 ATTRIBUTES

=head2 C<duration_of_warranty>

C<durationOfWarranty>

The duration of the warranty promise. Common unitCode values are ANN for
year, MON for months, or DAY for days.

A duration_of_warranty should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::QuantitativeValue']>

=back

=head2 C<warranty_scope>

C<warrantyScope>

The scope of the warranty promise.

A warranty_scope should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::WarrantyScope']>

=back

=head1 SEE ALSO

L<SemanticWeb::Schema::StructuredValue>

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

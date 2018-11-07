use utf8;

package SemanticWeb::Schema::Trip;

# ABSTRACT: A trip or journey

use Moo;

extends qw/ SemanticWeb::Schema::Intangible /;


use MooX::JSON_LD 'Trip';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v0.0.4';


has arrival_time => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'arrivalTime',
);



has departure_time => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'departureTime',
);



has offers => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'offers',
);



has provider => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'provider',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::Trip - A trip or journey

=head1 VERSION

version v0.0.4

=head1 DESCRIPTION

A trip or journey. An itinerary of visits to one or more places.

=head1 ATTRIBUTES

=head2 C<arrival_time>

C<arrivalTime>

The expected arrival time.

A arrival_time should be one of the following types:

=over

=item C<Str>

=back

=head2 C<departure_time>

C<departureTime>

The expected departure time.

A departure_time should be one of the following types:

=over

=item C<Str>

=back

=head2 C<offers>

An offer to provide this item&#x2014;for example, an offer to sell a
product, rent the DVD of a movie, perform a service, or give away tickets
to an event.

A offers should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Offer']>

=back

=head2 C<provider>

The service provider, service operator, or service performer; the goods
producer. Another party (a seller) may offer those services or goods on
behalf of the provider. A provider may also serve as the seller.

A provider should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::Person']>

=item C<InstanceOf['SemanticWeb::Schema::Organization']>

=back

=head1 SEE ALSO

L<SemanticWeb::Schema::Intangible>

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

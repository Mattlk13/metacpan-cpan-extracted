use utf8;

package SemanticWeb::Schema::BusTrip;

# ABSTRACT: A trip on a commercial bus line.

use Moo;

extends qw/ SemanticWeb::Schema::Trip /;


use MooX::JSON_LD 'BusTrip';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v0.0.2';


has arrival_bus_stop => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'arrivalBusStop',
);



has bus_name => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'busName',
);



has bus_number => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'busNumber',
);



has departure_bus_stop => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'departureBusStop',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::BusTrip - A trip on a commercial bus line.

=head1 VERSION

version v0.0.2

=head1 DESCRIPTION

A trip on a commercial bus line.

=head1 ATTRIBUTES

=head2 C<arrival_bus_stop>

C<arrivalBusStop>

The stop or station from which the bus arrives.

A arrival_bus_stop should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::BusStation']>

=item C<InstanceOf['SemanticWeb::Schema::BusStop']>

=back

=head2 C<bus_name>

C<busName>

The name of the bus (e.g. Bolt Express).

A bus_name should be one of the following types:

=over

=item C<Str>

=back

=head2 C<bus_number>

C<busNumber>

The unique identifier for the bus.

A bus_number should be one of the following types:

=over

=item C<Str>

=back

=head2 C<departure_bus_stop>

C<departureBusStop>

The stop or station from which the bus departs.

A departure_bus_stop should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::BusStation']>

=item C<InstanceOf['SemanticWeb::Schema::BusStop']>

=back

=head1 SEE ALSO

L<SemanticWeb::Schema::Trip>

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

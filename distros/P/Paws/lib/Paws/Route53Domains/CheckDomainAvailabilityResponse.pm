
package Paws::Route53Domains::CheckDomainAvailabilityResponse;
  use Moose;
  has Availability => (is => 'ro', isa => 'Str', required => 1);

  has _request_id => (is => 'ro', isa => 'Str');

### main pod documentation begin ###

=head1 NAME

Paws::Route53Domains::CheckDomainAvailabilityResponse

=head1 ATTRIBUTES


=head2 B<REQUIRED> Availability => Str

Whether the domain name is available for registering.

You can only register domains designated as C<AVAILABLE>.

Type: String

Valid values:

=over

=item * C<AVAILABLE> E<ndash> The domain name is available.

=item * C<AVAILABLE_RESERVED> E<ndash> The domain name is reserved
under specific conditions.

=item * C<AVAILABLE_PREORDER> E<ndash> The domain name is available and
can be preordered.

=item * C<UNAVAILABLE> E<ndash> The domain name is not available.

=item * C<UNAVAILABLE_PREMIUM> E<ndash> The domain name is not
available.

=item * C<UNAVAILABLE_RESTRICTED> E<ndash> The domain name is
forbidden.

=item * C<RESERVED> E<ndash> The domain name has been reserved for
another person or organization.

=item * C<DONT_KNOW> E<ndash> The TLD registry didn't reply with a
definitive answer about whether the domain name is available. Amazon
Route 53 can return this response for a variety of reasons, for
example, the registry is performing maintenance. Try again later.

=back


Valid values are: C<"AVAILABLE">, C<"AVAILABLE_RESERVED">, C<"AVAILABLE_PREORDER">, C<"UNAVAILABLE">, C<"UNAVAILABLE_PREMIUM">, C<"UNAVAILABLE_RESTRICTED">, C<"RESERVED">, C<"DONT_KNOW">
=head2 _request_id => Str


=cut

1;
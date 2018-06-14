package Paws::ServiceDiscovery::HealthCheckConfig;
  use Moose;
  has FailureThreshold => (is => 'ro', isa => 'Int');
  has ResourcePath => (is => 'ro', isa => 'Str');
  has Type => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::ServiceDiscovery::HealthCheckConfig

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::ServiceDiscovery::HealthCheckConfig object:

  $service_obj->Method(Att1 => { FailureThreshold => $value, ..., Type => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::ServiceDiscovery::HealthCheckConfig object:

  $result = $service_obj->Method(...);
  $result->Att1->FailureThreshold

=head1 DESCRIPTION

I<Public DNS namespaces only.> A complex type that contains settings
for an optional health check. If you specify settings for a health
check, Amazon Route 53 associates the health check with all the records
that you specify in C<DnsConfig>.

B<A and AAAA records>

If C<DnsConfig> includes configurations for both A and AAAA records,
Route 53 creates a health check that uses the IPv4 address to check the
health of the resource. If the endpoint that is specified by the IPv4
address is unhealthy, Route 53 considers both the A and AAAA records to
be unhealthy.

B<CNAME records>

You can't specify settings for C<HealthCheckConfig> when the
C<DNSConfig> includes C<CNAME> for the value of C<Type>. If you do, the
C<CreateService> request will fail with an C<InvalidInput> error.

B<Request interval>

The health check uses 30 seconds as the request interval. This is the
number of seconds between the time that each Route 53 health checker
gets a response from your endpoint and the time that it sends the next
health check request. A health checker in each data center around the
world sends your endpoint a health check request every 30 seconds. On
average, your endpoint receives a health check request about every two
seconds. Health checkers in different data centers don't coordinate
with one another, so you'll sometimes see several requests per second
followed by a few seconds with no health checks at all.

B<Health checking regions>

Health checkers perform checks from all Route 53 health-checking
regions. For a list of the current regions, see Regions
(http://docs.aws.amazon.com/Route53/latest/APIReference/API_HealthCheckConfig.html#Route53-Type-HealthCheckConfig-Regions).

B<Alias records>

When you register an instance, if you include the C<AWS_ALIAS_DNS_NAME>
attribute, Route 53 creates an alias record. Note the following:

=over

=item *

Route 53 automatically sets C<EvaluateTargetHealth> to true for alias
records. When C<EvaluateTargetHealth> is true, the alias record
inherits the health of the referenced AWS resource. such as an ELB load
balancer. For more information, see EvaluateTargetHealth
(http://docs.aws.amazon.com/Route53/latest/APIReference/API_AliasTarget.html#Route53-Type-AliasTarget-EvaluateTargetHealth).

=item *

If you include C<HealthCheckConfig> and then use the service to
register an instance that creates an alias record, Route 53 doesn't
create the health check.

=back

For information about the charges for health checks, see Route 53
Pricing (http://aws.amazon.com/route53/pricing).

=head1 ATTRIBUTES


=head2 FailureThreshold => Int

  The number of consecutive health checks that an endpoint must pass or
fail for Route 53 to change the current status of the endpoint from
unhealthy to healthy or vice versa. For more information, see How Route
53 Determines Whether an Endpoint Is Healthy
(http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-determining-health-of-endpoints.html)
in the I<Route 53 Developer Guide>.


=head2 ResourcePath => Str

  The path that you want Route 53 to request when performing health
checks. The path can be any value for which your endpoint will return
an HTTP status code of 2xx or 3xx when the endpoint is healthy, such as
the file C</docs/route53-health-check.html>. Route 53 automatically
adds the DNS name for the service and a leading forward slash (C</>)
character.


=head2 Type => Str

  The type of health check that you want to create, which indicates how
Route 53 determines whether an endpoint is healthy.

You can't change the value of C<Type> after you create a health check.

You can create the following types of health checks:

=over

=item *

B<HTTP>: Route 53 tries to establish a TCP connection. If successful,
Route 53 submits an HTTP request and waits for an HTTP status code of
200 or greater and less than 400.

=item *

B<HTTPS>: Route 53 tries to establish a TCP connection. If successful,
Route 53 submits an HTTPS request and waits for an HTTP status code of
200 or greater and less than 400.

If you specify HTTPS for the value of C<Type>, the endpoint must
support TLS v1.0 or later.

=item *

B<TCP>: Route 53 tries to establish a TCP connection.

=back

For more information, see How Route 53 Determines Whether an Endpoint
Is Healthy
(http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-determining-health-of-endpoints.html)
in the I<Route 53 Developer Guide>.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::ServiceDiscovery>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


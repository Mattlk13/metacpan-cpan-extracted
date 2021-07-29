
package Paws::Transfer::UpdateServer;
  use Moose;
  has Certificate => (is => 'ro', isa => 'Str');
  has EndpointDetails => (is => 'ro', isa => 'Paws::Transfer::EndpointDetails');
  has EndpointType => (is => 'ro', isa => 'Str');
  has HostKey => (is => 'ro', isa => 'Str');
  has IdentityProviderDetails => (is => 'ro', isa => 'Paws::Transfer::IdentityProviderDetails');
  has LoggingRole => (is => 'ro', isa => 'Str');
  has ProtocolDetails => (is => 'ro', isa => 'Paws::Transfer::ProtocolDetails');
  has Protocols => (is => 'ro', isa => 'ArrayRef[Str|Undef]');
  has SecurityPolicyName => (is => 'ro', isa => 'Str');
  has ServerId => (is => 'ro', isa => 'Str', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'UpdateServer');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::Transfer::UpdateServerResponse');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Transfer::UpdateServer - Arguments for method UpdateServer on L<Paws::Transfer>

=head1 DESCRIPTION

This class represents the parameters used for calling the method UpdateServer on the
L<AWS Transfer Family|Paws::Transfer> service. Use the attributes of this class
as arguments to method UpdateServer.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to UpdateServer.

=head1 SYNOPSIS

    my $transfer = Paws->service('Transfer');
    my $UpdateServerResponse = $transfer->UpdateServer(
      ServerId        => 'MyServerId',
      Certificate     => 'MyCertificate',    # OPTIONAL
      EndpointDetails => {
        AddressAllocationIds => [ 'MyAddressAllocationId', ... ],    # OPTIONAL
        SecurityGroupIds     => [
          'MySecurityGroupId', ...    # min: 11, max: 20
        ],    # OPTIONAL
        SubnetIds     => [ 'MySubnetId', ... ],    # OPTIONAL
        VpcEndpointId => 'MyVpcEndpointId',        # min: 22, max: 22; OPTIONAL
        VpcId         => 'MyVpcId',                # OPTIONAL
      },    # OPTIONAL
      EndpointType            => 'PUBLIC',       # OPTIONAL
      HostKey                 => 'MyHostKey',    # OPTIONAL
      IdentityProviderDetails => {
        DirectoryId    => 'MyDirectoryId',       # min: 12, max: 12; OPTIONAL
        InvocationRole => 'MyRole',              # min: 20, max: 2048; OPTIONAL
        Url            => 'MyUrl',               # max: 255; OPTIONAL
      },    # OPTIONAL
      LoggingRole     => 'MyNullableRole',    # OPTIONAL
      ProtocolDetails => {
        PassiveIp => 'MyPassiveIp',           # max: 15; OPTIONAL
      },    # OPTIONAL
      Protocols => [
        'SFTP', ...    # values: SFTP, FTP, FTPS
      ],    # OPTIONAL
      SecurityPolicyName => 'MySecurityPolicyName',    # OPTIONAL
    );

    # Results:
    my $ServerId = $UpdateServerResponse->ServerId;

    # Returns a L<Paws::Transfer::UpdateServerResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/transfer/UpdateServer>

=head1 ATTRIBUTES


=head2 Certificate => Str

The Amazon Resource Name (ARN) of the Amazon Web ServicesCertificate
Manager (ACM) certificate. Required when C<Protocols> is set to
C<FTPS>.

To request a new public certificate, see Request a public certificate
(https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-public.html)
in the I< Amazon Web ServicesCertificate Manager User Guide>.

To import an existing certificate into ACM, see Importing certificates
into ACM
(https://docs.aws.amazon.com/acm/latest/userguide/import-certificate.html)
in the I< Amazon Web ServicesCertificate Manager User Guide>.

To request a private certificate to use FTPS through private IP
addresses, see Request a private certificate
(https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-private.html)
in the I< Amazon Web ServicesCertificate Manager User Guide>.

Certificates with the following cryptographic algorithms and key sizes
are supported:

=over

=item *

2048-bit RSA (RSA_2048)

=item *

4096-bit RSA (RSA_4096)

=item *

Elliptic Prime Curve 256 bit (EC_prime256v1)

=item *

Elliptic Prime Curve 384 bit (EC_secp384r1)

=item *

Elliptic Prime Curve 521 bit (EC_secp521r1)

=back

The certificate must be a valid SSL/TLS X.509 version 3 certificate
with FQDN or IP address specified and information about the issuer.



=head2 EndpointDetails => L<Paws::Transfer::EndpointDetails>

The virtual private cloud (VPC) endpoint settings that are configured
for your server. When you host your endpoint within your VPC, you can
make it accessible only to resources within your VPC, or you can attach
Elastic IP addresses and make it accessible to clients over the
internet. Your VPC's default security groups are automatically assigned
to your endpoint.



=head2 EndpointType => Str

The type of endpoint that you want your server to use. You can choose
to make your server's endpoint publicly accessible (PUBLIC) or host it
inside your VPC. With an endpoint that is hosted in a VPC, you can
restrict access to your server and resources only within your VPC or
choose to make it internet facing by attaching Elastic IP addresses
directly to it.

After May 19, 2021, you won't be able to create a server using
C<EndpointType=VPC_ENDPOINT> in your Amazon Web Servicesaccount if your
account hasn't already done so before May 19, 2021. If you have already
created servers with C<EndpointType=VPC_ENDPOINT> in your Amazon Web
Servicesaccount on or before May 19, 2021, you will not be affected.
After this date, use C<EndpointType>=C<VPC>.

For more information, see
https://docs.aws.amazon.com/transfer/latest/userguide/create-server-in-vpc.html#deprecate-vpc-endpoint.

It is recommended that you use C<VPC> as the C<EndpointType>. With this
endpoint type, you have the option to directly associate up to three
Elastic IPv4 addresses (BYO IP included) with your server's endpoint
and use VPC security groups to restrict traffic by the client's public
IP address. This is not possible with C<EndpointType> set to
C<VPC_ENDPOINT>.

Valid values are: C<"PUBLIC">, C<"VPC">, C<"VPC_ENDPOINT">

=head2 HostKey => Str

The RSA private key as generated by C<ssh-keygen -N "" -m PEM -f
my-new-server-key>.

If you aren't planning to migrate existing users from an existing
server to a new server, don't update the host key. Accidentally
changing a server's host key can be disruptive.

For more information, see Change the host key for your SFTP-enabled
server
(https://docs.aws.amazon.com/transfer/latest/userguide/edit-server-config.html#configuring-servers-change-host-key)
in the I<Amazon Web ServicesTransfer Family User Guide>.



=head2 IdentityProviderDetails => L<Paws::Transfer::IdentityProviderDetails>

An array containing all of the information required to call a
customer's authentication API method.



=head2 LoggingRole => Str

Specifies the Amazon Resource Name (ARN) of the Amazon Web Services
Identity and Access Management (IAM) role that allows a server to turn
on Amazon CloudWatch logging for Amazon S3 or Amazon EFS events. When
set, user activity can be viewed in your CloudWatch logs.



=head2 ProtocolDetails => L<Paws::Transfer::ProtocolDetails>

The protocol settings that are configured for your server.

Use the C<PassiveIp> parameter to indicate passive mode (for FTP and
FTPS protocols). Enter a single dotted-quad IPv4 address, such as the
external IP address of a firewall, router, or load balancer.



=head2 Protocols => ArrayRef[Str|Undef]

Specifies the file transfer protocol or protocols over which your file
transfer protocol client can connect to your server's endpoint. The
available protocols are:

=over

=item *

Secure Shell (SSH) File Transfer Protocol (SFTP): File transfer over
SSH

=item *

File Transfer Protocol Secure (FTPS): File transfer with TLS encryption

=item *

File Transfer Protocol (FTP): Unencrypted file transfer

=back

If you select C<FTPS>, you must choose a certificate stored in Amazon
Web ServicesCertificate Manager (ACM) which will be used to identify
your server when clients connect to it over FTPS.

If C<Protocol> includes either C<FTP> or C<FTPS>, then the
C<EndpointType> must be C<VPC> and the C<IdentityProviderType> must be
C<AWS_DIRECTORY_SERVICE> or C<API_GATEWAY>.

If C<Protocol> includes C<FTP>, then C<AddressAllocationIds> cannot be
associated.

If C<Protocol> is set only to C<SFTP>, the C<EndpointType> can be set
to C<PUBLIC> and the C<IdentityProviderType> can be set to
C<SERVICE_MANAGED>.



=head2 SecurityPolicyName => Str

Specifies the name of the security policy that is attached to the
server.



=head2 B<REQUIRED> ServerId => Str

A system-assigned unique identifier for a server instance that the user
account is assigned to.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method UpdateServer in L<Paws::Transfer>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


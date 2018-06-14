
package Paws::DirectConnect::AllocateConnectionOnInterconnect;
  use Moose;
  has Bandwidth => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'bandwidth' , required => 1);
  has ConnectionName => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'connectionName' , required => 1);
  has InterconnectId => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'interconnectId' , required => 1);
  has OwnerAccount => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'ownerAccount' , required => 1);
  has Vlan => (is => 'ro', isa => 'Int', traits => ['NameInRequest'], request_name => 'vlan' , required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'AllocateConnectionOnInterconnect');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::DirectConnect::Connection');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::DirectConnect::AllocateConnectionOnInterconnect - Arguments for method AllocateConnectionOnInterconnect on L<Paws::DirectConnect>

=head1 DESCRIPTION

This class represents the parameters used for calling the method AllocateConnectionOnInterconnect on the
L<AWS Direct Connect|Paws::DirectConnect> service. Use the attributes of this class
as arguments to method AllocateConnectionOnInterconnect.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to AllocateConnectionOnInterconnect.

=head1 SYNOPSIS

    my $directconnect = Paws->service('DirectConnect');
    my $Connection = $directconnect->AllocateConnectionOnInterconnect(
      Bandwidth      => 'MyBandwidth',
      ConnectionName => 'MyConnectionName',
      InterconnectId => 'MyInterconnectId',
      OwnerAccount   => 'MyOwnerAccount',
      Vlan           => 1,

    );

    # Results:
    my $Vlan            = $Connection->Vlan;
    my $ConnectionId    = $Connection->ConnectionId;
    my $Region          = $Connection->Region;
    my $LagId           = $Connection->LagId;
    my $Bandwidth       = $Connection->Bandwidth;
    my $OwnerAccount    = $Connection->OwnerAccount;
    my $PartnerName     = $Connection->PartnerName;
    my $LoaIssueTime    = $Connection->LoaIssueTime;
    my $Location        = $Connection->Location;
    my $AwsDevice       = $Connection->AwsDevice;
    my $ConnectionState = $Connection->ConnectionState;
    my $ConnectionName  = $Connection->ConnectionName;

    # Returns a L<Paws::DirectConnect::Connection> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/directconnect/AllocateConnectionOnInterconnect>

=head1 ATTRIBUTES


=head2 B<REQUIRED> Bandwidth => Str

Bandwidth of the connection.

Example: "I<500Mbps>"

Default: None

Values: 50Mbps, 100Mbps, 200Mbps, 300Mbps, 400Mbps, or 500Mbps



=head2 B<REQUIRED> ConnectionName => Str

Name of the provisioned connection.

Example: "I<500M Connection to AWS>"

Default: None



=head2 B<REQUIRED> InterconnectId => Str

ID of the interconnect on which the connection will be provisioned.

Example: dxcon-456abc78

Default: None



=head2 B<REQUIRED> OwnerAccount => Str

Numeric account Id of the customer for whom the connection will be
provisioned.

Example: 123443215678

Default: None



=head2 B<REQUIRED> Vlan => Int

The dedicated VLAN provisioned to the connection.

Example: 101

Default: None




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method AllocateConnectionOnInterconnect in L<Paws::DirectConnect>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


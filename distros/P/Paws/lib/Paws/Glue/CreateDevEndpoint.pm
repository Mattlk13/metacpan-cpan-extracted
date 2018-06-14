
package Paws::Glue::CreateDevEndpoint;
  use Moose;
  has EndpointName => (is => 'ro', isa => 'Str', required => 1);
  has ExtraJarsS3Path => (is => 'ro', isa => 'Str');
  has ExtraPythonLibsS3Path => (is => 'ro', isa => 'Str');
  has NumberOfNodes => (is => 'ro', isa => 'Int');
  has PublicKey => (is => 'ro', isa => 'Str');
  has RoleArn => (is => 'ro', isa => 'Str', required => 1);
  has SecurityGroupIds => (is => 'ro', isa => 'ArrayRef[Str|Undef]');
  has SubnetId => (is => 'ro', isa => 'Str');

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'CreateDevEndpoint');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::Glue::CreateDevEndpointResponse');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Glue::CreateDevEndpoint - Arguments for method CreateDevEndpoint on L<Paws::Glue>

=head1 DESCRIPTION

This class represents the parameters used for calling the method CreateDevEndpoint on the
L<AWS Glue|Paws::Glue> service. Use the attributes of this class
as arguments to method CreateDevEndpoint.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to CreateDevEndpoint.

=head1 SYNOPSIS

    my $glue = Paws->service('Glue');
    my $CreateDevEndpointResponse = $glue->CreateDevEndpoint(
      EndpointName          => 'MyGenericString',
      RoleArn               => 'MyRoleArn',
      ExtraJarsS3Path       => 'MyGenericString',             # OPTIONAL
      ExtraPythonLibsS3Path => 'MyGenericString',             # OPTIONAL
      NumberOfNodes         => 1,                             # OPTIONAL
      PublicKey             => 'MyGenericString',             # OPTIONAL
      SecurityGroupIds      => [ 'MyGenericString', ... ],    # OPTIONAL
      SubnetId              => 'MyGenericString',             # OPTIONAL
    );

    # Results:
    my $RoleArn       = $CreateDevEndpointResponse->RoleArn;
    my $Status        = $CreateDevEndpointResponse->Status;
    my $FailureReason = $CreateDevEndpointResponse->FailureReason;
    my $EndpointName  = $CreateDevEndpointResponse->EndpointName;
    my $ZeppelinRemoteSparkInterpreterPort =
      $CreateDevEndpointResponse->ZeppelinRemoteSparkInterpreterPort;
    my $ExtraJarsS3Path  = $CreateDevEndpointResponse->ExtraJarsS3Path;
    my $AvailabilityZone = $CreateDevEndpointResponse->AvailabilityZone;
    my $SubnetId         = $CreateDevEndpointResponse->SubnetId;
    my $VpcId            = $CreateDevEndpointResponse->VpcId;
    my $ExtraPythonLibsS3Path =
      $CreateDevEndpointResponse->ExtraPythonLibsS3Path;
    my $CreatedTimestamp    = $CreateDevEndpointResponse->CreatedTimestamp;
    my $SecurityGroupIds    = $CreateDevEndpointResponse->SecurityGroupIds;
    my $YarnEndpointAddress = $CreateDevEndpointResponse->YarnEndpointAddress;
    my $NumberOfNodes       = $CreateDevEndpointResponse->NumberOfNodes;

    # Returns a L<Paws::Glue::CreateDevEndpointResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/glue/CreateDevEndpoint>

=head1 ATTRIBUTES


=head2 B<REQUIRED> EndpointName => Str

The name to be assigned to the new DevEndpoint.



=head2 ExtraJarsS3Path => Str

Path to one or more Java Jars in an S3 bucket that should be loaded in
your DevEndpoint.



=head2 ExtraPythonLibsS3Path => Str

Path(s) to one or more Python libraries in an S3 bucket that should be
loaded in your DevEndpoint. Multiple values must be complete paths
separated by a comma.

Please note that only pure Python libraries can currently be used on a
DevEndpoint. Libraries that rely on C extensions, such as the pandas
(http://pandas.pydata.org/) Python data analysis library, are not yet
supported.



=head2 NumberOfNodes => Int

The number of AWS Glue Data Processing Units (DPUs) to allocate to this
DevEndpoint.



=head2 PublicKey => Str

The public key to use for authentication.



=head2 B<REQUIRED> RoleArn => Str

The IAM role for the DevEndpoint.



=head2 SecurityGroupIds => ArrayRef[Str|Undef]

Security group IDs for the security groups to be used by the new
DevEndpoint.



=head2 SubnetId => Str

The subnet ID for the new DevEndpoint to use.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method CreateDevEndpoint in L<Paws::Glue>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


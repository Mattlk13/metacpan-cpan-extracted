
package Paws::MQ::DescribeBroker;
  use Moose;
  has BrokerId => (is => 'ro', isa => 'Str', traits => ['ParamInURI'], uri_name => 'broker-id', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'DescribeBroker');
  class_has _api_uri  => (isa => 'Str', is => 'ro', default => '/v1/brokers/{broker-id}');
  class_has _api_method  => (isa => 'Str', is => 'ro', default => 'GET');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::MQ::DescribeBrokerResponse');
1;

### main pod documentation begin ###

=head1 NAME

Paws::MQ::DescribeBroker - Arguments for method DescribeBroker on L<Paws::MQ>

=head1 DESCRIPTION

This class represents the parameters used for calling the method DescribeBroker on the
L<AmazonMQ|Paws::MQ> service. Use the attributes of this class
as arguments to method DescribeBroker.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to DescribeBroker.

=head1 SYNOPSIS

    my $mq = Paws->service('MQ');
    my $DescribeBrokerResponse = $mq->DescribeBroker(
      BrokerId => 'My__string',

    );

    # Results:
    my $EngineVersion      = $DescribeBrokerResponse->EngineVersion;
    my $SubnetIds          = $DescribeBrokerResponse->SubnetIds;
    my $EngineType         = $DescribeBrokerResponse->EngineType;
    my $BrokerId           = $DescribeBrokerResponse->BrokerId;
    my $BrokerInstances    = $DescribeBrokerResponse->BrokerInstances;
    my $SecurityGroups     = $DescribeBrokerResponse->SecurityGroups;
    my $BrokerState        = $DescribeBrokerResponse->BrokerState;
    my $Users              = $DescribeBrokerResponse->Users;
    my $BrokerName         = $DescribeBrokerResponse->BrokerName;
    my $Configurations     = $DescribeBrokerResponse->Configurations;
    my $PubliclyAccessible = $DescribeBrokerResponse->PubliclyAccessible;
    my $AutoMinorVersionUpgrade =
      $DescribeBrokerResponse->AutoMinorVersionUpgrade;
    my $HostInstanceType = $DescribeBrokerResponse->HostInstanceType;
    my $BrokerArn        = $DescribeBrokerResponse->BrokerArn;
    my $DeploymentMode   = $DescribeBrokerResponse->DeploymentMode;
    my $MaintenanceWindowStartTime =
      $DescribeBrokerResponse->MaintenanceWindowStartTime;

    # Returns a L<Paws::MQ::DescribeBrokerResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://aws.amazon.com/documentation/amazon-mq/>

=head1 ATTRIBUTES


=head2 B<REQUIRED> BrokerId => Str

The name of the broker. This value must be unique in your AWS account,
1-50 characters long, must contain only letters, numbers, dashes, and
underscores, and must not contain whitespaces, brackets, wildcard
characters, or special characters.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method DescribeBroker in L<Paws::MQ>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


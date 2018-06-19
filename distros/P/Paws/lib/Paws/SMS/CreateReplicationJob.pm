
package Paws::SMS::CreateReplicationJob;
  use Moose;
  has Description => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'description' );
  has Frequency => (is => 'ro', isa => 'Int', traits => ['NameInRequest'], request_name => 'frequency' , required => 1);
  has LicenseType => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'licenseType' );
  has RoleName => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'roleName' );
  has SeedReplicationTime => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'seedReplicationTime' , required => 1);
  has ServerId => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'serverId' , required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'CreateReplicationJob');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::SMS::CreateReplicationJobResponse');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::SMS::CreateReplicationJob - Arguments for method CreateReplicationJob on L<Paws::SMS>

=head1 DESCRIPTION

This class represents the parameters used for calling the method CreateReplicationJob on the
L<AWS Server Migration Service|Paws::SMS> service. Use the attributes of this class
as arguments to method CreateReplicationJob.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to CreateReplicationJob.

=head1 SYNOPSIS

    my $sms = Paws->service('SMS');
    my $CreateReplicationJobResponse = $sms->CreateReplicationJob(
      Frequency           => 1,
      SeedReplicationTime => '1970-01-01T01:00:00',
      ServerId            => 'MyServerId',
      Description         => 'MyDescription',         # OPTIONAL
      LicenseType         => 'AWS',                   # OPTIONAL
      RoleName            => 'MyRoleName',            # OPTIONAL
    );

    # Results:
    my $ReplicationJobId = $CreateReplicationJobResponse->ReplicationJobId;

    # Returns a L<Paws::SMS::CreateReplicationJobResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/sms/CreateReplicationJob>

=head1 ATTRIBUTES


=head2 Description => Str





=head2 B<REQUIRED> Frequency => Int





=head2 LicenseType => Str



Valid values are: C<"AWS">, C<"BYOL">

=head2 RoleName => Str





=head2 B<REQUIRED> SeedReplicationTime => Str





=head2 B<REQUIRED> ServerId => Str






=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method CreateReplicationJob in L<Paws::SMS>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


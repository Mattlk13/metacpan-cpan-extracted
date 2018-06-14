package Paws::Greengrass;
  use Moose;
  sub service { 'greengrass' }
  sub signing_name { 'greengrass' }
  sub version { '2017-06-07' }
  sub flattened_arrays { 0 }
  has max_attempts => (is => 'ro', isa => 'Int', default => 5);
  has retry => (is => 'ro', isa => 'HashRef', default => sub {
    { base => 'rand', type => 'exponential', growth_factor => 2 }
  });
  has retriables => (is => 'ro', isa => 'ArrayRef', default => sub { [
  ] });

  with 'Paws::API::Caller', 'Paws::API::EndpointResolver', 'Paws::Net::V4Signature', 'Paws::Net::RestJsonCaller';

  
  sub AssociateRoleToGroup {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::AssociateRoleToGroup', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub AssociateServiceRoleToAccount {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::AssociateServiceRoleToAccount', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateCoreDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateCoreDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateCoreDefinitionVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateCoreDefinitionVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateDeployment {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateDeployment', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateDeviceDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateDeviceDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateDeviceDefinitionVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateDeviceDefinitionVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateFunctionDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateFunctionDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateFunctionDefinitionVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateFunctionDefinitionVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateGroup {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateGroup', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateGroupCertificateAuthority {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateGroupCertificateAuthority', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateGroupVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateGroupVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateLoggerDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateLoggerDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateLoggerDefinitionVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateLoggerDefinitionVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateResourceDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateResourceDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateResourceDefinitionVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateResourceDefinitionVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateSoftwareUpdateJob {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateSoftwareUpdateJob', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateSubscriptionDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateSubscriptionDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateSubscriptionDefinitionVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::CreateSubscriptionDefinitionVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteCoreDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::DeleteCoreDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteDeviceDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::DeleteDeviceDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteFunctionDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::DeleteFunctionDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteGroup {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::DeleteGroup', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteLoggerDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::DeleteLoggerDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteResourceDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::DeleteResourceDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteSubscriptionDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::DeleteSubscriptionDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DisassociateRoleFromGroup {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::DisassociateRoleFromGroup', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DisassociateServiceRoleFromAccount {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::DisassociateServiceRoleFromAccount', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetAssociatedRole {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetAssociatedRole', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetConnectivityInfo {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetConnectivityInfo', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetCoreDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetCoreDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetCoreDefinitionVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetCoreDefinitionVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetDeploymentStatus {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetDeploymentStatus', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetDeviceDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetDeviceDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetDeviceDefinitionVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetDeviceDefinitionVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetFunctionDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetFunctionDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetFunctionDefinitionVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetFunctionDefinitionVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetGroup {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetGroup', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetGroupCertificateAuthority {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetGroupCertificateAuthority', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetGroupCertificateConfiguration {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetGroupCertificateConfiguration', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetGroupVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetGroupVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetLoggerDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetLoggerDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetLoggerDefinitionVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetLoggerDefinitionVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetResourceDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetResourceDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetResourceDefinitionVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetResourceDefinitionVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetServiceRoleForAccount {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetServiceRoleForAccount', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetSubscriptionDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetSubscriptionDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetSubscriptionDefinitionVersion {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::GetSubscriptionDefinitionVersion', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListCoreDefinitions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListCoreDefinitions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListCoreDefinitionVersions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListCoreDefinitionVersions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListDeployments {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListDeployments', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListDeviceDefinitions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListDeviceDefinitions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListDeviceDefinitionVersions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListDeviceDefinitionVersions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListFunctionDefinitions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListFunctionDefinitions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListFunctionDefinitionVersions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListFunctionDefinitionVersions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListGroupCertificateAuthorities {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListGroupCertificateAuthorities', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListGroups {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListGroups', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListGroupVersions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListGroupVersions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListLoggerDefinitions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListLoggerDefinitions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListLoggerDefinitionVersions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListLoggerDefinitionVersions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListResourceDefinitions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListResourceDefinitions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListResourceDefinitionVersions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListResourceDefinitionVersions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListSubscriptionDefinitions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListSubscriptionDefinitions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListSubscriptionDefinitionVersions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ListSubscriptionDefinitionVersions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ResetDeployments {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::ResetDeployments', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateConnectivityInfo {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::UpdateConnectivityInfo', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateCoreDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::UpdateCoreDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateDeviceDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::UpdateDeviceDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateFunctionDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::UpdateFunctionDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateGroup {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::UpdateGroup', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateGroupCertificateConfiguration {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::UpdateGroupCertificateConfiguration', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateLoggerDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::UpdateLoggerDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateResourceDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::UpdateResourceDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateSubscriptionDefinition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::Greengrass::UpdateSubscriptionDefinition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  


  sub operations { qw/AssociateRoleToGroup AssociateServiceRoleToAccount CreateCoreDefinition CreateCoreDefinitionVersion CreateDeployment CreateDeviceDefinition CreateDeviceDefinitionVersion CreateFunctionDefinition CreateFunctionDefinitionVersion CreateGroup CreateGroupCertificateAuthority CreateGroupVersion CreateLoggerDefinition CreateLoggerDefinitionVersion CreateResourceDefinition CreateResourceDefinitionVersion CreateSoftwareUpdateJob CreateSubscriptionDefinition CreateSubscriptionDefinitionVersion DeleteCoreDefinition DeleteDeviceDefinition DeleteFunctionDefinition DeleteGroup DeleteLoggerDefinition DeleteResourceDefinition DeleteSubscriptionDefinition DisassociateRoleFromGroup DisassociateServiceRoleFromAccount GetAssociatedRole GetConnectivityInfo GetCoreDefinition GetCoreDefinitionVersion GetDeploymentStatus GetDeviceDefinition GetDeviceDefinitionVersion GetFunctionDefinition GetFunctionDefinitionVersion GetGroup GetGroupCertificateAuthority GetGroupCertificateConfiguration GetGroupVersion GetLoggerDefinition GetLoggerDefinitionVersion GetResourceDefinition GetResourceDefinitionVersion GetServiceRoleForAccount GetSubscriptionDefinition GetSubscriptionDefinitionVersion ListCoreDefinitions ListCoreDefinitionVersions ListDeployments ListDeviceDefinitions ListDeviceDefinitionVersions ListFunctionDefinitions ListFunctionDefinitionVersions ListGroupCertificateAuthorities ListGroups ListGroupVersions ListLoggerDefinitions ListLoggerDefinitionVersions ListResourceDefinitions ListResourceDefinitionVersions ListSubscriptionDefinitions ListSubscriptionDefinitionVersions ResetDeployments UpdateConnectivityInfo UpdateCoreDefinition UpdateDeviceDefinition UpdateFunctionDefinition UpdateGroup UpdateGroupCertificateConfiguration UpdateLoggerDefinition UpdateResourceDefinition UpdateSubscriptionDefinition / }

1;

### main pod documentation begin ###

=head1 NAME

Paws::Greengrass - Perl Interface to AWS AWS Greengrass

=head1 SYNOPSIS

  use Paws;

  my $obj = Paws->service('Greengrass');
  my $res = $obj->Method(
    Arg1 => $val1,
    Arg2 => [ 'V1', 'V2' ],
    # if Arg3 is an object, the HashRef will be used as arguments to the constructor
    # of the arguments type
    Arg3 => { Att1 => 'Val1' },
    # if Arg4 is an array of objects, the HashRefs will be passed as arguments to
    # the constructor of the arguments type
    Arg4 => [ { Att1 => 'Val1'  }, { Att1 => 'Val2' } ],
  );

=head1 DESCRIPTION

AWS Greengrass seamlessly extends AWS onto physical devices so they can
act locally on the data they generate, while still using the cloud for
management, analytics, and durable storage. AWS Greengrass ensures your
devices can respond quickly to local events and operate with
intermittent connectivity. AWS Greengrass minimizes the cost of
transmitting data to the cloud by allowing you to author AWS Lambda
functions that execute locally.

For the AWS API documentation, see L<https://aws.amazon.com/documentation/greengrass/>


=head1 METHODS

=head2 AssociateRoleToGroup

=over

=item GroupId => Str

=item [RoleArn => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::AssociateRoleToGroup>

Returns: a L<Paws::Greengrass::AssociateRoleToGroupResponse> instance

Associates a role with a group. Your AWS Greengrass core will use the
role to access AWS cloud services. The role's permissions should allow
Greengrass core Lambda functions to perform actions against the cloud.


=head2 AssociateServiceRoleToAccount

=over

=item [RoleArn => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::AssociateServiceRoleToAccount>

Returns: a L<Paws::Greengrass::AssociateServiceRoleToAccountResponse> instance

Associates a role with your account. AWS Greengrass will use the role
to access your Lambda functions and AWS IoT resources. This is
necessary for deployments to succeed. The role must have at least
minimum permissions in the policy
''AWSGreengrassResourceAccessRolePolicy''.


=head2 CreateCoreDefinition

=over

=item [AmznClientToken => Str]

=item [InitialVersion => L<Paws::Greengrass::CoreDefinitionVersion>]

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateCoreDefinition>

Returns: a L<Paws::Greengrass::CreateCoreDefinitionResponse> instance

Creates a core definition. You may provide the initial version of the
core definition now or use ''CreateCoreDefinitionVersion'' at a later
time. AWS Greengrass groups must each contain exactly one AWS
Greengrass core.


=head2 CreateCoreDefinitionVersion

=over

=item CoreDefinitionId => Str

=item [AmznClientToken => Str]

=item [Cores => ArrayRef[L<Paws::Greengrass::Core>]]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateCoreDefinitionVersion>

Returns: a L<Paws::Greengrass::CreateCoreDefinitionVersionResponse> instance

Creates a version of a core definition that has already been defined.
AWS Greengrass groups must each contain exactly one AWS Greengrass
core.


=head2 CreateDeployment

=over

=item GroupId => Str

=item [AmznClientToken => Str]

=item [DeploymentId => Str]

=item [DeploymentType => Str]

=item [GroupVersionId => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateDeployment>

Returns: a L<Paws::Greengrass::CreateDeploymentResponse> instance

Creates a deployment.


=head2 CreateDeviceDefinition

=over

=item [AmznClientToken => Str]

=item [InitialVersion => L<Paws::Greengrass::DeviceDefinitionVersion>]

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateDeviceDefinition>

Returns: a L<Paws::Greengrass::CreateDeviceDefinitionResponse> instance

Creates a device definition. You may provide the initial version of the
device definition now or use ''CreateDeviceDefinitionVersion'' at a
later time.


=head2 CreateDeviceDefinitionVersion

=over

=item DeviceDefinitionId => Str

=item [AmznClientToken => Str]

=item [Devices => ArrayRef[L<Paws::Greengrass::Device>]]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateDeviceDefinitionVersion>

Returns: a L<Paws::Greengrass::CreateDeviceDefinitionVersionResponse> instance

Creates a version of a device definition that has already been defined.


=head2 CreateFunctionDefinition

=over

=item [AmznClientToken => Str]

=item [InitialVersion => L<Paws::Greengrass::FunctionDefinitionVersion>]

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateFunctionDefinition>

Returns: a L<Paws::Greengrass::CreateFunctionDefinitionResponse> instance

Creates a Lambda function definition which contains a list of Lambda
functions and their configurations to be used in a group. You can
create an initial version of the definition by providing a list of
Lambda functions and their configurations now, or use
''CreateFunctionDefinitionVersion'' later.


=head2 CreateFunctionDefinitionVersion

=over

=item FunctionDefinitionId => Str

=item [AmznClientToken => Str]

=item [Functions => ArrayRef[L<Paws::Greengrass::Function>]]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateFunctionDefinitionVersion>

Returns: a L<Paws::Greengrass::CreateFunctionDefinitionVersionResponse> instance

Creates a version of a Lambda function definition that has already been
defined.


=head2 CreateGroup

=over

=item [AmznClientToken => Str]

=item [InitialVersion => L<Paws::Greengrass::GroupVersion>]

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateGroup>

Returns: a L<Paws::Greengrass::CreateGroupResponse> instance

Creates a group. You may provide the initial version of the group or
use ''CreateGroupVersion'' at a later time.


=head2 CreateGroupCertificateAuthority

=over

=item GroupId => Str

=item [AmznClientToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateGroupCertificateAuthority>

Returns: a L<Paws::Greengrass::CreateGroupCertificateAuthorityResponse> instance

Creates a CA for the group. If a CA already exists, it will rotate the
existing CA.


=head2 CreateGroupVersion

=over

=item GroupId => Str

=item [AmznClientToken => Str]

=item [CoreDefinitionVersionArn => Str]

=item [DeviceDefinitionVersionArn => Str]

=item [FunctionDefinitionVersionArn => Str]

=item [LoggerDefinitionVersionArn => Str]

=item [ResourceDefinitionVersionArn => Str]

=item [SubscriptionDefinitionVersionArn => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateGroupVersion>

Returns: a L<Paws::Greengrass::CreateGroupVersionResponse> instance

Creates a version of a group which has already been defined.


=head2 CreateLoggerDefinition

=over

=item [AmznClientToken => Str]

=item [InitialVersion => L<Paws::Greengrass::LoggerDefinitionVersion>]

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateLoggerDefinition>

Returns: a L<Paws::Greengrass::CreateLoggerDefinitionResponse> instance

Creates a logger definition. You may provide the initial version of the
logger definition now or use ''CreateLoggerDefinitionVersion'' at a
later time.


=head2 CreateLoggerDefinitionVersion

=over

=item LoggerDefinitionId => Str

=item [AmznClientToken => Str]

=item [Loggers => ArrayRef[L<Paws::Greengrass::Logger>]]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateLoggerDefinitionVersion>

Returns: a L<Paws::Greengrass::CreateLoggerDefinitionVersionResponse> instance

Creates a version of a logger definition that has already been defined.


=head2 CreateResourceDefinition

=over

=item [AmznClientToken => Str]

=item [InitialVersion => L<Paws::Greengrass::ResourceDefinitionVersion>]

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateResourceDefinition>

Returns: a L<Paws::Greengrass::CreateResourceDefinitionResponse> instance

Creates a resource definition which contains a list of resources to be
used in a group. You can create an initial version of the definition by
providing a list of resources now, or use
''CreateResourceDefinitionVersion'' later.


=head2 CreateResourceDefinitionVersion

=over

=item ResourceDefinitionId => Str

=item [AmznClientToken => Str]

=item [Resources => ArrayRef[L<Paws::Greengrass::Resource>]]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateResourceDefinitionVersion>

Returns: a L<Paws::Greengrass::CreateResourceDefinitionVersionResponse> instance

Creates a version of a resource definition that has already been
defined.


=head2 CreateSoftwareUpdateJob

=over

=item [AmznClientToken => Str]

=item [S3UrlSignerRole => Str]

=item [SoftwareToUpdate => Str]

=item [UpdateAgentLogLevel => Str]

=item [UpdateTargets => ArrayRef[Str|Undef]]

=item [UpdateTargetsArchitecture => Str]

=item [UpdateTargetsOperatingSystem => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateSoftwareUpdateJob>

Returns: a L<Paws::Greengrass::CreateSoftwareUpdateJobResponse> instance

Creates a software update for a core or group of cores (specified as an
IoT thing group.) Use this to update the OTA Agent as well as the
Greengrass core software. It makes use of the IoT Jobs feature which
provides additional commands to manage a Greengrass core software
update job.


=head2 CreateSubscriptionDefinition

=over

=item [AmznClientToken => Str]

=item [InitialVersion => L<Paws::Greengrass::SubscriptionDefinitionVersion>]

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateSubscriptionDefinition>

Returns: a L<Paws::Greengrass::CreateSubscriptionDefinitionResponse> instance

Creates a subscription definition. You may provide the initial version
of the subscription definition now or use
''CreateSubscriptionDefinitionVersion'' at a later time.


=head2 CreateSubscriptionDefinitionVersion

=over

=item SubscriptionDefinitionId => Str

=item [AmznClientToken => Str]

=item [Subscriptions => ArrayRef[L<Paws::Greengrass::Subscription>]]


=back

Each argument is described in detail in: L<Paws::Greengrass::CreateSubscriptionDefinitionVersion>

Returns: a L<Paws::Greengrass::CreateSubscriptionDefinitionVersionResponse> instance

Creates a version of a subscription definition which has already been
defined.


=head2 DeleteCoreDefinition

=over

=item CoreDefinitionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::DeleteCoreDefinition>

Returns: a L<Paws::Greengrass::DeleteCoreDefinitionResponse> instance

Deletes a core definition.


=head2 DeleteDeviceDefinition

=over

=item DeviceDefinitionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::DeleteDeviceDefinition>

Returns: a L<Paws::Greengrass::DeleteDeviceDefinitionResponse> instance

Deletes a device definition.


=head2 DeleteFunctionDefinition

=over

=item FunctionDefinitionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::DeleteFunctionDefinition>

Returns: a L<Paws::Greengrass::DeleteFunctionDefinitionResponse> instance

Deletes a Lambda function definition.


=head2 DeleteGroup

=over

=item GroupId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::DeleteGroup>

Returns: a L<Paws::Greengrass::DeleteGroupResponse> instance

Deletes a group.


=head2 DeleteLoggerDefinition

=over

=item LoggerDefinitionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::DeleteLoggerDefinition>

Returns: a L<Paws::Greengrass::DeleteLoggerDefinitionResponse> instance

Deletes a logger definition.


=head2 DeleteResourceDefinition

=over

=item ResourceDefinitionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::DeleteResourceDefinition>

Returns: a L<Paws::Greengrass::DeleteResourceDefinitionResponse> instance

Deletes a resource definition.


=head2 DeleteSubscriptionDefinition

=over

=item SubscriptionDefinitionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::DeleteSubscriptionDefinition>

Returns: a L<Paws::Greengrass::DeleteSubscriptionDefinitionResponse> instance

Deletes a subscription definition.


=head2 DisassociateRoleFromGroup

=over

=item GroupId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::DisassociateRoleFromGroup>

Returns: a L<Paws::Greengrass::DisassociateRoleFromGroupResponse> instance

Disassociates the role from a group.


=head2 DisassociateServiceRoleFromAccount






Each argument is described in detail in: L<Paws::Greengrass::DisassociateServiceRoleFromAccount>

Returns: a L<Paws::Greengrass::DisassociateServiceRoleFromAccountResponse> instance

Disassociates the service role from your account. Without a service
role, deployments will not work.


=head2 GetAssociatedRole

=over

=item GroupId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetAssociatedRole>

Returns: a L<Paws::Greengrass::GetAssociatedRoleResponse> instance

Retrieves the role associated with a particular group.


=head2 GetConnectivityInfo

=over

=item ThingName => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetConnectivityInfo>

Returns: a L<Paws::Greengrass::GetConnectivityInfoResponse> instance

Retrieves the connectivity information for a core.


=head2 GetCoreDefinition

=over

=item CoreDefinitionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetCoreDefinition>

Returns: a L<Paws::Greengrass::GetCoreDefinitionResponse> instance

Retrieves information about a core definition version.


=head2 GetCoreDefinitionVersion

=over

=item CoreDefinitionId => Str

=item CoreDefinitionVersionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetCoreDefinitionVersion>

Returns: a L<Paws::Greengrass::GetCoreDefinitionVersionResponse> instance

Retrieves information about a core definition version.


=head2 GetDeploymentStatus

=over

=item DeploymentId => Str

=item GroupId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetDeploymentStatus>

Returns: a L<Paws::Greengrass::GetDeploymentStatusResponse> instance

Returns the status of a deployment.


=head2 GetDeviceDefinition

=over

=item DeviceDefinitionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetDeviceDefinition>

Returns: a L<Paws::Greengrass::GetDeviceDefinitionResponse> instance

Retrieves information about a device definition.


=head2 GetDeviceDefinitionVersion

=over

=item DeviceDefinitionId => Str

=item DeviceDefinitionVersionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetDeviceDefinitionVersion>

Returns: a L<Paws::Greengrass::GetDeviceDefinitionVersionResponse> instance

Retrieves information about a device definition version.


=head2 GetFunctionDefinition

=over

=item FunctionDefinitionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetFunctionDefinition>

Returns: a L<Paws::Greengrass::GetFunctionDefinitionResponse> instance

Retrieves information about a Lambda function definition, including its
creation time and latest version.


=head2 GetFunctionDefinitionVersion

=over

=item FunctionDefinitionId => Str

=item FunctionDefinitionVersionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetFunctionDefinitionVersion>

Returns: a L<Paws::Greengrass::GetFunctionDefinitionVersionResponse> instance

Retrieves information about a Lambda function definition version,
including which Lambda functions are included in the version and their
configurations.


=head2 GetGroup

=over

=item GroupId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetGroup>

Returns: a L<Paws::Greengrass::GetGroupResponse> instance

Retrieves information about a group.


=head2 GetGroupCertificateAuthority

=over

=item CertificateAuthorityId => Str

=item GroupId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetGroupCertificateAuthority>

Returns: a L<Paws::Greengrass::GetGroupCertificateAuthorityResponse> instance

Retreives the CA associated with a group. Returns the public key of the
CA.


=head2 GetGroupCertificateConfiguration

=over

=item GroupId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetGroupCertificateConfiguration>

Returns: a L<Paws::Greengrass::GetGroupCertificateConfigurationResponse> instance

Retrieves the current configuration for the CA used by the group.


=head2 GetGroupVersion

=over

=item GroupId => Str

=item GroupVersionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetGroupVersion>

Returns: a L<Paws::Greengrass::GetGroupVersionResponse> instance

Retrieves information about a group version.


=head2 GetLoggerDefinition

=over

=item LoggerDefinitionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetLoggerDefinition>

Returns: a L<Paws::Greengrass::GetLoggerDefinitionResponse> instance

Retrieves information about a logger definition.


=head2 GetLoggerDefinitionVersion

=over

=item LoggerDefinitionId => Str

=item LoggerDefinitionVersionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetLoggerDefinitionVersion>

Returns: a L<Paws::Greengrass::GetLoggerDefinitionVersionResponse> instance

Retrieves information about a logger definition version.


=head2 GetResourceDefinition

=over

=item ResourceDefinitionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetResourceDefinition>

Returns: a L<Paws::Greengrass::GetResourceDefinitionResponse> instance

Retrieves information about a resource definition, including its
creation time and latest version.


=head2 GetResourceDefinitionVersion

=over

=item ResourceDefinitionId => Str

=item ResourceDefinitionVersionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetResourceDefinitionVersion>

Returns: a L<Paws::Greengrass::GetResourceDefinitionVersionResponse> instance

Retrieves information about a resource definition version, including
which resources are included in the version.


=head2 GetServiceRoleForAccount






Each argument is described in detail in: L<Paws::Greengrass::GetServiceRoleForAccount>

Returns: a L<Paws::Greengrass::GetServiceRoleForAccountResponse> instance

Retrieves the service role that is attached to your account.


=head2 GetSubscriptionDefinition

=over

=item SubscriptionDefinitionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetSubscriptionDefinition>

Returns: a L<Paws::Greengrass::GetSubscriptionDefinitionResponse> instance

Retrieves information about a subscription definition.


=head2 GetSubscriptionDefinitionVersion

=over

=item SubscriptionDefinitionId => Str

=item SubscriptionDefinitionVersionId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::GetSubscriptionDefinitionVersion>

Returns: a L<Paws::Greengrass::GetSubscriptionDefinitionVersionResponse> instance

Retrieves information about a subscription definition version.


=head2 ListCoreDefinitions

=over

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListCoreDefinitions>

Returns: a L<Paws::Greengrass::ListCoreDefinitionsResponse> instance

Retrieves a list of core definitions.


=head2 ListCoreDefinitionVersions

=over

=item CoreDefinitionId => Str

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListCoreDefinitionVersions>

Returns: a L<Paws::Greengrass::ListCoreDefinitionVersionsResponse> instance

Lists the versions of a core definition.


=head2 ListDeployments

=over

=item GroupId => Str

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListDeployments>

Returns: a L<Paws::Greengrass::ListDeploymentsResponse> instance

Returns a history of deployments for the group.


=head2 ListDeviceDefinitions

=over

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListDeviceDefinitions>

Returns: a L<Paws::Greengrass::ListDeviceDefinitionsResponse> instance

Retrieves a list of device definitions.


=head2 ListDeviceDefinitionVersions

=over

=item DeviceDefinitionId => Str

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListDeviceDefinitionVersions>

Returns: a L<Paws::Greengrass::ListDeviceDefinitionVersionsResponse> instance

Lists the versions of a device definition.


=head2 ListFunctionDefinitions

=over

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListFunctionDefinitions>

Returns: a L<Paws::Greengrass::ListFunctionDefinitionsResponse> instance

Retrieves a list of Lambda function definitions.


=head2 ListFunctionDefinitionVersions

=over

=item FunctionDefinitionId => Str

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListFunctionDefinitionVersions>

Returns: a L<Paws::Greengrass::ListFunctionDefinitionVersionsResponse> instance

Lists the versions of a Lambda function definition.


=head2 ListGroupCertificateAuthorities

=over

=item GroupId => Str


=back

Each argument is described in detail in: L<Paws::Greengrass::ListGroupCertificateAuthorities>

Returns: a L<Paws::Greengrass::ListGroupCertificateAuthoritiesResponse> instance

Retrieves the current CAs for a group.


=head2 ListGroups

=over

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListGroups>

Returns: a L<Paws::Greengrass::ListGroupsResponse> instance

Retrieves a list of groups.


=head2 ListGroupVersions

=over

=item GroupId => Str

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListGroupVersions>

Returns: a L<Paws::Greengrass::ListGroupVersionsResponse> instance

Lists the versions of a group.


=head2 ListLoggerDefinitions

=over

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListLoggerDefinitions>

Returns: a L<Paws::Greengrass::ListLoggerDefinitionsResponse> instance

Retrieves a list of logger definitions.


=head2 ListLoggerDefinitionVersions

=over

=item LoggerDefinitionId => Str

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListLoggerDefinitionVersions>

Returns: a L<Paws::Greengrass::ListLoggerDefinitionVersionsResponse> instance

Lists the versions of a logger definition.


=head2 ListResourceDefinitions

=over

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListResourceDefinitions>

Returns: a L<Paws::Greengrass::ListResourceDefinitionsResponse> instance

Retrieves a list of resource definitions.


=head2 ListResourceDefinitionVersions

=over

=item ResourceDefinitionId => Str

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListResourceDefinitionVersions>

Returns: a L<Paws::Greengrass::ListResourceDefinitionVersionsResponse> instance

Lists the versions of a resource definition.


=head2 ListSubscriptionDefinitions

=over

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListSubscriptionDefinitions>

Returns: a L<Paws::Greengrass::ListSubscriptionDefinitionsResponse> instance

Retrieves a list of subscription definitions.


=head2 ListSubscriptionDefinitionVersions

=over

=item SubscriptionDefinitionId => Str

=item [MaxResults => Str]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::ListSubscriptionDefinitionVersions>

Returns: a L<Paws::Greengrass::ListSubscriptionDefinitionVersionsResponse> instance

Lists the versions of a subscription definition.


=head2 ResetDeployments

=over

=item GroupId => Str

=item [AmznClientToken => Str]

=item [Force => Bool]


=back

Each argument is described in detail in: L<Paws::Greengrass::ResetDeployments>

Returns: a L<Paws::Greengrass::ResetDeploymentsResponse> instance

Resets a group's deployments.


=head2 UpdateConnectivityInfo

=over

=item ThingName => Str

=item [ConnectivityInfo => ArrayRef[L<Paws::Greengrass::ConnectivityInfo>]]


=back

Each argument is described in detail in: L<Paws::Greengrass::UpdateConnectivityInfo>

Returns: a L<Paws::Greengrass::UpdateConnectivityInfoResponse> instance

Updates the connectivity information for the core. Any devices that
belong to the group which has this core will receive this information
in order to find the location of the core and connect to it.


=head2 UpdateCoreDefinition

=over

=item CoreDefinitionId => Str

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::UpdateCoreDefinition>

Returns: a L<Paws::Greengrass::UpdateCoreDefinitionResponse> instance

Updates a core definition.


=head2 UpdateDeviceDefinition

=over

=item DeviceDefinitionId => Str

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::UpdateDeviceDefinition>

Returns: a L<Paws::Greengrass::UpdateDeviceDefinitionResponse> instance

Updates a device definition.


=head2 UpdateFunctionDefinition

=over

=item FunctionDefinitionId => Str

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::UpdateFunctionDefinition>

Returns: a L<Paws::Greengrass::UpdateFunctionDefinitionResponse> instance

Updates a Lambda function definition.


=head2 UpdateGroup

=over

=item GroupId => Str

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::UpdateGroup>

Returns: a L<Paws::Greengrass::UpdateGroupResponse> instance

Updates a group.


=head2 UpdateGroupCertificateConfiguration

=over

=item GroupId => Str

=item [CertificateExpiryInMilliseconds => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::UpdateGroupCertificateConfiguration>

Returns: a L<Paws::Greengrass::UpdateGroupCertificateConfigurationResponse> instance

Updates the Certificate expiry time for a group.


=head2 UpdateLoggerDefinition

=over

=item LoggerDefinitionId => Str

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::UpdateLoggerDefinition>

Returns: a L<Paws::Greengrass::UpdateLoggerDefinitionResponse> instance

Updates a logger definition.


=head2 UpdateResourceDefinition

=over

=item ResourceDefinitionId => Str

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::UpdateResourceDefinition>

Returns: a L<Paws::Greengrass::UpdateResourceDefinitionResponse> instance

Updates a resource definition.


=head2 UpdateSubscriptionDefinition

=over

=item SubscriptionDefinitionId => Str

=item [Name => Str]


=back

Each argument is described in detail in: L<Paws::Greengrass::UpdateSubscriptionDefinition>

Returns: a L<Paws::Greengrass::UpdateSubscriptionDefinitionResponse> instance

Updates a subscription definition.




=head1 PAGINATORS

Paginator methods are helpers that repetively call methods that return partial results




=head1 SEE ALSO

This service class forms part of L<Paws>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


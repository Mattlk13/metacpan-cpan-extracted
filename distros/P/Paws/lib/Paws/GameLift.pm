package Paws::GameLift;
  use Moose;
  sub service { 'gamelift' }
  sub version { '2015-10-01' }
  sub target_prefix { 'GameLift' }
  sub json_version { "1.1" }
  has max_attempts => (is => 'ro', isa => 'Int', default => 5);
  has retry => (is => 'ro', isa => 'HashRef', default => sub {
    { base => 'rand', type => 'exponential', growth_factor => 2 }
  });
  has retriables => (is => 'ro', isa => 'ArrayRef', default => sub { [
  ] });

  with 'Paws::API::Caller', 'Paws::API::EndpointResolver', 'Paws::Net::V4Signature', 'Paws::Net::JsonCaller', 'Paws::Net::JsonResponse';

  
  sub CreateAlias {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::CreateAlias', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateBuild {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::CreateBuild', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateFleet {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::CreateFleet', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateGameSession {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::CreateGameSession', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateGameSessionQueue {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::CreateGameSessionQueue', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreatePlayerSession {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::CreatePlayerSession', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreatePlayerSessions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::CreatePlayerSessions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteAlias {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DeleteAlias', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteBuild {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DeleteBuild', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteFleet {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DeleteFleet', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteGameSessionQueue {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DeleteGameSessionQueue', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteScalingPolicy {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DeleteScalingPolicy', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeAlias {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeAlias', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeBuild {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeBuild', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeEC2InstanceLimits {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeEC2InstanceLimits', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeFleetAttributes {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeFleetAttributes', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeFleetCapacity {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeFleetCapacity', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeFleetEvents {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeFleetEvents', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeFleetPortSettings {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeFleetPortSettings', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeFleetUtilization {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeFleetUtilization', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeGameSessionDetails {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeGameSessionDetails', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeGameSessionPlacement {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeGameSessionPlacement', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeGameSessionQueues {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeGameSessionQueues', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeGameSessions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeGameSessions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeInstances {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeInstances', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribePlayerSessions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribePlayerSessions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeRuntimeConfiguration {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeRuntimeConfiguration', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeScalingPolicies {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::DescribeScalingPolicies', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetGameSessionLogUrl {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::GetGameSessionLogUrl', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetInstanceAccess {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::GetInstanceAccess', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListAliases {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::ListAliases', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListBuilds {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::ListBuilds', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListFleets {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::ListFleets', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub PutScalingPolicy {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::PutScalingPolicy', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub RequestUploadCredentials {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::RequestUploadCredentials', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ResolveAlias {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::ResolveAlias', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub SearchGameSessions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::SearchGameSessions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub StartGameSessionPlacement {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::StartGameSessionPlacement', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub StopGameSessionPlacement {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::StopGameSessionPlacement', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateAlias {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::UpdateAlias', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateBuild {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::UpdateBuild', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateFleetAttributes {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::UpdateFleetAttributes', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateFleetCapacity {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::UpdateFleetCapacity', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateFleetPortSettings {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::UpdateFleetPortSettings', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateGameSession {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::UpdateGameSession', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateGameSessionQueue {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::UpdateGameSessionQueue', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateRuntimeConfiguration {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::GameLift::UpdateRuntimeConfiguration', @_);
    return $self->caller->do_call($self, $call_object);
  }
  


  sub operations { qw/CreateAlias CreateBuild CreateFleet CreateGameSession CreateGameSessionQueue CreatePlayerSession CreatePlayerSessions DeleteAlias DeleteBuild DeleteFleet DeleteGameSessionQueue DeleteScalingPolicy DescribeAlias DescribeBuild DescribeEC2InstanceLimits DescribeFleetAttributes DescribeFleetCapacity DescribeFleetEvents DescribeFleetPortSettings DescribeFleetUtilization DescribeGameSessionDetails DescribeGameSessionPlacement DescribeGameSessionQueues DescribeGameSessions DescribeInstances DescribePlayerSessions DescribeRuntimeConfiguration DescribeScalingPolicies GetGameSessionLogUrl GetInstanceAccess ListAliases ListBuilds ListFleets PutScalingPolicy RequestUploadCredentials ResolveAlias SearchGameSessions StartGameSessionPlacement StopGameSessionPlacement UpdateAlias UpdateBuild UpdateFleetAttributes UpdateFleetCapacity UpdateFleetPortSettings UpdateGameSession UpdateGameSessionQueue UpdateRuntimeConfiguration / }

1;

### main pod documentation begin ###

=head1 NAME

Paws::GameLift - Perl Interface to AWS Amazon GameLift

=head1 SYNOPSIS

  use Paws;

  my $obj = Paws->service('GameLift');
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

Amazon GameLift Service

Amazon GameLift is a managed service for developers who need a
scalable, dedicated server solution for their multiplayer games. Amazon
GameLift provides tools for the following tasks: (1) acquire computing
resources and deploy game servers, (2) scale game server capacity to
meet player demand, (3) host game sessions and manage player access,
and (4) track in-depth metrics on player usage and server performance.

The Amazon GameLift service API includes two important function sets:

=over

=item *

B<Manage game sessions and player access> E<ndash> Retrieve information
on available game sessions; create new game sessions; send player
requests to join a game session.

=item *

B<Configure and manage game server resources> E<ndash> Manage builds,
fleets, queues, and aliases; set autoscaling policies; retrieve logs
and metrics.

=back

This reference guide describes the low-level service API for Amazon
GameLift. You can use the API functionality with these tools:

=over

=item *

The Amazon Web Services software development kit (AWS SDK) is available
in multiple languages including C++ and C#. Use the SDK to access the
API programmatically from an application, such as a game client.

=item *

The AWS command-line interface (CLI) tool is primarily useful for
handling administrative actions, such as setting up and managing Amazon
GameLift settings and resources. You can use the AWS CLI to manage all
of your AWS services.

=item *

The AWS Management Console for Amazon GameLift provides a web interface
to manage your Amazon GameLift settings and resources. The console
includes a dashboard for tracking key resources, includings builds and
fleets, and displays usage and performance metrics for your games as
customizable graphs.

=item *

Amazon GameLift Local is a tool for testing your game's integration
with Amazon GameLift before deploying it on the service. This tools
supports a subset of key API actions, which can be called from either
the AWS CLI or programmatically. See Testing an Integration.

=back

B<MORE RESOURCES>

=over

=item *

Amazon GameLift Developer Guide E<ndash> Learn more about Amazon
GameLift features and how to use them.

=item *

Lumberyard and Amazon GameLift Tutorials E<ndash> Get started fast with
walkthroughs and sample projects.

=item *

GameDev Blog E<ndash> Stay up to date with new features and techniques.

=item *

GameDev Forums E<ndash> Connect with the GameDev community.

=item *

Amazon GameLift Document History E<ndash> See changes to the Amazon
GameLift service, SDKs, and documentation, as well as links to release
notes.

=back

B<API SUMMARY>

This list offers a functional overview of the Amazon GameLift service
API.

B<Managing Games and Players>

These actions allow you to start new game sessions, find existing game
sessions, track status and other game session information, and enable
access for players to join game sessions.

=over

=item *

B<Discover existing game sessions>

=over

=item *

SearchGameSessions E<ndash> Get all available game sessions or search
for game sessions that match a set of criteria.

=back

=item *

B<Start a new game session>

=over

=item *

Game session placement E<ndash> Use a queue to process requests for new
game sessions and place them on the best available fleet. Placement
requests are asynchronous; game sessions are started whenever
acceptable resources become available.

=over

=item *

StartGameSessionPlacement E<ndash> Request a new game session placement
and add one or more players to it.

=item *

DescribeGameSessionPlacement E<ndash> Get details on a placement
request, including status.

=item *

StopGameSessionPlacement E<ndash> Cancel a placement request.

=back

=item *

CreateGameSession E<ndash> Request a new game session on a specific
fleet. I<Available in Amazon GameLift Local.>

=back

=item *

B<Manage game session data>

=over

=item *

DescribeGameSessions E<ndash> Retrieve metadata for one or more game
sessions, including length of time active and current player count.
I<Available in Amazon GameLift Local.>

=item *

DescribeGameSessionDetails E<ndash> Retrieve metadata and the game
session protection setting for one or more game sessions.

=item *

UpdateGameSession E<ndash> Change game session settings, such as
maximum player count and join policy.

=item *

GetGameSessionLogUrl E<ndash> Get the location of saved logs for a game
session.

=back

=item *

B<Manage player sessions>

=over

=item *

CreatePlayerSession E<ndash> Send a request for a player to join a game
session. I<Available in Amazon GameLift Local.>

=item *

CreatePlayerSessions E<ndash> Send a request for multiple players to
join a game session. I<Available in Amazon GameLift Local.>

=item *

DescribePlayerSessions E<ndash> Get details on player activity,
including status, playing time, and player data. I<Available in Amazon
GameLift Local.>

=back

=back

B<Setting Up and Managing Game Servers>

When setting up Amazon GameLift resources for your game, you first
create a game build and upload it to Amazon GameLift. You can then use
these actions to configure and manage a fleet of resources to run your
game servers, scale capacity to meet player demand, access performance
and utilization metrics, and more.

=over

=item *

B<Manage game builds>

=over

=item *

CreateBuild E<ndash> Create a new build using files stored in an Amazon
S3 bucket. (Update uploading permissions with
RequestUploadCredentials.) To create a build and upload files from a
local path, use the AWS CLI command C<upload-build>.

=item *

ListBuilds E<ndash> Get a list of all builds uploaded to a Amazon
GameLift region.

=item *

DescribeBuild E<ndash> Retrieve information associated with a build.

=item *

UpdateBuild E<ndash> Change build metadata, including build name and
version.

=item *

DeleteBuild E<ndash> Remove a build from Amazon GameLift.

=back

=item *

B<Manage fleets>

=over

=item *

CreateFleet E<ndash> Configure and activate a new fleet to run a
build's game servers.

=item *

ListFleets E<ndash> Get a list of all fleet IDs in a Amazon GameLift
region (all statuses).

=item *

DeleteFleet E<ndash> Terminate a fleet that is no longer running game
servers or hosting players.

=item *

View / update fleet configurations.

=over

=item *

DescribeFleetAttributes / UpdateFleetAttributes E<ndash> View or change
a fleet's metadata and settings for game session protection and
resource creation limits.

=item *

DescribeFleetPortSettings / UpdateFleetPortSettings E<ndash> View or
change the inbound permissions (IP address and port setting ranges)
allowed for a fleet.

=item *

DescribeRuntimeConfiguration / UpdateRuntimeConfiguration E<ndash> View
or change what server processes (and how many) to run on each instance
in a fleet.

=back

=back

=item *

B<Control fleet capacity>

=over

=item *

DescribeEC2InstanceLimits E<ndash> Retrieve maximum number of instances
allowed for the current AWS account and the current usage level.

=item *

DescribeFleetCapacity / UpdateFleetCapacity E<ndash> Retrieve the
capacity settings and the current number of instances in a fleet;
adjust fleet capacity settings to scale up or down.

=item *

Autoscale E<ndash> Manage autoscaling rules and apply them to a fleet.

=over

=item *

PutScalingPolicy E<ndash> Create a new autoscaling policy, or update an
existing one.

=item *

DescribeScalingPolicies E<ndash> Retrieve an existing autoscaling
policy.

=item *

DeleteScalingPolicy E<ndash> Delete an autoscaling policy and stop it
from affecting a fleet's capacity.

=back

=back

=item *

B<Access fleet activity statistics>

=over

=item *

DescribeFleetUtilization E<ndash> Get current data on the number of
server processes, game sessions, and players currently active on a
fleet.

=item *

DescribeFleetEvents E<ndash> Get a fleet's logged events for a
specified time span.

=item *

DescribeGameSessions E<ndash> Retrieve metadata associated with one or
more game sessions, including length of time active and current player
count.

=back

=item *

B<Remotely access an instance>

=over

=item *

DescribeInstances E<ndash> Get information on each instance in a fleet,
including instance ID, IP address, and status.

=item *

GetInstanceAccess E<ndash> Request access credentials needed to
remotely connect to a specified instance in a fleet.

=back

=item *

B<Manage fleet aliases>

=over

=item *

CreateAlias E<ndash> Define a new alias and optionally assign it to a
fleet.

=item *

ListAliases E<ndash> Get all fleet aliases defined in a Amazon GameLift
region.

=item *

DescribeAlias E<ndash> Retrieve information on an existing alias.

=item *

UpdateAlias E<ndash> Change settings for a alias, such as redirecting
it from one fleet to another.

=item *

DeleteAlias E<ndash> Remove an alias from the region.

=item *

ResolveAlias E<ndash> Get the fleet ID that a specified alias points
to.

=back

=item *

B<Manage game session queues>

=over

=item *

CreateGameSessionQueue E<ndash> Create a queue for processing requests
for new game sessions.

=item *

DescribeGameSessionQueues E<ndash> Get data on all game session queues
defined in a Amazon GameLift region.

=item *

UpdateGameSessionQueue E<ndash> Change the configuration of a game
session queue.

=item *

DeleteGameSessionQueue E<ndash> Remove a game session queue from the
region.

=back

=back


=head1 METHODS

=head2 CreateAlias(Name => Str, RoutingStrategy => L<Paws::GameLift::RoutingStrategy>, [Description => Str])

Each argument is described in detail in: L<Paws::GameLift::CreateAlias>

Returns: a L<Paws::GameLift::CreateAliasOutput> instance

  Creates an alias for a fleet. In most situations, you can use an alias
ID in place of a fleet ID. By using a fleet alias instead of a specific
fleet ID, you can switch gameplay and players to a new fleet without
changing your game client or other game components. For example, for
games in production, using an alias allows you to seamlessly redirect
your player base to a new game server update.

Amazon GameLift supports two types of routing strategies for aliases:
simple and terminal. A simple alias points to an active fleet. A
terminal alias is used to display messaging or link to a URL instead of
routing players to an active fleet. For example, you might use a
terminal alias when a game version is no longer supported and you want
to direct players to an upgrade site.

To create a fleet alias, specify an alias name, routing strategy, and
optional description. Each simple alias can point to only one fleet,
but a fleet can have multiple aliases. If successful, a new alias
record is returned, including an alias ID, which you can reference when
creating a game session. You can reassign an alias to another fleet by
calling C<UpdateAlias>.

Alias-related operations include:

=over

=item *

CreateAlias

=item *

ListAliases

=item *

DescribeAlias

=item *

UpdateAlias

=item *

DeleteAlias

=item *

ResolveAlias

=back



=head2 CreateBuild([Name => Str, OperatingSystem => Str, StorageLocation => L<Paws::GameLift::S3Location>, Version => Str])

Each argument is described in detail in: L<Paws::GameLift::CreateBuild>

Returns: a L<Paws::GameLift::CreateBuildOutput> instance

  Creates a new Amazon GameLift build from a set of game server binary
files stored in an Amazon Simple Storage Service (Amazon S3) location.
To use this API call, create a C<.zip> file containing all of the files
for the build and store it in an Amazon S3 bucket under your AWS
account. For help on packaging your build files and creating a build,
see Uploading Your Game to Amazon GameLift.

Use this API action ONLY if you are storing your game build files in an
Amazon S3 bucket. To create a build using files stored locally, use the
CLI command C<upload-build> , which uploads the build files from a file
location you specify.

To create a new build using C<CreateBuild>, identify the storage
location and operating system of your game build. You also have the
option of specifying a build name and version. If successful, this
action creates a new build record with an unique build ID and in
C<INITIALIZED> status. Use the API call DescribeBuild to check the
status of your build. A build must be in C<READY> status before it can
be used to create fleets to host your game.

Build-related operations include:

=over

=item *

CreateBuild

=item *

ListBuilds

=item *

DescribeBuild

=item *

UpdateBuild

=item *

DeleteBuild

=back



=head2 CreateFleet(BuildId => Str, EC2InstanceType => Str, Name => Str, [Description => Str, EC2InboundPermissions => ArrayRef[L<Paws::GameLift::IpPermission>], LogPaths => ArrayRef[Str|Undef], MetricGroups => ArrayRef[Str|Undef], NewGameSessionProtectionPolicy => Str, ResourceCreationLimitPolicy => L<Paws::GameLift::ResourceCreationLimitPolicy>, RuntimeConfiguration => L<Paws::GameLift::RuntimeConfiguration>, ServerLaunchParameters => Str, ServerLaunchPath => Str])

Each argument is described in detail in: L<Paws::GameLift::CreateFleet>

Returns: a L<Paws::GameLift::CreateFleetOutput> instance

  Creates a new fleet to run your game servers. A fleet is a set of
Amazon Elastic Compute Cloud (Amazon EC2) instances, each of which can
run multiple server processes to host game sessions. You configure a
fleet to create instances with certain hardware specifications (see
Amazon EC2 Instance Types for more information), and deploy a specified
game build to each instance. A newly created fleet passes through
several statuses; once it reaches the C<ACTIVE> status, it can begin
hosting game sessions.

To create a new fleet, you must specify the following: (1) fleet name,
(2) build ID of an uploaded game build, (3) an EC2 instance type, and
(4) a run-time configuration that describes which server processes to
run on each instance in the fleet. (Although the run-time configuration
is not a required parameter, the fleet cannot be successfully activated
without it.)

You can also configure the new fleet with the following settings:

=over

=item *

Fleet description

=item *

Access permissions for inbound traffic

=item *

Fleetwide game session protection

=item *

Resource creation limit

=back

If you use Amazon CloudWatch for metrics, you can add the new fleet to
a metric group. This allows you to view aggregated metrics for a set of
fleets. Once you specify a metric group, the new fleet's metrics are
included in the metric group's data.

If the CreateFleet call is successful, Amazon GameLift performs the
following tasks:

=over

=item *

Creates a fleet record and sets the status to C<NEW> (followed by other
statuses as the fleet is activated).

=item *

Sets the fleet's target capacity to 1 (desired instances), which causes
Amazon GameLift to start one new EC2 instance.

=item *

Starts launching server processes on the instance. If the fleet is
configured to run multiple server processes per instance, Amazon
GameLift staggers each launch by a few seconds.

=item *

Begins writing events to the fleet event log, which can be accessed in
the Amazon GameLift console.

=item *

Sets the fleet's status to C<ACTIVE> as soon as one server process in
the fleet is ready to host a game session.

=back

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 CreateGameSession(MaximumPlayerSessionCount => Int, [AliasId => Str, CreatorId => Str, FleetId => Str, GameProperties => ArrayRef[L<Paws::GameLift::GameProperty>], GameSessionId => Str, IdempotencyToken => Str, Name => Str])

Each argument is described in detail in: L<Paws::GameLift::CreateGameSession>

Returns: a L<Paws::GameLift::CreateGameSessionOutput> instance

  Creates a multiplayer game session for players. This action creates a
game session record and assigns an available server process in the
specified fleet to host the game session. A fleet must have an
C<ACTIVE> status before a game session can be created in it.

To create a game session, specify either fleet ID or alias ID and
indicate a maximum number of players to allow in the game session. You
can also provide a name and game-specific properties for this game
session. If successful, a GameSession object is returned containing
game session properties, including a game session ID with the custom
string you provided.

B<Idempotency tokens.> You can add a token that uniquely identifies
game session requests. This is useful for ensuring that game session
requests are idempotent. Multiple requests with the same idempotency
token are processed only once; subsequent requests return the original
result. All response values are the same with the exception of game
session status, which may change.

B<Resource creation limits.> If you are creating a game session on a
fleet with a resource creation limit policy in force, then you must
specify a creator ID. Without this ID, Amazon GameLift has no way to
evaluate the policy for this new game session request.

By default, newly created game sessions allow new players to join. Use
UpdateGameSession to change the game session's player session creation
policy.

I<Available in Amazon GameLift Local.>

Game-session-related operations include:

=over

=item *

CreateGameSession

=item *

DescribeGameSessions

=item *

DescribeGameSessionDetails

=item *

SearchGameSessions

=item *

UpdateGameSession

=item *

GetGameSessionLogUrl

=item *

Game session placements

=over

=item *

StartGameSessionPlacement

=item *

DescribeGameSessionPlacement

=item *

StopGameSessionPlacement

=back

=back



=head2 CreateGameSessionQueue(Name => Str, [Destinations => ArrayRef[L<Paws::GameLift::GameSessionQueueDestination>], PlayerLatencyPolicies => ArrayRef[L<Paws::GameLift::PlayerLatencyPolicy>], TimeoutInSeconds => Int])

Each argument is described in detail in: L<Paws::GameLift::CreateGameSessionQueue>

Returns: a L<Paws::GameLift::CreateGameSessionQueueOutput> instance

  Establishes a new queue for processing requests to place new game
sessions. A queue identifies where new game sessions can be hosted --
by specifying a list of destinations (fleets or aliases) -- and how
long requests can wait in the queue before timing out. You can set up a
queue to try to place game sessions on fleets in multiple regions. To
add placement requests to a queue, call StartGameSessionPlacement and
reference the queue name.

B<Destination order.> When processing a request for a game session,
Amazon GameLift tries each destination in order until it finds one with
available resources to host the new game session. A queue's default
order is determined by how destinations are listed. The default order
is overridden when a game session placement request provides player
latency information. Player latency information enables Amazon GameLift
to prioritize destinations where players report the lowest average
latency, as a result placing the new game session where the majority of
players will have the best possible gameplay experience.

B<Player latency policies.> For placement requests containing player
latency information, use player latency policies to protect individual
players from very high latencies. With a latency cap, even when a
destination can deliver a low latency for most players, the game is not
placed where any individual player is reporting latency higher than a
policy's maximum. A queue can have multiple latency policies, which are
enforced consecutively starting with the policy with the lowest latency
cap. Use multiple policies to gradually relax latency controls; for
example, you might set a policy with a low latency cap for the first 60
seconds, a second policy with a higher cap for the next 60 seconds,
etc.

To create a new queue, provide a name, timeout value, a list of
destinations and, if desired, a set of latency policies. If successful,
a new queue object is returned.

Queue-related operations include:

=over

=item *

CreateGameSessionQueue

=item *

DescribeGameSessionQueues

=item *

UpdateGameSessionQueue

=item *

DeleteGameSessionQueue

=back



=head2 CreatePlayerSession(GameSessionId => Str, PlayerId => Str, [PlayerData => Str])

Each argument is described in detail in: L<Paws::GameLift::CreatePlayerSession>

Returns: a L<Paws::GameLift::CreatePlayerSessionOutput> instance

  Adds a player to a game session and creates a player session record.
Before a player can be added, a game session must have an C<ACTIVE>
status, have a creation policy of C<ALLOW_ALL>, and have an open player
slot. To add a group of players to a game session, use
CreatePlayerSessions.

To create a player session, specify a game session ID, player ID, and
optionally a string of player data. If successful, the player is added
to the game session and a new PlayerSession object is returned. Player
sessions cannot be updated.

I<Available in Amazon GameLift Local.>

Player-session-related operations include:

=over

=item *

CreatePlayerSession

=item *

CreatePlayerSessions

=item *

DescribePlayerSessions

=item *

Game session placements

=over

=item *

StartGameSessionPlacement

=item *

DescribeGameSessionPlacement

=item *

StopGameSessionPlacement

=back

=back



=head2 CreatePlayerSessions(GameSessionId => Str, PlayerIds => ArrayRef[Str|Undef], [PlayerDataMap => L<Paws::GameLift::PlayerDataMap>])

Each argument is described in detail in: L<Paws::GameLift::CreatePlayerSessions>

Returns: a L<Paws::GameLift::CreatePlayerSessionsOutput> instance

  Adds a group of players to a game session. This action is useful with a
team matching feature. Before players can be added, a game session must
have an C<ACTIVE> status, have a creation policy of C<ALLOW_ALL>, and
have an open player slot. To add a single player to a game session, use
CreatePlayerSession.

To create player sessions, specify a game session ID, a list of player
IDs, and optionally a set of player data strings. If successful, the
players are added to the game session and a set of new PlayerSession
objects is returned. Player sessions cannot be updated.

I<Available in Amazon GameLift Local.>

Player-session-related operations include:

=over

=item *

CreatePlayerSession

=item *

CreatePlayerSessions

=item *

DescribePlayerSessions

=item *

Game session placements

=over

=item *

StartGameSessionPlacement

=item *

DescribeGameSessionPlacement

=item *

StopGameSessionPlacement

=back

=back



=head2 DeleteAlias(AliasId => Str)

Each argument is described in detail in: L<Paws::GameLift::DeleteAlias>

Returns: nothing

  Deletes an alias. This action removes all record of the alias. Game
clients attempting to access a server process using the deleted alias
receive an error. To delete an alias, specify the alias ID to be
deleted.

Alias-related operations include:

=over

=item *

CreateAlias

=item *

ListAliases

=item *

DescribeAlias

=item *

UpdateAlias

=item *

DeleteAlias

=item *

ResolveAlias

=back



=head2 DeleteBuild(BuildId => Str)

Each argument is described in detail in: L<Paws::GameLift::DeleteBuild>

Returns: nothing

  Deletes a build. This action permanently deletes the build record and
any uploaded build files.

To delete a build, specify its ID. Deleting a build does not affect the
status of any active fleets using the build, but you can no longer
create new fleets with the deleted build.

Build-related operations include:

=over

=item *

CreateBuild

=item *

ListBuilds

=item *

DescribeBuild

=item *

UpdateBuild

=item *

DeleteBuild

=back



=head2 DeleteFleet(FleetId => Str)

Each argument is described in detail in: L<Paws::GameLift::DeleteFleet>

Returns: nothing

  Deletes everything related to a fleet. Before deleting a fleet, you
must set the fleet's desired capacity to zero. See UpdateFleetCapacity.

This action removes the fleet's resources and the fleet record. Once a
fleet is deleted, you can no longer use that fleet.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 DeleteGameSessionQueue(Name => Str)

Each argument is described in detail in: L<Paws::GameLift::DeleteGameSessionQueue>

Returns: a L<Paws::GameLift::DeleteGameSessionQueueOutput> instance

  Deletes a game session queue. This action means that any
StartGameSessionPlacement requests that reference this queue will fail.
To delete a queue, specify the queue name.

Queue-related operations include:

=over

=item *

CreateGameSessionQueue

=item *

DescribeGameSessionQueues

=item *

UpdateGameSessionQueue

=item *

DeleteGameSessionQueue

=back



=head2 DeleteScalingPolicy(FleetId => Str, Name => Str)

Each argument is described in detail in: L<Paws::GameLift::DeleteScalingPolicy>

Returns: nothing

  Deletes a fleet scaling policy. This action means that the policy is no
longer in force and removes all record of it. To delete a scaling
policy, specify both the scaling policy name and the fleet ID it is
associated with.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 DescribeAlias(AliasId => Str)

Each argument is described in detail in: L<Paws::GameLift::DescribeAlias>

Returns: a L<Paws::GameLift::DescribeAliasOutput> instance

  Retrieves properties for an alias. This operation returns all alias
metadata and settings. To get an alias's target fleet ID only, use
C<ResolveAlias>.

To get alias properties, specify the alias ID. If successful, the
requested alias record is returned.

Alias-related operations include:

=over

=item *

CreateAlias

=item *

ListAliases

=item *

DescribeAlias

=item *

UpdateAlias

=item *

DeleteAlias

=item *

ResolveAlias

=back



=head2 DescribeBuild(BuildId => Str)

Each argument is described in detail in: L<Paws::GameLift::DescribeBuild>

Returns: a L<Paws::GameLift::DescribeBuildOutput> instance

  Retrieves properties for a build. To get a build record, specify a
build ID. If successful, an object containing the build properties is
returned.

Build-related operations include:

=over

=item *

CreateBuild

=item *

ListBuilds

=item *

DescribeBuild

=item *

UpdateBuild

=item *

DeleteBuild

=back



=head2 DescribeEC2InstanceLimits([EC2InstanceType => Str])

Each argument is described in detail in: L<Paws::GameLift::DescribeEC2InstanceLimits>

Returns: a L<Paws::GameLift::DescribeEC2InstanceLimitsOutput> instance

  Retrieves the following information for the specified EC2 instance
type:

=over

=item *

maximum number of instances allowed per AWS account (service limit)

=item *

current usage level for the AWS account

=back

Service limits vary depending on region. Available regions for Amazon
GameLift can be found in the AWS Management Console for Amazon GameLift
(see the drop-down list in the upper right corner).

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 DescribeFleetAttributes([FleetIds => ArrayRef[Str|Undef], Limit => Int, NextToken => Str])

Each argument is described in detail in: L<Paws::GameLift::DescribeFleetAttributes>

Returns: a L<Paws::GameLift::DescribeFleetAttributesOutput> instance

  Retrieves fleet properties, including metadata, status, and
configuration, for one or more fleets. You can request attributes for
all fleets, or specify a list of one or more fleet IDs. When requesting
multiple fleets, use the pagination parameters to retrieve results as a
set of sequential pages. If successful, a FleetAttributes object is
returned for each requested fleet ID. When specifying a list of fleet
IDs, attribute objects are returned only for fleets that currently
exist.

Some API actions may limit the number of fleet IDs allowed in one
request. If a request exceeds this limit, the request fails and the
error message includes the maximum allowed.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 DescribeFleetCapacity([FleetIds => ArrayRef[Str|Undef], Limit => Int, NextToken => Str])

Each argument is described in detail in: L<Paws::GameLift::DescribeFleetCapacity>

Returns: a L<Paws::GameLift::DescribeFleetCapacityOutput> instance

  Retrieves the current status of fleet capacity for one or more fleets.
This information includes the number of instances that have been
requested for the fleet and the number currently active. You can
request capacity for all fleets, or specify a list of one or more fleet
IDs. When requesting multiple fleets, use the pagination parameters to
retrieve results as a set of sequential pages. If successful, a
FleetCapacity object is returned for each requested fleet ID. When
specifying a list of fleet IDs, attribute objects are returned only for
fleets that currently exist.

Some API actions may limit the number of fleet IDs allowed in one
request. If a request exceeds this limit, the request fails and the
error message includes the maximum allowed.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 DescribeFleetEvents(FleetId => Str, [EndTime => Str, Limit => Int, NextToken => Str, StartTime => Str])

Each argument is described in detail in: L<Paws::GameLift::DescribeFleetEvents>

Returns: a L<Paws::GameLift::DescribeFleetEventsOutput> instance

  Retrieves entries from the specified fleet's event log. You can specify
a time range to limit the result set. Use the pagination parameters to
retrieve results as a set of sequential pages. If successful, a
collection of event log entries matching the request are returned.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 DescribeFleetPortSettings(FleetId => Str)

Each argument is described in detail in: L<Paws::GameLift::DescribeFleetPortSettings>

Returns: a L<Paws::GameLift::DescribeFleetPortSettingsOutput> instance

  Retrieves the inbound connection permissions for a fleet. Connection
permissions include a range of IP addresses and port settings that
incoming traffic can use to access server processes in the fleet. To
get a fleet's inbound connection permissions, specify a fleet ID. If
successful, a collection of IpPermission objects is returned for the
requested fleet ID. If the requested fleet has been deleted, the result
set is empty.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 DescribeFleetUtilization([FleetIds => ArrayRef[Str|Undef], Limit => Int, NextToken => Str])

Each argument is described in detail in: L<Paws::GameLift::DescribeFleetUtilization>

Returns: a L<Paws::GameLift::DescribeFleetUtilizationOutput> instance

  Retrieves utilization statistics for one or more fleets. You can
request utilization data for all fleets, or specify a list of one or
more fleet IDs. When requesting multiple fleets, use the pagination
parameters to retrieve results as a set of sequential pages. If
successful, a FleetUtilization object is returned for each requested
fleet ID. When specifying a list of fleet IDs, utilization objects are
returned only for fleets that currently exist.

Some API actions may limit the number of fleet IDs allowed in one
request. If a request exceeds this limit, the request fails and the
error message includes the maximum allowed.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 DescribeGameSessionDetails([AliasId => Str, FleetId => Str, GameSessionId => Str, Limit => Int, NextToken => Str, StatusFilter => Str])

Each argument is described in detail in: L<Paws::GameLift::DescribeGameSessionDetails>

Returns: a L<Paws::GameLift::DescribeGameSessionDetailsOutput> instance

  Retrieves properties, including the protection policy in force, for one
or more game sessions. This action can be used in several ways: (1)
provide a C<GameSessionId> or C<GameSessionArn> to request details for
a specific game session; (2) provide either a C<FleetId> or an
C<AliasId> to request properties for all game sessions running on a
fleet.

To get game session record(s), specify just one of the following: game
session ID, fleet ID, or alias ID. You can filter this request by game
session status. Use the pagination parameters to retrieve results as a
set of sequential pages. If successful, a GameSessionDetail object is
returned for each session matching the request.

Game-session-related operations include:

=over

=item *

CreateGameSession

=item *

DescribeGameSessions

=item *

DescribeGameSessionDetails

=item *

SearchGameSessions

=item *

UpdateGameSession

=item *

GetGameSessionLogUrl

=item *

Game session placements

=over

=item *

StartGameSessionPlacement

=item *

DescribeGameSessionPlacement

=item *

StopGameSessionPlacement

=back

=back



=head2 DescribeGameSessionPlacement(PlacementId => Str)

Each argument is described in detail in: L<Paws::GameLift::DescribeGameSessionPlacement>

Returns: a L<Paws::GameLift::DescribeGameSessionPlacementOutput> instance

  Retrieves properties and current status of a game session placement
request. To get game session placement details, specify the placement
ID. If successful, a GameSessionPlacement object is returned.

Game-session-related operations include:

=over

=item *

CreateGameSession

=item *

DescribeGameSessions

=item *

DescribeGameSessionDetails

=item *

SearchGameSessions

=item *

UpdateGameSession

=item *

GetGameSessionLogUrl

=item *

Game session placements

=over

=item *

StartGameSessionPlacement

=item *

DescribeGameSessionPlacement

=item *

StopGameSessionPlacement

=back

=back



=head2 DescribeGameSessionQueues([Limit => Int, Names => ArrayRef[Str|Undef], NextToken => Str])

Each argument is described in detail in: L<Paws::GameLift::DescribeGameSessionQueues>

Returns: a L<Paws::GameLift::DescribeGameSessionQueuesOutput> instance

  Retrieves the properties for one or more game session queues. When
requesting multiple queues, use the pagination parameters to retrieve
results as a set of sequential pages. If successful, a GameSessionQueue
object is returned for each requested queue. When specifying a list of
queues, objects are returned only for queues that currently exist in
the region.

Queue-related operations include:

=over

=item *

CreateGameSessionQueue

=item *

DescribeGameSessionQueues

=item *

UpdateGameSessionQueue

=item *

DeleteGameSessionQueue

=back



=head2 DescribeGameSessions([AliasId => Str, FleetId => Str, GameSessionId => Str, Limit => Int, NextToken => Str, StatusFilter => Str])

Each argument is described in detail in: L<Paws::GameLift::DescribeGameSessions>

Returns: a L<Paws::GameLift::DescribeGameSessionsOutput> instance

  Retrieves a set of one or more game sessions. Request a specific game
session or request all game sessions on a fleet. Alternatively, use
SearchGameSessions to request a set of active game sessions that are
filtered by certain criteria. To retrieve protection policy settings
for game sessions, use DescribeGameSessionDetails.

To get game sessions, specify one of the following: game session ID,
fleet ID, or alias ID. You can filter this request by game session
status. Use the pagination parameters to retrieve results as a set of
sequential pages. If successful, a GameSession object is returned for
each game session matching the request.

I<Available in Amazon GameLift Local.>

Game-session-related operations include:

=over

=item *

CreateGameSession

=item *

DescribeGameSessions

=item *

DescribeGameSessionDetails

=item *

SearchGameSessions

=item *

UpdateGameSession

=item *

GetGameSessionLogUrl

=item *

Game session placements

=over

=item *

StartGameSessionPlacement

=item *

DescribeGameSessionPlacement

=item *

StopGameSessionPlacement

=back

=back



=head2 DescribeInstances(FleetId => Str, [InstanceId => Str, Limit => Int, NextToken => Str])

Each argument is described in detail in: L<Paws::GameLift::DescribeInstances>

Returns: a L<Paws::GameLift::DescribeInstancesOutput> instance

  Retrieves information about a fleet's instances, including instance
IDs. Use this action to get details on all instances in the fleet or
get details on one specific instance.

To get a specific instance, specify fleet ID and instance ID. To get
all instances in a fleet, specify a fleet ID only. Use the pagination
parameters to retrieve results as a set of sequential pages. If
successful, an Instance object is returned for each result.


=head2 DescribePlayerSessions([GameSessionId => Str, Limit => Int, NextToken => Str, PlayerId => Str, PlayerSessionId => Str, PlayerSessionStatusFilter => Str])

Each argument is described in detail in: L<Paws::GameLift::DescribePlayerSessions>

Returns: a L<Paws::GameLift::DescribePlayerSessionsOutput> instance

  Retrieves properties for one or more player sessions. This action can
be used in several ways: (1) provide a C<PlayerSessionId> to request
properties for a specific player session; (2) provide a
C<GameSessionId> to request properties for all player sessions in the
specified game session; (3) provide a C<PlayerId> to request properties
for all player sessions of a specified player.

To get game session record(s), specify only one of the following: a
player session ID, a game session ID, or a player ID. You can filter
this request by player session status. Use the pagination parameters to
retrieve results as a set of sequential pages. If successful, a
PlayerSession object is returned for each session matching the request.

I<Available in Amazon GameLift Local.>

Player-session-related operations include:

=over

=item *

CreatePlayerSession

=item *

CreatePlayerSessions

=item *

DescribePlayerSessions

=item *

Game session placements

=over

=item *

StartGameSessionPlacement

=item *

DescribeGameSessionPlacement

=item *

StopGameSessionPlacement

=back

=back



=head2 DescribeRuntimeConfiguration(FleetId => Str)

Each argument is described in detail in: L<Paws::GameLift::DescribeRuntimeConfiguration>

Returns: a L<Paws::GameLift::DescribeRuntimeConfigurationOutput> instance

  Retrieves the current run-time configuration for the specified fleet.
The run-time configuration tells Amazon GameLift how to launch server
processes on instances in the fleet.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 DescribeScalingPolicies(FleetId => Str, [Limit => Int, NextToken => Str, StatusFilter => Str])

Each argument is described in detail in: L<Paws::GameLift::DescribeScalingPolicies>

Returns: a L<Paws::GameLift::DescribeScalingPoliciesOutput> instance

  Retrieves all scaling policies applied to a fleet.

To get a fleet's scaling policies, specify the fleet ID. You can filter
this request by policy status, such as to retrieve only active scaling
policies. Use the pagination parameters to retrieve results as a set of
sequential pages. If successful, set of ScalingPolicy objects is
returned for the fleet.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 GetGameSessionLogUrl(GameSessionId => Str)

Each argument is described in detail in: L<Paws::GameLift::GetGameSessionLogUrl>

Returns: a L<Paws::GameLift::GetGameSessionLogUrlOutput> instance

  Retrieves the location of stored game session logs for a specified game
session. When a game session is terminated, Amazon GameLift
automatically stores the logs in Amazon S3. Use this URL to download
the logs.

See the AWS Service Limits page for maximum log file sizes. Log files
that exceed this limit are not saved.

Game-session-related operations include:

=over

=item *

CreateGameSession

=item *

DescribeGameSessions

=item *

DescribeGameSessionDetails

=item *

SearchGameSessions

=item *

UpdateGameSession

=item *

GetGameSessionLogUrl

=item *

Game session placements

=over

=item *

StartGameSessionPlacement

=item *

DescribeGameSessionPlacement

=item *

StopGameSessionPlacement

=back

=back



=head2 GetInstanceAccess(FleetId => Str, InstanceId => Str)

Each argument is described in detail in: L<Paws::GameLift::GetInstanceAccess>

Returns: a L<Paws::GameLift::GetInstanceAccessOutput> instance

  Requests remote access to a fleet instance. Remote access is useful for
debugging, gathering benchmarking data, or watching activity in real
time.

Access requires credentials that match the operating system of the
instance. For a Windows instance, Amazon GameLift returns a user name
and password as strings for use with a Windows Remote Desktop client.
For a Linux instance, Amazon GameLift returns a user name and RSA
private key, also as strings, for use with an SSH client. The private
key must be saved in the proper format to a C<.pem> file before using.
If you're making this request using the AWS CLI, saving the secret can
be handled as part of the GetInstanceAccess request. (See the example
later in this topic). For more information on remote access, see
Remotely Accessing an Instance.

To request access to a specific instance, specify the IDs of the
instance and the fleet it belongs to. If successful, an InstanceAccess
object is returned containing the instance's IP address and a set of
credentials.


=head2 ListAliases([Limit => Int, Name => Str, NextToken => Str, RoutingStrategyType => Str])

Each argument is described in detail in: L<Paws::GameLift::ListAliases>

Returns: a L<Paws::GameLift::ListAliasesOutput> instance

  Retrieves all aliases for this AWS account. You can filter the result
set by alias name and/or routing strategy type. Use the pagination
parameters to retrieve results in sequential pages.

Returned aliases are not listed in any particular order.

Alias-related operations include:

=over

=item *

CreateAlias

=item *

ListAliases

=item *

DescribeAlias

=item *

UpdateAlias

=item *

DeleteAlias

=item *

ResolveAlias

=back



=head2 ListBuilds([Limit => Int, NextToken => Str, Status => Str])

Each argument is described in detail in: L<Paws::GameLift::ListBuilds>

Returns: a L<Paws::GameLift::ListBuildsOutput> instance

  Retrieves build records for all builds associated with the AWS account
in use. You can limit results to builds that are in a specific status
by using the C<Status> parameter. Use the pagination parameters to
retrieve results in a set of sequential pages.

Build records are not listed in any particular order.

Build-related operations include:

=over

=item *

CreateBuild

=item *

ListBuilds

=item *

DescribeBuild

=item *

UpdateBuild

=item *

DeleteBuild

=back



=head2 ListFleets([BuildId => Str, Limit => Int, NextToken => Str])

Each argument is described in detail in: L<Paws::GameLift::ListFleets>

Returns: a L<Paws::GameLift::ListFleetsOutput> instance

  Retrieves a collection of fleet records for this AWS account. You can
filter the result set by build ID. Use the pagination parameters to
retrieve results in sequential pages.

Fleet records are not listed in any particular order.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 PutScalingPolicy(ComparisonOperator => Str, EvaluationPeriods => Int, FleetId => Str, MetricName => Str, Name => Str, ScalingAdjustment => Int, ScalingAdjustmentType => Str, Threshold => Num)

Each argument is described in detail in: L<Paws::GameLift::PutScalingPolicy>

Returns: a L<Paws::GameLift::PutScalingPolicyOutput> instance

  Creates or updates a scaling policy for a fleet. An active scaling
policy prompts Amazon GameLift to track a certain metric for a fleet
and automatically change the fleet's capacity in specific
circumstances. Each scaling policy contains one rule statement. Fleets
can have multiple scaling policies in force simultaneously.

A scaling policy rule statement has the following structure:

If C<[MetricName]> is C<[ComparisonOperator]> C<[Threshold]> for
C<[EvaluationPeriods]> minutes, then C<[ScalingAdjustmentType]> to/by
C<[ScalingAdjustment]>.

For example, this policy: "If the number of idle instances exceeds 20
for more than 15 minutes, then reduce the fleet capacity by 10
instances" could be implemented as the following rule statement:

If [IdleInstances] is [GreaterThanOrEqualToThreshold] [20] for [15]
minutes, then [ChangeInCapacity] by [-10].

To create or update a scaling policy, specify a unique combination of
name and fleet ID, and set the rule values. All parameters for this
action are required. If successful, the policy name is returned.
Scaling policies cannot be suspended or made inactive. To stop
enforcing a scaling policy, call DeleteScalingPolicy.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 RequestUploadCredentials(BuildId => Str)

Each argument is described in detail in: L<Paws::GameLift::RequestUploadCredentials>

Returns: a L<Paws::GameLift::RequestUploadCredentialsOutput> instance

  I<This API call is not currently in use. > Retrieves a fresh set of
upload credentials and the assigned Amazon S3 storage location for a
specific build. Valid credentials are required to upload your game
build files to Amazon S3.


=head2 ResolveAlias(AliasId => Str)

Each argument is described in detail in: L<Paws::GameLift::ResolveAlias>

Returns: a L<Paws::GameLift::ResolveAliasOutput> instance

  Retrieves the fleet ID that a specified alias is currently pointing to.

Alias-related operations include:

=over

=item *

CreateAlias

=item *

ListAliases

=item *

DescribeAlias

=item *

UpdateAlias

=item *

DeleteAlias

=item *

ResolveAlias

=back



=head2 SearchGameSessions([AliasId => Str, FilterExpression => Str, FleetId => Str, Limit => Int, NextToken => Str, SortExpression => Str])

Each argument is described in detail in: L<Paws::GameLift::SearchGameSessions>

Returns: a L<Paws::GameLift::SearchGameSessionsOutput> instance

  Retrieves a set of game sessions that match a set of search criteria
and sorts them in a specified order. A game session search is limited
to a single fleet. Search results include only game sessions that are
in C<ACTIVE> status. If you need to retrieve game sessions with a
status other than active, use DescribeGameSessions. If you need to
retrieve the protection policy for each game session, use
DescribeGameSessionDetails.

You can search or sort by the following game session attributes:

=over

=item *

B<gameSessionId> -- Unique identifier for the game session. You can use
either a C<GameSessionId> or C<GameSessionArn> value.

=item *

B<gameSessionName> -- Name assigned to a game session. This value is
set when requesting a new game session with CreateGameSession or
updating with UpdateGameSession. Game session names do not need to be
unique to a game session.

=item *

B<creationTimeMillis> -- Value indicating when a game session was
created. It is expressed in Unix time as milliseconds.

=item *

B<playerSessionCount> -- Number of players currently connected to a
game session. This value changes rapidly as players join the session or
drop out.

=item *

B<maximumSessions> -- Maximum number of player sessions allowed for a
game session. This value is set when requesting a new game session with
CreateGameSession or updating with UpdateGameSession.

=item *

B<hasAvailablePlayerSessions> -- Boolean value indicating whether a
game session has reached its maximum number of players. When searching
with this attribute, the search value must be C<true> or C<false>. It
is highly recommended that all search requests include this filter
attribute to optimize search performance and return only sessions that
players can join.

=back

To search or sort, specify either a fleet ID or an alias ID, and
provide a search filter expression, a sort expression, or both. Use the
pagination parameters to retrieve results as a set of sequential pages.
If successful, a collection of GameSession objects matching the request
is returned.

Returned values for C<playerSessionCount> and
C<hasAvailablePlayerSessions> change quickly as players join sessions
and others drop out. Results should be considered a snapshot in time.
Be sure to refresh search results often, and handle sessions that fill
up before a player can join.

Game-session-related operations include:

=over

=item *

CreateGameSession

=item *

DescribeGameSessions

=item *

DescribeGameSessionDetails

=item *

SearchGameSessions

=item *

UpdateGameSession

=item *

GetGameSessionLogUrl

=item *

Game session placements

=over

=item *

StartGameSessionPlacement

=item *

DescribeGameSessionPlacement

=item *

StopGameSessionPlacement

=back

=back



=head2 StartGameSessionPlacement(GameSessionQueueName => Str, MaximumPlayerSessionCount => Int, PlacementId => Str, [DesiredPlayerSessions => ArrayRef[L<Paws::GameLift::DesiredPlayerSession>], GameProperties => ArrayRef[L<Paws::GameLift::GameProperty>], GameSessionName => Str, PlayerLatencies => ArrayRef[L<Paws::GameLift::PlayerLatency>]])

Each argument is described in detail in: L<Paws::GameLift::StartGameSessionPlacement>

Returns: a L<Paws::GameLift::StartGameSessionPlacementOutput> instance

  Places a request for a new game session in a queue (see
CreateGameSessionQueue). When processing a placement request, Amazon
GameLift searches for available resources on the queue's destinations,
scanning each until it finds resources or the placement request times
out.

A game session placement request can also request player sessions. When
a new game session is successfully created, Amazon GameLift creates a
player session for each player included in the request.

When placing a game session, by default Amazon GameLift tries each
fleet in the order they are listed in the queue configuration. Ideally,
a queue's destinations are listed in preference order.

Alternatively, when requesting a game session with players, you can
also provide latency data for each player in relevant regions. Latency
data indicates the performance lag a player experiences when connected
to a fleet in the region. Amazon GameLift uses latency data to reorder
the list of destinations to place the game session in a region with
minimal lag. If latency data is provided for multiple players, Amazon
GameLift calculates each region's average lag for all players and
reorders to get the best game play across all players.

To place a new game session request, specify the following:

=over

=item *

The queue name and a set of game session properties and settings

=item *

A unique ID (such as a UUID) for the placement. You use this ID to
track the status of the placement request

=item *

(Optional) A set of IDs and player data for each player you want to
join to the new game session

=item *

Latency data for all players (if you want to optimize game play for the
players)

=back

If successful, a new game session placement is created.

To track the status of a placement request, call
DescribeGameSessionPlacement and check the request's status. If the
status is C<Fulfilled>, a new game session has been created and a game
session ARN and region are referenced. If the placement request times
out, you can resubmit the request or retry it with a different queue.

Game-session-related operations include:

=over

=item *

CreateGameSession

=item *

DescribeGameSessions

=item *

DescribeGameSessionDetails

=item *

SearchGameSessions

=item *

UpdateGameSession

=item *

GetGameSessionLogUrl

=item *

Game session placements

=over

=item *

StartGameSessionPlacement

=item *

DescribeGameSessionPlacement

=item *

StopGameSessionPlacement

=back

=back



=head2 StopGameSessionPlacement(PlacementId => Str)

Each argument is described in detail in: L<Paws::GameLift::StopGameSessionPlacement>

Returns: a L<Paws::GameLift::StopGameSessionPlacementOutput> instance

  Cancels a game session placement that is in Pending status. To stop a
placement, provide the placement ID values. If successful, the
placement is moved to Cancelled status.

Game-session-related operations include:

=over

=item *

CreateGameSession

=item *

DescribeGameSessions

=item *

DescribeGameSessionDetails

=item *

SearchGameSessions

=item *

UpdateGameSession

=item *

GetGameSessionLogUrl

=item *

Game session placements

=over

=item *

StartGameSessionPlacement

=item *

DescribeGameSessionPlacement

=item *

StopGameSessionPlacement

=back

=back



=head2 UpdateAlias(AliasId => Str, [Description => Str, Name => Str, RoutingStrategy => L<Paws::GameLift::RoutingStrategy>])

Each argument is described in detail in: L<Paws::GameLift::UpdateAlias>

Returns: a L<Paws::GameLift::UpdateAliasOutput> instance

  Updates properties for an alias. To update properties, specify the
alias ID to be updated and provide the information to be changed. To
reassign an alias to another fleet, provide an updated routing
strategy. If successful, the updated alias record is returned.

Alias-related operations include:

=over

=item *

CreateAlias

=item *

ListAliases

=item *

DescribeAlias

=item *

UpdateAlias

=item *

DeleteAlias

=item *

ResolveAlias

=back



=head2 UpdateBuild(BuildId => Str, [Name => Str, Version => Str])

Each argument is described in detail in: L<Paws::GameLift::UpdateBuild>

Returns: a L<Paws::GameLift::UpdateBuildOutput> instance

  Updates metadata in a build record, including the build name and
version. To update the metadata, specify the build ID to update and
provide the new values. If successful, a build object containing the
updated metadata is returned.

Build-related operations include:

=over

=item *

CreateBuild

=item *

ListBuilds

=item *

DescribeBuild

=item *

UpdateBuild

=item *

DeleteBuild

=back



=head2 UpdateFleetAttributes(FleetId => Str, [Description => Str, MetricGroups => ArrayRef[Str|Undef], Name => Str, NewGameSessionProtectionPolicy => Str, ResourceCreationLimitPolicy => L<Paws::GameLift::ResourceCreationLimitPolicy>])

Each argument is described in detail in: L<Paws::GameLift::UpdateFleetAttributes>

Returns: a L<Paws::GameLift::UpdateFleetAttributesOutput> instance

  Updates fleet properties, including name and description, for a fleet.
To update metadata, specify the fleet ID and the property values that
you want to change. If successful, the fleet ID for the updated fleet
is returned.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 UpdateFleetCapacity(FleetId => Str, [DesiredInstances => Int, MaxSize => Int, MinSize => Int])

Each argument is described in detail in: L<Paws::GameLift::UpdateFleetCapacity>

Returns: a L<Paws::GameLift::UpdateFleetCapacityOutput> instance

  Updates capacity settings for a fleet. Use this action to specify the
number of EC2 instances (hosts) that you want this fleet to contain.
Before calling this action, you may want to call
DescribeEC2InstanceLimits to get the maximum capacity based on the
fleet's EC2 instance type.

If you're using autoscaling (see PutScalingPolicy), you may want to
specify a minimum and/or maximum capacity. If you don't provide these,
autoscaling can set capacity anywhere between zero and the service
limits.

To update fleet capacity, specify the fleet ID and the number of
instances you want the fleet to host. If successful, Amazon GameLift
starts or terminates instances so that the fleet's active instance
count matches the desired instance count. You can view a fleet's
current capacity information by calling DescribeFleetCapacity. If the
desired instance count is higher than the instance type's limit, the
"Limit Exceeded" exception occurs.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 UpdateFleetPortSettings(FleetId => Str, [InboundPermissionAuthorizations => ArrayRef[L<Paws::GameLift::IpPermission>], InboundPermissionRevocations => ArrayRef[L<Paws::GameLift::IpPermission>]])

Each argument is described in detail in: L<Paws::GameLift::UpdateFleetPortSettings>

Returns: a L<Paws::GameLift::UpdateFleetPortSettingsOutput> instance

  Updates port settings for a fleet. To update settings, specify the
fleet ID to be updated and list the permissions you want to update.
List the permissions you want to add in
C<InboundPermissionAuthorizations>, and permissions you want to remove
in C<InboundPermissionRevocations>. Permissions to be removed must
match existing fleet permissions. If successful, the fleet ID for the
updated fleet is returned.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back



=head2 UpdateGameSession(GameSessionId => Str, [MaximumPlayerSessionCount => Int, Name => Str, PlayerSessionCreationPolicy => Str, ProtectionPolicy => Str])

Each argument is described in detail in: L<Paws::GameLift::UpdateGameSession>

Returns: a L<Paws::GameLift::UpdateGameSessionOutput> instance

  Updates game session properties. This includes the session name,
maximum player count, protection policy, which controls whether or not
an active game session can be terminated during a scale-down event, and
the player session creation policy, which controls whether or not new
players can join the session. To update a game session, specify the
game session ID and the values you want to change. If successful, an
updated GameSession object is returned.

Game-session-related operations include:

=over

=item *

CreateGameSession

=item *

DescribeGameSessions

=item *

DescribeGameSessionDetails

=item *

SearchGameSessions

=item *

UpdateGameSession

=item *

GetGameSessionLogUrl

=item *

Game session placements

=over

=item *

StartGameSessionPlacement

=item *

DescribeGameSessionPlacement

=item *

StopGameSessionPlacement

=back

=back



=head2 UpdateGameSessionQueue(Name => Str, [Destinations => ArrayRef[L<Paws::GameLift::GameSessionQueueDestination>], PlayerLatencyPolicies => ArrayRef[L<Paws::GameLift::PlayerLatencyPolicy>], TimeoutInSeconds => Int])

Each argument is described in detail in: L<Paws::GameLift::UpdateGameSessionQueue>

Returns: a L<Paws::GameLift::UpdateGameSessionQueueOutput> instance

  Updates settings for a game session queue, which determines how new
game session requests in the queue are processed. To update settings,
specify the queue name to be updated and provide the new settings. When
updating destinations, provide a complete list of destinations.

Queue-related operations include:

=over

=item *

CreateGameSessionQueue

=item *

DescribeGameSessionQueues

=item *

UpdateGameSessionQueue

=item *

DeleteGameSessionQueue

=back



=head2 UpdateRuntimeConfiguration(FleetId => Str, RuntimeConfiguration => L<Paws::GameLift::RuntimeConfiguration>)

Each argument is described in detail in: L<Paws::GameLift::UpdateRuntimeConfiguration>

Returns: a L<Paws::GameLift::UpdateRuntimeConfigurationOutput> instance

  Updates the current run-time configuration for the specified fleet,
which tells Amazon GameLift how to launch server processes on instances
in the fleet. You can update a fleet's run-time configuration at any
time after the fleet is created; it does not need to be in an C<ACTIVE>
status.

To update run-time configuration, specify the fleet ID and provide a
C<RuntimeConfiguration> object with the updated collection of server
process configurations.

Each instance in a Amazon GameLift fleet checks regularly for an
updated run-time configuration and changes how it launches server
processes to comply with the latest version. Existing server processes
are not affected by the update; they continue to run until they end,
while Amazon GameLift simply adds new server processes to fit the
current run-time configuration. As a result, the run-time configuration
changes are applied gradually as existing processes shut down and new
processes are launched in Amazon GameLift's normal process recycling
activity.

Fleet-related operations include:

=over

=item *

CreateFleet

=item *

ListFleets

=item *

Describe fleets:

=over

=item *

DescribeFleetAttributes

=item *

DescribeFleetPortSettings

=item *

DescribeFleetUtilization

=item *

DescribeRuntimeConfiguration

=item *

DescribeFleetEvents

=back

=item *

Update fleets:

=over

=item *

UpdateFleetAttributes

=item *

UpdateFleetCapacity

=item *

UpdateFleetPortSettings

=item *

UpdateRuntimeConfiguration

=back

=item *

Manage fleet capacity:

=over

=item *

DescribeFleetCapacity

=item *

UpdateFleetCapacity

=item *

PutScalingPolicy (automatic scaling)

=item *

DescribeScalingPolicies (automatic scaling)

=item *

DeleteScalingPolicy (automatic scaling)

=item *

DescribeEC2InstanceLimits

=back

=item *

DeleteFleet

=back





=head1 PAGINATORS

Paginator methods are helpers that repetively call methods that return partial results




=head1 SEE ALSO

This service class forms part of L<Paws>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: https://github.com/pplu/aws-sdk-perl

Please report bugs to: https://github.com/pplu/aws-sdk-perl/issues

=cut


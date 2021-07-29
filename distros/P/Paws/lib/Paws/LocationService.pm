package Paws::LocationService;
  use Moose;
  sub service { 'geo' }
  sub signing_name { 'geo' }
  sub version { '2020-11-19' }
  sub flattened_arrays { 0 }
  has max_attempts => (is => 'ro', isa => 'Int', default => 5);
  has retry => (is => 'ro', isa => 'HashRef', default => sub {
    { base => 'rand', type => 'exponential', growth_factor => 2 }
  });
  has retriables => (is => 'ro', isa => 'ArrayRef', default => sub { [
  ] });

  with 'Paws::API::Caller', 'Paws::API::EndpointResolver', 'Paws::Net::V4Signature', 'Paws::Net::RestJsonCaller';

  
  sub AssociateTrackerConsumer {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::AssociateTrackerConsumer', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub BatchDeleteDevicePositionHistory {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::BatchDeleteDevicePositionHistory', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub BatchDeleteGeofence {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::BatchDeleteGeofence', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub BatchEvaluateGeofences {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::BatchEvaluateGeofences', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub BatchGetDevicePosition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::BatchGetDevicePosition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub BatchPutGeofence {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::BatchPutGeofence', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub BatchUpdateDevicePosition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::BatchUpdateDevicePosition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CalculateRoute {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::CalculateRoute', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateGeofenceCollection {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::CreateGeofenceCollection', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateMap {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::CreateMap', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreatePlaceIndex {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::CreatePlaceIndex', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateRouteCalculator {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::CreateRouteCalculator', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateTracker {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::CreateTracker', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteGeofenceCollection {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::DeleteGeofenceCollection', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteMap {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::DeleteMap', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeletePlaceIndex {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::DeletePlaceIndex', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteRouteCalculator {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::DeleteRouteCalculator', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteTracker {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::DeleteTracker', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeGeofenceCollection {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::DescribeGeofenceCollection', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeMap {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::DescribeMap', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribePlaceIndex {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::DescribePlaceIndex', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeRouteCalculator {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::DescribeRouteCalculator', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeTracker {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::DescribeTracker', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DisassociateTrackerConsumer {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::DisassociateTrackerConsumer', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetDevicePosition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::GetDevicePosition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetDevicePositionHistory {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::GetDevicePositionHistory', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetGeofence {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::GetGeofence', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetMapGlyphs {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::GetMapGlyphs', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetMapSprites {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::GetMapSprites', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetMapStyleDescriptor {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::GetMapStyleDescriptor', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetMapTile {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::GetMapTile', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListDevicePositions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::ListDevicePositions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListGeofenceCollections {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::ListGeofenceCollections', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListGeofences {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::ListGeofences', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListMaps {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::ListMaps', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListPlaceIndexes {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::ListPlaceIndexes', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListRouteCalculators {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::ListRouteCalculators', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListTagsForResource {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::ListTagsForResource', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListTrackerConsumers {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::ListTrackerConsumers', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListTrackers {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::ListTrackers', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub PutGeofence {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::PutGeofence', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub SearchPlaceIndexForPosition {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::SearchPlaceIndexForPosition', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub SearchPlaceIndexForText {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::SearchPlaceIndexForText', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub TagResource {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::TagResource', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UntagResource {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::LocationService::UntagResource', @_);
    return $self->caller->do_call($self, $call_object);
  }
  
  sub GetAllDevicePositionHistory {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->GetDevicePositionHistory(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->GetDevicePositionHistory(@_, NextToken => $next_result->NextToken);
        push @{ $result->DevicePositions }, @{ $next_result->DevicePositions };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'DevicePositions') foreach (@{ $result->DevicePositions });
        $result = $self->GetDevicePositionHistory(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'DevicePositions') foreach (@{ $result->DevicePositions });
    }

    return undef
  }
  sub ListAllDevicePositions {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->ListDevicePositions(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->ListDevicePositions(@_, NextToken => $next_result->NextToken);
        push @{ $result->Entries }, @{ $next_result->Entries };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'Entries') foreach (@{ $result->Entries });
        $result = $self->ListDevicePositions(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'Entries') foreach (@{ $result->Entries });
    }

    return undef
  }
  sub ListAllGeofenceCollections {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->ListGeofenceCollections(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->ListGeofenceCollections(@_, NextToken => $next_result->NextToken);
        push @{ $result->Entries }, @{ $next_result->Entries };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'Entries') foreach (@{ $result->Entries });
        $result = $self->ListGeofenceCollections(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'Entries') foreach (@{ $result->Entries });
    }

    return undef
  }
  sub ListAllGeofences {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->ListGeofences(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->ListGeofences(@_, NextToken => $next_result->NextToken);
        push @{ $result->Entries }, @{ $next_result->Entries };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'Entries') foreach (@{ $result->Entries });
        $result = $self->ListGeofences(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'Entries') foreach (@{ $result->Entries });
    }

    return undef
  }
  sub ListAllMaps {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->ListMaps(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->ListMaps(@_, NextToken => $next_result->NextToken);
        push @{ $result->Entries }, @{ $next_result->Entries };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'Entries') foreach (@{ $result->Entries });
        $result = $self->ListMaps(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'Entries') foreach (@{ $result->Entries });
    }

    return undef
  }
  sub ListAllPlaceIndexes {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->ListPlaceIndexes(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->ListPlaceIndexes(@_, NextToken => $next_result->NextToken);
        push @{ $result->Entries }, @{ $next_result->Entries };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'Entries') foreach (@{ $result->Entries });
        $result = $self->ListPlaceIndexes(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'Entries') foreach (@{ $result->Entries });
    }

    return undef
  }
  sub ListAllRouteCalculators {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->ListRouteCalculators(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->ListRouteCalculators(@_, NextToken => $next_result->NextToken);
        push @{ $result->Entries }, @{ $next_result->Entries };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'Entries') foreach (@{ $result->Entries });
        $result = $self->ListRouteCalculators(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'Entries') foreach (@{ $result->Entries });
    }

    return undef
  }
  sub ListAllTrackerConsumers {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->ListTrackerConsumers(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->ListTrackerConsumers(@_, NextToken => $next_result->NextToken);
        push @{ $result->ConsumerArns }, @{ $next_result->ConsumerArns };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'ConsumerArns') foreach (@{ $result->ConsumerArns });
        $result = $self->ListTrackerConsumers(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'ConsumerArns') foreach (@{ $result->ConsumerArns });
    }

    return undef
  }
  sub ListAllTrackers {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->ListTrackers(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->ListTrackers(@_, NextToken => $next_result->NextToken);
        push @{ $result->Entries }, @{ $next_result->Entries };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'Entries') foreach (@{ $result->Entries });
        $result = $self->ListTrackers(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'Entries') foreach (@{ $result->Entries });
    }

    return undef
  }


  sub operations { qw/AssociateTrackerConsumer BatchDeleteDevicePositionHistory BatchDeleteGeofence BatchEvaluateGeofences BatchGetDevicePosition BatchPutGeofence BatchUpdateDevicePosition CalculateRoute CreateGeofenceCollection CreateMap CreatePlaceIndex CreateRouteCalculator CreateTracker DeleteGeofenceCollection DeleteMap DeletePlaceIndex DeleteRouteCalculator DeleteTracker DescribeGeofenceCollection DescribeMap DescribePlaceIndex DescribeRouteCalculator DescribeTracker DisassociateTrackerConsumer GetDevicePosition GetDevicePositionHistory GetGeofence GetMapGlyphs GetMapSprites GetMapStyleDescriptor GetMapTile ListDevicePositions ListGeofenceCollections ListGeofences ListMaps ListPlaceIndexes ListRouteCalculators ListTagsForResource ListTrackerConsumers ListTrackers PutGeofence SearchPlaceIndexForPosition SearchPlaceIndexForText TagResource UntagResource / }

1;

### main pod documentation begin ###

=head1 NAME

Paws::LocationService - Perl Interface to AWS Amazon Location Service

=head1 SYNOPSIS

  use Paws;

  my $obj = Paws->service('LocationService');
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

Suite of geospatial services including Maps, Places, Routes, Tracking,
and Geofencing

For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/geo-2020-11-19>


=head1 METHODS

=head2 AssociateTrackerConsumer

=over

=item ConsumerArn => Str

=item TrackerName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::AssociateTrackerConsumer>

Returns: a L<Paws::LocationService::AssociateTrackerConsumerResponse> instance

Creates an association between a geofence collection and a tracker
resource. This allows the tracker resource to communicate location data
to the linked geofence collection.

Currently not supported E<mdash> Cross-account configurations, such as
creating associations between a tracker resource in one account and a
geofence collection in another account.


=head2 BatchDeleteDevicePositionHistory

=over

=item DeviceIds => ArrayRef[Str|Undef]

=item TrackerName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::BatchDeleteDevicePositionHistory>

Returns: a L<Paws::LocationService::BatchDeleteDevicePositionHistoryResponse> instance

Deletes the position history of one or more devices from a tracker
resource.


=head2 BatchDeleteGeofence

=over

=item CollectionName => Str

=item GeofenceIds => ArrayRef[Str|Undef]


=back

Each argument is described in detail in: L<Paws::LocationService::BatchDeleteGeofence>

Returns: a L<Paws::LocationService::BatchDeleteGeofenceResponse> instance

Deletes a batch of geofences from a geofence collection.

This operation deletes the resource permanently.


=head2 BatchEvaluateGeofences

=over

=item CollectionName => Str

=item DevicePositionUpdates => ArrayRef[L<Paws::LocationService::DevicePositionUpdate>]


=back

Each argument is described in detail in: L<Paws::LocationService::BatchEvaluateGeofences>

Returns: a L<Paws::LocationService::BatchEvaluateGeofencesResponse> instance

Evaluates device positions against the geofence geometries from a given
geofence collection. The evaluation determines if the device has
entered or exited a geofenced area, which publishes ENTER or EXIT
geofence events to Amazon EventBridge.

The last geofence that a device was observed within, if any, is tracked
for 30 days after the most recent device position update


=head2 BatchGetDevicePosition

=over

=item DeviceIds => ArrayRef[Str|Undef]

=item TrackerName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::BatchGetDevicePosition>

Returns: a L<Paws::LocationService::BatchGetDevicePositionResponse> instance

A batch request to retrieve all device positions.


=head2 BatchPutGeofence

=over

=item CollectionName => Str

=item Entries => ArrayRef[L<Paws::LocationService::BatchPutGeofenceRequestEntry>]


=back

Each argument is described in detail in: L<Paws::LocationService::BatchPutGeofence>

Returns: a L<Paws::LocationService::BatchPutGeofenceResponse> instance

A batch request for storing geofence geometries into a given geofence
collection, or updates the geometry of an existing geofence if a
geofence ID is included in the request.


=head2 BatchUpdateDevicePosition

=over

=item TrackerName => Str

=item Updates => ArrayRef[L<Paws::LocationService::DevicePositionUpdate>]


=back

Each argument is described in detail in: L<Paws::LocationService::BatchUpdateDevicePosition>

Returns: a L<Paws::LocationService::BatchUpdateDevicePositionResponse> instance

Uploads position update data for one or more devices to a tracker
resource. Amazon Location uses the data when reporting the last known
device position and position history.

Only one position update is stored per sample time. Location data is
sampled at a fixed rate of one position per 30-second interval and
retained for 30 days before it's deleted.


=head2 CalculateRoute

=over

=item CalculatorName => Str

=item DeparturePosition => ArrayRef[Num]

=item DestinationPosition => ArrayRef[Num]

=item [CarModeOptions => L<Paws::LocationService::CalculateRouteCarModeOptions>]

=item [DepartNow => Bool]

=item [DepartureTime => Str]

=item [DistanceUnit => Str]

=item [IncludeLegGeometry => Bool]

=item [TravelMode => Str]

=item [TruckModeOptions => L<Paws::LocationService::CalculateRouteTruckModeOptions>]

=item [WaypointPositions => ArrayRef[ArrayRef[Num]]]


=back

Each argument is described in detail in: L<Paws::LocationService::CalculateRoute>

Returns: a L<Paws::LocationService::CalculateRouteResponse> instance

Calculates a route
(https://docs.aws.amazon.com/location/latest/developerguide/calculate-route.html)
given the following required parameters: C<DeparturePostiton> and
C<DestinationPosition>. Requires that you first create aroute
calculator resource
(https://docs.aws.amazon.com/location-routes/latest/APIReference/API_CreateRouteCalculator.html)

By default, a request that doesn't specify a departure time uses the
best time of day to travel with the best traffic conditions when
calculating the route.

Additional options include:

=over

=item *

Specifying a departure time
(https://docs.aws.amazon.com/location/latest/developerguide/calculate-route.html#departure-time)
using either C<DepartureTime> or C<DepartureNow>. This calculates a
route based on predictive traffic data at the given time.

You can't specify both C<DepartureTime> and C<DepartureNow> in a single
request. Specifying both parameters returns an error message.

=item *

Specifying a travel mode
(https://docs.aws.amazon.com/location/latest/developerguide/calculate-route.html#travel-mode)
using TravelMode. This lets you specify additional route preference
such as C<CarModeOptions> if traveling by C<Car>, or
C<TruckModeOptions> if traveling by C<Truck>.

=back



=head2 CreateGeofenceCollection

=over

=item CollectionName => Str

=item PricingPlan => Str

=item [Description => Str]

=item [KmsKeyId => Str]

=item [PricingPlanDataSource => Str]

=item [Tags => L<Paws::LocationService::TagMap>]


=back

Each argument is described in detail in: L<Paws::LocationService::CreateGeofenceCollection>

Returns: a L<Paws::LocationService::CreateGeofenceCollectionResponse> instance

Creates a geofence collection, which manages and stores geofences.


=head2 CreateMap

=over

=item Configuration => L<Paws::LocationService::MapConfiguration>

=item MapName => Str

=item PricingPlan => Str

=item [Description => Str]

=item [Tags => L<Paws::LocationService::TagMap>]


=back

Each argument is described in detail in: L<Paws::LocationService::CreateMap>

Returns: a L<Paws::LocationService::CreateMapResponse> instance

Creates a map resource in your AWS account, which provides map tiles of
different styles sourced from global location data providers.


=head2 CreatePlaceIndex

=over

=item DataSource => Str

=item IndexName => Str

=item PricingPlan => Str

=item [DataSourceConfiguration => L<Paws::LocationService::DataSourceConfiguration>]

=item [Description => Str]

=item [Tags => L<Paws::LocationService::TagMap>]


=back

Each argument is described in detail in: L<Paws::LocationService::CreatePlaceIndex>

Returns: a L<Paws::LocationService::CreatePlaceIndexResponse> instance

Creates a place index resource in your AWS account, which supports
functions with geospatial data sourced from your chosen data provider.


=head2 CreateRouteCalculator

=over

=item CalculatorName => Str

=item DataSource => Str

=item PricingPlan => Str

=item [Description => Str]

=item [Tags => L<Paws::LocationService::TagMap>]


=back

Each argument is described in detail in: L<Paws::LocationService::CreateRouteCalculator>

Returns: a L<Paws::LocationService::CreateRouteCalculatorResponse> instance

Creates a route calculator resource in your AWS account.

You can send requests to a route calculator resource to estimate travel
time, distance, and get directions. A route calculator sources traffic
and road network data from your chosen data provider.


=head2 CreateTracker

=over

=item PricingPlan => Str

=item TrackerName => Str

=item [Description => Str]

=item [KmsKeyId => Str]

=item [PricingPlanDataSource => Str]

=item [Tags => L<Paws::LocationService::TagMap>]


=back

Each argument is described in detail in: L<Paws::LocationService::CreateTracker>

Returns: a L<Paws::LocationService::CreateTrackerResponse> instance

Creates a tracker resource in your AWS account, which lets you retrieve
current and historical location of devices.


=head2 DeleteGeofenceCollection

=over

=item CollectionName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::DeleteGeofenceCollection>

Returns: a L<Paws::LocationService::DeleteGeofenceCollectionResponse> instance

Deletes a geofence collection from your AWS account.

This operation deletes the resource permanently. If the geofence
collection is the target of a tracker resource, the devices will no
longer be monitored.


=head2 DeleteMap

=over

=item MapName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::DeleteMap>

Returns: a L<Paws::LocationService::DeleteMapResponse> instance

Deletes a map resource from your AWS account.

This operation deletes the resource permanently. If the map is being
used in an application, the map may not render.


=head2 DeletePlaceIndex

=over

=item IndexName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::DeletePlaceIndex>

Returns: a L<Paws::LocationService::DeletePlaceIndexResponse> instance

Deletes a place index resource from your AWS account.

This operation deletes the resource permanently.


=head2 DeleteRouteCalculator

=over

=item CalculatorName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::DeleteRouteCalculator>

Returns: a L<Paws::LocationService::DeleteRouteCalculatorResponse> instance

Deletes a route calculator resource from your AWS account.

This operation deletes the resource permanently.


=head2 DeleteTracker

=over

=item TrackerName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::DeleteTracker>

Returns: a L<Paws::LocationService::DeleteTrackerResponse> instance

Deletes a tracker resource from your AWS account.

This operation deletes the resource permanently. If the tracker
resource is in use, you may encounter an error. Make sure that the
target resource isn't a dependency for your applications.


=head2 DescribeGeofenceCollection

=over

=item CollectionName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::DescribeGeofenceCollection>

Returns: a L<Paws::LocationService::DescribeGeofenceCollectionResponse> instance

Retrieves the geofence collection details.


=head2 DescribeMap

=over

=item MapName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::DescribeMap>

Returns: a L<Paws::LocationService::DescribeMapResponse> instance

Retrieves the map resource details.


=head2 DescribePlaceIndex

=over

=item IndexName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::DescribePlaceIndex>

Returns: a L<Paws::LocationService::DescribePlaceIndexResponse> instance

Retrieves the place index resource details.


=head2 DescribeRouteCalculator

=over

=item CalculatorName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::DescribeRouteCalculator>

Returns: a L<Paws::LocationService::DescribeRouteCalculatorResponse> instance

Retrieves the route calculator resource details.


=head2 DescribeTracker

=over

=item TrackerName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::DescribeTracker>

Returns: a L<Paws::LocationService::DescribeTrackerResponse> instance

Retrieves the tracker resource details.


=head2 DisassociateTrackerConsumer

=over

=item ConsumerArn => Str

=item TrackerName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::DisassociateTrackerConsumer>

Returns: a L<Paws::LocationService::DisassociateTrackerConsumerResponse> instance

Removes the association between a tracker resource and a geofence
collection.

Once you unlink a tracker resource from a geofence collection, the
tracker positions will no longer be automatically evaluated against
geofences.


=head2 GetDevicePosition

=over

=item DeviceId => Str

=item TrackerName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::GetDevicePosition>

Returns: a L<Paws::LocationService::GetDevicePositionResponse> instance

Retrieves a device's most recent position according to its sample time.

Device positions are deleted after 30 days.


=head2 GetDevicePositionHistory

=over

=item DeviceId => Str

=item TrackerName => Str

=item [EndTimeExclusive => Str]

=item [NextToken => Str]

=item [StartTimeInclusive => Str]


=back

Each argument is described in detail in: L<Paws::LocationService::GetDevicePositionHistory>

Returns: a L<Paws::LocationService::GetDevicePositionHistoryResponse> instance

Retrieves the device position history from a tracker resource within a
specified range of time.

Device positions are deleted after 30 days.


=head2 GetGeofence

=over

=item CollectionName => Str

=item GeofenceId => Str


=back

Each argument is described in detail in: L<Paws::LocationService::GetGeofence>

Returns: a L<Paws::LocationService::GetGeofenceResponse> instance

Retrieves the geofence details from a geofence collection.


=head2 GetMapGlyphs

=over

=item FontStack => Str

=item FontUnicodeRange => Str

=item MapName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::GetMapGlyphs>

Returns: a L<Paws::LocationService::GetMapGlyphsResponse> instance

Retrieves glyphs used to display labels on a map.


=head2 GetMapSprites

=over

=item FileName => Str

=item MapName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::GetMapSprites>

Returns: a L<Paws::LocationService::GetMapSpritesResponse> instance

Retrieves the sprite sheet corresponding to a map resource. The sprite
sheet is a PNG image paired with a JSON document describing the offsets
of individual icons that will be displayed on a rendered map.


=head2 GetMapStyleDescriptor

=over

=item MapName => Str


=back

Each argument is described in detail in: L<Paws::LocationService::GetMapStyleDescriptor>

Returns: a L<Paws::LocationService::GetMapStyleDescriptorResponse> instance

Retrieves the map style descriptor from a map resource.

The style descriptor contains specications on how features render on a
map. For example, what data to display, what order to display the data
in, and the style for the data. Style descriptors follow the Mapbox
Style Specification.


=head2 GetMapTile

=over

=item MapName => Str

=item X => Str

=item Y => Str

=item Z => Str


=back

Each argument is described in detail in: L<Paws::LocationService::GetMapTile>

Returns: a L<Paws::LocationService::GetMapTileResponse> instance

Retrieves a vector data tile from the map resource. Map tiles are used
by clients to render a map. they're addressed using a grid arrangement
with an X coordinate, Y coordinate, and Z (zoom) level.

The origin (0, 0) is the top left of the map. Increasing the zoom level
by 1 doubles both the X and Y dimensions, so a tile containing data for
the entire world at (0/0/0) will be split into 4 tiles at zoom 1
(1/0/0, 1/0/1, 1/1/0, 1/1/1).


=head2 ListDevicePositions

=over

=item TrackerName => Str

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::LocationService::ListDevicePositions>

Returns: a L<Paws::LocationService::ListDevicePositionsResponse> instance

Lists the latest device positions for requested devices.


=head2 ListGeofenceCollections

=over

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::LocationService::ListGeofenceCollections>

Returns: a L<Paws::LocationService::ListGeofenceCollectionsResponse> instance

Lists geofence collections in your AWS account.


=head2 ListGeofences

=over

=item CollectionName => Str

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::LocationService::ListGeofences>

Returns: a L<Paws::LocationService::ListGeofencesResponse> instance

Lists geofences stored in a given geofence collection.


=head2 ListMaps

=over

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::LocationService::ListMaps>

Returns: a L<Paws::LocationService::ListMapsResponse> instance

Lists map resources in your AWS account.


=head2 ListPlaceIndexes

=over

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::LocationService::ListPlaceIndexes>

Returns: a L<Paws::LocationService::ListPlaceIndexesResponse> instance

Lists place index resources in your AWS account.


=head2 ListRouteCalculators

=over

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::LocationService::ListRouteCalculators>

Returns: a L<Paws::LocationService::ListRouteCalculatorsResponse> instance

Lists route calculator resources in your AWS account.


=head2 ListTagsForResource

=over

=item ResourceArn => Str


=back

Each argument is described in detail in: L<Paws::LocationService::ListTagsForResource>

Returns: a L<Paws::LocationService::ListTagsForResourceResponse> instance

Returns the tags for the specified Amazon Location Service resource.


=head2 ListTrackerConsumers

=over

=item TrackerName => Str

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::LocationService::ListTrackerConsumers>

Returns: a L<Paws::LocationService::ListTrackerConsumersResponse> instance

Lists geofence collections currently associated to the given tracker
resource.


=head2 ListTrackers

=over

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::LocationService::ListTrackers>

Returns: a L<Paws::LocationService::ListTrackersResponse> instance

Lists tracker resources in your AWS account.


=head2 PutGeofence

=over

=item CollectionName => Str

=item GeofenceId => Str

=item Geometry => L<Paws::LocationService::GeofenceGeometry>


=back

Each argument is described in detail in: L<Paws::LocationService::PutGeofence>

Returns: a L<Paws::LocationService::PutGeofenceResponse> instance

Stores a geofence geometry in a given geofence collection, or updates
the geometry of an existing geofence if a geofence ID is included in
the request.


=head2 SearchPlaceIndexForPosition

=over

=item IndexName => Str

=item Position => ArrayRef[Num]

=item [MaxResults => Int]


=back

Each argument is described in detail in: L<Paws::LocationService::SearchPlaceIndexForPosition>

Returns: a L<Paws::LocationService::SearchPlaceIndexForPositionResponse> instance

Reverse geocodes a given coordinate and returns a legible address.
Allows you to search for Places or points of interest near a given
position.


=head2 SearchPlaceIndexForText

=over

=item IndexName => Str

=item Text => Str

=item [BiasPosition => ArrayRef[Num]]

=item [FilterBBox => ArrayRef[Num]]

=item [FilterCountries => ArrayRef[Str|Undef]]

=item [MaxResults => Int]


=back

Each argument is described in detail in: L<Paws::LocationService::SearchPlaceIndexForText>

Returns: a L<Paws::LocationService::SearchPlaceIndexForTextResponse> instance

Geocodes free-form text, such as an address, name, city, or region to
allow you to search for Places or points of interest.

Includes the option to apply additional parameters to narrow your list
of results.

You can search for places near a given position using C<BiasPosition>,
or filter results within a bounding box using C<FilterBBox>. Providing
both parameters simultaneously returns an error.


=head2 TagResource

=over

=item ResourceArn => Str

=item Tags => L<Paws::LocationService::TagMap>


=back

Each argument is described in detail in: L<Paws::LocationService::TagResource>

Returns: a L<Paws::LocationService::TagResourceResponse> instance

Assigns one or more tags (key-value pairs) to the specified Amazon
Location Service resource.

 <p>Tags can help you organize and categorize your resources. You can also use them to scope user permissions, by granting a user permission to access or change only resources with certain tag values.</p> <p>Tags don't have any semantic meaning to AWS and are interpreted strictly as strings of characters.</p> <p>You can use the <code>TagResource</code> action with an Amazon Location Service resource that already has tags. If you specify a new tag key for the resource, this tag is appended to the tags already associated with the resource. If you specify a tag key that is already associated with the resource, the new tag value that you specify replaces the previous value for that tag. </p> <p>You can associate as many as 50 tags with a resource.</p>


=head2 UntagResource

=over

=item ResourceArn => Str

=item TagKeys => ArrayRef[Str|Undef]


=back

Each argument is described in detail in: L<Paws::LocationService::UntagResource>

Returns: a L<Paws::LocationService::UntagResourceResponse> instance

Removes one or more tags from the specified Amazon Location Service
resource.




=head1 PAGINATORS

Paginator methods are helpers that repetively call methods that return partial results

=head2 GetAllDevicePositionHistory(sub { },DeviceId => Str, TrackerName => Str, [EndTimeExclusive => Str, NextToken => Str, StartTimeInclusive => Str])

=head2 GetAllDevicePositionHistory(DeviceId => Str, TrackerName => Str, [EndTimeExclusive => Str, NextToken => Str, StartTimeInclusive => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - DevicePositions, passing the object as the first parameter, and the string 'DevicePositions' as the second parameter 

If not, it will return a a L<Paws::LocationService::GetDevicePositionHistoryResponse> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.


=head2 ListAllDevicePositions(sub { },TrackerName => Str, [MaxResults => Int, NextToken => Str])

=head2 ListAllDevicePositions(TrackerName => Str, [MaxResults => Int, NextToken => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - Entries, passing the object as the first parameter, and the string 'Entries' as the second parameter 

If not, it will return a a L<Paws::LocationService::ListDevicePositionsResponse> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.


=head2 ListAllGeofenceCollections(sub { },[MaxResults => Int, NextToken => Str])

=head2 ListAllGeofenceCollections([MaxResults => Int, NextToken => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - Entries, passing the object as the first parameter, and the string 'Entries' as the second parameter 

If not, it will return a a L<Paws::LocationService::ListGeofenceCollectionsResponse> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.


=head2 ListAllGeofences(sub { },CollectionName => Str, [NextToken => Str])

=head2 ListAllGeofences(CollectionName => Str, [NextToken => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - Entries, passing the object as the first parameter, and the string 'Entries' as the second parameter 

If not, it will return a a L<Paws::LocationService::ListGeofencesResponse> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.


=head2 ListAllMaps(sub { },[MaxResults => Int, NextToken => Str])

=head2 ListAllMaps([MaxResults => Int, NextToken => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - Entries, passing the object as the first parameter, and the string 'Entries' as the second parameter 

If not, it will return a a L<Paws::LocationService::ListMapsResponse> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.


=head2 ListAllPlaceIndexes(sub { },[MaxResults => Int, NextToken => Str])

=head2 ListAllPlaceIndexes([MaxResults => Int, NextToken => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - Entries, passing the object as the first parameter, and the string 'Entries' as the second parameter 

If not, it will return a a L<Paws::LocationService::ListPlaceIndexesResponse> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.


=head2 ListAllRouteCalculators(sub { },[MaxResults => Int, NextToken => Str])

=head2 ListAllRouteCalculators([MaxResults => Int, NextToken => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - Entries, passing the object as the first parameter, and the string 'Entries' as the second parameter 

If not, it will return a a L<Paws::LocationService::ListRouteCalculatorsResponse> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.


=head2 ListAllTrackerConsumers(sub { },TrackerName => Str, [MaxResults => Int, NextToken => Str])

=head2 ListAllTrackerConsumers(TrackerName => Str, [MaxResults => Int, NextToken => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - ConsumerArns, passing the object as the first parameter, and the string 'ConsumerArns' as the second parameter 

If not, it will return a a L<Paws::LocationService::ListTrackerConsumersResponse> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.


=head2 ListAllTrackers(sub { },[MaxResults => Int, NextToken => Str])

=head2 ListAllTrackers([MaxResults => Int, NextToken => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - Entries, passing the object as the first parameter, and the string 'Entries' as the second parameter 

If not, it will return a a L<Paws::LocationService::ListTrackersResponse> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.





=head1 SEE ALSO

This service class forms part of L<Paws>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


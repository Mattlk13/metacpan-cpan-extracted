package Paws::IoTEvents;
  use Moose;
  sub service { 'iotevents' }
  sub signing_name { 'iotevents' }
  sub version { '2018-07-27' }
  sub flattened_arrays { 0 }
  has max_attempts => (is => 'ro', isa => 'Int', default => 5);
  has retry => (is => 'ro', isa => 'HashRef', default => sub {
    { base => 'rand', type => 'exponential', growth_factor => 2 }
  });
  has retriables => (is => 'ro', isa => 'ArrayRef', default => sub { [
  ] });

  with 'Paws::API::Caller', 'Paws::API::EndpointResolver', 'Paws::Net::V4Signature', 'Paws::Net::RestJsonCaller';

  
  sub CreateAlarmModel {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::CreateAlarmModel', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateDetectorModel {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::CreateDetectorModel', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateInput {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::CreateInput', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteAlarmModel {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::DeleteAlarmModel', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteDetectorModel {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::DeleteDetectorModel', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteInput {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::DeleteInput', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeAlarmModel {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::DescribeAlarmModel', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeDetectorModel {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::DescribeDetectorModel', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeDetectorModelAnalysis {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::DescribeDetectorModelAnalysis', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeInput {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::DescribeInput', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeLoggingOptions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::DescribeLoggingOptions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetDetectorModelAnalysisResults {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::GetDetectorModelAnalysisResults', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListAlarmModels {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::ListAlarmModels', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListAlarmModelVersions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::ListAlarmModelVersions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListDetectorModels {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::ListDetectorModels', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListDetectorModelVersions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::ListDetectorModelVersions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListInputRoutings {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::ListInputRoutings', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListInputs {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::ListInputs', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListTagsForResource {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::ListTagsForResource', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub PutLoggingOptions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::PutLoggingOptions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub StartDetectorModelAnalysis {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::StartDetectorModelAnalysis', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub TagResource {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::TagResource', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UntagResource {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::UntagResource', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateAlarmModel {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::UpdateAlarmModel', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateDetectorModel {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::UpdateDetectorModel', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateInput {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::IoTEvents::UpdateInput', @_);
    return $self->caller->do_call($self, $call_object);
  }
  


  sub operations { qw/CreateAlarmModel CreateDetectorModel CreateInput DeleteAlarmModel DeleteDetectorModel DeleteInput DescribeAlarmModel DescribeDetectorModel DescribeDetectorModelAnalysis DescribeInput DescribeLoggingOptions GetDetectorModelAnalysisResults ListAlarmModels ListAlarmModelVersions ListDetectorModels ListDetectorModelVersions ListInputRoutings ListInputs ListTagsForResource PutLoggingOptions StartDetectorModelAnalysis TagResource UntagResource UpdateAlarmModel UpdateDetectorModel UpdateInput / }

1;

### main pod documentation begin ###

=head1 NAME

Paws::IoTEvents - Perl Interface to AWS AWS IoT Events

=head1 SYNOPSIS

  use Paws;

  my $obj = Paws->service('IoTEvents');
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

AWS IoT Events monitors your equipment or device fleets for failures or
changes in operation, and triggers actions when such events occur. You
can use AWS IoT Events API operations to create, read, update, and
delete inputs and detector models, and to list their versions.

For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/iotevents-2018-07-27>


=head1 METHODS

=head2 CreateAlarmModel

=over

=item AlarmModelName => Str

=item AlarmRule => L<Paws::IoTEvents::AlarmRule>

=item RoleArn => Str

=item [AlarmCapabilities => L<Paws::IoTEvents::AlarmCapabilities>]

=item [AlarmEventActions => L<Paws::IoTEvents::AlarmEventActions>]

=item [AlarmModelDescription => Str]

=item [AlarmNotification => L<Paws::IoTEvents::AlarmNotification>]

=item [Key => Str]

=item [Severity => Int]

=item [Tags => ArrayRef[L<Paws::IoTEvents::Tag>]]


=back

Each argument is described in detail in: L<Paws::IoTEvents::CreateAlarmModel>

Returns: a L<Paws::IoTEvents::CreateAlarmModelResponse> instance

Creates an alarm model to monitor an AWS IoT Events input attribute.
You can use the alarm to get notified when the value is outside a
specified range. For more information, see Create an alarm model
(https://docs.aws.amazon.com/iotevents/latest/developerguide/create-alarms.html)
in the I<AWS IoT Events Developer Guide>.


=head2 CreateDetectorModel

=over

=item DetectorModelDefinition => L<Paws::IoTEvents::DetectorModelDefinition>

=item DetectorModelName => Str

=item RoleArn => Str

=item [DetectorModelDescription => Str]

=item [EvaluationMethod => Str]

=item [Key => Str]

=item [Tags => ArrayRef[L<Paws::IoTEvents::Tag>]]


=back

Each argument is described in detail in: L<Paws::IoTEvents::CreateDetectorModel>

Returns: a L<Paws::IoTEvents::CreateDetectorModelResponse> instance

Creates a detector model.


=head2 CreateInput

=over

=item InputDefinition => L<Paws::IoTEvents::InputDefinition>

=item InputName => Str

=item [InputDescription => Str]

=item [Tags => ArrayRef[L<Paws::IoTEvents::Tag>]]


=back

Each argument is described in detail in: L<Paws::IoTEvents::CreateInput>

Returns: a L<Paws::IoTEvents::CreateInputResponse> instance

Creates an input.


=head2 DeleteAlarmModel

=over

=item AlarmModelName => Str


=back

Each argument is described in detail in: L<Paws::IoTEvents::DeleteAlarmModel>

Returns: a L<Paws::IoTEvents::DeleteAlarmModelResponse> instance

Deletes an alarm model. Any alarm instances that were created based on
this alarm model are also deleted. This action can't be undone.


=head2 DeleteDetectorModel

=over

=item DetectorModelName => Str


=back

Each argument is described in detail in: L<Paws::IoTEvents::DeleteDetectorModel>

Returns: a L<Paws::IoTEvents::DeleteDetectorModelResponse> instance

Deletes a detector model. Any active instances of the detector model
are also deleted.


=head2 DeleteInput

=over

=item InputName => Str


=back

Each argument is described in detail in: L<Paws::IoTEvents::DeleteInput>

Returns: a L<Paws::IoTEvents::DeleteInputResponse> instance

Deletes an input.


=head2 DescribeAlarmModel

=over

=item AlarmModelName => Str

=item [AlarmModelVersion => Str]


=back

Each argument is described in detail in: L<Paws::IoTEvents::DescribeAlarmModel>

Returns: a L<Paws::IoTEvents::DescribeAlarmModelResponse> instance

Retrieves information about an alarm model. If you don't specify a
value for the C<alarmModelVersion> parameter, the latest version is
returned.


=head2 DescribeDetectorModel

=over

=item DetectorModelName => Str

=item [DetectorModelVersion => Str]


=back

Each argument is described in detail in: L<Paws::IoTEvents::DescribeDetectorModel>

Returns: a L<Paws::IoTEvents::DescribeDetectorModelResponse> instance

Describes a detector model. If the C<version> parameter is not
specified, information about the latest version is returned.


=head2 DescribeDetectorModelAnalysis

=over

=item AnalysisId => Str


=back

Each argument is described in detail in: L<Paws::IoTEvents::DescribeDetectorModelAnalysis>

Returns: a L<Paws::IoTEvents::DescribeDetectorModelAnalysisResponse> instance

Retrieves runtime information about a detector model analysis.

After AWS IoT Events starts analyzing your detector model, you have up
to 24 hours to retrieve the analysis results.


=head2 DescribeInput

=over

=item InputName => Str


=back

Each argument is described in detail in: L<Paws::IoTEvents::DescribeInput>

Returns: a L<Paws::IoTEvents::DescribeInputResponse> instance

Describes an input.


=head2 DescribeLoggingOptions






Each argument is described in detail in: L<Paws::IoTEvents::DescribeLoggingOptions>

Returns: a L<Paws::IoTEvents::DescribeLoggingOptionsResponse> instance

Retrieves the current settings of the AWS IoT Events logging options.


=head2 GetDetectorModelAnalysisResults

=over

=item AnalysisId => Str

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::IoTEvents::GetDetectorModelAnalysisResults>

Returns: a L<Paws::IoTEvents::GetDetectorModelAnalysisResultsResponse> instance

Retrieves one or more analysis results of the detector model.

After AWS IoT Events starts analyzing your detector model, you have up
to 24 hours to retrieve the analysis results.


=head2 ListAlarmModels

=over

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::IoTEvents::ListAlarmModels>

Returns: a L<Paws::IoTEvents::ListAlarmModelsResponse> instance

Lists the alarm models that you created. The operation returns only the
metadata associated with each alarm model.


=head2 ListAlarmModelVersions

=over

=item AlarmModelName => Str

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::IoTEvents::ListAlarmModelVersions>

Returns: a L<Paws::IoTEvents::ListAlarmModelVersionsResponse> instance

Lists all the versions of an alarm model. The operation returns only
the metadata associated with each alarm model version.


=head2 ListDetectorModels

=over

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::IoTEvents::ListDetectorModels>

Returns: a L<Paws::IoTEvents::ListDetectorModelsResponse> instance

Lists the detector models you have created. Only the metadata
associated with each detector model is returned.


=head2 ListDetectorModelVersions

=over

=item DetectorModelName => Str

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::IoTEvents::ListDetectorModelVersions>

Returns: a L<Paws::IoTEvents::ListDetectorModelVersionsResponse> instance

Lists all the versions of a detector model. Only the metadata
associated with each detector model version is returned.


=head2 ListInputRoutings

=over

=item InputIdentifier => L<Paws::IoTEvents::InputIdentifier>

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::IoTEvents::ListInputRoutings>

Returns: a L<Paws::IoTEvents::ListInputRoutingsResponse> instance

Lists one or more input routings.


=head2 ListInputs

=over

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::IoTEvents::ListInputs>

Returns: a L<Paws::IoTEvents::ListInputsResponse> instance

Lists the inputs you have created.


=head2 ListTagsForResource

=over

=item ResourceArn => Str


=back

Each argument is described in detail in: L<Paws::IoTEvents::ListTagsForResource>

Returns: a L<Paws::IoTEvents::ListTagsForResourceResponse> instance

Lists the tags (metadata) you have assigned to the resource.


=head2 PutLoggingOptions

=over

=item LoggingOptions => L<Paws::IoTEvents::LoggingOptions>


=back

Each argument is described in detail in: L<Paws::IoTEvents::PutLoggingOptions>

Returns: nothing

Sets or updates the AWS IoT Events logging options.

If you update the value of any C<loggingOptions> field, it takes up to
one minute for the change to take effect. If you change the policy
attached to the role you specified in the C<roleArn> field (for
example, to correct an invalid policy), it takes up to five minutes for
that change to take effect.


=head2 StartDetectorModelAnalysis

=over

=item DetectorModelDefinition => L<Paws::IoTEvents::DetectorModelDefinition>


=back

Each argument is described in detail in: L<Paws::IoTEvents::StartDetectorModelAnalysis>

Returns: a L<Paws::IoTEvents::StartDetectorModelAnalysisResponse> instance

Performs an analysis of your detector model. For more information, see
Troubleshooting a detector model
(https://docs.aws.amazon.com/iotevents/latest/developerguide/iotevents-analyze-api.html)
in the I<AWS IoT Events Developer Guide>.


=head2 TagResource

=over

=item ResourceArn => Str

=item Tags => ArrayRef[L<Paws::IoTEvents::Tag>]


=back

Each argument is described in detail in: L<Paws::IoTEvents::TagResource>

Returns: a L<Paws::IoTEvents::TagResourceResponse> instance

Adds to or modifies the tags of the given resource. Tags are metadata
that can be used to manage a resource.


=head2 UntagResource

=over

=item ResourceArn => Str

=item TagKeys => ArrayRef[Str|Undef]


=back

Each argument is described in detail in: L<Paws::IoTEvents::UntagResource>

Returns: a L<Paws::IoTEvents::UntagResourceResponse> instance

Removes the given tags (metadata) from the resource.


=head2 UpdateAlarmModel

=over

=item AlarmModelName => Str

=item AlarmRule => L<Paws::IoTEvents::AlarmRule>

=item RoleArn => Str

=item [AlarmCapabilities => L<Paws::IoTEvents::AlarmCapabilities>]

=item [AlarmEventActions => L<Paws::IoTEvents::AlarmEventActions>]

=item [AlarmModelDescription => Str]

=item [AlarmNotification => L<Paws::IoTEvents::AlarmNotification>]

=item [Severity => Int]


=back

Each argument is described in detail in: L<Paws::IoTEvents::UpdateAlarmModel>

Returns: a L<Paws::IoTEvents::UpdateAlarmModelResponse> instance

Updates an alarm model. Any alarms that were created based on the
previous version are deleted and then created again as new data
arrives.


=head2 UpdateDetectorModel

=over

=item DetectorModelDefinition => L<Paws::IoTEvents::DetectorModelDefinition>

=item DetectorModelName => Str

=item RoleArn => Str

=item [DetectorModelDescription => Str]

=item [EvaluationMethod => Str]


=back

Each argument is described in detail in: L<Paws::IoTEvents::UpdateDetectorModel>

Returns: a L<Paws::IoTEvents::UpdateDetectorModelResponse> instance

Updates a detector model. Detectors (instances) spawned by the previous
version are deleted and then re-created as new inputs arrive.


=head2 UpdateInput

=over

=item InputDefinition => L<Paws::IoTEvents::InputDefinition>

=item InputName => Str

=item [InputDescription => Str]


=back

Each argument is described in detail in: L<Paws::IoTEvents::UpdateInput>

Returns: a L<Paws::IoTEvents::UpdateInputResponse> instance

Updates an input.




=head1 PAGINATORS

Paginator methods are helpers that repetively call methods that return partial results




=head1 SEE ALSO

This service class forms part of L<Paws>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


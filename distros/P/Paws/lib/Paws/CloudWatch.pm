package Paws::CloudWatch;
  use Moose;
  sub service { 'monitoring' }
  sub version { '2010-08-01' }
  sub flattened_arrays { 0 }
  has max_attempts => (is => 'ro', isa => 'Int', default => 5);
  has retry => (is => 'ro', isa => 'HashRef', default => sub {
    { base => 'rand', type => 'exponential', growth_factor => 2 }
  });
  has retriables => (is => 'ro', isa => 'ArrayRef', default => sub { [
  ] });

  with 'Paws::API::Caller', 'Paws::API::EndpointResolver', 'Paws::Net::V4Signature', 'Paws::Net::QueryCaller', 'Paws::Net::XMLResponse';

  
  sub DeleteAlarms {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::CloudWatch::DeleteAlarms', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeAlarmHistory {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::CloudWatch::DescribeAlarmHistory', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeAlarms {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::CloudWatch::DescribeAlarms', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeAlarmsForMetric {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::CloudWatch::DescribeAlarmsForMetric', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DisableAlarmActions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::CloudWatch::DisableAlarmActions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub EnableAlarmActions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::CloudWatch::EnableAlarmActions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub GetMetricStatistics {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::CloudWatch::GetMetricStatistics', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListMetrics {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::CloudWatch::ListMetrics', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub PutMetricAlarm {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::CloudWatch::PutMetricAlarm', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub PutMetricData {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::CloudWatch::PutMetricData', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub SetAlarmState {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::CloudWatch::SetAlarmState', @_);
    return $self->caller->do_call($self, $call_object);
  }
  
  sub DescribeAllAlarmHistory {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->DescribeAlarmHistory(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->DescribeAlarmHistory(@_, NextToken => $next_result->NextToken);
        push @{ $result->AlarmHistoryItems }, @{ $next_result->AlarmHistoryItems };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'AlarmHistoryItems') foreach (@{ $result->AlarmHistoryItems });
        $result = $self->DescribeAlarmHistory(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'AlarmHistoryItems') foreach (@{ $result->AlarmHistoryItems });
    }

    return undef
  }
  sub DescribeAllAlarms {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->DescribeAlarms(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->DescribeAlarms(@_, NextToken => $next_result->NextToken);
        push @{ $result->MetricAlarms }, @{ $next_result->MetricAlarms };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'MetricAlarms') foreach (@{ $result->MetricAlarms });
        $result = $self->DescribeAlarms(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'MetricAlarms') foreach (@{ $result->MetricAlarms });
    }

    return undef
  }
  sub ListAllMetrics {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->ListMetrics(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->ListMetrics(@_, NextToken => $next_result->NextToken);
        push @{ $result->Metrics }, @{ $next_result->Metrics };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'Metrics') foreach (@{ $result->Metrics });
        $result = $self->ListMetrics(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'Metrics') foreach (@{ $result->Metrics });
    }

    return undef
  }


  sub operations { qw/DeleteAlarms DescribeAlarmHistory DescribeAlarms DescribeAlarmsForMetric DisableAlarmActions EnableAlarmActions GetMetricStatistics ListMetrics PutMetricAlarm PutMetricData SetAlarmState / }

1;

### main pod documentation begin ###

=head1 NAME

Paws::CloudWatch - Perl Interface to AWS Amazon CloudWatch

=head1 SYNOPSIS

  use Paws;

  my $obj = Paws->service('CloudWatch');
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

Amazon CloudWatch monitors your Amazon Web Services (AWS) resources and
the applications you run on AWS in real-time. You can use CloudWatch to
collect and track metrics, which are the variables you want to measure
for your resources and applications.

CloudWatch alarms send notifications or automatically make changes to
the resources you are monitoring based on rules that you define. For
example, you can monitor the CPU usage and disk reads and writes of
your Amazon Elastic Compute Cloud (Amazon EC2) instances and then use
this data to determine whether you should launch additional instances
to handle increased load. You can also use this data to stop under-used
instances to save money.

In addition to monitoring the built-in metrics that come with AWS, you
can monitor your own custom metrics. With CloudWatch, you gain
system-wide visibility into resource utilization, application
performance, and operational health.

=head1 METHODS

=head2 DeleteAlarms(AlarmNames => ArrayRef[Str|Undef])

Each argument is described in detail in: L<Paws::CloudWatch::DeleteAlarms>

Returns: nothing

  Deletes the specified alarms. In the event of an error, no alarms are
deleted.


=head2 DescribeAlarmHistory([AlarmName => Str, EndDate => Str, HistoryItemType => Str, MaxRecords => Int, NextToken => Str, StartDate => Str])

Each argument is described in detail in: L<Paws::CloudWatch::DescribeAlarmHistory>

Returns: a L<Paws::CloudWatch::DescribeAlarmHistoryOutput> instance

  Retrieves the history for the specified alarm. You can filter the
results by date range or item type. If an alarm name is not specified,
the histories for all alarms are returned.

Note that Amazon CloudWatch retains the history of an alarm even if you
delete the alarm.


=head2 DescribeAlarms([ActionPrefix => Str, AlarmNamePrefix => Str, AlarmNames => ArrayRef[Str|Undef], MaxRecords => Int, NextToken => Str, StateValue => Str])

Each argument is described in detail in: L<Paws::CloudWatch::DescribeAlarms>

Returns: a L<Paws::CloudWatch::DescribeAlarmsOutput> instance

  Retrieves the specified alarms. If no alarms are specified, all alarms
are returned. Alarms can be retrieved by using only a prefix for the
alarm name, the alarm state, or a prefix for any action.


=head2 DescribeAlarmsForMetric(MetricName => Str, Namespace => Str, [Dimensions => ArrayRef[L<Paws::CloudWatch::Dimension>], ExtendedStatistic => Str, Period => Int, Statistic => Str, Unit => Str])

Each argument is described in detail in: L<Paws::CloudWatch::DescribeAlarmsForMetric>

Returns: a L<Paws::CloudWatch::DescribeAlarmsForMetricOutput> instance

  Retrieves the alarms for the specified metric. Specify a statistic,
period, or unit to filter the results.


=head2 DisableAlarmActions(AlarmNames => ArrayRef[Str|Undef])

Each argument is described in detail in: L<Paws::CloudWatch::DisableAlarmActions>

Returns: nothing

  Disables the actions for the specified alarms. When an alarm's actions
are disabled, the alarm actions do not execute when the alarm state
changes.


=head2 EnableAlarmActions(AlarmNames => ArrayRef[Str|Undef])

Each argument is described in detail in: L<Paws::CloudWatch::EnableAlarmActions>

Returns: nothing

  Enables the actions for the specified alarms.


=head2 GetMetricStatistics(EndTime => Str, MetricName => Str, Namespace => Str, Period => Int, StartTime => Str, [Dimensions => ArrayRef[L<Paws::CloudWatch::Dimension>], ExtendedStatistics => ArrayRef[Str|Undef], Statistics => ArrayRef[Str|Undef], Unit => Str])

Each argument is described in detail in: L<Paws::CloudWatch::GetMetricStatistics>

Returns: a L<Paws::CloudWatch::GetMetricStatisticsOutput> instance

  Gets statistics for the specified metric.

Amazon CloudWatch retains metric data as follows:

=over

=item *

Data points with a period of 60 seconds (1 minute) are available for 15
days

=item *

Data points with a period of 300 seconds (5 minute) are available for
63 days

=item *

Data points with a period of 3600 seconds (1 hour) are available for
455 days (15 months)

=back

Note that CloudWatch started retaining 5-minute and 1-hour metric data
as of 9 July 2016.

The maximum number of data points returned from a single call is 1,440.
If you request more than 1,440 data points, Amazon CloudWatch returns
an error. To reduce the number of data points, you can narrow the
specified time range and make multiple requests across adjacent time
ranges, or you can increase the specified period. A period can be as
short as one minute (60 seconds). Note that data points are not
returned in chronological order.

Amazon CloudWatch aggregates data points based on the length of the
period that you specify. For example, if you request statistics with a
one-hour period, Amazon CloudWatch aggregates all data points with time
stamps that fall within each one-hour period. Therefore, the number of
values aggregated by CloudWatch is larger than the number of data
points returned.

CloudWatch needs raw data points to calculate percentile statistics. If
you publish data using a statistic set instead, you cannot retrieve
percentile statistics for this data unless one of the following
conditions is true:

=over

=item *

The SampleCount of the statistic set is 1

=item *

The Min and the Max of the statistic set are equal

=back

For a list of metrics and dimensions supported by AWS services, see the
Amazon CloudWatch Metrics and Dimensions Reference in the I<Amazon
CloudWatch User Guide>.


=head2 ListMetrics([Dimensions => ArrayRef[L<Paws::CloudWatch::DimensionFilter>], MetricName => Str, Namespace => Str, NextToken => Str])

Each argument is described in detail in: L<Paws::CloudWatch::ListMetrics>

Returns: a L<Paws::CloudWatch::ListMetricsOutput> instance

  List the specified metrics. You can use the returned metrics with
GetMetricStatistics to obtain statistical data.

Up to 500 results are returned for any one call. To retrieve additional
results, use the returned token with subsequent calls.

After you create a metric, allow up to fifteen minutes before the
metric appears. Statistics about the metric, however, are available
sooner using GetMetricStatistics.


=head2 PutMetricAlarm(AlarmName => Str, ComparisonOperator => Str, EvaluationPeriods => Int, MetricName => Str, Namespace => Str, Period => Int, Threshold => Num, [ActionsEnabled => Bool, AlarmActions => ArrayRef[Str|Undef], AlarmDescription => Str, Dimensions => ArrayRef[L<Paws::CloudWatch::Dimension>], EvaluateLowSampleCountPercentile => Str, ExtendedStatistic => Str, InsufficientDataActions => ArrayRef[Str|Undef], OKActions => ArrayRef[Str|Undef], Statistic => Str, TreatMissingData => Str, Unit => Str])

Each argument is described in detail in: L<Paws::CloudWatch::PutMetricAlarm>

Returns: nothing

  Creates or updates an alarm and associates it with the specified
metric. Optionally, this operation can associate one or more Amazon SNS
resources with the alarm.

When this operation creates an alarm, the alarm state is immediately
set to C<INSUFFICIENT_DATA>. The alarm is evaluated and its state is
set appropriately. Any actions associated with the state are then
executed.

When you update an existing alarm, its state is left unchanged, but the
update completely overwrites the previous configuration of the alarm.

If you are an AWS Identity and Access Management (IAM) user, you must
have Amazon EC2 permissions for some operations:

=over

=item *

C<ec2:DescribeInstanceStatus> and C<ec2:DescribeInstances> for all
alarms on EC2 instance status metrics

=item *

C<ec2:StopInstances> for alarms with stop actions

=item *

C<ec2:TerminateInstances> for alarms with terminate actions

=item *

C<ec2:DescribeInstanceRecoveryAttribute> and C<ec2:RecoverInstances>
for alarms with recover actions

=back

If you have read/write permissions for Amazon CloudWatch but not for
Amazon EC2, you can still create an alarm, but the stop or terminate
actions won't be performed. However, if you are later granted the
required permissions, the alarm actions that you created earlier will
be performed.

If you are using an IAM role (for example, an Amazon EC2 instance
profile), you cannot stop or terminate the instance using alarm
actions. However, you can still see the alarm state and perform any
other actions such as Amazon SNS notifications or Auto Scaling
policies.

If you are using temporary security credentials granted using the AWS
Security Token Service (AWS STS), you cannot stop or terminate an
Amazon EC2 instance using alarm actions.

Note that you must create at least one stop, terminate, or reboot alarm
using the Amazon EC2 or CloudWatch console to create the
B<EC2ActionsAccess> IAM role. After this IAM role is created, you can
create stop, terminate, or reboot alarms using a command-line interface
or an API.


=head2 PutMetricData(MetricData => ArrayRef[L<Paws::CloudWatch::MetricDatum>], Namespace => Str)

Each argument is described in detail in: L<Paws::CloudWatch::PutMetricData>

Returns: nothing

  Publishes metric data points to Amazon CloudWatch. Amazon CloudWatch
associates the data points with the specified metric. If the specified
metric does not exist, Amazon CloudWatch creates the metric. When
Amazon CloudWatch creates a metric, it can take up to fifteen minutes
for the metric to appear in calls to ListMetrics.

Each C<PutMetricData> request is limited to 40 KB in size for HTTP POST
requests.

Although the C<Value> parameter accepts numbers of type C<Double>,
Amazon CloudWatch rejects values that are either too small or too
large. Values must be in the range of 8.515920e-109 to 1.174271e+108
(Base 10) or 2e-360 to 2e360 (Base 2). In addition, special values
(e.g., NaN, +Infinity, -Infinity) are not supported.

You can use up to 10 dimensions per metric to further clarify what data
the metric collects. For more information on specifying dimensions, see
Publishing Metrics in the I<Amazon CloudWatch User Guide>.

Data points with time stamps from 24 hours ago or longer can take at
least 48 hours to become available for GetMetricStatistics from the
time they are submitted.

CloudWatch needs raw data points to calculate percentile statistics. If
you publish data using a statistic set instead, you cannot retrieve
percentile statistics for this data unless one of the following
conditions is true:

=over

=item *

The SampleCount of the statistic set is 1

=item *

The Min and the Max of the statistic set are equal

=back



=head2 SetAlarmState(AlarmName => Str, StateReason => Str, StateValue => Str, [StateReasonData => Str])

Each argument is described in detail in: L<Paws::CloudWatch::SetAlarmState>

Returns: nothing

  Temporarily sets the state of an alarm for testing purposes. When the
updated state differs from the previous value, the action configured
for the appropriate state is invoked. For example, if your alarm is
configured to send an Amazon SNS message when an alarm is triggered,
temporarily changing the alarm state to C<ALARM> sends an Amazon SNS
message. The alarm returns to its actual state (often within seconds).
Because the alarm state change happens very quickly, it is typically
only visible in the alarm's B<History> tab in the Amazon CloudWatch
console or through DescribeAlarmHistory.




=head1 PAGINATORS

Paginator methods are helpers that repetively call methods that return partial results

=head2 DescribeAllAlarmHistory(sub { },[AlarmName => Str, EndDate => Str, HistoryItemType => Str, MaxRecords => Int, NextToken => Str, StartDate => Str])

=head2 DescribeAllAlarmHistory([AlarmName => Str, EndDate => Str, HistoryItemType => Str, MaxRecords => Int, NextToken => Str, StartDate => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - AlarmHistoryItems, passing the object as the first parameter, and the string 'AlarmHistoryItems' as the second parameter 

If not, it will return a a L<Paws::CloudWatch::DescribeAlarmHistoryOutput> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.


=head2 DescribeAllAlarms(sub { },[ActionPrefix => Str, AlarmNamePrefix => Str, AlarmNames => ArrayRef[Str|Undef], MaxRecords => Int, NextToken => Str, StateValue => Str])

=head2 DescribeAllAlarms([ActionPrefix => Str, AlarmNamePrefix => Str, AlarmNames => ArrayRef[Str|Undef], MaxRecords => Int, NextToken => Str, StateValue => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - MetricAlarms, passing the object as the first parameter, and the string 'MetricAlarms' as the second parameter 

If not, it will return a a L<Paws::CloudWatch::DescribeAlarmsOutput> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.


=head2 ListAllMetrics(sub { },[Dimensions => ArrayRef[L<Paws::CloudWatch::DimensionFilter>], MetricName => Str, Namespace => Str, NextToken => Str])

=head2 ListAllMetrics([Dimensions => ArrayRef[L<Paws::CloudWatch::DimensionFilter>], MetricName => Str, Namespace => Str, NextToken => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - Metrics, passing the object as the first parameter, and the string 'Metrics' as the second parameter 

If not, it will return a a L<Paws::CloudWatch::ListMetricsOutput> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.





=head1 SEE ALSO

This service class forms part of L<Paws>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: https://github.com/pplu/aws-sdk-perl

Please report bugs to: https://github.com/pplu/aws-sdk-perl/issues

=cut



package Paws::CloudWatch::PutMetricAlarm;
  use Moose;
  has ActionsEnabled => (is => 'ro', isa => 'Bool');
  has AlarmActions => (is => 'ro', isa => 'ArrayRef[Str|Undef]');
  has AlarmDescription => (is => 'ro', isa => 'Str');
  has AlarmName => (is => 'ro', isa => 'Str', required => 1);
  has ComparisonOperator => (is => 'ro', isa => 'Str', required => 1);
  has DatapointsToAlarm => (is => 'ro', isa => 'Int');
  has Dimensions => (is => 'ro', isa => 'ArrayRef[Paws::CloudWatch::Dimension]');
  has EvaluateLowSampleCountPercentile => (is => 'ro', isa => 'Str');
  has EvaluationPeriods => (is => 'ro', isa => 'Int', required => 1);
  has ExtendedStatistic => (is => 'ro', isa => 'Str');
  has InsufficientDataActions => (is => 'ro', isa => 'ArrayRef[Str|Undef]');
  has MetricName => (is => 'ro', isa => 'Str', required => 1);
  has Namespace => (is => 'ro', isa => 'Str', required => 1);
  has OKActions => (is => 'ro', isa => 'ArrayRef[Str|Undef]');
  has Period => (is => 'ro', isa => 'Int', required => 1);
  has Statistic => (is => 'ro', isa => 'Str');
  has Threshold => (is => 'ro', isa => 'Num', required => 1);
  has TreatMissingData => (is => 'ro', isa => 'Str');
  has Unit => (is => 'ro', isa => 'Str');

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'PutMetricAlarm');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::API::Response');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::CloudWatch::PutMetricAlarm - Arguments for method PutMetricAlarm on L<Paws::CloudWatch>

=head1 DESCRIPTION

This class represents the parameters used for calling the method PutMetricAlarm on the
L<Amazon CloudWatch|Paws::CloudWatch> service. Use the attributes of this class
as arguments to method PutMetricAlarm.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to PutMetricAlarm.

=head1 SYNOPSIS

    my $monitoring = Paws->service('CloudWatch');
    $monitoring->PutMetricAlarm(
      AlarmName          => 'MyAlarmName',
      ComparisonOperator => 'GreaterThanOrEqualToThreshold',
      EvaluationPeriods  => 1,
      MetricName         => 'MyMetricName',
      Namespace          => 'MyNamespace',
      Period             => 1,
      Threshold          => 1,
      ActionsEnabled     => 1,                                 # OPTIONAL
      AlarmActions       => [
        'MyResourceName', ...    # min: 1, max: 1024
      ],                         # OPTIONAL
      AlarmDescription  => 'MyAlarmDescription',    # OPTIONAL
      DatapointsToAlarm => 1,                       # OPTIONAL
      Dimensions        => [
        {
          Name  => 'MyDimensionName',               # min: 1, max: 255
          Value => 'MyDimensionValue',              # min: 1, max: 255

        },
        ...
      ],                                            # OPTIONAL
      EvaluateLowSampleCountPercentile =>
        'MyEvaluateLowSampleCountPercentile',       # OPTIONAL
      ExtendedStatistic       => 'MyExtendedStatistic',    # OPTIONAL
      InsufficientDataActions => [
        'MyResourceName', ...                              # min: 1, max: 1024
      ],                                                   # OPTIONAL
      OKActions => [
        'MyResourceName', ...                              # min: 1, max: 1024
      ],                                                   # OPTIONAL
      Statistic        => 'SampleCount',                   # OPTIONAL
      TreatMissingData => 'MyTreatMissingData',            # OPTIONAL
      Unit             => 'Seconds',                       # OPTIONAL
    );

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/monitoring/PutMetricAlarm>

=head1 ATTRIBUTES


=head2 ActionsEnabled => Bool

Indicates whether actions should be executed during any changes to the
alarm state.



=head2 AlarmActions => ArrayRef[Str|Undef]

The actions to execute when this alarm transitions to the C<ALARM>
state from any other state. Each action is specified as an Amazon
Resource Name (ARN).

Valid Values: arn:aws:automate:I<region>:ec2:stop |
arn:aws:automate:I<region>:ec2:terminate |
arn:aws:automate:I<region>:ec2:recover |
arn:aws:sns:I<region>:I<account-id>:I<sns-topic-name> |
arn:aws:autoscaling:I<region>:I<account-id>:scalingPolicy:I<policy-id>
autoScalingGroupName/I<group-friendly-name>:policyName/I<policy-friendly-name>

Valid Values (for use with IAM roles):
arn:aws:swf:I<region>:{I<account-id>}:action/actions/AWS_EC2.InstanceId.Stop/1.0
|
arn:aws:swf:I<region>:{I<account-id>}:action/actions/AWS_EC2.InstanceId.Terminate/1.0
|
arn:aws:swf:I<region>:{I<account-id>}:action/actions/AWS_EC2.InstanceId.Reboot/1.0



=head2 AlarmDescription => Str

The description for the alarm.



=head2 B<REQUIRED> AlarmName => Str

The name for the alarm. This name must be unique within the AWS
account.



=head2 B<REQUIRED> ComparisonOperator => Str

The arithmetic operation to use when comparing the specified statistic
and threshold. The specified statistic value is used as the first
operand.

Valid values are: C<"GreaterThanOrEqualToThreshold">, C<"GreaterThanThreshold">, C<"LessThanThreshold">, C<"LessThanOrEqualToThreshold">

=head2 DatapointsToAlarm => Int

The number of datapoints that must be breaching to trigger the alarm.
This is used only if you are setting an "M out of N" alarm. In that
case, this value is the M. For more information, see Evaluating an
Alarm
(http://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#alarm-evaluation)
in the I<Amazon CloudWatch User Guide>.



=head2 Dimensions => ArrayRef[L<Paws::CloudWatch::Dimension>]

The dimensions for the metric associated with the alarm.



=head2 EvaluateLowSampleCountPercentile => Str

Used only for alarms based on percentiles. If you specify C<ignore>,
the alarm state does not change during periods with too few data points
to be statistically significant. If you specify C<evaluate> or omit
this parameter, the alarm is always evaluated and possibly changes
state no matter how many data points are available. For more
information, see Percentile-Based CloudWatch Alarms and Low Data
Samples
(http://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#percentiles-with-low-samples).

Valid Values: C<evaluate | ignore>



=head2 B<REQUIRED> EvaluationPeriods => Int

The number of periods over which data is compared to the specified
threshold. If you are setting an alarm which requires that a number of
consecutive data points be breaching to trigger the alarm, this value
specifies that number. If you are setting an "M out of N" alarm, this
value is the N.

An alarm's total current evaluation period can be no longer than one
day, so this number multiplied by C<Period> cannot be more than 86,400
seconds.



=head2 ExtendedStatistic => Str

The percentile statistic for the metric associated with the alarm.
Specify a value between p0.0 and p100. When you call C<PutMetricAlarm>,
you must specify either C<Statistic> or C<ExtendedStatistic,> but not
both.



=head2 InsufficientDataActions => ArrayRef[Str|Undef]

The actions to execute when this alarm transitions to the
C<INSUFFICIENT_DATA> state from any other state. Each action is
specified as an Amazon Resource Name (ARN).

Valid Values: arn:aws:automate:I<region>:ec2:stop |
arn:aws:automate:I<region>:ec2:terminate |
arn:aws:automate:I<region>:ec2:recover |
arn:aws:sns:I<region>:I<account-id>:I<sns-topic-name> |
arn:aws:autoscaling:I<region>:I<account-id>:scalingPolicy:I<policy-id>
autoScalingGroupName/I<group-friendly-name>:policyName/I<policy-friendly-name>

Valid Values (for use with IAM roles):
arn:aws:swf:I<region>:{I<account-id>}:action/actions/AWS_EC2.InstanceId.Stop/1.0
|
arn:aws:swf:I<region>:{I<account-id>}:action/actions/AWS_EC2.InstanceId.Terminate/1.0
|
arn:aws:swf:I<region>:{I<account-id>}:action/actions/AWS_EC2.InstanceId.Reboot/1.0



=head2 B<REQUIRED> MetricName => Str

The name for the metric associated with the alarm.



=head2 B<REQUIRED> Namespace => Str

The namespace for the metric associated with the alarm.



=head2 OKActions => ArrayRef[Str|Undef]

The actions to execute when this alarm transitions to an C<OK> state
from any other state. Each action is specified as an Amazon Resource
Name (ARN).

Valid Values: arn:aws:automate:I<region>:ec2:stop |
arn:aws:automate:I<region>:ec2:terminate |
arn:aws:automate:I<region>:ec2:recover |
arn:aws:sns:I<region>:I<account-id>:I<sns-topic-name> |
arn:aws:autoscaling:I<region>:I<account-id>:scalingPolicy:I<policy-id>
autoScalingGroupName/I<group-friendly-name>:policyName/I<policy-friendly-name>

Valid Values (for use with IAM roles):
arn:aws:swf:I<region>:{I<account-id>}:action/actions/AWS_EC2.InstanceId.Stop/1.0
|
arn:aws:swf:I<region>:{I<account-id>}:action/actions/AWS_EC2.InstanceId.Terminate/1.0
|
arn:aws:swf:I<region>:{I<account-id>}:action/actions/AWS_EC2.InstanceId.Reboot/1.0



=head2 B<REQUIRED> Period => Int

The period, in seconds, over which the specified statistic is applied.
Valid values are 10, 30, and any multiple of 60.

Be sure to specify 10 or 30 only for metrics that are stored by a
C<PutMetricData> call with a C<StorageResolution> of 1. If you specify
a period of 10 or 30 for a metric that does not have sub-minute
resolution, the alarm still attempts to gather data at the period rate
that you specify. In this case, it does not receive data for the
attempts that do not correspond to a one-minute data resolution, and
the alarm may often lapse into INSUFFICENT_DATA status. Specifying 10
or 30 also sets this alarm as a high-resolution alarm, which has a
higher charge than other alarms. For more information about pricing,
see Amazon CloudWatch Pricing
(https://aws.amazon.com/cloudwatch/pricing/).

An alarm's total current evaluation period can be no longer than one
day, so C<Period> multiplied by C<EvaluationPeriods> cannot be more
than 86,400 seconds.



=head2 Statistic => Str

The statistic for the metric associated with the alarm, other than
percentile. For percentile statistics, use C<ExtendedStatistic>. When
you call C<PutMetricAlarm>, you must specify either C<Statistic> or
C<ExtendedStatistic,> but not both.

Valid values are: C<"SampleCount">, C<"Average">, C<"Sum">, C<"Minimum">, C<"Maximum">

=head2 B<REQUIRED> Threshold => Num

The value against which the specified statistic is compared.



=head2 TreatMissingData => Str

Sets how this alarm is to handle missing data points. If
C<TreatMissingData> is omitted, the default behavior of C<missing> is
used. For more information, see Configuring How CloudWatch Alarms
Treats Missing Data
(http://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html#alarms-and-missing-data).

Valid Values: C<breaching | notBreaching | ignore | missing>



=head2 Unit => Str

The unit of measure for the statistic. For example, the units for the
Amazon EC2 NetworkIn metric are Bytes because NetworkIn tracks the
number of bytes that an instance receives on all network interfaces.
You can also specify a unit when you create a custom metric. Units help
provide conceptual meaning to your data. Metric data points that
specify a unit of measure, such as Percent, are aggregated separately.

If you specify a unit, you must use a unit that is appropriate for the
metric. Otherwise, the CloudWatch alarm can get stuck in the
C<INSUFFICIENT DATA> state.

Valid values are: C<"Seconds">, C<"Microseconds">, C<"Milliseconds">, C<"Bytes">, C<"Kilobytes">, C<"Megabytes">, C<"Gigabytes">, C<"Terabytes">, C<"Bits">, C<"Kilobits">, C<"Megabits">, C<"Gigabits">, C<"Terabits">, C<"Percent">, C<"Count">, C<"Bytes/Second">, C<"Kilobytes/Second">, C<"Megabytes/Second">, C<"Gigabytes/Second">, C<"Terabytes/Second">, C<"Bits/Second">, C<"Kilobits/Second">, C<"Megabits/Second">, C<"Gigabits/Second">, C<"Terabits/Second">, C<"Count/Second">, C<"None">


=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method PutMetricAlarm in L<Paws::CloudWatch>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


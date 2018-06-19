
package Paws::Lambda::CreateEventSourceMapping;
  use Moose;
  has BatchSize => (is => 'ro', isa => 'Int');
  has Enabled => (is => 'ro', isa => 'Bool');
  has EventSourceArn => (is => 'ro', isa => 'Str', required => 1);
  has FunctionName => (is => 'ro', isa => 'Str', required => 1);
  has StartingPosition => (is => 'ro', isa => 'Str', required => 1);
  has StartingPositionTimestamp => (is => 'ro', isa => 'Str');

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'CreateEventSourceMapping');
  class_has _api_uri  => (isa => 'Str', is => 'ro', default => '/2015-03-31/event-source-mappings/');
  class_has _api_method  => (isa => 'Str', is => 'ro', default => 'POST');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::Lambda::EventSourceMappingConfiguration');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Lambda::CreateEventSourceMapping - Arguments for method CreateEventSourceMapping on L<Paws::Lambda>

=head1 DESCRIPTION

This class represents the parameters used for calling the method CreateEventSourceMapping on the
L<AWS Lambda|Paws::Lambda> service. Use the attributes of this class
as arguments to method CreateEventSourceMapping.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to CreateEventSourceMapping.

=head1 SYNOPSIS

    my $lambda = Paws->service('Lambda');
    my $EventSourceMappingConfiguration = $lambda->CreateEventSourceMapping(
      EventSourceArn            => 'MyArn',
      FunctionName              => 'MyFunctionName',
      StartingPosition          => 'TRIM_HORIZON',
      BatchSize                 => 1,                        # OPTIONAL
      Enabled                   => 1,                        # OPTIONAL
      StartingPositionTimestamp => '1970-01-01T01:00:00',    # OPTIONAL
    );

    # Results:
    my $BatchSize      = $EventSourceMappingConfiguration->BatchSize;
    my $EventSourceArn = $EventSourceMappingConfiguration->EventSourceArn;
    my $FunctionArn    = $EventSourceMappingConfiguration->FunctionArn;
    my $LastModified   = $EventSourceMappingConfiguration->LastModified;
    my $LastProcessingResult =
      $EventSourceMappingConfiguration->LastProcessingResult;
    my $State = $EventSourceMappingConfiguration->State;
    my $StateTransitionReason =
      $EventSourceMappingConfiguration->StateTransitionReason;
    my $UUID = $EventSourceMappingConfiguration->UUID;

    # Returns a L<Paws::Lambda::EventSourceMappingConfiguration> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/lambda/CreateEventSourceMapping>

=head1 ATTRIBUTES


=head2 BatchSize => Int

The largest number of records that AWS Lambda will retrieve from your
event source at the time of invoking your function. Your function
receives an event with all the retrieved records. The default is 100
records.



=head2 Enabled => Bool

Indicates whether AWS Lambda should begin polling the event source. By
default, C<Enabled> is true.



=head2 B<REQUIRED> EventSourceArn => Str

The Amazon Resource Name (ARN) of the Amazon Kinesis or the Amazon
DynamoDB stream that is the event source. Any record added to this
stream could cause AWS Lambda to invoke your Lambda function, it
depends on the C<BatchSize>. AWS Lambda POSTs the Amazon Kinesis event,
containing records, to your Lambda function as JSON.



=head2 B<REQUIRED> FunctionName => Str

The Lambda function to invoke when AWS Lambda detects an event on the
stream.

You can specify the function name (for example, C<Thumbnail>) or you
can specify Amazon Resource Name (ARN) of the function (for example,
C<arn:aws:lambda:us-west-2:account-id:function:ThumbNail>).

If you are using versioning, you can also provide a qualified function
ARN (ARN that is qualified with function version or alias name as
suffix). For more information about versioning, see AWS Lambda Function
Versioning and Aliases
(http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html)

AWS Lambda also allows you to specify only the function name with the
account ID qualifier (for example, C<account-id:Thumbnail>).

Note that the length constraint applies only to the ARN. If you specify
only the function name, it is limited to 64 characters in length.



=head2 B<REQUIRED> StartingPosition => Str

The position in the DynamoDB or Kinesis stream where AWS Lambda should
start reading. For more information, see GetShardIterator
(http://docs.aws.amazon.com/kinesis/latest/APIReference/API_GetShardIterator.html#Kinesis-GetShardIterator-request-ShardIteratorType)
in the I<Amazon Kinesis API Reference Guide> or GetShardIterator
(http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_streams_GetShardIterator.html)
in the I<Amazon DynamoDB API Reference Guide>. The C<AT_TIMESTAMP>
value is supported only for Kinesis streams
(http://docs.aws.amazon.com/streams/latest/dev/amazon-kinesis-streams.html).

Valid values are: C<"TRIM_HORIZON">, C<"LATEST">, C<"AT_TIMESTAMP">

=head2 StartingPositionTimestamp => Str

The timestamp of the data record from which to start reading. Used with
shard iterator type
(http://docs.aws.amazon.com/kinesis/latest/APIReference/API_GetShardIterator.html#Kinesis-GetShardIterator-request-ShardIteratorType)
AT_TIMESTAMP. If a record with this exact timestamp does not exist, the
iterator returned is for the next (later) record. If the timestamp is
older than the current trim horizon, the iterator returned is for the
oldest untrimmed data record (TRIM_HORIZON). Valid only for Kinesis
streams
(http://docs.aws.amazon.com/streams/latest/dev/amazon-kinesis-streams.html).




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method CreateEventSourceMapping in L<Paws::Lambda>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut



package Paws::CloudWatchEvents::DescribeRule;
  use Moose;
  has EventBusName => (is => 'ro', isa => 'Str');
  has Name => (is => 'ro', isa => 'Str', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'DescribeRule');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::CloudWatchEvents::DescribeRuleResponse');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::CloudWatchEvents::DescribeRule - Arguments for method DescribeRule on L<Paws::CloudWatchEvents>

=head1 DESCRIPTION

This class represents the parameters used for calling the method DescribeRule on the
L<Amazon EventBridge|Paws::CloudWatchEvents> service. Use the attributes of this class
as arguments to method DescribeRule.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to DescribeRule.

=head1 SYNOPSIS

    my $events = Paws->service('CloudWatchEvents');
    my $DescribeRuleResponse = $events->DescribeRule(
      Name         => 'MyRuleName',
      EventBusName => 'MyEventBusName',    # OPTIONAL
    );

    # Results:
    my $Arn                = $DescribeRuleResponse->Arn;
    my $Description        = $DescribeRuleResponse->Description;
    my $EventBusName       = $DescribeRuleResponse->EventBusName;
    my $EventPattern       = $DescribeRuleResponse->EventPattern;
    my $ManagedBy          = $DescribeRuleResponse->ManagedBy;
    my $Name               = $DescribeRuleResponse->Name;
    my $RoleArn            = $DescribeRuleResponse->RoleArn;
    my $ScheduleExpression = $DescribeRuleResponse->ScheduleExpression;
    my $State              = $DescribeRuleResponse->State;

    # Returns a L<Paws::CloudWatchEvents::DescribeRuleResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/events/DescribeRule>

=head1 ATTRIBUTES


=head2 EventBusName => Str

The event bus associated with the rule. If you omit this, the default
event bus is used.



=head2 B<REQUIRED> Name => Str

The name of the rule.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method DescribeRule in L<Paws::CloudWatchEvents>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


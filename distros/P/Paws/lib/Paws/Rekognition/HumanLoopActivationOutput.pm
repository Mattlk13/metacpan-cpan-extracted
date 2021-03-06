package Paws::Rekognition::HumanLoopActivationOutput;
  use Moose;
  has HumanLoopActivationConditionsEvaluationResults => (is => 'ro', isa => 'Str');
  has HumanLoopActivationReasons => (is => 'ro', isa => 'ArrayRef[Str|Undef]');
  has HumanLoopArn => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Rekognition::HumanLoopActivationOutput

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::Rekognition::HumanLoopActivationOutput object:

  $service_obj->Method(Att1 => { HumanLoopActivationConditionsEvaluationResults => $value, ..., HumanLoopArn => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::Rekognition::HumanLoopActivationOutput object:

  $result = $service_obj->Method(...);
  $result->Att1->HumanLoopActivationConditionsEvaluationResults

=head1 DESCRIPTION

Shows the results of the human in the loop evaluation. If there is no
HumanLoopArn, the input did not trigger human review.

=head1 ATTRIBUTES


=head2 HumanLoopActivationConditionsEvaluationResults => Str

  Shows the result of condition evaluations, including those conditions
which activated a human review.


=head2 HumanLoopActivationReasons => ArrayRef[Str|Undef]

  Shows if and why human review was needed.


=head2 HumanLoopArn => Str

  The Amazon Resource Name (ARN) of the HumanLoop created.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::Rekognition>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


package Paws::SageMaker::HyperParameterTuningJobConfig;
  use Moose;
  has HyperParameterTuningJobObjective => (is => 'ro', isa => 'Paws::SageMaker::HyperParameterTuningJobObjective', required => 1);
  has ParameterRanges => (is => 'ro', isa => 'Paws::SageMaker::ParameterRanges', required => 1);
  has ResourceLimits => (is => 'ro', isa => 'Paws::SageMaker::ResourceLimits', required => 1);
  has Strategy => (is => 'ro', isa => 'Str', required => 1);
1;

### main pod documentation begin ###

=head1 NAME

Paws::SageMaker::HyperParameterTuningJobConfig

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::SageMaker::HyperParameterTuningJobConfig object:

  $service_obj->Method(Att1 => { HyperParameterTuningJobObjective => $value, ..., Strategy => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::SageMaker::HyperParameterTuningJobConfig object:

  $result = $service_obj->Method(...);
  $result->Att1->HyperParameterTuningJobObjective

=head1 DESCRIPTION

Configures a hyperparameter tuning job.

=head1 ATTRIBUTES


=head2 B<REQUIRED> HyperParameterTuningJobObjective => L<Paws::SageMaker::HyperParameterTuningJobObjective>

  The object that specifies the objective metric for this tuning job.


=head2 B<REQUIRED> ParameterRanges => L<Paws::SageMaker::ParameterRanges>

  The object that specifies the ranges of hyperparameters that this
tuning job searches.


=head2 B<REQUIRED> ResourceLimits => L<Paws::SageMaker::ResourceLimits>

  The object that specifies the maximum number of training jobs and
parallel training jobs for this tuning job.


=head2 B<REQUIRED> Strategy => Str

  Specifies the search strategy for hyperparameters. Currently, the only
valid value is C<Bayesian>.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::SageMaker>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


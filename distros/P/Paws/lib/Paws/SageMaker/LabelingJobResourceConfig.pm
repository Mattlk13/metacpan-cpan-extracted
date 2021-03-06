package Paws::SageMaker::LabelingJobResourceConfig;
  use Moose;
  has VolumeKmsKeyId => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::SageMaker::LabelingJobResourceConfig

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::SageMaker::LabelingJobResourceConfig object:

  $service_obj->Method(Att1 => { VolumeKmsKeyId => $value, ..., VolumeKmsKeyId => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::SageMaker::LabelingJobResourceConfig object:

  $result = $service_obj->Method(...);
  $result->Att1->VolumeKmsKeyId

=head1 DESCRIPTION

Provides configuration information for labeling jobs.

=head1 ATTRIBUTES


=head2 VolumeKmsKeyId => Str

  The AWS Key Management Service (AWS KMS) key that Amazon SageMaker uses
to encrypt data on the storage volume attached to the ML compute
instance(s) that run the training job. The C<VolumeKmsKeyId> can be any
of the following formats:

=over

=item *

// KMS Key ID

C<"1234abcd-12ab-34cd-56ef-1234567890ab">

=item *

// Amazon Resource Name (ARN) of a KMS Key

C<"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab">

=back




=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::SageMaker>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut



package Paws::SageMaker::DeleteFeatureGroup;
  use Moose;
  has FeatureGroupName => (is => 'ro', isa => 'Str', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'DeleteFeatureGroup');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::API::Response');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::SageMaker::DeleteFeatureGroup - Arguments for method DeleteFeatureGroup on L<Paws::SageMaker>

=head1 DESCRIPTION

This class represents the parameters used for calling the method DeleteFeatureGroup on the
L<Amazon SageMaker Service|Paws::SageMaker> service. Use the attributes of this class
as arguments to method DeleteFeatureGroup.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to DeleteFeatureGroup.

=head1 SYNOPSIS

    my $api.sagemaker = Paws->service('SageMaker');
    $api . sagemaker->DeleteFeatureGroup(
      FeatureGroupName => 'MyFeatureGroupName',

    );

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/api.sagemaker/DeleteFeatureGroup>

=head1 ATTRIBUTES


=head2 B<REQUIRED> FeatureGroupName => Str

The name of the C<FeatureGroup> you want to delete. The name must be
unique within an Amazon Web Services Region in an Amazon Web Services
account.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method DeleteFeatureGroup in L<Paws::SageMaker>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


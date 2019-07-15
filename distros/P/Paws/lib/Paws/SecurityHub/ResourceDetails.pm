package Paws::SecurityHub::ResourceDetails;
  use Moose;
  has AwsEc2Instance => (is => 'ro', isa => 'Paws::SecurityHub::AwsEc2InstanceDetails');
  has AwsIamAccessKey => (is => 'ro', isa => 'Paws::SecurityHub::AwsIamAccessKeyDetails');
  has AwsS3Bucket => (is => 'ro', isa => 'Paws::SecurityHub::AwsS3BucketDetails');
  has Container => (is => 'ro', isa => 'Paws::SecurityHub::ContainerDetails');
  has Other => (is => 'ro', isa => 'Paws::SecurityHub::FieldMap');
1;

### main pod documentation begin ###

=head1 NAME

Paws::SecurityHub::ResourceDetails

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::SecurityHub::ResourceDetails object:

  $service_obj->Method(Att1 => { AwsEc2Instance => $value, ..., Other => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::SecurityHub::ResourceDetails object:

  $result = $service_obj->Method(...);
  $result->Att1->AwsEc2Instance

=head1 DESCRIPTION

Additional details about a resource related to a finding.

=head1 ATTRIBUTES


=head2 AwsEc2Instance => L<Paws::SecurityHub::AwsEc2InstanceDetails>

  Details about an Amazon EC2 instance related to a finding.


=head2 AwsIamAccessKey => L<Paws::SecurityHub::AwsIamAccessKeyDetails>

  Details about an IAM access key related to a finding.


=head2 AwsS3Bucket => L<Paws::SecurityHub::AwsS3BucketDetails>

  Details about an Amazon S3 Bucket related to a finding.


=head2 Container => L<Paws::SecurityHub::ContainerDetails>

  Details about a container resource related to a finding.


=head2 Other => L<Paws::SecurityHub::FieldMap>

  Details about a resource that doesn't have a specific type defined.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::SecurityHub>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


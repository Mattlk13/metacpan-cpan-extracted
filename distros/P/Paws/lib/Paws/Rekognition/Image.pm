package Paws::Rekognition::Image;
  use Moose;
  has Bytes => (is => 'ro', isa => 'Str');
  has S3Object => (is => 'ro', isa => 'Paws::Rekognition::S3Object');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Rekognition::Image

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::Rekognition::Image object:

  $service_obj->Method(Att1 => { Bytes => $value, ..., S3Object => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::Rekognition::Image object:

  $result = $service_obj->Method(...);
  $result->Att1->Bytes

=head1 DESCRIPTION

Provides the source image either as bytes or an S3 object.

The region for the S3 bucket containing the S3 object must match the
region you use for Amazon Rekognition operations.

You may need to Base64-encode the image bytes depending on the language
you are using and whether or not you are using the AWS SDK. For more
information, see example4.

If you use the Amazon CLI to call Amazon Rekognition operations,
passing image bytes using the Bytes property is not supported. You must
first upload the image to an Amazon S3 bucket and then call the
operation using the S3Object property.

For Amazon Rekognition to process an S3 object, the user must have
permission to access the S3 object. For more information, see
manage-access-resource-policies.

=head1 ATTRIBUTES


=head2 Bytes => Str

  Blob of image bytes up to 5 MBs.


=head2 S3Object => L<Paws::Rekognition::S3Object>

  Identifies an S3 object as the image source.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::Rekognition>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: https://github.com/pplu/aws-sdk-perl

Please report bugs to: https://github.com/pplu/aws-sdk-perl/issues

=cut


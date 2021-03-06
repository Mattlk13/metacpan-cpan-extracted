package Paws::SSM::AttachmentContent;
  use Moose;
  has Hash => (is => 'ro', isa => 'Str');
  has HashType => (is => 'ro', isa => 'Str');
  has Name => (is => 'ro', isa => 'Str');
  has Size => (is => 'ro', isa => 'Int');
  has Url => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::SSM::AttachmentContent

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::SSM::AttachmentContent object:

  $service_obj->Method(Att1 => { Hash => $value, ..., Url => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::SSM::AttachmentContent object:

  $result = $service_obj->Method(...);
  $result->Att1->Hash

=head1 DESCRIPTION

A structure that includes attributes that describe a document
attachment.

=head1 ATTRIBUTES


=head2 Hash => Str

  The cryptographic hash value of the document content.


=head2 HashType => Str

  The hash algorithm used to calculate the hash value.


=head2 Name => Str

  The name of an attachment.


=head2 Size => Int

  The size of an attachment in bytes.


=head2 Url => Str

  The URL location of the attachment content.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::SSM>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


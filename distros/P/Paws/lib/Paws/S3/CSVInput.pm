package Paws::S3::CSVInput;
  use Moose;
  has Comments => (is => 'ro', isa => 'Str');
  has FieldDelimiter => (is => 'ro', isa => 'Str');
  has FileHeaderInfo => (is => 'ro', isa => 'Str');
  has QuoteCharacter => (is => 'ro', isa => 'Str');
  has QuoteEscapeCharacter => (is => 'ro', isa => 'Str');
  has RecordDelimiter => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::S3::CSVInput

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::S3::CSVInput object:

  $service_obj->Method(Att1 => { Comments => $value, ..., RecordDelimiter => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::S3::CSVInput object:

  $result = $service_obj->Method(...);
  $result->Att1->Comments

=head1 DESCRIPTION

Describes how a CSV-formatted input object is formatted.

=head1 ATTRIBUTES


=head2 Comments => Str

  Single character used to indicate a row should be ignored when present
at the start of a row.


=head2 FieldDelimiter => Str

  Value used to separate individual fields in a record.


=head2 FileHeaderInfo => Str

  Describes the first line of input. Valid values: None, Ignore, Use.


=head2 QuoteCharacter => Str

  Value used for escaping where the field delimiter is part of the value.


=head2 QuoteEscapeCharacter => Str

  Single character used for escaping the quote character inside an
already escaped value.


=head2 RecordDelimiter => Str

  Value used to separate individual records.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::S3>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


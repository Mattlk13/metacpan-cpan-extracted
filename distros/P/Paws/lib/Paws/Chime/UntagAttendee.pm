
package Paws::Chime::UntagAttendee;
  use Moose;
  has AttendeeId => (is => 'ro', isa => 'Str', traits => ['ParamInURI'], uri_name => 'attendeeId', required => 1);
  has MeetingId => (is => 'ro', isa => 'Str', traits => ['ParamInURI'], uri_name => 'meetingId', required => 1);
  has TagKeys => (is => 'ro', isa => 'ArrayRef[Str|Undef]', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'UntagAttendee');
  class_has _api_uri  => (isa => 'Str', is => 'ro', default => '/meetings/{meetingId}/attendees/{attendeeId}/tags?operation=delete');
  class_has _api_method  => (isa => 'Str', is => 'ro', default => 'POST');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::API::Response');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Chime::UntagAttendee - Arguments for method UntagAttendee on L<Paws::Chime>

=head1 DESCRIPTION

This class represents the parameters used for calling the method UntagAttendee on the
L<Amazon Chime|Paws::Chime> service. Use the attributes of this class
as arguments to method UntagAttendee.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to UntagAttendee.

=head1 SYNOPSIS

    my $chime = Paws->service('Chime');
    $chime->UntagAttendee(
      AttendeeId => 'MyGuidString',
      MeetingId  => 'MyGuidString',
      TagKeys    => [
        'MyTagKey', ...    # min: 1, max: 128
      ],

    );

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/chime/UntagAttendee>

=head1 ATTRIBUTES


=head2 B<REQUIRED> AttendeeId => Str

The Amazon Chime SDK attendee ID.



=head2 B<REQUIRED> MeetingId => Str

The Amazon Chime SDK meeting ID.



=head2 B<REQUIRED> TagKeys => ArrayRef[Str|Undef]

The tag keys.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method UntagAttendee in L<Paws::Chime>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


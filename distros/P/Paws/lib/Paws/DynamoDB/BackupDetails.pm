package Paws::DynamoDB::BackupDetails;
  use Moose;
  has BackupArn => (is => 'ro', isa => 'Str', required => 1);
  has BackupCreationDateTime => (is => 'ro', isa => 'Str', required => 1);
  has BackupName => (is => 'ro', isa => 'Str', required => 1);
  has BackupSizeBytes => (is => 'ro', isa => 'Int');
  has BackupStatus => (is => 'ro', isa => 'Str', required => 1);
1;

### main pod documentation begin ###

=head1 NAME

Paws::DynamoDB::BackupDetails

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::DynamoDB::BackupDetails object:

  $service_obj->Method(Att1 => { BackupArn => $value, ..., BackupStatus => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::DynamoDB::BackupDetails object:

  $result = $service_obj->Method(...);
  $result->Att1->BackupArn

=head1 DESCRIPTION

Contains the details of the backup created for the table.

=head1 ATTRIBUTES


=head2 B<REQUIRED> BackupArn => Str

  ARN associated with the backup.


=head2 B<REQUIRED> BackupCreationDateTime => Str

  Time at which the backup was created. This is the request time of the
backup.


=head2 B<REQUIRED> BackupName => Str

  Name of the requested backup.


=head2 BackupSizeBytes => Int

  Size of the backup in bytes.


=head2 B<REQUIRED> BackupStatus => Str

  Backup can be in one of the following states: CREATING, ACTIVE,
DELETED.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::DynamoDB>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


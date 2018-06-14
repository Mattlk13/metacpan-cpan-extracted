package Paws::DynamoDB::ReplicaSettingsDescription;
  use Moose;
  has RegionName => (is => 'ro', isa => 'Str', required => 1);
  has ReplicaGlobalSecondaryIndexSettings => (is => 'ro', isa => 'ArrayRef[Paws::DynamoDB::ReplicaGlobalSecondaryIndexSettingsDescription]');
  has ReplicaProvisionedReadCapacityUnits => (is => 'ro', isa => 'Int');
  has ReplicaProvisionedWriteCapacityUnits => (is => 'ro', isa => 'Int');
  has ReplicaStatus => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::DynamoDB::ReplicaSettingsDescription

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::DynamoDB::ReplicaSettingsDescription object:

  $service_obj->Method(Att1 => { RegionName => $value, ..., ReplicaStatus => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::DynamoDB::ReplicaSettingsDescription object:

  $result = $service_obj->Method(...);
  $result->Att1->RegionName

=head1 DESCRIPTION

Represents the properties of a replica.

=head1 ATTRIBUTES


=head2 B<REQUIRED> RegionName => Str

  The region name of the replica.


=head2 ReplicaGlobalSecondaryIndexSettings => ArrayRef[L<Paws::DynamoDB::ReplicaGlobalSecondaryIndexSettingsDescription>]

  Replica global secondary index settings for the global table.


=head2 ReplicaProvisionedReadCapacityUnits => Int

  The maximum number of strongly consistent reads consumed per second
before DynamoDB returns a C<ThrottlingException>. For more information,
see Specifying Read and Write Requirements
(http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#ProvisionedThroughput)
in the I<Amazon DynamoDB Developer Guide>.


=head2 ReplicaProvisionedWriteCapacityUnits => Int

  The maximum number of writes consumed per second before DynamoDB
returns a C<ThrottlingException>. For more information, see Specifying
Read and Write Requirements
(http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/WorkingWithTables.html#ProvisionedThroughput)
in the I<Amazon DynamoDB Developer Guide>.


=head2 ReplicaStatus => Str

  The current state of the region:

=over

=item *

C<CREATING> - The region is being created.

=item *

C<UPDATING> - The region is being updated.

=item *

C<DELETING> - The region is being deleted.

=item *

C<ACTIVE> - The region is ready for use.

=back




=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::DynamoDB>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


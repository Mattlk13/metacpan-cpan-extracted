
package Paws::DynamoDB::UpdateTable;
  use Moose;
  has AttributeDefinitions => (is => 'ro', isa => 'ArrayRef[Paws::DynamoDB::AttributeDefinition]');
  has GlobalSecondaryIndexUpdates => (is => 'ro', isa => 'ArrayRef[Paws::DynamoDB::GlobalSecondaryIndexUpdate]');
  has ProvisionedThroughput => (is => 'ro', isa => 'Paws::DynamoDB::ProvisionedThroughput');
  has StreamSpecification => (is => 'ro', isa => 'Paws::DynamoDB::StreamSpecification');
  has TableName => (is => 'ro', isa => 'Str', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'UpdateTable');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::DynamoDB::UpdateTableOutput');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::DynamoDB::UpdateTable - Arguments for method UpdateTable on L<Paws::DynamoDB>

=head1 DESCRIPTION

This class represents the parameters used for calling the method UpdateTable on the
L<Amazon DynamoDB|Paws::DynamoDB> service. Use the attributes of this class
as arguments to method UpdateTable.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to UpdateTable.

=head1 SYNOPSIS

    my $dynamodb = Paws->service('DynamoDB');
   # To modify a table's provisioned throughput
   # This example increases the provisioned read and write capacity on the Music
   # table.
    my $UpdateTableOutput = $dynamodb->UpdateTable(
      {
        'ProvisionedThroughput' => {
          'WriteCapacityUnits' => 10,
          'ReadCapacityUnits'  => 10
        },
        'TableName' => 'MusicCollection'
      }
    );

    # Results:
    my $TableDescription = $UpdateTableOutput->TableDescription;

    # Returns a L<Paws::DynamoDB::UpdateTableOutput> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/dynamodb/UpdateTable>

=head1 ATTRIBUTES


=head2 AttributeDefinitions => ArrayRef[L<Paws::DynamoDB::AttributeDefinition>]

An array of attributes that describe the key schema for the table and
indexes. If you are adding a new global secondary index to the table,
C<AttributeDefinitions> must include the key element(s) of the new
index.



=head2 GlobalSecondaryIndexUpdates => ArrayRef[L<Paws::DynamoDB::GlobalSecondaryIndexUpdate>]

An array of one or more global secondary indexes for the table. For
each index in the array, you can request one action:

=over

=item *

C<Create> - add a new global secondary index to the table.

=item *

C<Update> - modify the provisioned throughput settings of an existing
global secondary index.

=item *

C<Delete> - remove a global secondary index from the table.

=back

For more information, see Managing Global Secondary Indexes
(http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GSI.OnlineOps.html)
in the I<Amazon DynamoDB Developer Guide>.



=head2 ProvisionedThroughput => L<Paws::DynamoDB::ProvisionedThroughput>

The new provisioned throughput settings for the specified table or
index.



=head2 StreamSpecification => L<Paws::DynamoDB::StreamSpecification>

Represents the DynamoDB Streams configuration for the table.

You will receive a C<ResourceInUseException> if you attempt to enable a
stream on a table that already has a stream, or if you attempt to
disable a stream on a table which does not have a stream.



=head2 B<REQUIRED> TableName => Str

The name of the table to be updated.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method UpdateTable in L<Paws::DynamoDB>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut



package Paws::Glue::DeleteColumnStatisticsForTable;
  use Moose;
  has CatalogId => (is => 'ro', isa => 'Str');
  has ColumnName => (is => 'ro', isa => 'Str', required => 1);
  has DatabaseName => (is => 'ro', isa => 'Str', required => 1);
  has TableName => (is => 'ro', isa => 'Str', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'DeleteColumnStatisticsForTable');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::Glue::DeleteColumnStatisticsForTableResponse');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Glue::DeleteColumnStatisticsForTable - Arguments for method DeleteColumnStatisticsForTable on L<Paws::Glue>

=head1 DESCRIPTION

This class represents the parameters used for calling the method DeleteColumnStatisticsForTable on the
L<AWS Glue|Paws::Glue> service. Use the attributes of this class
as arguments to method DeleteColumnStatisticsForTable.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to DeleteColumnStatisticsForTable.

=head1 SYNOPSIS

    my $glue = Paws->service('Glue');
    my $DeleteColumnStatisticsForTableResponse =
      $glue->DeleteColumnStatisticsForTable(
      ColumnName   => 'MyNameString',
      DatabaseName => 'MyNameString',
      TableName    => 'MyNameString',
      CatalogId    => 'MyCatalogIdString',    # OPTIONAL
      );

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/glue/DeleteColumnStatisticsForTable>

=head1 ATTRIBUTES


=head2 CatalogId => Str

The ID of the Data Catalog where the partitions in question reside. If
none is supplied, the Amazon Web Services account ID is used by
default.



=head2 B<REQUIRED> ColumnName => Str

The name of the column.



=head2 B<REQUIRED> DatabaseName => Str

The name of the catalog database where the partitions reside.



=head2 B<REQUIRED> TableName => Str

The name of the partitions' table.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method DeleteColumnStatisticsForTable in L<Paws::Glue>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


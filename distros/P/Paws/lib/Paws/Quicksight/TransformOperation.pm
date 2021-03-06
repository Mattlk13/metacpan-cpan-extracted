package Paws::Quicksight::TransformOperation;
  use Moose;
  has CastColumnTypeOperation => (is => 'ro', isa => 'Paws::Quicksight::CastColumnTypeOperation');
  has CreateColumnsOperation => (is => 'ro', isa => 'Paws::Quicksight::CreateColumnsOperation');
  has FilterOperation => (is => 'ro', isa => 'Paws::Quicksight::FilterOperation');
  has ProjectOperation => (is => 'ro', isa => 'Paws::Quicksight::ProjectOperation');
  has RenameColumnOperation => (is => 'ro', isa => 'Paws::Quicksight::RenameColumnOperation');
  has TagColumnOperation => (is => 'ro', isa => 'Paws::Quicksight::TagColumnOperation');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Quicksight::TransformOperation

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::Quicksight::TransformOperation object:

  $service_obj->Method(Att1 => { CastColumnTypeOperation => $value, ..., TagColumnOperation => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::Quicksight::TransformOperation object:

  $result = $service_obj->Method(...);
  $result->Att1->CastColumnTypeOperation

=head1 DESCRIPTION

A data transformation on a logical table. This is a variant type
structure. For this structure to be valid, only one of the attributes
can be non-null.

=head1 ATTRIBUTES


=head2 CastColumnTypeOperation => L<Paws::Quicksight::CastColumnTypeOperation>

  A transform operation that casts a column to a different type.


=head2 CreateColumnsOperation => L<Paws::Quicksight::CreateColumnsOperation>

  An operation that creates calculated columns. Columns created in one
such operation form a lexical closure.


=head2 FilterOperation => L<Paws::Quicksight::FilterOperation>

  An operation that filters rows based on some condition.


=head2 ProjectOperation => L<Paws::Quicksight::ProjectOperation>

  An operation that projects columns. Operations that come after a
projection can only refer to projected columns.


=head2 RenameColumnOperation => L<Paws::Quicksight::RenameColumnOperation>

  An operation that renames a column.


=head2 TagColumnOperation => L<Paws::Quicksight::TagColumnOperation>

  An operation that tags a column with additional information.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::Quicksight>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


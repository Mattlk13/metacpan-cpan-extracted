
package Paws::RDS::ModifyDBSnapshot;
  use Moose;
  has DBSnapshotIdentifier => (is => 'ro', isa => 'Str', required => 1);
  has EngineVersion => (is => 'ro', isa => 'Str');

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'ModifyDBSnapshot');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::RDS::ModifyDBSnapshotResult');
  class_has _result_key => (isa => 'Str', is => 'ro', default => 'ModifyDBSnapshotResult');
1;

### main pod documentation begin ###

=head1 NAME

Paws::RDS::ModifyDBSnapshot - Arguments for method ModifyDBSnapshot on Paws::RDS

=head1 DESCRIPTION

This class represents the parameters used for calling the method ModifyDBSnapshot on the 
Amazon Relational Database Service service. Use the attributes of this class
as arguments to method ModifyDBSnapshot.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to ModifyDBSnapshot.

As an example:

  $service_obj->ModifyDBSnapshot(Att1 => $value1, Att2 => $value2, ...);

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.

=head1 ATTRIBUTES


=head2 B<REQUIRED> DBSnapshotIdentifier => Str

The identifier of the DB snapshot to modify.



=head2 EngineVersion => Str

The engine version to update the DB snapshot to.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method ModifyDBSnapshot in L<Paws::RDS>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: https://github.com/pplu/aws-sdk-perl

Please report bugs to: https://github.com/pplu/aws-sdk-perl/issues

=cut


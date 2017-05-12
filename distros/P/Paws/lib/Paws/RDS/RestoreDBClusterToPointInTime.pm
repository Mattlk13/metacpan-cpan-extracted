
package Paws::RDS::RestoreDBClusterToPointInTime;
  use Moose;
  has DBClusterIdentifier => (is => 'ro', isa => 'Str', required => 1);
  has DBSubnetGroupName => (is => 'ro', isa => 'Str');
  has KmsKeyId => (is => 'ro', isa => 'Str');
  has OptionGroupName => (is => 'ro', isa => 'Str');
  has Port => (is => 'ro', isa => 'Int');
  has RestoreToTime => (is => 'ro', isa => 'Str');
  has SourceDBClusterIdentifier => (is => 'ro', isa => 'Str', required => 1);
  has Tags => (is => 'ro', isa => 'ArrayRef[Paws::RDS::Tag]');
  has UseLatestRestorableTime => (is => 'ro', isa => 'Bool');
  has VpcSecurityGroupIds => (is => 'ro', isa => 'ArrayRef[Str|Undef]');

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'RestoreDBClusterToPointInTime');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::RDS::RestoreDBClusterToPointInTimeResult');
  class_has _result_key => (isa => 'Str', is => 'ro', default => 'RestoreDBClusterToPointInTimeResult');
1;

### main pod documentation begin ###

=head1 NAME

Paws::RDS::RestoreDBClusterToPointInTime - Arguments for method RestoreDBClusterToPointInTime on Paws::RDS

=head1 DESCRIPTION

This class represents the parameters used for calling the method RestoreDBClusterToPointInTime on the 
Amazon Relational Database Service service. Use the attributes of this class
as arguments to method RestoreDBClusterToPointInTime.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to RestoreDBClusterToPointInTime.

As an example:

  $service_obj->RestoreDBClusterToPointInTime(Att1 => $value1, Att2 => $value2, ...);

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.

=head1 ATTRIBUTES


=head2 B<REQUIRED> DBClusterIdentifier => Str

The name of the new DB cluster to be created.

Constraints:

=over

=item *

Must contain from 1 to 63 alphanumeric characters or hyphens

=item *

First character must be a letter

=item *

Cannot end with a hyphen or contain two consecutive hyphens

=back




=head2 DBSubnetGroupName => Str

The DB subnet group name to use for the new DB cluster.

Constraints: Must contain no more than 255 alphanumeric characters,
periods, underscores, spaces, or hyphens. Must not be default.

Example: C<mySubnetgroup>



=head2 KmsKeyId => Str

The KMS key identifier to use when restoring an encrypted DB cluster
from an encrypted DB cluster.

The KMS key identifier is the Amazon Resource Name (ARN) for the KMS
encryption key. If you are restoring a DB cluster with the same AWS
account that owns the KMS encryption key used to encrypt the new DB
cluster, then you can use the KMS key alias instead of the ARN for the
KMS encryption key.

You can restore to a new DB cluster and encrypt the new DB cluster with
a KMS key that is different than the KMS key used to encrypt the source
DB cluster. The new DB cluster will be encrypted with the KMS key
identified by the C<KmsKeyId> parameter.

If you do not specify a value for the C<KmsKeyId> parameter, then the
following will occur:

=over

=item *

If the DB cluster is encrypted, then the restored DB cluster is
encrypted using the KMS key that was used to encrypt the source DB
cluster.

=item *

If the DB cluster is not encrypted, then the restored DB cluster is not
encrypted.

=back

If C<DBClusterIdentifier> refers to a DB cluster that is note
encrypted, then the restore request is rejected.



=head2 OptionGroupName => Str

The name of the option group for the new DB cluster.



=head2 Port => Int

The port number on which the new DB cluster accepts connections.

Constraints: Value must be C<1150-65535>

Default: The same port as the original DB cluster.



=head2 RestoreToTime => Str

The date and time to restore the DB cluster to.

Valid Values: Value must be a time in Universal Coordinated Time (UTC)
format

Constraints:

=over

=item *

Must be before the latest restorable time for the DB instance

=item *

Cannot be specified if C<UseLatestRestorableTime> parameter is true

=back

Example: C<2015-03-07T23:45:00Z>



=head2 B<REQUIRED> SourceDBClusterIdentifier => Str

The identifier of the source DB cluster from which to restore.

Constraints:

=over

=item *

Must be the identifier of an existing database instance

=item *

Must contain from 1 to 63 alphanumeric characters or hyphens

=item *

First character must be a letter

=item *

Cannot end with a hyphen or contain two consecutive hyphens

=back




=head2 Tags => ArrayRef[L<Paws::RDS::Tag>]





=head2 UseLatestRestorableTime => Bool

A value that is set to C<true> to restore the DB cluster to the latest
restorable backup time, and C<false> otherwise.

Default: C<false>

Constraints: Cannot be specified if C<RestoreToTime> parameter is
provided.



=head2 VpcSecurityGroupIds => ArrayRef[Str|Undef]

A lst of VPC security groups that the new DB cluster belongs to.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method RestoreDBClusterToPointInTime in L<Paws::RDS>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: https://github.com/pplu/aws-sdk-perl

Please report bugs to: https://github.com/pplu/aws-sdk-perl/issues

=cut


package Paws::SecurityHub::AwsIamRoleDetails;
  use Moose;
  has AssumeRolePolicyDocument => (is => 'ro', isa => 'Str');
  has CreateDate => (is => 'ro', isa => 'Str');
  has MaxSessionDuration => (is => 'ro', isa => 'Int');
  has Path => (is => 'ro', isa => 'Str');
  has RoleId => (is => 'ro', isa => 'Str');
  has RoleName => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::SecurityHub::AwsIamRoleDetails

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::SecurityHub::AwsIamRoleDetails object:

  $service_obj->Method(Att1 => { AssumeRolePolicyDocument => $value, ..., RoleName => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::SecurityHub::AwsIamRoleDetails object:

  $result = $service_obj->Method(...);
  $result->Att1->AssumeRolePolicyDocument

=head1 DESCRIPTION

Contains information about an IAM role, including all of the role's
policies.

=head1 ATTRIBUTES


=head2 AssumeRolePolicyDocument => Str

  The trust policy that grants permission to assume the role.


=head2 CreateDate => Str

  The date and time, in ISO 8601 date-time format, when the role was
created.


=head2 MaxSessionDuration => Int

  The maximum session duration (in seconds) that you want to set for the
specified role.


=head2 Path => Str

  The path to the role.


=head2 RoleId => Str

  The stable and unique string identifying the role.


=head2 RoleName => Str

  The friendly name that identifies the role.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::SecurityHub>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


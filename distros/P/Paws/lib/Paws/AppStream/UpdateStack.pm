
package Paws::AppStream::UpdateStack;
  use Moose;
  has Description => (is => 'ro', isa => 'Str');
  has DisplayName => (is => 'ro', isa => 'Str');
  has Name => (is => 'ro', isa => 'Str', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'UpdateStack');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::AppStream::UpdateStackResult');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::AppStream::UpdateStack - Arguments for method UpdateStack on Paws::AppStream

=head1 DESCRIPTION

This class represents the parameters used for calling the method UpdateStack on the 
Amazon AppStream service. Use the attributes of this class
as arguments to method UpdateStack.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to UpdateStack.

As an example:

  $service_obj->UpdateStack(Att1 => $value1, Att2 => $value2, ...);

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.

=head1 ATTRIBUTES


=head2 Description => Str

The description displayed to end users on the AppStream 2.0 portal.



=head2 DisplayName => Str

The name displayed to end users on the AppStream 2.0 portal.



=head2 B<REQUIRED> Name => Str

The name of the stack to update.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method UpdateStack in L<Paws::AppStream>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: https://github.com/pplu/aws-sdk-perl

Please report bugs to: https://github.com/pplu/aws-sdk-perl/issues

=cut


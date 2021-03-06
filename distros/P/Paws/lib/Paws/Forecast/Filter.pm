package Paws::Forecast::Filter;
  use Moose;
  has Condition => (is => 'ro', isa => 'Str', required => 1);
  has Key => (is => 'ro', isa => 'Str', required => 1);
  has Value => (is => 'ro', isa => 'Str', required => 1);
1;

### main pod documentation begin ###

=head1 NAME

Paws::Forecast::Filter

=head1 USAGE

This class represents one of two things:

=head3 Arguments in a call to a service

Use the attributes of this class as arguments to methods. You shouldn't make instances of this class. 
Each attribute should be used as a named argument in the calls that expect this type of object.

As an example, if Att1 is expected to be a Paws::Forecast::Filter object:

  $service_obj->Method(Att1 => { Condition => $value, ..., Value => $value  });

=head3 Results returned from an API call

Use accessors for each attribute. If Att1 is expected to be an Paws::Forecast::Filter object:

  $result = $service_obj->Method(...);
  $result->Att1->Condition

=head1 DESCRIPTION

Describes a filter for choosing a subset of objects. Each filter
consists of a condition and a match statement. The condition is either
C<IS> or C<IS_NOT>, which specifies whether to include or exclude the
objects that match the statement, respectively. The match statement
consists of a key and a value.

=head1 ATTRIBUTES


=head2 B<REQUIRED> Condition => Str

  The condition to apply. To include the objects that match the
statement, specify C<IS>. To exclude matching objects, specify
C<IS_NOT>.


=head2 B<REQUIRED> Key => Str

  The name of the parameter to filter on.


=head2 B<REQUIRED> Value => Str

  The value to match.



=head1 SEE ALSO

This class forms part of L<Paws>, describing an object used in L<Paws::Forecast>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


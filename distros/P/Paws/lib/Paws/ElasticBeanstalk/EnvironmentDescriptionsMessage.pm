
package Paws::ElasticBeanstalk::EnvironmentDescriptionsMessage;
  use Moose;
  has Environments => (is => 'ro', isa => 'ArrayRef[Paws::ElasticBeanstalk::EnvironmentDescription]');

  has _request_id => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::ElasticBeanstalk::EnvironmentDescriptionsMessage

=head1 ATTRIBUTES


=head2 Environments => ArrayRef[L<Paws::ElasticBeanstalk::EnvironmentDescription>]

Returns an EnvironmentDescription list.


=head2 _request_id => Str


=cut


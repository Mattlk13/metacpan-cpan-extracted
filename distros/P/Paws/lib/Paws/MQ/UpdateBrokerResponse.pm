
package Paws::MQ::UpdateBrokerResponse;
  use Moose;
  has BrokerId => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'brokerId');
  has Configuration => (is => 'ro', isa => 'Paws::MQ::ConfigurationId', traits => ['NameInRequest'], request_name => 'configuration');

  has _request_id => (is => 'ro', isa => 'Str');
1;

### main pod documentation begin ###

=head1 NAME

Paws::MQ::UpdateBrokerResponse

=head1 ATTRIBUTES


=head2 BrokerId => Str

Required. The unique ID that Amazon MQ generates for the broker.


=head2 Configuration => L<Paws::MQ::ConfigurationId>

The ID of the updated configuration.


=head2 _request_id => Str


=cut


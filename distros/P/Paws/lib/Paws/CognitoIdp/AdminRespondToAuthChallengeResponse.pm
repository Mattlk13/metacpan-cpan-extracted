
package Paws::CognitoIdp::AdminRespondToAuthChallengeResponse;
  use Moose;
  has AuthenticationResult => (is => 'ro', isa => 'Paws::CognitoIdp::AuthenticationResultType');
  has ChallengeName => (is => 'ro', isa => 'Str');
  has ChallengeParameters => (is => 'ro', isa => 'Paws::CognitoIdp::ChallengeParametersType');
  has Session => (is => 'ro', isa => 'Str');

  has _request_id => (is => 'ro', isa => 'Str');

### main pod documentation begin ###

=head1 NAME

Paws::CognitoIdp::AdminRespondToAuthChallengeResponse

=head1 ATTRIBUTES


=head2 AuthenticationResult => L<Paws::CognitoIdp::AuthenticationResultType>

The result returned by the server in response to the authentication
request.


=head2 ChallengeName => Str

The name of the challenge.

Valid values are: C<"SMS_MFA">, C<"PASSWORD_VERIFIER">, C<"CUSTOM_CHALLENGE">, C<"DEVICE_SRP_AUTH">, C<"DEVICE_PASSWORD_VERIFIER">, C<"ADMIN_NO_SRP_AUTH">, C<"NEW_PASSWORD_REQUIRED">
=head2 ChallengeParameters => L<Paws::CognitoIdp::ChallengeParametersType>

The challenge parameters.


=head2 Session => Str

The session.


=head2 _request_id => Str


=cut

1;
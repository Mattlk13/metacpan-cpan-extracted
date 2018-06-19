
package Paws::ApiGateway::UpdateAccount;
  use Moose;
  has PatchOperations => (is => 'ro', isa => 'ArrayRef[Paws::ApiGateway::PatchOperation]', traits => ['NameInRequest'], request_name => 'patchOperations');

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'UpdateAccount');
  class_has _api_uri  => (isa => 'Str', is => 'ro', default => '/account');
  class_has _api_method  => (isa => 'Str', is => 'ro', default => 'PATCH');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::ApiGateway::Account');
1;

### main pod documentation begin ###

=head1 NAME

Paws::ApiGateway::UpdateAccount - Arguments for method UpdateAccount on L<Paws::ApiGateway>

=head1 DESCRIPTION

This class represents the parameters used for calling the method UpdateAccount on the
L<Amazon API Gateway|Paws::ApiGateway> service. Use the attributes of this class
as arguments to method UpdateAccount.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to UpdateAccount.

=head1 SYNOPSIS

    my $apigateway = Paws->service('ApiGateway');
    my $Account = $apigateway->UpdateAccount(
      PatchOperations => [
        {
          from => 'MyString',    # OPTIONAL
          op =>
            'add',    # values: add, remove, replace, move, copy, test; OPTIONAL
          path  => 'MyString',    # OPTIONAL
          value => 'MyString',    # OPTIONAL
        },
        ...
      ],                          # OPTIONAL
    );

    # Results:
    my $apiKeyVersion     = $Account->apiKeyVersion;
    my $cloudwatchRoleArn = $Account->cloudwatchRoleArn;
    my $features          = $Account->features;
    my $throttleSettings  = $Account->throttleSettings;

    # Returns a L<Paws::ApiGateway::Account> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://aws.amazon.com/documentation/apigateway/>

=head1 ATTRIBUTES


=head2 PatchOperations => ArrayRef[L<Paws::ApiGateway::PatchOperation>]

A list of update operations to be applied to the specified resource and
in the order specified in this list.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method UpdateAccount in L<Paws::ApiGateway>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


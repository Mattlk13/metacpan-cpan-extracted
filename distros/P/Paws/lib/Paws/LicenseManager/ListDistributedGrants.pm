
package Paws::LicenseManager::ListDistributedGrants;
  use Moose;
  has Filters => (is => 'ro', isa => 'ArrayRef[Paws::LicenseManager::Filter]');
  has GrantArns => (is => 'ro', isa => 'ArrayRef[Str|Undef]');
  has MaxResults => (is => 'ro', isa => 'Int');
  has NextToken => (is => 'ro', isa => 'Str');

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'ListDistributedGrants');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::LicenseManager::ListDistributedGrantsResponse');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::LicenseManager::ListDistributedGrants - Arguments for method ListDistributedGrants on L<Paws::LicenseManager>

=head1 DESCRIPTION

This class represents the parameters used for calling the method ListDistributedGrants on the
L<AWS License Manager|Paws::LicenseManager> service. Use the attributes of this class
as arguments to method ListDistributedGrants.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to ListDistributedGrants.

=head1 SYNOPSIS

    my $license-manager = Paws->service('LicenseManager');
    my $ListDistributedGrantsResponse =
      $license -manager->ListDistributedGrants(
      Filters => [
        {
          Name   => 'MyFilterName',              # OPTIONAL
          Values => [ 'MyFilterValue', ... ],    # OPTIONAL
        },
        ...
      ],    # OPTIONAL
      GrantArns => [
        'MyArn', ...    # max: 2048
      ],    # OPTIONAL
      MaxResults => 1,             # OPTIONAL
      NextToken  => 'MyString',    # OPTIONAL
      );

    # Results:
    my $Grants    = $ListDistributedGrantsResponse->Grants;
    my $NextToken = $ListDistributedGrantsResponse->NextToken;

    # Returns a L<Paws::LicenseManager::ListDistributedGrantsResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/license-manager/ListDistributedGrants>

=head1 ATTRIBUTES


=head2 Filters => ArrayRef[L<Paws::LicenseManager::Filter>]

Filters to scope the results. The following filters are supported:

=over

=item *

C<LicenseArn>

=item *

C<GrantStatus>

=item *

C<GranteePrincipalARN>

=item *

C<ProductSKU>

=item *

C<LicenseIssuerName>

=back




=head2 GrantArns => ArrayRef[Str|Undef]

Amazon Resource Names (ARNs) of the grants.



=head2 MaxResults => Int

Maximum number of results to return in a single call.



=head2 NextToken => Str

Token for the next set of results.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method ListDistributedGrants in L<Paws::LicenseManager>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


package Paws::ES;
  use Moose;
  sub service { 'es' }
  sub signing_name { 'es' }
  sub version { '2015-01-01' }
  sub flattened_arrays { 0 }
  has max_attempts => (is => 'ro', isa => 'Int', default => 5);
  has retry => (is => 'ro', isa => 'HashRef', default => sub {
    { base => 'rand', type => 'exponential', growth_factor => 2 }
  });
  has retriables => (is => 'ro', isa => 'ArrayRef', default => sub { [
  ] });

  with 'Paws::API::Caller', 'Paws::API::EndpointResolver', 'Paws::Net::V4Signature', 'Paws::Net::RestJsonCaller';

  
  sub AddTags {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::AddTags', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub CreateElasticsearchDomain {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::CreateElasticsearchDomain', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteElasticsearchDomain {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::DeleteElasticsearchDomain', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DeleteElasticsearchServiceRole {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::DeleteElasticsearchServiceRole', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeElasticsearchDomain {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::DescribeElasticsearchDomain', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeElasticsearchDomainConfig {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::DescribeElasticsearchDomainConfig', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeElasticsearchDomains {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::DescribeElasticsearchDomains', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeElasticsearchInstanceTypeLimits {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::DescribeElasticsearchInstanceTypeLimits', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeReservedElasticsearchInstanceOfferings {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::DescribeReservedElasticsearchInstanceOfferings', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub DescribeReservedElasticsearchInstances {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::DescribeReservedElasticsearchInstances', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListDomainNames {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::ListDomainNames', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListElasticsearchInstanceTypes {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::ListElasticsearchInstanceTypes', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListElasticsearchVersions {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::ListElasticsearchVersions', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub ListTags {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::ListTags', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub PurchaseReservedElasticsearchInstanceOffering {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::PurchaseReservedElasticsearchInstanceOffering', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub RemoveTags {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::RemoveTags', @_);
    return $self->caller->do_call($self, $call_object);
  }
  sub UpdateElasticsearchDomainConfig {
    my $self = shift;
    my $call_object = $self->new_with_coercions('Paws::ES::UpdateElasticsearchDomainConfig', @_);
    return $self->caller->do_call($self, $call_object);
  }
  
  sub ListAllElasticsearchInstanceTypes {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->ListElasticsearchInstanceTypes(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->ListElasticsearchInstanceTypes(@_, NextToken => $next_result->NextToken);
        push @{ $result->ElasticsearchInstanceTypes }, @{ $next_result->ElasticsearchInstanceTypes };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'ElasticsearchInstanceTypes') foreach (@{ $result->ElasticsearchInstanceTypes });
        $result = $self->ListElasticsearchInstanceTypes(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'ElasticsearchInstanceTypes') foreach (@{ $result->ElasticsearchInstanceTypes });
    }

    return undef
  }
  sub ListAllElasticsearchVersions {
    my $self = shift;

    my $callback = shift @_ if (ref($_[0]) eq 'CODE');
    my $result = $self->ListElasticsearchVersions(@_);
    my $next_result = $result;

    if (not defined $callback) {
      while ($next_result->NextToken) {
        $next_result = $self->ListElasticsearchVersions(@_, NextToken => $next_result->NextToken);
        push @{ $result->ElasticsearchVersions }, @{ $next_result->ElasticsearchVersions };
      }
      return $result;
    } else {
      while ($result->NextToken) {
        $callback->($_ => 'ElasticsearchVersions') foreach (@{ $result->ElasticsearchVersions });
        $result = $self->ListElasticsearchVersions(@_, NextToken => $result->NextToken);
      }
      $callback->($_ => 'ElasticsearchVersions') foreach (@{ $result->ElasticsearchVersions });
    }

    return undef
  }


  sub operations { qw/AddTags CreateElasticsearchDomain DeleteElasticsearchDomain DeleteElasticsearchServiceRole DescribeElasticsearchDomain DescribeElasticsearchDomainConfig DescribeElasticsearchDomains DescribeElasticsearchInstanceTypeLimits DescribeReservedElasticsearchInstanceOfferings DescribeReservedElasticsearchInstances ListDomainNames ListElasticsearchInstanceTypes ListElasticsearchVersions ListTags PurchaseReservedElasticsearchInstanceOffering RemoveTags UpdateElasticsearchDomainConfig / }

1;

### main pod documentation begin ###

=head1 NAME

Paws::ES - Perl Interface to AWS Amazon Elasticsearch Service

=head1 SYNOPSIS

  use Paws;

  my $obj = Paws->service('ES');
  my $res = $obj->Method(
    Arg1 => $val1,
    Arg2 => [ 'V1', 'V2' ],
    # if Arg3 is an object, the HashRef will be used as arguments to the constructor
    # of the arguments type
    Arg3 => { Att1 => 'Val1' },
    # if Arg4 is an array of objects, the HashRefs will be passed as arguments to
    # the constructor of the arguments type
    Arg4 => [ { Att1 => 'Val1'  }, { Att1 => 'Val2' } ],
  );

=head1 DESCRIPTION

Amazon Elasticsearch Configuration Service

Use the Amazon Elasticsearch configuration API to create, configure,
and manage Elasticsearch domains.

The endpoint for configuration service requests is region-specific:
es.I<region>.amazonaws.com. For example, es.us-east-1.amazonaws.com.
For a current list of supported regions and endpoints, see Regions and
Endpoints
(http://docs.aws.amazon.com/general/latest/gr/rande.html#elasticsearch-service-regions).

For the AWS API documentation, see L<https://aws.amazon.com/documentation/elasticsearch-service/>


=head1 METHODS

=head2 AddTags

=over

=item ARN => Str

=item TagList => ArrayRef[L<Paws::ES::Tag>]


=back

Each argument is described in detail in: L<Paws::ES::AddTags>

Returns: nothing

Attaches tags to an existing Elasticsearch domain. Tags are a set of
case-sensitive key value pairs. An Elasticsearch domain may have up to
10 tags. See Tagging Amazon Elasticsearch Service Domains for more
information.
(http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains.html#es-managedomains-awsresorcetagging)


=head2 CreateElasticsearchDomain

=over

=item DomainName => Str

=item [AccessPolicies => Str]

=item [AdvancedOptions => L<Paws::ES::AdvancedOptions>]

=item [CognitoOptions => L<Paws::ES::CognitoOptions>]

=item [EBSOptions => L<Paws::ES::EBSOptions>]

=item [ElasticsearchClusterConfig => L<Paws::ES::ElasticsearchClusterConfig>]

=item [ElasticsearchVersion => Str]

=item [EncryptionAtRestOptions => L<Paws::ES::EncryptionAtRestOptions>]

=item [LogPublishingOptions => L<Paws::ES::LogPublishingOptions>]

=item [SnapshotOptions => L<Paws::ES::SnapshotOptions>]

=item [VPCOptions => L<Paws::ES::VPCOptions>]


=back

Each argument is described in detail in: L<Paws::ES::CreateElasticsearchDomain>

Returns: a L<Paws::ES::CreateElasticsearchDomainResponse> instance

Creates a new Elasticsearch domain. For more information, see Creating
Elasticsearch Domains
(http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomains)
in the I<Amazon Elasticsearch Service Developer Guide>.


=head2 DeleteElasticsearchDomain

=over

=item DomainName => Str


=back

Each argument is described in detail in: L<Paws::ES::DeleteElasticsearchDomain>

Returns: a L<Paws::ES::DeleteElasticsearchDomainResponse> instance

Permanently deletes the specified Elasticsearch domain and all of its
data. Once a domain is deleted, it cannot be recovered.


=head2 DeleteElasticsearchServiceRole

=over

=item  => 


=back

Each argument is described in detail in: L<Paws::ES::DeleteElasticsearchServiceRole>

Returns: nothing

Deletes the service-linked role that Elasticsearch Service uses to
manage and maintain VPC domains. Role deletion will fail if any
existing VPC domains use the role. You must delete any such
Elasticsearch domains before deleting the role. See Deleting
Elasticsearch Service Role
(http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-vpc.html#es-enabling-slr)
in I<VPC Endpoints for Amazon Elasticsearch Service Domains>.


=head2 DescribeElasticsearchDomain

=over

=item DomainName => Str


=back

Each argument is described in detail in: L<Paws::ES::DescribeElasticsearchDomain>

Returns: a L<Paws::ES::DescribeElasticsearchDomainResponse> instance

Returns domain configuration information about the specified
Elasticsearch domain, including the domain ID, domain endpoint, and
domain ARN.


=head2 DescribeElasticsearchDomainConfig

=over

=item DomainName => Str


=back

Each argument is described in detail in: L<Paws::ES::DescribeElasticsearchDomainConfig>

Returns: a L<Paws::ES::DescribeElasticsearchDomainConfigResponse> instance

Provides cluster configuration information about the specified
Elasticsearch domain, such as the state, creation date, update version,
and update date for cluster options.


=head2 DescribeElasticsearchDomains

=over

=item DomainNames => ArrayRef[Str|Undef]


=back

Each argument is described in detail in: L<Paws::ES::DescribeElasticsearchDomains>

Returns: a L<Paws::ES::DescribeElasticsearchDomainsResponse> instance

Returns domain configuration information about the specified
Elasticsearch domains, including the domain ID, domain endpoint, and
domain ARN.


=head2 DescribeElasticsearchInstanceTypeLimits

=over

=item ElasticsearchVersion => Str

=item InstanceType => Str

=item [DomainName => Str]


=back

Each argument is described in detail in: L<Paws::ES::DescribeElasticsearchInstanceTypeLimits>

Returns: a L<Paws::ES::DescribeElasticsearchInstanceTypeLimitsResponse> instance

Describe Elasticsearch Limits for a given InstanceType and
ElasticsearchVersion. When modifying existing Domain, specify the C<
DomainName > to know what Limits are supported for modifying.


=head2 DescribeReservedElasticsearchInstanceOfferings

=over

=item [MaxResults => Int]

=item [NextToken => Str]

=item [ReservedElasticsearchInstanceOfferingId => Str]


=back

Each argument is described in detail in: L<Paws::ES::DescribeReservedElasticsearchInstanceOfferings>

Returns: a L<Paws::ES::DescribeReservedElasticsearchInstanceOfferingsResponse> instance

Lists available reserved Elasticsearch instance offerings.


=head2 DescribeReservedElasticsearchInstances

=over

=item [MaxResults => Int]

=item [NextToken => Str]

=item [ReservedElasticsearchInstanceId => Str]


=back

Each argument is described in detail in: L<Paws::ES::DescribeReservedElasticsearchInstances>

Returns: a L<Paws::ES::DescribeReservedElasticsearchInstancesResponse> instance

Returns information about reserved Elasticsearch instances for this
account.


=head2 ListDomainNames

=over

=item  => 


=back

Each argument is described in detail in: L<Paws::ES::ListDomainNames>

Returns: a L<Paws::ES::ListDomainNamesResponse> instance

Returns the name of all Elasticsearch domains owned by the current
user's account.


=head2 ListElasticsearchInstanceTypes

=over

=item ElasticsearchVersion => Str

=item [DomainName => Str]

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::ES::ListElasticsearchInstanceTypes>

Returns: a L<Paws::ES::ListElasticsearchInstanceTypesResponse> instance

List all Elasticsearch instance types that are supported for given
ElasticsearchVersion


=head2 ListElasticsearchVersions

=over

=item [MaxResults => Int]

=item [NextToken => Str]


=back

Each argument is described in detail in: L<Paws::ES::ListElasticsearchVersions>

Returns: a L<Paws::ES::ListElasticsearchVersionsResponse> instance

List all supported Elasticsearch versions


=head2 ListTags

=over

=item ARN => Str


=back

Each argument is described in detail in: L<Paws::ES::ListTags>

Returns: a L<Paws::ES::ListTagsResponse> instance

Returns all tags for the given Elasticsearch domain.


=head2 PurchaseReservedElasticsearchInstanceOffering

=over

=item ReservationName => Str

=item ReservedElasticsearchInstanceOfferingId => Str

=item [InstanceCount => Int]


=back

Each argument is described in detail in: L<Paws::ES::PurchaseReservedElasticsearchInstanceOffering>

Returns: a L<Paws::ES::PurchaseReservedElasticsearchInstanceOfferingResponse> instance

Allows you to purchase reserved Elasticsearch instances.


=head2 RemoveTags

=over

=item ARN => Str

=item TagKeys => ArrayRef[Str|Undef]


=back

Each argument is described in detail in: L<Paws::ES::RemoveTags>

Returns: nothing

Removes the specified set of tags from the specified Elasticsearch
domain.


=head2 UpdateElasticsearchDomainConfig

=over

=item DomainName => Str

=item [AccessPolicies => Str]

=item [AdvancedOptions => L<Paws::ES::AdvancedOptions>]

=item [CognitoOptions => L<Paws::ES::CognitoOptions>]

=item [EBSOptions => L<Paws::ES::EBSOptions>]

=item [ElasticsearchClusterConfig => L<Paws::ES::ElasticsearchClusterConfig>]

=item [LogPublishingOptions => L<Paws::ES::LogPublishingOptions>]

=item [SnapshotOptions => L<Paws::ES::SnapshotOptions>]

=item [VPCOptions => L<Paws::ES::VPCOptions>]


=back

Each argument is described in detail in: L<Paws::ES::UpdateElasticsearchDomainConfig>

Returns: a L<Paws::ES::UpdateElasticsearchDomainConfigResponse> instance

Modifies the cluster configuration of the specified Elasticsearch
domain, setting as setting the instance type and the number of
instances.




=head1 PAGINATORS

Paginator methods are helpers that repetively call methods that return partial results

=head2 ListAllElasticsearchInstanceTypes(sub { },ElasticsearchVersion => Str, [DomainName => Str, MaxResults => Int, NextToken => Str])

=head2 ListAllElasticsearchInstanceTypes(ElasticsearchVersion => Str, [DomainName => Str, MaxResults => Int, NextToken => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - ElasticsearchInstanceTypes, passing the object as the first parameter, and the string 'ElasticsearchInstanceTypes' as the second parameter 

If not, it will return a a L<Paws::ES::ListElasticsearchInstanceTypesResponse> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.


=head2 ListAllElasticsearchVersions(sub { },[MaxResults => Int, NextToken => Str])

=head2 ListAllElasticsearchVersions([MaxResults => Int, NextToken => Str])


If passed a sub as first parameter, it will call the sub for each element found in :

 - ElasticsearchVersions, passing the object as the first parameter, and the string 'ElasticsearchVersions' as the second parameter 

If not, it will return a a L<Paws::ES::ListElasticsearchVersionsResponse> instance with all the C<param>s;  from all the responses. Please take into account that this mode can potentially consume vasts ammounts of memory.





=head1 SEE ALSO

This service class forms part of L<Paws>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


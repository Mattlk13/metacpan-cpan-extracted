
package Paws::CloudFront::UpdateDistribution;
  use Moose;
  has DistributionConfig => (is => 'ro', isa => 'Paws::CloudFront::DistributionConfig', required => 1);
  has Id => (is => 'ro', isa => 'Str', uri_name => 'Id', traits => ['ParamInURI'], required => 1);
  has IfMatch => (is => 'ro', isa => 'Str', header_name => 'If-Match', traits => ['ParamInHeader']);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'UpdateDistribution');
  class_has _api_uri  => (isa => 'Str', is => 'ro', default => '/2017-10-30/distribution/{Id}/config');
  class_has _api_method  => (isa => 'Str', is => 'ro', default => 'PUT');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::CloudFront::UpdateDistributionResult');
  class_has _result_key => (isa => 'Str', is => 'ro');
  
1;

### main pod documentation begin ###

=head1 NAME

Paws::CloudFront::UpdateDistribution - Arguments for method UpdateDistribution on L<Paws::CloudFront>

=head1 DESCRIPTION

This class represents the parameters used for calling the method UpdateDistribution2017_10_30 on the
L<Amazon CloudFront|Paws::CloudFront> service. Use the attributes of this class
as arguments to method UpdateDistribution2017_10_30.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to UpdateDistribution2017_10_30.

=head1 SYNOPSIS

    my $cloudfront = Paws->service('CloudFront');
    my $UpdateDistributionResult = $cloudfront->UpdateDistribution(
      DistributionConfig => {
        Origins => {
          Quantity => 1,
          Items    => [
            {
              Id            => 'Mystring',
              DomainName    => 'Mystring',
              CustomHeaders => {
                Quantity => 1,
                Items    => [
                  {
                    HeaderName  => 'Mystring',
                    HeaderValue => 'Mystring',

                  },
                  ...
                ],    # OPTIONAL
              },    # OPTIONAL
              S3OriginConfig => {
                OriginAccessIdentity => 'Mystring',

              },    # OPTIONAL
              CustomOriginConfig => {
                OriginProtocolPolicy =>
                  'http-only',    # values: http-only, match-viewer, https-only
                HTTPPort               => 1,
                HTTPSPort              => 1,
                OriginKeepaliveTimeout => 1,
                OriginReadTimeout      => 1,
                OriginSslProtocols     => {
                  Quantity => 1,
                  Items    => [
                    'SSLv3', ...    # values: SSLv3, TLSv1, TLSv1.1, TLSv1.2
                  ],

                },    # OPTIONAL
              },    # OPTIONAL
              OriginPath => 'Mystring',
            },
            ...
          ],        # min: 1, ; OPTIONAL
        },
        Comment              => 'Mystring',
        Enabled              => 1,
        CallerReference      => 'Mystring',
        DefaultCacheBehavior => {
          TrustedSigners => {
            Enabled  => 1,
            Quantity => 1,
            Items    => [ 'Mystring', ... ],    # OPTIONAL
          },
          ForwardedValues => {
            QueryString => 1,
            Cookies     => {
              Forward          => 'none',       # values: none, whitelist, all
              WhitelistedNames => {
                Quantity => 1,
                Items    => [ 'Mystring', ... ],    # OPTIONAL
              },    # OPTIONAL
            },
            Headers => {
              Quantity => 1,
              Items    => [ 'Mystring', ... ],    # OPTIONAL
            },    # OPTIONAL
            QueryStringCacheKeys => {
              Quantity => 1,
              Items    => [ 'Mystring', ... ],    # OPTIONAL
            },    # OPTIONAL
          },
          MinTTL         => 1,
          TargetOriginId => 'Mystring',
          ViewerProtocolPolicy =>
            'allow-all',    # values: allow-all, https-only, redirect-to-https
          DefaultTTL             => 1,
          SmoothStreaming        => 1,
          FieldLevelEncryptionId => 'Mystring',
          AllowedMethods         => {
            Items => [
              'GET', ...  # values: GET, HEAD, POST, PUT, PATCH, OPTIONS, DELETE
            ],
            Quantity      => 1,
            CachedMethods => {
              Quantity => 1,
              Items    => [
                'GET',
                ...       # values: GET, HEAD, POST, PUT, PATCH, OPTIONS, DELETE
              ],

            },    # OPTIONAL
          },    # OPTIONAL
          Compress                   => 1,
          LambdaFunctionAssociations => {
            Quantity => 1,
            Items    => [
              {
                EventType => 'viewer-request'
                , # values: viewer-request, viewer-response, origin-request, origin-response
                LambdaFunctionARN => 'MyLambdaFunctionARN',

              },
              ...
            ],    # OPTIONAL
          },    # OPTIONAL
          MaxTTL => 1,
        },
        ViewerCertificate => {
          Certificate      => 'Mystring',
          IAMCertificateId => 'Mystring',
          CertificateSource =>
            'cloudfront',    # values: cloudfront, iam, acm; OPTIONAL
          CloudFrontDefaultCertificate => 1,
          ACMCertificateArn            => 'Mystring',
          SSLSupportMethod => 'sni-only',    # values: sni-only, vip; OPTIONAL
          MinimumProtocolVersion => 'SSLv3'
          , # values: SSLv3, TLSv1, TLSv1_2016, TLSv1.1_2016, TLSv1.2_2018; OPTIONAL
        },    # OPTIONAL
        Aliases => {
          Quantity => 1,
          Items    => [ 'Mystring', ... ],    # OPTIONAL
        },    # OPTIONAL
        Logging => {
          Bucket         => 'Mystring',
          IncludeCookies => 1,
          Prefix         => 'Mystring',
          Enabled        => 1,

        },    # OPTIONAL
        PriceClass => 'PriceClass_100'
        ,     # values: PriceClass_100, PriceClass_200, PriceClass_All; OPTIONAL
        DefaultRootObject => 'Mystring',
        CacheBehaviors    => {
          Quantity => 1,
          Items    => [
            {
              TargetOriginId => 'Mystring',
              MinTTL         => 1,
              PathPattern    => 'Mystring',
              ViewerProtocolPolicy =>
                'allow-all',  # values: allow-all, https-only, redirect-to-https
              TrustedSigners => {
                Enabled  => 1,
                Quantity => 1,
                Items    => [ 'Mystring', ... ],    # OPTIONAL
              },
              ForwardedValues => {
                QueryString => 1,
                Cookies     => {
                  Forward          => 'none',    # values: none, whitelist, all
                  WhitelistedNames => {
                    Quantity => 1,
                    Items    => [ 'Mystring', ... ],    # OPTIONAL
                  },    # OPTIONAL
                },
                Headers => {
                  Quantity => 1,
                  Items    => [ 'Mystring', ... ],    # OPTIONAL
                },    # OPTIONAL
                QueryStringCacheKeys => {
                  Quantity => 1,
                  Items    => [ 'Mystring', ... ],    # OPTIONAL
                },    # OPTIONAL
              },
              LambdaFunctionAssociations => {
                Quantity => 1,
                Items    => [
                  {
                    EventType => 'viewer-request'
                    , # values: viewer-request, viewer-response, origin-request, origin-response
                    LambdaFunctionARN => 'MyLambdaFunctionARN',

                  },
                  ...
                ],    # OPTIONAL
              },    # OPTIONAL
              MaxTTL                 => 1,
              DefaultTTL             => 1,
              SmoothStreaming        => 1,
              FieldLevelEncryptionId => 'Mystring',
              AllowedMethods         => {
                Items => [
                  'GET',
                  ...    # values: GET, HEAD, POST, PUT, PATCH, OPTIONS, DELETE
                ],
                Quantity      => 1,
                CachedMethods => {
                  Quantity => 1,
                  Items    => [
                    'GET',
                    ...   # values: GET, HEAD, POST, PUT, PATCH, OPTIONS, DELETE
                  ],

                },    # OPTIONAL
              },    # OPTIONAL
              Compress => 1,
            },
            ...
          ],        # OPTIONAL
        },    # OPTIONAL
        CustomErrorResponses => {
          Quantity => 1,
          Items    => [
            {
              ErrorCode          => 1,
              ResponseCode       => 'Mystring',
              ResponsePagePath   => 'Mystring',
              ErrorCachingMinTTL => 1,
            },
            ...
          ],    # OPTIONAL
        },    # OPTIONAL
        HttpVersion  => 'http1.1',    # values: http1.1, http2; OPTIONAL
        Restrictions => {
          GeoRestriction => {
            Quantity        => 1,
            RestrictionType => 'blacklist', # values: blacklist, whitelist, none
            Items => [ 'Mystring', ... ],   # OPTIONAL
          },

        },    # OPTIONAL
        IsIPV6Enabled => 1,
        WebACLId      => 'Mystring',
      },
      Id      => 'Mystring',
      IfMatch => 'Mystring',    # OPTIONAL
    );

    # Results:
    my $Distribution = $UpdateDistributionResult->Distribution;
    my $ETag         = $UpdateDistributionResult->ETag;

    # Returns a L<Paws::CloudFront::UpdateDistributionResult> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/cloudfront/UpdateDistribution>

=head1 ATTRIBUTES


=head2 B<REQUIRED> DistributionConfig => L<Paws::CloudFront::DistributionConfig>

The distribution's configuration information.



=head2 B<REQUIRED> Id => Str

The distribution's id.



=head2 IfMatch => Str

The value of the C<ETag> header that you received when retrieving the
distribution's configuration. For example: C<E2QWRUHAPOMQZL>.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method UpdateDistribution2017_10_30 in L<Paws::CloudFront>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


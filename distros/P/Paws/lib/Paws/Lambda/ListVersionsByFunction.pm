
package Paws::Lambda::ListVersionsByFunction;
  use Moose;
  has FunctionName => (is => 'ro', isa => 'Str', traits => ['ParamInURI'], uri_name => 'FunctionName', required => 1);
  has Marker => (is => 'ro', isa => 'Str', traits => ['ParamInQuery'], query_name => 'Marker');
  has MaxItems => (is => 'ro', isa => 'Int', traits => ['ParamInQuery'], query_name => 'MaxItems');

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'ListVersionsByFunction');
  class_has _api_uri  => (isa => 'Str', is => 'ro', default => '/2015-03-31/functions/{FunctionName}/versions');
  class_has _api_method  => (isa => 'Str', is => 'ro', default => 'GET');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::Lambda::ListVersionsByFunctionResponse');
1;

### main pod documentation begin ###

=head1 NAME

Paws::Lambda::ListVersionsByFunction - Arguments for method ListVersionsByFunction on L<Paws::Lambda>

=head1 DESCRIPTION

This class represents the parameters used for calling the method ListVersionsByFunction on the
L<AWS Lambda|Paws::Lambda> service. Use the attributes of this class
as arguments to method ListVersionsByFunction.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to ListVersionsByFunction.

=head1 SYNOPSIS

    my $lambda = Paws->service('Lambda');
    # To retrieve a list of Lambda function versions
    # This operation retrieves a Lambda function versions
    my $ListVersionsByFunctionResponse = $lambda->ListVersionsByFunction(
      {
        'FunctionName' => 'myFunction',
        'Marker'       => '',
        'MaxItems'     => 123
      }
    );

    # Results:
    my $NextMarker = $ListVersionsByFunctionResponse->NextMarker;
    my $Versions   = $ListVersionsByFunctionResponse->Versions;

    # Returns a L<Paws::Lambda::ListVersionsByFunctionResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/lambda/ListVersionsByFunction>

=head1 ATTRIBUTES


=head2 B<REQUIRED> FunctionName => Str

Function name whose versions to list. You can specify a function name
(for example, C<Thumbnail>) or you can specify Amazon Resource Name
(ARN) of the function (for example,
C<arn:aws:lambda:us-west-2:account-id:function:ThumbNail>). AWS Lambda
also allows you to specify a partial ARN (for example,
C<account-id:Thumbnail>). Note that the length constraint applies only
to the ARN. If you specify only the function name, it is limited to 64
characters in length.



=head2 Marker => Str

Optional string. An opaque pagination token returned from a previous
C<ListVersionsByFunction> operation. If present, indicates where to
continue the listing.



=head2 MaxItems => Int

Optional integer. Specifies the maximum number of AWS Lambda function
versions to return in response. This parameter value must be greater
than 0.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method ListVersionsByFunction in L<Paws::Lambda>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


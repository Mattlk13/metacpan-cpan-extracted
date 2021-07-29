
package Paws::LocationService::DescribeRouteCalculator;
  use Moose;
  has CalculatorName => (is => 'ro', isa => 'Str', traits => ['ParamInURI'], uri_name => 'CalculatorName', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'DescribeRouteCalculator');
  class_has _api_uri  => (isa => 'Str', is => 'ro', default => '/routes/v0/calculators/{CalculatorName}');
  class_has _api_method  => (isa => 'Str', is => 'ro', default => 'GET');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::LocationService::DescribeRouteCalculatorResponse');
1;

### main pod documentation begin ###

=head1 NAME

Paws::LocationService::DescribeRouteCalculator - Arguments for method DescribeRouteCalculator on L<Paws::LocationService>

=head1 DESCRIPTION

This class represents the parameters used for calling the method DescribeRouteCalculator on the
L<Amazon Location Service|Paws::LocationService> service. Use the attributes of this class
as arguments to method DescribeRouteCalculator.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to DescribeRouteCalculator.

=head1 SYNOPSIS

    my $geo = Paws->service('LocationService');
    my $DescribeRouteCalculatorResponse = $geo->DescribeRouteCalculator(
      CalculatorName => 'MyResourceName',

    );

    # Results:
    my $CalculatorArn  = $DescribeRouteCalculatorResponse->CalculatorArn;
    my $CalculatorName = $DescribeRouteCalculatorResponse->CalculatorName;
    my $CreateTime     = $DescribeRouteCalculatorResponse->CreateTime;
    my $DataSource     = $DescribeRouteCalculatorResponse->DataSource;
    my $Description    = $DescribeRouteCalculatorResponse->Description;
    my $PricingPlan    = $DescribeRouteCalculatorResponse->PricingPlan;
    my $Tags           = $DescribeRouteCalculatorResponse->Tags;
    my $UpdateTime     = $DescribeRouteCalculatorResponse->UpdateTime;

   # Returns a L<Paws::LocationService::DescribeRouteCalculatorResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/geo/DescribeRouteCalculator>

=head1 ATTRIBUTES


=head2 B<REQUIRED> CalculatorName => Str

The name of the route calculator resource.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method DescribeRouteCalculator in L<Paws::LocationService>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


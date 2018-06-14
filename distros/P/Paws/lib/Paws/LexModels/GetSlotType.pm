
package Paws::LexModels::GetSlotType;
  use Moose;
  has Name => (is => 'ro', isa => 'Str', traits => ['ParamInURI'], uri_name => 'name', required => 1);
  has Version => (is => 'ro', isa => 'Str', traits => ['ParamInURI'], uri_name => 'version', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'GetSlotType');
  class_has _api_uri  => (isa => 'Str', is => 'ro', default => '/slottypes/{name}/versions/{version}');
  class_has _api_method  => (isa => 'Str', is => 'ro', default => 'GET');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::LexModels::GetSlotTypeResponse');
1;

### main pod documentation begin ###

=head1 NAME

Paws::LexModels::GetSlotType - Arguments for method GetSlotType on L<Paws::LexModels>

=head1 DESCRIPTION

This class represents the parameters used for calling the method GetSlotType on the
L<Amazon Lex Model Building Service|Paws::LexModels> service. Use the attributes of this class
as arguments to method GetSlotType.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to GetSlotType.

=head1 SYNOPSIS

    my $models.lex = Paws->service('LexModels');
    my $GetSlotTypeResponse = $models . lex->GetSlotType(
      Name    => 'MySlotTypeName',
      Version => 'MyVersion',

    );

    # Results:
    my $CreatedDate            = $GetSlotTypeResponse->CreatedDate;
    my $Description            = $GetSlotTypeResponse->Description;
    my $Version                = $GetSlotTypeResponse->Version;
    my $LastUpdatedDate        = $GetSlotTypeResponse->LastUpdatedDate;
    my $Checksum               = $GetSlotTypeResponse->Checksum;
    my $EnumerationValues      = $GetSlotTypeResponse->EnumerationValues;
    my $ValueSelectionStrategy = $GetSlotTypeResponse->ValueSelectionStrategy;
    my $Name                   = $GetSlotTypeResponse->Name;

    # Returns a L<Paws::LexModels::GetSlotTypeResponse> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://aws.amazon.com/documentation/lex/>

=head1 ATTRIBUTES


=head2 B<REQUIRED> Name => Str

The name of the slot type. The name is case sensitive.



=head2 B<REQUIRED> Version => Str

The version of the slot type.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method GetSlotType in L<Paws::LexModels>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


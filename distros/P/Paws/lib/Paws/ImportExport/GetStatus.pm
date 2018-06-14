
package Paws::ImportExport::GetStatus;
  use Moose;
  has APIVersion => (is => 'ro', isa => 'Str');
  has JobId => (is => 'ro', isa => 'Str', required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'GetStatus');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::ImportExport::GetStatusOutput');
  class_has _result_key => (isa => 'Str', is => 'ro', default => 'GetStatusResult');
1;

### main pod documentation begin ###

=head1 NAME

Paws::ImportExport::GetStatus - Arguments for method GetStatus on L<Paws::ImportExport>

=head1 DESCRIPTION

This class represents the parameters used for calling the method GetStatus on the
L<AWS ImportE<sol>Export|Paws::ImportExport> service. Use the attributes of this class
as arguments to method GetStatus.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to GetStatus.

=head1 SYNOPSIS

    my $importexport = Paws->service('ImportExport');
    my $GetStatusOutput = $importexport->GetStatus(
      JobId      => 'MyJobId',
      APIVersion => 'MyAPIVersion',    # OPTIONAL
    );

    # Results:
    my $Signature             = $GetStatusOutput->Signature;
    my $ErrorCount            = $GetStatusOutput->ErrorCount;
    my $SignatureFileContents = $GetStatusOutput->SignatureFileContents;
    my $ProgressCode          = $GetStatusOutput->ProgressCode;
    my $LogBucket             = $GetStatusOutput->LogBucket;
    my $JobType               = $GetStatusOutput->JobType;
    my $LogKey                = $GetStatusOutput->LogKey;
    my $ArtifactList          = $GetStatusOutput->ArtifactList;
    my $LocationCode          = $GetStatusOutput->LocationCode;
    my $TrackingNumber        = $GetStatusOutput->TrackingNumber;
    my $CurrentManifest       = $GetStatusOutput->CurrentManifest;
    my $CreationDate          = $GetStatusOutput->CreationDate;
    my $LocationMessage       = $GetStatusOutput->LocationMessage;
    my $Carrier               = $GetStatusOutput->Carrier;
    my $ProgressMessage       = $GetStatusOutput->ProgressMessage;
    my $JobId                 = $GetStatusOutput->JobId;

    # Returns a L<Paws::ImportExport::GetStatusOutput> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://aws.amazon.com/documentation/>

=head1 ATTRIBUTES


=head2 APIVersion => Str





=head2 B<REQUIRED> JobId => Str






=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method GetStatus in L<Paws::ImportExport>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


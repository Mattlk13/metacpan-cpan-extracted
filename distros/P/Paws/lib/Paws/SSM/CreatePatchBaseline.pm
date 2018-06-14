
package Paws::SSM::CreatePatchBaseline;
  use Moose;
  has ApprovalRules => (is => 'ro', isa => 'Paws::SSM::PatchRuleGroup');
  has ApprovedPatches => (is => 'ro', isa => 'ArrayRef[Str|Undef]');
  has ApprovedPatchesComplianceLevel => (is => 'ro', isa => 'Str');
  has ApprovedPatchesEnableNonSecurity => (is => 'ro', isa => 'Bool');
  has ClientToken => (is => 'ro', isa => 'Str');
  has Description => (is => 'ro', isa => 'Str');
  has GlobalFilters => (is => 'ro', isa => 'Paws::SSM::PatchFilterGroup');
  has Name => (is => 'ro', isa => 'Str', required => 1);
  has OperatingSystem => (is => 'ro', isa => 'Str');
  has RejectedPatches => (is => 'ro', isa => 'ArrayRef[Str|Undef]');
  has Sources => (is => 'ro', isa => 'ArrayRef[Paws::SSM::PatchSource]');

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'CreatePatchBaseline');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::SSM::CreatePatchBaselineResult');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::SSM::CreatePatchBaseline - Arguments for method CreatePatchBaseline on L<Paws::SSM>

=head1 DESCRIPTION

This class represents the parameters used for calling the method CreatePatchBaseline on the
L<Amazon Simple Systems Manager (SSM)|Paws::SSM> service. Use the attributes of this class
as arguments to method CreatePatchBaseline.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to CreatePatchBaseline.

=head1 SYNOPSIS

    my $ssm = Paws->service('SSM');
    my $CreatePatchBaselineResult = $ssm->CreatePatchBaseline(
      Name          => 'MyBaselineName',
      ApprovalRules => {
        PatchRules => [
          {
            PatchFilterGroup => {
              PatchFilters => [
                {
                  Values => [
                    'MyPatchFilterValue', ...    # min: 1, max: 64
                  ],                             # min: 1, max: 20
                  Key => 'PRODUCT'
                  , # values: PRODUCT, CLASSIFICATION, MSRC_SEVERITY, PATCH_ID, SECTION, PRIORITY, SEVERITY

                },
                ...
              ],    # max: 4

            },
            ApproveAfterDays  => 1,           # max: 100
            EnableNonSecurity => 1,           # OPTIONAL
            ComplianceLevel   => 'CRITICAL'
            , # values: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED; OPTIONAL
          },
          ...
        ],    # max: 10

      },    # OPTIONAL
      ApprovedPatches => [
        'MyPatchId', ...    # min: 1, max: 100
      ],                    # OPTIONAL
      ApprovedPatchesComplianceLevel   => 'CRITICAL',                 # OPTIONAL
      ApprovedPatchesEnableNonSecurity => 1,                          # OPTIONAL
      ClientToken                      => 'MyClientToken',            # OPTIONAL
      Description                      => 'MyBaselineDescription',    # OPTIONAL
      GlobalFilters                    => {
        PatchFilters => [
          {
            Values => [
              'MyPatchFilterValue', ...    # min: 1, max: 64
            ],                             # min: 1, max: 20
            Key => 'PRODUCT'
            , # values: PRODUCT, CLASSIFICATION, MSRC_SEVERITY, PATCH_ID, SECTION, PRIORITY, SEVERITY

          },
          ...
        ],    # max: 4

      },    # OPTIONAL
      OperatingSystem => 'WINDOWS',    # OPTIONAL
      RejectedPatches => [
        'MyPatchId', ...               # min: 1, max: 100
      ],                               # OPTIONAL
      Sources => [
        {
          Name          => 'MyPatchSourceName',
          Configuration => 'MyPatchSourceConfiguration',    # min: 1, max: 512
          Products      => [
            'MyPatchSourceProduct', ...                     # min: 1, max: 128
          ],                                                # min: 1, max: 20

        },
        ...
      ],                                                    # OPTIONAL
    );

    # Results:
    my $BaselineId = $CreatePatchBaselineResult->BaselineId;

    # Returns a L<Paws::SSM::CreatePatchBaselineResult> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/ssm/CreatePatchBaseline>

=head1 ATTRIBUTES


=head2 ApprovalRules => L<Paws::SSM::PatchRuleGroup>

A set of rules used to include patches in the baseline.



=head2 ApprovedPatches => ArrayRef[Str|Undef]

A list of explicitly approved patches for the baseline.

For information about accepted formats for lists of approved patches
and rejected patches, see Package Name Formats for Approved and
Rejected Patch Lists
(http://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html)
in the I<AWS Systems Manager User Guide>.



=head2 ApprovedPatchesComplianceLevel => Str

Defines the compliance level for approved patches. This means that if
an approved patch is reported as missing, this is the severity of the
compliance violation. The default value is UNSPECIFIED.

Valid values are: C<"CRITICAL">, C<"HIGH">, C<"MEDIUM">, C<"LOW">, C<"INFORMATIONAL">, C<"UNSPECIFIED">

=head2 ApprovedPatchesEnableNonSecurity => Bool

Indicates whether the list of approved patches includes non-security
updates that should be applied to the instances. The default value is
'false'. Applies to Linux instances only.



=head2 ClientToken => Str

User-provided idempotency token.



=head2 Description => Str

A description of the patch baseline.



=head2 GlobalFilters => L<Paws::SSM::PatchFilterGroup>

A set of global filters used to exclude patches from the baseline.



=head2 B<REQUIRED> Name => Str

The name of the patch baseline.



=head2 OperatingSystem => Str

Defines the operating system the patch baseline applies to. The Default
value is WINDOWS.

Valid values are: C<"WINDOWS">, C<"AMAZON_LINUX">, C<"UBUNTU">, C<"REDHAT_ENTERPRISE_LINUX">, C<"SUSE">, C<"CENTOS">

=head2 RejectedPatches => ArrayRef[Str|Undef]

A list of explicitly rejected patches for the baseline.

For information about accepted formats for lists of approved patches
and rejected patches, see Package Name Formats for Approved and
Rejected Patch Lists
(http://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html)
in the I<AWS Systems Manager User Guide>.



=head2 Sources => ArrayRef[L<Paws::SSM::PatchSource>]

Information about the patches to use to update the instances, including
target operating systems and source repositories. Applies to Linux
instances only.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method CreatePatchBaseline in L<Paws::SSM>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


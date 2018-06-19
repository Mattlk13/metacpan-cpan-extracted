
package Paws::CodeStar::CreateProject;
  use Moose;
  has ClientRequestToken => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'clientRequestToken' );
  has Description => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'description' );
  has Id => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'id' , required => 1);
  has Name => (is => 'ro', isa => 'Str', traits => ['NameInRequest'], request_name => 'name' , required => 1);

  use MooseX::ClassAttribute;

  class_has _api_call => (isa => 'Str', is => 'ro', default => 'CreateProject');
  class_has _returns => (isa => 'Str', is => 'ro', default => 'Paws::CodeStar::CreateProjectResult');
  class_has _result_key => (isa => 'Str', is => 'ro');
1;

### main pod documentation begin ###

=head1 NAME

Paws::CodeStar::CreateProject - Arguments for method CreateProject on L<Paws::CodeStar>

=head1 DESCRIPTION

This class represents the parameters used for calling the method CreateProject on the
L<AWS CodeStar|Paws::CodeStar> service. Use the attributes of this class
as arguments to method CreateProject.

You shouldn't make instances of this class. Each attribute should be used as a named argument in the call to CreateProject.

=head1 SYNOPSIS

    my $codestar = Paws->service('CodeStar');
    my $CreateProjectResult = $codestar->CreateProject(
      Id                 => 'MyProjectId',
      Name               => 'MyProjectName',
      ClientRequestToken => 'MyClientRequestToken',    # OPTIONAL
      Description        => 'MyProjectDescription',    # OPTIONAL
    );

    # Results:
    my $Arn                = $CreateProjectResult->Arn;
    my $ClientRequestToken = $CreateProjectResult->ClientRequestToken;
    my $Id                 = $CreateProjectResult->Id;
    my $ProjectTemplateId  = $CreateProjectResult->ProjectTemplateId;

    # Returns a L<Paws::CodeStar::CreateProjectResult> object.

Values for attributes that are native types (Int, String, Float, etc) can passed as-is (scalar values). Values for complex Types (objects) can be passed as a HashRef. The keys and values of the hashref will be used to instance the underlying object.
For the AWS API documentation, see L<https://docs.aws.amazon.com/goto/WebAPI/codestar/CreateProject>

=head1 ATTRIBUTES


=head2 ClientRequestToken => Str

Reserved for future use.



=head2 Description => Str

Reserved for future use.



=head2 B<REQUIRED> Id => Str

Reserved for future use.



=head2 B<REQUIRED> Name => Str

Reserved for future use.




=head1 SEE ALSO

This class forms part of L<Paws>, documenting arguments for method CreateProject in L<Paws::CodeStar>

=head1 BUGS and CONTRIBUTIONS

The source code is located here: L<https://github.com/pplu/aws-sdk-perl>

Please report bugs to: L<https://github.com/pplu/aws-sdk-perl/issues>

=cut


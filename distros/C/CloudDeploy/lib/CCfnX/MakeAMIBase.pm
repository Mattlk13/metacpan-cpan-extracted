package CCfnX::MakeAMIBase {
  use Moose;
  extends 'CCfn';
  use CCfnX::Shortcuts;
  use CCfnX::UserData;
  use CCfnX::CreateAMIUserData;

  resource CfnUser => 'AWS::IAM::User', {
    Path => '/',
  };

  resource CfnPolicy => 'AWS::IAM::Policy', {
    PolicyName => 'AbilityToGetMetadata',
    Roles => [ Ref('CfnRole') ],
    Users => [ Ref('CfnUser') ],
    PolicyDocument => {
      Statement => [ {
        Effect   => "Allow",
        Action   => "cloudformation:DescribeStackResource",
        Resource => "*"
      }, ]
    },
  };

  resource CfnRole => 'AWS::IAM::Role', {
    Path => '/',
    AssumeRolePolicyDocument => {
      Statement => [ {
        Effect => 'Allow',
        Principal => { Service => [ 'ec2.amazonaws.com' ] },
        Action => [ 'sts:AssumeRole' ]
      } ]
    },
  };

  resource CfnInstanceProfile => 'AWS::IAM::InstanceProfile', {
    Path => '/',
    Roles => [ Ref('CfnRole') ]
  };

  resource HostKeys => 'AWS::IAM::AccessKey', {
    UserName => Ref('CfnUser')
  };
  resource CreateAMISG => 'AWS::EC2::SecurityGroup', {
    GroupDescription => "Security Group for Creating an AMI",
    SecurityGroupIngress => [ SGRule(22, '0.0.0.0/0') ],
  };

  sub BUILD {
    my $self = shift;
    my $udata;
    if (not defined $self->params->template) {
      warn "You haven't passed templates to this deployment. Please make sure that you signal stack completion with cfn-signal -e 0 -r \"cfn-int setup complete\" '#-#WaitHandle#-#' if you're not in --devel mode";
    } else {
      $udata = CCfnX::CreateAMIUserData->new(files => $self->params->template, signal => (! $self->params->devel), os_family => $self->params->os_family);
    }

    my $kp = $self->params->keypair;
    $self->addResource(
      "Instance", 'AWS::EC2::Instance',
          Tags => [ Tag('Name', Parameter('name')) ],
          ImageId => $self->params->ami,
          InstanceType => $self->params->instance_type,
          SecurityGroups => [ Ref('CreateAMISG') ],
          IamInstanceProfile => Ref('CfnInstanceProfile'),
          ($kp)    ? (KeyName => $kp)     : (),
          ($udata) ? (UserData => $udata) : (),
    );

    $self->addOutput(
      InstanceID => Ref('Instance'),
    );
    $self->addOutput(
      InstanceAddress => GetAtt('Instance', 'PublicIp')
    );

    if (not $self->params->devel){
      $self->addResource(
        "WaitCondition", 'AWS::CloudFormation::WaitCondition',
          Handle  => Ref('WaitHandle'),
          Timeout => "14400"
      );
      $self->addResource(
        "WaitHandle", 'AWS::CloudFormation::WaitConditionHandle'
      );
    }
  }
}

1;

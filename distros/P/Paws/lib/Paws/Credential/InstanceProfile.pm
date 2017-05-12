package Paws::Credential::InstanceProfile;
  use JSON::MaybeXS;
  use Moose;
  use DateTime::Format::ISO8601;
  with 'Paws::Credential';

  has metadata_url => (
    is => 'ro',
    isa => 'Str',
    default => 'http://169.254.169.254/latest/meta-data/iam/security-credentials/'
  );

  has timeout => (is => 'ro', isa => 'Int', default => 1);

  has ua => (
    is => 'ro',
    lazy => 1,
    default => sub {
      my $self = shift;
      use HTTP::Tiny;
      HTTP::Tiny->new(
        agent => 'AWS Perl SDK',
        timeout => $self->timeout,
      );
    }
  );

  has expiration => (
    is => 'rw',
    isa => 'Int',
    default => sub { 0 }
  );

  has actual_creds => (is => 'rw', default => sub { {} });

  sub access_key {
    my $self = shift;
    $self->_refresh;
    $self->actual_creds->{AccessKeyId};
  }

  sub secret_key {
    my $self = shift;
    $self->_refresh;
    $self->actual_creds->{SecretAccessKey};
  }

  sub session_token {
    my $self = shift;
    $self->_refresh;
    $self->actual_creds->{Token};
  }

  #TODO: Raise exceptions if HTTP get didn't return success
  sub _refresh {
    my $self = shift;

    return if $self->expiration >= time;

    my $ua = $self->ua;
    my $r = $ua->get($self->metadata_url);
    return unless $r->{success};
    return unless $r->{content};

    $r = $ua->get($self->metadata_url . $r->{content});
    return unless $r->{success};

    my $json = eval { decode_json($r->{content}) };
    if ($@) { die "Error in JSON from metadata URL" }

    $self->actual_creds($json);
    $self->expiration(DateTime::Format::ISO8601->parse_datetime($json->{Expiration})->epoch);
  }

  no Moose;
1;

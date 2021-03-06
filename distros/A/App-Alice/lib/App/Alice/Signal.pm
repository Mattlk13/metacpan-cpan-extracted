package App::Alice::Signal;

use AnyEvent;
use Any::Moose;

has type => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);

has app => (
  is  => 'ro',
  isa => 'App::Alice',
  weak_ref => 1,
  required => 1,
);

sub BUILD {
  my $self = shift;
  my $method = "sig" . lc $self->type;
  $self->$method();
}

sub sigint  {$_[0]->app->init_shutdown};
sub sigquit {$_[0]->app->init_shutdown};

__PACKAGE__->meta->make_immutable;
1;

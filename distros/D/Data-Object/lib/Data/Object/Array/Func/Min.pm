package Data::Object::Array::Func::Min;

use 5.014;

use strict;
use warnings;

use registry 'Data::Object::Types';

use Data::Object::Class;
use Data::Object::ClassHas;

extends 'Data::Object::Array::Func';

our $VERSION = '2.05'; # VERSION

# BUILD

has arg1 => (
  is => 'ro',
  isa => 'ArrayLike',
  req => 1
);

# METHODS

sub execute {
  my ($self) = @_;

  my ($data) = $self->unpack;

  my $min;

  for my $val (@$data) {
    next if ref($val);
    next if !defined($val);
    next if !Scalar::Util::looks_like_number($val);

    $min //= $val;
    $min = $val if $val < $min;
  }

  return $min;
}

sub mapping {
  return ('arg1');
}

1;

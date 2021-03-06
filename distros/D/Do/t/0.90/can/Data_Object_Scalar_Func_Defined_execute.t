use 5.014;

use strict;
use warnings;

use Test::More;

# POD

=name

execute

=usage

  my $data = Data::Object::Scalar->new(\*main);

  my $func = Data::Object::Scalar::Func::Defined->new(
    arg1 => $data
  );

  my $result = $func->execute;

=description

Executes the function logic and returns the result.

=signature

execute() : Object

=type

method

=cut

# TESTING

no warnings 'once';

use Data::Object::Scalar;
use Data::Object::Scalar::Func::Defined;

can_ok "Data::Object::Scalar::Func::Defined", "execute";

my $data;
my $func;

$data = Data::Object::Scalar->new(\*main);
$func = Data::Object::Scalar::Func::Defined->new(
  arg1 => $data
);

my $result = $func->execute;

is_deeply $result, 1;

ok 1 and done_testing;

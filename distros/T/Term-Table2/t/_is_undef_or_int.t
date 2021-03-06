#!/usr/bin/env perl

use v5.14;
use warnings FATAL => qw(all);

package Term::Table2;

use Test2::V0 -target => 'Term::Table2';
use Test2::Mock;

my $isIntFlag;
my $mockThis = Test2::Mock->new(
  class    => $CLASS,
  override => [
    _is_int  => sub { return $isIntFlag },
  ]
);

$isIntFlag = '';
is(_is_undef_or_int(),   1, 'Undefined');

$isIntFlag = 1;
is(_is_undef_or_int(1),  1, 'Integer');

$isIntFlag = '';
is(_is_undef_or_int(1), '', 'No integer');

done_testing();
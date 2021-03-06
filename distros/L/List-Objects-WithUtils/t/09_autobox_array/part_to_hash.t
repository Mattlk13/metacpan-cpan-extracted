use Test::More;
use strict; use warnings FATAL => 'all';

use Lowu;

my $hs = 
  [qw/ann andy bob fred frankie/]
    ->part_to_hash(sub { ucfirst substr $_, 0, 1 });

isa_ok $hs, 'List::Objects::WithUtils::Hash';

ok $hs->keys->count == 3, 'boxed part_to_hash created 3 keys';

for (qw/A B F/) {
  isa_ok $hs->get($_), 'List::Objects::WithUtils::Array', "part '$_'";
}

is_deeply +{ $hs->export },
  +{ A => [qw/ann andy/], B => ['bob'], F => [qw/fred frankie/] },
  'boxed part_to_hash looks ok';

done_testing;

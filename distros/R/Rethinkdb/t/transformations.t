use Test::More;

plan skip_all => 'set TEST_ONLINE to enable this test'
  unless $ENV{TEST_ONLINE};

use Rethinkdb;

# setup
my $conn = r->connect->repl;
r->db('test')->drop->run;
r->db('test')->create->run;
r->db('test')->table('marvel')->create( primary_key => 'superhero' )->run;
r->table('marvel')->insert(
  [
    {
      user_id    => 1,
      superhero  => 'Iron Man',
      superpower => 'Arc Reactor',
      active     => 1,
      age        => 35,
      monsters   => ['Wererabit']
    },
    {
      user_id    => 2,
      superhero  => 'Hulk',
      superpower => 'Smash',
      active     => 1,
      age        => 38,
      monsters   => ['Werewolf']
    },
    {
      user_id    => 3,
      superhero  => 'Captain America',
      superpower => 'Super Strength',
      active     => 1,
      age        => 135,
      monsters   => ['Werecat']
    },
    {
      user_id    => 4,
      superhero  => 'Thor',
      superpower => 'God-like powers',
      active     => 1,
      age        => 1035,
      monsters   => ['Weredog']
    },
    {
      user_id    => 5,
      superhero  => 'Hawk-Eye',
      superpower => 'Bow-n-arrow',
      active     => 0,
      age        => 32,
      monsters   => ['Werehound']
    },
    {
      user_id    => 6,
      superhero  => 'Wasp',
      superpower => 'Bio-lasers',
      active     => 0,
      age        => 29,
      monsters   => ['Wereelephant']
    },
    {
      user_id    => 7,
      superhero  => 'Ant-Man',
      superpower => 'Size',
      active     => 1,
      age        => 34,
      monsters   => ['Werebear']
    },
    {
      user_id    => 8,
      superhero  => 'Wolverine',
      superpower => 'Adamantium',
      active     => 0,
      age        => 40,
      monsters   => ['Werehampster']
    },
    {
      user_id    => 9,
      superhero  => 'Spider-Man',
      superpower => 'Spidy Sense',
      active     => 0,
      age        => 20,
      monsters   => [ 'Werepig', 'Werechicken' ]
    },
  ]
)->run;

r->db('test')->table('dc')->create( primary_key => 'superhero' )->run;
r->table('dc')->insert(
  [
    {
      user_id    => 10,
      superhero  => '271',
      superpower => 'Alien',
      active     => 1,
      age        => 35
    },
    {
      user_id    => 11,
      superhero  => 'Batman',
      superpower => 'Cunning',
      active     => 1,
      age        => 35
    },
    {
      user_id    => 12,
      superhero  => 'Flash',
      superpower => 'Super Speed',
      active     => 1,
      age        => 135
    },
    {
      user_id    => 13,
      superhero  => 'Wonder Women',
      superpower => 'Super Stregth',
      active     => 1,
      age        => 1035
    },
    {
      user_id    => 14,
      superhero  => 'Green Lantern',
      superpower => 'Ring',
      active     => 0,
      age        => 35
    },
    {
      user_id    => 15,
      superhero  => 'Aquaman',
      superpower => 'Hydrokinesis',
      active     => 0,
      age        => 35
    },
    {
      user_id    => 16,
      superhero  => 'Hawkman',
      superpower => 'Ninth Metal',
      active     => 1,
      age        => 35
    },
    {
      user_id    => 17,
      superhero  => 'Martian Manhunter',
      superpower => 'Shapeshifting',
      active     => 0,
      age        => 35
    },
  ]
)->run;

my $res;

# map
$res = r->table('marvel')->map(
  sub {
    my $hero = shift;
    return $hero->bracket('user_id')->add( $hero->bracket('age')->mul(2) );
  }
)->run;

is $res->type, 2, 'Correct response type';

is_deeply [ sort @{ $res->response } ],
  [ '2074', '273', '49', '64', '69', '71', '75', '78', '88' ],
  'Correct number of documents';

# with_fields
$res = r->table('marvel')->with_fields( 'superhero', 'age' )->run;

isa_ok $res, 'Rethinkdb::Response', 'Correct class';
is $res->type, 2, 'Correct response type';
is scalar @{ $res->response }, 9, 'Correct number of documents';
is_deeply [ sort keys %{ $res->response->[0] } ], [ 'age', 'superhero' ],
  'Correct document fields';

# concat_map
$res = r->table('marvel')->concat_map(
  sub {
    my $hero = shift;
    return $hero->bracket('monsters');
  }
)->run;

is $res->type, 2, 'Correct response type';
is_deeply [ sort @{ $res->response } ],
  [
  'Werebear',     'Werecat',      'Werechicken', 'Weredog',
  'Wereelephant', 'Werehampster', 'Werehound',   'Werepig',
  'Wererabit',    'Werewolf',
  ],
  'Correct document fields';

# order_by
$res = r->table('marvel')->order_by('superhero')->run;

isa_ok $res, 'Rethinkdb::Response', 'Correct class';
is $res->type,         1,       'Correct response type';
isa_ok $res->response, 'ARRAY', 'Correct response type';
is scalar @{ $res->response }, 9, 'Correct number of documents returned';
is_deeply [ map { $_->{superhero} } @{ $res->response } ],
  [
  'Ant-Man',  'Captain America', 'Hawk-Eye', 'Hulk',
  'Iron Man', 'Spider-Man',      'Thor',     'Wasp',
  'Wolverine'
  ],
  'Correct order';

my $order = [
  'Spider-Man', 'Wasp', 'Hawk-Eye',  'Ant-Man',
  'Iron Man',   'Hulk', 'Wolverine', 'Captain America',
  'Thor'
];

# order by two attributes
$res = r->table('marvel')->order_by( 'age', 'superhero' )->run;

is_deeply [ map { $_->{superhero} } @{ $res->response } ], $order,
  'Correct order';

# order with asc/desc
$res
  = r->table('marvel')->order_by( r->desc('age'), r->asc('superhero') )->run;

is_deeply [ map { $_->{superhero} } @{ $res->response } ],
  [ reverse @{$order} ], 'Correct order';

# skip
$res = r->table('marvel')->order_by('superhero')->skip(7)->run;

is $res->type, 1, 'Correct response type';
is $res->response->[0]->{superhero}, 'Wasp',      'Correct response';
is $res->response->[1]->{superhero}, 'Wolverine', 'Correct response';

# limit
$res = r->table('marvel')->limit(2)->run;

is $res->type, 2, 'Correct response type';
is scalar @{ $res->response }, 2, 'Correct number of documents';

# slice
# $r->table('marvel')->order_by('strength')[5:10]->run;
# $res = r->table('marvel')->order_by('superhero')->slice(1, 3)->run;
$res = r->table('marvel')->slice( 5, 7 )->run;

is $res->type, 2, 'Correct response type';
is scalar @{ $res->response }, 2, 'Correct number of documents';

# nth
# $r->expr([1,2,3])[1]->run;
# $res = r->expr([1,2,3])->nth(1)->run;
$res = r->table('marvel')->nth(1)->run;

is $res->type,         1,      'Correct response type';
isa_ok $res->response, 'HASH', 'Correct type of response';

# offsets_of
$res = r->expr( [ 'a', 'b', 'c' ] )->offsets_of('c')->run($conn);

is $res->type, 1, 'Correct response type';
is_deeply $res->response, [2], 'Correct response';

$res
  = r->table('marvel')->union( r->table('dc') )->order_by('popularity')
  ->offsets_of( r->row->bracket('superpowers')->contains('invisibility') )
  ->run;

# is_empty
$res = r->table('marvel')->is_empty->run;

is $res->type, 1, 'Correct response type';
is $res->response, r->false, 'Correct response';

# union
$res = r->table('marvel')->union( r->table('dc') )->run;

is $res->type, 2, 'Correct response type';
is scalar @{ $res->response }, 17, 'Correct response';

# sample
$res = r->table('marvel')->sample(3)->run;

is $res->type, 1, 'Correct response type';
is scalar @{ $res->response }, 3, 'Correct response';

# clean up
r->db('test')->drop->run;

done_testing();

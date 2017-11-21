use 5.014;
use strict;
use warnings;
use Test::More;
use Test::Exception;
use Test::Deep;
use JSON::MaybeXS;
use Data::Dumper;

my $JSON = JSON::MaybeXS->new->allow_nonref->canonical;

BEGIN {
  use_ok( 'GraphQL::Schema' ) || print "Bail out!\n";
  use_ok( 'GraphQL::Execution', qw(execute) ) || print "Bail out!\n";
}

sub run_test {
  my ($args, $expected) = @_;
  my $got = execute(@$args);
  is_deeply $got, $expected or diag nice_dump($got);
}

sub nice_dump {
  my ($got) = @_;
  local ($Data::Dumper::Sortkeys, $Data::Dumper::Indent, $Data::Dumper::Terse);
  $Data::Dumper::Sortkeys = $Data::Dumper::Indent = $Data::Dumper::Terse = 1;
  Dumper $got;
}

subtest 'DateTime->now as resolve' => sub {
  require DateTime;
  my $schema = GraphQL::Schema->from_doc(<<'EOF');
type DateTimeObj { ymd: String }
type Query { dateTimeNow: DateTimeObj }
EOF
  my $now = DateTime->now;
  my $root_value = { dateTimeNow => sub { $now } };
  run_test([
    $schema, "{ dateTimeNow { ymd } }", $root_value, (undef) x 3, sub {
      my ($root_value, $args, $context, $info) = @_;
      my $field_name = $info->{field_name};
      my $property = ref($root_value) eq 'HASH'
        ? $root_value->{$field_name} 
        : $root_value;
      return $property->($args, $context, $info) if ref $property eq 'CODE';
      return $root_value->$field_name if ref $property; # no args
      $property;
    }
  ],
    { data => { dateTimeNow => { ymd => scalar $now->ymd } } },
  );
};

subtest 'DateTime type' => sub {
  require DateTime;
  my $schema = GraphQL::Schema->from_doc(<<'EOF');
type Query { dateTimeNow: DateTime }
EOF
  my $now = DateTime->now;
  my $root_value = { dateTimeNow => sub { $now } };
  run_test([ $schema, "{ dateTimeNow }", $root_value, (undef) x 3 ],
    { data => { dateTimeNow => $now.'' } },
  );
};

subtest 'nice errors Schema.from_ast' => sub {
  eval { GraphQL::Schema->from_ast([
    {
      'fields' => {
        'subtitle' => { 'type' => undef },
      },
      'kind' => 'type',
      'name' => 'Blog'
    },
    {
      'fields' => {
        'blog' => { 'type' => [ 'list', { 'type' => 'Blog' } ] },
      },
      'kind' => 'type',
      'name' => 'Query'
    },
  ]) };
  is $@, "Error in field 'subtitle': Undefined type given\n";
};

subtest 'test convert plugin' => sub {
  require_ok 'GraphQL::Plugin::Convert::Test';
  my $converted = GraphQL::Plugin::Convert::Test->to_graphql;
  run_test([
    $converted->{schema}, '{helloWorld}', $converted->{root_value}
  ],
    { data => { helloWorld => 'Hello, world!' } },
  );
};

done_testing;

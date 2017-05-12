use strict;
use warnings;

use Test::More;

use Net::Async::Redis;
use IO::Async::Loop;

plan skip_all => 'set NET_ASYNC_REDIS_HOST env var to test' unless exists $ENV{NET_ASYNC_REDIS_HOST};

my $loop = IO::Async::Loop->new;
$loop->add(my $redis = Net::Async::Redis->new);
ok(my $f = $redis->connect(
	host => $ENV{NET_ASYNC_REDIS_HOST} // '127.0.0.1',
), 'connect');
isa_ok($f, 'Future');
$loop->await($f);
ok($redis->stream, 'have a stream');
isa_ok($redis->stream, 'IO::Async::Stream');
my @keys = $redis->keys('*')->get;
note "Had " . @keys . " keys back";
note " * $_" for @keys;
note "Set key";
$redis->set(xyz => 'test')->get;
note "Get key";
is($redis->get('xyz')->get, 'test');
note "Delete key";
is($redis->del('xyz')->get, 1, 'deleted a single key');
note "Get key";
ok(!$redis->exists('xyz')->get, 'no longer exists');

done_testing;



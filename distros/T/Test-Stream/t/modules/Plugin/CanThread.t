use strict;
use warnings;
use Carp q/cluck/;
my $inc;
BEGIN {
    $inc = sub {
        my ($us, $got) = @_;
        cluck "loadng $got!" if $got =~ m/threads/i
    };
    unshift @INC => $inc;
}
use Test::Stream qw/-V1 CanThread/;
BEGIN {
    @INC = grep { !(ref($_) && $_ == $inc) } @INC;
}

plan 3;

ok(!$INC{"threads.pm"}, "did not load threads for us");

require threads;
require threads::shared;
threads->import('yield');
threads::shared->import('share');

my $go = 0;
share(\$go);

# Create a thread, and ensure it runs AFTER the main thread is done
# This will check the auto-join behavior
my $thread = threads->create(sub {
    while (!$go) { yield() };
    yield();
    ok(1, "inside thread");
});

ok(1, "outside thread");
$go = 1;

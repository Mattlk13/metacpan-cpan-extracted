use Test::Stream qw/-V1 CanFork/;

plan 2;

my $pid = fork;
die "Could not fork!" unless defined $pid;

unless ($pid) {
    ok(1, "In forked process ($$)");
    exit 0;
}

ok(1, "Inside parent process ($$)");

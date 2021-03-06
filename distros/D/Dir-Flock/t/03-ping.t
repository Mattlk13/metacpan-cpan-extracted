use strict;
use warnings;
use Test::More;
use Dir::Flock;

# can we detect a stale lock and override it?

pipe *P1, *P2;
(*P2)->autoflush(1);
sleep 2;

my $dir = Dir::Flock::getDir("t");
diag "t/03: dir is $dir";
ok(!!$dir, 'getDir returned value');
ok(-d $dir, 'getDir returned dir');
ok(-r $dir, 'getDir return value is readable');
ok(-w $dir, 'getDir return value is writeable');

my @t = glob("$dir/dir-flock-*");
ok(@t == 0, "lock directory is empty because it is new");

if (fork() == 0) {
    close P1;
    my $z1 = Dir::Flock::lock($dir);
    my ($z2,$z3);
    # make a copy of the lockfile
    my ($t) = glob("$dir/dir-flock-*");
    if (-f $t) {
	diag "duplicating $t";
	$z2 = open my $fh2, ">", "$t-copy";
	$z3 = open my $fh1, "<", $t;
	print $fh2 readline($fh1);
	close $fh1;
	close $fh2;
    } elsif (-d $t) {
	mkdir "$dir/dir-flock-2";
	for my $tt (glob("$dir/dir-flock-1/*")) {
	    diag "duplicating $tt";
	    my $uu = $tt;
	    $uu =~ s/flock-1/flock-2/;
	    $z2 = open my $fh2, ">", $uu;
	    $z3 = open my $fh1, "<", $tt;
	    print $fh2 readline($fh1);
	    close $fh1;
	    close $fh2;
	}
    }
    my $z4 = Dir::Flock::unlock($dir);
    no warnings 'uninitialized';
    diag "child status: $z1/$z2/$z3/$z4\n";
    print P2 "$z1 $z2 $z3 $z4\n";
    exit 0;
}

close P2;
my $z = <P1>;
close P1;
wait;         # so child process is reaped

opendir DH, $dir; readdir DH; closedir DH;
@t = glob("$dir/dir-flock-*");
ok(@t > 0, "lock directory is not empty because child has lock");

my $t1 = time;
my $p = Dir::Flock::lock($dir, 0);
my $t2 = time;
ok(!$p, "flock failed in parent")
    or Dir::Flock::unlock($dir);
ok($t2-$t1 < 2, "flock failed fast with 0 timeout");

$Dir::Flock::HEARTBEAT_CHECK = 3;

my $q = Dir::Flock::lock($dir,10);
my $t3 = time;
ok($q, "flock succeeded in parent") or diag $t3-$t2;
ok($t3-$t2 > 2, "flock in parent had to wait for stale lock to be removed");
my $r = Dir::Flock::unlock($dir);
ok($r, "funlock successful");

done_testing;



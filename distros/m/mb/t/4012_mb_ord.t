# This file is encoded in Shift_JIS.
die "This file is not encoded in Shift_JIS.\n" if '��' ne "\x82\xA0";
die "This script is for perl only. You are using $^X.\n" if $^X =~ /jperl/i;

use strict;
use FindBin;
use lib "$FindBin::Bin/../lib";
use mb;
mb::set_script_encoding('sjis');
use vars qw(@test);

@test = (
# 1
    sub { $_='A'; my $r=    ord($_); $r == 0x41 },
    sub { $_='A'; my $r=    ord;     $r == 0x41 },
    sub { $_='A'; my $r=mb::ord($_); $r == 0x41 },
    sub { $_='A'; my $r=mb::ord;     $r == 0x41 },
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
# 11
    sub { $_='��'; my $r=mb::ord($_); $r == 0x82A0 },
    sub { $_='��'; my $r=mb::ord;     $r == 0x82A0 },
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
#
);

$|=1; print "1..",scalar(@test),"\n"; my $testno=1; sub ok { print $_[0]?'ok ':'not ok ',$testno++,$_[1]?" - $_[1]\n":"\n" } ok($_->()) for @test;

__END__

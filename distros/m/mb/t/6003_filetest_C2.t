# This file is encoded in Shift_JIS.
die "This file is not encoded in Shift_JIS.\n" if '��' ne "\x82\xA0";
die "This script is for perl only. You are using $^X.\n" if $^X =~ /jperl/i;

use strict;
use FindBin;
use lib "$FindBin::Bin/../lib";
use mb;
mb::set_script_encoding('sjis');
use vars qw(@test);

use vars qw($MSWin32_MBCS);
$MSWin32_MBCS = 0; # ($^O =~ /MSWin32/) and (qx{chcp} =~ m/[^0123456789](932|936|949|950|951|20932|54936)\Z/);

BEGIN {
    $SIG{__WARN__} = sub {
        local($_) = @_;
        /\AUse of uninitialized value in multiplication \(\*\) at / ? return :
        warn $_[0];
    };
}

sleep 2;
open FILE,">6003.0B.A";          print FILE '';                          close FILE;
open FILE,">6003.1B.binary.A";   print FILE "\x00";                      close FILE;
open FILE,">6003.1B.text.A";     print FILE "A";                         close FILE;
open FILE,">6003.512B.binary.A"; print FILE "\x00" x 52, "A" x (512-52); close FILE;
open FILE,">6003.512B.text.A";   print FILE "\x00" x 51, "A" x (512-51); close FILE;
if ($MSWin32_MBCS) {
    mb::eval <<'END';
        open FILE,">6003.0B.�\";          print FILE '';                          close FILE;
        open FILE,">6003.1B.binary.�\";   print FILE "\x00";                      close FILE;
        open FILE,">6003.1B.text.�\";     print FILE "A";                         close FILE;
        open FILE,">6003.512B.binary.�\"; print FILE "\x00" x 52, "A" x (512-52); close FILE;
        open FILE,">6003.512B.text.�\";   print FILE "\x00" x 51, "A" x (512-51); close FILE;
END
}

END {
    mb::eval sprintf <<'END', $MSWin32_MBCS;
        close FH1;
        close FH2;
        unlink "6003.0B.A";
        unlink "6003.1B.binary.A";
        unlink "6003.1B.text.A";
        unlink "6003.512B.binary.A";
        unlink "6003.512B.text.A";
        if (%s) {
            unlink "6003.0B.�\";
            unlink "6003.1B.binary.�\";
            unlink "6003.1B.text.�\";
            unlink "6003.512B.binary.�\";
            unlink "6003.512B.text.�\";
        }
END
}

@test = (
# 1
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ int 1000 * -C "6003.NOTEXIST.A"    }) xor mb::eval(q{ int 1000 * -C "6003.NOTEXIST.�\"    }) },
    sub { return 'SKIP' unless $MSWin32_MBCS;     CORE::eval(q{ int 1000 * -C "6003.777.A"         }) ==  mb::eval(q{ int 1000 * -C "6003.777.�\"         }) },
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
# 11
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (int 1000 * -C "6003.NOTEXIST.A"   ) xor (int 1000 * -C "6003.NOTEXIST.�\"   ) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS;     mb::eval(q{ (int 1000 * -C "6003.777.A"        ) ==  (int 1000 * -C "6003.777.�\"        ) }) },
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
# 21
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ open(FH1,"6003.NOTEXIST.A"   ); my $r = int 1000 * -C FH1; close FH1;    $r }) xor mb::eval(q{ int 1000 * -C "6003.NOTEXIST.�\"    }) },
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
# 31
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ int 1000 * -C "6003.NOTEXIST.A"    }) xor mb::eval(q{ open(FH2,"6003.NOTEXIST.�\"   ); int 1000 * -C FH2 }) },
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
# 41
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ open(FH1,"6003.NOTEXIST.A"   ); open(FH2,"6003.NOTEXIST.�\"   ); (int 1000 * -C FH1) xor (int 1000 * -C FH2) }) },
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
    sub {1},
# 51
    sub { not CORE::eval(q{ (int 1000 * -C "6003.NOTEXIST.A"   ) xor (int 1000 * -C _) }) },
    sub {     CORE::eval(q{ (int 1000 * -C "6003.777.A"        ) ==  (int 1000 * -C _) }) },
    sub {     CORE::eval(q{ (int 1000 * -C "6003.000.A"        ) ==  (int 1000 * -C _) }) },
    sub {     CORE::eval(q{ (int 1000 * -C "6003.0B.A"         ) ==  (int 1000 * -C _) }) },
    sub {     CORE::eval(q{ (int 1000 * -C "6003.1B.binary.A"  ) ==  (int 1000 * -C _) }) },
    sub {     CORE::eval(q{ (int 1000 * -C "6003.1B.text.A"    ) ==  (int 1000 * -C _) }) },
    sub {     CORE::eval(q{ (int 1000 * -C "6003.512B.binary.A") ==  (int 1000 * -C _) }) },
    sub {     CORE::eval(q{ (int 1000 * -C "6003.512B.text.A"  ) ==  (int 1000 * -C _) }) },
    sub {1},
    sub {1},
# 61
    sub { not mb::eval(q{ (int 1000 * -C "6003.NOTEXIST.A"   ) xor (int 1000 * -C _) }) },
    sub {     mb::eval(q{ (int 1000 * -C "6003.777.A"        ) ==  (int 1000 * -C _) }) },
    sub {     mb::eval(q{ (int 1000 * -C "6003.000.A"        ) ==  (int 1000 * -C _) }) },
    sub {     mb::eval(q{ (int 1000 * -C "6003.0B.A"         ) ==  (int 1000 * -C _) }) },
    sub {     mb::eval(q{ (int 1000 * -C "6003.1B.binary.A"  ) ==  (int 1000 * -C _) }) },
    sub {     mb::eval(q{ (int 1000 * -C "6003.1B.text.A"    ) ==  (int 1000 * -C _) }) },
    sub {     mb::eval(q{ (int 1000 * -C "6003.512B.binary.A") ==  (int 1000 * -C _) }) },
    sub {     mb::eval(q{ (int 1000 * -C "6003.512B.text.A"  ) ==  (int 1000 * -C _) }) },
    sub {1},
    sub {1},
# 71
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (int 1000 * -C "6003.NOTEXIST.�\"   ) xor (int 1000 * -C _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS;     mb::eval(q{ (int 1000 * -C "6003.777.�\"        ) ==  (int 1000 * -C _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS;     mb::eval(q{ (int 1000 * -C "6003.000.�\"        ) ==  (int 1000 * -C _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS;     mb::eval(q{ (int 1000 * -C "6003.0B.�\"         ) ==  (int 1000 * -C _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS;     mb::eval(q{ (int 1000 * -C "6003.1B.binary.�\"  ) ==  (int 1000 * -C _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS;     mb::eval(q{ (int 1000 * -C "6003.1B.text.�\"    ) ==  (int 1000 * -C _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS;     mb::eval(q{ (int 1000 * -C "6003.512B.binary.�\") ==  (int 1000 * -C _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS;     mb::eval(q{ (int 1000 * -C "6003.512B.text.�\"  ) ==  (int 1000 * -C _) }) },
    sub {1},
    sub {1},
#
);

$|=1; print "1..",scalar(@test),"\n"; my $testno=1; sub ok { print $_[0]?'ok ':'not ok ',$testno++,$_[1]?" - $_[1]\n":"\n" } ok($_->()) for @test;

__END__

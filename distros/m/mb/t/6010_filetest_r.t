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

open FILE,">6010.0B.A";          print FILE '';                          close FILE;
open FILE,">6010.1B.binary.A";   print FILE "\x00";                      close FILE;
open FILE,">6010.1B.text.A";     print FILE "A";                         close FILE;
open FILE,">6010.512B.binary.A"; print FILE "\x00" x 52, "A" x (512-52); close FILE;
open FILE,">6010.512B.text.A";   print FILE "\x00" x 51, "A" x (512-51); close FILE;
if ($MSWin32_MBCS) {
    mb::eval <<'END';
        open FILE,">6010.0B.�\";          print FILE '';                          close FILE;
        open FILE,">6010.1B.binary.�\";   print FILE "\x00";                      close FILE;
        open FILE,">6010.1B.text.�\";     print FILE "A";                         close FILE;
        open FILE,">6010.512B.binary.�\"; print FILE "\x00" x 52, "A" x (512-52); close FILE;
        open FILE,">6010.512B.text.�\";   print FILE "\x00" x 51, "A" x (512-51); close FILE;
END
}

END {
    mb::eval sprintf <<'END', $MSWin32_MBCS;
        close FH1;
        close FH2;
        unlink "6010.0B.A";
        unlink "6010.1B.binary.A";
        unlink "6010.1B.text.A";
        unlink "6010.512B.binary.A";
        unlink "6010.512B.text.A";
        if (%s) {
            unlink "6010.0B.�\";
            unlink "6010.1B.binary.�\";
            unlink "6010.1B.text.�\";
            unlink "6010.512B.binary.�\";
            unlink "6010.512B.text.�\";
        }
END
}

@test = (
# 1
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.NOTEXIST.A"    }) xor mb::eval(q{ -r "6010.NOTEXIST.�\"    }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.777.A"         }) xor mb::eval(q{ -r "6010.777.�\"         }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.000.A"         }) xor mb::eval(q{ -r "6010.000.�\"         }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.0B.A"          }) xor mb::eval(q{ -r "6010.0B.�\"          }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.1B.binary.A"   }) xor mb::eval(q{ -r "6010.1B.binary.�\"   }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.1B.text.A"     }) xor mb::eval(q{ -r "6010.1B.text.�\"     }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.512B.binary.A" }) xor mb::eval(q{ -r "6010.512B.binary.�\" }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.512B.text.A"   }) xor mb::eval(q{ -r "6010.512B.text.�\"   }) },
    sub {1},
    sub {1},
# 11
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.NOTEXIST.A"   ) xor (-r "6010.NOTEXIST.�\"   ) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.777.A"        ) xor (-r "6010.777.�\"        ) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.000.A"        ) xor (-r "6010.000.�\"        ) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.0B.A"         ) xor (-r "6010.0B.�\"         ) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.1B.binary.A"  ) xor (-r "6010.1B.binary.�\"  ) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.1B.text.A"    ) xor (-r "6010.1B.text.�\"    ) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.512B.binary.A") xor (-r "6010.512B.binary.�\") }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.512B.text.A"  ) xor (-r "6010.512B.text.�\"  ) }) },
    sub {1},
    sub {1},
# 21
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ open(FH1,"6010.NOTEXIST.A"   ); my $r = -r FH1; close FH1;    $r }) xor mb::eval(q{ -r "6010.NOTEXIST.�\"    }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ open(FH1,"6010.0B.A"         ); my $r = -r FH1; close FH1;    $r }) xor mb::eval(q{ -r "6010.0B.�\"          }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ open(FH1,"6010.1B.binary.A"  ); my $r = -r FH1; close FH1;    $r }) xor mb::eval(q{ -r "6010.1B.binary.�\"   }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ open(FH1,"6010.1B.text.A"    ); my $r = -r FH1; close FH1;    $r }) xor mb::eval(q{ -r "6010.1B.text.�\"     }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ open(FH1,"6010.512B.binary.A"); my $r = -r FH1; close FH1;    $r }) xor mb::eval(q{ -r "6010.512B.binary.�\" }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ open(FH1,"6010.512B.text.A"  ); my $r = -r FH1; close FH1;    $r }) xor mb::eval(q{ -r "6010.512B.text.�\"   }) },
    sub {1},
    sub {1},
    sub {1},
    sub {1},
# 31
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.NOTEXIST.A"    }) xor mb::eval(q{ open(FH2,"6010.NOTEXIST.�\"   ); -r FH2 }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.0B.A"          }) xor mb::eval(q{ open(FH2,"6010.0B.�\"         ); -r FH2 }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.1B.binary.A"   }) xor mb::eval(q{ open(FH2,"6010.1B.binary.�\"  ); -r FH2 }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.1B.text.A"     }) xor mb::eval(q{ open(FH2,"6010.1B.text.�\"    ); -r FH2 }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.512B.binary.A" }) xor mb::eval(q{ open(FH2,"6010.512B.binary.�\"); -r FH2 }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not CORE::eval(q{ -r "6010.512B.text.A"   }) xor mb::eval(q{ open(FH2,"6010.512B.text.�\"  ); -r FH2 }) },
    sub {1},
    sub {1},
    sub {1},
    sub {1},
# 41
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ open(FH1,"6010.NOTEXIST.A"   ); open(FH2,"6010.NOTEXIST.�\"   ); (-r FH1) xor (-r FH2) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ open(FH1,"6010.0B.A"         ); open(FH2,"6010.0B.�\"         ); (-r FH1) xor (-r FH2) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ open(FH1,"6010.1B.binary.A"  ); open(FH2,"6010.1B.binary.�\"  ); (-r FH1) xor (-r FH2) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ open(FH1,"6010.1B.text.A"    ); open(FH2,"6010.1B.text.�\"    ); (-r FH1) xor (-r FH2) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ open(FH1,"6010.512B.binary.A"); open(FH2,"6010.512B.binary.�\"); (-r FH1) xor (-r FH2) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ open(FH1,"6010.512B.text.A"  ); open(FH2,"6010.512B.text.�\"  ); (-r FH1) xor (-r FH2) }) },
    sub {1},
    sub {1},
    sub {1},
    sub {1},
# 51
    sub { not CORE::eval(q{ (-r "6010.NOTEXIST.A"   ) xor (-r _) }) },
    sub { not CORE::eval(q{ (-r "6010.777.A"        ) xor (-r _) }) },
    sub { not CORE::eval(q{ (-r "6010.000.A"        ) xor (-r _) }) },
    sub { not CORE::eval(q{ (-r "6010.0B.A"         ) xor (-r _) }) },
    sub { not CORE::eval(q{ (-r "6010.1B.binary.A"  ) xor (-r _) }) },
    sub { not CORE::eval(q{ (-r "6010.1B.text.A"    ) xor (-r _) }) },
    sub { not CORE::eval(q{ (-r "6010.512B.binary.A") xor (-r _) }) },
    sub { not CORE::eval(q{ (-r "6010.512B.text.A"  ) xor (-r _) }) },
    sub {1},
    sub {1},
# 61
    sub { not mb::eval(q{ (-r "6010.NOTEXIST.A"   ) xor (-r _) }) },
    sub { not mb::eval(q{ (-r "6010.777.A"        ) xor (-r _) }) },
    sub { not mb::eval(q{ (-r "6010.000.A"        ) xor (-r _) }) },
    sub { not mb::eval(q{ (-r "6010.0B.A"         ) xor (-r _) }) },
    sub { not mb::eval(q{ (-r "6010.1B.binary.A"  ) xor (-r _) }) },
    sub { not mb::eval(q{ (-r "6010.1B.text.A"    ) xor (-r _) }) },
    sub { not mb::eval(q{ (-r "6010.512B.binary.A") xor (-r _) }) },
    sub { not mb::eval(q{ (-r "6010.512B.text.A"  ) xor (-r _) }) },
    sub {1},
    sub {1},
# 71
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.NOTEXIST.�\"   ) xor (-r _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.777.�\"        ) xor (-r _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.000.�\"        ) xor (-r _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.0B.�\"         ) xor (-r _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.1B.binary.�\"  ) xor (-r _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.1B.text.�\"    ) xor (-r _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.512B.binary.�\") xor (-r _) }) },
    sub { return 'SKIP' unless $MSWin32_MBCS; not mb::eval(q{ (-r "6010.512B.text.�\"  ) xor (-r _) }) },
    sub {1},
    sub {1},
#
);

$|=1; print "1..",scalar(@test),"\n"; my $testno=1; sub ok { print $_[0]?'ok ':'not ok ',$testno++,$_[1]?" - $_[1]\n":"\n" } ok($_->()) for @test;

__END__

# This file is encoded in Shift_JIS.
die "This file is not encoded in Shift_JIS.\n" if '��' ne "\x82\xA0";
die "This script is for perl only. You are using $^X.\n" if $^X =~ /jperl/i;

use strict;
use FindBin;
use lib "$FindBin::Bin/../lib";
use mb;
mb::set_script_encoding('sjis');
use vars qw(@test);

mb::eval <<'END';
    mkdir "6007.777.A",0777;
    mkdir "6007.000.A",0000;
    open FILE,">6007.0B.A";          print FILE '';                          close FILE;
    open FILE,">6007.1B.binary.A";   print FILE "\x00";                      close FILE;
    open FILE,">6007.1B.text.A";     print FILE "A";                         close FILE;
    open FILE,">6007.512B.binary.A"; print FILE "\x00" x 52, "A" x (512-52); close FILE;
    open FILE,">6007.512B.text.A";   print FILE "\x00" x 51, "A" x (512-51); close FILE;
    if ($^O =~ /MSWin32/) {
        mkdir "6007.777.�\",0777;
        mkdir "6007.000.�\",0000;
        open FILE,">6007.0B.�\";          print FILE '';                          close FILE;
        open FILE,">6007.1B.binary.�\";   print FILE "\x00";                      close FILE;
        open FILE,">6007.1B.text.�\";     print FILE "A";                         close FILE;
        open FILE,">6007.512B.binary.�\"; print FILE "\x00" x 52, "A" x (512-52); close FILE;
        open FILE,">6007.512B.text.�\";   print FILE "\x00" x 51, "A" x (512-51); close FILE;
    }
END

END {
    mb::eval <<'END';
        close FH1;
        close FH2;
        unlink "6007.0B.A";
        unlink "6007.1B.binary.A";
        unlink "6007.1B.text.A";
        unlink "6007.512B.binary.A";
        unlink "6007.512B.text.A";
        if ($^O =~ /MSWin32/) {
            closedir DH1;
            closedir DH2;
            rmdir "6007.777.�\";
            chmod 0777, "6007.000.�\";
            rmdir "6007.000.�\";
            unlink "6007.0B.�\";
            unlink "6007.1B.binary.�\";
            unlink "6007.1B.text.�\";
            unlink "6007.512B.binary.�\";
            unlink "6007.512B.text.�\";
        }
        rmdir "6007.777.A";
        rmdir "6007.000.A";
END
}

@test = (
# 1
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ -d "6007.NOTEXIST.A"    }) xor mb::eval(q{ -d "6007.NOTEXIST.�\"    }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ -d "6007.777.A"         }) xor mb::eval(q{ -d "6007.777.�\"         }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ -d "6007.000.A"         }) xor mb::eval(q{ -d "6007.000.�\"         }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ -d "6007.0B.A"          }) xor mb::eval(q{ -d "6007.0B.�\"          }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ -d "6007.1B.binary.A"   }) xor mb::eval(q{ -d "6007.1B.binary.�\"   }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ -d "6007.1B.text.A"     }) xor mb::eval(q{ -d "6007.1B.text.�\"     }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ -d "6007.512B.binary.A" }) xor mb::eval(q{ -d "6007.512B.binary.�\" }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ -d "6007.512B.text.A"   }) xor mb::eval(q{ -d "6007.512B.text.�\"   }) },
    sub {1},
    sub {1},
# 11
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.NOTEXIST.A"   ) xor (-d "6007.NOTEXIST.�\"   ) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.777.A"        ) xor (-d "6007.777.�\"        ) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.000.A"        ) xor (-d "6007.000.�\"        ) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.0B.A"         ) xor (-d "6007.0B.�\"         ) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.1B.binary.A"  ) xor (-d "6007.1B.binary.�\"  ) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.1B.text.A"    ) xor (-d "6007.1B.text.�\"    ) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.512B.binary.A") xor (-d "6007.512B.binary.�\") }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.512B.text.A"  ) xor (-d "6007.512B.text.�\"  ) }) },
    sub {1},
    sub {1},
# 21
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ opendir(DH1,"6007.NOTEXIST.A"   ); my $r = -d DH1; closedir DH1; $r           }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ opendir(DH1,"6007.777.A"        ); my $r = eval q{ -d DH1 }; closedir DH1; $r }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ opendir(DH1,"6007.000.A"        ); my $r = eval q{ -d DH1 }; closedir DH1; $r }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ opendir(DH1,"6007.0B.A"         ); my $r = -d DH1; closedir DH1; $r           }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ opendir(DH1,"6007.1B.binary.A"  ); my $r = -d DH1; closedir DH1; $r           }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ opendir(DH1,"6007.1B.text.A"    ); my $r = -d DH1; closedir DH1; $r           }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ opendir(DH1,"6007.512B.binary.A"); my $r = -d DH1; closedir DH1; $r           }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not CORE::eval(q{ opendir(DH1,"6007.512B.text.A"  ); my $r = -d DH1; closedir DH1; $r           }) },
    sub {1},
    sub {1},
# 31
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH2,"6007.NOTEXIST.�\"   ); -d DH2 }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH2,"6007.777.�\"        ); -d DH2 }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH2,"6007.000.�\"        ); -d DH2 }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH2,"6007.0B.�\"         ); -d DH2 }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH2,"6007.1B.binary.�\"  ); -d DH2 }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH2,"6007.1B.text.�\"    ); -d DH2 }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH2,"6007.512B.binary.�\"); -d DH2 }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH2,"6007.512B.text.�\"  ); -d DH2 }) },
    sub {1},
    sub {1},
# 41
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH1,"6007.NOTEXIST.A"   ); opendir(DH2,"6007.NOTEXIST.�\"   ); (-d DH1) xor (-d DH2) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH1,"6007.777.A"        ); opendir(DH2,"6007.777.�\"        ); (-d DH1) xor (-d DH2) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH1,"6007.000.A"        ); opendir(DH2,"6007.000.�\"        ); (-d DH1) xor (-d DH2) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH1,"6007.0B.A"         ); opendir(DH2,"6007.0B.�\"         ); (-d DH1) xor (-d DH2) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH1,"6007.1B.binary.A"  ); opendir(DH2,"6007.1B.binary.�\"  ); (-d DH1) xor (-d DH2) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH1,"6007.1B.text.A"    ); opendir(DH2,"6007.1B.text.�\"    ); (-d DH1) xor (-d DH2) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH1,"6007.512B.binary.A"); opendir(DH2,"6007.512B.binary.�\"); (-d DH1) xor (-d DH2) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ opendir(DH1,"6007.512B.text.A"  ); opendir(DH2,"6007.512B.text.�\"  ); (-d DH1) xor (-d DH2) }) },
    sub {1},
    sub {1},
# 51
    sub { not CORE::eval(q{ (-d "6007.NOTEXIST.A"   ) xor (-d _) }) },
    sub { not CORE::eval(q{ (-d "6007.777.A"        ) xor (-d _) }) },
    sub { not CORE::eval(q{ (-d "6007.000.A"        ) xor (-d _) }) },
    sub { not CORE::eval(q{ (-d "6007.0B.A"         ) xor (-d _) }) },
    sub { not CORE::eval(q{ (-d "6007.1B.binary.A"  ) xor (-d _) }) },
    sub { not CORE::eval(q{ (-d "6007.1B.text.A"    ) xor (-d _) }) },
    sub { not CORE::eval(q{ (-d "6007.512B.binary.A") xor (-d _) }) },
    sub { not CORE::eval(q{ (-d "6007.512B.text.A"  ) xor (-d _) }) },
    sub {1},
    sub {1},
# 61
    sub { not mb::eval(q{ (-d "6007.NOTEXIST.A"   ) xor (-d _) }) },
    sub { not mb::eval(q{ (-d "6007.777.A"        ) xor (-d _) }) },
    sub { not mb::eval(q{ (-d "6007.000.A"        ) xor (-d _) }) },
    sub { not mb::eval(q{ (-d "6007.0B.A"         ) xor (-d _) }) },
    sub { not mb::eval(q{ (-d "6007.1B.binary.A"  ) xor (-d _) }) },
    sub { not mb::eval(q{ (-d "6007.1B.text.A"    ) xor (-d _) }) },
    sub { not mb::eval(q{ (-d "6007.512B.binary.A") xor (-d _) }) },
    sub { not mb::eval(q{ (-d "6007.512B.text.A"  ) xor (-d _) }) },
    sub {1},
    sub {1},
# 71
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.NOTEXIST.�\"   ) xor (-d _) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.777.�\"        ) xor (-d _) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.000.�\"        ) xor (-d _) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.0B.�\"         ) xor (-d _) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.1B.binary.�\"  ) xor (-d _) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.1B.text.�\"    ) xor (-d _) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.512B.binary.�\") xor (-d _) }) },
    sub { return 'SKIP' if $^O !~ /MSWin32/; not mb::eval(q{ (-d "6007.512B.text.�\"  ) xor (-d _) }) },
    sub {1},
    sub {1},
#
);

$|=1; print "1..",scalar(@test),"\n"; my $testno=1; sub ok { print $_[0]?'ok ':'not ok ',$testno++,$_[1]?" - $_[1]\n":"\n" } ok($_->()) for @test;

__END__

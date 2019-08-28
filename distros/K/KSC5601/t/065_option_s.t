# encoding: KSC5601
# This file is encoded in KS C 5601.
die "This file is not encoded in KS C 5601.\n" if q{��} ne "\xa4\xa2";

use KSC5601;
print "1..3\n";

$| = 1;

my $__FILE__ = __FILE__;

my $tno = 1;

# s///o

for $i (1 .. 3) {
    $a = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    if ($i == 1) {
        $re = 'J';
    }
    elsif ($i == 2) {
        $re = 'K';
    }
    elsif ($i == 3) {
        $re = 'L';
    }

    if ($a =~ s/$re/��/o) {
        if ($a eq "ABCDEFGHI��KLMNOPQRSTUVWXYZ") {
            print qq{ok - $tno \$a =~ s/\$re/��/o (\$re=$re)(\$a=$a) $^X $__FILE__\n};
        }
        else {
            if ($] =~ /^5\.006/) {
                print qq{ok - $tno # SKIP \$a =~ s/\$re/��/o (\$re=$re)(\$a=$a) $^X $__FILE__\n};
            }
            else {
                print qq{not ok - $tno \$a =~ s/\$re/��/o (\$re=$re)(\$a=$a) $^X $__FILE__\n};
            }
        }
    }
    else {
        print qq{not ok - $tno \$a =~ s/\$re/��/o (\$re=$re)(\$a=$a) $^X $__FILE__\n};
    }

    $tno++;
}

__END__

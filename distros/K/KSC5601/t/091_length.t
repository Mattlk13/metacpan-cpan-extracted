# encoding: KSC5601
# This file is encoded in KS C 5601.
die "This file is not encoded in KS C 5601.\n" if q{��} ne "\xa4\xa2";

use KSC5601;
print "1..2\n";

my $__FILE__ = __FILE__;

if (length('����������') == 10) {
    print qq{ok - 1 length('����������') == 10 $^X $__FILE__\n};
}
else {
    print qq{not ok - 1 length('����������') == 10 $^X $__FILE__\n};
}

if (KSC5601::length('����������') == 5) {
    print qq{ok - 2 KSC5601::length('����������') == 5 $^X $__FILE__\n};
}
else {
    print qq{not ok - 2 KSC5601::length('����������') == 5 $^X $__FILE__\n};
}

__END__

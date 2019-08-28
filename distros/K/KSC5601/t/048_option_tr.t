# encoding: KSC5601
# This file is encoded in KS C 5601.
die "This file is not encoded in KS C 5601.\n" if q{��} ne "\xa4\xa2";

use KSC5601;
print "1..3\n";

my $__FILE__ = __FILE__;

# tr///c
$a = "�������������������������ĥƥ�";
if ($a =~ tr/����������/����������/c) {
    print qq{ok - 1 \$a =~ tr/����������/����������/c ($a) $^X $__FILE__\n};
}
else {
    print qq{not ok - 1 \$a =~ tr/����������/����������/c ($a) $^X $__FILE__\n};
}

# tr///d
$a = "�������������������������ĥƥ�";
if ($a =~ tr/����������//d) {
    print qq{ok - 2 \$a =~ tr/����������//d ($a) $^X $__FILE__\n};
}
else {
    print qq{not ok - 2 \$a =~ tr/����������//d ($a) $^X $__FILE__\n};
}

# tr///s
$a = "�������������������������ĥƥ�";
if ($a =~ tr/����������/��/s) {
    print qq{ok - 3 \$a =~ tr/����������/��/s ($a) $^X $__FILE__\n};
}
else {
    print qq{not ok - 3 \$a =~ tr/����������/��/s ($a) $^X $__FILE__\n};
}

__END__

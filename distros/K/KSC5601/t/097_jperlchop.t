# encoding: KSC5601
# This file is encoded in KS C 5601.
die "This file is not encoded in KS C 5601.\n" if q{��} ne "\xa4\xa2";

use KSC5601;
print "1..4\n";

my $__FILE__ = __FILE__;

#
# chop, chomp
#

$y = "������";
$x = chomp($y);
if ($x ne 0 || $y ne "������") {
    print "not ok - 1 $^X $__FILE__\n";
}
else {
    print "ok - 1 $^X $__FILE__\n";
}

$y = "������\n";
$x = chomp($y);
if ($x ne 1 || $y ne "������") {
    print "not ok - 2 $^X $__FILE__\n";
}
else {
    print "ok - 2 $^X $__FILE__\n";
}

$y = "������";
$x = chop($y);
if ($x ne "��" || $y ne "����") {
    print "not ok - 3 $^X $__FILE__\n";
}
else {
    print "ok - 3 $^X $__FILE__\n";
}

$y = "������t";
$x = chop($y);
if ($x ne "t" || $y ne "������") {
    print "not ok - 4 $^X $__FILE__\n";
}
else {
    print "ok - 4 $^X $__FILE__\n";
}

__END__

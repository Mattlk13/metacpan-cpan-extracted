# encoding: Windows1254
# This file is encoded in Windows-1254.
die "This file is not encoded in Windows-1254.\n" if q{��} ne "\x82\xa0";

use Windows1254;
print "1..1\n";

my $__FILE__ = __FILE__;

#
# split
#
@X = split(/(.)/, "abcde");
if ($#X != 9) {
    print "not ok - 1 $^X $__FILE__\n";
}
else {
    print "ok - 1 $^X $__FILE__\n";
}

__END__

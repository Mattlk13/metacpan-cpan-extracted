# encoding: KSC5601
# This file is encoded in KS C 5601.
die "This file is not encoded in KS C 5601.\n" if q{��} ne "\xa4\xa2";

use KSC5601;
print "1..1\n";

my $__FILE__ = __FILE__;

if ('��]' =~ /(��])/) {
    if ("$1" eq "��]") {
        print "ok - 1 $^X $__FILE__ ('��]' =~ /��]/).\n";
    }
    else {
        print "not ok - 1 $^X $__FILE__ ('��]' =~ /��]/).\n";
    }
}
else {
    print "not ok - 1 $^X $__FILE__ ('��]' =~ /��]/).\n";
}

__END__

# encoding: KPS9566
# This file is encoded in KPS9566.
die "This file is not encoded in KPS9566.\n" if q{あ} ne "\x82\xa0";

use KPS9566;
print "1..1\n";

my $__FILE__ = __FILE__;

if ('あxyzう' =~ /(あ.*う)/) {
    if ("$1" eq "あxyzう") {
        print "ok - 1 $^X $__FILE__ ('あxyzう' =~ /あ.*う/).\n";
    }
    else {
        print "not ok - 1 $^X $__FILE__ ('あxyzう' =~ /あ.*う/).\n";
    }
}
else {
    print "not ok - 1 $^X $__FILE__ ('あxyzう' =~ /あ.*う/).\n";
}

__END__

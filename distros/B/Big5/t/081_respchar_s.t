# encoding: Big5
# This file is encoded in Big5.
die "This file is not encoded in Big5.\n" if q{��} ne "\x82\xa0";

use Big5;
print "1..1\n";

my $__FILE__ = __FILE__;

$a = "�A�\�\";
if ($a !~ s/(�C�\*)//) {
    print qq{ok - 1 "�A�\�\" !~ s/(�C�\*)// \$1=() $^X $__FILE__\n};
}
else {
    print qq{not ok - 1 "�A�\�\" !~ s/(�C�\*)// \$1=($1) $^X $__FILE__\n};
}

__END__

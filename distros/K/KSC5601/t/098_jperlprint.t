# encoding: KSC5601
# This file is encoded in KS C 5601.
die "This file is not encoded in KS C 5601.\n" if q{��} ne "\xa4\xa2";

use KSC5601;
print "1..1\n";

my $__FILE__ = __FILE__;

if ($^O eq 'MacOS') {
    print "ok - 1 # SKIP $^X $0\n";
    exit;
}

open(TMP,'>Kanji_xxx.tmp') || die "Can't open file: Kanji_xxx.tmp\n";
print TMP <<EOL;
������    align
abcde ��  align
��������  align
��        align
EOL
close(TMP);

$CAT = 'perl -e "binmode(STDOUT); print STDOUT <>"';
if (`$CAT Kanji_xxx.tmp` eq <<EOL) {
������    align
abcde ��  align
��������  align
��        align
EOL
    print "ok - 1 $^X $__FILE__\n";
    unlink "Kanji_xxx.tmp";
}
else {
    print "not ok - 1 $^X $__FILE__\n";
}

__END__

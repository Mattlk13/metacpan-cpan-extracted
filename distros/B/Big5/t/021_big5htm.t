# encoding: Big5
# This file is encoded in Big5.
die "This file is not encoded in Big5.\n" if q{��} ne "\x82\xa0";

use Big5;
print "1..1\n";

$_ = '';

# unmatched [ ] in regexp
# �u���K�\���Ƀ}�b�`���Ȃ� [ ] ������v
eval { /�v�[��/ };
if ($@) {
    print "not ok - 1 eval { /PUURU/ }\n";
}
else {
    print "ok - 1 eval { /PUURU/ }\n";
}

__END__

Shift-JIS�e�L�X�g�𐳂�������
http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm

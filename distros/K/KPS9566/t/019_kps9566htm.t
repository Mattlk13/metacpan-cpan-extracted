# encoding: KPS9566
# This file is encoded in KPS9566.
die "This file is not encoded in KPS9566.\n" if q{��} ne "\x82\xa0";

use KPS9566;
print "1..1\n";

$_ = '';

# Search pattern not terminated
# �u�T�[�`�p�^�[�����I�����Ȃ��v
eval { /�\/ };
if ($@) {
    print "not ok - 1 eval { /HYO/ }\n";
}
else {
    print "ok - 1 eval { /HYO/ }\n";
}

__END__

Shift-JIS�e�L�X�g�𐳂�������
http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm

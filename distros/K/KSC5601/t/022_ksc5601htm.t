# encoding: KSC5601
# This file is encoded in KS C 5601.
die "This file is not encoded in KS C 5601.\n" if q{��} ne "\xa4\xa2";

use KSC5601;
print "1..1\n";

# ���顼�ˤϤʤ�ʤ�����ʸ����������ʣ���
if (lc('����������') eq '����������') {
    print "ok - 1 lc('����������') eq '����������'\n";
}
else {
    print "not ok - 1 lc('����������') eq '����������'\n";
}

__END__

KSC5601.pm �ν�����̤��ʲ��ˤʤ뤳�Ȥ���Ԥ��Ƥ���

if (lc('����������') eq '����������') {

Shift-JIS�ƥ����Ȥ�����������
http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm

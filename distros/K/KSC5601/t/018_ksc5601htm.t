# encoding: KSC5601
# This file is encoded in KS C 5601.
die "This file is not encoded in KS C 5601.\n" if q{��} ne "\xa4\xa2";

use KSC5601;
print "1..1\n";

# �ޥå�����Ϥ��ʤΤ˥ޥå����ʤ��ʣ���
if ("��ž�ȵ�" =~ m'��ž') {
    print qq<ok - 1 "UNTENMENKYO" =~ m'UNTEN'\n>;
}
else {
    print qq<not ok - 1 "UNTENMENKYO" =~ m'UNTEN'\n>;
}

__END__

Shift-JIS�ƥ����Ȥ�����������
http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm

# encoding: KSC5601
# This file is encoded in KS C 5601.
die "This file is not encoded in KS C 5601.\n" if q{��} ne "\xa4\xa2";

use KSC5601;
print "1..1\n";

my $__FILE__ = __FILE__;

# ���ɤ߸��� (�㤨�� C<(?<=[A-Z])>) ��ľ������Х���ʸ��������Х��Ȥ�
# ��äƥޥå����뤳�Ȥˤ��н褵��Ƥ��ޤ���
# �㤨�С� C<match("������", '(?<=[A-Z])(\p{Kana})')> �� C<('��')>
# ���֤��ޤ�������������Ǥ���

if ('������' =~ /(?<=[A-Z])([������])/) {
    print "not ok - 1 $^X $__FILE__ ('������' =~ /(?<=[A-Z])([������])/)($1)\n";
}
else {
    print "ok - 1 $^X $__FILE__ ('������' =~ /(?<=[A-Z])([������])/)()\n";
}

__END__


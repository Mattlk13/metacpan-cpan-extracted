# encoding: KSC5601
# This file is encoded in KS C 5601.
die "This file is not encoded in KS C 5601.\n" if q{��} ne "\xa4\xa2";

use KSC5601;
print "1..1\n";

my $__FILE__ = __FILE__;

# ������ C<i>, C<I> ����� C<j> �ϡ�C<\p{}>, C<\P{}>, POSIX C<[: :]>.
# (�㤨�� C<\p{IsLower}>, C<[:lower:]> �ʤ�) �ˤϺ��Ѥ��ޤ���
# ���Τ��ᡢC<re('\p{Lower}', 'iI')> �������
# C<re('\p{Alpha}')> ����Ѥ��Ƥ���������

# KSC5601 ���եȥ������� C<\p{}>, C<\P{}>, POSIX C<[: :]> �ε�ǽ����Ȥ��¸�ߤ��ʤ���

print "ok - 1 $^X $__FILE__ (NULL)\n";

__END__


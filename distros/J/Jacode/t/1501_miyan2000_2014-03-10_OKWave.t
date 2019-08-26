# This file is encoded in EUC-JP.
die "This file is not encoded in EUC-JP.\n" if q{��} ne "\xa4\xa2";
######################################################################
#
# 1501_miyan2000_2014-03-10_OKWave.t
#
# Copyright (c) 2015, 2019 INABA Hitoshi <ina@cpan.org>
#
######################################################################

sub BEGIN {
    eval q<
        use FindBin;
        use lib "$FindBin::Bin/../lib";
    >;
}
use Jacode;

print "1..1\n";

if ('��' ne "\xA1\xA1") {
    print "not ok - 1 Script '$0' is not in EUC-JP.\n";
    warn "Script '$0' may be in JIS.\n"    if '��' =~ /!!/;
    warn "Script '$0' may be in SJIS.\n"   if '��' eq "\x81\x40";
    warn "Script '$0' may be in UTF-8.\n"  if '��' eq "\xE3\x80\x80";
    exit;
}

$val = '�����������������������£ãģţƣǣȣɣʣˣ̣ͣΣϣУѣңӣԣգ֣ףأ٣ڣ���������������������������������ʡˡ�����';
#want   0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z ( ) _ @ -

Jacode::tr(*val,'��-����-�ڣ�-�� �ʡˡ�����','0-9A-Za-z ()_@-');

if ($val eq '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()_@-') {
    print "ok - 1 $^X $0\n";
}
else {
    print "not ok - 1 $^X $0\n";
}

__END__
http://okwave.jp/qa/q8507896.html
OKWave > [���ѼԸ�] ����ԥ塼���� > �ץ���ߥ� > Perl
���äƤޤ� 2014-03-10 15:10:01 ����No.8507896 

[��] jcode.pl�Τ����

miyan2000 ����

jcode.pl��
jcode::tr()
�Τ�����õ���Ƥ��ޤ���

jcode.pl��
jcode::tr($val,'��-����-�ڣ�-�� �ʡˡ�����','0-9A-Za-z ()_@-');
��Perl5.18.2�ǻ��Ѥ���ȥ��顼���ФƤ��ޤ��ޤ����������򤷤�����

�ץ���बUTF-8�Ǥ����
$val =~ tr/��-����-�ڣ�-�� �ʡˡ�����/0-9A-Za-z ()_@-/;
�Τ褦�ˤ���м¸���ǽ�ߤ����Ǥ������ץ�����EUC�ǽ񤫤�Ƥ��ޤ���
�ƶ��ϰϤ���ץ�����ʸ�������ɤ򤫤��뤳�ȤϤǤ�����򤱤�����

��ʸ�������Ѵ����뤳�Ȥ�ͤ��ޤ�������������ˡ�Ǥϥѥե����ޥ󥹤˷�ǰ������ޤ���

jacode.pl�ʤ��Τ⤢��ޤ�����������֤�����������Ǥ�ʸ���������Ƥ��ޤ��ޤ�����

jcode::tr()�Τ����ˤʤ�褦�ʼ��ʤϤ���ΤǤ��礦����

[��] ina�β�������1���

jacode.pl �����Ѥ���

�ڸ��jcode::tr($val,'��-����-�ڣ�-�� �ʡˡ�����','0-9A-Za-z ()_@-');
������jcode::tr(*val,'��-����-�ڣ�-�� �ʡˡ�����','0-9A-Za-z ()_@-');

��ư��ޤ�����

���ʤߤ� jcode::tr �Υѥե����ޥ󥹤ϡ�jcode.pl/jacode.pl �Ȥ��
���ʤ��٤��Ǥ���

Perl�ˤ�����ܸ���� PerlConference Tokyo '98 1998ǯ11��11�������
ftp://ftp.oreilly.co.jp/pcjp98/utashiro/utashiro.mgp
������

---------------------------------------------------------
Perl �� tr �ؿ��ϥơ��֥�򻲾Ȥ����Ѵ�����Τ�
�ˤ�ƹ�®������jcode::tr �ϡ�Ϣ�������Ȥä� s/../../
�η����Ѵ�����ΤǤ��ʤ��٤����Ȥ����
---------------------------------------------------------

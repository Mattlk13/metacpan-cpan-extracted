######################################################################
#
# t/6005_getcode_euc.t
#
# Copyright (c) 2022 INABA Hitoshi <ina@cpan.org> in a CPAN
######################################################################

sub BEGIN {
    eval q<
        use FindBin;
        use lib "$FindBin::Bin/..";
    >;
}
require 'lib/jacode.pl';

@todo = (
    '���Ŏ��ގ֎ʎ��֎ƎԎ��֎Ǝ����ގڎ����Ɏ��܎��ĎŎ؎Î����Ɏю��ώÎ�','euc',
    '������������','euc',
    '���£ãģţ�','euc',
    '����ϤˤۤؤȤ���̤��狼�褿�줽�Ĥͤʤ�द��Τ�����ޤ��դ����Ƥ��������ߤ���Ҥ⤻��','euc',
    '�ȥ�ʥ����񥹥�᥵�ޥ��ߥ襢���勵��ҥ󥫥��򥽥饤��ϥ��ƥ����ĥإ˥ۥեͥ���̥��Υ���','euc',
    '����۰�����Ʊŷ','euc',
    '���Υ����Ȥ� Perl �θ����ɥ�����ȡ��⥸�塼��ɥ�����Ȥ����ܸ������������Τ�ɽ�����륵���ȤǤ���','euc',
    '��������������ǡ����ϡ�Japanized Perl Resources Project(JPRP)���������줿��Ρ�ͭ�֤��������Ƥ���github�Υ�ݥ��ȥꡢJPA������ʸ�񤫤�������Ƥ��ޤ���','euc',
    '�Ƕ�ι��� / RSS','euc',
    'CVS�ڤ�git��commit������ǿ���50���������Ƥ��ޤ������������Ԥ�commit�����ͤ��㤦��礬����ޤ����ޤ���������commit����Ͽ����������̤�����Τ�Τ�ޤޤ���礬����ޤ���','euc',
);

print "1..", scalar(@todo)/2, "\n";
if ('��' ne "\xa4\xa2") {
    for $tno (1 .. scalar(@todo)/2) {
        print "ok $tno - SKIP (script '$0' must be 'euc')\n";
    }
    exit;
}

$tno = 1;

while (($give,$want) = splice(@todo,0,2)) {
    $got = &jacode'getcode(*give);
    if ($got eq $want) {
        print     "ok $tno - want=($want) got=($got)\n";
    }
    else {
        print "not ok $tno - want=($want) got=($got)\n";
    }
    $tno++;
}

__END__

######################################################################
#
# t/6004_getcode_sjis.t
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
    '�Ŷ���������ƻ��ڲ�ɲܵ���ú��ѽ���','sjis',
    '�O�P�Q�R�S�T','sjis',
    '�`�a�b�c�d�e','sjis',
    '����͂ɂقւƂ���ʂ���킩�悽�ꂻ�˂Ȃ�ނ���̂�����܂��ӂ����Ă�������߂݂���Ђ�����','sjis',
    '�g���i�N�R���X�����T�}�Z�~���A�P���^���q���J�V���\���C���n�G�e�I�L�c�w�j�z�t�l�������k�����m�E�`','sjis',
    '�R��و敗�����V','sjis',
    '���̃T�C�g�� Perl �̌����h�L�������g�A���W���[���h�L�������g����{��ɖ|�󂵂����̂�\������T�C�g�ł��B','sjis',
    '�T�C�g���̖|��f�[�^�́AJapanized Perl Resources Project(JPRP)�Ŗ|�󂳂ꂽ���́A�L�u���|�󂵂Ă���github�̃��|�W�g���AJPA�̖|�󕶏�����擾���Ă��܂��B','sjis',
    '�ŋ߂̍X�V / RSS','sjis',
    'CVS�y��git��commit���O����ŐV��50�����擾���Ă��܂��B�H�ɖ|��҂�commit�����l���Ⴄ�ꍇ������܂��B�܂��A�C����commit�A�o�^���������Ŗ��|��̂��̂��܂܂��ꍇ������܂��B','sjis',
    '�a','sjis',
    '��','sjis',
    '��','sjis',
    '�b','sjis',
    '�Q','sjis',
    '�o','sjis',
    '�','sjis',
    '��','sjis',
    '��','sjis',
    '��','sjis',
    '�M','sjis',
    '��','sjis',
    '�Z','sjis',
    '��','sjis',
);

print "1..", scalar(@todo)/2, "\n";
if ('��' ne "\x82\xa0") {
    for $tno (1 .. scalar(@todo)/2) {
        print "ok $tno - SKIP (script '$0' must be 'sjis')\n";
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

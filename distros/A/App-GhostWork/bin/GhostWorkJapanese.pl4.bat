@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
jperl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
jperl -x -S "%0" %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
goto endofperl
@rem ';
#!jperl
#line 14
print STDERR <<END;
#####################################################################

 GhostWork - �ǎ�����o�[�R�[�h�����O�t�@�C���ɂ���v���O����

#####################################################################

���������
   [Q] �� [Q]uit  �̗��Ńv���O�������I�����܂��B
   [R] �� [R]etry �̗��Œ��O�̑������蒼���܂��B

END

$Q_WHO='���Ȃ��̖��O�́H';
$Q_TOWHICH='�ǂ̍H�����s���܂����H';
$Q_WHAT='�ǂ̒��[�ł����H';
$Q_WHY='....���R�́H';
$INFO_LOGFILE_IS='���O�t�@�C���� ';
$INFO_DOUBLE_SCANNED='�G���[�����F���O�Ɠ����o�[�R�[�h�ł��B';
$INFO_ANY_KEY_TO_EXIT='�����L�[�������ƏI�����܂��B';

($FindBin = __FILE__) =~ s{[^/\\]+$}{};
do "$FindBin/GhostWork.pl4.bat";

__END__
:endofperl

# This file is encoded in Shift_JIS.
die "This file is not encoded in Shift_JIS.\n" if '��' ne "\x82\xA0";
die "This script is for perl only. You are using $^X.\n" if $^X =~ /jperl/i;

use strict;
use FindBin;
use lib "$FindBin::Bin/../lib";
use mb;
mb::set_script_encoding('sjis');
use vars qw(@test);

use vars qw($MSWin32_MBCS);
$MSWin32_MBCS = ($^O =~ /MSWin32/) and (qx{chcp} =~ m/[^0123456789](932|936|949|950|951|20932|54936)\Z/);

@test = (
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 1
---
'�@'
END1
---
'�@'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 2
'�A'
END1
'�A'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 3
'�B'
END1
'�B'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 4
'�C'
END1
'�C'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 5
'�D'
END1
'�D'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 6
'�E'
END1
'�E'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 7
'�F'
END1
'�F'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 8
'�G'
END1
'�G'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 9
'�H'
END1
'�H'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 10
'�I'
END1
'�I'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 11
'�J'
END1
'�J'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 12
'�K'
END1
'�K'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 13
'�L'
END1
'�L'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 14
'�M'
END1
'�M'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 15
'�N'
END1
'�N'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 16
'�O'
END1
'�O'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 17
'�P'
END1
'�P'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 18
'�Q'
END1
'�Q'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 19
'�R'
END1
'�R'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 20
'�S'
END1
'�S'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 21
'�T'
END1
'�T'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 22
'�U'
END1
'�U'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 23
'�V'
END1
'�V'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 24
'�W'
END1
'�W'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 25
'�X'
END1
'�X'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 26
'�Y'
END1
'�Y'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 27
'�Z'
END1
'�Z'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 28
'�['
END1
'�['
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 29
'�\'
END1
'�\\'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 30
'�]'
END1
'�]'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 31
'�^'
END1
'�^'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 32
'�_'
END1
'�_'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 33
'�`'
END1
'�`'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 34
'�a'
END1
'�a'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 35
'�b'
END1
'�b'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 36
'�c'
END1
'�c'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 37
'�d'
END1
'�d'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 38
'�e'
END1
'�e'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 39
'�f'
END1
'�f'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 40
'�g'
END1
'�g'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 41
'�h'
END1
'�h'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 42
'�i'
END1
'�i'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 43
'�j'
END1
'�j'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 44
'�k'
END1
'�k'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 45
'�l'
END1
'�l'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 46
'�m'
END1
'�m'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 47
'�n'
END1
'�n'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 48
'�o'
END1
'�o'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 49
'�p'
END1
'�p'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 50
'�q'
END1
'�q'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 51
'�r'
END1
'�r'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 52
'�s'
END1
'�s'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 53
'�t'
END1
'�t'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 54
'�u'
END1
'�u'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 55
'�v'
END1
'�v'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 56
'�w'
END1
'�w'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 57
'�x'
END1
'�x'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 58
'�y'
END1
'�y'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 59
'�z'
END1
'�z'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 60
'�{'
END1
'�{'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 61
'�|'
END1
'�|'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 62
'�}'
END1
'�}'
END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 63
'�~'
END1
'�~'
END2
);

$|=1; print "1..",scalar(@test),"\n"; my $testno=1; sub ok { print $_[0]?'ok ':'not ok ',$testno++,$_[1]?" - $_[1]\n":"\n" } ok($_->()) for @test;

__END__

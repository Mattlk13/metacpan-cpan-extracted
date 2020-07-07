# This file is encoded in Shift_JIS.
die "This file is not encoded in Shift_JIS.\n" if '��' ne "\x82\xA0";
die "This script is for perl only. You are using $^X.\n" if $^X =~ /jperl/i;

use strict;
use FindBin;
use lib "$FindBin::Bin/../lib";
use mb;
mb::set_script_encoding('sjis');
use vars qw(@test);

@test = (
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 1
---
s/�@/1/

END1
---
s{(\G${mb::_anchor})@{[qr/(?:�\@)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 2
s/�A/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�A)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 3
s/�B/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�B)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 4
s/�C/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�C)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 5
s/�D/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�D)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 6
s/�E/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�E)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 7
s/�F/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�F)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 8
s/�G/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�G)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 9
s/�H/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�H)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 10
s/�I/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�I)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 11
s/�J/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�J)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 12
s/�K/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�K)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 13
s/�L/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�L)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 14
s/�M/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�M)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 15
s/�N/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�N)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 16
s/�O/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�O)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 17
s/�P/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�P)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 18
s/�Q/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�Q)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 19
s/�R/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�R)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 20
s/�S/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�S)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 21
s/�T/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�T)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 22
s/�U/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�U)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 23
s/�V/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�V)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 24
s/�W/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�W)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 25
s/�X/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�X)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 26
s/�Y/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�Y)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 27
s/�Z/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�Z)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 28
s/�[/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�\[)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 29
s/�\/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�\\)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 30
s/�]/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�\])/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 31
s/�^/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�\^)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 32
s/�_/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�_)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 33
s/�`/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�\`)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 34
s/�a/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�a)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 35
s/�b/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�b)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 36
s/�c/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�c)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 37
s/�d/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�d)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 38
s/�e/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�e)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 39
s/�f/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�f)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 40
s/�g/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�g)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 41
s/�h/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�h)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 42
s/�i/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�i)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 43
s/�j/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�j)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 44
s/�k/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�k)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 45
s/�l/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�l)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 46
s/�m/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�m)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 47
s/�n/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�n)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 48
s/�o/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�o)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 49
s/�p/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�p)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 50
s/�q/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�q)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 51
s/�r/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�r)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 52
s/�s/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�s)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 53
s/�t/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�t)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 54
s/�u/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�u)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 55
s/�v/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�v)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 56
s/�w/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�w)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 57
s/�x/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�x)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 58
s/�y/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�y)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 59
s/�z/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�z)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 60
s/�{/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�\{)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 61
s/�|/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�\|)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 62
s/�}/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�\})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 63
s/�~/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:�\~)/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 64
s/[�@]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�\@])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 65
s/[�A]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�A])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 66
s/[�B]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�B])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 67
s/[�C]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�C])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 68
s/[�D]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�D])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 69
s/[�E]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�E])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 70
s/[�F]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�F])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 71
s/[�G]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�G])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 72
s/[�H]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�H])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 73
s/[�I]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�I])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 74
s/[�J]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�J])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 75
s/[�K]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�K])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 76
s/[�L]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�L])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 77
s/[�M]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�M])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 78
s/[�N]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�N])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 79
s/[�O]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�O])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 80
s/[�P]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�P])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 81
s/[�Q]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�Q])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 82
s/[�R]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�R])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 83
s/[�S]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�S])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 84
s/[�T]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�T])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 85
s/[�U]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�U])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 86
s/[�V]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�V])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 87
s/[�W]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�W])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 88
s/[�X]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�X])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 89
s/[�Y]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�Y])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 90
s/[�Z]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�Z])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 91
s/[�[]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�\[])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 92
s/[�\]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�\\])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 93
s/[�]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�\]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 94
s/[�^]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�\^])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 95
s/[�_]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�_])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 96
s/[�`]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�\`])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 97
s/[�a]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�a])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 98
s/[�b]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�b])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 99
s/[�c]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�c])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 100
s/[�d]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�d])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 101
s/[�e]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�e])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 102
s/[�f]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�f])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 103
s/[�g]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�g])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 104
s/[�h]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�h])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 105
s/[�i]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�i])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 106
s/[�j]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�j])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 107
s/[�k]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�k])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 108
s/[�l]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�l])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 109
s/[�m]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�m])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 110
s/[�n]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�n])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 111
s/[�o]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�o])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 112
s/[�p]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�p])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 113
s/[�q]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�q])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 114
s/[�r]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�r])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 115
s/[�s]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�s])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 116
s/[�t]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�t])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 117
s/[�u]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�u])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 118
s/[�v]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�v])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 119
s/[�w]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�w])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 120
s/[�x]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�x])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 121
s/[�y]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�y])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 122
s/[�z]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�z])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 123
s/[�{]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�\{])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 124
s/[�|]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�\|])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 125
s/[�}]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�\}])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 126
s/[�~]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�\~])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 127
s/[^�@]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�\@])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 128
s/[^�A]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�A])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 129
s/[^�B]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�B])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 130
s/[^�C]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�C])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 131
s/[^�D]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�D])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 132
s/[^�E]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�E])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 133
s/[^�F]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�F])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 134
s/[^�G]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�G])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 135
s/[^�H]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�H])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 136
s/[^�I]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�I])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 137
s/[^�J]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�J])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 138
s/[^�K]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�K])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 139
s/[^�L]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�L])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 140
s/[^�M]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�M])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 141
s/[^�N]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�N])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 142
s/[^�O]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�O])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 143
s/[^�P]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�P])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 144
s/[^�Q]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�Q])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 145
s/[^�R]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�R])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 146
s/[^�S]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�S])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 147
s/[^�T]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�T])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 148
s/[^�U]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�U])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 149
s/[^�V]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�V])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 150
s/[^�W]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�W])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 151
s/[^�X]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�X])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 152
s/[^�Y]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�Y])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 153
s/[^�Z]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�Z])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 154
s/[^�[]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�\[])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 155
s/[^�\]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�\\])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 156
s/[^�]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�\]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 157
s/[^�^]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�\^])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 158
s/[^�_]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�_])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 159
s/[^�`]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�\`])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 160
s/[^�a]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�a])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 161
s/[^�b]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�b])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 162
s/[^�c]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�c])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 163
s/[^�d]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�d])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 164
s/[^�e]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�e])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 165
s/[^�f]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�f])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 166
s/[^�g]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�g])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 167
s/[^�h]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�h])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 168
s/[^�i]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�i])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 169
s/[^�j]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�j])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 170
s/[^�k]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�k])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 171
s/[^�l]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�l])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 172
s/[^�m]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�m])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 173
s/[^�n]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�n])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 174
s/[^�o]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�o])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 175
s/[^�p]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�p])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 176
s/[^�q]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�q])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 177
s/[^�r]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�r])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 178
s/[^�s]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�s])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 179
s/[^�t]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�t])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 180
s/[^�u]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�u])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 181
s/[^�v]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�v])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 182
s/[^�w]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�w])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 183
s/[^�x]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�x])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 184
s/[^�y]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�y])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 185
s/[^�z]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�z])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 186
s/[^�{]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�\{])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 187
s/[^�|]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�\|])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 188
s/[^�}]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�\}])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 189
s/[^�~]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�\~])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 190
s:�@:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�\@)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 191
s:�A:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�A)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 192
s:�B:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�B)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 193
s:�C:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�C)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 194
s:�D:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�D)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 195
s:�E:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�E)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 196
s:�F:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�F)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 197
s:�G:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�G)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 198
s:�H:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�H)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 199
s:�I:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�I)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 200
s:�J:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�J)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 201
s:�K:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�K)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 202
s:�L:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�L)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 203
s:�M:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�M)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 204
s:�N:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�N)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 205
s:�O:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�O)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 206
s:�P:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�P)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 207
s:�Q:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�Q)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 208
s:�R:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�R)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 209
s:�S:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�S)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 210
s:�T:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�T)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 211
s:�U:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�U)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 212
s:�V:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�V)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 213
s:�W:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�W)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 214
s:�X:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�X)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 215
s:�Y:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�Y)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 216
s:�Z:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�Z)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 217
s:�[:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�\[)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 218
s:�\:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�\\)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 219
s:�]:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�\])` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 220
s:�^:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�\^)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 221
s:�_:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�_)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 222
s:�`:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�\`)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 223
s:�a:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�a)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 224
s:�b:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�b)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 225
s:�c:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�c)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 226
s:�d:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�d)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 227
s:�e:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�e)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 228
s:�f:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�f)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 229
s:�g:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�g)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 230
s:�h:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�h)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 231
s:�i:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�i)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 232
s:�j:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�j)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 233
s:�k:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�k)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 234
s:�l:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�l)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 235
s:�m:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�m)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 236
s:�n:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�n)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 237
s:�o:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�o)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 238
s:�p:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�p)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 239
s:�q:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�q)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 240
s:�r:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�r)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 241
s:�s:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�s)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 242
s:�t:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�t)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 243
s:�u:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�u)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 244
s:�v:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�v)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 245
s:�w:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�w)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 246
s:�x:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�x)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 247
s:�y:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�y)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 248
s:�z:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�z)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 249
s:�{:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�\{)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 250
s:�|:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�\|)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 251
s:�}:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�\})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 252
s:�~:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:�\~)` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 253
s:[�@]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\@])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 254
s:[�A]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�A])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 255
s:[�B]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�B])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 256
s:[�C]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�C])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 257
s:[�D]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�D])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 258
s:[�E]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�E])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 259
s:[�F]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�F])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 260
s:[�G]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�G])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 261
s:[�H]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�H])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 262
s:[�I]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�I])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 263
s:[�J]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�J])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 264
s:[�K]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�K])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 265
s:[�L]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�L])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 266
s:[�M]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�M])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 267
s:[�N]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�N])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 268
s:[�O]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�O])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 269
s:[�P]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�P])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 270
s:[�Q]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�Q])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 271
s:[�R]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�R])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 272
s:[�S]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�S])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 273
s:[�T]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�T])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 274
s:[�U]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�U])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 275
s:[�V]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�V])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 276
s:[�W]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�W])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 277
s:[�X]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�X])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 278
s:[�Y]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�Y])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 279
s:[�Z]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�Z])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 280
s:[�[]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\[])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 281
s:[�\]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\\])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 282
s:[�]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 283
s:[�^]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\^])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 284
s:[�_]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�_])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 285
s:[�`]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\`])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 286
s:[�a]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�a])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 287
s:[�b]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�b])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 288
s:[�c]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�c])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 289
s:[�d]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�d])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 290
s:[�e]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�e])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 291
s:[�f]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�f])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 292
s:[�g]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�g])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 293
s:[�h]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�h])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 294
s:[�i]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�i])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 295
s:[�j]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�j])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 296
s:[�k]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�k])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 297
s:[�l]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�l])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 298
s:[�m]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�m])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 299
s:[�n]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�n])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 300
s:[�o]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�o])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 301
s:[�p]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�p])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 302
s:[�q]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�q])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 303
s:[�r]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�r])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 304
s:[�s]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�s])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 305
s:[�t]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�t])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 306
s:[�u]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�u])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 307
s:[�v]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�v])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 308
s:[�w]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�w])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 309
s:[�x]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�x])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 310
s:[�y]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�y])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 311
s:[�z]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�z])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 312
s:[�{]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\{])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 313
s:[�|]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\|])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 314
s:[�}]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\}])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 315
s:[�~]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\~])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 316
s:[^�@]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\@])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 317
s:[^�A]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�A])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 318
s:[^�B]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�B])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 319
s:[^�C]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�C])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 320
s:[^�D]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�D])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 321
s:[^�E]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�E])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 322
s:[^�F]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�F])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 323
s:[^�G]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�G])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 324
s:[^�H]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�H])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 325
s:[^�I]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�I])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 326
s:[^�J]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�J])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 327
s:[^�K]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�K])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 328
s:[^�L]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�L])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 329
s:[^�M]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�M])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 330
s:[^�N]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�N])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 331
s:[^�O]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�O])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 332
s:[^�P]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�P])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 333
s:[^�Q]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�Q])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 334
s:[^�R]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�R])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 335
s:[^�S]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�S])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 336
s:[^�T]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�T])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 337
s:[^�U]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�U])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 338
s:[^�V]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�V])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 339
s:[^�W]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�W])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 340
s:[^�X]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�X])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 341
s:[^�Y]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�Y])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 342
s:[^�Z]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�Z])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 343
s:[^�[]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\[])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 344
s:[^�\]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\\])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 345
s:[^�]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 346
s:[^�^]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\^])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 347
s:[^�_]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�_])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 348
s:[^�`]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\`])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 349
s:[^�a]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�a])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 350
s:[^�b]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�b])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 351
s:[^�c]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�c])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 352
s:[^�d]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�d])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 353
s:[^�e]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�e])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 354
s:[^�f]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�f])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 355
s:[^�g]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�g])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 356
s:[^�h]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�h])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 357
s:[^�i]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�i])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 358
s:[^�j]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�j])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 359
s:[^�k]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�k])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 360
s:[^�l]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�l])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 361
s:[^�m]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�m])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 362
s:[^�n]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�n])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 363
s:[^�o]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�o])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 364
s:[^�p]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�p])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 365
s:[^�q]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�q])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 366
s:[^�r]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�r])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 367
s:[^�s]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�s])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 368
s:[^�t]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�t])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 369
s:[^�u]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�u])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 370
s:[^�v]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�v])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 371
s:[^�w]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�w])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 372
s:[^�x]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�x])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 373
s:[^�y]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�y])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 374
s:[^�z]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�z])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 375
s:[^�{]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\{])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 376
s:[^�|]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\|])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 377
s:[^�}]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\}])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 378
s:[^�~]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\~])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 379
s@�@@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�\@)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 380
s@�A@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�A)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 381
s@�B@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�B)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 382
s@�C@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�C)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 383
s@�D@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�D)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 384
s@�E@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�E)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 385
s@�F@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�F)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 386
s@�G@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�G)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 387
s@�H@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�H)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 388
s@�I@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�I)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 389
s@�J@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�J)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 390
s@�K@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�K)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 391
s@�L@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�L)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 392
s@�M@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�M)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 393
s@�N@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�N)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 394
s@�O@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�O)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 395
s@�P@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�P)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 396
s@�Q@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�Q)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 397
s@�R@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�R)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 398
s@�S@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�S)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 399
s@�T@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�T)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 400
s@�U@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�U)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 401
s@�V@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�V)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 402
s@�W@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�W)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 403
s@�X@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�X)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 404
s@�Y@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�Y)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 405
s@�Z@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�Z)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 406
s@�[@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�\[)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 407
s@�\@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�\\)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 408
s@�]@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�\])` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 409
s@�^@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�\^)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 410
s@�_@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�_)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 411
s@�`@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�\`)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 412
s@�a@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�a)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 413
s@�b@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�b)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 414
s@�c@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�c)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 415
s@�d@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�d)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 416
s@�e@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�e)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 417
s@�f@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�f)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 418
s@�g@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�g)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 419
s@�h@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�h)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 420
s@�i@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�i)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 421
s@�j@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�j)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 422
s@�k@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�k)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 423
s@�l@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�l)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 424
s@�m@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�m)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 425
s@�n@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�n)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 426
s@�o@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�o)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 427
s@�p@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�p)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 428
s@�q@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�q)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 429
s@�r@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�r)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 430
s@�s@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�s)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 431
s@�t@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�t)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 432
s@�u@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�u)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 433
s@�v@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�v)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 434
s@�w@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�w)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 435
s@�x@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�x)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 436
s@�y@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�y)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 437
s@�z@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�z)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 438
s@�{@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�\{)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 439
s@�|@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�\|)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 440
s@�}@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�\})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 441
s@�~@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:�\~)` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 442
s@[�@]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\@])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 443
s@[�A]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�A])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 444
s@[�B]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�B])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 445
s@[�C]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�C])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 446
s@[�D]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�D])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 447
s@[�E]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�E])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 448
s@[�F]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�F])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 449
s@[�G]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�G])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 450
s@[�H]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�H])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 451
s@[�I]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�I])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 452
s@[�J]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�J])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 453
s@[�K]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�K])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 454
s@[�L]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�L])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 455
s@[�M]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�M])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 456
s@[�N]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�N])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 457
s@[�O]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�O])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 458
s@[�P]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�P])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 459
s@[�Q]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�Q])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 460
s@[�R]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�R])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 461
s@[�S]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�S])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 462
s@[�T]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�T])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 463
s@[�U]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�U])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 464
s@[�V]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�V])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 465
s@[�W]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�W])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 466
s@[�X]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�X])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 467
s@[�Y]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�Y])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 468
s@[�Z]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�Z])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 469
s@[�[]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\[])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 470
s@[�\]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\\])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 471
s@[�]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 472
s@[�^]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\^])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 473
s@[�_]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�_])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 474
s@[�`]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\`])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 475
s@[�a]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�a])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 476
s@[�b]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�b])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 477
s@[�c]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�c])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 478
s@[�d]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�d])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 479
s@[�e]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�e])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 480
s@[�f]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�f])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 481
s@[�g]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�g])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 482
s@[�h]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�h])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 483
s@[�i]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�i])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 484
s@[�j]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�j])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 485
s@[�k]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�k])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 486
s@[�l]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�l])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 487
s@[�m]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�m])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 488
s@[�n]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�n])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 489
s@[�o]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�o])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 490
s@[�p]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�p])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 491
s@[�q]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�q])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 492
s@[�r]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�r])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 493
s@[�s]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�s])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 494
s@[�t]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�t])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 495
s@[�u]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�u])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 496
s@[�v]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�v])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 497
s@[�w]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�w])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 498
s@[�x]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�x])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 499
s@[�y]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�y])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 500
s@[�z]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�z])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 501
s@[�{]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\{])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 502
s@[�|]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\|])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 503
s@[�}]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\}])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 504
s@[�~]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[�\~])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 505
s@[^�@]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\@])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 506
s@[^�A]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�A])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 507
s@[^�B]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�B])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 508
s@[^�C]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�C])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 509
s@[^�D]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�D])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 510
s@[^�E]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�E])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 511
s@[^�F]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�F])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 512
s@[^�G]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�G])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 513
s@[^�H]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�H])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 514
s@[^�I]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�I])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 515
s@[^�J]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�J])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 516
s@[^�K]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�K])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 517
s@[^�L]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�L])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 518
s@[^�M]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�M])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 519
s@[^�N]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�N])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 520
s@[^�O]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�O])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 521
s@[^�P]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�P])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 522
s@[^�Q]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�Q])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 523
s@[^�R]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�R])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 524
s@[^�S]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�S])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 525
s@[^�T]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�T])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 526
s@[^�U]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�U])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 527
s@[^�V]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�V])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 528
s@[^�W]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�W])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 529
s@[^�X]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�X])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 530
s@[^�Y]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�Y])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 531
s@[^�Z]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�Z])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 532
s@[^�[]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\[])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 533
s@[^�\]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\\])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 534
s@[^�]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 535
s@[^�^]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\^])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 536
s@[^�_]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�_])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 537
s@[^�`]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\`])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 538
s@[^�a]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�a])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 539
s@[^�b]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�b])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 540
s@[^�c]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�c])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 541
s@[^�d]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�d])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 542
s@[^�e]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�e])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 543
s@[^�f]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�f])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 544
s@[^�g]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�g])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 545
s@[^�h]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�h])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 546
s@[^�i]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�i])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 547
s@[^�j]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�j])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 548
s@[^�k]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�k])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 549
s@[^�l]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�l])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 550
s@[^�m]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�m])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 551
s@[^�n]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�n])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 552
s@[^�o]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�o])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 553
s@[^�p]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�p])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 554
s@[^�q]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�q])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 555
s@[^�r]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�r])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 556
s@[^�s]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�s])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 557
s@[^�t]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�t])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 558
s@[^�u]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�u])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 559
s@[^�v]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�v])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 560
s@[^�w]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�w])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 561
s@[^�x]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�x])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 562
s@[^�y]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�y])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 563
s@[^�z]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�z])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 564
s@[^�{]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\{])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 565
s@[^�|]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\|])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 566
s@[^�}]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\}])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 567
s@[^�~]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^�\~])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 568
s/./1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_dot})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 569
s/\B/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_B})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 570
s/\D/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_D})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 571
s/\H/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_H})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 572
s/\N/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_N})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 573
s/\R/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_R})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 574
s/\S/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_S})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 575
s/\V/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_V})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 576
s/\W/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_W})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 577
s/\b/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_b})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 578
s/\d/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_d})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 579
s/\h/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_h})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 580
s/\s/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_s})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 581
s/\v/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_v})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 582
s/\w/1/

END1
s{(\G${mb::_anchor})@{[qr/(?:@{mb::_w})/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 583
s/[\b]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\b])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 584
s/[[:alnum:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:alnum:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 585
s/[[:alpha:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:alpha:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 586
s/[[:ascii:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:ascii:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 587
s/[[:blank:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:blank:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 588
s/[[:cntrl:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:cntrl:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 589
s/[[:digit:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:digit:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 590
s/[[:graph:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:graph:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 591
s/[[:lower:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:lower:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 592
s/[[:print:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:print:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 593
s/[[:punct:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:punct:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 594
s/[[:space:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:space:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 595
s/[[:upper:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:upper:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 596
s/[[:word:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:word:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 597
s/[[:xdigit:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:xdigit:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 598
s/[[:^alnum:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^alnum:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 599
s/[[:^alpha:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^alpha:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 600
s/[[:^ascii:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^ascii:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 601
s/[[:^blank:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^blank:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 602
s/[[:^cntrl:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^cntrl:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 603
s/[[:^digit:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^digit:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 604
s/[[:^graph:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^graph:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 605
s/[[:^lower:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^lower:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 606
s/[[:^print:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^print:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 607
s/[[:^punct:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^punct:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 608
s/[[:^space:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^space:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 609
s/[[:^upper:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^upper:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 610
s/[[:^word:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^word:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 611
s/[[:^xdigit:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[[:^xdigit:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 612
s/[.]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[.])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 613
s/[\B]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\B])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 614
s/[\D]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\D])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 615
s/[\H]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\H])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 616
s/[\N]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\N])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 617
s/[\R]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\R])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 618
s/[\S]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\S])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 619
s/[\V]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\V])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 620
s/[\W]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\W])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 621
s/[\b]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\b])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 622
s/[\d]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\d])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 623
s/[\h]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\h])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 624
s/[\s]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\s])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 625
s/[\v]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\v])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 626
s/[\w]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[\\w])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 627
s/[^.]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^.])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 628
s/[^\B]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\B])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 629
s/[^\D]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\D])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 630
s/[^\H]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\H])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 631
s/[^\N]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\N])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 632
s/[^\R]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\R])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 633
s/[^\S]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\S])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 634
s/[^\V]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\V])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 635
s/[^\W]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\W])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 636
s/[^\b]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\b])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 637
s/[^\d]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\d])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 638
s/[^\h]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\h])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 639
s/[^\s]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\s])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 640
s/[^\v]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\v])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 641
s/[^\w]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^\\w])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 642
s:.:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_dot})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 643
s:\B:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_B})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 644
s:\D:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_D})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 645
s:\H:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_H})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 646
s:\N:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_N})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 647
s:\R:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_R})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 648
s:\S:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_S})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 649
s:\V:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_V})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 650
s:\W:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_W})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 651
s:\b:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_b})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 652
s:\d:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_d})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 653
s:\h:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_h})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 654
s:\s:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_s})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 655
s:\v:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_v})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 656
s:\w:1:

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_w})` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 657
s:[\b]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\b])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 658
s:[[:alnum:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:alnum:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 659
s:[[:alpha:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:alpha:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 660
s:[[:ascii:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:ascii:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 661
s:[[:blank:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:blank:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 662
s:[[:cntrl:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:cntrl:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 663
s:[[:digit:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:digit:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 664
s:[[:graph:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:graph:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 665
s:[[:lower:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:lower:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 666
s:[[:print:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:print:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 667
s:[[:punct:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:punct:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 668
s:[[:space:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:space:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 669
s:[[:upper:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:upper:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 670
s:[[:word:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:word:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 671
s:[[:xdigit:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:xdigit:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 672
s:[[:^alnum:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^alnum:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 673
s:[[:^alpha:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^alpha:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 674
s:[[:^ascii:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^ascii:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 675
s:[[:^blank:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^blank:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 676
s:[[:^cntrl:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^cntrl:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 677
s:[[:^digit:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^digit:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 678
s:[[:^graph:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^graph:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 679
s:[[:^lower:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^lower:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 680
s:[[:^print:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^print:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 681
s:[[:^punct:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^punct:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 682
s:[[:^space:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^space:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 683
s:[[:^upper:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^upper:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 684
s:[[:^word:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^word:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 685
s:[[:^xdigit:]]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^xdigit:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 686
s:[.]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[.])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 687
s:[\B]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\B])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 688
s:[\D]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\D])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 689
s:[\H]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\H])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 690
s:[\N]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\N])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 691
s:[\R]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\R])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 692
s:[\S]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\S])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 693
s:[\V]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\V])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 694
s:[\W]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\W])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 695
s:[\b]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\b])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 696
s:[\d]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\d])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 697
s:[\h]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\h])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 698
s:[\s]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\s])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 699
s:[\v]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\v])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 700
s:[\w]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\w])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 701
s:[^.]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^.])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 702
s:[^\B]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\B])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 703
s:[^\D]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\D])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 704
s:[^\H]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\H])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 705
s:[^\N]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\N])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 706
s:[^\R]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\R])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 707
s:[^\S]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\S])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 708
s:[^\V]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\V])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 709
s:[^\W]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\W])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 710
s:[^\b]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\b])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 711
s:[^\d]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\d])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 712
s:[^\h]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\h])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 713
s:[^\s]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\s])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 714
s:[^\v]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\v])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 715
s:[^\w]:1:

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\w])]}` ]}@{[mb::_s_passed()]}}{$1 . qq :1:}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 716
s@.@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_dot})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 717
s@\B@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_B})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 718
s@\D@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_D})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 719
s@\H@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_H})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 720
s@\N@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_N})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 721
s@\R@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_R})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 722
s@\S@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_S})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 723
s@\V@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_V})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 724
s@\W@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_W})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 725
s@\b@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_b})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 726
s@\d@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_d})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 727
s@\h@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_h})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 728
s@\s@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_s})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 729
s@\v@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_v})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 730
s@\w@1@

END1
s{(\G${mb::_anchor})@{[qr`(?:@{mb::_w})` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 731
s@[\b]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\b])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 732
s@[[:alnum:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:alnum:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 733
s@[[:alpha:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:alpha:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 734
s@[[:ascii:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:ascii:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 735
s@[[:blank:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:blank:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 736
s@[[:cntrl:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:cntrl:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 737
s@[[:digit:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:digit:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 738
s@[[:graph:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:graph:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 739
s@[[:lower:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:lower:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 740
s@[[:print:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:print:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 741
s@[[:punct:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:punct:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 742
s@[[:space:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:space:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 743
s@[[:upper:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:upper:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 744
s@[[:word:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:word:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 745
s@[[:xdigit:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:xdigit:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 746
s@[[:^alnum:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^alnum:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 747
s@[[:^alpha:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^alpha:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 748
s@[[:^ascii:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^ascii:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 749
s@[[:^blank:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^blank:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 750
s@[[:^cntrl:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^cntrl:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 751
s@[[:^digit:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^digit:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 752
s@[[:^graph:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^graph:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 753
s@[[:^lower:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^lower:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 754
s@[[:^print:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^print:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 755
s@[[:^punct:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^punct:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 756
s@[[:^space:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^space:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 757
s@[[:^upper:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^upper:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 758
s@[[:^word:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^word:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 759
s@[[:^xdigit:]]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[[:^xdigit:]])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 760
s@[.]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[.])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 761
s@[\B]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\B])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 762
s@[\D]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\D])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 763
s@[\H]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\H])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 764
s@[\N]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\N])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 765
s@[\R]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\R])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 766
s@[\S]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\S])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 767
s@[\V]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\V])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 768
s@[\W]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\W])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 769
s@[\b]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\b])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 770
s@[\d]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\d])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 771
s@[\h]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\h])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 772
s@[\s]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\s])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 773
s@[\v]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\v])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 774
s@[\w]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[\\w])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 775
s@[^.]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^.])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 776
s@[^\B]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\B])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 777
s@[^\D]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\D])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 778
s@[^\H]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\H])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 779
s@[^\N]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\N])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 780
s@[^\R]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\R])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 781
s@[^\S]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\S])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 782
s@[^\V]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\V])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 783
s@[^\W]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\W])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 784
s@[^\b]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\b])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 785
s@[^\d]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\d])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 786
s@[^\h]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\h])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 787
s@[^\s]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\s])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 788
s@[^\v]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\v])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 789
s@[^\w]@1@

END1
s{(\G${mb::_anchor})@{[qr`@{[mb::_cc(qq[^\\w])]}` ]}@{[mb::_s_passed()]}}{$1 . qq @1@}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 790
s/[�A�\�]ABC1-3]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�A�\\�\]ABC1-3])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 791
s/[^�A�\�]ABC1-3]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�A�\\�\]ABC1-3])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 792
s/[�A�\�]ABC1-3[:alnum:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�A�\\�\]ABC1-3[:alnum:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 793
s/[^�A�\�]ABC1-3[:alnum:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�A�\\�\]ABC1-3[:alnum:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 794
s/[�A�\�]${_}ABC1-3[:alnum:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[�A�\\�\]${_}ABC1-3[:alnum:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 795
s/[^�A�\�]${_}ABC1-3[:alnum:]]/1/

END1
s{(\G${mb::_anchor})@{[qr/@{[mb::_cc(qq[^�A�\\�\]${_}ABC1-3[:alnum:]])]}/ ]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 796
s/Ab�A[�A�\�]ABC1-3]/1/i

END1
s{(\G${mb::_anchor})@{[mb::_ignorecase(qr/Ab(?:�A)@{[mb::_cc(qq[�A�\\�\]ABC1-3])]}/)]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 797
s/Ab�A[^�A�\�]ABC1-3]/1/i

END1
s{(\G${mb::_anchor})@{[mb::_ignorecase(qr/Ab(?:�A)@{[mb::_cc(qq[^�A�\\�\]ABC1-3])]}/)]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 798
s/Ab�A[�A�\�]ABC1-3[:alnum:]]/1/i

END1
s{(\G${mb::_anchor})@{[mb::_ignorecase(qr/Ab(?:�A)@{[mb::_cc(qq[�A�\\�\]ABC1-3[:alnum:]])]}/)]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 799
s/Ab�A[^�A�\�]ABC1-3[:alnum:]]/1/i

END1
s{(\G${mb::_anchor})@{[mb::_ignorecase(qr/Ab(?:�A)@{[mb::_cc(qq[^�A�\\�\]ABC1-3[:alnum:]])]}/)]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 800
s/Ab�A[�A�\�]${_}ABC1-3[:alnum:]]/1/i

END1
s{(\G${mb::_anchor})@{[mb::_ignorecase(qr/Ab(?:�A)@{[mb::_cc(qq[�A�\\�\]${_}ABC1-3[:alnum:]])]}/)]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 801
s/Ab�A[^�A�\�]${_}ABC1-3[:alnum:]]/1/i

END1
s{(\G${mb::_anchor})@{[mb::_ignorecase(qr/Ab(?:�A)@{[mb::_cc(qq[^�A�\\�\]${_}ABC1-3[:alnum:]])]}/)]}@{[mb::_s_passed()]}}{$1 . qq /1/}e

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 802
s # comment 1-1
# comment 1-2
  # comment 1-3
{search} # comment 2-1
# comment 2-2
  # comment 2-3
{replacement} # comment 3-1
# comment 3-2
  # comment 3-3

END1
s # comment 1-1
# comment 1-2
  # comment 1-3
{(\G${mb::_anchor})@{[qr {search} ]}@{[mb::_s_passed()]}} # comment 2-1
# comment 2-2
  # comment 2-3
{$1 . qq {replacement}}e # comment 3-1
# comment 3-2
  # comment 3-3

END2
);

$|=1; print "1..",scalar(@test),"\n"; my $testno=1; sub ok { print $_[0]?'ok ':'not ok ',$testno++,$_[1]?" - $_[1]\n":"\n" } ok($_->()) for @test;

__END__

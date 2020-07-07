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
qr/�@/

END1
---
qr{\G${mb::_anchor}@{[qr/(?:�\@)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 2
qr/�A/

END1
qr{\G${mb::_anchor}@{[qr/(?:�A)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 3
qr/�B/

END1
qr{\G${mb::_anchor}@{[qr/(?:�B)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 4
qr/�C/

END1
qr{\G${mb::_anchor}@{[qr/(?:�C)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 5
qr/�D/

END1
qr{\G${mb::_anchor}@{[qr/(?:�D)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 6
qr/�E/

END1
qr{\G${mb::_anchor}@{[qr/(?:�E)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 7
qr/�F/

END1
qr{\G${mb::_anchor}@{[qr/(?:�F)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 8
qr/�G/

END1
qr{\G${mb::_anchor}@{[qr/(?:�G)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 9
qr/�H/

END1
qr{\G${mb::_anchor}@{[qr/(?:�H)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 10
qr/�I/

END1
qr{\G${mb::_anchor}@{[qr/(?:�I)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 11
qr/�J/

END1
qr{\G${mb::_anchor}@{[qr/(?:�J)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 12
qr/�K/

END1
qr{\G${mb::_anchor}@{[qr/(?:�K)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 13
qr/�L/

END1
qr{\G${mb::_anchor}@{[qr/(?:�L)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 14
qr/�M/

END1
qr{\G${mb::_anchor}@{[qr/(?:�M)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 15
qr/�N/

END1
qr{\G${mb::_anchor}@{[qr/(?:�N)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 16
qr/�O/

END1
qr{\G${mb::_anchor}@{[qr/(?:�O)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 17
qr/�P/

END1
qr{\G${mb::_anchor}@{[qr/(?:�P)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 18
qr/�Q/

END1
qr{\G${mb::_anchor}@{[qr/(?:�Q)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 19
qr/�R/

END1
qr{\G${mb::_anchor}@{[qr/(?:�R)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 20
qr/�S/

END1
qr{\G${mb::_anchor}@{[qr/(?:�S)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 21
qr/�T/

END1
qr{\G${mb::_anchor}@{[qr/(?:�T)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 22
qr/�U/

END1
qr{\G${mb::_anchor}@{[qr/(?:�U)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 23
qr/�V/

END1
qr{\G${mb::_anchor}@{[qr/(?:�V)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 24
qr/�W/

END1
qr{\G${mb::_anchor}@{[qr/(?:�W)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 25
qr/�X/

END1
qr{\G${mb::_anchor}@{[qr/(?:�X)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 26
qr/�Y/

END1
qr{\G${mb::_anchor}@{[qr/(?:�Y)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 27
qr/�Z/

END1
qr{\G${mb::_anchor}@{[qr/(?:�Z)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 28
qr/�[/

END1
qr{\G${mb::_anchor}@{[qr/(?:�\[)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 29
qr/�\/

END1
qr{\G${mb::_anchor}@{[qr/(?:�\\)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 30
qr/�]/

END1
qr{\G${mb::_anchor}@{[qr/(?:�\])/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 31
qr/�^/

END1
qr{\G${mb::_anchor}@{[qr/(?:�\^)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 32
qr/�_/

END1
qr{\G${mb::_anchor}@{[qr/(?:�_)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 33
qr/�`/

END1
qr{\G${mb::_anchor}@{[qr/(?:�\`)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 34
qr/�a/

END1
qr{\G${mb::_anchor}@{[qr/(?:�a)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 35
qr/�b/

END1
qr{\G${mb::_anchor}@{[qr/(?:�b)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 36
qr/�c/

END1
qr{\G${mb::_anchor}@{[qr/(?:�c)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 37
qr/�d/

END1
qr{\G${mb::_anchor}@{[qr/(?:�d)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 38
qr/�e/

END1
qr{\G${mb::_anchor}@{[qr/(?:�e)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 39
qr/�f/

END1
qr{\G${mb::_anchor}@{[qr/(?:�f)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 40
qr/�g/

END1
qr{\G${mb::_anchor}@{[qr/(?:�g)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 41
qr/�h/

END1
qr{\G${mb::_anchor}@{[qr/(?:�h)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 42
qr/�i/

END1
qr{\G${mb::_anchor}@{[qr/(?:�i)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 43
qr/�j/

END1
qr{\G${mb::_anchor}@{[qr/(?:�j)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 44
qr/�k/

END1
qr{\G${mb::_anchor}@{[qr/(?:�k)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 45
qr/�l/

END1
qr{\G${mb::_anchor}@{[qr/(?:�l)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 46
qr/�m/

END1
qr{\G${mb::_anchor}@{[qr/(?:�m)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 47
qr/�n/

END1
qr{\G${mb::_anchor}@{[qr/(?:�n)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 48
qr/�o/

END1
qr{\G${mb::_anchor}@{[qr/(?:�o)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 49
qr/�p/

END1
qr{\G${mb::_anchor}@{[qr/(?:�p)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 50
qr/�q/

END1
qr{\G${mb::_anchor}@{[qr/(?:�q)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 51
qr/�r/

END1
qr{\G${mb::_anchor}@{[qr/(?:�r)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 52
qr/�s/

END1
qr{\G${mb::_anchor}@{[qr/(?:�s)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 53
qr/�t/

END1
qr{\G${mb::_anchor}@{[qr/(?:�t)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 54
qr/�u/

END1
qr{\G${mb::_anchor}@{[qr/(?:�u)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 55
qr/�v/

END1
qr{\G${mb::_anchor}@{[qr/(?:�v)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 56
qr/�w/

END1
qr{\G${mb::_anchor}@{[qr/(?:�w)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 57
qr/�x/

END1
qr{\G${mb::_anchor}@{[qr/(?:�x)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 58
qr/�y/

END1
qr{\G${mb::_anchor}@{[qr/(?:�y)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 59
qr/�z/

END1
qr{\G${mb::_anchor}@{[qr/(?:�z)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 60
qr/�{/

END1
qr{\G${mb::_anchor}@{[qr/(?:�\{)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 61
qr/�|/

END1
qr{\G${mb::_anchor}@{[qr/(?:�\|)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 62
qr/�}/

END1
qr{\G${mb::_anchor}@{[qr/(?:�\})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 63
qr/�~/

END1
qr{\G${mb::_anchor}@{[qr/(?:�\~)/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 64
qr/[�@]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�\@])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 65
qr/[�A]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�A])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 66
qr/[�B]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�B])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 67
qr/[�C]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�C])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 68
qr/[�D]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�D])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 69
qr/[�E]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�E])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 70
qr/[�F]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�F])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 71
qr/[�G]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�G])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 72
qr/[�H]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�H])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 73
qr/[�I]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�I])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 74
qr/[�J]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�J])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 75
qr/[�K]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�K])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 76
qr/[�L]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�L])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 77
qr/[�M]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�M])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 78
qr/[�N]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�N])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 79
qr/[�O]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�O])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 80
qr/[�P]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�P])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 81
qr/[�Q]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�Q])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 82
qr/[�R]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�R])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 83
qr/[�S]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�S])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 84
qr/[�T]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�T])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 85
qr/[�U]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�U])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 86
qr/[�V]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�V])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 87
qr/[�W]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�W])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 88
qr/[�X]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�X])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 89
qr/[�Y]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�Y])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 90
qr/[�Z]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�Z])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 91
qr/[�[]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�\[])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 92
qr/[�\]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�\\])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 93
qr/[�]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�\]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 94
qr/[�^]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�\^])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 95
qr/[�_]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�_])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 96
qr/[�`]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�\`])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 97
qr/[�a]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�a])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 98
qr/[�b]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�b])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 99
qr/[�c]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�c])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 100
qr/[�d]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�d])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 101
qr/[�e]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�e])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 102
qr/[�f]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�f])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 103
qr/[�g]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�g])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 104
qr/[�h]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�h])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 105
qr/[�i]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�i])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 106
qr/[�j]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�j])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 107
qr/[�k]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�k])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 108
qr/[�l]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�l])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 109
qr/[�m]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�m])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 110
qr/[�n]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�n])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 111
qr/[�o]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�o])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 112
qr/[�p]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�p])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 113
qr/[�q]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�q])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 114
qr/[�r]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�r])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 115
qr/[�s]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�s])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 116
qr/[�t]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�t])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 117
qr/[�u]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�u])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 118
qr/[�v]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�v])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 119
qr/[�w]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�w])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 120
qr/[�x]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�x])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 121
qr/[�y]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�y])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 122
qr/[�z]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�z])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 123
qr/[�{]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�\{])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 124
qr/[�|]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�\|])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 125
qr/[�}]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�\}])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 126
qr/[�~]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�\~])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 127
qr/[^�@]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�\@])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 128
qr/[^�A]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�A])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 129
qr/[^�B]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�B])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 130
qr/[^�C]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�C])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 131
qr/[^�D]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�D])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 132
qr/[^�E]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�E])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 133
qr/[^�F]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�F])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 134
qr/[^�G]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�G])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 135
qr/[^�H]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�H])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 136
qr/[^�I]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�I])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 137
qr/[^�J]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�J])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 138
qr/[^�K]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�K])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 139
qr/[^�L]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�L])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 140
qr/[^�M]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�M])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 141
qr/[^�N]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�N])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 142
qr/[^�O]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�O])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 143
qr/[^�P]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�P])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 144
qr/[^�Q]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�Q])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 145
qr/[^�R]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�R])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 146
qr/[^�S]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�S])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 147
qr/[^�T]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�T])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 148
qr/[^�U]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�U])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 149
qr/[^�V]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�V])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 150
qr/[^�W]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�W])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 151
qr/[^�X]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�X])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 152
qr/[^�Y]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�Y])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 153
qr/[^�Z]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�Z])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 154
qr/[^�[]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�\[])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 155
qr/[^�\]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�\\])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 156
qr/[^�]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�\]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 157
qr/[^�^]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�\^])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 158
qr/[^�_]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�_])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 159
qr/[^�`]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�\`])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 160
qr/[^�a]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�a])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 161
qr/[^�b]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�b])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 162
qr/[^�c]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�c])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 163
qr/[^�d]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�d])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 164
qr/[^�e]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�e])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 165
qr/[^�f]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�f])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 166
qr/[^�g]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�g])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 167
qr/[^�h]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�h])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 168
qr/[^�i]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�i])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 169
qr/[^�j]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�j])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 170
qr/[^�k]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�k])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 171
qr/[^�l]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�l])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 172
qr/[^�m]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�m])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 173
qr/[^�n]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�n])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 174
qr/[^�o]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�o])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 175
qr/[^�p]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�p])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 176
qr/[^�q]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�q])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 177
qr/[^�r]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�r])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 178
qr/[^�s]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�s])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 179
qr/[^�t]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�t])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 180
qr/[^�u]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�u])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 181
qr/[^�v]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�v])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 182
qr/[^�w]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�w])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 183
qr/[^�x]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�x])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 184
qr/[^�y]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�y])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 185
qr/[^�z]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�z])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 186
qr/[^�{]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�\{])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 187
qr/[^�|]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�\|])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 188
qr/[^�}]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�\}])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 189
qr/[^�~]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�\~])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 190
qr:�@:

END1
qr{\G${mb::_anchor}@{[qr`(?:�\@)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 191
qr:�A:

END1
qr{\G${mb::_anchor}@{[qr`(?:�A)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 192
qr:�B:

END1
qr{\G${mb::_anchor}@{[qr`(?:�B)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 193
qr:�C:

END1
qr{\G${mb::_anchor}@{[qr`(?:�C)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 194
qr:�D:

END1
qr{\G${mb::_anchor}@{[qr`(?:�D)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 195
qr:�E:

END1
qr{\G${mb::_anchor}@{[qr`(?:�E)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 196
qr:�F:

END1
qr{\G${mb::_anchor}@{[qr`(?:�F)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 197
qr:�G:

END1
qr{\G${mb::_anchor}@{[qr`(?:�G)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 198
qr:�H:

END1
qr{\G${mb::_anchor}@{[qr`(?:�H)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 199
qr:�I:

END1
qr{\G${mb::_anchor}@{[qr`(?:�I)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 200
qr:�J:

END1
qr{\G${mb::_anchor}@{[qr`(?:�J)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 201
qr:�K:

END1
qr{\G${mb::_anchor}@{[qr`(?:�K)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 202
qr:�L:

END1
qr{\G${mb::_anchor}@{[qr`(?:�L)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 203
qr:�M:

END1
qr{\G${mb::_anchor}@{[qr`(?:�M)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 204
qr:�N:

END1
qr{\G${mb::_anchor}@{[qr`(?:�N)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 205
qr:�O:

END1
qr{\G${mb::_anchor}@{[qr`(?:�O)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 206
qr:�P:

END1
qr{\G${mb::_anchor}@{[qr`(?:�P)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 207
qr:�Q:

END1
qr{\G${mb::_anchor}@{[qr`(?:�Q)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 208
qr:�R:

END1
qr{\G${mb::_anchor}@{[qr`(?:�R)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 209
qr:�S:

END1
qr{\G${mb::_anchor}@{[qr`(?:�S)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 210
qr:�T:

END1
qr{\G${mb::_anchor}@{[qr`(?:�T)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 211
qr:�U:

END1
qr{\G${mb::_anchor}@{[qr`(?:�U)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 212
qr:�V:

END1
qr{\G${mb::_anchor}@{[qr`(?:�V)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 213
qr:�W:

END1
qr{\G${mb::_anchor}@{[qr`(?:�W)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 214
qr:�X:

END1
qr{\G${mb::_anchor}@{[qr`(?:�X)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 215
qr:�Y:

END1
qr{\G${mb::_anchor}@{[qr`(?:�Y)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 216
qr:�Z:

END1
qr{\G${mb::_anchor}@{[qr`(?:�Z)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 217
qr:�[:

END1
qr{\G${mb::_anchor}@{[qr`(?:�\[)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 218
qr:�\:

END1
qr{\G${mb::_anchor}@{[qr`(?:�\\)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 219
qr:�]:

END1
qr{\G${mb::_anchor}@{[qr`(?:�\])` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 220
qr:�^:

END1
qr{\G${mb::_anchor}@{[qr`(?:�\^)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 221
qr:�_:

END1
qr{\G${mb::_anchor}@{[qr`(?:�_)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 222
qr:�`:

END1
qr{\G${mb::_anchor}@{[qr`(?:�\`)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 223
qr:�a:

END1
qr{\G${mb::_anchor}@{[qr`(?:�a)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 224
qr:�b:

END1
qr{\G${mb::_anchor}@{[qr`(?:�b)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 225
qr:�c:

END1
qr{\G${mb::_anchor}@{[qr`(?:�c)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 226
qr:�d:

END1
qr{\G${mb::_anchor}@{[qr`(?:�d)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 227
qr:�e:

END1
qr{\G${mb::_anchor}@{[qr`(?:�e)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 228
qr:�f:

END1
qr{\G${mb::_anchor}@{[qr`(?:�f)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 229
qr:�g:

END1
qr{\G${mb::_anchor}@{[qr`(?:�g)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 230
qr:�h:

END1
qr{\G${mb::_anchor}@{[qr`(?:�h)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 231
qr:�i:

END1
qr{\G${mb::_anchor}@{[qr`(?:�i)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 232
qr:�j:

END1
qr{\G${mb::_anchor}@{[qr`(?:�j)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 233
qr:�k:

END1
qr{\G${mb::_anchor}@{[qr`(?:�k)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 234
qr:�l:

END1
qr{\G${mb::_anchor}@{[qr`(?:�l)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 235
qr:�m:

END1
qr{\G${mb::_anchor}@{[qr`(?:�m)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 236
qr:�n:

END1
qr{\G${mb::_anchor}@{[qr`(?:�n)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 237
qr:�o:

END1
qr{\G${mb::_anchor}@{[qr`(?:�o)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 238
qr:�p:

END1
qr{\G${mb::_anchor}@{[qr`(?:�p)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 239
qr:�q:

END1
qr{\G${mb::_anchor}@{[qr`(?:�q)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 240
qr:�r:

END1
qr{\G${mb::_anchor}@{[qr`(?:�r)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 241
qr:�s:

END1
qr{\G${mb::_anchor}@{[qr`(?:�s)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 242
qr:�t:

END1
qr{\G${mb::_anchor}@{[qr`(?:�t)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 243
qr:�u:

END1
qr{\G${mb::_anchor}@{[qr`(?:�u)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 244
qr:�v:

END1
qr{\G${mb::_anchor}@{[qr`(?:�v)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 245
qr:�w:

END1
qr{\G${mb::_anchor}@{[qr`(?:�w)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 246
qr:�x:

END1
qr{\G${mb::_anchor}@{[qr`(?:�x)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 247
qr:�y:

END1
qr{\G${mb::_anchor}@{[qr`(?:�y)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 248
qr:�z:

END1
qr{\G${mb::_anchor}@{[qr`(?:�z)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 249
qr:�{:

END1
qr{\G${mb::_anchor}@{[qr`(?:�\{)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 250
qr:�|:

END1
qr{\G${mb::_anchor}@{[qr`(?:�\|)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 251
qr:�}:

END1
qr{\G${mb::_anchor}@{[qr`(?:�\})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 252
qr:�~:

END1
qr{\G${mb::_anchor}@{[qr`(?:�\~)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 253
qr:[�@]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\@])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 254
qr:[�A]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�A])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 255
qr:[�B]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�B])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 256
qr:[�C]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�C])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 257
qr:[�D]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�D])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 258
qr:[�E]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�E])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 259
qr:[�F]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�F])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 260
qr:[�G]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�G])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 261
qr:[�H]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�H])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 262
qr:[�I]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�I])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 263
qr:[�J]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�J])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 264
qr:[�K]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�K])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 265
qr:[�L]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�L])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 266
qr:[�M]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�M])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 267
qr:[�N]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�N])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 268
qr:[�O]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�O])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 269
qr:[�P]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�P])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 270
qr:[�Q]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�Q])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 271
qr:[�R]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�R])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 272
qr:[�S]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�S])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 273
qr:[�T]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�T])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 274
qr:[�U]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�U])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 275
qr:[�V]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�V])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 276
qr:[�W]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�W])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 277
qr:[�X]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�X])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 278
qr:[�Y]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�Y])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 279
qr:[�Z]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�Z])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 280
qr:[�[]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\[])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 281
qr:[�\]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\\])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 282
qr:[�]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 283
qr:[�^]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\^])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 284
qr:[�_]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�_])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 285
qr:[�`]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\`])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 286
qr:[�a]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�a])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 287
qr:[�b]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�b])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 288
qr:[�c]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�c])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 289
qr:[�d]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�d])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 290
qr:[�e]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�e])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 291
qr:[�f]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�f])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 292
qr:[�g]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�g])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 293
qr:[�h]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�h])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 294
qr:[�i]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�i])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 295
qr:[�j]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�j])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 296
qr:[�k]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�k])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 297
qr:[�l]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�l])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 298
qr:[�m]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�m])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 299
qr:[�n]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�n])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 300
qr:[�o]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�o])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 301
qr:[�p]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�p])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 302
qr:[�q]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�q])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 303
qr:[�r]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�r])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 304
qr:[�s]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�s])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 305
qr:[�t]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�t])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 306
qr:[�u]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�u])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 307
qr:[�v]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�v])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 308
qr:[�w]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�w])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 309
qr:[�x]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�x])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 310
qr:[�y]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�y])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 311
qr:[�z]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�z])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 312
qr:[�{]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\{])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 313
qr:[�|]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\|])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 314
qr:[�}]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\}])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 315
qr:[�~]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\~])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 316
qr:[^�@]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\@])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 317
qr:[^�A]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�A])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 318
qr:[^�B]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�B])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 319
qr:[^�C]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�C])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 320
qr:[^�D]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�D])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 321
qr:[^�E]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�E])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 322
qr:[^�F]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�F])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 323
qr:[^�G]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�G])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 324
qr:[^�H]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�H])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 325
qr:[^�I]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�I])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 326
qr:[^�J]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�J])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 327
qr:[^�K]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�K])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 328
qr:[^�L]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�L])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 329
qr:[^�M]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�M])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 330
qr:[^�N]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�N])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 331
qr:[^�O]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�O])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 332
qr:[^�P]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�P])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 333
qr:[^�Q]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�Q])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 334
qr:[^�R]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�R])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 335
qr:[^�S]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�S])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 336
qr:[^�T]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�T])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 337
qr:[^�U]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�U])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 338
qr:[^�V]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�V])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 339
qr:[^�W]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�W])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 340
qr:[^�X]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�X])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 341
qr:[^�Y]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�Y])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 342
qr:[^�Z]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�Z])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 343
qr:[^�[]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\[])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 344
qr:[^�\]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\\])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 345
qr:[^�]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 346
qr:[^�^]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\^])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 347
qr:[^�_]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�_])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 348
qr:[^�`]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\`])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 349
qr:[^�a]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�a])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 350
qr:[^�b]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�b])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 351
qr:[^�c]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�c])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 352
qr:[^�d]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�d])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 353
qr:[^�e]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�e])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 354
qr:[^�f]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�f])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 355
qr:[^�g]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�g])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 356
qr:[^�h]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�h])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 357
qr:[^�i]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�i])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 358
qr:[^�j]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�j])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 359
qr:[^�k]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�k])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 360
qr:[^�l]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�l])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 361
qr:[^�m]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�m])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 362
qr:[^�n]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�n])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 363
qr:[^�o]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�o])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 364
qr:[^�p]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�p])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 365
qr:[^�q]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�q])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 366
qr:[^�r]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�r])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 367
qr:[^�s]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�s])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 368
qr:[^�t]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�t])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 369
qr:[^�u]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�u])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 370
qr:[^�v]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�v])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 371
qr:[^�w]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�w])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 372
qr:[^�x]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�x])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 373
qr:[^�y]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�y])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 374
qr:[^�z]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�z])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 375
qr:[^�{]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\{])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 376
qr:[^�|]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\|])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 377
qr:[^�}]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\}])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 378
qr:[^�~]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\~])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 379
qr@�@@

END1
qr{\G${mb::_anchor}@{[qr`(?:�\@)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 380
qr@�A@

END1
qr{\G${mb::_anchor}@{[qr`(?:�A)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 381
qr@�B@

END1
qr{\G${mb::_anchor}@{[qr`(?:�B)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 382
qr@�C@

END1
qr{\G${mb::_anchor}@{[qr`(?:�C)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 383
qr@�D@

END1
qr{\G${mb::_anchor}@{[qr`(?:�D)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 384
qr@�E@

END1
qr{\G${mb::_anchor}@{[qr`(?:�E)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 385
qr@�F@

END1
qr{\G${mb::_anchor}@{[qr`(?:�F)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 386
qr@�G@

END1
qr{\G${mb::_anchor}@{[qr`(?:�G)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 387
qr@�H@

END1
qr{\G${mb::_anchor}@{[qr`(?:�H)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 388
qr@�I@

END1
qr{\G${mb::_anchor}@{[qr`(?:�I)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 389
qr@�J@

END1
qr{\G${mb::_anchor}@{[qr`(?:�J)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 390
qr@�K@

END1
qr{\G${mb::_anchor}@{[qr`(?:�K)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 391
qr@�L@

END1
qr{\G${mb::_anchor}@{[qr`(?:�L)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 392
qr@�M@

END1
qr{\G${mb::_anchor}@{[qr`(?:�M)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 393
qr@�N@

END1
qr{\G${mb::_anchor}@{[qr`(?:�N)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 394
qr@�O@

END1
qr{\G${mb::_anchor}@{[qr`(?:�O)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 395
qr@�P@

END1
qr{\G${mb::_anchor}@{[qr`(?:�P)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 396
qr@�Q@

END1
qr{\G${mb::_anchor}@{[qr`(?:�Q)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 397
qr@�R@

END1
qr{\G${mb::_anchor}@{[qr`(?:�R)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 398
qr@�S@

END1
qr{\G${mb::_anchor}@{[qr`(?:�S)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 399
qr@�T@

END1
qr{\G${mb::_anchor}@{[qr`(?:�T)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 400
qr@�U@

END1
qr{\G${mb::_anchor}@{[qr`(?:�U)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 401
qr@�V@

END1
qr{\G${mb::_anchor}@{[qr`(?:�V)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 402
qr@�W@

END1
qr{\G${mb::_anchor}@{[qr`(?:�W)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 403
qr@�X@

END1
qr{\G${mb::_anchor}@{[qr`(?:�X)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 404
qr@�Y@

END1
qr{\G${mb::_anchor}@{[qr`(?:�Y)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 405
qr@�Z@

END1
qr{\G${mb::_anchor}@{[qr`(?:�Z)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 406
qr@�[@

END1
qr{\G${mb::_anchor}@{[qr`(?:�\[)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 407
qr@�\@

END1
qr{\G${mb::_anchor}@{[qr`(?:�\\)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 408
qr@�]@

END1
qr{\G${mb::_anchor}@{[qr`(?:�\])` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 409
qr@�^@

END1
qr{\G${mb::_anchor}@{[qr`(?:�\^)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 410
qr@�_@

END1
qr{\G${mb::_anchor}@{[qr`(?:�_)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 411
qr@�`@

END1
qr{\G${mb::_anchor}@{[qr`(?:�\`)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 412
qr@�a@

END1
qr{\G${mb::_anchor}@{[qr`(?:�a)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 413
qr@�b@

END1
qr{\G${mb::_anchor}@{[qr`(?:�b)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 414
qr@�c@

END1
qr{\G${mb::_anchor}@{[qr`(?:�c)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 415
qr@�d@

END1
qr{\G${mb::_anchor}@{[qr`(?:�d)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 416
qr@�e@

END1
qr{\G${mb::_anchor}@{[qr`(?:�e)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 417
qr@�f@

END1
qr{\G${mb::_anchor}@{[qr`(?:�f)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 418
qr@�g@

END1
qr{\G${mb::_anchor}@{[qr`(?:�g)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 419
qr@�h@

END1
qr{\G${mb::_anchor}@{[qr`(?:�h)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 420
qr@�i@

END1
qr{\G${mb::_anchor}@{[qr`(?:�i)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 421
qr@�j@

END1
qr{\G${mb::_anchor}@{[qr`(?:�j)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 422
qr@�k@

END1
qr{\G${mb::_anchor}@{[qr`(?:�k)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 423
qr@�l@

END1
qr{\G${mb::_anchor}@{[qr`(?:�l)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 424
qr@�m@

END1
qr{\G${mb::_anchor}@{[qr`(?:�m)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 425
qr@�n@

END1
qr{\G${mb::_anchor}@{[qr`(?:�n)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 426
qr@�o@

END1
qr{\G${mb::_anchor}@{[qr`(?:�o)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 427
qr@�p@

END1
qr{\G${mb::_anchor}@{[qr`(?:�p)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 428
qr@�q@

END1
qr{\G${mb::_anchor}@{[qr`(?:�q)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 429
qr@�r@

END1
qr{\G${mb::_anchor}@{[qr`(?:�r)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 430
qr@�s@

END1
qr{\G${mb::_anchor}@{[qr`(?:�s)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 431
qr@�t@

END1
qr{\G${mb::_anchor}@{[qr`(?:�t)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 432
qr@�u@

END1
qr{\G${mb::_anchor}@{[qr`(?:�u)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 433
qr@�v@

END1
qr{\G${mb::_anchor}@{[qr`(?:�v)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 434
qr@�w@

END1
qr{\G${mb::_anchor}@{[qr`(?:�w)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 435
qr@�x@

END1
qr{\G${mb::_anchor}@{[qr`(?:�x)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 436
qr@�y@

END1
qr{\G${mb::_anchor}@{[qr`(?:�y)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 437
qr@�z@

END1
qr{\G${mb::_anchor}@{[qr`(?:�z)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 438
qr@�{@

END1
qr{\G${mb::_anchor}@{[qr`(?:�\{)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 439
qr@�|@

END1
qr{\G${mb::_anchor}@{[qr`(?:�\|)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 440
qr@�}@

END1
qr{\G${mb::_anchor}@{[qr`(?:�\})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 441
qr@�~@

END1
qr{\G${mb::_anchor}@{[qr`(?:�\~)` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 442
qr@[�@]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\@])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 443
qr@[�A]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�A])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 444
qr@[�B]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�B])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 445
qr@[�C]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�C])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 446
qr@[�D]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�D])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 447
qr@[�E]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�E])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 448
qr@[�F]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�F])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 449
qr@[�G]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�G])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 450
qr@[�H]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�H])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 451
qr@[�I]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�I])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 452
qr@[�J]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�J])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 453
qr@[�K]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�K])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 454
qr@[�L]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�L])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 455
qr@[�M]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�M])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 456
qr@[�N]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�N])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 457
qr@[�O]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�O])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 458
qr@[�P]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�P])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 459
qr@[�Q]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�Q])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 460
qr@[�R]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�R])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 461
qr@[�S]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�S])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 462
qr@[�T]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�T])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 463
qr@[�U]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�U])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 464
qr@[�V]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�V])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 465
qr@[�W]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�W])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 466
qr@[�X]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�X])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 467
qr@[�Y]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�Y])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 468
qr@[�Z]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�Z])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 469
qr@[�[]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\[])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 470
qr@[�\]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\\])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 471
qr@[�]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 472
qr@[�^]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\^])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 473
qr@[�_]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�_])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 474
qr@[�`]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\`])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 475
qr@[�a]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�a])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 476
qr@[�b]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�b])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 477
qr@[�c]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�c])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 478
qr@[�d]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�d])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 479
qr@[�e]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�e])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 480
qr@[�f]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�f])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 481
qr@[�g]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�g])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 482
qr@[�h]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�h])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 483
qr@[�i]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�i])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 484
qr@[�j]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�j])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 485
qr@[�k]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�k])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 486
qr@[�l]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�l])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 487
qr@[�m]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�m])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 488
qr@[�n]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�n])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 489
qr@[�o]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�o])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 490
qr@[�p]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�p])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 491
qr@[�q]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�q])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 492
qr@[�r]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�r])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 493
qr@[�s]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�s])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 494
qr@[�t]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�t])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 495
qr@[�u]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�u])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 496
qr@[�v]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�v])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 497
qr@[�w]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�w])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 498
qr@[�x]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�x])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 499
qr@[�y]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�y])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 500
qr@[�z]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�z])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 501
qr@[�{]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\{])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 502
qr@[�|]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\|])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 503
qr@[�}]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\}])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 504
qr@[�~]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[�\~])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 505
qr@[^�@]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\@])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 506
qr@[^�A]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�A])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 507
qr@[^�B]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�B])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 508
qr@[^�C]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�C])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 509
qr@[^�D]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�D])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 510
qr@[^�E]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�E])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 511
qr@[^�F]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�F])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 512
qr@[^�G]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�G])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 513
qr@[^�H]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�H])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 514
qr@[^�I]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�I])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 515
qr@[^�J]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�J])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 516
qr@[^�K]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�K])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 517
qr@[^�L]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�L])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 518
qr@[^�M]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�M])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 519
qr@[^�N]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�N])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 520
qr@[^�O]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�O])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 521
qr@[^�P]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�P])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 522
qr@[^�Q]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�Q])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 523
qr@[^�R]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�R])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 524
qr@[^�S]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�S])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 525
qr@[^�T]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�T])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 526
qr@[^�U]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�U])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 527
qr@[^�V]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�V])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 528
qr@[^�W]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�W])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 529
qr@[^�X]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�X])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 530
qr@[^�Y]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�Y])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 531
qr@[^�Z]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�Z])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 532
qr@[^�[]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\[])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 533
qr@[^�\]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\\])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 534
qr@[^�]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 535
qr@[^�^]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\^])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 536
qr@[^�_]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�_])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 537
qr@[^�`]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\`])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 538
qr@[^�a]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�a])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 539
qr@[^�b]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�b])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 540
qr@[^�c]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�c])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 541
qr@[^�d]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�d])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 542
qr@[^�e]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�e])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 543
qr@[^�f]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�f])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 544
qr@[^�g]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�g])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 545
qr@[^�h]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�h])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 546
qr@[^�i]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�i])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 547
qr@[^�j]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�j])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 548
qr@[^�k]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�k])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 549
qr@[^�l]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�l])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 550
qr@[^�m]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�m])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 551
qr@[^�n]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�n])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 552
qr@[^�o]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�o])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 553
qr@[^�p]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�p])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 554
qr@[^�q]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�q])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 555
qr@[^�r]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�r])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 556
qr@[^�s]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�s])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 557
qr@[^�t]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�t])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 558
qr@[^�u]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�u])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 559
qr@[^�v]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�v])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 560
qr@[^�w]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�w])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 561
qr@[^�x]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�x])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 562
qr@[^�y]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�y])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 563
qr@[^�z]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�z])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 564
qr@[^�{]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\{])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 565
qr@[^�|]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\|])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 566
qr@[^�}]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\}])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 567
qr@[^�~]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^�\~])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 568
qr/./

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_dot})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 569
qr/\B/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_B})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 570
qr/\D/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_D})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 571
qr/\H/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_H})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 572
qr/\N/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_N})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 573
qr/\R/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_R})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 574
qr/\S/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_S})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 575
qr/\V/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_V})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 576
qr/\W/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_W})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 577
qr/\b/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_b})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 578
qr/\d/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_d})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 579
qr/\h/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_h})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 580
qr/\s/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_s})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 581
qr/\v/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_v})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 582
qr/\w/

END1
qr{\G${mb::_anchor}@{[qr/(?:@{mb::_w})/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 583
qr/[\b]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\b])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 584
qr/[[:alnum:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:alnum:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 585
qr/[[:alpha:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:alpha:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 586
qr/[[:ascii:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:ascii:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 587
qr/[[:blank:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:blank:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 588
qr/[[:cntrl:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:cntrl:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 589
qr/[[:digit:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:digit:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 590
qr/[[:graph:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:graph:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 591
qr/[[:lower:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:lower:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 592
qr/[[:print:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:print:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 593
qr/[[:punct:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:punct:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 594
qr/[[:space:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:space:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 595
qr/[[:upper:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:upper:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 596
qr/[[:word:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:word:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 597
qr/[[:xdigit:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:xdigit:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 598
qr/[[:^alnum:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^alnum:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 599
qr/[[:^alpha:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^alpha:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 600
qr/[[:^ascii:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^ascii:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 601
qr/[[:^blank:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^blank:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 602
qr/[[:^cntrl:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^cntrl:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 603
qr/[[:^digit:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^digit:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 604
qr/[[:^graph:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^graph:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 605
qr/[[:^lower:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^lower:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 606
qr/[[:^print:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^print:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 607
qr/[[:^punct:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^punct:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 608
qr/[[:^space:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^space:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 609
qr/[[:^upper:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^upper:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 610
qr/[[:^word:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^word:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 611
qr/[[:^xdigit:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[[:^xdigit:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 612
qr/[.]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[.])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 613
qr/[\B]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\B])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 614
qr/[\D]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\D])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 615
qr/[\H]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\H])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 616
qr/[\N]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\N])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 617
qr/[\R]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\R])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 618
qr/[\S]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\S])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 619
qr/[\V]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\V])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 620
qr/[\W]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\W])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 621
qr/[\b]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\b])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 622
qr/[\d]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\d])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 623
qr/[\h]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\h])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 624
qr/[\s]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\s])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 625
qr/[\v]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\v])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 626
qr/[\w]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[\\w])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 627
qr/[^.]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^.])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 628
qr/[^\B]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\B])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 629
qr/[^\D]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\D])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 630
qr/[^\H]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\H])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 631
qr/[^\N]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\N])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 632
qr/[^\R]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\R])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 633
qr/[^\S]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\S])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 634
qr/[^\V]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\V])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 635
qr/[^\W]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\W])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 636
qr/[^\b]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\b])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 637
qr/[^\d]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\d])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 638
qr/[^\h]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\h])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 639
qr/[^\s]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\s])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 640
qr/[^\v]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\v])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 641
qr/[^\w]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^\\w])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 642
qr:.:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_dot})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 643
qr:\B:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_B})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 644
qr:\D:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_D})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 645
qr:\H:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_H})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 646
qr:\N:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_N})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 647
qr:\R:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_R})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 648
qr:\S:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_S})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 649
qr:\V:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_V})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 650
qr:\W:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_W})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 651
qr:\b:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_b})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 652
qr:\d:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_d})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 653
qr:\h:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_h})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 654
qr:\s:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_s})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 655
qr:\v:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_v})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 656
qr:\w:

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_w})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 657
qr:[\b]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\b])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 658
qr:[[:alnum:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:alnum:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 659
qr:[[:alpha:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:alpha:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 660
qr:[[:ascii:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:ascii:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 661
qr:[[:blank:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:blank:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 662
qr:[[:cntrl:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:cntrl:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 663
qr:[[:digit:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:digit:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 664
qr:[[:graph:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:graph:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 665
qr:[[:lower:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:lower:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 666
qr:[[:print:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:print:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 667
qr:[[:punct:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:punct:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 668
qr:[[:space:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:space:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 669
qr:[[:upper:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:upper:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 670
qr:[[:word:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:word:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 671
qr:[[:xdigit:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:xdigit:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 672
qr:[[:^alnum:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^alnum:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 673
qr:[[:^alpha:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^alpha:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 674
qr:[[:^ascii:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^ascii:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 675
qr:[[:^blank:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^blank:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 676
qr:[[:^cntrl:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^cntrl:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 677
qr:[[:^digit:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^digit:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 678
qr:[[:^graph:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^graph:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 679
qr:[[:^lower:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^lower:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 680
qr:[[:^print:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^print:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 681
qr:[[:^punct:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^punct:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 682
qr:[[:^space:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^space:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 683
qr:[[:^upper:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^upper:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 684
qr:[[:^word:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^word:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 685
qr:[[:^xdigit:]]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^xdigit:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 686
qr:[.]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[.])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 687
qr:[\B]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\B])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 688
qr:[\D]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\D])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 689
qr:[\H]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\H])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 690
qr:[\N]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\N])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 691
qr:[\R]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\R])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 692
qr:[\S]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\S])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 693
qr:[\V]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\V])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 694
qr:[\W]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\W])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 695
qr:[\b]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\b])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 696
qr:[\d]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\d])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 697
qr:[\h]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\h])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 698
qr:[\s]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\s])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 699
qr:[\v]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\v])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 700
qr:[\w]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\w])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 701
qr:[^.]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^.])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 702
qr:[^\B]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\B])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 703
qr:[^\D]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\D])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 704
qr:[^\H]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\H])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 705
qr:[^\N]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\N])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 706
qr:[^\R]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\R])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 707
qr:[^\S]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\S])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 708
qr:[^\V]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\V])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 709
qr:[^\W]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\W])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 710
qr:[^\b]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\b])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 711
qr:[^\d]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\d])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 712
qr:[^\h]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\h])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 713
qr:[^\s]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\s])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 714
qr:[^\v]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\v])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 715
qr:[^\w]:

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\w])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 716
qr@.@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_dot})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 717
qr@\B@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_B})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 718
qr@\D@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_D})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 719
qr@\H@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_H})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 720
qr@\N@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_N})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 721
qr@\R@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_R})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 722
qr@\S@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_S})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 723
qr@\V@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_V})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 724
qr@\W@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_W})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 725
qr@\b@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_b})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 726
qr@\d@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_d})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 727
qr@\h@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_h})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 728
qr@\s@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_s})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 729
qr@\v@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_v})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 730
qr@\w@

END1
qr{\G${mb::_anchor}@{[qr`(?:@{mb::_w})` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 731
qr@[\b]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\b])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 732
qr@[[:alnum:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:alnum:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 733
qr@[[:alpha:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:alpha:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 734
qr@[[:ascii:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:ascii:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 735
qr@[[:blank:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:blank:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 736
qr@[[:cntrl:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:cntrl:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 737
qr@[[:digit:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:digit:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 738
qr@[[:graph:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:graph:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 739
qr@[[:lower:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:lower:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 740
qr@[[:print:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:print:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 741
qr@[[:punct:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:punct:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 742
qr@[[:space:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:space:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 743
qr@[[:upper:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:upper:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 744
qr@[[:word:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:word:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 745
qr@[[:xdigit:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:xdigit:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 746
qr@[[:^alnum:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^alnum:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 747
qr@[[:^alpha:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^alpha:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 748
qr@[[:^ascii:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^ascii:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 749
qr@[[:^blank:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^blank:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 750
qr@[[:^cntrl:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^cntrl:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 751
qr@[[:^digit:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^digit:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 752
qr@[[:^graph:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^graph:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 753
qr@[[:^lower:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^lower:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 754
qr@[[:^print:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^print:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 755
qr@[[:^punct:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^punct:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 756
qr@[[:^space:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^space:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 757
qr@[[:^upper:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^upper:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 758
qr@[[:^word:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^word:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 759
qr@[[:^xdigit:]]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[[:^xdigit:]])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 760
qr@[.]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[.])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 761
qr@[\B]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\B])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 762
qr@[\D]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\D])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 763
qr@[\H]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\H])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 764
qr@[\N]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\N])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 765
qr@[\R]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\R])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 766
qr@[\S]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\S])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 767
qr@[\V]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\V])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 768
qr@[\W]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\W])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 769
qr@[\b]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\b])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 770
qr@[\d]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\d])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 771
qr@[\h]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\h])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 772
qr@[\s]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\s])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 773
qr@[\v]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\v])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 774
qr@[\w]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[\\w])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 775
qr@[^.]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^.])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 776
qr@[^\B]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\B])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 777
qr@[^\D]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\D])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 778
qr@[^\H]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\H])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 779
qr@[^\N]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\N])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 780
qr@[^\R]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\R])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 781
qr@[^\S]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\S])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 782
qr@[^\V]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\V])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 783
qr@[^\W]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\W])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 784
qr@[^\b]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\b])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 785
qr@[^\d]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\d])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 786
qr@[^\h]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\h])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 787
qr@[^\s]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\s])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 788
qr@[^\v]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\v])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 789
qr@[^\w]@

END1
qr{\G${mb::_anchor}@{[qr`@{[mb::_cc(qq[^\\w])]}` ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 790
qr/[�A�\�]ABC1-3]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�A�\\�\]ABC1-3])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 791
qr/[^�A�\�]ABC1-3]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�A�\\�\]ABC1-3])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 792
qr/[�A�\�]ABC1-3[:alnum:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�A�\\�\]ABC1-3[:alnum:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 793
qr/[^�A�\�]ABC1-3[:alnum:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�A�\\�\]ABC1-3[:alnum:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 794
qr/[�A�\�]${_}ABC1-3[:alnum:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[�A�\\�\]${_}ABC1-3[:alnum:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 795
qr/[^�A�\�]${_}ABC1-3[:alnum:]]/

END1
qr{\G${mb::_anchor}@{[qr/@{[mb::_cc(qq[^�A�\\�\]${_}ABC1-3[:alnum:]])]}/ ]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 796
qr/Ab�A[�A�\�]ABC1-3]/i

END1
qr{\G${mb::_anchor}@{[mb::_ignorecase(qr/Ab(?:�A)@{[mb::_cc(qq[�A�\\�\]ABC1-3])]}/)]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 797
qr/Ab�A[^�A�\�]ABC1-3]/i

END1
qr{\G${mb::_anchor}@{[mb::_ignorecase(qr/Ab(?:�A)@{[mb::_cc(qq[^�A�\\�\]ABC1-3])]}/)]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 798
qr/Ab�A[�A�\�]ABC1-3[:alnum:]]/i

END1
qr{\G${mb::_anchor}@{[mb::_ignorecase(qr/Ab(?:�A)@{[mb::_cc(qq[�A�\\�\]ABC1-3[:alnum:]])]}/)]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 799
qr/Ab�A[^�A�\�]ABC1-3[:alnum:]]/i

END1
qr{\G${mb::_anchor}@{[mb::_ignorecase(qr/Ab(?:�A)@{[mb::_cc(qq[^�A�\\�\]ABC1-3[:alnum:]])]}/)]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 800
qr/Ab�A[�A�\�]${_}ABC1-3[:alnum:]]/i

END1
qr{\G${mb::_anchor}@{[mb::_ignorecase(qr/Ab(?:�A)@{[mb::_cc(qq[�A�\\�\]${_}ABC1-3[:alnum:]])]}/)]}@{[mb::_m_passed()]}}

END2
    sub { $_=<<'END1'; mb::parse() eq <<'END2'; }, # test no 801
qr/Ab�A[^�A�\�]${_}ABC1-3[:alnum:]]/i

END1
qr{\G${mb::_anchor}@{[mb::_ignorecase(qr/Ab(?:�A)@{[mb::_cc(qq[^�A�\\�\]${_}ABC1-3[:alnum:]])]}/)]}@{[mb::_m_passed()]}}

END2
);

$|=1; print "1..",scalar(@test),"\n"; my $testno=1; sub ok { print $_[0]?'ok ':'not ok ',$testno++,$_[1]?" - $_[1]\n":"\n" } ok($_->()) for @test;

__END__

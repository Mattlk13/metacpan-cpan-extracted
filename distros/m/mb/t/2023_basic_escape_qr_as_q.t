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
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 1
---
qr'�@'
END1
---
qr{\G${mb::_anchor}@{[qr'(?:\x83\x40)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 2
qr'�A'
END1
qr{\G${mb::_anchor}@{[qr'(?:�A)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 3
qr'�B'
END1
qr{\G${mb::_anchor}@{[qr'(?:�B)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 4
qr'�C'
END1
qr{\G${mb::_anchor}@{[qr'(?:�C)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 5
qr'�D'
END1
qr{\G${mb::_anchor}@{[qr'(?:�D)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 6
qr'�E'
END1
qr{\G${mb::_anchor}@{[qr'(?:�E)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 7
qr'�F'
END1
qr{\G${mb::_anchor}@{[qr'(?:�F)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 8
qr'�G'
END1
qr{\G${mb::_anchor}@{[qr'(?:�G)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 9
qr'�H'
END1
qr{\G${mb::_anchor}@{[qr'(?:�H)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 10
qr'�I'
END1
qr{\G${mb::_anchor}@{[qr'(?:�I)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 11
qr'�J'
END1
qr{\G${mb::_anchor}@{[qr'(?:�J)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 12
qr'�K'
END1
qr{\G${mb::_anchor}@{[qr'(?:�K)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 13
qr'�L'
END1
qr{\G${mb::_anchor}@{[qr'(?:�L)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 14
qr'�M'
END1
qr{\G${mb::_anchor}@{[qr'(?:�M)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 15
qr'�N'
END1
qr{\G${mb::_anchor}@{[qr'(?:�N)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 16
qr'�O'
END1
qr{\G${mb::_anchor}@{[qr'(?:�O)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 17
qr'�P'
END1
qr{\G${mb::_anchor}@{[qr'(?:�P)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 18
qr'�Q'
END1
qr{\G${mb::_anchor}@{[qr'(?:�Q)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 19
qr'�R'
END1
qr{\G${mb::_anchor}@{[qr'(?:�R)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 20
qr'�S'
END1
qr{\G${mb::_anchor}@{[qr'(?:�S)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 21
qr'�T'
END1
qr{\G${mb::_anchor}@{[qr'(?:�T)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 22
qr'�U'
END1
qr{\G${mb::_anchor}@{[qr'(?:�U)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 23
qr'�V'
END1
qr{\G${mb::_anchor}@{[qr'(?:�V)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 24
qr'�W'
END1
qr{\G${mb::_anchor}@{[qr'(?:�W)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 25
qr'�X'
END1
qr{\G${mb::_anchor}@{[qr'(?:�X)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 26
qr'�Y'
END1
qr{\G${mb::_anchor}@{[qr'(?:�Y)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 27
qr'�Z'
END1
qr{\G${mb::_anchor}@{[qr'(?:�Z)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 28
qr'�['
END1
qr{\G${mb::_anchor}@{[qr'(?:\x83\x5B)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 29
qr'�\'
END1
qr{\G${mb::_anchor}@{[qr'(?:\x83\x5C)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 30
qr'�]'
END1
qr{\G${mb::_anchor}@{[qr'(?:\x83\x5D)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 31
qr'�^'
END1
qr{\G${mb::_anchor}@{[qr'(?:\x83\x5E)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 32
qr'�_'
END1
qr{\G${mb::_anchor}@{[qr'(?:�_)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 33
qr'�`'
END1
qr{\G${mb::_anchor}@{[qr'(?:\x83\x60)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 34
qr'�a'
END1
qr{\G${mb::_anchor}@{[qr'(?:�a)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 35
qr'�b'
END1
qr{\G${mb::_anchor}@{[qr'(?:�b)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 36
qr'�c'
END1
qr{\G${mb::_anchor}@{[qr'(?:�c)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 37
qr'�d'
END1
qr{\G${mb::_anchor}@{[qr'(?:�d)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 38
qr'�e'
END1
qr{\G${mb::_anchor}@{[qr'(?:�e)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 39
qr'�f'
END1
qr{\G${mb::_anchor}@{[qr'(?:�f)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 40
qr'�g'
END1
qr{\G${mb::_anchor}@{[qr'(?:�g)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 41
qr'�h'
END1
qr{\G${mb::_anchor}@{[qr'(?:�h)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 42
qr'�i'
END1
qr{\G${mb::_anchor}@{[qr'(?:�i)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 43
qr'�j'
END1
qr{\G${mb::_anchor}@{[qr'(?:�j)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 44
qr'�k'
END1
qr{\G${mb::_anchor}@{[qr'(?:�k)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 45
qr'�l'
END1
qr{\G${mb::_anchor}@{[qr'(?:�l)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 46
qr'�m'
END1
qr{\G${mb::_anchor}@{[qr'(?:�m)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 47
qr'�n'
END1
qr{\G${mb::_anchor}@{[qr'(?:�n)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 48
qr'�o'
END1
qr{\G${mb::_anchor}@{[qr'(?:�o)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 49
qr'�p'
END1
qr{\G${mb::_anchor}@{[qr'(?:�p)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 50
qr'�q'
END1
qr{\G${mb::_anchor}@{[qr'(?:�q)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 51
qr'�r'
END1
qr{\G${mb::_anchor}@{[qr'(?:�r)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 52
qr'�s'
END1
qr{\G${mb::_anchor}@{[qr'(?:�s)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 53
qr'�t'
END1
qr{\G${mb::_anchor}@{[qr'(?:�t)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 54
qr'�u'
END1
qr{\G${mb::_anchor}@{[qr'(?:�u)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 55
qr'�v'
END1
qr{\G${mb::_anchor}@{[qr'(?:�v)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 56
qr'�w'
END1
qr{\G${mb::_anchor}@{[qr'(?:�w)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 57
qr'�x'
END1
qr{\G${mb::_anchor}@{[qr'(?:�x)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 58
qr'�y'
END1
qr{\G${mb::_anchor}@{[qr'(?:�y)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 59
qr'�z'
END1
qr{\G${mb::_anchor}@{[qr'(?:�z)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 60
qr'�{'
END1
qr{\G${mb::_anchor}@{[qr'(?:\x83\x7B)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 61
qr'�|'
END1
qr{\G${mb::_anchor}@{[qr'(?:\x83\x7C)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 62
qr'�}'
END1
qr{\G${mb::_anchor}@{[qr'(?:\x83\x7D)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 63
qr'�~'
END1
qr{\G${mb::_anchor}@{[qr'(?:\x83\x7E)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 64
qr'[�@]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:\x83\x40))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 65
qr'[�A]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�A))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 66
qr'[�B]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 67
qr'[�C]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 68
qr'[�D]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 69
qr'[�E]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 70
qr'[�F]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�F))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 71
qr'[�G]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�G))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 72
qr'[�H]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�H))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 73
qr'[�I]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�I))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 74
qr'[�J]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�J))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 75
qr'[�K]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�K))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 76
qr'[�L]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�L))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 77
qr'[�M]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�M))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 78
qr'[�N]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�N))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 79
qr'[�O]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�O))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 80
qr'[�P]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�P))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 81
qr'[�Q]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�Q))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 82
qr'[�R]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�R))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 83
qr'[�S]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�S))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 84
qr'[�T]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�T))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 85
qr'[�U]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�U))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 86
qr'[�V]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�V))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 87
qr'[�W]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�W))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 88
qr'[�X]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�X))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 89
qr'[�Y]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�Y))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 90
qr'[�Z]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�Z))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 91
qr'[�[]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:\x83\x5B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 92
qr'[�\]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:\x83\x5C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 93
qr'[�]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:\x83\x5D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 94
qr'[�^]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:\x83\x5E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 95
qr'[�_]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�_))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 96
qr'[�`]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:\x83\x60))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 97
qr'[�a]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�a))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 98
qr'[�b]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�b))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 99
qr'[�c]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�c))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 100
qr'[�d]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�d))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 101
qr'[�e]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�e))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 102
qr'[�f]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�f))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 103
qr'[�g]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�g))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 104
qr'[�h]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�h))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 105
qr'[�i]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�i))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 106
qr'[�j]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�j))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 107
qr'[�k]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�k))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 108
qr'[�l]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�l))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 109
qr'[�m]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�m))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 110
qr'[�n]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�n))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 111
qr'[�o]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�o))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 112
qr'[�p]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�p))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 113
qr'[�q]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�q))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 114
qr'[�r]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�r))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 115
qr'[�s]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�s))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 116
qr'[�t]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�t))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 117
qr'[�u]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�u))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 118
qr'[�v]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�v))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 119
qr'[�w]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�w))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 120
qr'[�x]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�x))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 121
qr'[�y]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�y))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 122
qr'[�z]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�z))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 123
qr'[�{]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:\x83\x7B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 124
qr'[�|]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:\x83\x7C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 125
qr'[�}]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:\x83\x7D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 126
qr'[�~]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:\x83\x7E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 127
qr'[^�@]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:\x83\x40))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 128
qr'[^�A]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�A))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 129
qr'[^�B]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 130
qr'[^�C]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 131
qr'[^�D]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 132
qr'[^�E]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 133
qr'[^�F]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�F))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 134
qr'[^�G]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�G))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 135
qr'[^�H]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�H))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 136
qr'[^�I]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�I))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 137
qr'[^�J]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�J))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 138
qr'[^�K]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�K))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 139
qr'[^�L]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�L))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 140
qr'[^�M]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�M))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 141
qr'[^�N]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�N))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 142
qr'[^�O]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�O))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 143
qr'[^�P]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�P))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 144
qr'[^�Q]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�Q))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 145
qr'[^�R]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�R))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 146
qr'[^�S]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�S))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 147
qr'[^�T]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�T))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 148
qr'[^�U]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�U))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 149
qr'[^�V]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�V))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 150
qr'[^�W]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�W))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 151
qr'[^�X]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�X))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 152
qr'[^�Y]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�Y))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 153
qr'[^�Z]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�Z))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 154
qr'[^�[]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:\x83\x5B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 155
qr'[^�\]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:\x83\x5C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 156
qr'[^�]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:\x83\x5D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 157
qr'[^�^]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:\x83\x5E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 158
qr'[^�_]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�_))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 159
qr'[^�`]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:\x83\x60))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 160
qr'[^�a]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�a))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 161
qr'[^�b]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�b))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 162
qr'[^�c]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�c))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 163
qr'[^�d]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�d))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 164
qr'[^�e]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�e))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 165
qr'[^�f]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�f))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 166
qr'[^�g]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�g))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 167
qr'[^�h]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�h))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 168
qr'[^�i]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�i))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 169
qr'[^�j]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�j))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 170
qr'[^�k]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�k))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 171
qr'[^�l]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�l))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 172
qr'[^�m]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�m))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 173
qr'[^�n]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�n))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 174
qr'[^�o]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�o))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 175
qr'[^�p]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�p))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 176
qr'[^�q]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�q))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 177
qr'[^�r]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�r))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 178
qr'[^�s]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�s))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 179
qr'[^�t]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�t))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 180
qr'[^�u]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�u))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 181
qr'[^�v]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�v))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 182
qr'[^�w]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�w))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 183
qr'[^�x]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�x))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 184
qr'[^�y]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�y))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 185
qr'[^�z]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�z))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 186
qr'[^�{]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:\x83\x7B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 187
qr'[^�|]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:\x83\x7C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 188
qr'[^�}]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:\x83\x7D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 189
qr'[^�~]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:\x83\x7E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 190
qr'.'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|.)' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 191
qr'\B'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?<![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])|(?<=[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?=[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_]))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 192
qr'\D'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![0123456789])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 193
qr'\H'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 194
qr'\N'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!\n)(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 195
qr'\R'
END1
qr{\G${mb::_anchor}@{[qr'(?>\r\n|[\x0A\x0B\x0C\x0D])' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 196
qr'\S'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![\t\n\f\r\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 197
qr'\V'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![\x0A\x0B\x0C\x0D])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 198
qr'\W'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 199
qr'\b'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?<![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?=[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])|(?<=[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_]))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 200
qr'\d'
END1
qr{\G${mb::_anchor}@{[qr'[0123456789]' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 201
qr'\h'
END1
qr{\G${mb::_anchor}@{[qr'[\x09\x20]' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 202
qr'\s'
END1
qr{\G${mb::_anchor}@{[qr'[\t\n\f\r\x20]' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 203
qr'\v'
END1
qr{\G${mb::_anchor}@{[qr'[\x0A\x0B\x0C\x0D]' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 204
qr'\w'
END1
qr{\G${mb::_anchor}@{[qr'[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_]' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 205
qr'[\b]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x08])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 206
qr'[[:alnum:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 207
qr'[[:alpha:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 208
qr'[[:ascii:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x00-\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 209
qr'[[:blank:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 210
qr'[[:cntrl:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x00-\x1F\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 211
qr'[[:digit:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x30-\x39])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 212
qr'[[:graph:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x21-\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 213
qr'[[:lower:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[abcdefghijklmnopqrstuvwxyz])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 214
qr'[[:print:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x20-\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 215
qr'[[:punct:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x21-\x2F\x3A-\x3F\x40\x5B-\x5F\x60\x7B-\x7E])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 216
qr'[[:space:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\s\x0B])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 217
qr'[[:upper:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[ABCDEFGHIJKLMNOPQRSTUVWXYZ])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 218
qr'[[:word:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x30-\x39\x41-\x5A\x5F\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 219
qr'[[:xdigit:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x30-\x39\x41-\x46\x61-\x66])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 220
qr'[[:^alnum:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 221
qr'[[:^alpha:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 222
qr'[[:^ascii:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x00-\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 223
qr'[[:^blank:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 224
qr'[[:^cntrl:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x00-\x1F\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 225
qr'[[:^digit:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x30-\x39])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 226
qr'[[:^graph:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x21-\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 227
qr'[[:^lower:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![abcdefghijklmnopqrstuvwxyz])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 228
qr'[[:^print:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x20-\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 229
qr'[[:^punct:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x21-\x2F\x3A-\x3F\x40\x5B-\x5F\x60\x7B-\x7E])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 230
qr'[[:^space:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\s\x0B])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 231
qr'[[:^upper:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![ABCDEFGHIJKLMNOPQRSTUVWXYZ])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 232
qr'[[:^word:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x30-\x39\x41-\x5A\x5F\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 233
qr'[[:^xdigit:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x30-\x39\x41-\x46\x61-\x66])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 234
qr'[.]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[.])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 235
qr'[\B]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\B])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 236
qr'[\D]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![0123456789])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 237
qr'[\H]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 238
qr'[\N]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\N])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 239
qr'[\R]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\R])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 240
qr'[\S]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\t\n\f\r\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 241
qr'[\V]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![\x0A\x0B\x0C\x0D])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 242
qr'[\W]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:(?![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 243
qr'[\b]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x08])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 244
qr'[\d]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[0123456789])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 245
qr'[\h]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 246
qr'[\s]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\t\n\f\r\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 247
qr'[\v]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[\x0A\x0B\x0C\x0D])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 248
qr'[\w]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 249
qr'[^.]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![.])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 250
qr'[^\B]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![\B])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 251
qr'[^\D]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:(?![0123456789])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 252
qr'[^\H]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:(?![\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 253
qr'[^\N]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![\N])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 254
qr'[^\R]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![\R])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 255
qr'[^\S]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:(?![\t\n\f\r\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 256
qr'[^\V]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:(?![\x0A\x0B\x0C\x0D])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 257
qr'[^\W]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:(?![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 258
qr'[^\b]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![\x08])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 259
qr'[^\d]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![0123456789])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 260
qr'[^\h]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 261
qr'[^\s]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![\t\n\f\r\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 262
qr'[^\v]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![\x0A\x0B\x0C\x0D])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 263
qr'[^\w]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 264
qr'[�A�\�]ABC1-3]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[ABC1-3])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 265
qr'[^�A�\�]ABC1-3]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[ABC1-3])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 266
qr'[�A�\�]ABC1-3[:alnum:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[ABC1-3\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 267
qr'[^�A�\�]ABC1-3[:alnum:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[ABC1-3\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 268
qr'[�A�\�]${_}ABC1-3[:alnum:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?=(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[${_}ABC1-3\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 269
qr'[^�A�\�]${_}ABC1-3[:alnum:]]'
END1
qr{\G${mb::_anchor}@{[qr'(?:(?!(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[${_}ABC1-3\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 270
qr'Ab�A[�A�\�]ABC1-3]'i
END1
qr{\G${mb::_anchor}@{[mb::_ignorecase(qr'Ab(?:�A)(?:(?=(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[ABC1-3])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))')]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 271
qr'Ab�A[^�A�\�]ABC1-3]'i
END1
qr{\G${mb::_anchor}@{[mb::_ignorecase(qr'Ab(?:�A)(?:(?!(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[ABC1-3])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))')]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 272
qr'Ab�A[�A�\�]ABC1-3[:alnum:]]'i
END1
qr{\G${mb::_anchor}@{[mb::_ignorecase(qr'Ab(?:�A)(?:(?=(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[ABC1-3\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))')]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 273
qr'Ab�A[^�A�\�]ABC1-3[:alnum:]]'i
END1
qr{\G${mb::_anchor}@{[mb::_ignorecase(qr'Ab(?:�A)(?:(?!(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[ABC1-3\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))')]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 274
qr'Ab�A[�A�\�]${_}ABC1-3[:alnum:]]'i
END1
qr{\G${mb::_anchor}@{[mb::_ignorecase(qr'Ab(?:�A)(?:(?=(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[${_}ABC1-3\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))')]}@{[mb::_m_passed()]}}
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 275
qr'Ab�A[^�A�\�]${_}ABC1-3[:alnum:]]'i
END1
qr{\G${mb::_anchor}@{[mb::_ignorecase(qr'Ab(?:�A)(?:(?!(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[${_}ABC1-3\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))')]}@{[mb::_m_passed()]}}
END2
);

$|=1; print "1..",scalar(@test),"\n"; my $testno=1; sub ok { print $_[0]?'ok ':'not ok ',$testno++,$_[1]?" - $_[1]\n":"\n" } ok($_->()) for @test;

sub regexp {
    local($_) = @_;
    if (qr// eq '(?^:)') {
        s{\(\?-xism:}{(?^:}g;
    }
    return $_;
}

__END__

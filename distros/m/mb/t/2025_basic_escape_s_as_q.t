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
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 1
---
s'�@'1'
END1
---
s{(\G${mb::_anchor})@{[qr'(?:\x83\x40)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 2
s'�A'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�A)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 3
s'�B'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�B)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 4
s'�C'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�C)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 5
s'�D'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�D)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 6
s'�E'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�E)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 7
s'�F'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�F)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 8
s'�G'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�G)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 9
s'�H'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�H)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 10
s'�I'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�I)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 11
s'�J'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�J)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 12
s'�K'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�K)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 13
s'�L'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�L)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 14
s'�M'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�M)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 15
s'�N'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�N)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 16
s'�O'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�O)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 17
s'�P'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�P)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 18
s'�Q'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�Q)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 19
s'�R'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�R)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 20
s'�S'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�S)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 21
s'�T'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�T)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 22
s'�U'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�U)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 23
s'�V'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�V)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 24
s'�W'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�W)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 25
s'�X'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�X)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 26
s'�Y'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�Y)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 27
s'�Z'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�Z)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 28
s'�['1'
END1
s{(\G${mb::_anchor})@{[qr'(?:\x83\x5B)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 29
s'�\'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:\x83\x5C)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 30
s'�]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:\x83\x5D)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 31
s'�^'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:\x83\x5E)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 32
s'�_'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�_)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 33
s'�`'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:\x83\x60)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 34
s'�a'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�a)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 35
s'�b'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�b)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 36
s'�c'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�c)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 37
s'�d'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�d)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 38
s'�e'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�e)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 39
s'�f'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�f)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 40
s'�g'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�g)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 41
s'�h'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�h)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 42
s'�i'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�i)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 43
s'�j'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�j)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 44
s'�k'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�k)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 45
s'�l'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�l)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 46
s'�m'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�m)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 47
s'�n'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�n)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 48
s'�o'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�o)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 49
s'�p'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�p)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 50
s'�q'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�q)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 51
s'�r'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�r)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 52
s'�s'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�s)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 53
s'�t'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�t)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 54
s'�u'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�u)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 55
s'�v'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�v)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 56
s'�w'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�w)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 57
s'�x'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�x)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 58
s'�y'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�y)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 59
s'�z'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:�z)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 60
s'�{'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:\x83\x7B)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 61
s'�|'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:\x83\x7C)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 62
s'�}'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:\x83\x7D)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 63
s'�~'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:\x83\x7E)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 64
s'[�@]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:\x83\x40))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 65
s'[�A]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�A))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 66
s'[�B]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 67
s'[�C]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 68
s'[�D]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 69
s'[�E]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 70
s'[�F]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�F))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 71
s'[�G]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�G))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 72
s'[�H]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�H))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 73
s'[�I]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�I))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 74
s'[�J]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�J))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 75
s'[�K]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�K))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 76
s'[�L]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�L))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 77
s'[�M]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�M))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 78
s'[�N]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�N))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 79
s'[�O]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�O))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 80
s'[�P]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�P))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 81
s'[�Q]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�Q))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 82
s'[�R]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�R))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 83
s'[�S]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�S))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 84
s'[�T]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�T))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 85
s'[�U]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�U))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 86
s'[�V]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�V))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 87
s'[�W]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�W))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 88
s'[�X]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�X))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 89
s'[�Y]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�Y))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 90
s'[�Z]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�Z))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 91
s'[�[]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:\x83\x5B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 92
s'[�\]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:\x83\x5C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 93
s'[�]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:\x83\x5D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 94
s'[�^]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:\x83\x5E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 95
s'[�_]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�_))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 96
s'[�`]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:\x83\x60))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 97
s'[�a]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�a))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 98
s'[�b]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�b))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 99
s'[�c]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�c))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 100
s'[�d]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�d))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 101
s'[�e]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�e))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 102
s'[�f]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�f))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 103
s'[�g]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�g))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 104
s'[�h]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�h))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 105
s'[�i]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�i))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 106
s'[�j]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�j))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 107
s'[�k]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�k))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 108
s'[�l]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�l))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 109
s'[�m]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�m))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 110
s'[�n]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�n))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 111
s'[�o]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�o))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 112
s'[�p]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�p))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 113
s'[�q]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�q))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 114
s'[�r]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�r))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 115
s'[�s]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�s))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 116
s'[�t]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�t))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 117
s'[�u]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�u))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 118
s'[�v]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�v))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 119
s'[�w]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�w))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 120
s'[�x]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�x))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 121
s'[�y]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�y))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 122
s'[�z]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�z))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 123
s'[�{]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:\x83\x7B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 124
s'[�|]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:\x83\x7C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 125
s'[�}]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:\x83\x7D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 126
s'[�~]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:\x83\x7E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 127
s'[^�@]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:\x83\x40))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 128
s'[^�A]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�A))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 129
s'[^�B]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 130
s'[^�C]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 131
s'[^�D]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 132
s'[^�E]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 133
s'[^�F]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�F))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 134
s'[^�G]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�G))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 135
s'[^�H]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�H))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 136
s'[^�I]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�I))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 137
s'[^�J]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�J))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 138
s'[^�K]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�K))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 139
s'[^�L]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�L))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 140
s'[^�M]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�M))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 141
s'[^�N]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�N))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 142
s'[^�O]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�O))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 143
s'[^�P]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�P))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 144
s'[^�Q]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�Q))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 145
s'[^�R]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�R))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 146
s'[^�S]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�S))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 147
s'[^�T]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�T))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 148
s'[^�U]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�U))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 149
s'[^�V]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�V))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 150
s'[^�W]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�W))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 151
s'[^�X]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�X))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 152
s'[^�Y]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�Y))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 153
s'[^�Z]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�Z))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 154
s'[^�[]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:\x83\x5B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 155
s'[^�\]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:\x83\x5C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 156
s'[^�]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:\x83\x5D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 157
s'[^�^]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:\x83\x5E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 158
s'[^�_]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�_))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 159
s'[^�`]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:\x83\x60))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 160
s'[^�a]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�a))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 161
s'[^�b]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�b))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 162
s'[^�c]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�c))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 163
s'[^�d]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�d))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 164
s'[^�e]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�e))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 165
s'[^�f]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�f))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 166
s'[^�g]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�g))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 167
s'[^�h]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�h))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 168
s'[^�i]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�i))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 169
s'[^�j]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�j))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 170
s'[^�k]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�k))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 171
s'[^�l]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�l))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 172
s'[^�m]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�m))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 173
s'[^�n]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�n))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 174
s'[^�o]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�o))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 175
s'[^�p]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�p))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 176
s'[^�q]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�q))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 177
s'[^�r]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�r))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 178
s'[^�s]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�s))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 179
s'[^�t]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�t))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 180
s'[^�u]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�u))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 181
s'[^�v]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�v))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 182
s'[^�w]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�w))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 183
s'[^�x]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�x))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 184
s'[^�y]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�y))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 185
s'[^�z]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�z))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 186
s'[^�{]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:\x83\x7B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 187
s'[^�|]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:\x83\x7C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 188
s'[^�}]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:\x83\x7D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 189
s'[^�~]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:\x83\x7E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 190
s'.'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|.)' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 191
s'\B'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?<![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])|(?<=[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?=[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_]))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 192
s'\D'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![0123456789])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 193
s'\H'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 194
s'\N'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!\n)(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 195
s'\R'1'
END1
s{(\G${mb::_anchor})@{[qr'(?>\r\n|[\x0A\x0B\x0C\x0D])' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 196
s'\S'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![\t\n\f\r\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 197
s'\V'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![\x0A\x0B\x0C\x0D])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 198
s'\W'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 199
s'\b'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?<![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?=[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])|(?<=[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_]))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 200
s'\d'1'
END1
s{(\G${mb::_anchor})@{[qr'[0123456789]' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 201
s'\h'1'
END1
s{(\G${mb::_anchor})@{[qr'[\x09\x20]' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 202
s'\s'1'
END1
s{(\G${mb::_anchor})@{[qr'[\t\n\f\r\x20]' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 203
s'\v'1'
END1
s{(\G${mb::_anchor})@{[qr'[\x0A\x0B\x0C\x0D]' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 204
s'\w'1'
END1
s{(\G${mb::_anchor})@{[qr'[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_]' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 205
s'[\b]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x08])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 206
s'[[:alnum:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 207
s'[[:alpha:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 208
s'[[:ascii:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x00-\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 209
s'[[:blank:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 210
s'[[:cntrl:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x00-\x1F\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 211
s'[[:digit:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x30-\x39])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 212
s'[[:graph:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x21-\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 213
s'[[:lower:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[abcdefghijklmnopqrstuvwxyz])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 214
s'[[:print:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x20-\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 215
s'[[:punct:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x21-\x2F\x3A-\x3F\x40\x5B-\x5F\x60\x7B-\x7E])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 216
s'[[:space:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\s\x0B])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 217
s'[[:upper:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[ABCDEFGHIJKLMNOPQRSTUVWXYZ])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 218
s'[[:word:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x30-\x39\x41-\x5A\x5F\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 219
s'[[:xdigit:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x30-\x39\x41-\x46\x61-\x66])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 220
s'[[:^alnum:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 221
s'[[:^alpha:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 222
s'[[:^ascii:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x00-\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 223
s'[[:^blank:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 224
s'[[:^cntrl:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x00-\x1F\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 225
s'[[:^digit:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x30-\x39])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 226
s'[[:^graph:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x21-\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 227
s'[[:^lower:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![abcdefghijklmnopqrstuvwxyz])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 228
s'[[:^print:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x20-\x7F])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 229
s'[[:^punct:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x21-\x2F\x3A-\x3F\x40\x5B-\x5F\x60\x7B-\x7E])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 230
s'[[:^space:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\s\x0B])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 231
s'[[:^upper:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![ABCDEFGHIJKLMNOPQRSTUVWXYZ])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 232
s'[[:^word:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x30-\x39\x41-\x5A\x5F\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 233
s'[[:^xdigit:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x30-\x39\x41-\x46\x61-\x66])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 234
s'[.]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[.])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 235
s'[\B]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\B])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 236
s'[\D]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![0123456789])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 237
s'[\H]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 238
s'[\N]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\N])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 239
s'[\R]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\R])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 240
s'[\S]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\t\n\f\r\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 241
s'[\V]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![\x0A\x0B\x0C\x0D])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 242
s'[\W]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:(?![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 243
s'[\b]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x08])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 244
s'[\d]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[0123456789])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 245
s'[\h]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 246
s'[\s]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\t\n\f\r\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 247
s'[\v]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[\x0A\x0B\x0C\x0D])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 248
s'[\w]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 249
s'[^.]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![.])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 250
s'[^\B]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![\B])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 251
s'[^\D]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:(?![0123456789])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 252
s'[^\H]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:(?![\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 253
s'[^\N]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![\N])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 254
s'[^\R]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![\R])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 255
s'[^\S]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:(?![\t\n\f\r\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 256
s'[^\V]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:(?![\x0A\x0B\x0C\x0D])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 257
s'[^\W]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:(?![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 258
s'[^\b]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![\x08])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 259
s'[^\d]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![0123456789])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 260
s'[^\h]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![\x09\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 261
s'[^\s]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![\t\n\f\r\x20])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 262
s'[^\v]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![\x0A\x0B\x0C\x0D])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 263
s'[^\w]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?![ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 264
s'[�A�\�]ABC1-3]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[\x31-\x33]|[ABC])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 265
s'[^�A�\�]ABC1-3]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[\x31-\x33]|[ABC])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 266
s'[�A�\�]ABC1-3[:alnum:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[\x31-\x33]|[ABC\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 267
s'[^�A�\�]ABC1-3[:alnum:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[\x31-\x33]|[ABC\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 268
s'[�A�\�]${_}ABC1-3[:alnum:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?=(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[\x31-\x33]|[${_}ABC\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 269
s'[^�A�\�]${_}ABC1-3[:alnum:]]'1'
END1
s{(\G${mb::_anchor})@{[qr'(?:(?!(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[\x31-\x33]|[${_}ABC\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))' ]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 270
s'Ab�A[�A�\�]ABC1-3]'1'i
END1
s{(\G${mb::_anchor})@{[mb::_ignorecase(qr'Ab(?:�A)(?:(?=(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[\x31-\x33]|[ABC])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))')]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 271
s'Ab�A[^�A�\�]ABC1-3]'1'i
END1
s{(\G${mb::_anchor})@{[mb::_ignorecase(qr'Ab(?:�A)(?:(?!(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[\x31-\x33]|[ABC])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))')]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 272
s'Ab�A[�A�\�]ABC1-3[:alnum:]]'1'i
END1
s{(\G${mb::_anchor})@{[mb::_ignorecase(qr'Ab(?:�A)(?:(?=(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[\x31-\x33]|[ABC\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))')]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 273
s'Ab�A[^�A�\�]ABC1-3[:alnum:]]'1'i
END1
s{(\G${mb::_anchor})@{[mb::_ignorecase(qr'Ab(?:�A)(?:(?!(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[\x31-\x33]|[ABC\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))')]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 274
s'Ab�A[�A�\�]${_}ABC1-3[:alnum:]]'1'i
END1
s{(\G${mb::_anchor})@{[mb::_ignorecase(qr'Ab(?:�A)(?:(?=(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[\x31-\x33]|[${_}ABC\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))')]}@{[mb::_s_passed()]}}{$1 . '1'}e
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 275
s'Ab�A[^�A�\�]${_}ABC1-3[:alnum:]]'1'i
END1
s{(\G${mb::_anchor})@{[mb::_ignorecase(qr'Ab(?:�A)(?:(?!(?:�A)|(?:\x83\x5C)|(?:\x83\x5D)|[\x31-\x33]|[${_}ABC\x30-\x39\x41-\x5A\x61-\x7A])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F])))')]}@{[mb::_s_passed()]}}{$1 . '1'}e
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

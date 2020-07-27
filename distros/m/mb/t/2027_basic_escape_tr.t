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
tr'�@'1'
END1
---
s{(\G${mb::_anchor})((?:(?=(?:\x83\x40))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�@',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 2
tr'�A'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�A))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�A',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 3
tr'�B'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�B',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 4
tr'�C'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�C',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 5
tr'�D'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�D',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 6
tr'�E'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�E',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 7
tr'�F'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�F))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�F',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 8
tr'�G'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�G))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�G',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 9
tr'�H'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�H))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�H',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 10
tr'�I'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�I))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�I',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 11
tr'�J'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�J))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�J',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 12
tr'�K'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�K))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�K',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 13
tr'�L'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�L))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�L',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 14
tr'�M'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�M))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�M',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 15
tr'�N'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�N))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�N',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 16
tr'�O'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�O))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�O',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 17
tr'�P'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�P))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�P',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 18
tr'�Q'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�Q))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�Q',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 19
tr'�R'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�R))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�R',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 20
tr'�S'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�S))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�S',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 21
tr'�T'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�T))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�T',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 22
tr'�U'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�U))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�U',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 23
tr'�V'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�V))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�V',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 24
tr'�W'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�W))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�W',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 25
tr'�X'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�X))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�X',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 26
tr'�Y'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�Y))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�Y',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 27
tr'�Z'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�Z))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�Z',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 28
tr'�['1'
END1
s{(\G${mb::_anchor})((?:(?=(?:\x83\x5B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�[',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 29
tr'�\'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:\x83\x5C)|[\])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�\\',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 30
tr'�]'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:\x83\x5D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�]',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 31
tr'�^'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:\x83\x5E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�^',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 32
tr'�_'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�_))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�_',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 33
tr'�`'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:\x83\x60))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�`',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 34
tr'�a'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�a))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�a',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 35
tr'�b'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�b))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�b',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 36
tr'�c'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�c))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�c',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 37
tr'�d'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�d))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�d',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 38
tr'�e'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�e))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�e',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 39
tr'�f'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�f))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�f',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 40
tr'�g'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�g))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�g',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 41
tr'�h'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�h))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�h',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 42
tr'�i'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�i))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�i',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 43
tr'�j'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�j))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�j',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 44
tr'�k'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�k))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�k',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 45
tr'�l'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�l))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�l',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 46
tr'�m'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�m))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�m',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 47
tr'�n'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�n))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�n',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 48
tr'�o'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�o))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�o',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 49
tr'�p'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�p))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�p',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 50
tr'�q'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�q))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�q',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 51
tr'�r'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�r))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�r',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 52
tr'�s'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�s))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�s',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 53
tr'�t'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�t))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�t',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 54
tr'�u'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�u))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�u',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 55
tr'�v'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�v))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�v',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 56
tr'�w'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�w))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�w',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 57
tr'�x'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�x))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�x',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 58
tr'�y'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�y))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�y',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 59
tr'�z'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:�z))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�z',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 60
tr'�{'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:\x83\x7B))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�{',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 61
tr'�|'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:\x83\x7C))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�|',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 62
tr'�}'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:\x83\x7D))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�}',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 63
tr'�~'1'
END1
s{(\G${mb::_anchor})((?:(?=(?:\x83\x7E))(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))}{$1.mb::tr($2,q'�~',q'1','r')}eg
END2
    sub { $_=<<'END1'; mb::parse() eq regexp(<<'END2'); }, # test no 64
tr # comment 1-1
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
{(\G${mb::_anchor})((?:(?=[search])(?-xism:(?>(?>[\x81-\x9F\xE0-\xFC][\x00-\xFF]|[\x80-\xFF])|[\x00-\x7F]))))} # comment 2-1
# comment 2-2
  # comment 2-3
{$1.mb::tr($2,q{search},q{replacement},'r')}eg # comment 3-1
# comment 3-2
  # comment 3-3
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

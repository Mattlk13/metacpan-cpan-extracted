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
    sub { mb::eval(<<'END1'); }, # test no 1
'1234567890' =~ /3/
END1
    sub { mb::eval(<<'END1'); }, # test no 2
'1234567890' !~ /A/
END1
    sub { CORE::eval(<<'END1'); }, # test no 3
'�A�C�E�G�I' =~ /E/
END1
    sub { mb::eval(<<'END1'); }, # test no 4
'�A�C�E�G�I' !~ /E/
END1
    sub { mb::eval(<<'END1'); }, # test no 5
'�A�C�E�G�I' =~ /�E/
END1
    sub { mb::eval(<<'END1'); }, # test no 6
'�A�C�E�G�I' !~ /�J/
END1
    sub { mb::eval(<<'END1'); }, # test no 7
'1234567890' =~ m/3/
END1
    sub { mb::eval(<<'END1'); }, # test no 8
'1234567890' !~ m/A/
END1
    sub { CORE::eval(<<'END1'); }, # test no 9
'�A�C�E�G�I' =~ m/E/
END1
    sub { mb::eval(<<'END1'); }, # test no 10
'�A�C�E�G�I' !~ m/E/
END1
    sub { mb::eval(<<'END1'); }, # test no 11
'�A�C�E�G�I' =~ m/�E/
END1
    sub { mb::eval(<<'END1'); }, # test no 12
'�A�C�E�G�I' !~ m/�J/
END1
    sub { mb::eval(<<'END1'); }, # test no 13
'1234567890' =~ qr/3/
END1
    sub { mb::eval(<<'END1'); }, # test no 14
'1234567890' !~ qr/A/
END1
    sub { CORE::eval(<<'END1'); }, # test no 15
'�A�C�E�G�I' =~ qr/E/
END1
    sub { mb::eval(<<'END1'); }, # test no 16
'�A�C�E�G�I' !~ qr/E/
END1
    sub { mb::eval(<<'END1'); }, # test no 17
'�A�C�E�G�I' =~ qr/�E/
END1
    sub { mb::eval(<<'END1'); }, # test no 18
'�A�C�E�G�I' !~ qr/�J/
END1
    sub { mb::eval(<<'END1'); }, # test no 19
$_='1234567890'; s/3/1/; $_ eq '1214567890';
END1
    sub { mb::eval(<<'END1'); }, # test no 20
$_='1234567890'; s/A/1/; $_ eq '1234567890';
END1
    sub { CORE::eval(<<'END1'); }, # test no 21
$_='�A�C�E�G�I'; s/E/1/; $_ ne '�A�C�E�G�I';
END1
    sub { mb::eval(<<'END1'); }, # test no 22
$_='�A�C�E�G�I'; s/E/1/; $_ eq '�A�C�E�G�I';
END1
    sub { mb::eval(<<'END1'); }, # test no 23
$_='�A�C�E�G�I'; s/�E/1/; $_ eq '�A�C1�G�I';
END1
    sub { mb::eval(<<'END1'); }, # test no 24
$_='�A�C�E�G�I'; s/�J/1/; $_ eq '�A�C�E�G�I';
END1
    sub { mb::eval(<<'END1'); }, # test no 25
$_='�AA�C�EA�GA�I'; @_=split(/A/); "@_" eq '�A �C�E �G �I';
END1
    sub { mb::eval(<<'END1'); }, # test no 26
'1234567890' =~ m'3'
END1
    sub { mb::eval(<<'END1'); }, # test no 27
'1234567890' !~ m'A'
END1
    sub { CORE::eval(<<'END1'); }, # test no 28
'�A�C�E�G�I' =~ m'E'
END1
    sub { mb::eval(<<'END1'); }, # test no 29
'�A�C�E�G�I' !~ m'E'
END1
    sub { mb::eval(<<'END1'); }, # test no 30
'�A�C�E�G�I' =~ m'�E'
END1
    sub { mb::eval(<<'END1'); }, # test no 31
'�A�C�E�G�I' !~ m'�J'
END1
    sub { mb::eval(<<'END1'); }, # test no 32
'1234567890' =~ qr'3'
END1
    sub { mb::eval(<<'END1'); }, # test no 33
'1234567890' !~ qr'A'
END1
    sub { CORE::eval(<<'END1'); }, # test no 34
'�A�C�E�G�I' =~ qr'E'
END1
    sub { mb::eval(<<'END1'); }, # test no 35
'�A�C�E�G�I' !~ qr'E'
END1
    sub { mb::eval(<<'END1'); }, # test no 36
'�A�C�E�G�I' =~ qr'�E'
END1
    sub { mb::eval(<<'END1'); }, # test no 37
'�A�C�E�G�I' !~ qr'�J'
END1
    sub { mb::eval(<<'END1'); }, # test no 38
$_='1234567890'; s'3'1'; $_ eq '1214567890';
END1
    sub { mb::eval(<<'END1'); }, # test no 39
$_='1234567890'; s'A'1'; $_ eq '1234567890';
END1
    sub { CORE::eval(<<'END1'); }, # test no 40
$_='�A�C�E�G�I'; s'E'1'; $_ ne '�A�C�E�G�I';
END1
    sub { mb::eval(<<'END1'); }, # test no 41
$_='�A�C�E�G�I'; s'E'1'; $_ eq '�A�C�E�G�I';
END1
    sub { mb::eval(<<'END1'); }, # test no 42
$_='�A�C�E�G�I'; s'�E'1'; $_ eq '�A�C1�G�I';
END1
    sub { mb::eval(<<'END1'); }, # test no 43
$_='�A�C�E�G�I'; s'�J'1'; $_ eq '�A�C�E�G�I';
END1
    sub { mb::eval(<<'END1'); }, # test no 44
$_='�AA�C�EA�GA�I'; @_=split('A'); "@_" eq '�A �C�E �G �I';
END1
);

$|=1; print "1..",scalar(@test),"\n"; my $testno=1; sub ok { print $_[0]?'ok ':'not ok ',$testno++,$_[1]?" - $_[1]\n":"\n" } ok($_->()) for @test;

__END__

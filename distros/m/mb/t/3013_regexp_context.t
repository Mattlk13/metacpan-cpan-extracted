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
    sub { eval(<<'END1'); }, # test no 1
1;
END1
    sub { mb::eval(<<'END1'); }, # test no 2
1;
END1
    sub { mb::eval(<<'END1'); }, # test no 3
'A' =~ /A/;
END1
    sub { mb::eval(<<'END1'); }, # test no 4
@_ = 'ABC' =~ /(A)(B)(C)/; "@_" eq 'A B C';
END1
    sub { mb::eval(<<'END1'); }, # test no 5
@_ = 'ABCABCABC' =~ /(A)(B)(C)/; "@_" eq 'A B C';
END1
    sub { mb::eval(<<'END1'); }, # test no 6
@_ = 'ABCABCABC' =~ /(A)(B)(C)/g; "@_" eq 'A B C A B C A B C';
END1
    sub { mb::eval(<<'END1'); }, # test no 7
@_ = '�A�C�E�A�C�E�A�C�E' =~ /(�A)(�C)(�E)/g; "@_" eq '�A �C �E �A �C �E �A �C �E';
END1
    sub { mb::eval(<<'END1'); }, # test no 8
@_ = '�A�C�E�A�C�E�A�C�E' =~ /((�E)(�A)(�C))/; $` eq '�A�C';
END1
    sub { mb::eval(<<'END1'); }, # test no 9
@_ = '�A�C�E�A�C�E�A�C�E' =~ /((�E)(�A)(�C))/; $& eq '�E�A�C';
END1
    sub { mb::eval(<<'END1'); }, # test no 10
@_ = '�A�C�E�A�C�E�A�C�E' =~ /((�E)(�A)(�C))/; $' eq '�E�A�C�E';
END1
    sub { mb::eval(<<'END1'); }, # test no 11
@_ = '�A�C�E�A�C�E�A�C�E' =~ /((�E)(�A)(�C))/; $1 eq '�E�A�C';
END1
    sub { mb::eval(<<'END1'); }, # test no 12
@_ = '�A�C�E�A�C�E�A�C�E' =~ /((�E)(�A)(�C))/; $2 eq '�E';
END1
    sub { mb::eval(<<'END1'); }, # test no 13
@_ = '�A�C�E�A�C�E�A�C�E' =~ /((�E)(�A)(�C))/; $3 eq '�A';
END1
    sub { mb::eval(<<'END1'); }, # test no 14
@_ = '�A�C�E�A�C�E�A�C�E' =~ /((�E)(�A)(�C))/; $4 eq '�C';
END1
    sub { mb::eval(<<'END1'); }, # test no 15
$_='A'; s/A//;
END1
    sub { mb::eval(<<'END1'); }, # test no 16
$_='ABC'; s/(A)(B)(C)//; "($1)($2)($3)" eq '(A)(B)(C)';
END1
    sub { mb::eval(<<'END1'); }, # test no 17
$_='ABCABCABC'; s/(A)(B)(C)//; "($1)($2)($3)" eq '(A)(B)(C)';
END1
    sub { mb::eval(<<'END1'); }, # test no 18
$_='ABCDEFGHI'; s/(.)(.)(.)//g; "($1)($2)($3)" eq '(G)(H)(I)';
END1
    sub { mb::eval(<<'END1'); }, # test no 19
$_='�A�C�E�G�I�J�L�N�P�R'; s/(.)(.)(.)//g; "($1)($2)($3)" eq '(�L)(�N)(�P)';
END1
    sub { mb::eval(<<'END1'); }, # test no 20
$_='�A�C�E�A�C�E�A�C�E'; s/((�E)(�A)(�C))//; $` eq '�A�C';
END1
    sub { mb::eval(<<'END1'); }, # test no 21
$_='�A�C�E�A�C�E�A�C�E'; s/((�E)(�A)(�C))//; $& eq '�E�A�C';
END1
    sub { mb::eval(<<'END1'); }, # test no 22
$_='�A�C�E�A�C�E�A�C�E'; s/((�E)(�A)(�C))//; $' eq '�E�A�C�E';
END1
    sub { mb::eval(<<'END1'); }, # test no 23
$_='�A�C�E�A�C�E�A�C�E'; s/((�E)(�A)(�C))//; $1 eq '�E�A�C';
END1
    sub { mb::eval(<<'END1'); }, # test no 24
$_='�A�C�E�A�C�E�A�C�E'; s/((�E)(�A)(�C))//; $2 eq '�E';
END1
    sub { mb::eval(<<'END1'); }, # test no 25
$_='�A�C�E�A�C�E�A�C�E'; s/((�E)(�A)(�C))//; $3 eq '�A';
END1
    sub { mb::eval(<<'END1'); }, # test no 26
$_='�A�C�E�A�C�E�A�C�E'; s/((�E)(�A)(�C))//; $4 eq '�C';
END1
);

$|=1; print "1..",scalar(@test),"\n"; my $testno=1; sub ok { print $_[0]?'ok ':'not ok ',$testno++,$_[1]?" - $_[1]\n":"\n" } ok($_->()) for @test;

__END__

#!/usr/bin/perl

use Lingua::Numending;
use Test::More tests => 1;

use Lingua::Numending qw(cyr_units);
$num = cyr_units(200, "������ ����� �����");
is( $num, '200 ������',   'Return name can be "200 ������"' );

#!/usr/bin/perl 

use strict;
use warnings;

use Test::More;
use Test::UseAllModules under => qw(lib/STUN);

BEGIN {
	all_uses_ok();
}

diag("Testing all used modules");

1;


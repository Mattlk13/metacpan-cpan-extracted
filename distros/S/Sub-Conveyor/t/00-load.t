#!perl
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Sub::Conveyor' ) || print "Bail out!\n";
}

diag( "Testing Sub::Conveyor $Sub::Conveyor::VERSION, Perl $], $^X" );

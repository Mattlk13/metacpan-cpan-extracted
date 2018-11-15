#!/usr/bin/env perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer $i = 0;
TESTWHILELOOP:
while ( $i < 7 ) {
    $i++;
    if ( $i == 3 ) {
        next TESTWHILELOOP;
    }
    print 'Production rule Loop matched by LoopWhile, iteration item ', $i,
        "\n";
}

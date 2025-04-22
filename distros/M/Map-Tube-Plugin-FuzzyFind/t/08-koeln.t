#!perl
use 5.012;
use strict;
use warnings FATAL => 'all';
use Test::More 0.82;
use lib 't/';
use Sample;

eval 'use Text::Phonetic::Koeln';
plan skip_all => 'Text::Phonetic::Phonix required for this test' if $@;

plan tests => 15;

sub a2n { return [ map { $_->name( ) } @{ $_[0] } ]; }

my $tube = new_ok( 'Sample' );
my $ret;

$ret = $tube->fuzzy_find( 'Bakerloo', objects => 'lines', method => 'koeln' );
is( $ret, 'Bakerloo', 'Finding line Bakerloo based on K�ln phonetics' );

$ret = $tube->fuzzy_find( 'Bkrl', objects => 'lines', method => 'koeln' );
is( $ret, 'Bakerloo', 'Finding line Bkrl based on K�ln phonetics' );

$ret = $tube->fuzzy_find( 'Bxqxq', objects => 'lines', method => 'koeln' );
is( $ret, undef, 'Finding line Bxqxq based on K�ln phonetics should fail' );

$ret = [ $tube->fuzzy_find( 'Bakerloo', objects => 'lines', method => 'koeln' ) ];
is_deeply( $ret, [ 'Bakerloo' ], 'Finding many lines Bakerloo based on K�ln phonetics' );

$ret = [ $tube->fuzzy_find( 'Bkrl', objects => 'lines', method => 'koeln' ) ];
is_deeply( $ret, [ 'Bakerloo' ], 'Finding many lines Bkrl based on K�ln phonetics' );

$ret = [ $tube->fuzzy_find( 'Bxqxq', objects => 'lines', method => 'koeln' ) ];
is_deeply( $ret, [ ], 'Finding many lines Bxqxq based on K�ln phonetics should fail' );

$ret = $tube->fuzzy_find( 'Baker Street', objects => 'stations', method => 'koeln' );
ok( $ret, 'Finding station Baker Street based on K�ln phonetics' );
is( $ret->name(), 'Baker Street', 'Finding station Baker Street based on K�ln phonetics' );

$ret = $tube->fuzzy_find( 'B�ckerstraat', objects => 'stations', method => 'koeln' );
ok( $ret, 'Finding station B�ckerstraat based on K�ln phonetics' );
is( $ret->name(), 'Baker Street', 'Finding station B�ckerstraat based on K�ln phonetics' );

$ret = $tube->fuzzy_find( 'Pxqxq', objects => 'stations', method => 'koeln' );
is( $ret, undef, 'Finding station Pxqxq based on K�ln phonetics should fail' );

$ret = [ $tube->fuzzy_find( 'Baker Street', objects => 'stations', method => 'koeln' ) ];
is_deeply( a2n($ret), [ 'Baker Street' ], 'Finding many stations Baker Street based on K�ln phonetics' );

$ret = [ $tube->fuzzy_find( 'B�ckerstraat', objects => 'stations', method => 'koeln' ) ];
is_deeply( a2n($ret), [ 'Baker Street' ], 'Finding many stations B�ckerstraat based on K�ln phonetics' );

$ret = [ $tube->fuzzy_find( 'Pxqxq', objects => 'stations', method => 'koeln' ) ];
is_deeply( $ret, [ ], 'Finding many stations Pxqxq based on K�ln phonetics should fail' );


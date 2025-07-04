#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '1' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use types;
our $VERSION = 0.002_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use Perl::Types::Test::TypeCheckingOn::AllTypes;

# [[[ OPERATIONS ]]]

my Perl::Types::Test::TypeCheckingOn::AllTypes $alltypes_object = Perl::Types::Test::TypeCheckingOn::AllTypes->new();
$alltypes_object->check_class();
$alltypes_object->check_class_integer(23);

check_integer(0);
check_integer(1);
check_integer(555_555);
check_integer(-1);
check_integer(-555_555);

check_number(0);
check_number(1);
check_number(555_555);
check_number(-1);
check_number(-555_555);
check_number(0.123_456);
check_number(1.123_456);
check_number(555_555.123_456);
check_number(-1.123_456);
check_number(-555_555.123_456);

check_string(q{});
check_string('0');
check_string('a');
check_string('0123abcd');
check_string(q{0123abcd});
check_string('0123abcd\\n');
check_string(q{0123abcd\\n});
check_string("0123abcd\n");
check_string('0123$abcd');
check_string(q{0123$abcd});

check_arrayref( [] );
check_arrayref( [0] );
check_arrayref( [0.123] );
check_arrayref( ['abcd'] );
check_arrayref( [ 0, 0, 0 ] );
check_arrayref( [ 0.123, 0.123, 0.123 ] );
check_arrayref( [ 'abcd', 'abcd', 'abcd' ] );
check_arrayref( [ 0, -0.123_456, 'abcd' ] );
check_arrayref( [   0, -0.123_456, 'abcd', [ 2, 4, 6, 8 ], { a => 'hello', b => 'howdy', c => 'ahoy' } ] );

check_arrayref_integer( [] );
check_arrayref_integer( [0] );
check_arrayref_integer( [ 0, 1, 2, 3 ] );
check_arrayref_integer( [ -999_999, 0, 1, 2, 3 ] );

check_arrayref_number( [] );
check_arrayref_number( [0] );
check_arrayref_number( [ 0, 1, 2, 3 ] );
check_arrayref_number( [ -999_999, 0, 1, 2, 3 ] );
check_arrayref_number( [0.123] );
check_arrayref_number( [ 0.123, 1.123, 2.123, 3.123 ] );
check_arrayref_number( [ -999_999.123_456, 0.123, 1, 2, 3 ] );

my arrayref::number $input_1 = [ -999_999, 0.0,  0.0,  0.0 ];
my arrayref::number $input_2 = [ -999_999, 3.0,  4.0,  12.0 ];
my arrayref::number $input_3 = [ -999_999, 23.0, 42.0, 2_112.0 ];
check_arrayref_number_multiple( $input_1, $input_2, $input_3 );

check_arrayref_string( [] );
check_arrayref_string( ['0'] );
check_arrayref_string( [ '0', 'a', '0123abcd' ] );
check_arrayref_string( [ '0', 'a', '0123abcd', q{0}, q{a}, q{0123abcd} ] );
check_arrayref_string( [ '0\\n', '$a', '0123$abcd', q{0}, q{a\\n}, q{0123abcd\\n} ] );
check_arrayref_string( [ "0\n", "a\n", "0123abcd\n" ] );

check_hashref( {} );
check_hashref( { a => 0 } );
check_hashref( { a => 0.123 } );
check_hashref( { a => 'abcd' } );
check_hashref( { a => 0, b => 0, c => 0 } );
check_hashref( { a => 0.123, b => 0.123, c => 0.123 } );
check_hashref( { a => 'abcd', b => 'abcd', c => 'abcd' } );
check_hashref( {   a => 0, b => -0.123_456, c => 'abcd', d => [ 2, 4, 6, 8 ], e => { a => 'hello', b => 'howdy', c => 'ahoy' } } );
check_hashref_integer( {} );
check_hashref_integer( { a => 0 } );
check_hashref_integer( { a => 0, b => 1, c => 2, d => 3 } );
check_hashref_integer( { aa => -999_999, a => 0, b => 1, c => 2, d => 3 } );

check_hashref_number( {} );
check_hashref_number( { a => 0 } );
check_hashref_number( { a => 0, b => 1, c => 2, d => 3 } );
check_hashref_number( { aa => -999_999, a => 0, b => 1, c => 2, d => 3 } );
check_hashref_number( { a => 0.123 } );
check_hashref_number( { a => 0.123, b => 1.123, c => 2.123, d => 3.123 } );
check_hashref_number( { aa => -999_999.123_456, a => 0.123, b => 1, c => 2, d => 3 } );

my hashref::number $input_4 = { a => -999_999, b => 0.0, c => 0.0, d => 0.0 };
my hashref::number $input_5 = { a => -999_999, b => 3.0, c => 4.0, d => 12.0 };
my hashref::number $input_6 = { a => -999_999, b => 23.0, c => 42.0, d => 2_112.0 };
check_hashref_number_multiple( $input_4, $input_5, $input_6 );

check_hashref_string( {} );
check_hashref_string( { a => '0' } );
check_hashref_string( { a => '0', b => 'a', c => '0123abcd' } );
check_hashref_string( {   a => '0', b => 'a', c => '0123abcd', d => q{0}, e => q{a}, f => q{0123abcd} } );
check_hashref_string( {   a => '0\\n', b => '$a', c => '0123$abcd', d => q{0}, e => q{a\\n}, f => q{0123abcd\\n} } );
check_hashref_string( {   a => "0\n", b => "a\n", c => "0123abcd\n" });

print "1\n";

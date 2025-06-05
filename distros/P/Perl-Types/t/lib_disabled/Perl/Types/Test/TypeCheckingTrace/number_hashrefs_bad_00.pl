#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'ERROR EHVRVNV03, TYPE-CHECKING MISMATCH' >>>
# <<< EXECUTE_ERROR: "number value expected but non-number value found at key 'd'" >>>
# <<< EXECUTE_ERROR: 'in variable $input_1 from subroutine check_hashref_number_multiple()' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use types;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use Perl::Types::Test::TypeCheckingTrace::AllTypes;

# [[[ OPERATIONS ]]]
my hashref::number $input_1
    = { a => -999_999, b => 3.0, c => 4.0, d => 'howdy' };
my hashref::number $input_2
    = { a => -999_999, b => 3.0, c => 4.0, d => -12.0 };
my hashref::number $input_3
    = { a => -999_999.123_456, b => 23.0, c => 42.0, d => -2112.0 };
check_hashref_number_multiple( $input_1, $input_2, $input_3 );

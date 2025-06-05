#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_ERROR: 'ERROR EAVRV01, TYPE-CHECKING MISMATCH' >>>
# <<< EXECUTE_ERROR: 'arrayref value expected but non-arrayref value found' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use types;
our $VERSION = 0.000_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use Perl::Types::Test::TypeCheckingOn::AllTypes;

# [[[ OPERATIONS ]]]
check_arrayref(0);

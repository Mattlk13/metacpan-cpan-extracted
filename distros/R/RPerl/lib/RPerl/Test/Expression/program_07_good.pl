#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '161.7' >>>
# <<< EXECUTE_SUCCESS: '295.4' >>>
# <<< EXECUTE_SUCCESS: '516.6' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;

# [[[ OPERATIONS ]]]
print Dumper( RPerl::Test::Foo::ylprag( 7, [ 23.1, 42.2, 73.8 ] ) );

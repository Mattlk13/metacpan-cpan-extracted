#!/usr/bin/env perl

# Learning RPerl, Section 4.3.1: C<return> Operator

# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: "error: cannot convert ‘std::__cxx11::basic_string<char>’ to ‘integer {aka long int}’ in return" >>>
# <<< COMPILE_ERROR: 'ERROR ECOCOSU04' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ SUBROUTINES ]]]
sub unpredictable { { my integer $RETURN_TYPE }; return 'howdy' . 'doody'; }

# [[[ OPERATIONS ]]]
print 'have unpredictable() = ', unpredictable(), "\n";

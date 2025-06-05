#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '46' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use types;
our $VERSION = 0.000_010;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use Perl::Types::Test::Properties::Class_00_Good;

# [[[ OPERATIONS ]]]
# do not set object property ourself, just let test_method() do it for us
my Perl::Types::Test::Properties::Class_00_Good $test_object = Perl::Types::Test::Properties::Class_00_Good->new();
my integer $retval = $test_object->test_method(23);
print $retval . "\n";

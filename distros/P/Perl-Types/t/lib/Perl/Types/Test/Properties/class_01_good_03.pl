#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '200' >>>
# <<< EXECUTE_SUCCESS: '300' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use types;
our $VERSION = 0.000_010;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use Perl::Types::Test::Properties::Class_01_Good;

# [[[ OPERATIONS ]]]
my Perl::Types::Test::Properties::Class_01_Good $test_object = Perl::Types::Test::Properties::Class_01_Good->new({ foo => 200, bar => 300 });
print $test_object->{foo} . "\n";
print $test_object->{bar} . "\n";

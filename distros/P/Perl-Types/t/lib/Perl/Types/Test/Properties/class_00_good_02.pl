#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '92' >>>

# [[[ HEADER ]]]
use Perl::Types;
use strict;
use warnings;
our $VERSION = 0.000_010;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use Perl::Types::Test::Properties::Class_00_Good;

# [[[ OPERATIONS ]]]
# set and get object property ourself
# using direct access to blessed $property hashref, breaking object encapsulation
my Perl::Types::Test::Properties::Class_00_Good $test_object = Perl::Types::Test::Properties::Class_00_Good->new();
$test_object->{test_property} = 4;
$test_object->test_method(23);
print $test_object->{test_property} . "\n";

#!/usr/bin/env perl

# Learning RPerl, Chapter 2, Exercise 1
# Find the circumference of a circle with hard-coded radius of 12.5 units

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

#use constant PI => my number $TYPED_PI = 3.141_592_654;
use constant PI => my number $TYPED_PI = 333_333_333.141_592_654;

# [[[ OPERATIONS ]]]
my number $radius = 12.5;
my number $circumference = 2 * PI() * $radius;

print 'Pi = ', to_string(PI()), "\n";
print 'Radius = ', to_string($radius), "\n";
print 'Circumference = 2 * Pi * Radius = 2 * ', to_string(PI()), ' * ', to_string($radius), ' = ', to_string($circumference), "\n";

#!/usr/bin/perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitMultiplePackages ProhibitReusedNames ProhibitPackageVars)  # USER DEFAULT 8: allow additional packages

# [[[ INCLUDES ]]]
use MyClass04MediumRMoo;

# [[[ OPERATIONS ]]]

# class example

my MyClass04MediumRMoo $my_object = MyClass04MediumRMoo->new({bar => 22});

print 'have $my_object->bar() = ', $my_object->bar(), "\n";

$my_object->double_bar_save();
print 'have $my_object->bar() = ', $my_object->bar(), "\n";

print 'have $my_object->double_bar_return() = ', $my_object->double_bar_return(), "\n";
print 'have $my_object->bar() = ', $my_object->bar(), "\n";

# subclass example

my MySubclass04MediumRMoo $my_object_subclass = MySubclass04MediumRMoo->new({bar => 33});

print 'have $my_object_subclass->bar() = ', $my_object_subclass->bar(), "\n";
print 'have $my_object_subclass->bax() = ', $my_object_subclass->bax(), "\n";

$my_object_subclass->triple_bax_save();
print 'have $my_object_subclass->bax() = ', $my_object_subclass->bax(), "\n";

print 'have $my_object_subclass->triple_bax_return() = ', $my_object_subclass->triple_bax_return(), "\n";
print 'have $my_object_subclass->bax() = ', $my_object_subclass->bax(), "\n";

print 'have $my_object_subclass->multiply_bax_return(2) = ', $my_object_subclass->multiply_bax_return(2), "\n";
print 'have $my_object_subclass->bax() = ', $my_object_subclass->bax(), "\n";

print 'have $my_object_subclass->multiply_bax_return(20) = ', $my_object_subclass->multiply_bax_return(20), "\n";
print 'have $my_object_subclass->bax() = ', $my_object_subclass->bax(), "\n";

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::ScopeTypeNameValue::Class_00_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { some_integer => my integer $TYPED_some_integer = 23 };

# [[[ SUBROUTINES & OO METHODS ]]]
sub properties_stnv {
    { my string::method $RETURN_TYPE };
    return main::scope_type_name_value($properties);
}

1;    # end of class

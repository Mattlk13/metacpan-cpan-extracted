# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  ###' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Critic::Class_00_Bad_02;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ CRITICS ]]]
### no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

# [[[ SUBROUTINES & OO METHODS ]]]
our void::method $empty_method = sub {
    return 2;
};

1;                  # end of class

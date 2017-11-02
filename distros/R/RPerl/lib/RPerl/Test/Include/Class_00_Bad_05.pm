# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPAPL02' >>>
# <<< PARSE_ERROR: 'Bareword "RPerl::Test::Bar" not allowed' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Include::Class_00_Bad_05;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ INCLUDES ]]]
use RPerl::Test::Foo;
 RPerl::Test::Bar;

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

# [[[ SUBROUTINES & OO METHODS ]]]
sub empty_method { { my integer::method $RETURN_TYPE }; return 2; }

1;                  # end of class

use strict;
use warnings;

use Error::Pure::Always;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Error::Pure::Always::VERSION, 0.07, 'Version.');

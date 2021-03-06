
# Driver API tests for Class::DBI::ViewLoader

# Driver writers may want to copy this file into their distribution to be sure
# to comply with the current API

use strict;
use warnings;

use Test::More tests => 4;

use lib qw( t/lib );

our $class;

BEGIN {
    # Change this to the name of your driver
    my $plugin_name = 'Mock';

    $class = "Class::DBI::ViewLoader::$plugin_name";

    use_ok('Class::DBI::ViewLoader');
    use_ok($class);
}

ok($class->isa('Class::DBI::ViewLoader'), "$class isa Class::DBI::ViewLoader");
can_ok($class, @Class::DBI::ViewLoader::driver_methods);

__END__

vim: ft=perl

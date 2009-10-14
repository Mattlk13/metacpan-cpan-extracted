package uni::perl::ua;

use uni::perl;
use uni::perl::encodebase;
m{
use strict;
use warnings;
}x;

our $LOADED;
sub load {
	$LOADED++ and return;
	uni::perl::encodebase::generate(qw(cp1251 koi8u cp866));
	return;
}

1;

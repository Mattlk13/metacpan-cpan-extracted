#!perl -w

use strict;
use warnings;

use Test::Most;

if(not $ENV{RELEASE_TESTING}) {
	plan(skip_all => 'Author tests not required for installation');
}

eval "use Test::GreaterVersion";

plan skip_all => "Test::GreaterVersion required for checking versions" if $@;

Test::GreaterVersion::has_greater_version_than_cpan('Log::Log4perl::Layout::RFC3164');

done_testing();

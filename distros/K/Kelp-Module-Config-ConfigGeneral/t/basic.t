use strict;
use warnings;

use Kelp::Base -strict;
use Kelp;
use Test::More;

my $app = Kelp->new( config_module => 'Config::ConfigGeneral' );

can_ok $app, 'config';
is $app->config('something'), 1;

done_testing;

#!perl
use 5.010;
use strict;
use warnings;
use Test::More;

plan tests => 3;

# Not in a BEGIN block: the plan is emitted at run time, and a BEGIN would put
# these two ok lines in front of it - which is a TAP parse error, not a pass.
use_ok('Punk::Feed')         || BAIL_OUT('the facade did not load');
use_ok('Punk::Plugin::Feed') || BAIL_OUT('the plugin did not load');

# The two modules ship together and are versioned together. A facade that
# drifts from its plugin is a dependency nobody can pin.
is($Punk::Plugin::Feed::VERSION, $Punk::Feed::VERSION,
    'the plugin and the facade carry the same version');

diag("Testing Punk::Feed $Punk::Feed::VERSION, Perl $], $^X");

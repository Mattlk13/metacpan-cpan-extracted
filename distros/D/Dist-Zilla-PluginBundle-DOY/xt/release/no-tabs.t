use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.07

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Dist/Zilla/PluginBundle/DOY.pm',
    't/00-compile.t'
);

notabs_ok($_) foreach @files;
done_testing;

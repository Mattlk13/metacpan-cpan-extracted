use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.15

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Pod/Weaver/Section/Badges.pm',
    'lib/Pod/Weaver/Section/Badges/PluginSearcher.pm',
    'lib/Pod/Weaver/Section/Badges/Utils.pm',
    't/00-compile.t',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/01-utils.t',
    't/02-badges.t',
    't/corpus/01/dist.ini',
    't/corpus/01/lib/Badge/Depot/Plugin/Anothertestplugin.pm',
    't/corpus/01/lib/Badge/Depot/Plugin/Atestpluginwedontwant.pm',
    't/corpus/01/lib/Badge/Depot/Plugin/Thisisatestplugin.pm',
    't/corpus/01/lib/TesterFor/Badges.pm',
    't/corpus/01/weaver.ini'
);

notabs_ok($_) foreach @files;
done_testing;

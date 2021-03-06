use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.19

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/Dist/Zilla/Plugin/ATOOMIC/Contributors.pm',
    'lib/Dist/Zilla/Plugin/ATOOMIC/Git/CheckFor/CorrectBranch.pm',
    'lib/Dist/Zilla/Plugin/ATOOMIC/License.pm',
    'lib/Dist/Zilla/Plugin/ATOOMIC/MakeMaker.pm',
    'lib/Dist/Zilla/Plugin/ATOOMIC/Role/CoreCounter.pm',
    'lib/Dist/Zilla/Plugin/ATOOMIC/RunExtraTests.pm',
    'lib/Dist/Zilla/Plugin/ATOOMIC/TidyAll.pm',
    'lib/Dist/Zilla/Plugin/ATOOMIC/WeaverConfig.pm',
    'lib/Dist/Zilla/PluginBundle/ATOOMIC.pm',
    'lib/Pod/Weaver/PluginBundle/ATOOMIC.pm',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;

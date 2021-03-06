use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.15

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Mac/PopClip/Quick.pm',
    'lib/Mac/PopClip/Quick/Generator.pm',
    'lib/Mac/PopClip/Quick/Role/Apps.pm',
    'lib/Mac/PopClip/Quick/Role/BeforeAfter.pm',
    'lib/Mac/PopClip/Quick/Role/CoreAttributes.pm',
    'lib/Mac/PopClip/Quick/Role/PerlScript.pm',
    'lib/Mac/PopClip/Quick/Role/Regex.pm',
    'lib/Mac/PopClip/Quick/Role/WritePlist.pm',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/01generator.t'
);

notabs_ok($_) foreach @files;
done_testing;

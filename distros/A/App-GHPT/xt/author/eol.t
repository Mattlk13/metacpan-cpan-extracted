use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.19

use Test::More 0.88;
use Test::EOL;

my @files = (
    'bin/gh-pt.pl',
    'lib/App/GHPT.pm',
    'lib/App/GHPT/Types.pm',
    'lib/App/GHPT/WorkSubmitter.pm',
    'lib/App/GHPT/WorkSubmitter/AskPullRequestQuestions.pm',
    'lib/App/GHPT/WorkSubmitter/ChangedFiles.pm',
    'lib/App/GHPT/WorkSubmitter/ChangedFilesFactory.pm',
    'lib/App/GHPT/WorkSubmitter/Question/ExampleFileNameCheck.pod',
    'lib/App/GHPT/WorkSubmitter/Role/FileInspector.pm',
    'lib/App/GHPT/WorkSubmitter/Role/Question.pm',
    'lib/App/GHPT/Wrapper/OurMoose.pm',
    'lib/App/GHPT/Wrapper/OurMoose/Role.pm',
    'lib/App/GHPT/Wrapper/OurMooseX/Role/Parameterized.pm',
    'lib/App/GHPT/Wrapper/OurMooseX/Role/Parameterized/Meta/Trait/Parameterizable/Strict.pm',
    'lib/App/GHPT/Wrapper/Ourperl.pm',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/lib/App/GHPT/Wrapper/OurTest/Class/Moose.pm',
    't/lib/TestFor/App/GHPT/WorkSubmitter.pm',
    't/lib/TestFor/App/GHPT/WorkSubmitter/ChangedFiles.pm',
    't/run-test-class-moose.t',
    't/test-data/not-committed-todelete',
    't/test-data/not-committed-tomodify',
    't/test-data/todelete1',
    't/test-data/todelete2',
    't/test-data/tomodify1',
    't/test-data/tomodify2'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;

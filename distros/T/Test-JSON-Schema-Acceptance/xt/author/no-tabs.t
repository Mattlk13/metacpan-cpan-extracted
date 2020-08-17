use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.15

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'examples/run_all_tests',
    'lib/Test/JSON/Schema/Acceptance.pm',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/01-basic.t',
    't/02-constructor.t',
    't/03-validate_data.t',
    't/04-validate_json_string.t',
    't/05-test-descriptions.t',
    't/06-subset-of-tests.t',
    't/07-skip-tests-deprecated.t',
    't/08-todo-tests.t',
    't/09-unicode.t',
    't/10-exception.t',
    't/11-additional-resources.t',
    't/12-include-optional.t',
    't/13-empty-test-dir.t',
    't/14-add-resource.t',
    't/15-mutation.t',
    't/99-sanity.t',
    't/lib/SchemaParser.pm',
    't/tests/add_resource/foo.json',
    't/tests/add_resource/remotes/remote1.json',
    't/tests/add_resource/remotes/subfolder/remote2.json',
    't/tests/bad/invalid-schema.json',
    't/tests/empty/keep',
    't/tests/include_optional/extra/foo.json',
    't/tests/include_optional/foo.json',
    't/tests/include_optional/optional/alpha.json',
    't/tests/include_optional/optional/beta.json',
    't/tests/include_optional/zulu.json',
    't/tests/mutation/hash.json',
    't/tests/simple-booleans/bar.json',
    't/tests/simple-booleans/foo.json',
    't/tests/subset/bar.json',
    't/tests/subset/baz.json',
    't/tests/subset/foo.json',
    't/tests/unicode/unicode.json',
    'xt/author/00-compile.t',
    'xt/author/changes_has_content.t',
    'xt/author/clean-namespaces.t',
    'xt/author/eol.t',
    'xt/author/kwalitee.t',
    'xt/author/live-data-sanity.t',
    'xt/author/minimum-version.t',
    'xt/author/mojibake.t',
    'xt/author/no-tabs.t',
    'xt/author/pod-coverage.t',
    'xt/author/pod-no404s.t',
    'xt/author/pod-spell.t',
    'xt/author/pod-syntax.t',
    'xt/author/portability.t',
    'xt/release/changes_has_content.t',
    'xt/release/cpan-changes.t',
    'xt/release/distmeta.t'
);

notabs_ok($_) foreach @files;
done_testing;

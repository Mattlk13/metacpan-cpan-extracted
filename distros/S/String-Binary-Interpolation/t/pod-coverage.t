use strict;
use warnings;

use Test::More;
eval "use Test::Pod::Coverage 1.08";
plan skip_all => "Test::Pod::Coverage 1.08 required for testing POD coverage" if $@;
foreach my $module (all_modules()) {
    pod_coverage_ok($module);
}
done_testing();

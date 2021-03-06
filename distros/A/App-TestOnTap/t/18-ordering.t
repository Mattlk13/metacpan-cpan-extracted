use strict;
use warnings;

use FindBin qw($Bin);

use lib "$Bin/lib";

use TestUtils;

use Test::More tests => 32;

note("default ordering");
my ($ret, $stdout, $stderr) = TestUtils::xeqsuite([qw(--verbose)]);

is($ret, 0, "Exited with 0");
like($stderr->[0], qr/^WARNING: No execmap found, using internal default!$/, "default execmap");
like($stdout->[13], qr/^Files=3, Tests=3, /, "Three tests found");
is($stdout->[14], "Result: PASS", "Passed");

note("alphabetic (config) ordering");
($ret, $stdout, $stderr) = TestUtils::xeqsuite(['--verbose', '--cfg', "$Bin/misc/18-alphabetic_config.testontap"]);

is($ret, 0, "Exited with 0");
like($stderr->[0], qr/^WARNING: No execmap found, using internal default!$/, "default execmap");
like($stdout->[0], qr/^t1\.pl /, "t1 first");
like($stdout->[4], qr/^t10\.pl /, "t10 in the middle");
like($stdout->[8], qr/^t2\.pl /, "t2 last");
like($stdout->[13], qr/^Files=3, Tests=3, /, "Three tests found");
is($stdout->[14], "Result: PASS", "Passed");

note("ralphabetic ordering");
($ret, $stdout, $stderr) = TestUtils::xeqsuite([qw(--verbose --order ralphabetic)]);

is($ret, 0, "Exited with 0");
like($stderr->[0], qr/^WARNING: No execmap found, using internal default!$/, "default execmap");
like($stdout->[0], qr/^t2\.pl /, "t2 first");
like($stdout->[4], qr/^t10\.pl /, "t10 in the middle");
like($stdout->[8], qr/^t1\.pl /, "t1 last");
like($stdout->[13], qr/^Files=3, Tests=3, /, "Three tests found");
is($stdout->[14], "Result: PASS", "Passed");

note("natural (config) ordering");
($ret, $stdout, $stderr) = TestUtils::xeqsuite(['--verbose', '--cfg', "$Bin/misc/18-natural_config.testontap"]);

is($ret, 0, "Exited with 0");
like($stderr->[0], qr/^WARNING: No execmap found, using internal default!$/, "default execmap");
like($stdout->[0], qr/^t1\.pl /, "t1 first");
like($stdout->[4], qr/^t2\.pl /, "t2 in the middle");
like($stdout->[8], qr/^t10\.pl /, "t10 last");
like($stdout->[13], qr/^Files=3, Tests=3, /, "Three tests found");
is($stdout->[14], "Result: PASS", "Passed");

note("rnatural ordering");
($ret, $stdout, $stderr) = TestUtils::xeqsuite([qw(--verbose --order rnatural)]);

is($ret, 0, "Exited with 0");
like($stderr->[0], qr/^WARNING: No execmap found, using internal default!$/, "default execmap");
like($stdout->[0], qr/^t10\.pl /, "t10 first");
like($stdout->[4], qr/^t2\.pl /, "t2 in the middle");
like($stdout->[8], qr/^t1\.pl /, "t1 last");
like($stdout->[13], qr/^Files=3, Tests=3, /, "Three tests found");
is($stdout->[14], "Result: PASS", "Passed");

done_testing();

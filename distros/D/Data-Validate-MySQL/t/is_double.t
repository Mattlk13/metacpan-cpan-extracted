#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 22;
BEGIN { use_ok('Data::Validate::MySQL', qw(is_double)) };

#########################

# valid tests
my @good = (
	[0,'','',0],
	[1,'','',0],
	[1,1,'',0],
	[1.1,'','',0],
	[1.1,2,1,0],
	['-1.7976931348623157E308','','',0],
	['-2.2250738585072014E-308','','',0],
	['2.2250738585072014E-308','','',0],
	['1.7976931348623157E+308','','',0],
);
foreach my $set (@good){
	ok(defined(is_double($set->[0], $set->[1], $set->[2], $set->[3])), "valid: $set->[0], $set->[1], $set->[2], $set->[3]");
}

# invalid tests
my @bad = (
	['', '','',0],
	['', '','',1],
	['abc', '','',0],
	['abc', '','',1],
	['abc', 1,'',0],
	['abc', 1,1,0],
	['100.1', 2,1,0],
	['100.1111', 7,1,0],
	['-1.7976931348623157E309','','',0],
	['-2.2250738585072014E-309','','',0],
	['2.2250738585072014E-309','','',0],
	['1.7976931348623157E+309','','',0],
);
foreach my $set (@bad){
	ok(!defined(is_double($set->[0], $set->[1], $set->[2], $set->[3])), "invalid: $set->[0], $set->[1], $set->[2], $set->[3]");
}
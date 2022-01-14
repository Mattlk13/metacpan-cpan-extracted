# Test the error reporting for malformed PDL::PP code.
use strict;
use warnings;
use Test::More;

# Load up PDL::PP
use PDL::PP qw(foo::bar foo::bar foobar);

# Prevent file generation (does not prevent calling of functions)
$PDL::PP::done = 1;

# Check the loop malformed call:
eval {
	pp_def(test1 =>
		Pars => 'a(n)',
		Code => q{
			loop %{
				$a()++;
			%}
		}
	);
};

my $err_msg = $@;
isnt($@, undef, 'loop without dim name should throw an error');
like($@, qr/Expected.*loop.*%\{/, 'loop without dim name should explain the error')
	or diag("Got this error: $@");

TODO: {
	local $TODO = 'Have not figured out why @CARP_NOT is not working';
	unlike($@, qr/PP\.pm/, 'Should not report error as coming from PDL::PP');
};

eval {
  pp_def(test1 =>
    Pars => 'a(n)',
    OtherPars => 'int b; int c',
    OtherParsDefaults => { b => 0 },
    Code => q{;},
  );
};
isnt $@, '', 'error to give default for non-last params';

done_testing;

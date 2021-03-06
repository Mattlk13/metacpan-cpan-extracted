use warnings;
use strict;

BEGIN {
	eval {
		require Devel::Declare;
		Devel::Declare->VERSION(0.006004);
	};
	if($@ ne "") {
		require Test::More;
		Test::More::plan(skip_all => "good Devel::Declare unavailable");
	}
}

use Test::More tests => 1;

use Devel::CallParser ();

sub method {
	my ($usepack, $name, $inpack, $sub) = @_;
	no strict "refs";
	*{"${inpack}::${name}"} = $sub;
}

use Devel::Declare method => sub {
	my ($usepack, $use, $inpack, $name) = @_;
	return sub (&) { ($usepack, $name, $inpack, $_[0]); };
};

method bar {
	return join(",", @_);
};

is +__PACKAGE__->bar(qw(x y)), "main,x,y";

1;

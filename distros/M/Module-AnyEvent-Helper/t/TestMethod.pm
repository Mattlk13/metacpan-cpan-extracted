package TestMethod;

use strict;
use warnings;

sub new
{
	return bless {};
}

sub func1
{
	return 1;
}

sub func2
{
	return 2;
}

sub func3
{
	my ($self, $arg) = @_;
	return $self->func1() if $arg == 1;
	return $self->func2() if $arg == 2;
	return 0;
}

1;

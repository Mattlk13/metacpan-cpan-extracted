#!/usr/bin/env perl 
#
# Before `make install' is performed this script should be runnable with
# `make test'.
# After `make install' it should work as `perl 570_Slurm-SAUser-parse.t'
use strict;
use warnings;

use Test::More;
use Cwd qw(abs_path);
use File::Basename qw(dirname);

use Slurm::Sacctmgr;
use Slurm::Sacctmgr::User;
my $entity = 'Slurm::Sacctmgr::User';
my $entname = 'user';

my $testDir = dirname(abs_path($0));
my $fake_sa = "${testDir}/helpers/fake_sacctmgr_user";
my $num_tests_run = 0; 

#========================================================================
#		Set up expected results
#========================================================================

our @fake_user_data;
require "${testDir}/helpers/fake-user-data.pl";

sub filter_fake_data($$)
#Filter fake data results
{	my $data = shift || [];
	my $rawfilter = shift || {};
	my $me = 'filter_fake_data';

	return $data unless $rawfilter && %$rawfilter;
	return [] unless $data && @$data;

	my $filter = { %$rawfilter };

	my @filtered = @$data;

	my @filterable_fields = qw(adminlevel defaultaccount user name);

	FFIELD: foreach my $ffld (@filterable_fields)
	{	my $fval = delete $filter->{$ffld};
		next FFIELD unless defined $fval;
		my $meth = $ffld;
		$meth = 'user' if $ffld eq 'name';

		@filtered = grep { $_->$meth eq  $fval } @filtered;
	}

	if ( %$filter )
	{	my @tmp = keys %$filter;
		my $tmp = join ', ', @tmp;
		die "$me: Unrecognized filter fields [ $tmp ], aborting at ";
	}

	return [ @filtered ];
}


#========================================================================
#		Set up tests
#========================================================================

my @tests = 
(	{	name => "list all ${entname}s",
		filter => undef,
	},

	{	name => "list $entname by name",
		filter => { name => 'aaa' },
	},

	{	name => "list $entname by defacct (single record)",
		filter => { defaultaccount => 'abc114', },
	},

	{	name => "list $entname by defacct (multiple records)",
		filter => { defaultaccount => 'test', },
	},

	{	name => "list $entname by name (no match)",
		filter => { name => 'no-such-user' },
	},
);

sub do_run_tests($$)
#Given slurm version, dryrun, run the tests
{	my $slurm_version = shift;
	my $dryrun = shift;

	my $setname = "slurm $slurm_version, ";
	$setname .= $dryrun?'DRYRUN':'no dryrun';

	my $sa = Slurm::Sacctmgr->new(sacctmgr=>$fake_sa, slurm_version=>$slurm_version);
	$sa->dryrun($dryrun);
	#$sa->verbose(1);

	#Need to regenerate as strip* functions will modify fake data objects
	my $fake_data = generate_fake_data();

	foreach my $test (@tests)
	{	my $tname = $test->{name};
		my $filter = $test->{filter};

		my $testname = "$tname ($setname)";
		my $exp = filter_fake_data($fake_data, $filter);

		my $got = $entity->sacctmgr_list($sa, %$filter);

		is_deeply($got, $exp, $testname);
		$num_tests_run++;
	}
}

#========================================================================
#		Actually run tests
#========================================================================

my @slurm_versions = ( '14', '15.08.2' );

foreach my $slurm_version (@slurm_versions)
{	foreach my $dryrun (0, 1)
	{	do_run_tests($slurm_version, $dryrun);
	}
}

done_testing($num_tests_run);


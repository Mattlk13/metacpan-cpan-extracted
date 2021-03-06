#!/usr/bin/env perl

use strict;
use warnings;
use Module::Build;
my $builder = Module::Build->new(
	module_name       => 'AnyEvent::ImageShack',
	license           => 'perl',
	dist_author       => 'Dmitry Konstantinov <konstantinov.dmitry@gmail.com>',
	dist_version_from => 'lib/AnyEvent/ImageShack.pm',
	build_requires    => {
		'Test::More' => 0,
	},
	requires          => {
		'AnyEvent::HTTP'        => 0,
		'HTTP::Request::Common' => 0,
	},
	meta_merge => {
		resources => {
			repository => 'git://github.com/konstantinov/AnyEvent-ImageShack.git',
		},
		keywords  => [ qw(anyevent imageshack) ],
	},
	create_makefile_pl => 'traditional',
);

$builder->create_build_script();
#
# This file is part of Software-Copyright
#
# This software is Copyright (c) 2022 by Dominique Dumont <dod@debian.org>.
#
# This is free software, licensed under:
#
#   The GNU General Public License, Version 3, June 2007
#

# This file was automatically generated by Dist::Zilla::Plugin::ModuleBuild v6.032.
use strict;
use warnings;

use Module::Build 0.34;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.34"
  },
  "configure_requires" => {
    "Module::Build" => "0.34"
  },
  "dist_abstract" => "Copyright class",
  "dist_author" => [
    "Dominique Dumont"
  ],
  "dist_name" => "Software-Copyright",
  "dist_version" => "0.015",
  "license" => "gpl",
  "module_name" => "Software::Copyright",
  "recursive_test_files" => 1,
  "requires" => {
    "Array::IntSpan" => 0,
    "Carp" => 0,
    "Date::Parse" => 0,
    "Mouse" => 0,
    "Mouse::Util::TypeConstraints" => 0,
    "MouseX::NativeTraits" => 0,
    "Storable" => 0,
    "Time::localtime" => 0,
    "Unicode::Normalize" => 0,
    "feature" => 0,
    "overload" => 0,
    "perl" => "v5.20.0",
    "utf8" => 0,
    "warnings" => 0
  },
  "test_requires" => {
    "English" => 0,
    "File::Spec" => 0,
    "Test::Differences" => 0,
    "Test::More" => 0,
    "Test::Perl::Critic" => 0,
    "Test::Synopsis::Expectation" => 0,
    "open" => 0,
    "strict" => 0
  }
);


my %fallback_build_requires = (
  "English" => 0,
  "File::Spec" => 0,
  "Module::Build" => "0.34",
  "Test::Differences" => 0,
  "Test::More" => 0,
  "Test::Perl::Critic" => 0,
  "Test::Synopsis::Expectation" => 0,
  "open" => 0,
  "strict" => 0
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);


$build->create_build_script;

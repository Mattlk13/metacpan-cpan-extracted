
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.013.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker 6.17;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Dist::Zilla configuration the way SILEX does it",
  "AUTHOR" => "\x{ae40}\x{b3c4}\x{d615} - Keedi Kim <keedi\@cpan.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.17"
  },
  "DISTNAME" => "Dist-Zilla-PluginBundle-SILEX",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Dist::Zilla::PluginBundle::SILEX",
  "PREREQ_PM" => {
    "Dist::Zilla" => 5,
    "Dist::Zilla::Plugin::ReadmeAnyFromPod" => "0.133360",
    "Dist::Zilla::PluginBundle::DAGOLDEN" => "0.062",
    "Dist::Zilla::Role::PluginBundle::PluginRemover" => 0,
    "Dist::Zilla::Util" => 0,
    "List::MoreUtils" => 0,
    "Moose" => "0.99",
    "Pod::Weaver::PluginBundle::DAGOLDEN" => 0,
    "autodie" => "2.00",
    "namespace::autoclean" => "0.09"
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec::Functions" => 0,
    "List::Util" => 0,
    "Test::More" => 0,
    "version" => 0
  },
  "VERSION" => "v0.0.2",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Dist::Zilla" => 5,
  "Dist::Zilla::Plugin::ReadmeAnyFromPod" => "0.133360",
  "Dist::Zilla::PluginBundle::DAGOLDEN" => "0.062",
  "Dist::Zilla::Role::PluginBundle::PluginRemover" => 0,
  "Dist::Zilla::Util" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec::Functions" => 0,
  "List::MoreUtils" => 0,
  "List::Util" => 0,
  "Moose" => "0.99",
  "Pod::Weaver::PluginBundle::DAGOLDEN" => 0,
  "Test::More" => 0,
  "autodie" => "2.00",
  "namespace::autoclean" => "0.09",
  "version" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);




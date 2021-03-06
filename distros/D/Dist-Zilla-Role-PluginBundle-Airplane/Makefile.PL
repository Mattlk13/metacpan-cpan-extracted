# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.014.
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "A role for building packages with Dist::Zilla in an airplane",
  "AUTHOR" => "Wesley Schwengle <waterkip\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Dist-Zilla-Role-PluginBundle-Airplane",
  "LICENSE" => "bsd",
  "MIN_PERL_VERSION" => "5.010",
  "NAME" => "Dist::Zilla::Role::PluginBundle::Airplane",
  "PREREQ_PM" => {
    "Dist::Zilla::Plugin::BlockRelease" => 0,
    "Dist::Zilla::Util" => 0,
    "Moose::Role" => 0
  },
  "TEST_REQUIRES" => {
    "Dist::Zilla::Role::PluginBundle::Easy" => 0,
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Moose" => 0,
    "Test::Deep" => 0,
    "Test::Exception" => 0,
    "Test::Lib" => 0,
    "Test::More" => "0.96"
  },
  "VERSION" => "0.002",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Dist::Zilla::Plugin::BlockRelease" => 0,
  "Dist::Zilla::Role::PluginBundle::Easy" => 0,
  "Dist::Zilla::Util" => 0,
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Moose" => 0,
  "Moose::Role" => 0,
  "Test::Deep" => 0,
  "Test::Exception" => 0,
  "Test::Lib" => 0,
  "Test::More" => "0.96"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

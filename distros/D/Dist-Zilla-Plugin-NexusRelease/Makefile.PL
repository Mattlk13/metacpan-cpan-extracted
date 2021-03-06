# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.047.
use strict;
use warnings;

use 5.008000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Release a Dist::Zilla build to a Sonatype Nexus instance.",
  "AUTHOR" => "Brad Macpherson <brad\@teched-creations.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Dist-Zilla-Plugin-NexusRelease",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.008000",
  "NAME" => "Dist::Zilla::Plugin::NexusRelease",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Dist::Zilla::Role::Releaser" => 0,
    "Dist::Zilla::Role::Stash::Login" => 0,
    "Log::Any" => 0,
    "Moose" => 0,
    "Moose::Util::TypeConstraints" => 0,
    "Nexus::Uploader" => "1.0.0",
    "Scalar::Util" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0,
    "utf8" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "Nexus::Uploader" => "1.0.0",
    "Pod::Coverage::TrustPod" => 0,
    "Test::DZil" => 0,
    "Test::Fatal" => 0,
    "Test::More" => "1.00",
    "Test::Pod" => 0,
    "Test::Pod::Coverage" => 0
  },
  "VERSION" => "1.0.1",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Dist::Zilla::Role::Releaser" => 0,
  "Dist::Zilla::Role::Stash::Login" => 0,
  "File::Spec" => 0,
  "Log::Any" => 0,
  "Moose" => 0,
  "Moose::Util::TypeConstraints" => 0,
  "Nexus::Uploader" => "1.0.0",
  "Pod::Coverage::TrustPod" => 0,
  "Scalar::Util" => 0,
  "Test::DZil" => 0,
  "Test::Fatal" => 0,
  "Test::More" => "1.00",
  "Test::Pod" => 0,
  "Test::Pod::Coverage" => 0,
  "namespace::autoclean" => 0,
  "strict" => 0,
  "utf8" => 0,
  "warnings" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Automate Stratopan releases with Dist::Zilla",
  "AUTHOR" => "Mike Friedman <friedo\@friedo.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Dist-Zilla-Plugin-UploadToStratopan",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "Dist::Zilla::Plugin::UploadToStratopan",
  "PREREQ_PM" => {
    "Dist::Zilla::Role::Releaser" => 0,
    "LWP::Protocol::https" => 0,
    "Mojo::DOM" => 0,
    "Mojo::UserAgent" => 0,
    "Mojolicious" => 0,
    "Moose" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::Exception" => 0,
    "Test::Mock::One" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.015",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Dist::Zilla::Role::Releaser" => 0,
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "LWP::Protocol::https" => 0,
  "Mojo::DOM" => 0,
  "Mojo::UserAgent" => 0,
  "Mojolicious" => 0,
  "Moose" => 0,
  "Test::Exception" => 0,
  "Test::Mock::One" => 0,
  "Test::More" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

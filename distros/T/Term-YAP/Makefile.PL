# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;

use 5.008009;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "show pulsed progress bar in terminal",
  "AUTHOR" => "Alceu Rodrigues de Freitas Junior <arfreitas\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Term-YAP",
  "LICENSE" => "gpl",
  "MIN_PERL_VERSION" => "5.008009",
  "NAME" => "Term::YAP",
  "PREREQ_PM" => {
    "Capture::Tiny" => "0.30",
    "Moo" => "2.000002",
    "Thread::Queue" => "3.05",
    "Time::HiRes" => "1.9726",
    "Types::Standard" => "1.000005",
    "namespace::clean" => "0.26",
    "threads" => "2.01"
  },
  "TEST_REQUIRES" => {
    "Capture::Tiny" => "0.30",
    "File::Spec" => 0,
    "IO::File" => 0,
    "Moose" => "2.1604",
    "Test::Exception" => "0.43",
    "Test::Moose" => "2.1604",
    "Test::More" => 0,
    "Test::TempDir::Tiny" => "0.018"
  },
  "VERSION" => "0.08",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Capture::Tiny" => "0.30",
  "File::Spec" => 0,
  "IO::File" => 0,
  "Moo" => "2.000002",
  "Moose" => "2.1604",
  "Test::Exception" => "0.43",
  "Test::Moose" => "2.1604",
  "Test::More" => 0,
  "Test::TempDir::Tiny" => "0.018",
  "Thread::Queue" => "3.05",
  "Time::HiRes" => "1.9726",
  "Types::Standard" => "1.000005",
  "namespace::clean" => "0.26",
  "threads" => "2.01"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

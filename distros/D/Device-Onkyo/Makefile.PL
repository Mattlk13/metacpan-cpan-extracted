
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.025.
use strict;
use warnings;



use ExtUtils::MakeMaker;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Perl module to control Onkyo/Integra AV equipment",
  "AUTHOR" => "Mark Hindess <soft-cpan\@temporalanomaly.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Device-Onkyo",
  "EXE_FILES" => [
    "bin/onkyo"
  ],
  "LICENSE" => "perl",
  "NAME" => "Device::Onkyo",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Fcntl" => 0,
    "Getopt::Long" => 0,
    "IO::Select" => 0,
    "IO::Socket::INET" => 0,
    "Pod::Usage" => 0,
    "Socket" => 0,
    "Symbol" => 0,
    "Time::HiRes" => 0,
    "constant" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "Test::More" => 0,
    "Test::Requires" => 0,
    "Test::SharedFork" => 0,
    "base" => 0
  },
  "VERSION" => "1.143640",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "ExtUtils::MakeMaker" => 0,
  "Fcntl" => 0,
  "File::Spec" => 0,
  "Getopt::Long" => 0,
  "IO::Select" => 0,
  "IO::Socket::INET" => 0,
  "Pod::Usage" => 0,
  "Socket" => 0,
  "Symbol" => 0,
  "Test::More" => 0,
  "Test::Requires" => 0,
  "Test::SharedFork" => 0,
  "Time::HiRes" => 0,
  "base" => 0,
  "constant" => 0,
  "strict" => 0,
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




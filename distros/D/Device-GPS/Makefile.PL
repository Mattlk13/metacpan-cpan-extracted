# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.036.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Read GPS (NMEA) data over a wire",
  "AUTHOR" => "Timm Murray <tmurray\@wumpus-cave.net>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Device-GPS",
  "EXE_FILES" => [],
  "LICENSE" => "bsd",
  "NAME" => "Device::GPS",
  "PREREQ_PM" => {
    "Device::SerialPort" => "1.04",
    "Moose" => 0,
    "namespace::clean" => 0
  },
  "TEST_REQUIRES" => {
    "Test::Pod" => 0
  },
  "VERSION" => "0.714874475569562",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Device::SerialPort" => "1.04",
  "ExtUtils::MakeMaker" => 0,
  "Moose" => 0,
  "Test::Pod" => 0,
  "namespace::clean" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

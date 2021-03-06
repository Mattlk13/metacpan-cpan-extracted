
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.020.
use strict;
use warnings;



use ExtUtils::MakeMaker ;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Tweet from a queue of messages",
  "AUTHOR" => "Drew Stephens <drew\@dinomite.net>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Net-Twitter-Queue",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Net::Twitter::Queue",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Moose" => 0,
    "Net::Twitter" => "4.01005",
    "Try::Tiny" => 0,
    "YAML::Any" => "0.70",
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => "0.94"
  },
  "VERSION" => "0.4",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Moose" => 0,
  "Net::Twitter" => "4.01005",
  "Test::More" => "0.94",
  "Try::Tiny" => 0,
  "YAML::Any" => "0.70",
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




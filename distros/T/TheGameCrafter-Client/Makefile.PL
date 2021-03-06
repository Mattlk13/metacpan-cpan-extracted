
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.019.
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "A simple client to TGC's web services.",
  "AUTHOR" => "JT Smith <jt\@plainblack.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "TheGameCrafter-Client",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "TheGameCrafter::Client",
  "PREREQ_PM" => {
    "HTTP::Request::Common" => 0,
    "JSON" => 0,
    "LWP::UserAgent" => "6.04",
    "Ouch" => "0.0400",
    "Test::Deep" => 0,
    "Test::More" => 0,
    "URI" => 0
  },
  "VERSION" => "0.0104",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "HTTP::Request::Common" => 0,
  "JSON" => 0,
  "LWP::UserAgent" => "6.04",
  "Ouch" => "0.0400",
  "Test::Deep" => 0,
  "Test::More" => 0,
  "URI" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);




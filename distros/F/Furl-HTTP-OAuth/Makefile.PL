# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.043.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Make OAuth 1.0 signed requests with Furl",
  "AUTHOR" => "ascra <ascra\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Furl-HTTP-OAuth",
  "LICENSE" => "perl",
  "NAME" => "Furl::HTTP::OAuth",
  "PREREQ_PM" => {
    "Digest::HMAC_SHA1" => 0,
    "Furl::HTTP" => 0,
    "Scalar::Util" => 0,
    "URI" => 0,
    "URI::Escape" => 0,
    "constant" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => 0
  },
  "VERSION" => "0.002",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Digest::HMAC_SHA1" => 0,
  "Furl::HTTP" => 0,
  "Scalar::Util" => 0,
  "Test::More" => 0,
  "URI" => 0,
  "URI::Escape" => 0,
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

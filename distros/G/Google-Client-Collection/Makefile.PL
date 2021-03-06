# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.044.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Google Client Collection",
  "AUTHOR" => "Ali Zia <ziali088\@gmail.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Google-Client-Collection",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "Google::Client::Collection",
  "PREREQ_PM" => {
    "Carp" => "1.38",
    "Cpanel::JSON::XS" => 0,
    "Furl" => 0,
    "Moo" => 0,
    "Moo::Role" => 0
  },
  "TEST_REQUIRES" => {
    "CHI" => 0,
    "Class::Load" => 0,
    "Path::Tiny" => 0,
    "Test::Mock::Furl" => 0,
    "Test::Most" => 0
  },
  "VERSION" => "0.005",
  "test" => {
    "TESTS" => "t/*.t t/files/*.t"
  }
);


my %FallbackPrereqs = (
  "CHI" => 0,
  "Carp" => "1.38",
  "Class::Load" => 0,
  "Cpanel::JSON::XS" => 0,
  "Furl" => 0,
  "Moo" => 0,
  "Moo::Role" => 0,
  "Path::Tiny" => 0,
  "Test::Mock::Furl" => 0,
  "Test::Most" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

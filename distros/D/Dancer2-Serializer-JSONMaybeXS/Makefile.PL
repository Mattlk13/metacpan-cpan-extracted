# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.008.
use strict;
use warnings;

use 5.008001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "(DEPRECATED) Serializer for handling JSON data",
  "AUTHOR" => "Dan Book <dbook\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Dancer2-Serializer-JSONMaybeXS",
  "LICENSE" => "artistic_2",
  "MIN_PERL_VERSION" => "5.008001",
  "NAME" => "Dancer2::Serializer::JSONMaybeXS",
  "PREREQ_PM" => {
    "Dancer2" => "0.165000",
    "JSON::MaybeXS" => "1.003005",
    "Moo" => "2.000000"
  },
  "TEST_REQUIRES" => {
    "Encode" => 0,
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "HTTP::Request::Common" => 0,
    "Plack" => "1.0035",
    "Test::More" => "0.88"
  },
  "VERSION" => "0.003",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Dancer2" => "0.165000",
  "Encode" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "HTTP::Request::Common" => 0,
  "JSON::MaybeXS" => "1.003005",
  "Moo" => "2.000000",
  "Plack" => "1.0035",
  "Test::More" => "0.88"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

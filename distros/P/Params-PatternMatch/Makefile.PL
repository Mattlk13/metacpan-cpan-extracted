
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.013.
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Pattern match-based argument binding for Perl.",
  "AUTHOR" => "Koichi SATOH <sato\@seesaa.co.jp>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Params-PatternMatch",
  "EXE_FILES" => [],
  "LICENSE" => "mit",
  "NAME" => "Params::PatternMatch",
  "PREREQ_PM" => {
    "B" => 0,
    "Carp" => 0,
    "Data::Compare" => 0,
    "Exporter::Lite" => 0,
    "Scalar::Util" => 0,
    "TryCatch" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => 0
  },
  "VERSION" => "0.01",
  "test" => {
    "TESTS" => "t/Params/*.t"
  }
);


my %FallbackPrereqs = (
  "B" => 0,
  "Carp" => 0,
  "Data::Compare" => 0,
  "Exporter::Lite" => 0,
  "Scalar::Util" => 0,
  "Test::More" => 0,
  "TryCatch" => 0,
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




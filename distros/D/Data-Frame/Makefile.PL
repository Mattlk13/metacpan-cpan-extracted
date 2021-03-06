
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.029.
use strict;
use warnings;

use 5.012;

use ExtUtils::MakeMaker;



my %WriteMakefileArgs = (
  "ABSTRACT" => "data frame implementation",
  "AUTHOR" => "Zakariyya Mughal <zmughal\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Data-Frame",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.012",
  "NAME" => "Data::Frame",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Data::Perl" => 0,
    "Data::Rmap" => 0,
    "Exporter" => 0,
    "List::AllUtils" => 0,
    "Moo" => 0,
    "Moo::Role" => 0,
    "MooX::InsideOut" => 0,
    "MooX::Traits" => 0,
    "PDL" => "2.007",
    "PDL::Lite" => 0,
    "Scalar::Util" => 0,
    "Storable" => 0,
    "Test::Deep::NoTest" => 0,
    "Text::Table::Tiny" => 0,
    "Tie::IxHash" => 0,
    "Try::Tiny" => 0,
    "constant" => 0,
    "overload" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Math::BigInt" => 0,
    "Test::Most" => 0
  },
  "VERSION" => "0.003",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Data::Perl" => 0,
  "Data::Rmap" => 0,
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "List::AllUtils" => 0,
  "Math::BigInt" => 0,
  "Moo" => 0,
  "Moo::Role" => 0,
  "MooX::InsideOut" => 0,
  "MooX::Traits" => 0,
  "PDL" => "2.007",
  "PDL::Lite" => 0,
  "Scalar::Util" => 0,
  "Storable" => 0,
  "Test::Deep::NoTest" => 0,
  "Test::Most" => 0,
  "Text::Table::Tiny" => 0,
  "Tie::IxHash" => 0,
  "Try::Tiny" => 0,
  "constant" => 0,
  "overload" => 0,
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




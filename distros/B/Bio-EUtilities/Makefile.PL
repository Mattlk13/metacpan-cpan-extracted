# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "BioPerl low-level API for retrieving and storing data from NCBI eUtils",
  "AUTHOR" => "cjfields <cjfields\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Bio-EUtilities",
  "EXE_FILES" => [
    "bin/bp_einfo",
    "bin/bp_genbank_ref_extractor"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010",
  "NAME" => "Bio::EUtilities",
  "PREREQ_PM" => {
    "Bio::ASN1::EntrezGene" => 0,
    "Bio::DB::GenericWebAgent" => 0,
    "Bio::ParameterBaseI" => 0,
    "Bio::Root::IO" => 0,
    "Bio::Root::Root" => 0,
    "Bio::Root::RootI" => 0,
    "Bio::Root::Version" => 0,
    "Bio::SeqIO" => 0,
    "Cwd" => 0,
    "Data::Dumper" => 0,
    "File::Spec" => 0,
    "Getopt::Long" => 0,
    "HTTP::Request" => 0,
    "LWP::UserAgent" => 0,
    "Text::CSV" => 0,
    "Text::Wrap" => 0,
    "URI" => 0,
    "XML::Simple" => 0,
    "base" => 0,
    "strict" => 0,
    "utf8" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0
  },
  "VERSION" => "1.77",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Bio::ASN1::EntrezGene" => 0,
  "Bio::DB::GenericWebAgent" => 0,
  "Bio::ParameterBaseI" => 0,
  "Bio::Root::IO" => 0,
  "Bio::Root::Root" => 0,
  "Bio::Root::RootI" => 0,
  "Bio::Root::Version" => 0,
  "Bio::SeqIO" => 0,
  "Cwd" => 0,
  "Data::Dumper" => 0,
  "File::Spec" => 0,
  "Getopt::Long" => 0,
  "HTTP::Request" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "LWP::UserAgent" => 0,
  "Test::More" => 0,
  "Text::CSV" => 0,
  "Text::Wrap" => 0,
  "URI" => 0,
  "XML::Simple" => 0,
  "base" => 0,
  "strict" => 0,
  "utf8" => 0,
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

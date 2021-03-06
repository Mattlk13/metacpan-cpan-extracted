# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Simple low-dependency procedural interfaces to BioPerl",
  "AUTHOR" => "Ewan Birney <birney\@ebi.ac.uk>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Bio-Procedural",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "Bio::Procedural",
  "PREREQ_PM" => {
    "Bio::DB::EMBL" => 0,
    "Bio::DB::GenBank" => 0,
    "Bio::DB::GenPept" => 0,
    "Bio::DB::RefSeq" => 0,
    "Bio::DB::SwissProt" => 0,
    "Bio::Root::Version" => 0,
    "Bio::Seq" => 0,
    "Bio::SeqIO" => 0,
    "Bio::Tools::Run::RemoteBlast" => 0,
    "Carp" => 0,
    "Exporter" => 0,
    "base" => 0,
    "strict" => 0,
    "utf8" => 0,
    "vars" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Bio::Root::Test" => 0,
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0,
    "lib" => 0
  },
  "VERSION" => "1.7.4",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Bio::DB::EMBL" => 0,
  "Bio::DB::GenBank" => 0,
  "Bio::DB::GenPept" => 0,
  "Bio::DB::RefSeq" => 0,
  "Bio::DB::SwissProt" => 0,
  "Bio::Root::Test" => 0,
  "Bio::Root::Version" => 0,
  "Bio::Seq" => 0,
  "Bio::SeqIO" => 0,
  "Bio::Tools::Run::RemoteBlast" => 0,
  "Carp" => 0,
  "Exporter" => 0,
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Test::More" => 0,
  "base" => 0,
  "lib" => 0,
  "strict" => 0,
  "utf8" => 0,
  "vars" => 0,
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

# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.014.
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Dump Chrome history",
  "AUTHOR" => "perlancar <perlancar\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "App-DumpChromeHistory",
  "EXE_FILES" => [
    "script/dump-chrome-history"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010001",
  "NAME" => "App::DumpChromeHistory",
  "PREREQ_PM" => {
    "Chrome::Util::Profile" => "0.004",
    "DBD::SQLite" => 0,
    "DBI" => 0,
    "Data::Sah::Coerce::perl::To_array::From_str::comma_sep" => 0,
    "Data::Sah::Compiler::perl::TH::array" => 0,
    "Data::Sah::Compiler::perl::TH::bool" => 0,
    "Data::Sah::Compiler::perl::TH::int" => 0,
    "Data::Sah::Compiler::perl::TH::str" => 0,
    "File::Copy" => 0,
    "File::Temp" => 0,
    "File::chdir" => 0,
    "List::Util" => "1.45",
    "Log::ger" => "0.037",
    "Perinci::CmdLine::Any" => 0,
    "Perinci::CmdLine::Lite" => "1.827",
    "Sah::Schema::chrome::profile_name" => 0,
    "Sah::Schema::posint" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.005",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Chrome::Util::Profile" => "0.004",
  "DBD::SQLite" => 0,
  "DBI" => 0,
  "Data::Sah::Coerce::perl::To_array::From_str::comma_sep" => 0,
  "Data::Sah::Compiler::perl::TH::array" => 0,
  "Data::Sah::Compiler::perl::TH::bool" => 0,
  "Data::Sah::Compiler::perl::TH::int" => 0,
  "Data::Sah::Compiler::perl::TH::str" => 0,
  "File::Copy" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "File::chdir" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "List::Util" => "1.45",
  "Log::ger" => "0.037",
  "Perinci::CmdLine::Any" => 0,
  "Perinci::CmdLine::Lite" => "1.827",
  "Sah::Schema::chrome::profile_name" => 0,
  "Sah::Schema::posint" => 0,
  "Test::More" => 0,
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

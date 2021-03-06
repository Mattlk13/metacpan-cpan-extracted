# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Utilities related to ffmpeg",
  "AUTHOR" => "perlancar <perlancar\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "App-FfmpegUtils",
  "EXE_FILES" => [
    "script/reencode-video-with-libx264",
    "script/split-video-by-duration"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010001",
  "NAME" => "App::FfmpegUtils",
  "PREREQ_PM" => {
    "Data::Sah::Coerce::perl::To_duration::From_float::seconds" => 0,
    "Data::Sah::Coerce::perl::To_duration::From_obj::datetime_duration" => 0,
    "Data::Sah::Coerce::perl::To_duration::From_str::human" => 0,
    "Data::Sah::Coerce::perl::To_duration::From_str::iso8601" => 0,
    "Data::Sah::Coerce::perl::To_float::From_str::percent" => 0,
    "Data::Sah::Compiler::perl::TH::array" => 0,
    "Data::Sah::Compiler::perl::TH::duration" => 0,
    "Data::Sah::Compiler::perl::TH::float" => 0,
    "Data::Sah::Compiler::perl::TH::int" => 0,
    "Data::Sah::Compiler::perl::TH::str" => 0,
    "Data::Sah::Filter::perl::Path::expand_tilde_when_on_unix" => 0,
    "Data::Sah::Filter::perl::Path::strip_slashes_when_on_unix" => 0,
    "File::Which" => 0,
    "IPC::System::Options" => "0.335",
    "Log::ger" => "0.037",
    "Math::Image::CalcResized" => "0.003",
    "Media::Info" => "0.131",
    "POSIX" => 0,
    "Perinci::CmdLine::Any" => 0,
    "Perinci::CmdLine::Lite" => "1.827",
    "Perinci::Exporter" => "0.080",
    "Perinci::Sub::DepChecker" => 0,
    "Sah::Schema::filename" => 0,
    "Sah::Schema::ufloat" => 0,
    "Sah::Schema::uint" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.009",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Data::Sah::Coerce::perl::To_duration::From_float::seconds" => 0,
  "Data::Sah::Coerce::perl::To_duration::From_obj::datetime_duration" => 0,
  "Data::Sah::Coerce::perl::To_duration::From_str::human" => 0,
  "Data::Sah::Coerce::perl::To_duration::From_str::iso8601" => 0,
  "Data::Sah::Coerce::perl::To_float::From_str::percent" => 0,
  "Data::Sah::Compiler::perl::TH::array" => 0,
  "Data::Sah::Compiler::perl::TH::duration" => 0,
  "Data::Sah::Compiler::perl::TH::float" => 0,
  "Data::Sah::Compiler::perl::TH::int" => 0,
  "Data::Sah::Compiler::perl::TH::str" => 0,
  "Data::Sah::Filter::perl::Path::expand_tilde_when_on_unix" => 0,
  "Data::Sah::Filter::perl::Path::strip_slashes_when_on_unix" => 0,
  "File::Spec" => 0,
  "File::Which" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "IPC::System::Options" => "0.335",
  "Log::ger" => "0.037",
  "Math::Image::CalcResized" => "0.003",
  "Media::Info" => "0.131",
  "POSIX" => 0,
  "Perinci::CmdLine::Any" => 0,
  "Perinci::CmdLine::Lite" => "1.827",
  "Perinci::Exporter" => "0.080",
  "Perinci::Sub::DepChecker" => 0,
  "Sah::Schema::filename" => 0,
  "Sah::Schema::ufloat" => 0,
  "Sah::Schema::uint" => 0,
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

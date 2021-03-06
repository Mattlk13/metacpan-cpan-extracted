# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.011.
use strict;
use warnings;

use 5.008003;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "build Dezi search applications",
  "AUTHOR" => "Peter Karman <karpet\@dezi.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Dezi-App",
  "EXE_FILES" => [
    "bin/deziapp",
    "bin/lucyx-dump-terms"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.008003",
  "NAME" => "Dezi::App",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Class::Load" => 0,
    "Config::General" => "2.31",
    "Data::Dump" => 0,
    "DateTime::Format::DateParse" => 0,
    "Digest::MD5" => 0,
    "File::Basename" => 0,
    "File::Rules" => "0.02",
    "File::Spec" => 0,
    "File::Temp" => 0,
    "HTTP::Date" => 0,
    "Lucy" => "0.006002",
    "Moose" => 0,
    "MooseX::Getopt" => 0,
    "MooseX::StrictConstructor" => 0,
    "MooseX::Types::DateTime" => 0,
    "MooseX::Types::Path::Class" => 0,
    "MooseX::XSAccessor" => 0,
    "Path::Class" => "0.32",
    "Path::Class::File::Lockable" => 0,
    "Path::Class::File::Stat" => "0.05",
    "SWISH::3" => "1.000015",
    "SWISH::Filter" => "0.191",
    "Scalar::Util" => 0,
    "Search::Query" => "0.307",
    "Search::Query::Dialect::Lucy" => "0.202",
    "Search::Tools" => "1.000",
    "Sort::SQL" => 0,
    "Sys::Hostname" => 0,
    "Text::ParseWords" => 0,
    "Time::HiRes" => 0,
    "Try::Tiny" => 0,
    "Type::Tiny" => 0,
    "Types::Standard" => 0,
    "namespace::autoclean" => 0
  },
  "TEST_REQUIRES" => {
    "CAM::PDF" => 0,
    "Compress::Zlib" => 0,
    "Test::LeakTrace" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.016",
  "test" => {
    "TESTS" => "t/*.t t/lucy/*.t"
  }
);


my %FallbackPrereqs = (
  "CAM::PDF" => 0,
  "Carp" => 0,
  "Class::Load" => 0,
  "Compress::Zlib" => 0,
  "Config::General" => "2.31",
  "Data::Dump" => 0,
  "DateTime::Format::DateParse" => 0,
  "Digest::MD5" => 0,
  "File::Basename" => 0,
  "File::Rules" => "0.02",
  "File::Spec" => 0,
  "File::Temp" => 0,
  "HTTP::Date" => 0,
  "Lucy" => "0.006002",
  "Moose" => 0,
  "MooseX::Getopt" => 0,
  "MooseX::StrictConstructor" => 0,
  "MooseX::Types::DateTime" => 0,
  "MooseX::Types::Path::Class" => 0,
  "MooseX::XSAccessor" => 0,
  "Path::Class" => "0.32",
  "Path::Class::File::Lockable" => 0,
  "Path::Class::File::Stat" => "0.05",
  "SWISH::3" => "1.000015",
  "SWISH::Filter" => "0.191",
  "Scalar::Util" => 0,
  "Search::Query" => "0.307",
  "Search::Query::Dialect::Lucy" => "0.202",
  "Search::Tools" => "1.000",
  "Sort::SQL" => 0,
  "Sys::Hostname" => 0,
  "Test::LeakTrace" => 0,
  "Test::More" => 0,
  "Text::ParseWords" => 0,
  "Time::HiRes" => 0,
  "Try::Tiny" => 0,
  "Type::Tiny" => 0,
  "Types::Standard" => 0,
  "namespace::autoclean" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

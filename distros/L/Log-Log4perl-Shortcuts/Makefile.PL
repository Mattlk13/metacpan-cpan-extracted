# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker;

use File::ShareDir::Install;
$File::ShareDir::Install::INCLUDE_DOTFILES = 1;
$File::ShareDir::Install::INCLUDE_DOTDIRS = 1;
install_share dist => "config";


my %WriteMakefileArgs = (
  "ABSTRACT" => "shortcut functions to make log4perl even easier",
  "AUTHOR" => "Steve Dondley <s\@dondley.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::ShareDir::Install" => "0.06"
  },
  "DISTNAME" => "Log-Log4perl-Shortcuts",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010000",
  "NAME" => "Log::Log4perl::Shortcuts",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Data::Dumper" => 0,
    "Exporter" => 0,
    "File::UserConfig" => 0,
    "Log::Log4perl" => 0,
    "Log::Log4perl::Level" => 0,
    "Module::Data" => 0,
    "Path::Tiny" => 0
  },
  "TEST_REQUIRES" => {
    "File::Copy" => 0,
    "File::HomeDir" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "File::UserConfig" => 0,
    "Test::Exception" => 0,
    "Test::Fatal" => 0,
    "Test::File::ShareDir::Dist" => 0,
    "Test::File::ShareDir::Module" => 0,
    "Test::More" => 0,
    "Test::NoWarnings" => 0,
    "Test::Output" => 0,
    "Test::Warn" => 0,
    "lib" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.024",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Data::Dumper" => 0,
  "Exporter" => 0,
  "File::Copy" => 0,
  "File::HomeDir" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "File::UserConfig" => 0,
  "Log::Log4perl" => 0,
  "Log::Log4perl::Level" => 0,
  "Module::Data" => 0,
  "Path::Tiny" => 0,
  "Test::Exception" => 0,
  "Test::Fatal" => 0,
  "Test::File::ShareDir::Dist" => 0,
  "Test::File::ShareDir::Module" => 0,
  "Test::More" => 0,
  "Test::NoWarnings" => 0,
  "Test::Output" => 0,
  "Test::Warn" => 0,
  "lib" => 0,
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

if ( $^O =~ /win/i ) {
	$WriteMakefileArgs{PREREQ_PM}{'Log::Log4perl'} = $FallbackPrereqs{'Log::Log4perl'} = '<= 1.47';
}

WriteMakefile(%WriteMakefileArgs);

{
package
MY;
use File::ShareDir::Install qw(postamble);
}

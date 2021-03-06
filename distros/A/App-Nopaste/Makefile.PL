# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.013.
use strict;
use warnings;

use 5.008003;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Easy access to any pastebin",
  "AUTHOR" => "Shawn M Moore, <sartak\@gmail.com>",
  "CONFIGURE_REQUIRES" => {
    "CPAN::Meta::Requirements" => "2.120620",
    "ExtUtils::MakeMaker" => 0,
    "Module::Metadata" => 0
  },
  "DISTNAME" => "App-Nopaste",
  "EXE_FILES" => [
    "script/nopaste"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.008003",
  "NAME" => "App::Nopaste",
  "PREREQ_PM" => {
    "Class::Load" => 0,
    "Exporter" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "Getopt::Long::Descriptive" => 0,
    "JSON::MaybeXS" => 0,
    "LWP::UserAgent" => 0,
    "Module::Pluggable" => 0,
    "Module::Runtime" => 0,
    "POSIX" => 0,
    "Path::Tiny" => 0,
    "URI::Escape" => 0,
    "WWW::Mechanize" => 0,
    "namespace::clean" => "0.19",
    "parent" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "LWP::Protocol" => 0,
    "Test::Deep" => 0,
    "Test::Fatal" => 0,
    "Test::More" => "0.88"
  },
  "VERSION" => "1.013",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Class::Load" => 0,
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "Getopt::Long::Descriptive" => 0,
  "JSON::MaybeXS" => 0,
  "LWP::Protocol" => 0,
  "LWP::UserAgent" => 0,
  "Module::Pluggable" => 0,
  "Module::Runtime" => 0,
  "POSIX" => 0,
  "Path::Tiny" => 0,
  "Test::Deep" => 0,
  "Test::Fatal" => 0,
  "Test::More" => "0.88",
  "URI::Escape" => 0,
  "WWW::Mechanize" => 0,
  "namespace::clean" => "0.19",
  "parent" => 0,
  "strict" => 0,
  "warnings" => 0
);

# inserted by Dist::Zilla::Plugin::DynamicPrereqs 0.035
requires('WWW::Pastebin::PastebinCom::Create', '1.003')
  if has_module('WWW::Pastebin::PastebinCom::Create', '1.003')
    || prompt('install pastebin.com support? [y/N]', 'N') =~ /^y/i;
requires('Clipboard')
  if has_module('Clipboard')
    || prompt('install copying of URLs with -x/--copy? [y/N]', 'N') =~ /^y/i;
requires('Browser::Open')
  if has_module('Browser::Open')
    || prompt('install opening of URLs in a browser with --open_url/--open/-o? [y/N]', 'N') =~ /^y/i;


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

# inserted by Dist::Zilla::Plugin::DynamicPrereqs 0.035
sub _add_prereq {
  my ($mm_key, $module, $version_or_range) = @_;
  $version_or_range ||= 0;
  warn "$module already exists in $mm_key (at version $WriteMakefileArgs{$mm_key}{$module}) -- need to do a sane metamerge!"
    if exists $WriteMakefileArgs{$mm_key}{$module}
      and $WriteMakefileArgs{$mm_key}{$module} ne '0'
      and $WriteMakefileArgs{$mm_key}{$module} ne $version_or_range;
  warn "$module already exists in FallbackPrereqs (at version $WriteMakefileArgs{$mm_key}{$module}) -- need to do a sane metamerge!"
    if exists $FallbackPrereqs{$module} and $FallbackPrereqs{$module} ne '0'
        and $FallbackPrereqs{$module} ne $version_or_range;
  $WriteMakefileArgs{$mm_key}{$module} = $FallbackPrereqs{$module} = $version_or_range;
  return;
}

sub has_module {
  my ($module, $version_or_range) = @_;
  require Module::Metadata;
  my $mmd = Module::Metadata->new_from_module($module);
  return undef if not $mmd;
  return $mmd->version($module) if not defined $version_or_range;

  require CPAN::Meta::Requirements;
  my $req = CPAN::Meta::Requirements->new;
  $req->add_string_requirement($module => $version_or_range);
  return 1 if $req->accepts_module($module => $mmd->version($module));
  return 0;
}

sub requires { goto &runtime_requires }

sub runtime_requires {
  my ($module, $version_or_range) = @_;
  _add_prereq(PREREQ_PM => $module, $version_or_range);
}

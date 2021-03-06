
# This file was automatically generated by Dist::Zilla::Plugin::ModuleBuild v6.008.
use strict;
use warnings;

use Module::Build 0.28;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.28"
  },
  "configure_requires" => {
    "ExtUtils::MakeMaker" => 0,
    "Module::Build" => "0.28"
  },
  "dist_abstract" => "dump directory structures' meta-data in a consistent and machine-readable way.",
  "dist_author" => [
    "Shlomi Fish <shlomif\@cpan.org>"
  ],
  "dist_name" => "File-Dir-Dumper",
  "dist_version" => "v0.4.0",
  "license" => "mit",
  "module_name" => "File::Dir::Dumper",
  "recursive_test_files" => 1,
  "requires" => {
    "Carp" => 0,
    "Class::XSAccessor" => 0,
    "Devel::CheckOS" => 0,
    "Digest" => 0,
    "File::Basename" => 0,
    "File::Find::Object" => "v0.1.2",
    "File::Path" => "2.00",
    "File::Spec" => 0,
    "Getopt::Long" => "2.36",
    "JSON::MaybeXS" => 0,
    "List::Util" => 0,
    "POSIX" => 0,
    "Pod::Usage" => 0,
    "autodie" => 0,
    "parent" => 0,
    "perl" => "5.012",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [
    "bin/dir-dump"
  ],
  "test_requires" => {
    "Digest::MD5" => 0,
    "Digest::SHA" => 0,
    "English" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "IO::Handle" => 0,
    "IO::String" => 0,
    "IPC::Open3" => 0,
    "Test::More" => "0.88",
    "blib" => "1.01",
    "lib" => 0
  }
);


my %fallback_build_requires = (
  "Digest::MD5" => 0,
  "Digest::SHA" => 0,
  "English" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "IO::Handle" => 0,
  "IO::String" => 0,
  "IPC::Open3" => 0,
  "Module::Build" => "0.28",
  "Test::More" => "0.88",
  "blib" => "1.01",
  "lib" => 0
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);


$build->create_build_script;

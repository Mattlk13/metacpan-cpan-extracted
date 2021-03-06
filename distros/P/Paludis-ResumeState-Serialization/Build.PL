
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.4008"
  },
  "configure_requires" => {
    "Module::Build" => "0.4008"
  },
  "dist_abstract" => "Work with resume-files generated by Paludis",
  "dist_author" => [
    "Kent Fredric <kentnl\@cpan.org>"
  ],
  "dist_name" => "Paludis-ResumeState-Serialization",
  "dist_version" => "0.01000410",
  "license" => "perl",
  "module_name" => "Paludis::ResumeState::Serialization",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Carp" => 0,
    "Class::Load" => "0.06",
    "English" => 0,
    "Params::Util" => 0,
    "Regexp::Grammars" => 0,
    "Regexp::Grammars::Common::String" => 0,
    "autovivification" => 0,
    "perl" => "5.010",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [],
  "test_requires" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IO::Uncompress::Gunzip" => 0,
    "IPC::Open3" => 0,
    "Scalar::Util" => 0,
    "Test::More" => "1.001002"
  }
);


my %fallback_build_requires = (
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IO::Uncompress::Gunzip" => 0,
  "IPC::Open3" => 0,
  "Module::Build" => "0.4008",
  "Scalar::Util" => 0,
  "Test::More" => "1.001002"
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;

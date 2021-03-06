use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
   module_name => 'IO::Async::Loop::EV',
   requires => {
      'IO::Async::Loop' => '0.49',
      'IO::Async::Metrics' => 0,
      'EV' => 0,
   },
   test_requires => {
      'IO::Async::LoopTests' => '0.76',
      'Test::More' => '0.88', # done_testing
   },
   configure_requires => {
      'Module::Build' => '0.4004', # test_requires
   },
   license => 'perl',
   create_license => 1,
   create_readme  => 1,
);

$build->create_build_script;

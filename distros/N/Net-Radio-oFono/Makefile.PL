# Note: this file was auto-generated by Module::Build::Compat version 0.40
require 5.010;
use ExtUtils::MakeMaker;
WriteMakefile
(
  'PL_FILES' => {},
  'INSTALLDIRS' => 'site',
  'NAME' => 'Net::Radio::oFono',
  'EXE_FILES' => [],
  'VERSION_FROM' => 'lib/Net/Radio/oFono.pm',
  'PREREQ_PM' => {
                   'Scalar::Util' => 0,
                   'Hash::MoreUtils' => '0.02',
                   'Carp::Assert' => '0.18',
                   'Log::Any::Adapter' => 0,
                   'Log::Any' => '0.10',
                   'Test::More' => '0.90',
                   'List::Util' => 0,
                   'Params::Util' => '0.37',
                   'Net::DBus' => '1.000000',
                   'List::MoreUtils' => '0.22'
                 }
)
;

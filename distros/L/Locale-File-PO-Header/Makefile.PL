# Note: this file was auto-generated by Module::Build::Compat version 0.4218
require 5.006;
use ExtUtils::MakeMaker;
WriteMakefile
(
  'PL_FILES' => {},
  'INSTALLDIRS' => 'site',
  'PREREQ_PM' => {
                   'namespace::autoclean' => 0,
                   'Clone' => 0,
                   'Test::Differences' => '0.60',
                   'Moose' => 0,
                   'Test::NoWarnings' => '1.03',
                   'Test::Exception' => 0,
                   'Test::More' => 0,
                   'MooseX::StrictConstructor' => 0,
                   'Moose::Util::TypeConstraints' => 0
                 },
  'VERSION_FROM' => 'lib/Locale/File/PO/Header.pm',
  'EXE_FILES' => [],
  'NAME' => 'Locale::File::PO::Header'
)
;

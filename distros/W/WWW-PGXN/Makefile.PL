# Note: this file was auto-generated by Module::Build::Compat version 0.4007
require 5.010;
use ExtUtils::MakeMaker;
WriteMakefile
(
  'NAME' => 'WWW::PGXN',
  'VERSION_FROM' => 'lib/WWW/PGXN.pm',
  'PREREQ_PM' => {
                   'Carp' => 0,
                   'File::Spec' => 0,
                   'File::Spec::Functions' => 0,
                   'HTTP::Tiny' => 0,
                   'JSON' => 0,
                   'Module::Build' => '0.30',
                   'Test::MockModule' => '0.05',
                   'Test::More' => '0.96',
                   'URI::Template' => '0.16'
                 },
  'INSTALLDIRS' => 'site',
  'EXE_FILES' => [],
  'PL_FILES' => {}
)
;

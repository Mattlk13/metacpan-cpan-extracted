# Note: this file was auto-generated by Module::Build::Compat version 0.4214
use ExtUtils::MakeMaker;
WriteMakefile
(
  'VERSION_FROM' => 'lib/WriteAt.pm',
  'EXE_FILES' => [
                   'scripts/atom2file',
                   'scripts/writeat'
                 ],
  'NAME' => 'WriteAt',
  'PREREQ_PM' => {
                   'Template' => '2.24',
                   'Perl6::Pod' => '0.71',
                   'Regexp::Grammars' => '1.042',
                   'DateTime::Format::W3CDTF' => 0,
                   'Perl6::Pod::Lib' => '0.13'
                 },
  'PL_FILES' => {},
  'INSTALLDIRS' => 'site'
)
;

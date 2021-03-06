use strict;
use warnings;
use ExtUtils::MakeMaker;

my %options = %{
{
  'TYPEMAPS' => [],
  'NAME' => 'Math::MPFR::Random',
  'LIBS' => '-lmpfr -lgmp',
  'VERSION_FROM' => 'Random.pm',
}
};
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }

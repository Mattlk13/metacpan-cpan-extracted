use ExtUtils::MakeMaker;
my %options = %{
{
  'TYPEMAPS' => [
    '/usr/share/perl/5.10/ExtUtils/typemap'
  ],
  'NAME' => 'benchmark_pl_b905',
  'INC' => '-I/home/st47/sit-bmelab-labview/EANN/ANN/examples',
  'VERSION' => '0.00'
}
};
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }

use 5.005;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Net::ChooseFName',
    VERSION_FROM      => 'lib/Net/ChooseFName.pm', # finds $VERSION
    PREREQ_PM         => {'Test::More'  =>  0}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Net/ChooseFName.pm', # retrieve abstract from module
       AUTHOR         => 'Ilya Zakharevich <ilyaz@cpan.org>') : ()),
);

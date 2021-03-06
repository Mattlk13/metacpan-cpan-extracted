use 5.006001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Acme::Oil',
    'VERSION_FROM'	=> 'lib/Acme/Oil.pm', # finds $VERSION
    'PREREQ_PM'		=> {Test::More => 0}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT => 'lib/Acme/Oil.pm', # retrieve abstract from module
       AUTHOR     => 'Makamaka Hannyaharamitu, E<lt>makamaka[at]cpan.orgE<gt>') : ()),
);

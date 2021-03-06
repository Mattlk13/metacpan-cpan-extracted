use 5.008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

print <<"*EOF*";
-----------------------------------------------------------
    MasonX::Apache2Handler is an EXPERIMENTAL BETA RELEASE!
       Please install and use it only on a test system.
    (But it really, really works! The brave-hearted can use
                    it in production.)
                      Aloha => Beau;
-----------------------------------------------------------
*EOF*
    sleep 3;

WriteMakefile(
    NAME              => 'MasonX::Apache2Handler',
    VERSION_FROM      => 'lib/MasonX/Apache2Handler.pm', # finds $VERSION
    PREREQ_PM         => 
	      {
		  mod_perl => 1.9910,
		  'HTML::Mason' => 1.25,
		  'Apache::Request' => '2.02-dev',
		  'Apache::Cookie' => '2.02-dev',
	      }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/MasonX/Apache2Handler.pm', # retrieve abstract from module
       AUTHOR         => 'Beau E. Cox <mason@beaucox.com>') : ()),
);

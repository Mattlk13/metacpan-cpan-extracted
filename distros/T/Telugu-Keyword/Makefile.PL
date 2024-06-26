use 5.026001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Telugu::Keyword',
    VERSION_FROM      => 'lib/Telugu/Keyword.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {'Mouse' => '0', 'Keyword::Declare' => '0'}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/Telugu/Keyword.pm', # retrieve abstract from module
    AUTHOR            => '',
    EXE_FILES         => ['script/shoba'],
	#Value must be from legacy list of licenses here
    #http://search.cpan.org/perldoc?Module%3A%3ABuild%3A%3AAPI
);

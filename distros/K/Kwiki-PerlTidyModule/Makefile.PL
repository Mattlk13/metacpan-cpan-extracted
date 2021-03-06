use inc::Module::Install;

name('Kwiki-PerlTidyModule');
author('Brian Ingerson <ingy@cpan.org>');
abstract('Kwiki Perl::Tidy Module Plugin');
license('perl');
version_from('lib/Kwiki/PerlTidyModule.pm');

requires(qw(
    perl 5.6.1
    Kwiki 0.37
    Kwiki::Cache 0.11
    Perl::Tidy 20031021
));

check_nmake();

&WriteAll();

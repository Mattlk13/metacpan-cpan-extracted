# -*-Perl-*-
BEGIN { unshift @INC, 'blib/lib' }
use CGI::Debug( report => 'errors', to => { file => "/tmp/a$$" } );
use strict;

compile error!

print "Content-type: text/html\n\n";
print "a1\n";



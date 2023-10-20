#!perl
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'WWW::Crawl' ) || print "Bail out!\n";
}

diag( "Testing WWW::Crawl $WWW::Crawl::VERSION, Perl $], $^X" );

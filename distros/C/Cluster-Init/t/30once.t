#!/usr/bin/perl -w
# vim:set syntax=perl:
use strict;
use Test;
require "t/utils.pl";

# BEGIN { plan tests => 14, todo => [3,4] }
BEGIN { plan tests => 12 }

use Cluster::Init;

my %parms = (
    'cltab' => 't/cltab',
    'socket' => 't/clinit.s'
	    );

unless (fork())
{
  my $init = daemon Cluster::Init (%parms);
  exit;
}
sleep 1;
my $init = client Cluster::Init (%parms);

`cat /dev/null > t/out`;
ok(lines(),0);
$init->tell("hellogrp",4);
sleep 1;
ok(lines(),1);
ok(lastline(),1);
sleep 2;
ok(lines(),2);
ok(lastline(),2);
sleep 2;
ok(lines(),3);
ok(lastline(),3);
sleep 1;
ok(lines(),3);
ok(lastline(),3);
sleep 2;
ok(lines(),3);
ok(lastline(),3);

$init->shutdown();
ok(1);

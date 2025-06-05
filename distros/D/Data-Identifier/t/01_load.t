#!/usr/bin/perl -w

use v5.10;
use lib 'lib', '../lib'; # able to run prove in project dir and .t locally

use Test::More tests => 6;

use_ok('Data::Identifier');
use_ok('Data::Identifier::Wellknown');
use_ok('Data::Identifier::Generate');
use_ok('Data::Identifier::Cloudlet');
use_ok('Data::Identifier::Interface::Known');
use_ok('Data::Identifier::Interface::Userdata');

exit 0;

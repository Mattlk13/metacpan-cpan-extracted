#!/usr/bin/env perl

package Prty::SoapWsdlServiceCgi::Demo::Test;
use base qw/Prty::Test::Class/;

use strict;
use warnings;
use v5.10.0;

# -----------------------------------------------------------------------------

sub test_loadClass : Init(1) {
    shift->useOk('Prty::SoapWsdlServiceCgi::Demo');
}

# -----------------------------------------------------------------------------

package main;
Prty::SoapWsdlServiceCgi::Demo::Test->runTests;

# eof

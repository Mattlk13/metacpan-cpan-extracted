#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use Test::More;
use FindBin '$Bin';
use Data::Dumper;
use YAML::Perl::Loader;

eval {
    my $yppl = YAML::Perl::Loader->new( boolean => 'bla' );
};
my $error = $@;
cmp_ok($error, '=~', 'Invalid value', "Invalid value for 'boolean'");

eval {
    my $yppl = YAML::Perl::Loader->new( bool => 'bla' );
};
$error = $@;
cmp_ok($error, '=~', 'Unexpected arguments', "Unexpected arguments");

done_testing;

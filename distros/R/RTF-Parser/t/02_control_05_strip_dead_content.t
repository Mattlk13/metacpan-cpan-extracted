#!/usr/bin/perl

use strict;
use warnings;

use RTF::TEXT::Converter;
use Test::More tests => 1;

my $output;

my $object = RTF::TEXT::Converter->new(   
	output => \$output
);

my $data = join '', (<DATA>);

$object->parse_string( $data );

$output =~ s/\s+$//;

is( $output, "Macro e-mail outlook", "Content after last } stripped" );

__DATA__
{\rtf1\ansi\deff0{\fonttbl{\f0\fnil\fcharset0 Courier New;}}
\viewkind4\uc1\pard\lang1033\f0\fs20 Macro e-mail outlook \par
}
asdf 
ddd
asdfasdfasdfas
dfasdfffffffffffffffffffffffffffffffffffffffffffffffff


sdaaaaaaaaaaaafffffffffffffffffffffffasdf

asdfasdf







234asefasdfasdrasdrasdrd





asdf

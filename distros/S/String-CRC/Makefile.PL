#! /usr/local/bin/perl

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile being created.
WriteMakefile(
	'NAME' => 'String::CRC',
	'DISTNAME' => 'String-CRC',
	'VERSION' => '1.0',
	'OBJECT' => 'CRC.o',
	'dist'   => {COMPRESS=>'gzip', SUFFIX=>'gz'}
);

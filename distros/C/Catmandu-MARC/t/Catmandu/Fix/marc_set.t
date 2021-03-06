#!perl

use strict;
use warnings;
use Test::More;
use Test::Exception;
use Catmandu::Importer::MARC;
use Catmandu::Fix;
use utf8;

my $pkg;

BEGIN {
    $pkg = 'Catmandu::Fix::marc_set';
    use_ok $pkg;
}

require_ok $pkg;

my $fixer = Catmandu::Fix->new(fixes => [q|marc_set('LDR/0-3','XXX')|,q|marc_map('LDR','leader')|]);
my $importer = Catmandu::Importer::MARC->new( file => 't/camel.mrc', type => "ISO" );
my $record = $fixer->fix($importer->first);

like $record->{leader}, qr/^XXX/, q|fix: marc_set('LDR/0-3','XXX');|;

#---
{
	$fixer = Catmandu::Fix->new(fixes => [q|marc_set('100x','XXX')|,q|marc_map('100x','test')|]);
	$importer = Catmandu::Importer::MARC->new( file => 't/camel.mrc', type => "ISO" );
	$record = $fixer->fix($importer->first);

	like $record->{test}, qr/^XXX$/, q|fix: marc_set('100x','XXX');|;
}

#---
{
	$fixer = Catmandu::Fix->new(fixes => [q|marc_set('100[1]a','XXX')|,q|marc_map('100a','test')|]);
	$importer = Catmandu::Importer::MARC->new( file => 't/camel.mrc', type => "ISO" );
	$record = $fixer->fix($importer->first);

	like $record->{test}, qr/^XXX$/, q|fix: marc_set('100[1]a','XXX');|;
}

#---
{
	$fixer = Catmandu::Fix->new(fixes => [
		q|add_field(my.deep.field,XXX)|,
		q|marc_set('100[1]a','$.my.deep.field')|,
		q|marc_map('100a','test')|
	]);
	$importer = Catmandu::Importer::MARC->new( file => 't/camel.mrc', type => "ISO" );
	$record = $fixer->fix($importer->first);

	like $record->{test}, qr/^XXX$/, q|fix: marc_set('100[1]a','$.my.deep.field'');|;
}

done_testing;

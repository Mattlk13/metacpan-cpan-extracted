=head1

Locale::CLDR::Locales::En::Any::To - Package for language English

=cut

package Locale::CLDR::Locales::En::Any::To;
# This file auto generated from Data\common\main\en_TO.xml
#	on Sun  5 Aug  5:58:37 pm GMT

use strict;
use warnings;
use version;

our $VERSION = version->declare('v0.33.0');

use v5.10.1;
use mro 'c3';
use utf8;
use if $^V ge v5.12.0, feature => 'unicode_strings';
use Types::Standard qw( Str Int HashRef ArrayRef CodeRef RegexpRef );
use Moo;

extends('Locale::CLDR::Locales::En::Any::001');
has 'currencies' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'TOP' => {
			symbol => 'T$',
		},
	} },
);


no Moo;

1;

# vim: tabstop=4

=encoding utf8

=head1 NAME

Locale::CLDR::Locales::Ff::Adlm::Ng - Package for language Fulah

=cut

package Locale::CLDR::Locales::Ff::Adlm::Ng;
# This file auto generated from Data\common\main\ff_Adlm_NG.xml
#	on Sun  7 Jan  2:30:41 pm GMT

use strict;
use warnings;
use version;

our $VERSION = version->declare('v0.40.1');

use v5.10.1;
use mro 'c3';
use utf8;
use if $^V ge v5.12.0, feature => 'unicode_strings';
use Types::Standard qw( Str Int HashRef ArrayRef CodeRef RegexpRef );
use Moo;

extends('Locale::CLDR::Locales::Ff::Adlm');
has 'currencies' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'GNF' => {
			symbol => 'GNF',
		},
		'NGN' => {
			symbol => '₦',
		},
	} },
);


no Moo;

1;

# vim: tabstop=4

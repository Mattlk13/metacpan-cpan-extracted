=encoding utf8

=head1 NAME

Locale::CLDR::Locales::Nb - Package for language Norwegian Bokmål

=cut

package Locale::CLDR::Locales::Nb;
# This file auto generated from Data\common\main\nb.xml
#	on Fri 17 Jan 12:03:31 pm GMT

use strict;
use warnings;
use version;

our $VERSION = version->declare('v0.46.0');

use v5.12.0;
use mro 'c3';
use utf8;
use feature 'unicode_strings';
use Types::Standard qw( Str Int HashRef ArrayRef CodeRef RegexpRef );
use Moo;

extends('Locale::CLDR::Locales::No');
has 'algorithmic_number_format_data' => (
    is => 'ro',
    isa => HashRef,
    init_arg => undef,
    default => sub {
        use bigfloat;
        return {
    } },
);

no Moo;

1;

# vim: tabstop=4

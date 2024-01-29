=encoding utf8

=head1 NAME

Locale::CLDR::Locales::Ff::Adlm - Package for language Fulah

=cut

package Locale::CLDR::Locales::Ff::Adlm;
# This file auto generated from Data\common\main\ff_Adlm.xml
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

extends('Locale::CLDR::Locales::Ff');
# Need to add code for Key type pattern
sub display_name_pattern {
	my ($self, $name, $region, $script, $variant) = @_;

	my $display_pattern = '{0} ({1})';
	$display_pattern =~s/\{0\}/$name/g;
	my $subtags = join '{0}⹁ {1}', grep {$_} (
		$region,
		$script,
		$variant,
	);

	$display_pattern =~s/\{1\}/$subtags/g;
	return $display_pattern;
}

has 'display_name_language' => (
	is			=> 'ro',
	isa			=> CodeRef,
	init_arg	=> undef,
	default		=> sub {
		 sub {
			 my %languages = (
				'aa' => '𞤀𞤬𞤢𞥄𞤪𞤫',
 				'af' => '𞤀𞤬𞤪𞤭𞤳𞤢𞤲𞤪𞤫',
 				'ak' => '𞤀𞤳𞤢𞤲𞤪𞤫',
 				'am' => '𞤀𞤥𞤸𞤢𞤪𞤭𞥅𞤪𞤫',
 				'an' => '𞤀𞤪𞤢𞤺𞤮𞤲𞤪𞤫',
 				'anp' => '𞤀𞤲𞤺𞤭𞤳𞤢𞥄𞤪𞤫',
 				'ar' => '𞤀𞥄𞤪𞤢𞤦𞤫𞥅𞤪𞤫',
 				'ar_001' => '𞤀𞥄𞤪𞤢𞤦𞤫𞥅𞤪𞤫 𞤊𞤵𞤧𞤸𞤢 𞤒𞤫𞤲𞤯𞤵𞤳𞤢',
 				'arp' => '𞤀𞤪𞤢𞤨𞤢𞤸𞤮𞥅𞤪𞤫',
 				'as' => '𞤀𞤧𞤢𞤥𞤫𞥅𞤪𞤫',
 				'asa' => '𞤀𞤧𞤵𞥅𞤪𞤫',
 				'ast' => '𞤀𞤧𞤼𞤵𞤪𞤭𞥅𞤪𞤫',
 				'av' => '𞤀𞤬𞤱𞤢𞤪𞤭𞥅𞤪𞤫',
 				'awa' => '𞤀𞤱𞤢𞤣𞤭𞥅𞤪𞤫',
 				'ay' => '𞤀𞤴𞤥𞤢𞤪𞤢𞥄𞤪𞤫',
 				'az' => '𞤀𞤶𞤢𞤪𞤦𞤢𞤴𞤭𞤶𞤢𞤲𞤭𞥅𞤪𞤫',
 				'az@alt=short' => '𞤀𞤶𞤢𞤪𞤭𞥅𞤪𞤫',
 				'ba' => '𞤄𞤢𞤧𞤳𞤭𞥅𞤪𞤫',
 				'ban' => '𞤄𞤢𞥄𞤤𞤭𞥅𞤪𞤫',
 				'bas' => '𞤄𞤢𞤧𞤢𞥄𞤪𞤫',
 				'be' => '𞤄𞤫𞤤𞤢𞤪𞤭𞥅𞤧𞤭𞥅𞤪𞤫',
 				'bem' => '𞤄𞤫𞤥𞤦𞤢𞥄𞤪𞤫',
 				'bez' => '𞤄𞤫𞤲𞤢𞥄𞤪𞤫',
 				'bg' => '𞤄𞤭𞤤𞤺𞤢𞥄𞤪𞤫',
 				'bho' => '𞤄𞤮𞤧𞤨𞤵𞤪𞤭𞥅𞤪𞤫',
 				'bi' => '𞤄𞤭𞤧𞤤𞤢𞤥𞤢𞥄𞤪𞤫',
 				'bin' => '𞤄𞤭𞤲𞤭𞥅𞤪𞤫',
 				'bm' => '𞤄𞤢𞤥𞤦𞤢𞤪𞤢𞥄𞤪𞤫',
 				'bn' => '𞤄𞤫𞤲𞤺𞤢𞤤𞤭𞥅𞤪𞤫',
 				'br' => '𞤄𞤫𞤪𞤫𞤼𞤮𞤲𞤪𞤫',
 				'brx' => '𞤄𞤮𞤣𞤮𞥅𞤪𞤫',
 				'bs' => '𞤄𞤮𞤧𞤲𞤭𞤴𞤢𞥄𞤪𞤫',
 				'bug' => '𞤄𞤵𞤺𞤭𞤧𞤢𞥄𞤪𞤫',
 				'byn' => '𞤄𞤭𞤤𞤭𞤲𞤪𞤫',
 				'ca' => '𞤑𞤢𞤼𞤢𞤤𞤢𞤲𞤪𞤫',
 				'ce' => '𞤕𞤫𞤷𞤫𞤲𞤪𞤫',
 				'ceb' => '𞤅𞤫𞤦𞤱𞤢𞤲𞤮𞥅𞤪𞤫',
 				'cgg' => '𞤕𞤭𞤺𞤢𞥄𞤪𞤫',
 				'ch' => '𞤕𞤢𞤥𞤮𞤪𞤮𞥅𞤪𞤫',
 				'chk' => '𞤕𞤵𞥅𞤳𞤵𞥅𞤪𞤫',
 				'cho' => '𞤕𞤢𞤸𞤼𞤢𞥄𞤪𞤫',
 				'chr' => '𞤕𞤫𞥅𞤪𞤮𞤳𞤭𞥅𞤪𞤫',
 				'chy' => '𞤅𞤢𞥄𞤴𞤢𞤲𞤪𞤫',
 				'ckb' => '𞤑𞤵𞤪𞤣𞤵𞥅𞤪𞤫',
 				'co' => '𞤑𞤮𞤪𞤧𞤭𞤳𞤢𞥄𞤪𞤫',
 				'cs' => '𞤕𞤫𞤳𞤧𞤭𞤲𞤢𞥄𞤪𞤫',
 				'cy' => '𞤘𞤢𞤤𞤭𞤲𞤳𞤮𞥅𞤪𞤫',
 				'da' => '𞤁𞤢𞥄𞤲𞤭𞤧𞤳𞤮𞥅𞤪𞤫',
 				'dak' => '𞤁𞤢𞤳𞤮𞤼𞤢𞥄𞤪𞤫',
 				'dar' => '𞤁𞤢𞤪𞤺𞤭𞤲𞤢𞥄𞤪𞤫',
 				'de' => '𞤔𞤫𞤪𞤥𞤢𞤲𞤭𞤲𞤳𞤮𞥅𞤪𞤫',
 				'de_AT' => '𞤔𞤫𞤪𞤥𞤢𞤲𞤭𞤲𞤳𞤮𞥅𞤪𞤫 𞤌𞤼𞤭𞤪𞤧𞤢',
 				'de_CH' => '𞤔𞤫𞤪𞤥𞤢𞤲𞤭𞤲𞤳𞤮𞥅𞤪𞤫 𞤅𞤵𞤱𞤭𞥅𞤧',
 				'dje' => '𞤔𞤢𞤪𞤥𞤢𞥄𞤪𞤫',
 				'dua' => '𞤁𞤵𞤱𞤢𞤤𞤢𞥄𞤪𞤫',
 				'dv' => '𞤁𞤭𞥅𞤬𞤫𞤸𞤭𞥅𞤪𞤫',
 				'dyo' => '𞤔𞤮𞥅𞤤𞤢𞥄𞤪𞤫',
 				'dz' => '𞤄𞤵𞥅𞤼𞤢𞤲𞤪𞤫',
 				'dzg' => '𞤁𞤢𞤶𞤢𞤺𞤢𞥄𞤪𞤫',
 				'en' => '𞤉𞤲𞤺𞤭𞤤𞤫𞥅𞤪𞤫',
 				'en_AU' => '𞤉𞤲𞤺𞤭𞤤𞤫𞥅𞤪𞤫 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞤲𞤳𞤮𞥅𞤪𞤫',
 				'en_CA' => '𞤉𞤲𞤺𞤭𞤤𞤫𞥅𞤪𞤫 𞤑𞤢𞤲𞤢𞤣𞤢𞤲𞤳𞤮𞥅𞤪𞤫',
 				'en_GB' => '𞤉𞤲𞤺𞤭𞤤𞤫𞥅𞤪𞤫 𞤄𞤭𞤪𞤼𞤢𞤲𞤳𞤮𞥅𞤪𞤫',
 				'en_GB@alt=short' => '𞤉𞤲𞤺𞤭𞤤𞤫𞥅𞤪𞤫 𞤁𞤘',
 				'en_US' => '𞤉𞤲𞤺𞤭𞤤𞤫𞥅𞤪𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞤲𞤳𞤮𞤪𞤫',
 				'en_US@alt=short' => '𞤉𞤲𞤺𞤭𞤤𞤫𞥅𞤪𞤫 𞤁𞤂𞤀',
 				'es' => '𞤅𞤭𞤨𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮𞥅𞤪𞤫',
 				'es_419' => '𞤅𞤭𞤨𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮𞥅𞤪𞤫 𞤀𞤥𞤭𞤪𞤭𞤳 𞤂𞤢𞤼𞤭𞤲𞤭𞤴𞤢',
 				'es_ES' => '𞤅𞤭𞤨𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮𞥅𞤪𞤫 𞤀𞤪𞤮𞤦𞤢',
 				'es_MX' => '𞤅𞤭𞤨𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮𞥅𞤪𞤫 𞤃𞤫𞤳𞤧𞤭𞤳',
 				'eu' => '𞤄𞤢𞤧𞤳𞤢𞤪𞤢𞥄𞤪𞤫',
 				'ff' => '𞤆𞤵𞤤𞤢𞤪',
 				'fr' => '𞤊𞤢𞤪𞤢𞤲𞤧𞤭𞥅𞤪𞤫',
 				'fr_CA' => '𞤊𞤢𞤪𞤢𞤲𞤧𞤭𞥅𞤪𞤫 𞤑𞤢𞤲𞤢𞤣𞤢𞤲𞤳𞤮𞥅𞤪𞤫',
 				'fr_CH' => '𞤊𞤢𞤪𞤢𞤲𞤧𞤭𞥅𞤪𞤫 𞤅𞤵𞤱𞤭𞥅𞤧',
 				'fy' => '𞤊𞤭𞤪𞤭𞥅𞤧𞤭𞤴𞤢𞤲𞤳𞤮𞥅𞤪𞤫 𞤖𞤭𞤪𞤲𞤢',
 				'ga' => '𞤋𞤪𞤤𞤢𞤲𞤣𞤫𞥅𞤪𞤫',
 				'hi' => '𞤖𞤭𞤲𞤣𞤭𞥅𞤪𞤫',
 				'hr' => '𞤑𞤮𞤪𞤮𞤱𞤢𞤧𞤭𞥅𞤪𞤫',
 				'hy' => '𞤀𞤪𞤥𞤫𞤲𞤭𞥅𞤪𞤫',
 				'ia' => '𞤉𞤲𞤼𞤫𞤪𞤤𞤭𞤺𞤢𞥄𞤪𞤫',
 				'id' => '𞤋𞤲𞤣𞤮𞤲𞤭𞥅𞤧𞤭𞤴𞤢𞤲𞤳𞤮𞥅𞤪𞤫',
 				'ilo' => '𞤋𞤤𞤮𞤳𞤮𞥅𞤪𞤫',
 				'inh' => '𞤋𞤲𞤺𞤮𞤧𞤫𞥅𞤪𞤫',
 				'it' => '𞤋𞤼𞤢𞤤𞤭𞤲𞤳𞤮𞥅𞤪𞤫',
 				'iu' => '𞤋𞤲𞤵𞤳𞤼𞤫𞥅𞤪𞤫',
 				'ja' => '𞤐𞤭𞤨𞤮𞤲𞤪𞤫',
 				'jgo' => '𞤐𞤺𞤮𞤥𞤦𞤢𞥄𞤪𞤫',
 				'jmc' => '𞤃𞤢𞤳𞤢𞤥𞤫𞥅𞤪𞤫',
 				'jv' => '𞤔𞤢𞥄𞤱𞤢𞤫𞥅𞤪𞤫',
 				'kaj' => '𞤑𞤢𞤶𞤫𞥅𞤪𞤫',
 				'kde' => '𞤃𞤢𞤳𞤮𞤲𞤣𞤫𞥅𞤪𞤫',
 				'ko' => '𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞤲𞤪𞤫',
 				'ksf' => '𞤄𞤢𞤬𞤭𞤴𞤢𞥄𞤪𞤫',
 				'kw' => '𞤑𞤮𞤪𞤲𞤭𞥅𞤪𞤫',
 				'lus' => '𞤃𞤭𞤧𞤮𞥅𞤪𞤫',
 				'mad' => '𞤃𞤢𞤣𞤵𞤪𞤫𞥅𞤪𞤫',
 				'mag' => '𞤃𞤢𞤺𞤢𞤸𞤭𞥅𞤪𞤫',
 				'mai' => '𞤃𞤢𞤴𞤭𞤼𞤭𞤤𞤭𞥅𞤪𞤫',
 				'mak' => '𞤃𞤢𞤳𞤢𞤧𞤢𞤪𞤢𞥄𞤪𞤫',
 				'mas' => '𞤃𞤢𞤧𞤢𞤴𞤭𞥅𞤪𞤫',
 				'mdf' => '𞤃𞤮𞤳𞤧𞤢𞤲𞤳𞤮𞥅𞤪𞤫',
 				'men' => '𞤃𞤫𞤲𞤣𞤫𞥅𞤪𞤫',
 				'mer' => '𞤃𞤫𞤪𞤵𞥅𞤪𞤫',
 				'mfe' => '𞤃𞤮𞤪𞤭𞥅𞤧𞤭𞤲𞤳𞤮𞥅𞤪𞤫',
 				'mg' => '𞤃𞤢𞤤𞤢𞤺𞤢𞤧𞤭𞥅𞤪𞤫',
 				'mgh' => '𞤃𞤢𞤳𞤵𞤱𞤢𞥄𞤪𞤫',
 				'mgo' => '𞤃𞤫𞤼𞤢𞥄𞤪𞤫',
 				'mh' => '𞤃𞤢𞤪𞤧𞤢𞤤𞤫𞥅𞤪𞤫',
 				'mk' => '𞤃𞤢𞤧𞤫𞤣𞤮𞤲𞤭𞤲𞤳𞤮𞥅𞤪𞤫',
 				'ml' => '𞤃𞤢𞤤𞤢𞤴𞤢𞤤𞤢𞤥𞤪𞤫',
 				'mn' => '𞤃𞤮𞤲𞤺𞤮𞤤𞤭𞤲𞤳𞤮𞥅𞤪𞤫',
 				'mni' => '𞤃𞤢𞤲𞤭𞤨𞤵𞥅𞤪𞤫',
 				'moh' => '𞤃𞤮𞥅𞤸𞤢𞤲𞤳𞤮𞥅𞤪𞤫',
 				'mos' => '𞤃𞤮𞥅𞤧𞤭𞥅𞤪𞤫',
 				'ms' => '𞤃𞤢𞤤𞤫𞥅𞤪𞤫',
 				'mt' => '𞤃𞤢𞤤𞤼𞤭𞤲𞤳𞤮𞥅𞤪𞤫',
 				'mua' => '𞤃𞤵𞤲𞤣𞤢𞤲𞤪𞤫',
 				'mul' => '𞤍𞤫𞤲𞤯𞤫 𞤅𞤫𞤪𞤼𞤵𞤯𞤫',
 				'mus' => '𞤃𞤵𞤧𞤳𞤮𞤳𞤭𞥅𞤪𞤫',
 				'mwl' => '𞤃𞤭𞤪𞤢𞤲𞤣𞤫𞥅𞤪𞤫',
 				'my' => '𞤄𞤵𞤪𞤥𞤢𞥄𞤪𞤫',
 				'na' => '𞤐𞤢𞤱𞤵𞤪𞤵𞤲𞤳𞤮𞥅𞤪𞤫',
 				'nap' => '𞤐𞤢𞥄𞤨𞤮𞤤𞤭𞤲𞤳𞤮𞥅𞤪𞤫',
 				'naq' => '𞤐𞤢𞤥𞤢𞥄𞤪𞤫',
 				'ne' => '𞤐𞤫𞤨𞤢𞤤𞤭𞤲𞤳𞤮𞥅𞤪𞤫',
 				'new' => '𞤐𞤫𞤱𞤢𞤪𞤭𞥅𞤪𞤫',
 				'ng' => '𞤐𞤣𞤮𞤲𞤺𞤢𞥄𞤪𞤫',
 				'nia' => '𞤙𞤢𞤧𞤭𞤲𞤳𞤮𞥅𞤪𞤫',
 				'nl' => '𞤁𞤮𞥅𞤷𞤵𞤪𞤫',
 				'nl_BE' => '𞤊𞤭𞤤𞤢𞤥𞤢𞤲𞤪𞤫',
 				'nnh' => '𞤐𞤶𞤢𞤥𞤦𞤵𞥅𞤪𞤫',
 				'nqo' => '𞤐𞤳𞤮𞥅𞤪𞤫',
 				'nv' => '𞤐𞤢𞤬𞤱𞤢𞤸𞤮𞥅𞤪𞤫',
 				'pl' => '𞤆𞤮𞤤𞤢𞤲𞤣𞤭𞥅𞤪𞤫',
 				'pt' => '𞤆𞤮𞤪𞤼𞤮𞤳𞤫𞥅𞤧𞤭𞥅𞤪𞤫',
 				'pt_BR' => '𞤆𞤮𞤪𞤼𞤮𞤳𞤫𞥅𞤧𞤭𞥅𞤪𞤫 𞤄𞤪𞤫𞥁𞤭𞤤',
 				'pt_PT' => '𞤆𞤮𞤪𞤼𞤮𞤳𞤫𞥅𞤧𞤭𞥅𞤪𞤫 𞤆𞤮𞤪𞤼𞤭𞤺𞤢𞥄𞤤',
 				'ru' => '𞤈𞤮𞥅𞤧𞤭𞤴𞤢𞤲𞤪𞤫',
 				'rup' => '𞤀𞤪𞤮𞤥𞤢𞤲𞤭𞥅𞤪𞤫',
 				'smn' => '𞤋𞤲𞤢𞤪𞤭𞤧𞤳𞤢𞤤𞤭𞥅𞤪𞤫',
 				'sq' => '𞤀𞤤𞤦𞤢𞤲𞤭𞥅𞤪𞤫',
 				'swb' => '𞤑𞤮𞤥𞤮𞤪𞤭𞥅𞤪𞤫',
 				'th' => '𞤚𞤢𞤴𞤤𞤢𞤲𞤣𞤫𞥅𞤪𞤫',
 				'tr' => '𞤚𞤵𞥅𞤪𞤢𞤲𞤳𞤮𞥅𞤪𞤫',
 				'ug' => '𞤓𞥅𞤴𞤺𞤵𞥅𞤪𞤫',
 				'und' => '𞤍𞤫𞤲𞤺𞤢𞤤 𞤢𞤧-𞤢𞤲𞤣𞤢𞥄𞤲𞤺𞤢𞤤',
 				'ur' => '𞤓𞤪𞤣𞤵𞥅𞤪𞤫',
 				'uz' => '𞤓𞥅𞤧𞤦𞤫𞤳𞤪𞤫',
 				'vai' => '𞤾𞤢𞥄𞤴𞤪𞤫',
 				've' => '𞤏𞤫𞤲𞤣𞤢𞥄𞤪𞤫',
 				'vi' => '𞤏𞤭𞤴𞤫𞤼𞤲𞤢𞤥𞤭𞤲𞤳𞤮𞥅𞤪𞤫',
 				'vo' => '𞤏𞤮𞤤𞤢𞤨𞤵𞤳𞤪𞤫',
 				'vun' => '𞤏𞤵𞤲𞤶𞤮𞥅𞤪𞤫',
 				'wa' => '𞤏𞤢𞥄𞤤𞤮𞤲𞤳𞤮𞥅𞤪𞤫',
 				'wae' => '𞤏𞤢𞤤𞤧𞤫𞥅𞤪𞤫',
 				'wal' => '𞤏𞤮𞥅𞤤𞤢𞤴𞤼𞤢𞥄𞤪𞤫',
 				'war' => '𞤏𞤢𞤪𞤢𞤴𞤫𞥅𞤪𞤫',
 				'wo' => '𞤏𞤮𞤤𞤮𞤬𞤪𞤫',
 				'xh' => '𞤑𞤮𞥅𞤧𞤢𞥄𞤪𞤫',
 				'yav' => '𞤒𞤢𞤲𞤺𞤦𞤫𞥅𞤪𞤫',
 				'ybb' => '𞤒𞤫𞤥𞤦𞤢𞥄𞤪𞤫',
 				'yi' => '𞤒𞤭𞤣𞤭𞤧𞤢𞤲𞤳𞤮𞥅𞤪𞤫',
 				'yo' => '𞤒𞤮𞥅𞤪𞤵𞤦𞤢𞥄𞤪𞤫',
 				'yue' => '𞤑𞤢𞤲𞤼𞤮𞤲𞤫𞥅𞤪𞤫',
 				'zh' => '𞤕𞤢𞤴𞤲𞤢𞤲𞤳𞤮𞥅𞤪𞤫',
 				'zh@alt=menu' => '𞤕𞤢𞤴𞤲𞤢𞤲𞤳𞤮𞥅𞤪𞤫 𞤃𞤢𞤲𞤣𞤢𞤪𞤫𞤲𞤪𞤫',
 				'zh_Hans' => '𞤕𞤢𞤴𞤲𞤢𞤲𞤳𞤮𞥅𞤪𞤫 𞤖𞤮𞤴𞤬𞤭𞤲𞤢𞥄𞤲𞤣𞤫',
 				'zh_Hans@alt=long' => '𞤃𞤢𞤲𞤣𞤢𞤪𞤫𞤲𞤪𞤫 𞤖𞤮𞤴𞤬𞤭𞤲𞤢𞥄𞤲𞤣𞤫',
 				'zh_Hant' => '𞤕𞤢𞤴𞤲𞤢𞤲𞤳𞤮𞥅𞤪𞤫 𞤒𞤫𞤷𞥆𞤵𞤲𞥋𞤣𞤫',
 				'zh_Hant@alt=long' => '𞤃𞤢𞤲𞤣𞤢𞤪𞤫𞤲𞤪𞤫 𞤀𞤪𞤣𞤭𞥅𞤲𞤣𞤫',
 				'zu' => '𞥁𞤵𞤤𞤵𞥅𞤪𞤫',

			);
			if (@_) {
				return $languages{$_[0]};
			}
			return \%languages;
		}
	},
);

has 'display_name_script' => (
	is			=> 'ro',
	isa			=> CodeRef,
	init_arg	=> undef,
	default		=> sub {
		sub {
			my %scripts = (
			'Adlm' => '𞤀𞤁𞤂𞤢𞤃',
 			'Arab' => '𞤀𞥄𞤪𞤢𞤦𞤵',
 			'Cyrl' => '𞤅𞤭𞤪𞤤𞤭𞤳',
 			'Hans' => '𞤖𞤮𞤴𞤲𞤢𞥄𞤲𞤣𞤫',
 			'Hans@alt=stand-alone' => '𞤖𞤢𞥄𞤲𞤪𞤫 𞤖𞤮𞤴𞤲𞤢𞥄𞤲𞤣𞤫',
 			'Hant' => '𞤚𞤢𞤱𞤢𞥄𞤲𞤣𞤫',
 			'Hant@alt=stand-alone' => '𞤖𞤢𞥄𞤲𞤪𞤫 𞤚𞤢𞤱𞤢𞥄𞤲𞤣𞤫',
 			'Jpan' => '𞤐𞤭𞤨𞤮𞤲𞤶𞤭',
 			'Kore' => '𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞤲𞤶𞤭',
 			'Latn' => '𞤂𞤢𞤼𞤫𞤲',
 			'Zxxx' => '𞤀𞤧𞤱𞤭𞤲𞤣𞤢𞥄𞤯𞤵𞤲',
 			'Zzzz' => '𞤄𞤭𞤲𞤣𞤭 𞤀𞤧-𞤢𞤲𞤣𞤢𞥄𞤯𞤭',

			);
			if ( @_ ) {
				return $scripts{$_[0]};
			}
			return \%scripts;
		}
	}
);

has 'display_name_region' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub {
		{
			'001' => '𞤀𞤣𞤵𞤲𞤢',
 			'002' => '𞤀𞤬𞤪𞤭𞤳𞤢𞥄',
 			'003' => '𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄',
 			'005' => '𞤙𞤢𞤥𞤲𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄',
 			'009' => '𞤌𞤧𞤭𞤴𞤢𞤲𞤭𞥅',
 			'011' => '𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤀𞤬𞤪𞤭𞤳𞤢𞥄',
 			'013' => '𞤚𞤵𞤥𞤦𞤮 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄',
 			'014' => '𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤀𞤬𞤪𞤭𞤳𞤢𞥄',
 			'015' => '𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤀𞤬𞤪𞤭𞤳𞤢𞥄',
 			'017' => '𞤚𞤵𞤥𞤦𞤮 𞤀𞤬𞤪𞤭𞤳𞤢𞥄',
 			'018' => '𞤙𞤢𞥄𞤥𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤀𞤬𞤪𞤭𞤳𞤢𞥄',
 			'019' => '𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄',
 			'021' => '𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄',
 			'029' => '𞤑𞤢𞤪𞤦𞤭𞤴𞤢𞥄',
 			'030' => '𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤀𞥄𞤧𞤭𞤴𞤢',
 			'034' => '𞤙𞤢𞤥𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤀𞥄𞤧𞤭𞤴𞤢',
 			'035' => '𞤙𞤢𞤥𞤬𞤭𞤯𞤲𞤢𞥄𞤲𞤺𞤫 𞤀𞥄𞤧𞤭𞤴𞤢',
 			'039' => '𞤙𞤢𞤥𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤓𞤪𞤨𞤢',
 			'053' => '𞤀𞤧𞤼𞤢𞤪𞤤𞤢𞥄𞤧𞤭𞤴𞤢𞥄',
 			'054' => '𞤃𞤭𞤤𞤢𞤲𞤭𞥅𞤧𞤴𞤢',
 			'057' => '𞤖𞤭𞤤𞥆𞤮 𞤃𞤭𞤳𞤪𞤮𞤲𞤭𞥅𞤧𞤸𞤮',
 			'061' => '𞤆𞤮𞤤𞤭𞤲𞤭𞥅𞤧𞤴𞤢',
 			'142' => '𞤀𞥄𞤧𞤭𞤴𞤢',
 			'143' => '𞤚𞤵𞤥𞤦𞤮𞥅𞤪𞤭 𞤀𞥄𞤧𞤭𞤴𞤢',
 			'145' => '𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤀𞥄𞤧𞤭𞤴𞤢',
 			'150' => '𞤓𞤪𞤨𞤢',
 			'151' => '𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤓𞤪𞤨𞤢',
 			'154' => '𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤓𞤪𞤨𞤢',
 			'155' => '𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤓𞤪𞤨𞤢',
 			'202' => '𞤀𞤬𞤪𞤭𞤳𞤢𞥄 𞤂𞤫𞤧-𞤅𞤢𞥄𞤸𞤢𞤪𞤢',
 			'419' => '𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄 𞤂𞤢𞤼𞤭𞤲𞤳𞤮',
 			'AC' => '𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤀𞤧𞤢𞤲𞤧𞤮𞥅𞤲',
 			'AD' => '𞤀𞤲𞤣𞤮𞤪𞤢𞥄',
 			'AE' => '𞤁𞤫𞤲𞤼𞤢𞤤 𞤋𞤥𞤪𞤢𞥄𞤼𞤭 𞤀𞥄𞤪𞤢𞤦𞤵',
 			'AF' => '𞤀𞤬𞤺𞤢𞤲𞤭𞤧𞤼𞤢𞥄𞤲',
 			'AG' => '𞤀𞤲𞤼𞤭𞤺𞤵𞤱𞤢 & 𞤄𞤢𞤪𞤦𞤵𞥅𞤣𞤢',
 			'AI' => '𞤀𞤲𞤺𞤭𞤤𞤢𞥄',
 			'AL' => '𞤀𞤤𞤦𞤢𞤲𞤭𞤴𞤢𞥄',
 			'AM' => '𞤀𞤪𞤥𞤫𞤲𞤭𞤴𞤢𞥄',
 			'AO' => '𞤀𞤲𞤺𞤮𞤤𞤢𞥄',
 			'AQ' => '𞤀𞤲𞤼𞤢𞤪𞤼𞤭𞤳𞤢𞥄',
 			'AR' => '𞤀𞤪𞤶𞤢𞤲𞤼𞤭𞤲𞤢𞥄',
 			'AS' => '𞤅𞤢𞤥𞤵𞤱𞤢 𞤀𞤥𞤫𞤪𞤭𞤳𞤭𞤴𞤢𞤲𞤳𞤮',
 			'AT' => '𞤌𞤼𞤭𞤪𞤧𞤢',
 			'AU' => '𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄',
 			'AW' => '𞤀𞤪𞤵𞤦𞤢𞥄',
 			'AX' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤀𞤤𞤢𞤲𞤣',
 			'AZ' => '𞤀𞥁𞤫𞤪𞤦𞤢𞤭𞤶𞤢𞥄𞤲',
 			'BA' => '𞤄𞤮𞤧𞤲𞤭𞤴𞤢 & 𞤖𞤫𞤪𞤧𞤫𞤳𞤮𞤾𞤭𞤲𞤢𞥄',
 			'BB' => '𞤄𞤢𞤪𞤦𞤫𞥅𞤣𞤮𞥅𞤧',
 			'BD' => '𞤄𞤢𞤲𞤺𞤭𞤤𞤢𞤣𞤫𞥅𞤧',
 			'BE' => '𞤄𞤫𞤤𞤶𞤭𞤳𞤢𞥄',
 			'BF' => '𞤄𞤵𞤪𞤳𞤭𞤲𞤢 𞤊𞤢𞤧𞤮𞥅',
 			'BG' => '𞤄𞤵𞥅𞤤𞤺𞤢𞤪𞤭𞤴𞤢𞥄',
 			'BH' => '𞤄𞤢𞤸𞤢𞤪𞤢𞤴𞤲',
 			'BI' => '𞤄𞤵𞤪𞤵𞤲𞤣𞤭',
 			'BJ' => '𞤄𞤫𞤲𞤫𞤲',
 			'BL' => '𞤅𞤼. 𞤄𞤢𞤪𞤼𞤫𞤤𞤭𞤥𞤭',
 			'BM' => '𞤄𞤭𞤪𞤥𞤵𞤣𞤢',
 			'BN' => '𞤄𞤵𞤪𞤲𞤢𞥄𞤴',
 			'BO' => '𞤄𞤮𞤤𞤭𞥅𞤾𞤭𞤴𞤢𞥄',
 			'BQ' => '𞤑𞤢𞤪𞤦𞤭𞤴𞤢𞥄 𞤖𞤮𞤤𞤢𞤲𞤣𞤭𞤴𞤢𞥄',
 			'BR' => '𞤄𞤪𞤢𞥄𞥁𞤭𞤤',
 			'BS' => '𞤄𞤢𞤸𞤢𞤥𞤢𞥄𞤧',
 			'BT' => '𞤄𞤵𞥅𞤼𞤢𞥄𞤲',
 			'BV' => '𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤄𞤵𞥅𞤾𞤫𞥅',
 			'BW' => '‮𞤄𞤮𞤼𞤧𞤵𞤱𞤢𞥄𞤲𞤢',
 			'BY' => '𞤄𞤫𞤤𞤢𞤪𞤵𞥅𞤧',
 			'BZ' => '𞤄𞤫𞤤𞤭𞥅𞥁',
 			'CA' => '𞤑𞤢𞤲𞤢𞤣𞤢𞥄',
 			'CC' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤑𞤮𞤳𞤮𞥅𞤧 (𞤑𞤭𞥅𞤤𞤭𞤲𞤺)',
 			'CD' => '𞤑𞤮𞤲𞤺𞤮 - 𞤑𞤭𞤲𞤧𞤢𞤧𞤢',
 			'CD@alt=variant' => '𞤐𞤣𞤫𞤲𞤣𞤭 𞤁𞤫𞤥𞤮𞤳𞤪𞤢𞥄𞤳𞤵 𞤑𞤮𞤲𞤺𞤮',
 			'CF' => '𞤐𞤣𞤫𞤲𞤣𞤭 𞤚𞤵𞤥𞤦𞤮𞥅𞤪𞤭 𞤀𞤬𞤪𞤭𞤳𞤢𞥄',
 			'CG' => '𞤑𞤮𞤲𞤺𞤮 - 𞤄𞤪𞤢𞥁𞤢𞤾𞤭𞤤',
 			'CG@alt=variant' => '𞤐𞤣𞤫𞤲𞤣𞤭 𞤑𞤮𞤲𞤺𞤮',
 			'CH' => '𞤅𞤵𞤱𞤭𞤪𞤧𞤢𞥄',
 			'CI' => '𞤑𞤮𞤼𞤣𞤭𞤾𞤢𞥄𞤪',
 			'CK' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤑𞤵𞥅𞤳',
 			'CL' => '𞤕𞤭𞤤𞤫𞥊𞥅',
 			'CM' => '𞤑𞤢𞤥𞤢𞤪𞤵𞥅𞤲',
 			'CN' => '𞤅𞤭𞥅𞤲',
 			'CO' => '𞤑𞤮𞤤𞤮𞤥𞤦𞤭𞤴𞤢𞥄',
 			'CP' => '𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤑𞤭𞤤𞤭𞤨𞤫𞤪𞤼𞤮𞤲',
 			'CR' => '𞤑𞤮𞤧𞤼𞤢 𞤈𞤭𞤳𞤢𞥄',
 			'CU' => '𞤑𞤵𞥅𞤦𞤢𞥄',
 			'CV' => '𞤑𞤢𞥄𞤦𞤮 𞤜𞤫𞤪𞤣𞤫',
 			'CW' => '𞤑𞤵𞥅𞤪𞤢𞤧𞤢𞤱𞤮',
 			'CX' => '𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤑𞤭𞤪𞤧𞤭𞤥𞤢𞥄𞤧',
 			'CY' => '𞤑𞤵𞤦𞤪𞤵𞥅𞤧',
 			'CZ' => '𞤕𞤫𞥅𞤳𞤭𞤴𞤢𞥄',
 			'CZ@alt=variant' => '𞤐𞤣𞤫𞤲𞤣𞤭 𞤕𞤫𞤧𞤳𞤢𞥄',
 			'DE' => '𞤔𞤫𞤪𞤥𞤢𞤲𞤭𞥅',
 			'DG' => '𞤔𞤮𞤺𞤮 𞤘𞤢𞥄𞤪𞤧𞤭𞤴𞤢',
 			'DJ' => '𞤔𞤭𞤦𞤵𞥅𞤼𞤭',
 			'DK' => '𞤁𞤢𞤲𞤵𞤥𞤢𞤪𞤳',
 			'DM' => '𞤁𞤮𞤥𞤭𞤲𞤭𞤳𞤢𞥄',
 			'DO' => '𞤐𞤣𞤫𞤲𞤣𞤭 𞤁𞤮𞤥𞤭𞤲𞤭𞤳𞤢𞥄',
 			'DZ' => '𞤀𞤤𞤶𞤢𞤪𞤭𞥅',
 			'EA' => '𞤅𞤭𞤼𞥆𞤢 & 𞤃𞤫𞤤𞤭𞤤𞤢',
 			'EC' => '𞤉𞤳𞤵𞤱𞤢𞤣𞤮𞥅𞤪',
 			'EE' => '𞤉𞤧𞤼𞤮𞤲𞤭𞤴𞤢𞥄',
 			'EG' => '𞤃𞤭𞤧𞤭𞤪𞤢',
 			'EH' => '𞤅𞤢𞥄𞤸𞤢𞤪𞤢 𞤖𞤭𞥅𞤲𞤢𞥄𞤪𞤭',
 			'ER' => '𞤉𞤪𞤭𞥅𞤼𞤫𞤪𞤫',
 			'ES' => '𞤉𞤧𞤨𞤢𞤻𞤢𞥄',
 			'ET' => '𞤀𞤦𞤢𞤧𞤭𞤲𞤭𞥅',
 			'EU' => '𞤑𞤢𞤱𞤼𞤢𞤤 𞤓𞤪𞤨𞤢',
 			'EZ' => '𞤊𞤭𞤪𞤤𞤢 𞤓𞤪𞤮𞥅',
 			'FI' => '𞤊𞤭𞤲𞤤𞤢𞤲𞤣',
 			'FJ' => '𞤊𞤭𞤶𞤭𞥅',
 			'FK' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤊𞤢𞤤𞤳𞤵𞤤𞤢𞤲𞤣',
 			'FK@alt=variant' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤃𞤢𞤤𞤾𞤭𞤲𞤢𞥄𞤧',
 			'FM' => '𞤃𞤭𞤳𞤪𞤮𞤲𞤫𞥅𞤧𞤭𞤴𞤢',
 			'FO' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤊𞤢𞤪𞤵𞥅𞤧',
 			'FR' => '𞤊𞤢𞤪𞤢𞤲𞤧𞤭',
 			'GA' => '𞤘𞤢𞤦𞤮𞤲',
 			'GB' => '𞤁𞤫𞤲𞤼𞤢𞤤 𞤐𞤺𞤫𞤯𞤵𞥅𞤪𞤭',
 			'GB@alt=short' => '𞤑𞤘',
 			'GD' => '𞤘𞤢𞤪𞤲𞤢𞤣𞤢𞥄',
 			'GE' => '𞤔𞤮𞤪𞤶𞤭𞤴𞤢𞥄',
 			'GF' => '𞤘𞤵𞤴𞤢𞥄𞤲 𞤊𞤪𞤢𞤲𞤧𞤭𞤲𞤳𞤮',
 			'GG' => '𞤘𞤢𞤪𞤲𞤫𞤧𞤭𞥅',
 			'GH' => '𞤘𞤢𞤲𞤢',
 			'GI' => '𞤔𞤭𞤦𞤪𞤢𞤤𞤼𞤢𞥄',
 			'GL' => '𞤘𞤭𞤪𞤤𞤢𞤲𞤣𞤭',
 			'GM' => '𞤘𞤢𞤥𞤦𞤭𞤴𞤢',
 			'GN' => '𞤘𞤭𞤲𞤫',
 			'GP' => '𞤘𞤵𞤱𞤢𞤣𞤢𞤤𞤵𞤨𞤫𞥅',
 			'GQ' => '𞤘𞤭𞤲𞤫 𞤕𞤢𞤳𞤢𞤲𞤼𞤫𞥅𞤪𞤭',
 			'GR' => '𞤀𞤤𞤴𞤵𞤲𞤢𞥄𞤲',
 			'GS' => '𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤔𞤮𞤪𞤶𞤭𞤴𞤢 & 𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤅𞤢𞤲𞤣𞤵𞤱𞤭𞥅𞤷',
 			'GT' => '𞤘𞤵𞤱𞤢𞤼𞤫𞤥𞤢𞤤𞤢𞥄',
 			'GU' => '𞤘𞤵𞤱𞤢𞥄𞤥',
 			'GW' => '𞤘𞤭𞤲𞤫-𞤄𞤭𞤧𞤢𞤱𞤮𞥅',
 			'GY' => '𞤘𞤢𞤴𞤢𞤲𞤢𞥄',
 			'HK' => '𞤖𞤂𞤀 𞤅𞤭𞥅𞤲 𞤫 𞤖𞤮𞤲𞤺 𞤑𞤮𞤲𞤺',
 			'HK@alt=short' => '𞤖𞤮𞤲𞤺 𞤑𞤮𞤲𞤺',
 			'HM' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤖𞤭𞤪𞤣𞤭 & 𞤃𞤢𞤳𞤣𞤮𞤲𞤢𞤤',
 			'HN' => '𞤖𞤮𞤲𞤣𞤭𞤪𞤢𞥄𞤧',
 			'HR' => '𞤑𞤵𞤪𞤱𞤢𞥄𞤧𞤭𞤴𞤢',
 			'HT' => '𞤖𞤢𞤴𞤼𞤭𞥅',
 			'HU' => '𞤖𞤢𞤲𞤺𞤢𞤪𞤭𞤴𞤢𞥄',
 			'IC' => '𞤅𞤵𞤪𞤭𞥅𞤪𞤫-𞤑𞤢𞤲𞤢𞤪𞤭𞥅',
 			'ID' => '𞤋𞤲𞤣𞤮𞤲𞤭𞥅𞤧𞤴𞤢',
 			'IE' => '𞤋𞤪𞤤𞤢𞤲𞤣',
 			'IL' => '𞤋𞤧𞤪𞤢𞥄𞤴𞤭𞥅𞤤',
 			'IM' => '𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤃𞤫𞥅𞤲',
 			'IN' => '𞤋𞤲𞤣𞤭𞤴𞤢',
 			'IO' => '𞤚𞤵𞤥𞤦𞤫𞤪𞤫 𞤄𞤪𞤭𞤼𞤢𞤲𞤭𞤲𞤳𞤮𞥅𞤪𞤫 𞤀𞤬𞤪𞤭𞤳𞤭',
 			'IQ' => '𞤋𞤪𞤢𞥄𞤳',
 			'IR' => '𞤋𞤪𞤢𞥄𞤲',
 			'IS' => '𞤀𞤴𞤧𞤵𞤤𞤢𞤲𞤣',
 			'IT' => '𞤋𞤼𞤢𞤤𞤭𞥅',
 			'JE' => '𞤔𞤫𞤪𞤧𞤭𞥅',
 			'JM' => '𞤔𞤢𞤥𞤢𞤴𞤳𞤢𞥄',
 			'JO' => '𞤔𞤮𞤪𞤣𞤢𞥄𞤲',
 			'JP' => '𞤐𞤭𞤨𞥆𞤮𞤲',
 			'KE' => '𞤑𞤫𞤲𞤭𞤴𞤢𞥄',
 			'KG' => '𞤑𞤭𞤪𞤶𞤭𞤧𞤼𞤢𞥄𞤲',
 			'KH' => '𞤑𞤢𞤥𞤦𞤮𞥅𞤣𞤭𞤴𞤢',
 			'KI' => '𞤑𞤭𞤪𞤦𞤢𞤼𞤭𞥅',
 			'KM' => '𞤑𞤮𞤥𞤮𞥅𞤪𞤮',
 			'KN' => '𞤅𞤼. 𞤑𞤪𞤭𞤧𞤼𞤮𞤦𞤢𞤤 & 𞤐𞤫𞥅𞤾𞤭𞤧',
 			'KP' => '𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞥄 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫',
 			'KR' => '𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞥄 𞤙𞤢𞤥𞤲𞤢𞥄𞤲𞤺𞤫',
 			'KW' => '𞤑𞤵𞤱𞤢𞤴𞤼𞤵',
 			'KY' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤑𞤢𞤴𞤥𞤢𞥄𞤲',
 			'KZ' => '𞤑𞤢𞥁𞤢𞤧𞤼𞤢𞥄𞤲',
 			'LA' => '𞤂𞤢𞤱𞤮𞥅𞤧',
 			'LB' => '𞤂𞤭𞤦𞤢𞤲𞤮𞥅𞤲',
 			'LC' => '𞤅𞤼. 𞤂𞤵𞥅𞤧𞤭𞤴𞤢',
 			'LI' => '𞤂𞤭𞤧𞤼𞤫𞤲𞤧𞤭𞤼𞤫𞥅𞤲',
 			'LK' => '𞤅𞤭𞤪 𞤂𞤢𞤲𞤳𞤢𞥄',
 			'LR' => '𞤂𞤢𞤦𞤭𞤪𞤭𞤴𞤢𞥄',
 			'LS' => '𞤂𞤫𞤧𞤮𞤼𞤮𞥅',
 			'LT' => '𞤂𞤭𞤼𞤵𞤾𞤢',
 			'LU' => '𞤂𞤵𞤳𞤧𞤢𞤲𞤦𞤵𞥅𞤺',
 			'LV' => '𞤂𞤢𞤼𞤾𞤭𞤴𞤢',
 			'LY' => '𞤂𞤭𞤦𞤭𞤴𞤢𞥄',
 			'MA' => '𞤃𞤢𞤪𞤮𞥅𞤳',
 			'MC' => '𞤃𞤮𞤲𞤢𞤳𞤮𞥅',
 			'MD' => '𞤃𞤮𞤤𞤣𞤮𞤾𞤢𞥄',
 			'ME' => '𞤃𞤮𞤲𞤼𞤫𞤲𞤫𞥅𞤺𞤮𞤪𞤮',
 			'MF' => '𞤅𞤼. 𞤃𞤢𞤪𞤼𞤫𞤲',
 			'MG' => '𞤃𞤢𞤣𞤢𞤺𞤢𞤧𞤳𞤢𞥄𞤪',
 			'MH' => '𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤃𞤢𞤪𞥃𞤢𞤤',
 			'MK' => '𞤃𞤢𞤳𞤫𞤣𞤮𞤲𞤭𞤴𞤢𞥄 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫',
 			'ML' => '𞤃𞤢𞥄𞤤𞤭',
 			'MM' => '𞤃𞤭𞤴𞤢𞤥𞤢𞥄𞤪 (𞤄𞤵𞥅𞤪𞤥𞤢)',
 			'MN' => '𞤃𞤮𞤲𞤺𞤮𞤤𞤭𞤴𞤢',
 			'MO' => '𞤖𞤂𞤀 𞤅𞤭𞥅𞤲 𞤫 𞤃𞤢𞤳𞤢𞤱𞤮𞥅',
 			'MO@alt=short' => '𞤃𞤢𞤳𞤢𞤱𞤮𞥅',
 			'MP' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤃𞤢𞤪𞤭𞤴𞤢𞥄𞤲𞤢 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭',
 			'MQ' => '𞤃𞤢𞤪𞤼𞤭𞤲𞤭𞤳𞤢𞥄',
 			'MR' => '𞤃𞤮𞤪𞤼𞤢𞤲𞤭𞥅',
 			'MS' => '𞤃𞤮𞤲𞤧𞤭𞤪𞤢𞥄𞤼',
 			'MT' => '𞤃𞤢𞤤𞤼𞤢',
 			'MU' => '𞤃𞤮𞤪𞤭𞥅𞤧𞤭',
 			'MV' => '𞤃𞤢𞤤𞤣𞤭𞥅𞤬',
 			'MW' => '𞤃𞤢𞤤𞤢𞤱𞤭𞥅',
 			'MX' => '𞤃𞤫𞤳𞤧𞤭𞤳𞤮𞥅',
 			'MY' => '𞤃𞤢𞤤𞤫𞥅𞤧𞤭𞤴𞤢',
 			'MZ' => '𞤃𞤮𞤧𞤢𞤥𞤦𞤭𞥅𞤳',
 			'NA' => '𞤐𞤢𞤥𞤭𞥅𞤦𞤭𞤴𞤢𞥄',
 			'NC' => '𞤑𞤢𞤤𞤭𞤣𞤮𞤲𞤭𞤴𞤢𞥄 𞤖𞤫𞤧𞤮',
 			'NE' => '𞤐𞤭𞥅𞤶𞤫𞤪',
 			'NF' => '𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤐𞤮𞤪𞤬𞤮𞤤𞤳𞤵',
 			'NG' => '𞤐𞤢𞤶𞤫𞤪𞤭𞤴𞤢𞥄',
 			'NI' => '𞤐𞤭𞤳𞤢𞤪𞤢𞤺𞤵𞤱𞤢𞥄',
 			'NL' => '𞤖𞤮𞤤𞤢𞤲𞤣𞤭𞤴𞤢𞥄',
 			'NO' => '𞤐𞤮𞤪𞤺𞤫𞤴𞤢𞥄',
 			'NP' => '𞤐𞤭𞤨𞤢𞥄𞤤',
 			'NR' => '𞤐𞤢𞤱𞤪𞤵',
 			'NU' => '𞤐𞤵𞥅𞤱𞤭',
 			'NZ' => '𞤐𞤫𞤱 𞤟𞤫𞤤𞤢𞤲𞤣',
 			'OM' => '𞤌𞥅𞤥𞤢𞥄𞤲',
 			'PA' => '𞤆𞤢𞤲𞤢𞤥𞤢',
 			'PE' => '𞤆𞤫𞤪𞤵𞥅',
 			'PF' => '𞤆𞤮𞤤𞤭𞤲𞤫𞥅𞤧𞤭𞤴𞤢 𞤊𞤪𞤢𞤲𞤧𞤭𞤲𞤳𞤮',
 			'PG' => '𞤆𞤢𞤨𞤵𞤱𞤢 𞤘𞤭𞤲𞤫 𞤖𞤫𞤧𞤮',
 			'PH' => '𞤊𞤭𞤤𞤭𞤨𞤭𞥅𞤲',
 			'PK' => '𞤆𞤢𞤳𞤭𞤧𞤼𞤢𞥄𞤲',
 			'PL' => '𞤆𞤮𞤤𞤢𞤲𞤣',
 			'PM' => '𞤅𞤼. 𞤆𞤭𞤴𞤫𞥅𞤪 & 𞤃𞤭𞤳𞤫𞤤𞤮𞤲',
 			'PN' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤆𞤭𞤼𞤳𞤭𞥅𞤪𞤲𞤵',
 			'PR' => '𞤆𞤮𞤪𞤼𞤮 𞤈𞤭𞤳𞤮𞥅',
 			'PS' => '𞤂𞤫𞤧𞤣𞤭𞥅𞤶𞤭 𞤊𞤢𞤤𞤫𞤧𞤼𞤭𞥅𞤲',
 			'PT' => '𞤆𞤮𞥅𞤪𞤼𞤵𞤺𞤢𞥄𞤤',
 			'PW' => '𞤆𞤢𞤤𞤢𞤱',
 			'PY' => '𞤆𞤢𞥄𞤪𞤢𞤺𞤵𞤱𞤢𞥄𞤴',
 			'QA' => '𞤊𞤢𞤤𞤫𞤧𞤼𞤭𞥅𞤲',
 			'QO' => '𞤚𞤢𞤼𞥆𞤫𞥅𞤪𞤭 𞤌𞤧𞤴𞤢𞤲𞤭𞤴𞤢',
 			'RE' => '𞤈𞤫𞥅𞤲𞤭𞤴𞤮𞤲',
 			'RO' => '𞤈𞤵𞤥𞤢𞥄𞤲𞤭𞤴𞤢',
 			'RS' => '𞤅𞤫𞤪𞤦𞤭𞤴𞤢𞥄',
 			'RU' => '𞤈𞤮𞥅𞤧𞤭𞤴𞤢',
 			'RW' => '𞤈𞤵𞤱𞤢𞤲𞤣𞤢𞥄',
 			'SA' => '𞤅𞤢𞤵𞥅𞤣 𞤀𞥄𞤪𞤢𞤦𞤭𞤴𞤢𞥄',
 			'SB' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤅𞤵𞤤𞤢𞤴𞤥𞤢𞥄𞤲',
 			'SC' => '𞤅𞤫𞤴𞤭𞤧𞤫𞤤',
 			'SD' => '𞤅𞤵𞤣𞤢𞥄𞤲',
 			'SE' => '𞤅𞤵𞤱𞤫𞤣𞤭𞤴𞤢𞥄',
 			'SG' => '𞤅𞤭𞤲𞤺𞤢𞤨𞤵𞥅𞤪',
 			'SH' => '𞤅𞤫𞤲-𞤖𞤫𞤤𞤫𞤲𞤢𞥄',
 			'SI' => '𞤅𞤵𞤤𞤮𞤾𞤫𞤲𞤭𞤴𞤢𞥄',
 			'SJ' => '𞤅𞤢𞤾𞤢𞤤𞤦𞤢𞤪𞤣 & 𞤔𞤢𞤲 𞤃𞤢𞤴𞤫𞤲',
 			'SK' => '𞤅𞤵𞤤𞤮𞤾𞤢𞥄𞤳𞤭𞤴𞤢',
 			'SL' => '𞤅𞤢𞤪𞤢𞤤𞤮𞤲',
 			'SM' => '𞤅𞤢𞤲 𞤃𞤢𞤪𞤭𞤲𞤮𞥅',
 			'SN' => '𞤅𞤫𞤲𞤫𞤺𞤢𞥄𞤤',
 			'SO' => '𞤅𞤵𞥅𞤥𞤢𞥄𞤤𞤭',
 			'SR' => '𞤅𞤵𞤪𞤭𞤲𞤢𞥄𞤥',
 			'SS' => '𞤅𞤵𞤣𞤢𞥄𞤲 𞤂𞤫𞤧𞤤𞤫𞤴𞤪𞤭',
 			'ST' => '𞤅𞤢𞤱𞤵 𞤚𞤵𞤥𞤫𞥅 & 𞤆𞤫𞤪𞤫𞤲𞤧𞤭𞤨𞤫',
 			'SV' => '𞤉𞤤 𞤅𞤢𞤤𞤾𞤢𞤣𞤮𞥅𞤪',
 			'SX' => '𞤅𞤫𞤲𞤼𞤵 𞤃𞤢𞥄𞤪𞤼𞤫𞤲',
 			'SY' => '𞤅𞤵𞥅𞤪𞤭𞤴𞤢𞥄',
 			'SZ' => '𞤉𞤧𞤱𞤢𞤼𞤭𞤲𞤭',
 			'SZ@alt=variant' => '𞤅𞤵𞤱𞤢𞥄𞤧𞤭𞤤𞤫𞤴𞤣𞤭',
 			'TA' => '𞤚𞤵𞤪𞤧𞤵𞤼𞤢𞤲 𞤁𞤢𞤳𞤵𞤲𞤸𞤢',
 			'TC' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤚𞤵𞤪𞤳𞤵𞤧 & 𞤑𞤢𞤴𞤳𞤮𞥅𞤧',
 			'TD' => '𞤕𞤢𞥄𞤣',
 			'TF' => '𞤚𞤵𞤥𞤦𞤫 𞤂𞤫𞤧𞤤𞤫𞤴𞤶𞤫 𞤊𞤪𞤢𞤲𞤧𞤭',
 			'TG' => '𞤚𞤮𞤺𞤮',
 			'TH' => '𞤚𞤢𞥄𞤴𞤤𞤢𞤲𞤣',
 			'TJ' => '𞤚𞤢𞤶𞤭𞤳𞤭𞤧𞤼𞤢𞥄𞤲',
 			'TK' => '𞤚𞤮𞥅𞤳𞤮𞤤𞤢𞥄𞤱𞤵',
 			'TL' => '𞤚𞤭𞤥𞤮𞥅𞤪 𞤂𞤫𞤧𞤼𞤫',
 			'TL@alt=variant' => '𞤚𞤭𞤥𞤮𞥅𞤪 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫',
 			'TM' => '𞤚𞤵𞤪𞤳𞤵𞤥𞤫𞤲𞤭𞤧𞤼𞤢𞥄𞤲',
 			'TN' => '𞤚𞤵𞤲𞤭𞥅𞤧𞤢',
 			'TO' => '𞤚𞤮𞤲𞤺𞤢',
 			'TR' => '𞤚𞤵𞤪𞤳𞤭𞤴𞤢𞥄',
 			'TT' => '𞤚𞤭𞤪𞤲𞤭𞤣𞤢𞥄𞤣 & 𞤚𞤮𞤦𞤢𞤺𞤮𞥅',
 			'TV' => '𞤚𞤵𞥅𞤾𞤢𞤤𞤵',
 			'TW' => '𞤚𞤢𞤴𞤱𞤢𞥄𞤲',
 			'TZ' => '𞤚𞤢𞤲𞤧𞤢𞤲𞤭𞥅',
 			'UA' => '𞤓𞤳𞤪𞤫𞥅𞤲𞤭𞤴𞤢',
 			'UG' => '𞤓𞤺𞤢𞤲𞤣𞤢𞥄',
 			'UM' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤁𞤢𞥄𞤴𞤭𞥅𞤯𞤫 𞤁𞤂𞤀',
 			'UN' => '𞤑𞤢𞤱𞤼𞤢𞤤 𞤘𞤫𞤲𞤯𞤭',
 			'US' => '𞤁𞤫𞤲𞤼𞤢𞤤 𞤂𞤢𞤪𞤫',
 			'US@alt=short' => '𞤁𞤂𞤀',
 			'UY' => '𞤓𞤪𞤵𞤺𞤵𞤱𞤢𞥄𞤴',
 			'UZ' => '𞤓𞥁𞤦𞤫𞤳𞤭𞤧𞤼𞤢𞥄𞤲',
 			'VA' => '𞤜𞤢𞤼𞤭𞤳𞤢𞥄𞤲',
 			'VC' => '𞤅𞤼. 𞤜𞤭𞤲𞤧𞤢𞤲 & 𞤘𞤭𞤪𞤲𞤢𞤣𞤭𞥅𞤲',
 			'VE' => '𞤜𞤫𞥊𞤲𞤭𞥅𞥁𞤵𞤱𞤫𞤤𞤢𞥄',
 			'VG' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤜𞤭𞤪𞤺𞤭𞥅𞤲 𞤄𞤪𞤭𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮𞥅𞤶𞤫',
 			'VI' => '𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤜𞤭𞤪𞤺𞤭𞥅𞤲 𞤁𞤂𞤀',
 			'VN' => '𞤜𞤭𞤴𞤫𞤼𞤲𞤢𞥄𞤥',
 			'VU' => '𞤜𞤢𞤲𞤵𞤱𞤢𞥄𞤼𞤵',
 			'WF' => '𞤏𞤢𞤤𞥆𞤭𞥅𞤧 & 𞤊𞤵𞤼𞤵𞤲𞤢',
 			'WS' => '𞤅𞤢𞤥𞤵𞤱𞤢',
 			'XK' => '𞤑𞤮𞥅𞤧𞤮𞤾𞤮𞥅',
 			'YE' => '𞤒𞤢𞤥𞤢𞤲',
 			'YT' => '𞤃𞤢𞤴𞤮𞥅𞤼𞤵',
 			'ZA' => '𞤀𞤬𞤪𞤭𞤳𞤢 𞤂𞤫𞤧𞤤𞤫𞤴𞤪𞤭',
 			'ZM' => '𞤟𞤢𞤥𞤦𞤭𞤴𞤢',
 			'ZW' => '𞤟𞤭𞤥𞤦𞤢𞥄𞤥𞤵𞤴𞤢',
 			'ZZ' => '𞤖𞤭𞤤𞥆𞤮 𞤀𞤧-𞤢𞤲𞤣𞤢𞥄𞤲𞤺𞤮',

		}
	},
);

has 'display_name_key' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub {
		{
			'calendar' => '𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫',
 			'cf' => '𞤃𞤢𞥄𞤲𞥋𞤣𞤫 𞤐𞥋𞤄𞤵𞥅𞤯𞤭',
 			'collation' => '𞤈𞤫𞤱𞤲𞤭𞤲𞥋𞤣𞤭𞤪𞤮 𞤔𞤭𞤩𞤼𞤢𞤲𞤣𞤫',
 			'currency' => '𞤐𞥋𞤄𞤵𞥅𞤯𞤭',
 			'hc' => '𞤃𞤢𞥄𞤲𞥋𞤣𞤫 𞤚𞤢𞥄𞤪𞤮 𞤐𞥋𞤄𞤵𞥅𞤯𞤭 (𞥑𞥒 𞤥𞤢𞥄 𞥒𞥔)',
 			'lb' => '𞤐𞥋𞤄𞤢𞥄𞤣𞤭 𞤕𞤮𞤣𞤢𞤲𞤣𞤫 𞤁𞤭𞥅𞤣𞤮𞤤',
 			'ms' => '𞤐𞥋𞤔𞤵𞤩𞥆𞤵𞤣𞤭 𞤇𞤫𞤼𞤵',
 			'numbers' => '𞤈𞤢𞤽𞤢𞤥𞤫',

		}
	},
);

has 'display_name_type' => (
	is			=> 'ro',
	isa			=> HashRef[HashRef[Str]],
	init_arg	=> undef,
	default		=> sub {
		{
			'calendar' => {
 				'buddhist' => q{𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫 𞤄𞤵𞥅𞤣𞤢𞤴𞤢𞤲𞤳𞤮},
 				'chinese' => q{𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫 𞤅𞤭𞥅𞤲𞤭𞤲𞤳𞤮},
 				'dangi' => q{𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫 𞤁𞤢𞤲𞤺𞤭𞤲𞤳𞤮},
 				'ethiopic' => q{𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫 𞤀𞤦𞤢𞤧𞤭𞤴𞤢𞤲𞤳𞤮},
 				'gregorian' => q{𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫 𞤘𞤫𞤪𞤺𞤮𞤪𞤭𞤴𞤢𞤲𞤳𞤮},
 				'hebrew' => q{𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫 𞤋𞤦𞤪𞤭𞤴𞤢𞤲𞤳𞤮},
 				'islamic' => q{𞤙𞤢𞤤𞤥𞤫𞤪𞤫 𞤂𞤭𞤧𞤤𞤢𞥄𞤥𞤴𞤢𞤲𞤳𞤮},
 				'islamic-civil' => q{𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫 𞤂𞤭𞤧𞤤𞤢𞥄𞤥𞤴𞤢𞤲𞤳𞤮 (𞤢𞤤𞥆𞤵𞤱𞤢𞤤, 𞤬𞤫𞤱𞤲𞥋𞤣𞤮 𞤲𞥋𞤦𞤫𞤯𞥆𞤢𞥄𞤳𞤵)},
 				'islamic-tbla' => q{𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫 𞤂𞤭𞤧𞤤𞤢𞥄𞤥𞤵 (𞤀𞤤𞥆𞤵𞤲𞤳𞤮, 𞤊𞤫𞤱𞤣𞤮 𞤋𞤲𞤳𞤮𞥅𞤣𞤭𞤲𞤳𞤮)},
 				'iso8601' => q{𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫 ISO-8601},
 				'japanese' => q{𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫 𞤔𞤢𞥄𞤨𞤮𞤲𞤭𞤲𞤳𞤮},
 				'persian' => q{𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫 𞤊𞤢𞥄𞤪𞤭𞤧𞤭𞤴𞤢𞤲𞤳𞤮},
 				'roc' => q{𞤙𞤢𞤤𞤯𞤭𞤥𞤫𞤪𞤫 𞤘𞤫𞤲𞤣𞤭𞤴𞤢𞤲𞤳𞤮 𞤅𞤭𞥅𞤲},
 			},
 			'cf' => {
 				'account' => q{𞤃𞤢𞥄𞤲𞥋𞤣𞤫 𞤂𞤭𞤥𞤭𞤲𞤳𞤮 𞤐𞥋𞤄𞤵𞥅𞤯𞤭},
 				'standard' => q{𞤃𞤢𞥄𞤲𞥋𞤣𞤫 𞤚𞤢𞤦𞤵𞤼𞤵𞤲𞥋𞤣𞤫 𞤐𞥋𞤄𞤵𞥅𞤯𞤭},
 			},
 			'collation' => {
 				'ducet' => q{𞤈𞤫𞤱𞤲𞤭𞤲𞥋𞤣𞤭𞤪𞤮 𞤔𞤭𞤩𞤼𞤢𞤲𞤣𞤫 𞤊𞤭𞤩𞤢𞤲𞤣𞤫 Unicode},
 				'search' => q{𞤏𞤭𞤯𞤢𞤲𞤣𞤫 𞤖𞤵𞥅𞤩𞤵𞤲𞥋𞤣𞤫},
 				'standard' => q{𞤖𞤢𞤱𞤪𞤭𞤼𞤢𞤲𞤣𞤫 𞤈𞤫𞤱𞤲𞤭𞤲𞥋𞤣𞤭𞤪𞤮 𞤔𞤭𞤩𞤼𞤢𞤲𞤣𞤫},
 			},
 			'hc' => {
 				'h11' => q{𞤐𞥋𞤔𞤵𞤩𞥆𞤵𞤣𞤭 𞤁𞤵𞤥𞤵𞤲𞥆𞤢 𞤐𞥋𞤔𞤢𞤥𞤲𞥋𞤣𞤭 𞥑𞥒 (𞥐-𞥑𞥒)},
 				'h12' => q{𞤐𞥋𞤔𞤵𞤩𞥆𞤵𞤣𞤭 𞤁𞤵𞤥𞤵𞤲𞥆𞤢 𞤐𞥋𞤔𞤢𞤥𞤲𞥋𞤣𞤭 𞥑𞥒 (𞥑-𞥑𞥒)},
 				'h23' => q{𞤐𞥋𞤔𞤵𞤩𞥆𞤵𞤣𞤭 𞤁𞤵𞤥𞤵𞤲𞥆𞤢 𞤐𞥋𞤔𞤢𞤥𞤲𞥋𞤣𞤭 𞥒𞥔 (𞥐-𞥒𞥓)},
 				'h24' => q{𞤐𞥋𞤔𞤵𞤩𞥆𞤵𞤣𞤭 𞤁𞤵𞤥𞤵𞤲𞥆𞤢 𞤐𞥋𞤔𞤢𞤥𞤲𞥋𞤣𞤭 𞥒𞥔 (𞥑-𞥒𞥔)},
 			},
 			'lb' => {
 				'loose' => q{𞤐𞥋𞤄𞤢𞥄𞤣𞤭 𞤒𞤢𞤲𞤻𞤮 𞤕𞤮𞤣𞤢𞤲𞤣𞤫 𞤁𞤭𞥅𞤣𞤮𞤤},
 				'normal' => q{𞤐𞥋𞤄𞤢𞥄𞤣𞤭 𞤖𞤵𞥅𞤩𞤵𞤲𞥋𞤣𞤭 𞤕𞤮𞤣𞤢𞤲𞤣𞤫 𞤁𞤭𞥅𞤣𞤮𞤤},
 				'strict' => q{𞤐𞥋𞤄𞤢𞥄𞤣𞤭 𞤊𞤮𞤷𞥆𞤭𞥅𞤲𞥋𞤣𞤭 𞤕𞤮𞤣𞤢𞤲𞤣𞤫 𞤁𞤭𞥅𞤣𞤮𞤤},
 			},
 			'ms' => {
 				'metric' => q{𞤐𞥋𞤔𞤵𞤩𞥆𞤵𞤣𞤭 𞤃𞤫𞥅𞤼𞤭𞤲𞤳𞤮},
 				'uksystem' => q{𞤐𞥋𞤔𞤵𞤩𞥆𞤵𞤣𞤭 𞤇𞤫𞤼𞤵 𞤋𞤥𞤦𞤭𞤪𞤢𞥄𞤼𞤵},
 				'ussystem' => q{𞤐𞥋𞤔𞤵𞤩𞤵𞤣𞤭 𞤇𞤫𞤼𞤵 𞤁𞤂𞤀},
 			},
 			'numbers' => {
 				'arab' => q{𞤂𞤭𞤥𞤪𞤫 𞤀𞥄𞤪𞤢𞤦𞤭𞤲𞤳𞤮-𞤋𞤲𞤣𞤭𞤲𞤳𞤮},
 				'arabext' => q{𞤂𞤭𞤥𞤪𞤫 𞤀𞥄𞤪𞤢𞤦𞤭𞤲𞤳𞤮-𞤋𞤲𞤣𞤭𞤲𞤳𞤮 𞤙𞤢𞤲𞤻𞤢𞥄𞤲𞥋𞤣𞤫},
 				'armn' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤀𞤪𞤥𞤫𞤲𞤭𞤲𞤳𞤮},
 				'armnlow' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤚𞤮𞤧𞤮𞥅𞤳𞤫 𞤀𞤪𞤥𞤫𞤲𞤭𞤲𞤳𞤮},
 				'beng' => q{𞤂𞤭𞤥𞤫 𞤄𞤢𞤲𞤺𞤭𞤤𞤢𞤲𞤳𞤮},
 				'deva' => q{𞤂𞤭𞤥𞤫 𞤁𞤢𞤾𞤢𞤲𞤢𞤲𞤳𞤮},
 				'ethi' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤀𞤦𞤢𞤧𞤭𞤲𞤳𞤮},
 				'fullwide' => q{𞤂𞤭𞤥𞤫 𞤑𞤵𞥅𞤩𞤵𞤯𞤫},
 				'geor' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤔𞤮𞤪𞤶𞤭𞤲𞤳𞤮},
 				'grek' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤘𞤭𞤪𞤭𞤧𞤢𞤲𞤳𞤮},
 				'greklow' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤚𞤮𞤧𞤮𞥅𞤳𞤫 𞤘𞤭𞤪𞤭𞤧𞤢𞤲𞤳𞤮},
 				'gujr' => q{𞤂𞤭𞤥𞤫 𞤘𞤵𞤶𞤵𞤪𞤢𞤲𞤳𞤮},
 				'guru' => q{𞤂𞤭𞤥𞤫 𞤘𞤵𞤪𞤥𞤭𞤲𞤳𞤮},
 				'hanidec' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤁𞤫𞥅𞤧𞤭𞤥𞤶𞤫 𞤅𞤭𞥅𞤲𞤭𞤲𞤳𞤮},
 				'hans' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤐𞤫𞤱𞤭𞤲𞤢𞥄𞤯𞤫 𞤅𞤭𞥅𞤲𞤭𞤲𞤳𞤮},
 				'hansfin' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤅𞤭𞥅𞤲𞤭𞤲𞤳𞤮 𞤐𞤫𞤱𞤭𞤲𞤢𞥄𞤯𞤫 𞤐𞥋𞤘𞤢𞤤𞤵},
 				'hant' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤅𞤭𞥅𞤲𞤭𞤲𞤳𞤮 𞤊𞤭𞤲𞤼𞤢𞤱𞤢𞥄𞤶𞤫},
 				'hantfin' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤅𞤭𞥅𞤲𞤭𞤲𞤳𞤮 𞤊𞤭𞤲𞤼𞤢𞤱𞤢𞥄𞤶𞤫 𞤐𞥋𞤘𞤢𞤤𞤵},
 				'hebr' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤖𞤭𞥅𞤦𞤭𞤪𞤭𞤲𞤳𞤮},
 				'jpan' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤔𞤢𞥄𞤨𞤢𞤲𞤭𞤲𞤳𞤮},
 				'jpanfin' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤔𞤢𞥄𞤨𞤢𞤲𞤭𞤲𞤳𞤮 𞤐𞥋𞤔𞤢𞤤𞤵},
 				'khmr' => q{𞤂𞤭𞤥𞤫 𞤝𞤭𞥅𞤥𞤭𞤪𞤭𞤲𞤳𞤮},
 				'knda' => q{𞤂𞤭𞤥𞤫 𞤑𞤢𞥄𞤲𞤢𞤣𞤢𞤲𞤳𞤮},
 				'laoo' => q{𞤂𞤭𞤥𞤫 𞤂𞤢𞥄𞤱𞤮𞤴𞤢𞤲𞤳𞤮},
 				'latn' => q{𞤂𞤭𞤥𞤫 𞤖𞤭𞥅𞤪𞤲𞤢𞤲𞤳𞤮},
 				'mlym' => q{𞤂𞤭𞤥𞤫 𞤃𞤢𞤤𞤢𞤴𞤢𞤥𞤳𞤮},
 				'mymr' => q{𞤂𞤭𞤥𞤫 𞤃𞤭𞤴𞤢𞤥𞤢𞤪𞤳𞤮},
 				'orya' => q{𞤂𞤭𞤥𞤫 𞤌𞤣𞤭𞤴𞤢𞤲𞤳𞤮},
 				'roman' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤈𞤵𞥅𞤥𞤭𞤴𞤢𞤲𞤳𞤮},
 				'romanlow' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤚𞤮𞤧𞤮𞥅𞤳𞤫 𞤈𞤵𞥅𞤥𞤭𞤴𞤢𞤲𞤳𞤮},
 				'taml' => q{𞤈𞤢𞤽𞤢𞤥𞤫 𞤊𞤭𞤲𞤼𞤢𞤱𞤢𞥄𞤶𞤫 𞤚𞤢𞥄𞤥𞤭𞤤𞤭𞥅𞤴𞤢},
 				'tamldec' => q{𞤂𞤭𞤥𞤫 𞤚𞤢𞥄𞤥𞤭𞤤𞤭𞥅𞤴𞤢},
 				'telu' => q{𞤂𞤭𞤥𞤫 𞤚𞤫𞤤𞤵𞤺𞤵𞤲𞤳𞤮},
 				'thai' => q{𞤂𞤭𞤥𞤫 𞤚𞤢𞥄𞤴𞤭𞤲𞤳𞤮},
 				'tibt' => q{𞤂𞤭𞤥𞤫 𞤚𞤭𞤦𞤫𞤼𞤭𞤲𞤳𞤮},
 			},

		}
	},
);

has 'display_name_measurement_system' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub {
		{
			'metric' => q{𞤑𞤵𞥅𞤰𞤫 𞤃𞤫𞤼𞤭𞤪𞤳𞤵},
 			'UK' => q{𞤑𞤵𞥅𞤰𞤫 𞤁𞤘},
 			'US' => q{𞤑𞤵𞥅𞤰𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄 𞤁𞤂𞤀},

		}
	},
);

has 'display_name_code_patterns' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub {
		{
			'language' => '{0}',
 			'script' => '{0}',
 			'region' => '{0}',

		}
	},
);

has 'text_orientation' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub { return {
			lines => 'top-to-bottom',
			characters => 'right-to-left',
		}}
);

has 'characters' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> $^V ge v5.18.0
	? eval <<'EOT'
	sub {
		no warnings 'experimental::regex_sets';
		return {
			auxiliary => qr{[𞤾 𞤿 𞥀 𞥁 𞥂 𞥃]},
			index => ['𞤀', '𞤛'],
			main => qr{[𞥄𞥅𞥆 𞤢 𞤣 𞤤 𞤥 𞤦 𞤧 𞤨 𞤩 𞤪 𞤫 𞤬 𞤭 𞤮 𞤯 𞤰 𞤱 𞤲 𞤳 𞤴 𞤵 𞤶 𞤷 𞤸 𞤹 𞤺 𞤻 𞤼 𞤽 𞥋]},
			numbers => qr{[𞥐 𞥑 𞥒 𞥓 𞥔 𞥕 𞥖 𞥗 𞥘 𞥙]},
			punctuation => qr{[\- ‑ 𞥞 𞥟 . % ‰]},
		};
	},
EOT
: sub {
		return { index => ['𞤀', '𞤛'], };
},
);


has 'ellipsis' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub {
		return {
			'final' => '{0}…',
			'initial' => '…{0}',
			'medial' => '{0}…{1}',
			'word-final' => '{0}…',
			'word-initial' => '…{0}',
			'word-medial' => '{0} … {1}',
		};
	},
);

has 'more_information' => (
	is			=> 'ro',
	isa			=> Str,
	init_arg	=> undef,
	default		=> qq{؟},
);

has 'quote_start' => (
	is			=> 'ro',
	isa			=> Str,
	init_arg	=> undef,
	default		=> qq{“},
);

has 'quote_end' => (
	is			=> 'ro',
	isa			=> Str,
	init_arg	=> undef,
	default		=> qq{”},
);

has 'alternate_quote_start' => (
	is			=> 'ro',
	isa			=> Str,
	init_arg	=> undef,
	default		=> qq{‘},
);

has 'alternate_quote_end' => (
	is			=> 'ro',
	isa			=> Str,
	init_arg	=> undef,
	default		=> qq{’},
);

has 'units' => (
	is			=> 'ro',
	isa			=> HashRef[HashRef[HashRef[Str]]],
	init_arg	=> undef,
	default		=> sub { {
				'long' => {
					# Long Unit Identifier
					'' => {
						'name' => q(𞤦𞤢𞤲𞤽𞤢𞤤 𞤸𞤫𞤣𞥆𞤫),
					},
					# Core Unit Identifier
					'' => {
						'name' => q(𞤦𞤢𞤲𞤽𞤢𞤤 𞤸𞤫𞤣𞥆𞤫),
					},
					# Long Unit Identifier
					'1024p1' => {
						'1' => q(𞤳𞤭𞤦𞤭{0}),
					},
					# Core Unit Identifier
					'1024p1' => {
						'1' => q(𞤳𞤭𞤦𞤭{0}),
					},
					# Long Unit Identifier
					'1024p2' => {
						'1' => q(𞤥𞤫𞤦𞤭{0}),
					},
					# Core Unit Identifier
					'1024p2' => {
						'1' => q(𞤥𞤫𞤦𞤭{0}),
					},
					# Long Unit Identifier
					'1024p3' => {
						'1' => q(𞤺𞤭𞤦𞤭{0}),
					},
					# Core Unit Identifier
					'1024p3' => {
						'1' => q(𞤺𞤭𞤦𞤭{0}),
					},
					# Long Unit Identifier
					'1024p4' => {
						'1' => q(𞤼𞤫𞤦𞤭{0}),
					},
					# Core Unit Identifier
					'1024p4' => {
						'1' => q(𞤼𞤫𞤦𞤭{0}),
					},
					# Long Unit Identifier
					'1024p5' => {
						'1' => q(𞤨𞤫𞤦𞤭{0}),
					},
					# Core Unit Identifier
					'1024p5' => {
						'1' => q(𞤨𞤫𞤦𞤭{0}),
					},
					# Long Unit Identifier
					'1024p6' => {
						'1' => q(𞤫𞥁𞤦𞤭{0}),
					},
					# Core Unit Identifier
					'1024p6' => {
						'1' => q(𞤫𞥁𞤦𞤭{0}),
					},
					# Long Unit Identifier
					'1024p7' => {
						'1' => q(𞥁𞤫𞤦𞤭{0}),
					},
					# Core Unit Identifier
					'1024p7' => {
						'1' => q(𞥁𞤫𞤦𞤭{0}),
					},
					# Long Unit Identifier
					'1024p8' => {
						'1' => q(𞤴𞤮𞤦𞤭{0}),
					},
					# Core Unit Identifier
					'1024p8' => {
						'1' => q(𞤴𞤮𞤦𞤭{0}),
					},
					# Long Unit Identifier
					'10p-1' => {
						'1' => q(𞤣𞤫𞥅𞤧𞤭{0}),
					},
					# Core Unit Identifier
					'1' => {
						'1' => q(𞤣𞤫𞥅𞤧𞤭{0}),
					},
					# Long Unit Identifier
					'10p-12' => {
						'1' => q(𞤨𞤭𞤳𞤮{0}),
					},
					# Core Unit Identifier
					'12' => {
						'1' => q(𞤨𞤭𞤳𞤮{0}),
					},
					# Long Unit Identifier
					'10p-15' => {
						'1' => q(𞤬𞤫𞤥𞤼𞤮{0}),
					},
					# Core Unit Identifier
					'15' => {
						'1' => q(𞤬𞤫𞤥𞤼𞤮{0}),
					},
					# Long Unit Identifier
					'10p-18' => {
						'1' => q(𞤢𞤼𞥆𞤮{0}),
					},
					# Core Unit Identifier
					'18' => {
						'1' => q(𞤢𞤼𞥆𞤮{0}),
					},
					# Long Unit Identifier
					'10p-2' => {
						'1' => q(𞤧𞤫𞤲𞤼𞤭{0}),
					},
					# Core Unit Identifier
					'2' => {
						'1' => q(𞤧𞤫𞤲𞤼𞤭{0}),
					},
					# Long Unit Identifier
					'10p-21' => {
						'1' => q(𞥁𞤫𞤨𞤼𞤮{0}),
					},
					# Core Unit Identifier
					'21' => {
						'1' => q(𞥁𞤫𞤨𞤼𞤮{0}),
					},
					# Long Unit Identifier
					'10p-24' => {
						'1' => q(𞤴𞤮𞤳𞤼𞤮{0}),
					},
					# Core Unit Identifier
					'24' => {
						'1' => q(𞤴𞤮𞤳𞤼𞤮{0}),
					},
					# Long Unit Identifier
					'10p-3' => {
						'1' => q(𞤥𞤭𞤤𞤭{0}),
					},
					# Core Unit Identifier
					'3' => {
						'1' => q(𞤥𞤭𞤤𞤭{0}),
					},
					# Long Unit Identifier
					'10p-6' => {
						'1' => q(𞤻𞤭𞤤𞤢{0}),
					},
					# Core Unit Identifier
					'6' => {
						'1' => q(𞤻𞤭𞤤𞤢{0}),
					},
					# Long Unit Identifier
					'10p-9' => {
						'1' => q(𞤲𞤢𞤲𞤮{0}),
					},
					# Core Unit Identifier
					'9' => {
						'1' => q(𞤲𞤢𞤲𞤮{0}),
					},
					# Long Unit Identifier
					'10p1' => {
						'1' => q(𞤣𞤫𞤳𞤢{0}),
					},
					# Core Unit Identifier
					'10p1' => {
						'1' => q(𞤣𞤫𞤳𞤢{0}),
					},
					# Long Unit Identifier
					'10p12' => {
						'1' => q(𞤼𞤫𞤪𞤢{0}),
					},
					# Core Unit Identifier
					'10p12' => {
						'1' => q(𞤼𞤫𞤪𞤢{0}),
					},
					# Long Unit Identifier
					'10p15' => {
						'1' => q(𞤨𞤫𞤼𞤢{0}),
					},
					# Core Unit Identifier
					'10p15' => {
						'1' => q(𞤨𞤫𞤼𞤢{0}),
					},
					# Long Unit Identifier
					'10p18' => {
						'1' => q(𞤫𞥁𞤯{0}),
					},
					# Core Unit Identifier
					'10p18' => {
						'1' => q(𞤫𞥁𞤯{0}),
					},
					# Long Unit Identifier
					'10p2' => {
						'1' => q(𞤸𞤫𞤳𞤼𞤮{0}),
					},
					# Core Unit Identifier
					'10p2' => {
						'1' => q(𞤸𞤫𞤳𞤼𞤮{0}),
					},
					# Long Unit Identifier
					'10p21' => {
						'1' => q(𞥁𞤫𞤼𞥆𞤢{0}),
					},
					# Core Unit Identifier
					'10p21' => {
						'1' => q(𞥁𞤫𞤼𞥆𞤢{0}),
					},
					# Long Unit Identifier
					'10p24' => {
						'1' => q(𞤴𞤮𞤼𞥆𞤢{0}),
					},
					# Core Unit Identifier
					'10p24' => {
						'1' => q(𞤴𞤮𞤼𞥆𞤢{0}),
					},
					# Long Unit Identifier
					'10p3' => {
						'1' => q(𞤳𞤭𞤤𞤮{0}),
					},
					# Core Unit Identifier
					'10p3' => {
						'1' => q(𞤳𞤭𞤤𞤮{0}),
					},
					# Long Unit Identifier
					'10p6' => {
						'1' => q(𞤥𞤫𞤺𞤢{0}),
					},
					# Core Unit Identifier
					'10p6' => {
						'1' => q(𞤥𞤫𞤺𞤢{0}),
					},
					# Long Unit Identifier
					'10p9' => {
						'1' => q(𞤺𞤭𞤺𞤢{0}),
					},
					# Core Unit Identifier
					'10p9' => {
						'1' => q(𞤺𞤭𞤺𞤢{0}),
					},
					# Long Unit Identifier
					'acceleration-g-force' => {
						'name' => q(𞤵𞥅𞤴𞤲𞤣𞤭 𞤻𞤭𞥅𞤧𞤵𞤳𞤭 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'one' => q({0} 𞤲𞤣𞤫 𞤵𞥅𞤴𞤲𞤣𞤭 𞤻𞤭𞥅𞤧𞤵𞤳𞤭 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'other' => q({0} 𞤲𞤣𞤫 𞤵𞥅𞤴𞤲𞤣𞤭 𞤻𞤭𞥅𞤧𞤵𞤳𞤭 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
					},
					# Core Unit Identifier
					'g-force' => {
						'name' => q(𞤵𞥅𞤴𞤲𞤣𞤭 𞤻𞤭𞥅𞤧𞤵𞤳𞤭 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'one' => q({0} 𞤲𞤣𞤫 𞤵𞥅𞤴𞤲𞤣𞤭 𞤻𞤭𞥅𞤧𞤵𞤳𞤭 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'other' => q({0} 𞤲𞤣𞤫 𞤵𞥅𞤴𞤲𞤣𞤭 𞤻𞤭𞥅𞤧𞤵𞤳𞤭 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
					},
					# Long Unit Identifier
					'acceleration-meter-per-square-second' => {
						'name' => q(𞤥𞤫𞥅𞤼𞤭 𞤲𞤣𞤫𞤪 𞤳𞤭𞤲𞤰𞤫𞤪𞤫 𞤣𞤭𞤲𞤺𞤢𞥄𞤲𞤣𞤫),
						'one' => q({0} 𞤥𞤫𞥅𞤼𞤮𞤤 𞤲𞤣𞤫𞤪 𞤳𞤭𞤲𞤰𞤫𞤪𞤫 𞤣𞤭𞤲𞤺𞤢𞥄𞤲𞤣𞤫),
						'other' => q({0} 𞤥𞤫𞥅𞤼𞤭 𞤲𞤣𞤫𞤪 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤪𞤫 𞤣𞤭𞤲𞤺𞤢𞥄𞤲𞤣𞤫),
					},
					# Core Unit Identifier
					'meter-per-square-second' => {
						'name' => q(𞤥𞤫𞥅𞤼𞤭 𞤲𞤣𞤫𞤪 𞤳𞤭𞤲𞤰𞤫𞤪𞤫 𞤣𞤭𞤲𞤺𞤢𞥄𞤲𞤣𞤫),
						'one' => q({0} 𞤥𞤫𞥅𞤼𞤮𞤤 𞤲𞤣𞤫𞤪 𞤳𞤭𞤲𞤰𞤫𞤪𞤫 𞤣𞤭𞤲𞤺𞤢𞥄𞤲𞤣𞤫),
						'other' => q({0} 𞤥𞤫𞥅𞤼𞤭 𞤲𞤣𞤫𞤪 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤪𞤫 𞤣𞤭𞤲𞤺𞤢𞥄𞤲𞤣𞤫),
					},
					# Long Unit Identifier
					'angle-arc-minute' => {
						'name' => q(𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫 𞤤𞤢𞥄𞤻𞤢𞤤),
						'one' => q({0} 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤪𞤫 𞤤𞤢𞥄𞤻𞤢𞤤),
						'other' => q({0} 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫 𞤤𞤢𞥄𞤻𞤢𞤤),
					},
					# Core Unit Identifier
					'arc-minute' => {
						'name' => q(𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫 𞤤𞤢𞥄𞤻𞤢𞤤),
						'one' => q({0} 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤪𞤫 𞤤𞤢𞥄𞤻𞤢𞤤),
						'other' => q({0} 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫 𞤤𞤢𞥄𞤻𞤢𞤤),
					},
					# Long Unit Identifier
					'angle-arc-second' => {
						'name' => q(𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫 𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'one' => q({0} 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫 𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'other' => q({0} 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫 𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
					},
					# Core Unit Identifier
					'arc-second' => {
						'name' => q(𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫 𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'one' => q({0} 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫 𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'other' => q({0} 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫 𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
					},
					# Long Unit Identifier
					'angle-degree' => {
						'name' => q(𞤶𞤫𞤩𞤫),
						'one' => q({0} 𞤶𞤫𞤩𞤫𞤪𞤫),
						'other' => q({0} 𞤶𞤫𞤩𞤫),
					},
					# Core Unit Identifier
					'degree' => {
						'name' => q(𞤶𞤫𞤩𞤫),
						'one' => q({0} 𞤶𞤫𞤩𞤫𞤪𞤫),
						'other' => q({0} 𞤶𞤫𞤩𞤫),
					},
					# Long Unit Identifier
					'angle-radian' => {
						'name' => q(𞤪𞤢𞤣𞤭𞤴𞤢𞤲𞤶𞤭),
						'one' => q({0} 𞤪𞤢𞤣𞤭𞤴𞤢𞤲𞤪𞤵),
						'other' => q({0} 𞤪𞤢𞤣𞤭𞤴𞤢𞤲𞤶𞤭),
					},
					# Core Unit Identifier
					'radian' => {
						'name' => q(𞤪𞤢𞤣𞤭𞤴𞤢𞤲𞤶𞤭),
						'one' => q({0} 𞤪𞤢𞤣𞤭𞤴𞤢𞤲𞤪𞤵),
						'other' => q({0} 𞤪𞤢𞤣𞤭𞤴𞤢𞤲𞤶𞤭),
					},
					# Long Unit Identifier
					'angle-revolution' => {
						'name' => q(𞤱𞤭𞤣𞥆𞤢𞤲𞤣𞤫),
						'one' => q({0} 𞤱𞤭𞤣𞥆𞤢𞤲𞤣𞤫),
						'other' => q({0} 𞤱𞤭𞤣𞥆𞤢𞤲𞤯𞤫),
					},
					# Core Unit Identifier
					'revolution' => {
						'name' => q(𞤱𞤭𞤣𞥆𞤢𞤲𞤣𞤫),
						'one' => q({0} 𞤱𞤭𞤣𞥆𞤢𞤲𞤣𞤫),
						'other' => q({0} 𞤱𞤭𞤣𞥆𞤢𞤲𞤯𞤫),
					},
					# Long Unit Identifier
					'area-acre' => {
						'name' => q(𞤺𞤢𞤪𞤳𞤭),
						'one' => q({0} 𞤺𞤢𞤪𞤳𞤵),
						'other' => q({0} 𞤺𞤢𞤪𞤳𞤭),
					},
					# Core Unit Identifier
					'acre' => {
						'name' => q(𞤺𞤢𞤪𞤳𞤭),
						'one' => q({0} 𞤺𞤢𞤪𞤳𞤵),
						'other' => q({0} 𞤺𞤢𞤪𞤳𞤭),
					},
					# Long Unit Identifier
					'area-dunam' => {
						'name' => q(𞤣𞤵𞥅𞤲𞤢𞤥𞤭),
						'one' => q({0} 𞤣𞤵𞥅𞤲𞤢𞤥𞤵),
						'other' => q({0} 𞤣𞤵𞥅𞤲𞤢𞤥𞤭),
					},
					# Core Unit Identifier
					'dunam' => {
						'name' => q(𞤣𞤵𞥅𞤲𞤢𞤥𞤭),
						'one' => q({0} 𞤣𞤵𞥅𞤲𞤢𞤥𞤵),
						'other' => q({0} 𞤣𞤵𞥅𞤲𞤢𞤥𞤭),
					},
					# Long Unit Identifier
					'area-hectare' => {
						'name' => q(𞤸𞤫𞤳𞤼𞤢𞤪𞤯𞤫),
						'one' => q({0} 𞤸𞤫𞤳𞤼𞤢𞤪𞤣𞤫),
						'other' => q({0} 𞤸𞤫𞤳𞤼𞤢𞤪𞤯𞤫),
					},
					# Core Unit Identifier
					'hectare' => {
						'name' => q(𞤸𞤫𞤳𞤼𞤢𞤪𞤯𞤫),
						'one' => q({0} 𞤸𞤫𞤳𞤼𞤢𞤪𞤣𞤫),
						'other' => q({0} 𞤸𞤫𞤳𞤼𞤢𞤪𞤯𞤫),
					},
					# Long Unit Identifier
					'area-square-centimeter' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'square-centimeter' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'area-square-foot' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤼𞤫𞤨𞥆𞤭),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤼𞤫𞤨𞥆𞤵),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤼𞤫𞤨𞥆𞤭),
					},
					# Core Unit Identifier
					'square-foot' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤼𞤫𞤨𞥆𞤭),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤼𞤫𞤨𞥆𞤵),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤼𞤫𞤨𞥆𞤭),
					},
					# Long Unit Identifier
					'area-square-inch' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤭),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤵),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤵),
					},
					# Core Unit Identifier
					'square-inch' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤭),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤵),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤵),
					},
					# Long Unit Identifier
					'area-square-kilometer' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Core Unit Identifier
					'square-kilometer' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Long Unit Identifier
					'area-square-meter' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Core Unit Identifier
					'square-meter' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Long Unit Identifier
					'area-square-mile' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤢𞤴𞤤𞤭),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤢𞤴𞤤𞤵),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤢𞤴𞤤𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤢𞤴𞤤𞤵),
					},
					# Core Unit Identifier
					'square-mile' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤢𞤴𞤤𞤭),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤢𞤴𞤤𞤵),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤢𞤴𞤤𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤥𞤢𞤴𞤤𞤵),
					},
					# Long Unit Identifier
					'area-square-yard' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤮𞤺𞤮𞤲𞤫),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤮𞤺𞤮𞤲𞤢𞤤),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤮𞤺𞤮𞤲𞤫),
					},
					# Core Unit Identifier
					'square-yard' => {
						'name' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤮𞤺𞤮𞤲𞤫),
						'one' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤮𞤺𞤮𞤲𞤢𞤤),
						'other' => q({0} 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤧𞤮𞤺𞤮𞤲𞤫),
					},
					# Long Unit Identifier
					'concentr-milligram-ofglucose-per-deciliter' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤺𞤢𞤪𞤬𞤭 𞤲𞤣𞤫𞤪 𞤣𞤫𞥅𞤧𞤭𞤤𞤭𞥅𞤼𞤵),
					},
					# Core Unit Identifier
					'milligram-ofglucose-per-deciliter' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤺𞤢𞤪𞤬𞤭 𞤲𞤣𞤫𞤪 𞤣𞤫𞥅𞤧𞤭𞤤𞤭𞥅𞤼𞤵),
					},
					# Long Unit Identifier
					'coordinate' => {
						'east' => q({0} 𞤬𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫),
						'north' => q({0} 𞤲𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫),
						'south' => q({0} 𞤻𞤢𞤥𞤲𞤢𞥄𞤲𞤺𞤫),
						'west' => q({0} 𞤸𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫),
					},
					# Core Unit Identifier
					'coordinate' => {
						'east' => q({0} 𞤬𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫),
						'north' => q({0} 𞤲𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫),
						'south' => q({0} 𞤻𞤢𞤥𞤲𞤢𞥄𞤲𞤺𞤫),
						'west' => q({0} 𞤸𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫),
					},
					# Long Unit Identifier
					'digital-bit' => {
						'name' => q(𞤦𞤭𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤦𞤭𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤦𞤭𞥅𞤼𞥆𞤭),
					},
					# Core Unit Identifier
					'bit' => {
						'name' => q(𞤦𞤭𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤦𞤭𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤦𞤭𞥅𞤼𞥆𞤭),
					},
					# Long Unit Identifier
					'digital-byte' => {
						'name' => q(𞤶𞤫𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤶𞤫𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤶𞤫𞥅𞤼𞥆𞤭),
					},
					# Core Unit Identifier
					'byte' => {
						'name' => q(𞤶𞤫𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤶𞤫𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤶𞤫𞥅𞤼𞥆𞤭),
					},
					# Long Unit Identifier
					'digital-gigabit' => {
						'name' => q(𞤺𞤭𞤺𞤢𞤦𞤭𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤺𞤭𞤺𞤢𞤦𞤭𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤺𞤭𞤺𞤢𞤦𞤭𞥅𞤼𞥆𞤭),
					},
					# Core Unit Identifier
					'gigabit' => {
						'name' => q(𞤺𞤭𞤺𞤢𞤦𞤭𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤺𞤭𞤺𞤢𞤦𞤭𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤺𞤭𞤺𞤢𞤦𞤭𞥅𞤼𞥆𞤭),
					},
					# Long Unit Identifier
					'digital-gigabyte' => {
						'name' => q(𞤺𞤭𞤺𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤺𞤭𞤺𞤢𞤶𞤫𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤺𞤭𞤺𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
					},
					# Core Unit Identifier
					'gigabyte' => {
						'name' => q(𞤺𞤭𞤺𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤺𞤭𞤺𞤢𞤶𞤫𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤺𞤭𞤺𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
					},
					# Long Unit Identifier
					'digital-kilobit' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤦𞤭𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤦𞤭𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤦𞤭𞥅𞤼𞥆𞤭),
					},
					# Core Unit Identifier
					'kilobit' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤦𞤭𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤦𞤭𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤦𞤭𞥅𞤼𞥆𞤭),
					},
					# Long Unit Identifier
					'digital-kilobyte' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤶𞤫𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤶𞤫𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤶𞤫𞥅𞤼𞥆𞤭),
					},
					# Core Unit Identifier
					'kilobyte' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤶𞤫𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤶𞤫𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤶𞤫𞥅𞤼𞥆𞤭),
					},
					# Long Unit Identifier
					'digital-megabit' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤦𞤭𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤦𞤭𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤦𞤭𞥅𞤼𞥆𞤭),
					},
					# Core Unit Identifier
					'megabit' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤦𞤭𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤦𞤭𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤦𞤭𞥅𞤼𞥆𞤭),
					},
					# Long Unit Identifier
					'digital-megabyte' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤶𞤫𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
					},
					# Core Unit Identifier
					'megabyte' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤶𞤫𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
					},
					# Long Unit Identifier
					'digital-petabyte' => {
						'name' => q(𞤨𞤫𞤼𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤨𞤫𞤼𞤢𞤶𞤫𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤨𞤫𞤼𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
					},
					# Core Unit Identifier
					'petabyte' => {
						'name' => q(𞤨𞤫𞤼𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤨𞤫𞤼𞤢𞤶𞤫𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤨𞤫𞤼𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
					},
					# Long Unit Identifier
					'digital-terabit' => {
						'name' => q(𞤼𞤫𞤪𞤢𞤦𞤭𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤼𞤫𞤪𞤢𞤦𞤭𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤼𞤫𞤪𞤢𞤦𞤭𞥅𞤼𞥆𞤭),
					},
					# Core Unit Identifier
					'terabit' => {
						'name' => q(𞤼𞤫𞤪𞤢𞤦𞤭𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤼𞤫𞤪𞤢𞤦𞤭𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤼𞤫𞤪𞤢𞤦𞤭𞥅𞤼𞥆𞤭),
					},
					# Long Unit Identifier
					'digital-terabyte' => {
						'name' => q(𞤼𞤫𞤪𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤼𞤫𞤪𞤢𞤶𞤫𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤼𞤫𞤪𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
					},
					# Core Unit Identifier
					'terabyte' => {
						'name' => q(𞤼𞤫𞤪𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤼𞤫𞤪𞤢𞤶𞤫𞥅𞤼𞥆𞤵),
						'other' => q({0} 𞤼𞤫𞤪𞤢𞤶𞤫𞥅𞤼𞥆𞤭),
					},
					# Long Unit Identifier
					'duration-century' => {
						'name' => q(𞤼𞤫𞥅𞤥𞤭𞤲𞤢𞤲𞤯𞤫),
						'one' => q({0} 𞤼𞤫𞥅𞤥𞤭𞤲𞤢𞤲𞤣𞤫),
						'other' => q({0} 𞤼𞤫𞥅𞤥𞤭𞤲𞤢𞤲𞤯𞤫),
					},
					# Core Unit Identifier
					'century' => {
						'name' => q(𞤼𞤫𞥅𞤥𞤭𞤲𞤢𞤲𞤯𞤫),
						'one' => q({0} 𞤼𞤫𞥅𞤥𞤭𞤲𞤢𞤲𞤣𞤫),
						'other' => q({0} 𞤼𞤫𞥅𞤥𞤭𞤲𞤢𞤲𞤯𞤫),
					},
					# Long Unit Identifier
					'duration-day' => {
						'name' => q(𞤻𞤢𞤤𞥆𞤢𞤤),
						'one' => q({0} 𞤻𞤢𞤤𞥆𞤢𞤤),
						'other' => q({0} 𞤻𞤢𞤤𞥆𞤫),
						'per' => q({0} 𞤲𞥋𞤣𞤫𞤪 𞤻𞤢𞤤𞥆𞤢𞤤),
					},
					# Core Unit Identifier
					'day' => {
						'name' => q(𞤻𞤢𞤤𞥆𞤢𞤤),
						'one' => q({0} 𞤻𞤢𞤤𞥆𞤢𞤤),
						'other' => q({0} 𞤻𞤢𞤤𞥆𞤫),
						'per' => q({0} 𞤲𞥋𞤣𞤫𞤪 𞤻𞤢𞤤𞥆𞤢𞤤),
					},
					# Long Unit Identifier
					'duration-decade' => {
						'name' => q(𞤼𞤭𞤶𞤢𞤲𞤯𞤫),
						'one' => q({0} 𞤼𞤭𞤶𞤢𞤲𞤣𞤫),
						'other' => q({0} 𞤼𞤭𞤶𞤢𞤲𞤯𞤫),
					},
					# Core Unit Identifier
					'decade' => {
						'name' => q(𞤼𞤭𞤶𞤢𞤲𞤯𞤫),
						'one' => q({0} 𞤼𞤭𞤶𞤢𞤲𞤣𞤫),
						'other' => q({0} 𞤼𞤭𞤶𞤢𞤲𞤯𞤫),
					},
					# Long Unit Identifier
					'duration-hour' => {
						'name' => q(𞤲𞤶𞤢𞤥𞤤𞤭),
						'one' => q({0} 𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'other' => q({0} 𞤲𞤶𞤢𞤥𞤤𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
					},
					# Core Unit Identifier
					'hour' => {
						'name' => q(𞤲𞤶𞤢𞤥𞤤𞤭),
						'one' => q({0} 𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'other' => q({0} 𞤲𞤶𞤢𞤥𞤤𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
					},
					# Long Unit Identifier
					'duration-microsecond' => {
						'name' => q(𞤻𞤭𞤤𞤢𞤳𞤭𞤲𞤰𞤫),
						'one' => q({0} 𞤻𞤭𞤤𞤢𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'other' => q({0} 𞤻𞤭𞤤𞤢𞤳𞤭𞤲𞤰𞤫),
					},
					# Core Unit Identifier
					'microsecond' => {
						'name' => q(𞤻𞤭𞤤𞤢𞤳𞤭𞤲𞤰𞤫),
						'one' => q({0} 𞤻𞤭𞤤𞤢𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'other' => q({0} 𞤻𞤭𞤤𞤢𞤳𞤭𞤲𞤰𞤫),
					},
					# Long Unit Identifier
					'duration-millisecond' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤳𞤭𞤲𞤰𞤫),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤳𞤭𞤲𞤰𞤫),
					},
					# Core Unit Identifier
					'millisecond' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤳𞤭𞤲𞤰𞤫),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤳𞤭𞤲𞤰𞤫),
					},
					# Long Unit Identifier
					'duration-minute' => {
						'name' => q(𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫),
						'one' => q({0} 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤪𞤫),
						'other' => q({0} 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤪𞤫),
					},
					# Core Unit Identifier
					'minute' => {
						'name' => q(𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫),
						'one' => q({0} 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤪𞤫),
						'other' => q({0} 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤶𞤫),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤸𞤮𞤶𞤮𞤥𞤢𞥄𞤪𞤫),
					},
					# Long Unit Identifier
					'duration-month' => {
						'name' => q(𞤤𞤫𞤦𞥆𞤭),
						'one' => q({0} 𞤤𞤫𞤱𞤪𞤵),
						'other' => q({0} 𞤤𞤫𞤦𞥆𞤭),
						'per' => q({0} 𞤲𞥋𞤣𞤫𞤪 𞤤𞤫𞤱𞤪𞤵),
					},
					# Core Unit Identifier
					'month' => {
						'name' => q(𞤤𞤫𞤦𞥆𞤭),
						'one' => q({0} 𞤤𞤫𞤱𞤪𞤵),
						'other' => q({0} 𞤤𞤫𞤦𞥆𞤭),
						'per' => q({0} 𞤲𞥋𞤣𞤫𞤪 𞤤𞤫𞤱𞤪𞤵),
					},
					# Long Unit Identifier
					'duration-nanosecond' => {
						'name' => q(𞤲𞤢𞤲𞤮𞥅𞤳𞤭𞤲𞤰𞤫),
						'one' => q({0} 𞤲𞤢𞤲𞤮𞥅𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'other' => q({0} 𞤲𞤢𞤲𞤮𞥅𞤳𞤭𞤲𞤰𞤫),
					},
					# Core Unit Identifier
					'nanosecond' => {
						'name' => q(𞤲𞤢𞤲𞤮𞥅𞤳𞤭𞤲𞤰𞤫),
						'one' => q({0} 𞤲𞤢𞤲𞤮𞥅𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'other' => q({0} 𞤲𞤢𞤲𞤮𞥅𞤳𞤭𞤲𞤰𞤫),
					},
					# Long Unit Identifier
					'duration-second' => {
						'name' => q(𞤳𞤭𞤲𞤰𞤫),
						'one' => q({0} 𞤳𞤭𞤲𞤰𞤮),
						'other' => q({0} 𞤳𞤭𞤲𞤰𞤫),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤳𞤭𞤲𞤰𞤫),
					},
					# Core Unit Identifier
					'second' => {
						'name' => q(𞤳𞤭𞤲𞤰𞤫),
						'one' => q({0} 𞤳𞤭𞤲𞤰𞤮),
						'other' => q({0} 𞤳𞤭𞤲𞤰𞤫),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤳𞤭𞤲𞤰𞤫),
					},
					# Long Unit Identifier
					'duration-week' => {
						'name' => q(𞤶𞤮𞤲𞤼𞤫),
						'one' => q({0} 𞤴𞤮𞤲𞤼𞤫𞤪𞤫),
						'other' => q({0} 𞤶𞤮𞤲𞤼𞤫),
						'per' => q({0} 𞤲𞥋𞤣𞤫𞤪 𞤴𞤮𞤲𞤼𞤫𞤪𞤫),
					},
					# Core Unit Identifier
					'week' => {
						'name' => q(𞤶𞤮𞤲𞤼𞤫),
						'one' => q({0} 𞤴𞤮𞤲𞤼𞤫𞤪𞤫),
						'other' => q({0} 𞤶𞤮𞤲𞤼𞤫),
						'per' => q({0} 𞤲𞥋𞤣𞤫𞤪 𞤴𞤮𞤲𞤼𞤫𞤪𞤫),
					},
					# Long Unit Identifier
					'duration-year' => {
						'name' => q(𞤳𞤭𞤼𞤢𞥄𞤯𞤫),
						'one' => q({0} 𞤸𞤭𞤼𞤢𞥄𞤲𞥋𞤣𞤫),
						'other' => q({0} 𞤳𞤭𞤼𞤢𞥄𞤯𞤫),
						'per' => q({0} 𞤲𞥋𞤣𞤫𞤪 𞤸𞤭𞤼𞤢𞥄𞤲𞥋𞤣𞤫),
					},
					# Core Unit Identifier
					'year' => {
						'name' => q(𞤳𞤭𞤼𞤢𞥄𞤯𞤫),
						'one' => q({0} 𞤸𞤭𞤼𞤢𞥄𞤲𞥋𞤣𞤫),
						'other' => q({0} 𞤳𞤭𞤼𞤢𞥄𞤯𞤫),
						'per' => q({0} 𞤲𞥋𞤣𞤫𞤪 𞤸𞤭𞤼𞤢𞥄𞤲𞥋𞤣𞤫),
					},
					# Long Unit Identifier
					'electric-ampere' => {
						'name' => q(𞤢𞤥𞤨𞤫𞤪𞤶𞤭),
						'one' => q({0} 𞤢𞤥𞤨𞤫𞤪𞤱𞤵),
						'other' => q({0} 𞤢𞤥𞤨𞤫𞤪𞤶𞤭),
					},
					# Core Unit Identifier
					'ampere' => {
						'name' => q(𞤢𞤥𞤨𞤫𞤪𞤶𞤭),
						'one' => q({0} 𞤢𞤥𞤨𞤫𞤪𞤱𞤵),
						'other' => q({0} 𞤢𞤥𞤨𞤫𞤪𞤶𞤭),
					},
					# Long Unit Identifier
					'electric-milliampere' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤢𞤥𞤨𞤫𞤪𞤶𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤢𞤥𞤨𞤫𞤪𞤱𞤵),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤢𞤥𞤨𞤫𞤪𞤶𞤭),
					},
					# Core Unit Identifier
					'milliampere' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤢𞤥𞤨𞤫𞤪𞤶𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤢𞤥𞤨𞤫𞤪𞤱𞤵),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤢𞤥𞤨𞤫𞤪𞤶𞤭),
					},
					# Long Unit Identifier
					'electric-ohm' => {
						'name' => q(𞤮𞤸𞤥𞤵𞥅𞤶𞤭),
						'one' => q({0} 𞤮𞤸𞤥𞤵),
						'other' => q({0} 𞤮𞤸𞤥𞤵𞥅𞤶𞤭),
					},
					# Core Unit Identifier
					'ohm' => {
						'name' => q(𞤮𞤸𞤥𞤵𞥅𞤶𞤭),
						'one' => q({0} 𞤮𞤸𞤥𞤵),
						'other' => q({0} 𞤮𞤸𞤥𞤵𞥅𞤶𞤭),
					},
					# Long Unit Identifier
					'electric-volt' => {
						'name' => q(𞤾𞤮𞤤𞤼𞤵𞥅𞤶𞤭),
						'one' => q({0} 𞤾𞤮𞤤𞤼𞤵),
						'other' => q({0} 𞤾𞤮𞤤𞤼𞤵𞥅𞤶𞤭),
					},
					# Core Unit Identifier
					'volt' => {
						'name' => q(𞤾𞤮𞤤𞤼𞤵𞥅𞤶𞤭),
						'one' => q({0} 𞤾𞤮𞤤𞤼𞤵),
						'other' => q({0} 𞤾𞤮𞤤𞤼𞤵𞥅𞤶𞤭),
					},
					# Long Unit Identifier
					'energy-british-thermal-unit' => {
						'name' => q(𞤑𞤵𞥅𞤰𞤫 𞤲𞤺𞤵𞤤𞤲𞤣𞤭𞤲𞤳𞤮 𞤄𞤭𞤪𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
						'one' => q({0} 𞤑𞤵𞥅𞤰𞤮 𞤲𞤺𞤵𞤤𞤣𞤭𞤲𞤳𞤮 𞤄𞤭𞤪𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
						'other' => q({0} 𞤑𞤵𞥅𞤰𞤫 𞤲𞤺𞤵𞤤𞤣𞤭𞤲𞤳𞤮 𞤄𞤭𞤪𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
					},
					# Core Unit Identifier
					'british-thermal-unit' => {
						'name' => q(𞤑𞤵𞥅𞤰𞤫 𞤲𞤺𞤵𞤤𞤲𞤣𞤭𞤲𞤳𞤮 𞤄𞤭𞤪𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
						'one' => q({0} 𞤑𞤵𞥅𞤰𞤮 𞤲𞤺𞤵𞤤𞤣𞤭𞤲𞤳𞤮 𞤄𞤭𞤪𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
						'other' => q({0} 𞤑𞤵𞥅𞤰𞤫 𞤲𞤺𞤵𞤤𞤣𞤭𞤲𞤳𞤮 𞤄𞤭𞤪𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
					},
					# Long Unit Identifier
					'energy-calorie' => {
						'name' => q(𞤲𞤺𞤵𞤤𞤭),
						'one' => q({0} 𞤲𞤺𞤵𞤤𞤵),
						'other' => q({0} 𞤲𞤺𞤵𞤤𞤭),
					},
					# Core Unit Identifier
					'calorie' => {
						'name' => q(𞤲𞤺𞤵𞤤𞤭),
						'one' => q({0} 𞤲𞤺𞤵𞤤𞤵),
						'other' => q({0} 𞤲𞤺𞤵𞤤𞤭),
					},
					# Long Unit Identifier
					'energy-electronvolt' => {
						'name' => q(𞤫𞤤𞤫𞤳𞤼𞤮𞤾𞤮𞤤𞤼𞤵𞥅𞤶𞤭),
						'one' => q({0} 𞤫𞤤𞤫𞤳𞤼𞤮𞤾𞤮𞤤𞤼𞤵),
						'other' => q({0} 𞤫𞤤𞤫𞤳𞤼𞤮𞤾𞤮𞤤𞤼𞤵𞥅𞤶𞤭),
					},
					# Core Unit Identifier
					'electronvolt' => {
						'name' => q(𞤫𞤤𞤫𞤳𞤼𞤮𞤾𞤮𞤤𞤼𞤵𞥅𞤶𞤭),
						'one' => q({0} 𞤫𞤤𞤫𞤳𞤼𞤮𞤾𞤮𞤤𞤼𞤵),
						'other' => q({0} 𞤫𞤤𞤫𞤳𞤼𞤮𞤾𞤮𞤤𞤼𞤵𞥅𞤶𞤭),
					},
					# Long Unit Identifier
					'energy-foodcalorie' => {
						'name' => q(𞤐𞤺𞤵𞤤𞤭),
						'one' => q({0} 𞤐𞤺𞤵𞤤𞤵),
						'other' => q({0} 𞤐𞤺𞤵𞤤𞤭),
					},
					# Core Unit Identifier
					'foodcalorie' => {
						'name' => q(𞤐𞤺𞤵𞤤𞤭),
						'one' => q({0} 𞤐𞤺𞤵𞤤𞤵),
						'other' => q({0} 𞤐𞤺𞤵𞤤𞤭),
					},
					# Long Unit Identifier
					'energy-joule' => {
						'name' => q(𞥁𞤵𞥅𞤤𞤶𞤭),
						'one' => q({0} 𞥁𞤵𞥅𞤤𞤱𞤵),
						'other' => q({0} 𞥁𞤵𞥅𞤤𞤶𞤭),
					},
					# Core Unit Identifier
					'joule' => {
						'name' => q(𞥁𞤵𞥅𞤤𞤶𞤭),
						'one' => q({0} 𞥁𞤵𞥅𞤤𞤱𞤵),
						'other' => q({0} 𞥁𞤵𞥅𞤤𞤶𞤭),
					},
					# Long Unit Identifier
					'energy-kilocalorie' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤲𞤺𞤵𞤤𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤲𞤺𞤵𞤤𞤵),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤲𞤺𞤵𞤤𞤭),
					},
					# Core Unit Identifier
					'kilocalorie' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤲𞤺𞤵𞤤𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤲𞤺𞤵𞤤𞤵),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤲𞤺𞤵𞤤𞤭),
					},
					# Long Unit Identifier
					'energy-kilojoule' => {
						'name' => q(𞤳𞤭𞤤𞤮𞥁𞤵𞥅𞤤𞤶𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞥁𞤵𞥅𞤤𞤶𞤭),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞥁𞤵𞥅𞤤𞤶𞤭),
					},
					# Core Unit Identifier
					'kilojoule' => {
						'name' => q(𞤳𞤭𞤤𞤮𞥁𞤵𞥅𞤤𞤶𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞥁𞤵𞥅𞤤𞤶𞤭),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞥁𞤵𞥅𞤤𞤶𞤭),
					},
					# Long Unit Identifier
					'energy-kilowatt-hour' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤱𞤢𞥄𞤼𞤵-𞤲𞤶𞤢𞤥𞤤𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤱𞤢𞥄𞤼𞤵-𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤱𞤢𞥄𞤼𞤵-𞤲𞤶𞤢𞤥𞤤𞤭),
					},
					# Core Unit Identifier
					'kilowatt-hour' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤱𞤢𞥄𞤼𞤵-𞤲𞤶𞤢𞤥𞤤𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤱𞤢𞥄𞤼𞤵-𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤱𞤢𞥄𞤼𞤵-𞤲𞤶𞤢𞤥𞤤𞤭),
					},
					# Long Unit Identifier
					'energy-therm-us' => {
						'name' => q(𞤲𞤺𞤵𞤤𞤣𞤭𞤲𞤳𞤫 𞤁𞤀),
						'one' => q({0} 𞤲𞤺𞤵𞤤𞤣𞤭𞤲𞤳𞤮 𞤁𞤀),
						'other' => q({0} 𞤲𞤺𞤵𞤤𞤣𞤭𞤲𞤳𞤫 𞤁𞤀),
					},
					# Core Unit Identifier
					'therm-us' => {
						'name' => q(𞤲𞤺𞤵𞤤𞤣𞤭𞤲𞤳𞤫 𞤁𞤀),
						'one' => q({0} 𞤲𞤺𞤵𞤤𞤣𞤭𞤲𞤳𞤮 𞤁𞤀),
						'other' => q({0} 𞤲𞤺𞤵𞤤𞤣𞤭𞤲𞤳𞤫 𞤁𞤀),
					},
					# Long Unit Identifier
					'force-newton' => {
						'name' => q(𞤲𞤫𞤱𞤼𞤮𞤲𞤶𞤭),
						'one' => q({0} 𞤲𞤫𞤱𞤼𞤮𞤲),
						'other' => q({0} 𞤲𞤫𞤱𞤼𞤮𞤲𞤶𞤭),
					},
					# Core Unit Identifier
					'newton' => {
						'name' => q(𞤲𞤫𞤱𞤼𞤮𞤲𞤶𞤭),
						'one' => q({0} 𞤲𞤫𞤱𞤼𞤮𞤲),
						'other' => q({0} 𞤲𞤫𞤱𞤼𞤮𞤲𞤶𞤭),
					},
					# Long Unit Identifier
					'frequency-gigahertz' => {
						'name' => q(𞤺𞤭𞤺𞤢𞤸𞤫𞤪𞤼𞤵),
						'one' => q({0} 𞤺𞤭𞤺𞤢𞤸𞤫𞤪𞤼𞤵),
						'other' => q({0} 𞤺𞤭𞤺𞤢𞤸𞤫𞤪𞤼𞤭),
					},
					# Core Unit Identifier
					'gigahertz' => {
						'name' => q(𞤺𞤭𞤺𞤢𞤸𞤫𞤪𞤼𞤵),
						'one' => q({0} 𞤺𞤭𞤺𞤢𞤸𞤫𞤪𞤼𞤵),
						'other' => q({0} 𞤺𞤭𞤺𞤢𞤸𞤫𞤪𞤼𞤭),
					},
					# Long Unit Identifier
					'frequency-hertz' => {
						'name' => q(𞤸𞤫𞤪𞤼𞤵),
						'one' => q({0} 𞤸𞤫𞤪𞤼𞤵),
						'other' => q({0} 𞤸𞤫𞤪𞤼𞤭),
					},
					# Core Unit Identifier
					'hertz' => {
						'name' => q(𞤸𞤫𞤪𞤼𞤵),
						'one' => q({0} 𞤸𞤫𞤪𞤼𞤵),
						'other' => q({0} 𞤸𞤫𞤪𞤼𞤭),
					},
					# Long Unit Identifier
					'frequency-kilohertz' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤸𞤫𞤪𞤼𞤵),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤸𞤫𞤪𞤼𞤵),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤸𞤫𞤪𞤼𞤭),
					},
					# Core Unit Identifier
					'kilohertz' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤸𞤫𞤪𞤼𞤵),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤸𞤫𞤪𞤼𞤵),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤸𞤫𞤪𞤼𞤭),
					},
					# Long Unit Identifier
					'frequency-megahertz' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤸𞤫𞤪𞤼𞤵),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤸𞤫𞤪𞤼𞤵),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤸𞤫𞤪𞤼𞤭),
					},
					# Core Unit Identifier
					'megahertz' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤸𞤫𞤪𞤼𞤵),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤸𞤫𞤪𞤼𞤵),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤸𞤫𞤪𞤼𞤭),
					},
					# Long Unit Identifier
					'graphics-dot' => {
						'name' => q(𞤼𞤮𞤩𞥆𞤫𞤪𞤫),
						'one' => q({0} 𞤼𞤮𞤩𞥆𞤫𞤪𞤫),
						'other' => q({0} 𞤼𞤮𞤩𞥆𞤫𞤪𞤫),
					},
					# Core Unit Identifier
					'dot' => {
						'name' => q(𞤼𞤮𞤩𞥆𞤫𞤪𞤫),
						'one' => q({0} 𞤼𞤮𞤩𞥆𞤫𞤪𞤫),
						'other' => q({0} 𞤼𞤮𞤩𞥆𞤫𞤪𞤫),
					},
					# Long Unit Identifier
					'graphics-dot-per-centimeter' => {
						'name' => q(𞤼𞤮𞤩𞥆𞤫 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'one' => q({0} 𞤼𞤮𞤩𞥆𞤫𞤪𞤫 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤼𞤮𞤩𞥆𞤫 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Core Unit Identifier
					'dot-per-centimeter' => {
						'name' => q(𞤼𞤮𞤩𞥆𞤫 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'one' => q({0} 𞤼𞤮𞤩𞥆𞤫𞤪𞤫 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤼𞤮𞤩𞥆𞤫 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Long Unit Identifier
					'graphics-dot-per-inch' => {
						'name' => q(𞤼𞤮𞤩𞥆𞤫 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
						'one' => q({0} 𞤼𞤮𞤩𞥆𞤫𞤪𞤫 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
						'other' => q({0} 𞤼𞤮𞤩𞥆𞤫 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
					},
					# Core Unit Identifier
					'dot-per-inch' => {
						'name' => q(𞤼𞤮𞤩𞥆𞤫 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
						'one' => q({0} 𞤼𞤮𞤩𞥆𞤫𞤪𞤫 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
						'other' => q({0} 𞤼𞤮𞤩𞥆𞤫 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
					},
					# Long Unit Identifier
					'graphics-em' => {
						'name' => q(𞤭𞤥𞤵 𞤬𞤭𞥅 𞤴𞤢𞥄𞤴𞤮),
						'one' => q({0} 𞤭𞤥𞤵),
						'other' => q({0} 𞤭𞤥𞤭),
					},
					# Core Unit Identifier
					'em' => {
						'name' => q(𞤭𞤥𞤵 𞤬𞤭𞥅 𞤴𞤢𞥄𞤴𞤮),
						'one' => q({0} 𞤭𞤥𞤵),
						'other' => q({0} 𞤭𞤥𞤭),
					},
					# Long Unit Identifier
					'graphics-megapixel' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤨𞤭𞤳𞤷𞤮𞤤),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤨𞤭𞤳𞤷𞤮𞤤),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤨𞤭𞤳𞤷𞤭),
					},
					# Core Unit Identifier
					'megapixel' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤨𞤭𞤳𞤷𞤮𞤤),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤨𞤭𞤳𞤷𞤮𞤤),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤨𞤭𞤳𞤷𞤭),
					},
					# Long Unit Identifier
					'graphics-pixel' => {
						'name' => q(𞤨𞤭𞤳𞤷𞤭),
						'one' => q({0} 𞤨𞤭𞤳𞤷𞤮𞤤),
						'other' => q({0} 𞤨𞤭𞤳𞤷𞤭),
					},
					# Core Unit Identifier
					'pixel' => {
						'name' => q(𞤨𞤭𞤳𞤷𞤭),
						'one' => q({0} 𞤨𞤭𞤳𞤷𞤮𞤤),
						'other' => q({0} 𞤨𞤭𞤳𞤷𞤭),
					},
					# Long Unit Identifier
					'graphics-pixel-per-centimeter' => {
						'name' => q(𞤨𞤭𞤳𞤷𞤭 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'one' => q({0} 𞤨𞤭𞤳𞤷𞤮𞤤 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤨𞤭𞤳𞤷𞤭 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Core Unit Identifier
					'pixel-per-centimeter' => {
						'name' => q(𞤨𞤭𞤳𞤷𞤭 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'one' => q({0} 𞤨𞤭𞤳𞤷𞤮𞤤 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤨𞤭𞤳𞤷𞤭 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Long Unit Identifier
					'graphics-pixel-per-inch' => {
						'name' => q(𞤨𞤭𞤳𞤷𞤭 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
						'one' => q({0} 𞤨𞤭𞤳𞤷𞤮𞤤 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
						'other' => q({0} 𞤨𞤭𞤳𞤷𞤭 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
					},
					# Core Unit Identifier
					'pixel-per-inch' => {
						'name' => q(𞤨𞤭𞤳𞤷𞤭 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
						'one' => q({0} 𞤨𞤭𞤳𞤷𞤮𞤤 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
						'other' => q({0} 𞤨𞤭𞤳𞤷𞤭 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
					},
					# Long Unit Identifier
					'length-astronomical-unit' => {
						'name' => q(𞤳𞤵𞥅𞤰𞤫 𞤦𞤵𞤪𞤶𞤵𞤲𞤳𞤮𞥅𞤶𞤫),
						'one' => q({0} 𞤳𞤵𞥅𞤰𞤵 𞤦𞤵𞤪𞤶𞤵𞤲𞤳𞤮𞤱𞤵),
						'other' => q({0} 𞤳𞤵𞥅𞤰𞤫 𞤦𞤵𞤪𞤶𞤵𞤲𞤳𞤮𞥅𞤶𞤫),
					},
					# Core Unit Identifier
					'astronomical-unit' => {
						'name' => q(𞤳𞤵𞥅𞤰𞤫 𞤦𞤵𞤪𞤶𞤵𞤲𞤳𞤮𞥅𞤶𞤫),
						'one' => q({0} 𞤳𞤵𞥅𞤰𞤵 𞤦𞤵𞤪𞤶𞤵𞤲𞤳𞤮𞤱𞤵),
						'other' => q({0} 𞤳𞤵𞥅𞤰𞤫 𞤦𞤵𞤪𞤶𞤵𞤲𞤳𞤮𞥅𞤶𞤫),
					},
					# Long Unit Identifier
					'length-centimeter' => {
						'name' => q(𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤧𞤫𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Core Unit Identifier
					'centimeter' => {
						'name' => q(𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤧𞤫𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Long Unit Identifier
					'length-decimeter' => {
						'name' => q(𞤣𞤫𞥅𞤧𞤭𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤣𞤫𞥅𞤧𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤣𞤫𞥅𞤧𞤭𞤥𞤫𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'decimeter' => {
						'name' => q(𞤣𞤫𞥅𞤧𞤭𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤣𞤫𞥅𞤧𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤣𞤫𞥅𞤧𞤭𞤥𞤫𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'length-earth-radius' => {
						'name' => q(𞤤𞤢𞥄𞤧𞤮𞤤 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'one' => q({0} 𞤤𞤢𞥄𞤧𞤮𞤤 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'other' => q({0} 𞤤𞤢𞥄𞤧𞤮𞤤 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
					},
					# Core Unit Identifier
					'earth-radius' => {
						'name' => q(𞤤𞤢𞥄𞤧𞤮𞤤 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'one' => q({0} 𞤤𞤢𞥄𞤧𞤮𞤤 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'other' => q({0} 𞤤𞤢𞥄𞤧𞤮𞤤 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
					},
					# Long Unit Identifier
					'length-foot' => {
						'name' => q(𞤼𞤫𞤨𞥆𞤭),
						'one' => q({0} 𞤼𞤫𞤨𞥆𞤵),
						'other' => q({0} 𞤼𞤫𞤨𞥆𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤼𞤫𞤨𞥆𞤵),
					},
					# Core Unit Identifier
					'foot' => {
						'name' => q(𞤼𞤫𞤨𞥆𞤭),
						'one' => q({0} 𞤼𞤫𞤨𞥆𞤵),
						'other' => q({0} 𞤼𞤫𞤨𞥆𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤼𞤫𞤨𞥆𞤵),
					},
					# Long Unit Identifier
					'length-inch' => {
						'name' => q(𞤲𞤺𞤮𞤪𞤰𞤭),
						'one' => q({0} 𞤲𞤺𞤮𞤪𞤰𞤵),
						'other' => q({0} 𞤲𞤺𞤮𞤪𞤰𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
					},
					# Core Unit Identifier
					'inch' => {
						'name' => q(𞤲𞤺𞤮𞤪𞤰𞤭),
						'one' => q({0} 𞤲𞤺𞤮𞤪𞤰𞤵),
						'other' => q({0} 𞤲𞤺𞤮𞤪𞤰𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤲𞤺𞤮𞤪𞤰𞤵),
					},
					# Long Unit Identifier
					'length-kilometer' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Core Unit Identifier
					'kilometer' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Long Unit Identifier
					'length-light-year' => {
						'name' => q(𞤳𞤭𞤼𞤢𞥄𞤤𞤫-𞤲𞤣𞤢𞤴𞤲𞤺𞤵),
						'one' => q({0} 𞤸𞤭𞤼𞤢𞥄𞤲𞤣𞤫-𞤲𞤣𞤢𞤴𞤲𞤺𞤵),
						'other' => q({0} 𞤳𞤭𞤼𞤢𞥄𞤤𞤫-𞤲𞤣𞤢𞤴𞤲𞤺𞤵),
					},
					# Core Unit Identifier
					'light-year' => {
						'name' => q(𞤳𞤭𞤼𞤢𞥄𞤤𞤫-𞤲𞤣𞤢𞤴𞤲𞤺𞤵),
						'one' => q({0} 𞤸𞤭𞤼𞤢𞥄𞤲𞤣𞤫-𞤲𞤣𞤢𞤴𞤲𞤺𞤵),
						'other' => q({0} 𞤳𞤭𞤼𞤢𞥄𞤤𞤫-𞤲𞤣𞤢𞤴𞤲𞤺𞤵),
					},
					# Long Unit Identifier
					'length-meter' => {
						'name' => q(𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Core Unit Identifier
					'meter' => {
						'name' => q(𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Long Unit Identifier
					'length-micrometer' => {
						'name' => q(𞤻𞤭𞤤𞤢𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤻𞤭𞤤𞤢𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤻𞤭𞤤𞤢𞤥𞤫𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'micrometer' => {
						'name' => q(𞤻𞤭𞤤𞤢𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤻𞤭𞤤𞤢𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤻𞤭𞤤𞤢𞤥𞤫𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'length-mile' => {
						'name' => q(𞤥𞤢𞤴𞤤𞤭),
						'one' => q({0} 𞤥𞤢𞤴𞤤𞤵),
						'other' => q({0} 𞤥𞤢𞤴𞤤𞤭),
					},
					# Core Unit Identifier
					'mile' => {
						'name' => q(𞤥𞤢𞤴𞤤𞤭),
						'one' => q({0} 𞤥𞤢𞤴𞤤𞤵),
						'other' => q({0} 𞤥𞤢𞤴𞤤𞤭),
					},
					# Long Unit Identifier
					'length-mile-scandinavian' => {
						'name' => q(𞤃𞤢𞤴𞤤𞤵 𞤧𞤭𞤳𞤢𞥄𞤣𞤭𞤲𞤢𞥄𞤾𞤭𞤲𞤳𞤮),
						'one' => q({0} 𞤃𞤢𞤴𞤤𞤵 𞤧𞤭𞤳𞤢𞥄𞤣𞤭𞤲𞤢𞥄𞤾𞤭𞤲𞤳𞤮),
						'other' => q({0} 𞤃𞤢𞤴𞤤𞤭 𞤧𞤭𞤳𞤢𞥄𞤣𞤭𞤲𞤢𞥄𞤾𞤭𞤲𞤳𞤮),
					},
					# Core Unit Identifier
					'mile-scandinavian' => {
						'name' => q(𞤃𞤢𞤴𞤤𞤵 𞤧𞤭𞤳𞤢𞥄𞤣𞤭𞤲𞤢𞥄𞤾𞤭𞤲𞤳𞤮),
						'one' => q({0} 𞤃𞤢𞤴𞤤𞤵 𞤧𞤭𞤳𞤢𞥄𞤣𞤭𞤲𞤢𞥄𞤾𞤭𞤲𞤳𞤮),
						'other' => q({0} 𞤃𞤢𞤴𞤤𞤭 𞤧𞤭𞤳𞤢𞥄𞤣𞤭𞤲𞤢𞥄𞤾𞤭𞤲𞤳𞤮),
					},
					# Long Unit Identifier
					'length-millimeter' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤥𞤫𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'millimeter' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤥𞤫𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'length-nanometer' => {
						'name' => q(𞤲𞤢𞤲𞤮𞥊𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤲𞤢𞤲𞤮𞥊𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤲𞤢𞤲𞤮𞥊𞤥𞤫𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'nanometer' => {
						'name' => q(𞤲𞤢𞤲𞤮𞥊𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤲𞤢𞤲𞤮𞥊𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤲𞤢𞤲𞤮𞥊𞤥𞤫𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'length-nautical-mile' => {
						'name' => q(𞤥𞤢𞤴𞤤𞤭 𞤥𞤢𞥄𞤶𞤫𞤴𞤢𞤲𞤳𞤮𞥅𞤶𞤭),
						'one' => q({0} 𞤥𞤢𞤴𞤤𞤵 𞤥𞤢𞥄𞤶𞤫𞤴𞤢𞤲𞤳𞤮𞤱𞤵),
						'other' => q({0} 𞤥𞤢𞤴𞤤𞤭 𞤥𞤢𞥄𞤶𞤫𞤴𞤢𞤲𞤳𞤮𞥅𞤶𞤭),
					},
					# Core Unit Identifier
					'nautical-mile' => {
						'name' => q(𞤥𞤢𞤴𞤤𞤭 𞤥𞤢𞥄𞤶𞤫𞤴𞤢𞤲𞤳𞤮𞥅𞤶𞤭),
						'one' => q({0} 𞤥𞤢𞤴𞤤𞤵 𞤥𞤢𞥄𞤶𞤫𞤴𞤢𞤲𞤳𞤮𞤱𞤵),
						'other' => q({0} 𞤥𞤢𞤴𞤤𞤭 𞤥𞤢𞥄𞤶𞤫𞤴𞤢𞤲𞤳𞤮𞥅𞤶𞤭),
					},
					# Long Unit Identifier
					'length-parsec' => {
						'name' => q(𞤨𞤢𞤪𞤧𞤫𞤳𞤭),
						'one' => q({0} 𞤨𞤢𞤪𞤧𞤫𞤳𞤵),
						'other' => q({0} 𞤨𞤢𞤪𞤧𞤫𞤳𞤭),
					},
					# Core Unit Identifier
					'parsec' => {
						'name' => q(𞤨𞤢𞤪𞤧𞤫𞤳𞤭),
						'one' => q({0} 𞤨𞤢𞤪𞤧𞤫𞤳𞤵),
						'other' => q({0} 𞤨𞤢𞤪𞤧𞤫𞤳𞤭),
					},
					# Long Unit Identifier
					'length-picometer' => {
						'name' => q(𞤨𞤭𞤳𞤮𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤨𞤭𞤳𞤮𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤨𞤭𞤳𞤮𞤥𞤫𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'picometer' => {
						'name' => q(𞤨𞤭𞤳𞤮𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤨𞤭𞤳𞤮𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤨𞤭𞤳𞤮𞤥𞤫𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'length-point' => {
						'name' => q(𞤲𞤶𞤮𞤣𞥆𞤵𞥅𞤶𞤭),
						'one' => q({0} 𞤲𞤶𞤮𞤣𞥆𞤵),
						'other' => q({0} 𞤲𞤶𞤮𞤣𞥆𞤵𞥅𞤶𞤭),
					},
					# Core Unit Identifier
					'point' => {
						'name' => q(𞤲𞤶𞤮𞤣𞥆𞤵𞥅𞤶𞤭),
						'one' => q({0} 𞤲𞤶𞤮𞤣𞥆𞤵),
						'other' => q({0} 𞤲𞤶𞤮𞤣𞥆𞤵𞥅𞤶𞤭),
					},
					# Long Unit Identifier
					'length-solar-radius' => {
						'name' => q(𞤤𞤢𞥄𞤧𞤮𞤤 𞤲𞤢𞥄𞤲𞤺𞤫𞤴𞤢𞤲𞤳𞤮),
						'one' => q({0} 𞤤𞤢𞥄𞤧𞤭 𞤲𞤢𞥄𞤲𞤺𞤫𞤴𞤢𞤲𞤳𞤮),
						'other' => q({0} 𞤤𞤢𞥄𞤧𞤮𞤤 𞤲𞤢𞥄𞤲𞤺𞤫𞤴𞤢𞤲𞤳𞤮),
					},
					# Core Unit Identifier
					'solar-radius' => {
						'name' => q(𞤤𞤢𞥄𞤧𞤮𞤤 𞤲𞤢𞥄𞤲𞤺𞤫𞤴𞤢𞤲𞤳𞤮),
						'one' => q({0} 𞤤𞤢𞥄𞤧𞤭 𞤲𞤢𞥄𞤲𞤺𞤫𞤴𞤢𞤲𞤳𞤮),
						'other' => q({0} 𞤤𞤢𞥄𞤧𞤮𞤤 𞤲𞤢𞥄𞤲𞤺𞤫𞤴𞤢𞤲𞤳𞤮),
					},
					# Long Unit Identifier
					'length-yard' => {
						'name' => q(𞤧𞤮𞤺𞤮𞤲𞤫),
						'one' => q({0} 𞤧𞤮𞤺𞤮𞤲𞤢𞤤),
						'other' => q({0} 𞤧𞤮𞤺𞤮𞤲𞤫),
					},
					# Core Unit Identifier
					'yard' => {
						'name' => q(𞤧𞤮𞤺𞤮𞤲𞤫),
						'one' => q({0} 𞤧𞤮𞤺𞤮𞤲𞤢𞤤),
						'other' => q({0} 𞤧𞤮𞤺𞤮𞤲𞤫),
					},
					# Long Unit Identifier
					'mass-carat' => {
						'name' => q(𞤳𞤭𞤪𞤢𞤪𞤼𞤵),
						'one' => q({0} 𞤳𞤢𞤪𞤢𞤪𞤼𞤵),
						'other' => q({0} 𞤳𞤢𞤪𞤢𞤪𞤼𞤭),
					},
					# Core Unit Identifier
					'carat' => {
						'name' => q(𞤳𞤭𞤪𞤢𞤪𞤼𞤵),
						'one' => q({0} 𞤳𞤢𞤪𞤢𞤪𞤼𞤵),
						'other' => q({0} 𞤳𞤢𞤪𞤢𞤪𞤼𞤭),
					},
					# Long Unit Identifier
					'mass-dalton' => {
						'name' => q(𞤣𞤢𞤤𞤼𞤮𞥅𞤲𞤭),
						'one' => q({0} 𞤣𞤢𞤤𞤼𞤮𞥅𞤲𞤵),
						'other' => q({0} 𞤣𞤢𞤤𞤼𞤮𞥅𞤲𞤭),
					},
					# Core Unit Identifier
					'dalton' => {
						'name' => q(𞤣𞤢𞤤𞤼𞤮𞥅𞤲𞤭),
						'one' => q({0} 𞤣𞤢𞤤𞤼𞤮𞥅𞤲𞤵),
						'other' => q({0} 𞤣𞤢𞤤𞤼𞤮𞥅𞤲𞤭),
					},
					# Long Unit Identifier
					'mass-earth-mass' => {
						'name' => q(𞤲𞤭𞥅𞤧𞤵𞥅𞤶𞤭 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'one' => q({0} 𞤲𞤭𞥅𞤧𞤵 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'other' => q({0} 𞤲𞤭𞥅𞤧𞤵𞥅𞤶𞤭 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
					},
					# Core Unit Identifier
					'earth-mass' => {
						'name' => q(𞤲𞤭𞥅𞤧𞤵𞥅𞤶𞤭 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'one' => q({0} 𞤲𞤭𞥅𞤧𞤵 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'other' => q({0} 𞤲𞤭𞥅𞤧𞤵𞥅𞤶𞤭 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
					},
					# Long Unit Identifier
					'mass-grain' => {
						'name' => q(𞤺𞤢𞤰𞥆𞤫𞤪𞤫),
						'one' => q({0} 𞤺𞤢𞤰𞥆𞤫),
						'other' => q({0} 𞤺𞤢𞤰𞥆𞤫),
					},
					# Core Unit Identifier
					'grain' => {
						'name' => q(𞤺𞤢𞤰𞥆𞤫𞤪𞤫),
						'one' => q({0} 𞤺𞤢𞤰𞥆𞤫),
						'other' => q({0} 𞤺𞤢𞤰𞥆𞤫),
					},
					# Long Unit Identifier
					'mass-gram' => {
						'name' => q(𞤺𞤢𞤪𞤬𞤭),
						'one' => q({0} 𞤺𞤢𞤪𞤬𞤵),
						'other' => q({0} 𞤺𞤢𞤪𞤬𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤺𞤢𞤪𞤬𞤵),
					},
					# Core Unit Identifier
					'gram' => {
						'name' => q(𞤺𞤢𞤪𞤬𞤭),
						'one' => q({0} 𞤺𞤢𞤪𞤬𞤵),
						'other' => q({0} 𞤺𞤢𞤪𞤬𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤺𞤢𞤪𞤬𞤵),
					},
					# Long Unit Identifier
					'mass-kilogram' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤺𞤢𞤪𞤬𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤺𞤢𞤪𞤬𞤵),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤺𞤢𞤪𞤬𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤳𞤭𞤤𞤮𞤺𞤢𞤪𞤬𞤵),
					},
					# Core Unit Identifier
					'kilogram' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤺𞤢𞤪𞤬𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤺𞤢𞤪𞤬𞤵),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤺𞤢𞤪𞤬𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤳𞤭𞤤𞤮𞤺𞤢𞤪𞤬𞤵),
					},
					# Long Unit Identifier
					'mass-metric-ton' => {
						'name' => q(𞤼𞤮𞥅𞤲𞤭 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
						'one' => q({0} 𞤼𞤮𞥅𞤲𞤵 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
						'other' => q({0} 𞤼𞤮𞥅𞤲𞤭 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
					},
					# Core Unit Identifier
					'metric-ton' => {
						'name' => q(𞤼𞤮𞥅𞤲𞤭 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
						'one' => q({0} 𞤼𞤮𞥅𞤲𞤵 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
						'other' => q({0} 𞤼𞤮𞥅𞤲𞤭 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
					},
					# Long Unit Identifier
					'mass-microgram' => {
						'name' => q(𞤻𞤭𞤤𞤢𞤺𞤢𞤪𞤬𞤭),
						'one' => q({0} 𞤻𞤭𞤤𞤢𞤺𞤢𞤪𞤬𞤵),
						'other' => q({0} 𞤻𞤭𞤤𞤢𞤺𞤢𞤪𞤬𞤭),
					},
					# Core Unit Identifier
					'microgram' => {
						'name' => q(𞤻𞤭𞤤𞤢𞤺𞤢𞤪𞤬𞤭),
						'one' => q({0} 𞤻𞤭𞤤𞤢𞤺𞤢𞤪𞤬𞤵),
						'other' => q({0} 𞤻𞤭𞤤𞤢𞤺𞤢𞤪𞤬𞤭),
					},
					# Long Unit Identifier
					'mass-milligram' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤺𞤢𞤪𞤬𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤺𞤢𞤪𞤬𞤵),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤺𞤢𞤪𞤬𞤭),
					},
					# Core Unit Identifier
					'milligram' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤺𞤢𞤪𞤬𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤺𞤢𞤪𞤬𞤵),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤺𞤢𞤪𞤬𞤭),
					},
					# Long Unit Identifier
					'mass-ounce' => {
						'name' => q(𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭),
						'one' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞤱𞤵),
						'other' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤱𞤢𞤺𞤭𞤴𞤢𞤱𞤵),
					},
					# Core Unit Identifier
					'ounce' => {
						'name' => q(𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭),
						'one' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞤱𞤵),
						'other' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤱𞤢𞤺𞤭𞤴𞤢𞤱𞤵),
					},
					# Long Unit Identifier
					'mass-ounce-troy' => {
						'name' => q(𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤥𞤫𞤲𞤳𞤫𞤤𞤣𞤭),
						'one' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞤱𞤵 𞤥𞤫𞤲𞤳𞤫𞤤𞤣𞤫),
						'other' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤥𞤫𞤲𞤳𞤫𞤤𞤣𞤫),
					},
					# Core Unit Identifier
					'ounce-troy' => {
						'name' => q(𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤥𞤫𞤲𞤳𞤫𞤤𞤣𞤭),
						'one' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞤱𞤵 𞤥𞤫𞤲𞤳𞤫𞤤𞤣𞤫),
						'other' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤥𞤫𞤲𞤳𞤫𞤤𞤣𞤫),
					},
					# Long Unit Identifier
					'mass-pound' => {
						'name' => q(𞤺𞤢𞤪𞤤𞤭),
						'one' => q({0} 𞤺𞤢𞤪𞤤𞤵),
						'other' => q({0} 𞤺𞤢𞤪𞤤𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤺𞤢𞤪𞤤𞤵),
					},
					# Core Unit Identifier
					'pound' => {
						'name' => q(𞤺𞤢𞤪𞤤𞤭),
						'one' => q({0} 𞤺𞤢𞤪𞤤𞤵),
						'other' => q({0} 𞤺𞤢𞤪𞤤𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤺𞤢𞤪𞤤𞤵),
					},
					# Long Unit Identifier
					'mass-solar-mass' => {
						'name' => q(𞤲𞤭𞥅𞤧𞤵𞥅𞤶𞤭 𞤲𞤢𞥄𞤲𞤺𞤫 𞤲𞤺𞤫𞤲),
						'one' => q({0} 𞤲𞤭𞥅𞤧𞤵 𞤲𞤢𞥄𞤲𞤺𞤫 𞤲𞤺𞤫𞤲),
						'other' => q({0} 𞤲𞤭𞥅𞤧𞤵𞥅𞤶𞤭 𞤲𞤢𞥄𞤲𞤺𞤫 𞤲𞤺𞤫𞤲),
					},
					# Core Unit Identifier
					'solar-mass' => {
						'name' => q(𞤲𞤭𞥅𞤧𞤵𞥅𞤶𞤭 𞤲𞤢𞥄𞤲𞤺𞤫 𞤲𞤺𞤫𞤲),
						'one' => q({0} 𞤲𞤭𞥅𞤧𞤵 𞤲𞤢𞥄𞤲𞤺𞤫 𞤲𞤺𞤫𞤲),
						'other' => q({0} 𞤲𞤭𞥅𞤧𞤵𞥅𞤶𞤭 𞤲𞤢𞥄𞤲𞤺𞤫 𞤲𞤺𞤫𞤲),
					},
					# Long Unit Identifier
					'mass-ton' => {
						'name' => q(𞤼𞤮𞥅𞤲𞤭),
						'one' => q({0} 𞤼𞤮𞥅𞤲𞤵),
						'other' => q({0} 𞤼𞤮𞥅𞤲𞤭),
					},
					# Core Unit Identifier
					'ton' => {
						'name' => q(𞤼𞤮𞥅𞤲𞤭),
						'one' => q({0} 𞤼𞤮𞥅𞤲𞤵),
						'other' => q({0} 𞤼𞤮𞥅𞤲𞤭),
					},
					# Long Unit Identifier
					'per' => {
						'1' => q({0} 𞤲𞤣𞤫𞤪 {1}),
					},
					# Core Unit Identifier
					'per' => {
						'1' => q({0} 𞤲𞤣𞤫𞤪 {1}),
					},
					# Long Unit Identifier
					'power-gigawatt' => {
						'name' => q(𞤺𞤭𞤺𞤢𞤱𞤢𞥄𞤼𞤭),
						'one' => q({0} 𞤺𞤭𞤺𞤢𞤱𞤢𞥄𞤼𞤵),
						'other' => q({0} 𞤺𞤭𞤺𞤢𞤱𞤢𞥄𞤼𞤭),
					},
					# Core Unit Identifier
					'gigawatt' => {
						'name' => q(𞤺𞤭𞤺𞤢𞤱𞤢𞥄𞤼𞤭),
						'one' => q({0} 𞤺𞤭𞤺𞤢𞤱𞤢𞥄𞤼𞤵),
						'other' => q({0} 𞤺𞤭𞤺𞤢𞤱𞤢𞥄𞤼𞤭),
					},
					# Long Unit Identifier
					'power-horsepower' => {
						'name' => q(𞤷𞤫𞤥𞤦𞤫-𞤨𞤵𞤷𞥆𞤭),
						'one' => q({0} 𞤷𞤫𞤥𞤦𞤫-𞤨𞤵𞤨𞥆𞤵),
						'other' => q({0} 𞤷𞤫𞤥𞤦𞤫-𞤨𞤵𞤷𞥆𞤭),
					},
					# Core Unit Identifier
					'horsepower' => {
						'name' => q(𞤷𞤫𞤥𞤦𞤫-𞤨𞤵𞤷𞥆𞤭),
						'one' => q({0} 𞤷𞤫𞤥𞤦𞤫-𞤨𞤵𞤨𞥆𞤵),
						'other' => q({0} 𞤷𞤫𞤥𞤦𞤫-𞤨𞤵𞤷𞥆𞤭),
					},
					# Long Unit Identifier
					'power-kilowatt' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤱𞤢𞥄𞤼𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤱𞤢𞥄𞤼𞤵),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤱𞤢𞥄𞤼𞤭),
					},
					# Core Unit Identifier
					'kilowatt' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤱𞤢𞥄𞤼𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤱𞤢𞥄𞤼𞤵),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤱𞤢𞥄𞤼𞤭),
					},
					# Long Unit Identifier
					'power-megawatt' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤱𞤢𞥄𞤼𞤭),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤱𞤢𞥄𞤼𞤵),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤱𞤢𞥄𞤼𞤭),
					},
					# Core Unit Identifier
					'megawatt' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤱𞤢𞥄𞤼𞤭),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤱𞤢𞥄𞤼𞤵),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤱𞤢𞥄𞤼𞤭),
					},
					# Long Unit Identifier
					'power-milliwatt' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤱𞤢𞥄𞤼𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤱𞤢𞥄𞤼𞤵),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤱𞤢𞥄𞤼𞤭),
					},
					# Core Unit Identifier
					'milliwatt' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤱𞤢𞥄𞤼𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤱𞤢𞥄𞤼𞤵),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤱𞤢𞥄𞤼𞤭),
					},
					# Long Unit Identifier
					'power-watt' => {
						'name' => q(𞤱𞤢𞥄𞤼𞤭),
						'one' => q({0} 𞤱𞤢𞥄𞤼𞤭),
						'other' => q({0} 𞤱𞤢𞥄𞤼𞤭),
					},
					# Core Unit Identifier
					'watt' => {
						'name' => q(𞤱𞤢𞥄𞤼𞤭),
						'one' => q({0} 𞤱𞤢𞥄𞤼𞤭),
						'other' => q({0} 𞤱𞤢𞥄𞤼𞤭),
					},
					# Long Unit Identifier
					'power2' => {
						'one' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 {0}),
						'other' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 {0}),
					},
					# Core Unit Identifier
					'power2' => {
						'one' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 {0}),
						'other' => q(𞤣𞤭𞤲𞤺𞤫𞤪𞤫 {0}),
					},
					# Long Unit Identifier
					'power3' => {
						'one' => q(𞤤𞤢𞤥𞤦𞤵 {0}),
						'other' => q(𞤤𞤢𞤥𞤦𞤵 {0}),
					},
					# Core Unit Identifier
					'power3' => {
						'one' => q(𞤤𞤢𞤥𞤦𞤵 {0}),
						'other' => q(𞤤𞤢𞤥𞤦𞤵 {0}),
					},
					# Long Unit Identifier
					'pressure-atmosphere' => {
						'name' => q(𞤦𞤫𞤧𞤤𞤮𞥅𞤶𞤭),
						'one' => q({0} 𞤦𞤫𞤧𞤤𞤮𞥅𞤪𞤭),
						'other' => q({0} 𞤦𞤫𞤧𞤤𞤮𞥅𞤶𞤭),
					},
					# Core Unit Identifier
					'atmosphere' => {
						'name' => q(𞤦𞤫𞤧𞤤𞤮𞥅𞤶𞤭),
						'one' => q({0} 𞤦𞤫𞤧𞤤𞤮𞥅𞤪𞤭),
						'other' => q({0} 𞤦𞤫𞤧𞤤𞤮𞥅𞤶𞤭),
					},
					# Long Unit Identifier
					'pressure-bar' => {
						'name' => q(𞤦𞤢𞤪𞤤𞤭),
						'one' => q({0} 𞤦𞤢𞤪𞤤𞤵),
						'other' => q({0} 𞤦𞤢𞤪𞤤𞤭),
					},
					# Core Unit Identifier
					'bar' => {
						'name' => q(𞤦𞤢𞤪𞤤𞤭),
						'one' => q({0} 𞤦𞤢𞤪𞤤𞤵),
						'other' => q({0} 𞤦𞤢𞤪𞤤𞤭),
					},
					# Long Unit Identifier
					'pressure-hectopascal' => {
						'name' => q(𞤸𞤫𞤳𞤼𞤮𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
						'one' => q({0} 𞤸𞤫𞤳𞤼𞤮𞤨𞤢𞤧𞤳𞤢𞤤),
						'other' => q({0} 𞤸𞤫𞤳𞤼𞤮𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
					},
					# Core Unit Identifier
					'hectopascal' => {
						'name' => q(𞤸𞤫𞤳𞤼𞤮𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
						'one' => q({0} 𞤸𞤫𞤳𞤼𞤮𞤨𞤢𞤧𞤳𞤢𞤤),
						'other' => q({0} 𞤸𞤫𞤳𞤼𞤮𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
					},
					# Long Unit Identifier
					'pressure-inch-ofhg' => {
						'name' => q(𞤲𞤺𞤮𞤪𞤰𞤭 𞤯𞤫𞤤𞤳𞤮𞥅𞤪𞤭),
						'one' => q({0} 𞤲𞤺𞤮𞤪𞤰𞤵 𞤯𞤫𞤤𞤳𞤮𞥅𞤪𞤭),
						'other' => q({0} 𞤲𞤺𞤮𞤪𞤰𞤭 𞤯𞤫𞤤𞤳𞤮𞥅𞤪𞤭),
					},
					# Core Unit Identifier
					'inch-ofhg' => {
						'name' => q(𞤲𞤺𞤮𞤪𞤰𞤭 𞤯𞤫𞤤𞤳𞤮𞥅𞤪𞤭),
						'one' => q({0} 𞤲𞤺𞤮𞤪𞤰𞤵 𞤯𞤫𞤤𞤳𞤮𞥅𞤪𞤭),
						'other' => q({0} 𞤲𞤺𞤮𞤪𞤰𞤭 𞤯𞤫𞤤𞤳𞤮𞥅𞤪𞤭),
					},
					# Long Unit Identifier
					'pressure-kilopascal' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤨𞤢𞤧𞤳𞤢𞤤),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
					},
					# Core Unit Identifier
					'kilopascal' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤨𞤢𞤧𞤳𞤢𞤤),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
					},
					# Long Unit Identifier
					'pressure-megapascal' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤨𞤢𞤧𞤳𞤢𞤤),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
					},
					# Core Unit Identifier
					'megapascal' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤨𞤢𞤧𞤳𞤢𞤤),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
					},
					# Long Unit Identifier
					'pressure-millibar' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤦𞤢𞤪𞤤𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤦𞤢𞤪𞤤𞤵),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤦𞤢𞤪𞤤𞤭),
					},
					# Core Unit Identifier
					'millibar' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤦𞤢𞤪𞤤𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤦𞤢𞤪𞤤𞤵),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤦𞤢𞤪𞤤𞤭),
					},
					# Long Unit Identifier
					'pressure-millimeter-ofhg' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤥𞤫𞥅𞤼𞤭 𞤯𞤫𞤤𞤳𞤮𞥅𞤪𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤥𞤫𞥅𞤼𞤮𞤤 𞤯𞤫𞤤𞤳𞤮𞥅𞤪𞤭),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤥𞤫𞥅𞤼𞤭 𞤯𞤫𞤤𞤳𞤮𞥅𞤪𞤭),
					},
					# Core Unit Identifier
					'millimeter-ofhg' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤥𞤫𞥅𞤼𞤭 𞤯𞤫𞤤𞤳𞤮𞥅𞤪𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤥𞤫𞥅𞤼𞤮𞤤 𞤯𞤫𞤤𞤳𞤮𞥅𞤪𞤭),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤥𞤫𞥅𞤼𞤭 𞤯𞤫𞤤𞤳𞤮𞥅𞤪𞤭),
					},
					# Long Unit Identifier
					'pressure-pascal' => {
						'name' => q(𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
						'one' => q({0} 𞤨𞤢𞤧𞤷𞤢𞤤),
						'other' => q({0} 𞤨𞤢𞤧𞤷𞤢𞤤𞤶𞤭),
					},
					# Core Unit Identifier
					'pascal' => {
						'name' => q(𞤨𞤢𞤧𞤳𞤢𞤤𞤶𞤭),
						'one' => q({0} 𞤨𞤢𞤧𞤷𞤢𞤤),
						'other' => q({0} 𞤨𞤢𞤧𞤷𞤢𞤤𞤶𞤭),
					},
					# Long Unit Identifier
					'pressure-pound-force-per-square-inch' => {
						'name' => q(𞤺𞤢𞤪𞤤𞤭 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤵),
						'one' => q({0} 𞤺𞤢𞤪𞤤𞤵 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤵),
						'other' => q({0} 𞤺𞤢𞤪𞤤𞤭 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤵),
					},
					# Core Unit Identifier
					'pound-force-per-square-inch' => {
						'name' => q(𞤺𞤢𞤪𞤤𞤭 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤵),
						'one' => q({0} 𞤺𞤢𞤪𞤤𞤵 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤵),
						'other' => q({0} 𞤺𞤢𞤪𞤤𞤭 𞤲𞤣𞤫𞤪 𞤣𞤭𞤲𞤺𞤫𞤪𞤫 𞤲𞤺𞤮𞤪𞤰𞤵),
					},
					# Long Unit Identifier
					'speed-kilometer-per-hour' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤣𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤮𞤤 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤣𞤭),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤣𞤭),
					},
					# Core Unit Identifier
					'kilometer-per-hour' => {
						'name' => q(𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤣𞤭),
						'one' => q({0} 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤮𞤤 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤣𞤭),
						'other' => q({0} 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤣𞤭),
					},
					# Long Unit Identifier
					'speed-knot' => {
						'name' => q(𞤨𞤭𞤩𞤫),
						'one' => q({0} 𞤨𞤭𞤩𞤮),
						'other' => q({0} 𞤨𞤭𞤩𞤫),
					},
					# Core Unit Identifier
					'knot' => {
						'name' => q(𞤨𞤭𞤩𞤫),
						'one' => q({0} 𞤨𞤭𞤩𞤮),
						'other' => q({0} 𞤨𞤭𞤩𞤫),
					},
					# Long Unit Identifier
					'speed-meter-per-second' => {
						'name' => q(𞤥𞤫𞥅𞤼𞤭 𞤲𞤣𞤫𞤪 𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'one' => q({0} 𞤥𞤫𞥅𞤼𞤮𞤤 𞤲𞤣𞤫𞤪 𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'other' => q({0} 𞤥𞤫𞥅𞤼𞤭 𞤲𞤣𞤫𞤪 𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
					},
					# Core Unit Identifier
					'meter-per-second' => {
						'name' => q(𞤥𞤫𞥅𞤼𞤭 𞤲𞤣𞤫𞤪 𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'one' => q({0} 𞤥𞤫𞥅𞤼𞤮𞤤 𞤲𞤣𞤫𞤪 𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
						'other' => q({0} 𞤥𞤫𞥅𞤼𞤭 𞤲𞤣𞤫𞤪 𞤳𞤭𞤲𞤰𞤫𞤪𞤫),
					},
					# Long Unit Identifier
					'speed-mile-per-hour' => {
						'name' => q(𞤥𞤢𞤴𞤤𞤭 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'one' => q({0} 𞤥𞤢𞤴𞤤𞤵 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'other' => q({0} 𞤥𞤢𞤴𞤤𞤭 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
					},
					# Core Unit Identifier
					'mile-per-hour' => {
						'name' => q(𞤥𞤢𞤴𞤤𞤭 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'one' => q({0} 𞤥𞤢𞤴𞤤𞤵 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'other' => q({0} 𞤥𞤢𞤴𞤤𞤭 𞤲𞤣𞤫𞤪 𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
					},
					# Long Unit Identifier
					'temperature-celsius' => {
						'name' => q(𞤶𞤫𞤩𞤫 𞤅𞤫𞤤𞤧𞤵),
						'one' => q({0} 𞤶𞤫𞤩𞤫𞤪𞤫 𞤅𞤫𞤤𞤧𞤵),
						'other' => q({0} 𞤶𞤫𞤩𞤫 𞤅𞤫𞤤𞤧𞤵),
					},
					# Core Unit Identifier
					'celsius' => {
						'name' => q(𞤶𞤫𞤩𞤫 𞤅𞤫𞤤𞤧𞤵),
						'one' => q({0} 𞤶𞤫𞤩𞤫𞤪𞤫 𞤅𞤫𞤤𞤧𞤵),
						'other' => q({0} 𞤶𞤫𞤩𞤫 𞤅𞤫𞤤𞤧𞤵),
					},
					# Long Unit Identifier
					'temperature-fahrenheit' => {
						'name' => q(𞤶𞤫𞤩𞤫 𞤊𞤢𞤸𞤪𞤢𞤲𞤫𞤴𞤼𞤵),
						'one' => q({0} 𞤶𞤫𞤩𞤫𞤪𞤫 𞤊𞤢𞤸𞤪𞤢𞤲𞤫𞤴𞤼𞤵),
						'other' => q({0} 𞤶𞤫𞤩𞤫 𞤊𞤢𞤸𞤪𞤢𞤲𞤫𞤴𞤼𞤵),
					},
					# Core Unit Identifier
					'fahrenheit' => {
						'name' => q(𞤶𞤫𞤩𞤫 𞤊𞤢𞤸𞤪𞤢𞤲𞤫𞤴𞤼𞤵),
						'one' => q({0} 𞤶𞤫𞤩𞤫𞤪𞤫 𞤊𞤢𞤸𞤪𞤢𞤲𞤫𞤴𞤼𞤵),
						'other' => q({0} 𞤶𞤫𞤩𞤫 𞤊𞤢𞤸𞤪𞤢𞤲𞤫𞤴𞤼𞤵),
					},
					# Long Unit Identifier
					'temperature-generic' => {
						'one' => q({0} 𞤶𞤫𞤩𞤫𞤪𞤫),
						'other' => q({0} 𞤶𞤫𞤩𞤫),
					},
					# Core Unit Identifier
					'generic' => {
						'one' => q({0} 𞤶𞤫𞤩𞤫𞤪𞤫),
						'other' => q({0} 𞤶𞤫𞤩𞤫),
					},
					# Long Unit Identifier
					'temperature-kelvin' => {
						'name' => q(𞤶𞤫𞤩𞤫 𞤳𞤫𞤤𞤾𞤭𞥅𞤲),
						'one' => q({0} 𞤶𞤫𞤩𞤫𞤪𞤫 𞤳𞤫𞤤𞤾𞤭𞥅𞤲),
						'other' => q({0} 𞤶𞤫𞤩𞤫 𞤳𞤫𞤤𞤾𞤭𞥅𞤲),
					},
					# Core Unit Identifier
					'kelvin' => {
						'name' => q(𞤶𞤫𞤩𞤫 𞤳𞤫𞤤𞤾𞤭𞥅𞤲),
						'one' => q({0} 𞤶𞤫𞤩𞤫𞤪𞤫 𞤳𞤫𞤤𞤾𞤭𞥅𞤲),
						'other' => q({0} 𞤶𞤫𞤩𞤫 𞤳𞤫𞤤𞤾𞤭𞥅𞤲),
					},
					# Long Unit Identifier
					'times' => {
						'1' => q({0}-{1}),
					},
					# Core Unit Identifier
					'times' => {
						'1' => q({0}-{1}),
					},
					# Long Unit Identifier
					'torque-newton-meter' => {
						'name' => q(𞤲𞤫𞤱𞤼𞤮𞤲-𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤲𞤫𞤱𞤼𞤮𞤲-𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤲𞤫𞤱𞤼𞤮𞤲-𞤥𞤫𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'newton-meter' => {
						'name' => q(𞤲𞤫𞤱𞤼𞤮𞤲-𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤲𞤫𞤱𞤼𞤮𞤲-𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤲𞤫𞤱𞤼𞤮𞤲-𞤥𞤫𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'volume-acre-foot' => {
						'name' => q(𞤺𞤢𞤪𞤳𞤵 𞤼𞤫𞤨𞥆𞤭),
						'one' => q({0} 𞤺𞤢𞤪𞤳𞤵 𞤼𞤫𞤨𞥆𞤵),
						'other' => q({0} 𞤺𞤢𞤪𞤳𞤵 𞤼𞤫𞤨𞥆𞤭),
					},
					# Core Unit Identifier
					'acre-foot' => {
						'name' => q(𞤺𞤢𞤪𞤳𞤵 𞤼𞤫𞤨𞥆𞤭),
						'one' => q({0} 𞤺𞤢𞤪𞤳𞤵 𞤼𞤫𞤨𞥆𞤵),
						'other' => q({0} 𞤺𞤢𞤪𞤳𞤵 𞤼𞤫𞤨𞥆𞤭),
					},
					# Long Unit Identifier
					'volume-barrel' => {
						'name' => q(𞤺𞤮𞤲𞤺𞤮𞥅𞤶𞤭),
						'one' => q({0} 𞤺𞤮𞤲𞤺𞤮𞥅𞤪𞤵),
						'other' => q({0} 𞤺𞤮𞤲𞤺𞤮𞥅𞤶𞤭),
					},
					# Core Unit Identifier
					'barrel' => {
						'name' => q(𞤺𞤮𞤲𞤺𞤮𞥅𞤶𞤭),
						'one' => q({0} 𞤺𞤮𞤲𞤺𞤮𞥅𞤪𞤵),
						'other' => q({0} 𞤺𞤮𞤲𞤺𞤮𞥅𞤶𞤭),
					},
					# Long Unit Identifier
					'volume-centiliter' => {
						'name' => q(𞤧𞤢𞤲𞤼𞤭𞤤𞤭𞥅𞤼𞤭),
						'one' => q({0} 𞤧𞤢𞤲𞤼𞤭𞤤𞤭𞥅𞤼𞤵),
						'other' => q({0} 𞤧𞤢𞤲𞤼𞤭𞤤𞤭𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'centiliter' => {
						'name' => q(𞤧𞤢𞤲𞤼𞤭𞤤𞤭𞥅𞤼𞤭),
						'one' => q({0} 𞤧𞤢𞤲𞤼𞤭𞤤𞤭𞥅𞤼𞤵),
						'other' => q({0} 𞤧𞤢𞤲𞤼𞤭𞤤𞤭𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'volume-cubic-centimeter' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤤𞤢𞤥𞤦𞤵 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'cubic-centimeter' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤤𞤢𞤥𞤦𞤵 𞤧𞤢𞤲𞤼𞤭𞤥𞤫𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'volume-cubic-foot' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤼𞤫𞤨𞥆𞤭),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤼𞤫𞤨𞥆𞤵),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤼𞤫𞤨𞥆𞤭),
					},
					# Core Unit Identifier
					'cubic-foot' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤼𞤫𞤨𞥆𞤭),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤼𞤫𞤨𞥆𞤵),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤼𞤫𞤨𞥆𞤭),
					},
					# Long Unit Identifier
					'volume-cubic-inch' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤲𞤺𞤮𞤪𞤰𞤵),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤲𞤺𞤮𞤪𞤰𞤵),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤲𞤺𞤮𞤪𞤰𞤭),
					},
					# Core Unit Identifier
					'cubic-inch' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤲𞤺𞤮𞤪𞤰𞤵),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤲𞤺𞤮𞤪𞤰𞤵),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤲𞤺𞤮𞤪𞤰𞤭),
					},
					# Long Unit Identifier
					'volume-cubic-kilometer' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'cubic-kilometer' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤳𞤭𞤤𞤮𞤥𞤫𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'volume-cubic-meter' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤥𞤫𞥅𞤼𞤮𞤤),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤤𞤢𞤥𞤦𞤵 𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Core Unit Identifier
					'cubic-meter' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤥𞤫𞥅𞤼𞤮𞤤),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤥𞤫𞥅𞤼𞤮𞤤),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤥𞤫𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤤𞤢𞤥𞤦𞤵 𞤥𞤫𞥅𞤼𞤮𞤤),
					},
					# Long Unit Identifier
					'volume-cubic-mile' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤥𞤢𞤴𞤤𞤭),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤥𞤢𞤴𞤤𞤵),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤥𞤢𞤴𞤤𞤭),
					},
					# Core Unit Identifier
					'cubic-mile' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤥𞤢𞤴𞤤𞤭),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤥𞤢𞤴𞤤𞤵),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤥𞤢𞤴𞤤𞤭),
					},
					# Long Unit Identifier
					'volume-cubic-yard' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤧𞤮𞤺𞤮𞤲𞤫),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤧𞤮𞤺𞤮𞤲𞤢𞤤),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤧𞤮𞤺𞤮𞤲𞤫),
					},
					# Core Unit Identifier
					'cubic-yard' => {
						'name' => q(𞤤𞤢𞤥𞤦𞤵 𞤧𞤮𞤺𞤮𞤲𞤫),
						'one' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤧𞤮𞤺𞤮𞤲𞤢𞤤),
						'other' => q({0} 𞤤𞤢𞤥𞤦𞤵 𞤧𞤮𞤺𞤮𞤲𞤫),
					},
					# Long Unit Identifier
					'volume-cup' => {
						'name' => q(𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤫),
						'one' => q({0} 𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤮),
						'other' => q({0} 𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤫),
					},
					# Core Unit Identifier
					'cup' => {
						'name' => q(𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤫),
						'one' => q({0} 𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤮),
						'other' => q({0} 𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤫),
					},
					# Long Unit Identifier
					'volume-cup-metric' => {
						'name' => q(𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤫 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
						'one' => q({0} 𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤮 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
						'other' => q({0} 𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤫 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
					},
					# Core Unit Identifier
					'cup-metric' => {
						'name' => q(𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤫 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
						'one' => q({0} 𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤮 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
						'other' => q({0} 𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤫 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
					},
					# Long Unit Identifier
					'volume-deciliter' => {
						'name' => q(𞤣𞤫𞥅𞤧𞤭𞤤𞤭𞥅𞤼𞤭),
						'one' => q({0} 𞤣𞤫𞥅𞤧𞤭𞤤𞤭𞥅𞤼𞤵),
						'other' => q({0} 𞤣𞤫𞥅𞤧𞤭𞤤𞤭𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'deciliter' => {
						'name' => q(𞤣𞤫𞥅𞤧𞤭𞤤𞤭𞥅𞤼𞤭),
						'one' => q({0} 𞤣𞤫𞥅𞤧𞤭𞤤𞤭𞥅𞤼𞤵),
						'other' => q({0} 𞤣𞤫𞥅𞤧𞤭𞤤𞤭𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'volume-dessert-spoon' => {
						'name' => q(𞤳𞤮𞤤𞤬𞤮 𞤤𞤫𞤥𞤰𞤢𞥄𞤪𞤭),
						'one' => q({0} 𞤳𞤮𞤤𞤬𞤮 𞤤𞤫𞤥𞤰𞤢𞥄𞤪𞤭),
						'other' => q({0} 𞤳𞤮𞤤𞤬𞤮 𞤤𞤫𞤥𞤰𞤢𞥄𞤪𞤭),
					},
					# Core Unit Identifier
					'dessert-spoon' => {
						'name' => q(𞤳𞤮𞤤𞤬𞤮 𞤤𞤫𞤥𞤰𞤢𞥄𞤪𞤭),
						'one' => q({0} 𞤳𞤮𞤤𞤬𞤮 𞤤𞤫𞤥𞤰𞤢𞥄𞤪𞤭),
						'other' => q({0} 𞤳𞤮𞤤𞤬𞤮 𞤤𞤫𞤥𞤰𞤢𞥄𞤪𞤭),
					},
					# Long Unit Identifier
					'volume-dessert-spoon-imperial' => {
						'name' => q(𞤳𞤮𞤤𞤬𞤮 𞤤𞤫𞤥𞤰𞤢𞥄𞤪𞤭 𞤚𞤭𞤤.),
						'one' => q({0} 𞤳𞤮𞤤𞤬𞤫 𞤤𞤫𞤥𞤰𞤢𞥄𞤪𞤭 𞤚𞤭𞤤.),
						'other' => q({0} 𞤳𞤮𞤤𞤬𞤮 𞤤𞤫𞤥𞤰𞤢𞥄𞤪𞤭 𞤚𞤭𞤤.),
					},
					# Core Unit Identifier
					'dessert-spoon-imperial' => {
						'name' => q(𞤳𞤮𞤤𞤬𞤮 𞤤𞤫𞤥𞤰𞤢𞥄𞤪𞤭 𞤚𞤭𞤤.),
						'one' => q({0} 𞤳𞤮𞤤𞤬𞤫 𞤤𞤫𞤥𞤰𞤢𞥄𞤪𞤭 𞤚𞤭𞤤.),
						'other' => q({0} 𞤳𞤮𞤤𞤬𞤮 𞤤𞤫𞤥𞤰𞤢𞥄𞤪𞤭 𞤚𞤭𞤤.),
					},
					# Long Unit Identifier
					'volume-dram' => {
						'name' => q(𞤣𞤭𞤪𞤸𞤢𞤥𞤵),
						'one' => q({0} 𞤣𞤭𞤪𞤸𞤢𞤥𞤵),
						'other' => q({0} 𞤣𞤭𞤪𞤸𞤢𞤥𞤵),
					},
					# Core Unit Identifier
					'dram' => {
						'name' => q(𞤣𞤭𞤪𞤸𞤢𞤥𞤵),
						'one' => q({0} 𞤣𞤭𞤪𞤸𞤢𞤥𞤵),
						'other' => q({0} 𞤣𞤭𞤪𞤸𞤢𞤥𞤵),
					},
					# Long Unit Identifier
					'volume-drop' => {
						'name' => q(𞤧𞤭𞤲𞤼𞤫𞤪𞤫),
						'one' => q({0} 𞤧𞤭𞤲𞤼𞤫𞤪𞤫),
						'other' => q({0} 𞤷𞤭𞤲𞤼𞤫),
					},
					# Core Unit Identifier
					'drop' => {
						'name' => q(𞤧𞤭𞤲𞤼𞤫𞤪𞤫),
						'one' => q({0} 𞤧𞤭𞤲𞤼𞤫𞤪𞤫),
						'other' => q({0} 𞤷𞤭𞤲𞤼𞤫),
					},
					# Long Unit Identifier
					'volume-fluid-ounce' => {
						'name' => q(𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤧𞤫𞤤𞤦𞤢𞤲),
						'one' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞤱𞤵 𞤧𞤫𞤤𞤦𞤢𞤲),
						'other' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤧𞤫𞤤𞤦𞤢𞤲),
					},
					# Core Unit Identifier
					'fluid-ounce' => {
						'name' => q(𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤧𞤫𞤤𞤦𞤢𞤲),
						'one' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞤱𞤵 𞤧𞤫𞤤𞤦𞤢𞤲),
						'other' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤧𞤫𞤤𞤦𞤢𞤲),
					},
					# Long Unit Identifier
					'volume-fluid-ounce-imperial' => {
						'name' => q(𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤧𞤫𞤤𞤦𞤢𞤲 𞤚𞤭𞤤𞤧𞤵),
						'one' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞤱𞤵 𞤧𞤫𞤤𞤦𞤢𞤲 𞤚𞤭𞤤𞤧𞤵),
						'other' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤧𞤫𞤤𞤦𞤢𞤲 𞤚𞤭𞤤𞤧𞤵),
					},
					# Core Unit Identifier
					'fluid-ounce-imperial' => {
						'name' => q(𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤧𞤫𞤤𞤦𞤢𞤲 𞤚𞤭𞤤𞤧𞤵),
						'one' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞤱𞤵 𞤧𞤫𞤤𞤦𞤢𞤲 𞤚𞤭𞤤𞤧𞤵),
						'other' => q({0} 𞤱𞤢𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤧𞤫𞤤𞤦𞤢𞤲 𞤚𞤭𞤤𞤧𞤵),
					},
					# Long Unit Identifier
					'volume-gallon' => {
						'name' => q(𞤺𞤢𞤤𞤮𞤲𞤶𞤭),
						'one' => q({0} 𞤺𞤢𞤤𞤮𞤲𞤪𞤵),
						'other' => q({0} 𞤺𞤢𞤤𞤮𞤲𞤶𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤺𞤢𞤤𞤮𞤲𞤪𞤵),
					},
					# Core Unit Identifier
					'gallon' => {
						'name' => q(𞤺𞤢𞤤𞤮𞤲𞤶𞤭),
						'one' => q({0} 𞤺𞤢𞤤𞤮𞤲𞤪𞤵),
						'other' => q({0} 𞤺𞤢𞤤𞤮𞤲𞤶𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤺𞤢𞤤𞤮𞤲𞤪𞤵),
					},
					# Long Unit Identifier
					'volume-gallon-imperial' => {
						'name' => q(𞤺𞤢𞤤𞤮𞤲𞤶𞤭 𞤚𞤭𞤤𞤧𞤵),
						'one' => q({0} 𞤺𞤢𞤤𞤮𞤲𞤪𞤵 𞤚𞤭𞤤𞤧𞤵),
						'other' => q({0} 𞤺𞤢𞤤𞤮𞤲𞤶𞤭 𞤚𞤭𞤤𞤧𞤵),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤺𞤢𞤤𞤮𞤲𞤪𞤵 𞤚𞤭𞤤𞤧𞤵),
					},
					# Core Unit Identifier
					'gallon-imperial' => {
						'name' => q(𞤺𞤢𞤤𞤮𞤲𞤶𞤭 𞤚𞤭𞤤𞤧𞤵),
						'one' => q({0} 𞤺𞤢𞤤𞤮𞤲𞤪𞤵 𞤚𞤭𞤤𞤧𞤵),
						'other' => q({0} 𞤺𞤢𞤤𞤮𞤲𞤶𞤭 𞤚𞤭𞤤𞤧𞤵),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤺𞤢𞤤𞤮𞤲𞤪𞤵 𞤚𞤭𞤤𞤧𞤵),
					},
					# Long Unit Identifier
					'volume-hectoliter' => {
						'name' => q(𞤸𞤫𞤳𞤼𞤮𞤤𞤭𞥅𞤼𞤭),
						'one' => q({0} 𞤸𞤫𞤳𞤼𞤮𞤤𞤭𞥅𞤼𞤵),
						'other' => q({0} 𞤸𞤫𞤳𞤼𞤮𞤤𞤭𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'hectoliter' => {
						'name' => q(𞤸𞤫𞤳𞤼𞤮𞤤𞤭𞥅𞤼𞤭),
						'one' => q({0} 𞤸𞤫𞤳𞤼𞤮𞤤𞤭𞥅𞤼𞤵),
						'other' => q({0} 𞤸𞤫𞤳𞤼𞤮𞤤𞤭𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'volume-jigger' => {
						'name' => q(𞤶𞤭𞤺𞥆𞤮),
						'one' => q({0} 𞤶𞤭𞤺𞥆𞤮),
						'other' => q({0} 𞤶𞤭𞤺𞥆𞤫),
					},
					# Core Unit Identifier
					'jigger' => {
						'name' => q(𞤶𞤭𞤺𞥆𞤮),
						'one' => q({0} 𞤶𞤭𞤺𞥆𞤮),
						'other' => q({0} 𞤶𞤭𞤺𞥆𞤫),
					},
					# Long Unit Identifier
					'volume-liter' => {
						'name' => q(𞤤𞤭𞥅𞤼𞤭),
						'one' => q({0} 𞤤𞤭𞥅𞤼𞤵),
						'other' => q({0} 𞤤𞤭𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤤𞤭𞥅𞤼𞤵),
					},
					# Core Unit Identifier
					'liter' => {
						'name' => q(𞤤𞤭𞥅𞤼𞤭),
						'one' => q({0} 𞤤𞤭𞥅𞤼𞤵),
						'other' => q({0} 𞤤𞤭𞥅𞤼𞤭),
						'per' => q({0} 𞤲𞤣𞤫𞤪 𞤤𞤭𞥅𞤼𞤵),
					},
					# Long Unit Identifier
					'volume-megaliter' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤤𞤭𞥅𞤼𞤵),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤤𞤭𞥅𞤼𞤵),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤤𞤭𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'megaliter' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤤𞤭𞥅𞤼𞤵),
						'one' => q({0} 𞤥𞤫𞤺𞤢𞤤𞤭𞥅𞤼𞤵),
						'other' => q({0} 𞤥𞤫𞤺𞤢𞤤𞤭𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'volume-milliliter' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤤𞤭𞥅𞤼𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤤𞤭𞥅𞤼𞤵),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤤𞤭𞥅𞤼𞤭),
					},
					# Core Unit Identifier
					'milliliter' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤤𞤭𞥅𞤼𞤭),
						'one' => q({0} 𞤥𞤭𞤤𞤭𞤤𞤭𞥅𞤼𞤵),
						'other' => q({0} 𞤥𞤭𞤤𞤭𞤤𞤭𞥅𞤼𞤭),
					},
					# Long Unit Identifier
					'volume-pinch' => {
						'name' => q(𞤩𞤵𞤷𞥆𞤢𞤲𞤣𞤫),
						'one' => q({0} 𞤩𞤵𞤷𞥆𞤢𞤲𞤣𞤫),
						'other' => q({0} 𞤩𞤵𞤷𞥆𞤢𞤲𞤯𞤫),
					},
					# Core Unit Identifier
					'pinch' => {
						'name' => q(𞤩𞤵𞤷𞥆𞤢𞤲𞤣𞤫),
						'one' => q({0} 𞤩𞤵𞤷𞥆𞤢𞤲𞤣𞤫),
						'other' => q({0} 𞤩𞤵𞤷𞥆𞤢𞤲𞤯𞤫),
					},
					# Long Unit Identifier
					'volume-pint' => {
						'name' => q(𞤨𞤭𞤲𞤼𞤭),
						'one' => q({0} 𞤨𞤭𞤲𞤼𞤵),
						'other' => q({0} 𞤨𞤭𞤲𞤼𞤭),
					},
					# Core Unit Identifier
					'pint' => {
						'name' => q(𞤨𞤭𞤲𞤼𞤭),
						'one' => q({0} 𞤨𞤭𞤲𞤼𞤵),
						'other' => q({0} 𞤨𞤭𞤲𞤼𞤭),
					},
					# Long Unit Identifier
					'volume-pint-metric' => {
						'name' => q(𞤨𞤭𞤲𞤼𞤭 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
						'one' => q({0} 𞤨𞤭𞤲𞤼𞤵 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
						'other' => q({0} 𞤨𞤭𞤲𞤼𞤭 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
					},
					# Core Unit Identifier
					'pint-metric' => {
						'name' => q(𞤨𞤭𞤲𞤼𞤭 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
						'one' => q({0} 𞤨𞤭𞤲𞤼𞤵 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
						'other' => q({0} 𞤨𞤭𞤲𞤼𞤭 𞤥𞤫𞤼𞤭𞤪𞤳𞤵),
					},
					# Long Unit Identifier
					'volume-quart' => {
						'name' => q(𞤳𞤮𞤪𞤼𞤭),
						'one' => q({0} 𞤳𞤮𞤪𞤼𞤵),
						'other' => q({0} 𞤳𞤮𞤪𞤼𞤭),
					},
					# Core Unit Identifier
					'quart' => {
						'name' => q(𞤳𞤮𞤪𞤼𞤭),
						'one' => q({0} 𞤳𞤮𞤪𞤼𞤵),
						'other' => q({0} 𞤳𞤮𞤪𞤼𞤭),
					},
					# Long Unit Identifier
					'volume-quart-imperial' => {
						'name' => q(𞤳𞤮𞤪𞤼𞤵 𞤚𞤭𞤤𞤧𞤵),
						'one' => q({0} 𞤳𞤮𞤪𞤼𞤵 𞤚𞤭𞤤𞤧𞤵),
						'other' => q({0} 𞤳𞤮𞤪𞤼𞤭 𞤚𞤭𞤤𞤧𞤵),
					},
					# Core Unit Identifier
					'quart-imperial' => {
						'name' => q(𞤳𞤮𞤪𞤼𞤵 𞤚𞤭𞤤𞤧𞤵),
						'one' => q({0} 𞤳𞤮𞤪𞤼𞤵 𞤚𞤭𞤤𞤧𞤵),
						'other' => q({0} 𞤳𞤮𞤪𞤼𞤭 𞤚𞤭𞤤𞤧𞤵),
					},
					# Long Unit Identifier
					'volume-tablespoon' => {
						'name' => q(𞤳𞤮𞤤𞤬𞤫-𞤻𞤢𞥄𞤥𞤣𞤵),
						'one' => q({0} 𞤳𞤮𞤤𞤬𞤮-𞤻𞤢𞥄𞤥𞤣𞤵),
						'other' => q({0} 𞤳𞤮𞤤𞤬𞤫-𞤻𞤢𞥄𞤥𞤣𞤵),
					},
					# Core Unit Identifier
					'tablespoon' => {
						'name' => q(𞤳𞤮𞤤𞤬𞤫-𞤻𞤢𞥄𞤥𞤣𞤵),
						'one' => q({0} 𞤳𞤮𞤤𞤬𞤮-𞤻𞤢𞥄𞤥𞤣𞤵),
						'other' => q({0} 𞤳𞤮𞤤𞤬𞤫-𞤻𞤢𞥄𞤥𞤣𞤵),
					},
					# Long Unit Identifier
					'volume-teaspoon' => {
						'name' => q(𞤳𞤮𞤤𞤬𞤫-𞤲𞤦𞤢𞤪𞤩𞤵),
						'one' => q({0} 𞤳𞤮𞤤𞤬𞤮-𞤲𞤦𞤢𞤪𞤩𞤵),
						'other' => q({0} 𞤳𞤮𞤤𞤬𞤫-𞤲𞤦𞤢𞤪𞤩𞤵),
					},
					# Core Unit Identifier
					'teaspoon' => {
						'name' => q(𞤳𞤮𞤤𞤬𞤫-𞤲𞤦𞤢𞤪𞤩𞤵),
						'one' => q({0} 𞤳𞤮𞤤𞤬𞤮-𞤲𞤦𞤢𞤪𞤩𞤵),
						'other' => q({0} 𞤳𞤮𞤤𞤬𞤫-𞤲𞤦𞤢𞤪𞤩𞤵),
					},
				},
				'narrow' => {
					# Long Unit Identifier
					'' => {
						'name' => q(𞤸𞤫𞤤𞥆𞤢),
					},
					# Core Unit Identifier
					'' => {
						'name' => q(𞤸𞤫𞤤𞥆𞤢),
					},
					# Long Unit Identifier
					'1024p1' => {
						'1' => q(𞤑𞤭{0}),
					},
					# Core Unit Identifier
					'1024p1' => {
						'1' => q(𞤑𞤭{0}),
					},
					# Long Unit Identifier
					'1024p2' => {
						'1' => q(𞤃𞤭{0}),
					},
					# Core Unit Identifier
					'1024p2' => {
						'1' => q(𞤃𞤭{0}),
					},
					# Long Unit Identifier
					'1024p3' => {
						'1' => q(𞤘𞤭{0}),
					},
					# Core Unit Identifier
					'1024p3' => {
						'1' => q(𞤘𞤭{0}),
					},
					# Long Unit Identifier
					'1024p4' => {
						'1' => q(𞤚𞤭{0}),
					},
					# Core Unit Identifier
					'1024p4' => {
						'1' => q(𞤚𞤭{0}),
					},
					# Long Unit Identifier
					'1024p5' => {
						'1' => q(𞤆𞤭{0}),
					},
					# Core Unit Identifier
					'1024p5' => {
						'1' => q(𞤆𞤭{0}),
					},
					# Long Unit Identifier
					'1024p6' => {
						'1' => q(𞤉𞤭{0}),
					},
					# Core Unit Identifier
					'1024p6' => {
						'1' => q(𞤉𞤭{0}),
					},
					# Long Unit Identifier
					'1024p7' => {
						'1' => q(𞤟𞤭{0}),
					},
					# Core Unit Identifier
					'1024p7' => {
						'1' => q(𞤟𞤭{0}),
					},
					# Long Unit Identifier
					'1024p8' => {
						'1' => q(𞤒𞤭{0}),
					},
					# Core Unit Identifier
					'1024p8' => {
						'1' => q(𞤒𞤭{0}),
					},
					# Long Unit Identifier
					'10p-1' => {
						'1' => q(𞤣{0}),
					},
					# Core Unit Identifier
					'1' => {
						'1' => q(𞤣{0}),
					},
					# Long Unit Identifier
					'10p-12' => {
						'1' => q(𞤨{0}),
					},
					# Core Unit Identifier
					'12' => {
						'1' => q(𞤨{0}),
					},
					# Long Unit Identifier
					'10p-15' => {
						'1' => q(𞤬{0}),
					},
					# Core Unit Identifier
					'15' => {
						'1' => q(𞤬{0}),
					},
					# Long Unit Identifier
					'10p-18' => {
						'1' => q(𞤢{0}),
					},
					# Core Unit Identifier
					'18' => {
						'1' => q(𞤢{0}),
					},
					# Long Unit Identifier
					'10p-2' => {
						'1' => q(𞤧{0}),
					},
					# Core Unit Identifier
					'2' => {
						'1' => q(𞤧{0}),
					},
					# Long Unit Identifier
					'10p-21' => {
						'1' => q(𞥁{0}),
					},
					# Core Unit Identifier
					'21' => {
						'1' => q(𞥁{0}),
					},
					# Long Unit Identifier
					'10p-24' => {
						'1' => q(𞤴{0}),
					},
					# Core Unit Identifier
					'24' => {
						'1' => q(𞤴{0}),
					},
					# Long Unit Identifier
					'10p-3' => {
						'1' => q(𞤥{0}),
					},
					# Core Unit Identifier
					'3' => {
						'1' => q(𞤥{0}),
					},
					# Long Unit Identifier
					'10p-6' => {
						'1' => q(𞤻{0}),
					},
					# Core Unit Identifier
					'6' => {
						'1' => q(𞤻{0}),
					},
					# Long Unit Identifier
					'10p-9' => {
						'1' => q(𞤲{0}),
					},
					# Core Unit Identifier
					'9' => {
						'1' => q(𞤲{0}),
					},
					# Long Unit Identifier
					'10p1' => {
						'1' => q(𞤣𞤢{0}),
					},
					# Core Unit Identifier
					'10p1' => {
						'1' => q(𞤣𞤢{0}),
					},
					# Long Unit Identifier
					'10p12' => {
						'1' => q(𞤚{0}),
					},
					# Core Unit Identifier
					'10p12' => {
						'1' => q(𞤚{0}),
					},
					# Long Unit Identifier
					'10p15' => {
						'1' => q(𞤆{0}),
					},
					# Core Unit Identifier
					'10p15' => {
						'1' => q(𞤆{0}),
					},
					# Long Unit Identifier
					'10p18' => {
						'1' => q(𞤉{0}),
					},
					# Core Unit Identifier
					'10p18' => {
						'1' => q(𞤉{0}),
					},
					# Long Unit Identifier
					'10p2' => {
						'1' => q(𞤸{0}),
					},
					# Core Unit Identifier
					'10p2' => {
						'1' => q(𞤸{0}),
					},
					# Long Unit Identifier
					'10p21' => {
						'1' => q(𞤟{0}),
					},
					# Core Unit Identifier
					'10p21' => {
						'1' => q(𞤟{0}),
					},
					# Long Unit Identifier
					'10p24' => {
						'1' => q(𞤒{0}),
					},
					# Core Unit Identifier
					'10p24' => {
						'1' => q(𞤒{0}),
					},
					# Long Unit Identifier
					'10p3' => {
						'1' => q(𞤳{0}),
					},
					# Core Unit Identifier
					'10p3' => {
						'1' => q(𞤳{0}),
					},
					# Long Unit Identifier
					'10p6' => {
						'1' => q(𞤃{0}),
					},
					# Core Unit Identifier
					'10p6' => {
						'1' => q(𞤃{0}),
					},
					# Long Unit Identifier
					'10p9' => {
						'1' => q(𞤘{0}),
					},
					# Core Unit Identifier
					'10p9' => {
						'1' => q(𞤘{0}),
					},
					# Long Unit Identifier
					'coordinate' => {
						'east' => q({0}𞤊),
						'north' => q({0}𞤐),
						'south' => q({0}𞤙),
						'west' => q({0}𞤖),
					},
					# Core Unit Identifier
					'coordinate' => {
						'east' => q({0}𞤊),
						'north' => q({0}𞤐),
						'south' => q({0}𞤙),
						'west' => q({0}𞤖),
					},
					# Long Unit Identifier
					'duration-day' => {
						'name' => q(𞤻𞤢𞤤.),
						'one' => q({0} 𞤻𞤢𞤤.),
						'other' => q({0} 𞤻𞤢𞤤.),
					},
					# Core Unit Identifier
					'day' => {
						'name' => q(𞤻𞤢𞤤.),
						'one' => q({0} 𞤻𞤢𞤤.),
						'other' => q({0} 𞤻𞤢𞤤.),
					},
					# Long Unit Identifier
					'duration-hour' => {
						'name' => q(𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'one' => q({0}𞤶),
						'other' => q({0}𞤶),
					},
					# Core Unit Identifier
					'hour' => {
						'name' => q(𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'one' => q({0}𞤶),
						'other' => q({0}𞤶),
					},
					# Long Unit Identifier
					'duration-millisecond' => {
						'name' => q(𞤥𞤳𞤭𞤲),
						'one' => q({0}𞤥𞤳𞤭𞤲),
						'other' => q({0}𞤥𞤳𞤭𞤲),
					},
					# Core Unit Identifier
					'millisecond' => {
						'name' => q(𞤥𞤳𞤭𞤲),
						'one' => q({0}𞤥𞤳𞤭𞤲),
						'other' => q({0}𞤥𞤳𞤭𞤲),
					},
					# Long Unit Identifier
					'duration-minute' => {
						'name' => q(𞤸𞤮𞤶),
						'one' => q({0}𞤸𞤮𞤶),
						'other' => q({0}𞤸𞤮𞤶),
					},
					# Core Unit Identifier
					'minute' => {
						'name' => q(𞤸𞤮𞤶),
						'one' => q({0}𞤸𞤮𞤶),
						'other' => q({0}𞤸𞤮𞤶),
					},
					# Long Unit Identifier
					'duration-month' => {
						'name' => q(𞤤𞤫𞤦𞥆𞤭),
						'one' => q({0} 𞤤𞤫𞤱),
						'other' => q({0} 𞤤𞤫𞤦),
					},
					# Core Unit Identifier
					'month' => {
						'name' => q(𞤤𞤫𞤦𞥆𞤭),
						'one' => q({0} 𞤤𞤫𞤱),
						'other' => q({0} 𞤤𞤫𞤦),
					},
					# Long Unit Identifier
					'duration-second' => {
						'name' => q(𞤳𞤭𞤲),
						'one' => q({0}𞤳𞤭𞤲),
						'other' => q({0}𞤳𞤭𞤲),
					},
					# Core Unit Identifier
					'second' => {
						'name' => q(𞤳𞤭𞤲),
						'one' => q({0}𞤳𞤭𞤲),
						'other' => q({0}𞤳𞤭𞤲),
					},
					# Long Unit Identifier
					'duration-week' => {
						'name' => q(𞤶𞤼),
						'one' => q({0} 𞤴𞤼),
						'other' => q({0} 𞤶𞤼),
					},
					# Core Unit Identifier
					'week' => {
						'name' => q(𞤶𞤼),
						'one' => q({0} 𞤴𞤼),
						'other' => q({0} 𞤶𞤼),
					},
					# Long Unit Identifier
					'duration-year' => {
						'name' => q(𞤸𞤭𞤼),
						'one' => q({0} 𞤳𞤭𞤼),
						'other' => q({0}/𞤳𞤭𞤼),
					},
					# Core Unit Identifier
					'year' => {
						'name' => q(𞤸𞤭𞤼),
						'one' => q({0} 𞤳𞤭𞤼),
						'other' => q({0}/𞤳𞤭𞤼),
					},
					# Long Unit Identifier
					'length-centimeter' => {
						'name' => q(𞤧𞤥),
						'one' => q({0}𞤧𞤥),
						'other' => q({0}𞤧𞤥),
					},
					# Core Unit Identifier
					'centimeter' => {
						'name' => q(𞤧𞤥),
						'one' => q({0}𞤧𞤥),
						'other' => q({0}𞤧𞤥),
					},
					# Long Unit Identifier
					'length-kilometer' => {
						'name' => q(𞤳𞤥),
						'one' => q({0}𞤳𞤥),
						'other' => q({0}𞤳𞤥),
					},
					# Core Unit Identifier
					'kilometer' => {
						'name' => q(𞤳𞤥),
						'one' => q({0}𞤳𞤥),
						'other' => q({0}𞤳𞤥),
					},
					# Long Unit Identifier
					'length-meter' => {
						'name' => q(𞤥),
						'one' => q({0}𞤥),
						'other' => q({0}𞤥),
					},
					# Core Unit Identifier
					'meter' => {
						'name' => q(𞤥),
						'one' => q({0}𞤥),
						'other' => q({0}𞤥),
					},
					# Long Unit Identifier
					'length-millimeter' => {
						'name' => q(𞤥𞤥),
						'one' => q({0}𞤥𞤥),
						'other' => q({0}𞤥𞤥),
					},
					# Core Unit Identifier
					'millimeter' => {
						'name' => q(𞤥𞤥),
						'one' => q({0}𞤥𞤥),
						'other' => q({0}𞤥𞤥),
					},
					# Long Unit Identifier
					'mass-gram' => {
						'name' => q(𞤺𞤢𞤪𞤬𞤵),
						'one' => q({0}𞤺),
						'other' => q({0}𞤺),
					},
					# Core Unit Identifier
					'gram' => {
						'name' => q(𞤺𞤢𞤪𞤬𞤵),
						'one' => q({0}𞤺),
						'other' => q({0}𞤺),
					},
					# Long Unit Identifier
					'mass-kilogram' => {
						'name' => q(𞤳𞤺),
						'one' => q({0}𞤳𞤺),
						'other' => q({0}𞤳𞤺),
					},
					# Core Unit Identifier
					'kilogram' => {
						'name' => q(𞤳𞤺),
						'one' => q({0}𞤳𞤺),
						'other' => q({0}𞤳𞤺),
					},
					# Long Unit Identifier
					'per' => {
						'1' => q({0}/{1}),
					},
					# Core Unit Identifier
					'per' => {
						'1' => q({0}/{1}),
					},
					# Long Unit Identifier
					'power2' => {
						'one' => q({0}𞥒),
						'other' => q({0}𞥒),
					},
					# Core Unit Identifier
					'power2' => {
						'one' => q({0}𞥒),
						'other' => q({0}𞥒),
					},
					# Long Unit Identifier
					'power3' => {
						'one' => q({0}𞥓),
						'other' => q({0}𞥓),
					},
					# Core Unit Identifier
					'power3' => {
						'one' => q({0}𞥓),
						'other' => q({0}𞥓),
					},
					# Long Unit Identifier
					'speed-kilometer-per-hour' => {
						'name' => q(𞤳𞤥/𞤶𞤢),
						'one' => q({0}𞤳𞤥/𞤶),
						'other' => q({0}𞤳𞤥/𞤶),
					},
					# Core Unit Identifier
					'kilometer-per-hour' => {
						'name' => q(𞤳𞤥/𞤶𞤢),
						'one' => q({0}𞤳𞤥/𞤶),
						'other' => q({0}𞤳𞤥/𞤶),
					},
					# Long Unit Identifier
					'temperature-celsius' => {
						'name' => q(°𞤅),
						'one' => q({0}°𞤅),
						'other' => q({0}°𞤅),
					},
					# Core Unit Identifier
					'celsius' => {
						'name' => q(°𞤅),
						'one' => q({0}°𞤅),
						'other' => q({0}°𞤅),
					},
					# Long Unit Identifier
					'times' => {
						'1' => q({0}-{1}),
					},
					# Core Unit Identifier
					'times' => {
						'1' => q({0}-{1}),
					},
					# Long Unit Identifier
					'volume-liter' => {
						'name' => q(𞤤𞤭𞥅𞤼𞤵),
						'one' => q({0}𞤂),
						'other' => q({0}𞤂),
					},
					# Core Unit Identifier
					'liter' => {
						'name' => q(𞤤𞤭𞥅𞤼𞤵),
						'one' => q({0}𞤂),
						'other' => q({0}𞤂),
					},
				},
				'short' => {
					# Long Unit Identifier
					'' => {
						'name' => q(𞤸𞤫𞤤𞥆𞤢),
					},
					# Core Unit Identifier
					'' => {
						'name' => q(𞤸𞤫𞤤𞥆𞤢),
					},
					# Long Unit Identifier
					'1024p1' => {
						'1' => q(𞤑𞤭{0}),
					},
					# Core Unit Identifier
					'1024p1' => {
						'1' => q(𞤑𞤭{0}),
					},
					# Long Unit Identifier
					'1024p2' => {
						'1' => q(𞤃𞤭{0}),
					},
					# Core Unit Identifier
					'1024p2' => {
						'1' => q(𞤃𞤭{0}),
					},
					# Long Unit Identifier
					'1024p3' => {
						'1' => q(𞤘𞤭{0}),
					},
					# Core Unit Identifier
					'1024p3' => {
						'1' => q(𞤘𞤭{0}),
					},
					# Long Unit Identifier
					'1024p4' => {
						'1' => q(𞤚𞤭{0}),
					},
					# Core Unit Identifier
					'1024p4' => {
						'1' => q(𞤚𞤭{0}),
					},
					# Long Unit Identifier
					'1024p5' => {
						'1' => q(𞤆𞤭{0}),
					},
					# Core Unit Identifier
					'1024p5' => {
						'1' => q(𞤆𞤭{0}),
					},
					# Long Unit Identifier
					'1024p6' => {
						'1' => q(𞤉𞤭{0}),
					},
					# Core Unit Identifier
					'1024p6' => {
						'1' => q(𞤉𞤭{0}),
					},
					# Long Unit Identifier
					'1024p7' => {
						'1' => q(𞤟𞤭{0}),
					},
					# Core Unit Identifier
					'1024p7' => {
						'1' => q(𞤟𞤭{0}),
					},
					# Long Unit Identifier
					'1024p8' => {
						'1' => q(𞤒𞤭{0}),
					},
					# Core Unit Identifier
					'1024p8' => {
						'1' => q(𞤒𞤭{0}),
					},
					# Long Unit Identifier
					'10p-1' => {
						'1' => q(𞤣{0}),
					},
					# Core Unit Identifier
					'1' => {
						'1' => q(𞤣{0}),
					},
					# Long Unit Identifier
					'10p-12' => {
						'1' => q(𞤨{0}),
					},
					# Core Unit Identifier
					'12' => {
						'1' => q(𞤨{0}),
					},
					# Long Unit Identifier
					'10p-15' => {
						'1' => q(𞤬{0}),
					},
					# Core Unit Identifier
					'15' => {
						'1' => q(𞤬{0}),
					},
					# Long Unit Identifier
					'10p-18' => {
						'1' => q(𞤢{0}),
					},
					# Core Unit Identifier
					'18' => {
						'1' => q(𞤢{0}),
					},
					# Long Unit Identifier
					'10p-2' => {
						'1' => q(𞤧{0}),
					},
					# Core Unit Identifier
					'2' => {
						'1' => q(𞤧{0}),
					},
					# Long Unit Identifier
					'10p-21' => {
						'1' => q(𞥁{0}),
					},
					# Core Unit Identifier
					'21' => {
						'1' => q(𞥁{0}),
					},
					# Long Unit Identifier
					'10p-24' => {
						'1' => q(𞤴{0}),
					},
					# Core Unit Identifier
					'24' => {
						'1' => q(𞤴{0}),
					},
					# Long Unit Identifier
					'10p-3' => {
						'1' => q(𞤥{0}),
					},
					# Core Unit Identifier
					'3' => {
						'1' => q(𞤥{0}),
					},
					# Long Unit Identifier
					'10p-6' => {
						'1' => q(𞤻𞤭𞤤𞤢{0}),
					},
					# Core Unit Identifier
					'6' => {
						'1' => q(𞤻𞤭𞤤𞤢{0}),
					},
					# Long Unit Identifier
					'10p-9' => {
						'1' => q(𞤲{0}),
					},
					# Core Unit Identifier
					'9' => {
						'1' => q(𞤲{0}),
					},
					# Long Unit Identifier
					'10p1' => {
						'1' => q(𞤣𞤢{0}),
					},
					# Core Unit Identifier
					'10p1' => {
						'1' => q(𞤣𞤢{0}),
					},
					# Long Unit Identifier
					'10p12' => {
						'1' => q(𞤚{0}),
					},
					# Core Unit Identifier
					'10p12' => {
						'1' => q(𞤚{0}),
					},
					# Long Unit Identifier
					'10p15' => {
						'1' => q(𞤆{0}),
					},
					# Core Unit Identifier
					'10p15' => {
						'1' => q(𞤆{0}),
					},
					# Long Unit Identifier
					'10p18' => {
						'1' => q(𞤉{0}),
					},
					# Core Unit Identifier
					'10p18' => {
						'1' => q(𞤉{0}),
					},
					# Long Unit Identifier
					'10p2' => {
						'1' => q(𞤸{0}),
					},
					# Core Unit Identifier
					'10p2' => {
						'1' => q(𞤸{0}),
					},
					# Long Unit Identifier
					'10p21' => {
						'1' => q(𞤟{0}),
					},
					# Core Unit Identifier
					'10p21' => {
						'1' => q(𞤟{0}),
					},
					# Long Unit Identifier
					'10p24' => {
						'1' => q(𞤒{0}),
					},
					# Core Unit Identifier
					'10p24' => {
						'1' => q(𞤒{0}),
					},
					# Long Unit Identifier
					'10p3' => {
						'1' => q(𞤳{0}),
					},
					# Core Unit Identifier
					'10p3' => {
						'1' => q(𞤳{0}),
					},
					# Long Unit Identifier
					'10p6' => {
						'1' => q(𞤃{0}),
					},
					# Core Unit Identifier
					'10p6' => {
						'1' => q(𞤃{0}),
					},
					# Long Unit Identifier
					'10p9' => {
						'1' => q(𞤘{0}),
					},
					# Core Unit Identifier
					'10p9' => {
						'1' => q(𞤘{0}),
					},
					# Long Unit Identifier
					'acceleration-g-force' => {
						'name' => q(𞤻-𞤷𞤫𞤥𞤦𞤫),
						'one' => q({0} 𞤙),
						'other' => q({0} 𞤙),
					},
					# Core Unit Identifier
					'g-force' => {
						'name' => q(𞤻-𞤷𞤫𞤥𞤦𞤫),
						'one' => q({0} 𞤙),
						'other' => q({0} 𞤙),
					},
					# Long Unit Identifier
					'acceleration-meter-per-square-second' => {
						'name' => q(𞤥𞤫𞥅𞤼𞤭/𞤳𞤭𞤲𞥒),
						'one' => q({0} 𞤥/𞤳𞤭𞤲𞥒),
						'other' => q({0} 𞤥/𞤳𞤭𞤲𞥒),
					},
					# Core Unit Identifier
					'meter-per-square-second' => {
						'name' => q(𞤥𞤫𞥅𞤼𞤭/𞤳𞤭𞤲𞥒),
						'one' => q({0} 𞤥/𞤳𞤭𞤲𞥒),
						'other' => q({0} 𞤥/𞤳𞤭𞤲𞥒),
					},
					# Long Unit Identifier
					'angle-arc-minute' => {
						'name' => q(𞤸𞤮𞤶𞤤𞤢),
						'one' => q({0} 𞤸𞤮𞤶𞤤𞤢),
						'other' => q({0} 𞤸𞤮𞤶𞤤𞤢),
					},
					# Core Unit Identifier
					'arc-minute' => {
						'name' => q(𞤸𞤮𞤶𞤤𞤢),
						'one' => q({0} 𞤸𞤮𞤶𞤤𞤢),
						'other' => q({0} 𞤸𞤮𞤶𞤤𞤢),
					},
					# Long Unit Identifier
					'angle-arc-second' => {
						'name' => q(𞤶𞤮𞤶𞤳𞤭𞤲),
						'one' => q({0} 𞤸𞤮𞤶𞤳𞤭𞤲),
						'other' => q({0} 𞤸𞤮𞤶𞤳𞤭𞤲),
					},
					# Core Unit Identifier
					'arc-second' => {
						'name' => q(𞤶𞤮𞤶𞤳𞤭𞤲),
						'one' => q({0} 𞤸𞤮𞤶𞤳𞤭𞤲),
						'other' => q({0} 𞤸𞤮𞤶𞤳𞤭𞤲),
					},
					# Long Unit Identifier
					'angle-degree' => {
						'name' => q(𞤶𞤫𞤩𞤫),
						'one' => q({0} 𞤶𞤫𞤩),
						'other' => q({0} 𞤶𞤫𞤩),
					},
					# Core Unit Identifier
					'degree' => {
						'name' => q(𞤶𞤫𞤩𞤫),
						'one' => q({0} 𞤶𞤫𞤩),
						'other' => q({0} 𞤶𞤫𞤩),
					},
					# Long Unit Identifier
					'angle-radian' => {
						'name' => q(𞤪𞤢𞤣𞤭𞤴𞤢𞤲𞤶𞤭),
						'one' => q({0} 𞤪𞤢𞤣),
						'other' => q({0} 𞤪𞤢𞤣),
					},
					# Core Unit Identifier
					'radian' => {
						'name' => q(𞤪𞤢𞤣𞤭𞤴𞤢𞤲𞤶𞤭),
						'one' => q({0} 𞤪𞤢𞤣),
						'other' => q({0} 𞤪𞤢𞤣),
					},
					# Long Unit Identifier
					'angle-revolution' => {
						'name' => q(𞤱𞤭𞤣),
						'one' => q({0} 𞤱𞤭𞤣),
						'other' => q({0} 𞤱𞤭𞤣),
					},
					# Core Unit Identifier
					'revolution' => {
						'name' => q(𞤱𞤭𞤣),
						'one' => q({0} 𞤱𞤭𞤣),
						'other' => q({0} 𞤱𞤭𞤣),
					},
					# Long Unit Identifier
					'area-acre' => {
						'name' => q(𞤺𞤢𞤪𞤳𞤭),
						'one' => q({0} 𞤺𞤢),
						'other' => q({0} 𞤺𞤢),
					},
					# Core Unit Identifier
					'acre' => {
						'name' => q(𞤺𞤢𞤪𞤳𞤭),
						'one' => q({0} 𞤺𞤢),
						'other' => q({0} 𞤺𞤢),
					},
					# Long Unit Identifier
					'area-dunam' => {
						'name' => q(𞤣𞤵𞥅𞤲𞤢𞤥𞤭),
						'one' => q({0} 𞤣𞤵𞥅𞤲𞤢𞤥𞤵),
						'other' => q({0} 𞤣𞤵𞥅𞤲𞤢𞤥𞤭),
					},
					# Core Unit Identifier
					'dunam' => {
						'name' => q(𞤣𞤵𞥅𞤲𞤢𞤥𞤭),
						'one' => q({0} 𞤣𞤵𞥅𞤲𞤢𞤥𞤵),
						'other' => q({0} 𞤣𞤵𞥅𞤲𞤢𞤥𞤭),
					},
					# Long Unit Identifier
					'area-hectare' => {
						'name' => q(𞤸𞤫𞤳𞤼𞤢𞤪𞤯𞤫),
						'one' => q({0} 𞤸𞤢),
						'other' => q({0} 𞤸𞤢),
					},
					# Core Unit Identifier
					'hectare' => {
						'name' => q(𞤸𞤫𞤳𞤼𞤢𞤪𞤯𞤫),
						'one' => q({0} 𞤸𞤢),
						'other' => q({0} 𞤸𞤢),
					},
					# Long Unit Identifier
					'area-square-centimeter' => {
						'name' => q(𞤧𞤥𞥒),
						'one' => q({0} 𞤧𞤥𞥒),
						'other' => q({0} 𞤧𞤥𞥒),
						'per' => q({0}/𞤧𞤥𞥒),
					},
					# Core Unit Identifier
					'square-centimeter' => {
						'name' => q(𞤧𞤥𞥒),
						'one' => q({0} 𞤧𞤥𞥒),
						'other' => q({0} 𞤧𞤥𞥒),
						'per' => q({0}/𞤧𞤥𞥒),
					},
					# Long Unit Identifier
					'area-square-foot' => {
						'name' => q(𞤣𞤺 𞤼𞤫𞤨𞥆𞤭),
						'one' => q({0} 𞤣𞤺 𞤼𞤨),
						'other' => q({0} 𞤣𞤺 𞤼𞤨),
					},
					# Core Unit Identifier
					'square-foot' => {
						'name' => q(𞤣𞤺 𞤼𞤫𞤨𞥆𞤭),
						'one' => q({0} 𞤣𞤺 𞤼𞤨),
						'other' => q({0} 𞤣𞤺 𞤼𞤨),
					},
					# Long Unit Identifier
					'area-square-inch' => {
						'name' => q(𞤲𞤺𞤮𞤪𞤰𞤭𞥒),
						'one' => q({0} 𞤺𞤮𞥒),
						'other' => q({0} 𞤺𞤮𞥒),
						'per' => q({0}/𞤺𞤮𞥒),
					},
					# Core Unit Identifier
					'square-inch' => {
						'name' => q(𞤲𞤺𞤮𞤪𞤰𞤭𞥒),
						'one' => q({0} 𞤺𞤮𞥒),
						'other' => q({0} 𞤺𞤮𞥒),
						'per' => q({0}/𞤺𞤮𞥒),
					},
					# Long Unit Identifier
					'area-square-kilometer' => {
						'name' => q(𞤳𞤥𞥒),
						'one' => q({0} 𞤳𞤥𞥒),
						'other' => q({0} 𞤳𞤥𞥒),
						'per' => q({0}/𞤳𞤥𞥒),
					},
					# Core Unit Identifier
					'square-kilometer' => {
						'name' => q(𞤳𞤥𞥒),
						'one' => q({0} 𞤳𞤥𞥒),
						'other' => q({0} 𞤳𞤥𞥒),
						'per' => q({0}/𞤳𞤥𞥒),
					},
					# Long Unit Identifier
					'area-square-meter' => {
						'name' => q(𞤥𞤫𞥅𞤼𞤭𞥒),
						'one' => q({0} 𞤥𞥒),
						'other' => q({0} 𞤥𞥒),
						'per' => q({0}/𞤥𞥒),
					},
					# Core Unit Identifier
					'square-meter' => {
						'name' => q(𞤥𞤫𞥅𞤼𞤭𞥒),
						'one' => q({0} 𞤥𞥒),
						'other' => q({0} 𞤥𞥒),
						'per' => q({0}/𞤥𞥒),
					},
					# Long Unit Identifier
					'area-square-mile' => {
						'name' => q(𞤣𞤺 𞤥𞤢𞤴𞤤𞤭),
						'one' => q({0} 𞤥𞤢 𞤣𞤺),
						'other' => q({0} 𞤥𞤢 𞤣𞤺),
						'per' => q({0}/𞤥𞤢𞥒),
					},
					# Core Unit Identifier
					'square-mile' => {
						'name' => q(𞤣𞤺 𞤥𞤢𞤴𞤤𞤭),
						'one' => q({0} 𞤥𞤢 𞤣𞤺),
						'other' => q({0} 𞤥𞤢 𞤣𞤺),
						'per' => q({0}/𞤥𞤢𞥒),
					},
					# Long Unit Identifier
					'area-square-yard' => {
						'name' => q(𞤧𞤮𞤺𞤮𞤲𞤫𞥒),
						'one' => q({0} 𞤧𞤮𞥒),
						'other' => q({0} 𞤧𞤮𞥒),
					},
					# Core Unit Identifier
					'square-yard' => {
						'name' => q(𞤧𞤮𞤺𞤮𞤲𞤫𞥒),
						'one' => q({0} 𞤧𞤮𞥒),
						'other' => q({0} 𞤧𞤮𞥒),
					},
					# Long Unit Identifier
					'coordinate' => {
						'east' => q({0} 𞤊),
						'north' => q({0} 𞤐),
						'south' => q({0} 𞤙),
						'west' => q({0} 𞤖),
					},
					# Core Unit Identifier
					'coordinate' => {
						'east' => q({0} 𞤊),
						'north' => q({0} 𞤐),
						'south' => q({0} 𞤙),
						'west' => q({0} 𞤖),
					},
					# Long Unit Identifier
					'digital-bit' => {
						'name' => q(𞤦𞤭𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤦),
						'other' => q({0} 𞤦),
					},
					# Core Unit Identifier
					'bit' => {
						'name' => q(𞤦𞤭𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤦),
						'other' => q({0} 𞤦),
					},
					# Long Unit Identifier
					'digital-byte' => {
						'name' => q(𞤶𞤫𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤔),
						'other' => q({0} 𞤔),
					},
					# Core Unit Identifier
					'byte' => {
						'name' => q(𞤶𞤫𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤔),
						'other' => q({0} 𞤔),
					},
					# Long Unit Identifier
					'digital-gigabit' => {
						'name' => q(𞤘𞤦𞤭𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤘𞤦),
						'other' => q({0} 𞤘𞤦),
					},
					# Core Unit Identifier
					'gigabit' => {
						'name' => q(𞤘𞤦𞤭𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤘𞤦),
						'other' => q({0} 𞤘𞤦),
					},
					# Long Unit Identifier
					'digital-gigabyte' => {
						'name' => q(𞤘𞤔𞤫𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤘𞤔),
						'other' => q({0} 𞤘𞤔),
					},
					# Core Unit Identifier
					'gigabyte' => {
						'name' => q(𞤘𞤔𞤫𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤘𞤔),
						'other' => q({0} 𞤘𞤔),
					},
					# Long Unit Identifier
					'digital-kilobit' => {
						'name' => q(𞤳𞤦𞤭𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤳𞤦),
						'other' => q({0} 𞤳𞤦),
					},
					# Core Unit Identifier
					'kilobit' => {
						'name' => q(𞤳𞤦𞤭𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤳𞤦),
						'other' => q({0} 𞤳𞤦),
					},
					# Long Unit Identifier
					'digital-kilobyte' => {
						'name' => q(𞤳𞤔𞤫𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤳𞤔),
						'other' => q({0} 𞤳𞤔),
					},
					# Core Unit Identifier
					'kilobyte' => {
						'name' => q(𞤳𞤔𞤫𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤳𞤔),
						'other' => q({0} 𞤳𞤔),
					},
					# Long Unit Identifier
					'digital-megabit' => {
						'name' => q(𞤃𞤦𞤭𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤃𞤦),
						'other' => q({0} 𞤃𞤦),
					},
					# Core Unit Identifier
					'megabit' => {
						'name' => q(𞤃𞤦𞤭𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤃𞤦),
						'other' => q({0} 𞤃𞤦),
					},
					# Long Unit Identifier
					'digital-megabyte' => {
						'name' => q(𞤃𞤔𞤫𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤃𞤔),
						'other' => q({0} 𞤃𞤔),
					},
					# Core Unit Identifier
					'megabyte' => {
						'name' => q(𞤃𞤔𞤫𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤃𞤔),
						'other' => q({0} 𞤃𞤔),
					},
					# Long Unit Identifier
					'digital-petabyte' => {
						'name' => q(𞤆𞤔𞤫𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤆𞤔),
						'other' => q({0} 𞤆𞤔),
					},
					# Core Unit Identifier
					'petabyte' => {
						'name' => q(𞤆𞤔𞤫𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤆𞤔),
						'other' => q({0} 𞤆𞤔),
					},
					# Long Unit Identifier
					'digital-terabit' => {
						'name' => q(𞤚𞤦𞤭𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤚𞤦),
						'other' => q({0} 𞤚𞤦),
					},
					# Core Unit Identifier
					'terabit' => {
						'name' => q(𞤚𞤦𞤭𞥅𞤼𞥆𞤭),
						'one' => q({0} 𞤚𞤦),
						'other' => q({0} 𞤚𞤦),
					},
					# Long Unit Identifier
					'digital-terabyte' => {
						'name' => q(𞤚𞤔𞤫𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤚𞤔),
						'other' => q({0} 𞤚𞤔),
					},
					# Core Unit Identifier
					'terabyte' => {
						'name' => q(𞤚𞤔𞤫𞥅𞤼𞥆𞤵),
						'one' => q({0} 𞤚𞤔),
						'other' => q({0} 𞤚𞤔),
					},
					# Long Unit Identifier
					'duration-century' => {
						'name' => q(𞤼),
						'one' => q({0} 𞤼),
						'other' => q({0} 𞤼),
					},
					# Core Unit Identifier
					'century' => {
						'name' => q(𞤼),
						'one' => q({0} 𞤼),
						'other' => q({0} 𞤼),
					},
					# Long Unit Identifier
					'duration-day' => {
						'name' => q(𞤻𞤢𞤤.),
						'one' => q({0} 𞤻𞤢𞤤.),
						'other' => q({0} 𞤻𞤢𞤤.),
						'per' => q({0}/𞤻𞤢𞤤.),
					},
					# Core Unit Identifier
					'day' => {
						'name' => q(𞤻𞤢𞤤.),
						'one' => q({0} 𞤻𞤢𞤤.),
						'other' => q({0} 𞤻𞤢𞤤.),
						'per' => q({0}/𞤻𞤢𞤤.),
					},
					# Long Unit Identifier
					'duration-decade' => {
						'name' => q(𞤼𞤭𞤶),
						'one' => q({0} 𞤼𞤭𞤶),
						'other' => q({0} 𞤼𞤭𞤶),
					},
					# Core Unit Identifier
					'decade' => {
						'name' => q(𞤼𞤭𞤶),
						'one' => q({0} 𞤼𞤭𞤶),
						'other' => q({0} 𞤼𞤭𞤶),
					},
					# Long Unit Identifier
					'duration-hour' => {
						'name' => q(𞤲𞤶𞤢𞤥𞤤𞤭),
						'one' => q({0} 𞤶𞤢),
						'other' => q({0} 𞤶𞤢),
						'per' => q({0}/𞤶),
					},
					# Core Unit Identifier
					'hour' => {
						'name' => q(𞤲𞤶𞤢𞤥𞤤𞤭),
						'one' => q({0} 𞤶𞤢),
						'other' => q({0} 𞤶𞤢),
						'per' => q({0}/𞤶),
					},
					# Long Unit Identifier
					'duration-microsecond' => {
						'name' => q(𞤻𞤳𞤭𞤲),
						'one' => q({0} 𞤻𞤳𞤭𞤲),
						'other' => q({0} 𞤻𞤳𞤭𞤲),
					},
					# Core Unit Identifier
					'microsecond' => {
						'name' => q(𞤻𞤳𞤭𞤲),
						'one' => q({0} 𞤻𞤳𞤭𞤲),
						'other' => q({0} 𞤻𞤳𞤭𞤲),
					},
					# Long Unit Identifier
					'duration-millisecond' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤳𞤭𞤲),
						'one' => q({0} 𞤥𞤳𞤭𞤲),
						'other' => q({0} 𞤥𞤳𞤭𞤲),
					},
					# Core Unit Identifier
					'millisecond' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤳𞤭𞤲),
						'one' => q({0} 𞤥𞤳𞤭𞤲),
						'other' => q({0} 𞤥𞤳𞤭𞤲),
					},
					# Long Unit Identifier
					'duration-minute' => {
						'name' => q(𞤸𞤮𞤶),
						'one' => q({0} 𞤸𞤮𞤶),
						'other' => q({0} 𞤸𞤮𞤶),
						'per' => q({0}/𞤸𞤮𞤶),
					},
					# Core Unit Identifier
					'minute' => {
						'name' => q(𞤸𞤮𞤶),
						'one' => q({0} 𞤸𞤮𞤶),
						'other' => q({0} 𞤸𞤮𞤶),
						'per' => q({0}/𞤸𞤮𞤶),
					},
					# Long Unit Identifier
					'duration-month' => {
						'name' => q(𞤤𞤫𞤦𞥆𞤭),
						'one' => q({0}/𞤤𞤫𞤱),
						'other' => q({0} 𞤤𞤫𞤦),
						'per' => q({0}/𞤤𞤫𞤱),
					},
					# Core Unit Identifier
					'month' => {
						'name' => q(𞤤𞤫𞤦𞥆𞤭),
						'one' => q({0}/𞤤𞤫𞤱),
						'other' => q({0} 𞤤𞤫𞤦),
						'per' => q({0}/𞤤𞤫𞤱),
					},
					# Long Unit Identifier
					'duration-nanosecond' => {
						'name' => q(𞤲𞤳𞤭𞤲),
						'one' => q({0} 𞤲𞤳𞤭𞤲),
						'other' => q({0} 𞤲𞤳𞤭𞤲),
					},
					# Core Unit Identifier
					'nanosecond' => {
						'name' => q(𞤲𞤳𞤭𞤲),
						'one' => q({0} 𞤲𞤳𞤭𞤲),
						'other' => q({0} 𞤲𞤳𞤭𞤲),
					},
					# Long Unit Identifier
					'duration-second' => {
						'name' => q(𞤳𞤭𞤲),
						'one' => q({0} 𞤳𞤭𞤲),
						'other' => q({0} 𞤳𞤭𞤲),
						'per' => q({0}/𞤳𞤭𞤲),
					},
					# Core Unit Identifier
					'second' => {
						'name' => q(𞤳𞤭𞤲),
						'one' => q({0} 𞤳𞤭𞤲),
						'other' => q({0} 𞤳𞤭𞤲),
						'per' => q({0}/𞤳𞤭𞤲),
					},
					# Long Unit Identifier
					'duration-week' => {
						'name' => q(𞤶𞤼),
						'one' => q({0} 𞤴𞤼),
						'other' => q({0} 𞤶𞤼),
						'per' => q({0}/𞤴𞤼),
					},
					# Core Unit Identifier
					'week' => {
						'name' => q(𞤶𞤼),
						'one' => q({0} 𞤴𞤼),
						'other' => q({0} 𞤶𞤼),
						'per' => q({0}/𞤴𞤼),
					},
					# Long Unit Identifier
					'duration-year' => {
						'name' => q(𞤳𞤭𞤼𞤢𞥄𞤯𞤫),
						'one' => q({0} 𞤸𞤭𞤼),
						'other' => q({0} 𞤳𞤭𞤼),
						'per' => q({0}/𞤸𞤭𞤼𞤢𞥄𞤲𞥋𞤣𞤫),
					},
					# Core Unit Identifier
					'year' => {
						'name' => q(𞤳𞤭𞤼𞤢𞥄𞤯𞤫),
						'one' => q({0} 𞤸𞤭𞤼),
						'other' => q({0} 𞤳𞤭𞤼),
						'per' => q({0}/𞤸𞤭𞤼𞤢𞥄𞤲𞥋𞤣𞤫),
					},
					# Long Unit Identifier
					'electric-ampere' => {
						'name' => q(𞤢𞤥𞤨𞤫𞤪𞤶𞤭),
						'one' => q({0} 𞤀),
						'other' => q({0} 𞤀),
					},
					# Core Unit Identifier
					'ampere' => {
						'name' => q(𞤢𞤥𞤨𞤫𞤪𞤶𞤭),
						'one' => q({0} 𞤀),
						'other' => q({0} 𞤀),
					},
					# Long Unit Identifier
					'electric-milliampere' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤢𞤥𞤨𞤫𞤪𞤶𞤭),
						'one' => q({0} 𞤥𞤀),
						'other' => q({0} 𞤥𞤀),
					},
					# Core Unit Identifier
					'milliampere' => {
						'name' => q(𞤥𞤭𞤤𞤭𞤢𞤥𞤨𞤫𞤪𞤶𞤭),
						'one' => q({0} 𞤥𞤀),
						'other' => q({0} 𞤥𞤀),
					},
					# Long Unit Identifier
					'electric-ohm' => {
						'name' => q(𞤮𞤸𞤥𞤵𞥅𞤶𞤭),
						'one' => q({0} Ω),
						'other' => q({0} Ω),
					},
					# Core Unit Identifier
					'ohm' => {
						'name' => q(𞤮𞤸𞤥𞤵𞥅𞤶𞤭),
						'one' => q({0} Ω),
						'other' => q({0} Ω),
					},
					# Long Unit Identifier
					'electric-volt' => {
						'name' => q(𞤾𞤮𞤤𞤼𞤵𞥅𞤶𞤭),
						'one' => q({0} 𞤜),
						'other' => q({0} 𞤜),
					},
					# Core Unit Identifier
					'volt' => {
						'name' => q(𞤾𞤮𞤤𞤼𞤵𞥅𞤶𞤭),
						'one' => q({0} 𞤜),
						'other' => q({0} 𞤜),
					},
					# Long Unit Identifier
					'energy-british-thermal-unit' => {
						'name' => q(𞤑𞤘𞤄),
						'one' => q({0} 𞤑𞤺𞤦),
						'other' => q({0} 𞤑𞤺𞤦),
					},
					# Core Unit Identifier
					'british-thermal-unit' => {
						'name' => q(𞤑𞤘𞤄),
						'one' => q({0} 𞤑𞤺𞤦),
						'other' => q({0} 𞤑𞤺𞤦),
					},
					# Long Unit Identifier
					'energy-calorie' => {
						'name' => q(𞤺𞤵𞤤),
						'one' => q({0} 𞤺𞤵𞤤),
						'other' => q({0} 𞤺𞤵𞤤),
					},
					# Core Unit Identifier
					'calorie' => {
						'name' => q(𞤺𞤵𞤤),
						'one' => q({0} 𞤺𞤵𞤤),
						'other' => q({0} 𞤺𞤵𞤤),
					},
					# Long Unit Identifier
					'energy-electronvolt' => {
						'name' => q(𞤫𞤤𞤫𞤳𞤼𞤮𞤾𞤮𞤤𞤼𞤵),
						'one' => q({0} 𞤫𞤜),
						'other' => q({0} 𞤫𞤜),
					},
					# Core Unit Identifier
					'electronvolt' => {
						'name' => q(𞤫𞤤𞤫𞤳𞤼𞤮𞤾𞤮𞤤𞤼𞤵),
						'one' => q({0} 𞤫𞤜),
						'other' => q({0} 𞤫𞤜),
					},
					# Long Unit Identifier
					'energy-foodcalorie' => {
						'name' => q(𞤺𞤵𞤤),
						'one' => q({0} 𞤺𞤵𞤤),
						'other' => q({0} 𞤺𞤵𞤤),
					},
					# Core Unit Identifier
					'foodcalorie' => {
						'name' => q(𞤺𞤵𞤤),
						'one' => q({0} 𞤺𞤵𞤤),
						'other' => q({0} 𞤺𞤵𞤤),
					},
					# Long Unit Identifier
					'energy-joule' => {
						'name' => q(𞥁𞤵𞥅𞤤𞤶𞤭),
						'one' => q({0} 𞤟),
						'other' => q({0} 𞤟),
					},
					# Core Unit Identifier
					'joule' => {
						'name' => q(𞥁𞤵𞥅𞤤𞤶𞤭),
						'one' => q({0} 𞤟),
						'other' => q({0} 𞤟),
					},
					# Long Unit Identifier
					'energy-kilocalorie' => {
						'name' => q(𞤳𞤺𞤵𞤤),
						'one' => q({0} 𞤳𞤺𞤵𞤤),
						'other' => q({0} 𞤳𞤺𞤵𞤤),
					},
					# Core Unit Identifier
					'kilocalorie' => {
						'name' => q(𞤳𞤺𞤵𞤤),
						'one' => q({0} 𞤳𞤺𞤵𞤤),
						'other' => q({0} 𞤳𞤺𞤵𞤤),
					},
					# Long Unit Identifier
					'energy-kilojoule' => {
						'name' => q(𞤳𞤭𞤤𞤮𞥁𞤵𞥅𞤤𞤱𞤵),
						'one' => q({0} 𞤳𞥁),
						'other' => q({0} 𞤳𞥁),
					},
					# Core Unit Identifier
					'kilojoule' => {
						'name' => q(𞤳𞤭𞤤𞤮𞥁𞤵𞥅𞤤𞤱𞤵),
						'one' => q({0} 𞤳𞥁),
						'other' => q({0} 𞤳𞥁),
					},
					# Long Unit Identifier
					'energy-kilowatt-hour' => {
						'name' => q(𞤳𞤏-𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'one' => q({0} 𞤳𞤏𞤶),
						'other' => q({0} 𞤳𞤏𞤶),
					},
					# Core Unit Identifier
					'kilowatt-hour' => {
						'name' => q(𞤳𞤏-𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'one' => q({0} 𞤳𞤏𞤶),
						'other' => q({0} 𞤳𞤏𞤶),
					},
					# Long Unit Identifier
					'energy-therm-us' => {
						'name' => q(𞤲𞤺𞤵𞤤𞤣𞤭𞤲𞤳𞤮 𞤁𞤀),
						'one' => q({0} 𞤲𞤺𞤣𞤳𞤮 𞤁𞤀),
						'other' => q({0} 𞤲𞤺𞤣𞤳𞤮 𞤁𞤀),
					},
					# Core Unit Identifier
					'therm-us' => {
						'name' => q(𞤲𞤺𞤵𞤤𞤣𞤭𞤲𞤳𞤮 𞤁𞤀),
						'one' => q({0} 𞤲𞤺𞤣𞤳𞤮 𞤁𞤀),
						'other' => q({0} 𞤲𞤺𞤣𞤳𞤮 𞤁𞤀),
					},
					# Long Unit Identifier
					'force-newton' => {
						'name' => q(𞤲𞤫𞤱𞤼𞤮𞤲),
						'one' => q({0} 𞤐),
						'other' => q({0} 𞤐),
					},
					# Core Unit Identifier
					'newton' => {
						'name' => q(𞤲𞤫𞤱𞤼𞤮𞤲),
						'one' => q({0} 𞤐),
						'other' => q({0} 𞤐),
					},
					# Long Unit Identifier
					'frequency-gigahertz' => {
						'name' => q(𞤘𞤖𞤪),
						'one' => q({0} 𞤘𞤖𞤪),
						'other' => q({0} 𞤘𞤖𞤪),
					},
					# Core Unit Identifier
					'gigahertz' => {
						'name' => q(𞤘𞤖𞤪),
						'one' => q({0} 𞤘𞤖𞤪),
						'other' => q({0} 𞤘𞤖𞤪),
					},
					# Long Unit Identifier
					'frequency-hertz' => {
						'name' => q(𞤖𞤪),
						'one' => q({0} 𞤖𞤪),
						'other' => q({0} 𞤖𞤪),
					},
					# Core Unit Identifier
					'hertz' => {
						'name' => q(𞤖𞤪),
						'one' => q({0} 𞤖𞤪),
						'other' => q({0} 𞤖𞤪),
					},
					# Long Unit Identifier
					'frequency-kilohertz' => {
						'name' => q(𞤳𞤖𞤪),
						'one' => q({0} 𞤳𞤖𞤪),
						'other' => q({0} 𞤳𞤖𞤪),
					},
					# Core Unit Identifier
					'kilohertz' => {
						'name' => q(𞤳𞤖𞤪),
						'one' => q({0} 𞤳𞤖𞤪),
						'other' => q({0} 𞤳𞤖𞤪),
					},
					# Long Unit Identifier
					'frequency-megahertz' => {
						'name' => q(𞤃𞤖𞤪),
						'one' => q({0} 𞤃𞤖𞤪),
						'other' => q({0} 𞤃𞤖𞤪),
					},
					# Core Unit Identifier
					'megahertz' => {
						'name' => q(𞤃𞤖𞤪),
						'one' => q({0} 𞤃𞤖𞤪),
						'other' => q({0} 𞤃𞤖𞤪),
					},
					# Long Unit Identifier
					'graphics-dot' => {
						'name' => q(𞤼𞤮𞤩𞥆𞤫𞤪𞤫),
						'one' => q({0} 𞤼𞤮𞤩𞥆𞤫𞤪𞤫),
						'other' => q({0} 𞤼𞤮𞤩𞥆𞤫𞤪𞤫),
					},
					# Core Unit Identifier
					'dot' => {
						'name' => q(𞤼𞤮𞤩𞥆𞤫𞤪𞤫),
						'one' => q({0} 𞤼𞤮𞤩𞥆𞤫𞤪𞤫),
						'other' => q({0} 𞤼𞤮𞤩𞥆𞤫𞤪𞤫),
					},
					# Long Unit Identifier
					'graphics-dot-per-centimeter' => {
						'name' => q(𞤼𞤩𞤧𞤥),
						'one' => q({0} 𞤼𞤩𞤧𞤥),
						'other' => q({0} 𞤼𞤩𞤧𞤥),
					},
					# Core Unit Identifier
					'dot-per-centimeter' => {
						'name' => q(𞤼𞤩𞤧𞤥),
						'one' => q({0} 𞤼𞤩𞤧𞤥),
						'other' => q({0} 𞤼𞤩𞤧𞤥),
					},
					# Long Unit Identifier
					'graphics-dot-per-inch' => {
						'name' => q(𞤼𞤩𞤺𞤰),
						'one' => q({0} 𞤼𞤩𞤺𞤰),
						'other' => q({0} 𞤼𞤩𞤺𞤰),
					},
					# Core Unit Identifier
					'dot-per-inch' => {
						'name' => q(𞤼𞤩𞤺𞤰),
						'one' => q({0} 𞤼𞤩𞤺𞤰),
						'other' => q({0} 𞤼𞤩𞤺𞤰),
					},
					# Long Unit Identifier
					'graphics-em' => {
						'name' => q(𞤭𞤥𞤵),
						'one' => q({0} 𞤭𞤥𞤵),
						'other' => q({0} 𞤭𞤥𞤵),
					},
					# Core Unit Identifier
					'em' => {
						'name' => q(𞤭𞤥𞤵),
						'one' => q({0} 𞤭𞤥𞤵),
						'other' => q({0} 𞤭𞤥𞤵),
					},
					# Long Unit Identifier
					'graphics-megapixel' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤨𞤭𞤳𞤷𞤭),
						'one' => q({0} 𞤃𞤆),
						'other' => q({0} 𞤃𞤆),
					},
					# Core Unit Identifier
					'megapixel' => {
						'name' => q(𞤥𞤫𞤺𞤢𞤨𞤭𞤳𞤷𞤭),
						'one' => q({0} 𞤃𞤆),
						'other' => q({0} 𞤃𞤆),
					},
					# Long Unit Identifier
					'graphics-pixel' => {
						'name' => q(𞤨𞤭𞤳𞤷𞤭),
						'one' => q({0} 𞤨𞤳),
						'other' => q({0} 𞤨𞤳),
					},
					# Core Unit Identifier
					'pixel' => {
						'name' => q(𞤨𞤭𞤳𞤷𞤭),
						'one' => q({0} 𞤨𞤳),
						'other' => q({0} 𞤨𞤳),
					},
					# Long Unit Identifier
					'graphics-pixel-per-centimeter' => {
						'name' => q(𞤨𞤳𞤣𞤧𞤥),
						'one' => q({0} 𞤨𞤳𞤣𞤧𞤥),
						'other' => q({0} 𞤨𞤳𞤣𞤧𞤥),
					},
					# Core Unit Identifier
					'pixel-per-centimeter' => {
						'name' => q(𞤨𞤳𞤣𞤧𞤥),
						'one' => q({0} 𞤨𞤳𞤣𞤧𞤥),
						'other' => q({0} 𞤨𞤳𞤣𞤧𞤥),
					},
					# Long Unit Identifier
					'graphics-pixel-per-inch' => {
						'name' => q(𞤨𞤳𞤣𞤺𞤰),
						'one' => q({0} 𞤨𞤳𞤣𞤺𞤰),
						'other' => q({0} 𞤨𞤳𞤣𞤺𞤰),
					},
					# Core Unit Identifier
					'pixel-per-inch' => {
						'name' => q(𞤨𞤳𞤣𞤺𞤰),
						'one' => q({0} 𞤨𞤳𞤣𞤺𞤰),
						'other' => q({0} 𞤨𞤳𞤣𞤺𞤰),
					},
					# Long Unit Identifier
					'length-astronomical-unit' => {
						'name' => q(𞤳𞤵),
						'one' => q({0} 𞤳𞤵),
						'other' => q({0} 𞤳𞤵),
					},
					# Core Unit Identifier
					'astronomical-unit' => {
						'name' => q(𞤳𞤵),
						'one' => q({0} 𞤳𞤵),
						'other' => q({0} 𞤳𞤵),
					},
					# Long Unit Identifier
					'length-centimeter' => {
						'name' => q(𞤧𞤥),
						'one' => q({0} 𞤧𞤥),
						'other' => q({0} 𞤧𞤥),
						'per' => q({0}/𞤧𞤥),
					},
					# Core Unit Identifier
					'centimeter' => {
						'name' => q(𞤧𞤥),
						'one' => q({0} 𞤧𞤥),
						'other' => q({0} 𞤧𞤥),
						'per' => q({0}/𞤧𞤥),
					},
					# Long Unit Identifier
					'length-decimeter' => {
						'name' => q(𞤣𞤥),
						'one' => q({0} 𞤣𞤥),
						'other' => q({0} 𞤣𞤥),
					},
					# Core Unit Identifier
					'decimeter' => {
						'name' => q(𞤣𞤥),
						'one' => q({0} 𞤣𞤥),
						'other' => q({0} 𞤣𞤥),
					},
					# Long Unit Identifier
					'length-earth-radius' => {
						'name' => q(𞤂⊕),
						'one' => q({0} 𞤂⊕),
						'other' => q({0} 𞤂⊕),
					},
					# Core Unit Identifier
					'earth-radius' => {
						'name' => q(𞤂⊕),
						'one' => q({0} 𞤂⊕),
						'other' => q({0} 𞤂⊕),
					},
					# Long Unit Identifier
					'length-foot' => {
						'name' => q(𞤼𞤨),
						'one' => q({0} 𞤼𞤨),
						'other' => q({0} 𞤼𞤨),
						'per' => q({0}/𞤼𞤨),
					},
					# Core Unit Identifier
					'foot' => {
						'name' => q(𞤼𞤨),
						'one' => q({0} 𞤼𞤨),
						'other' => q({0} 𞤼𞤨),
						'per' => q({0}/𞤼𞤨),
					},
					# Long Unit Identifier
					'length-inch' => {
						'name' => q(𞤲𞤺𞤮𞤪𞤰𞤭),
						'one' => q({0} 𞤺𞤮),
						'other' => q({0} 𞤺𞤮),
						'per' => q({0}/𞤺𞤮),
					},
					# Core Unit Identifier
					'inch' => {
						'name' => q(𞤲𞤺𞤮𞤪𞤰𞤭),
						'one' => q({0} 𞤺𞤮),
						'other' => q({0} 𞤺𞤮),
						'per' => q({0}/𞤺𞤮),
					},
					# Long Unit Identifier
					'length-kilometer' => {
						'name' => q(𞤳𞤥),
						'one' => q({0} 𞤳𞤥),
						'other' => q({0} 𞤳𞤥),
						'per' => q({0}/𞤳𞤥),
					},
					# Core Unit Identifier
					'kilometer' => {
						'name' => q(𞤳𞤥),
						'one' => q({0} 𞤳𞤥),
						'other' => q({0} 𞤳𞤥),
						'per' => q({0}/𞤳𞤥),
					},
					# Long Unit Identifier
					'length-light-year' => {
						'name' => q(𞤳𞤣),
						'one' => q({0} 𞤸𞤣),
						'other' => q({0} 𞤳𞤣),
					},
					# Core Unit Identifier
					'light-year' => {
						'name' => q(𞤳𞤣),
						'one' => q({0} 𞤸𞤣),
						'other' => q({0} 𞤳𞤣),
					},
					# Long Unit Identifier
					'length-meter' => {
						'name' => q(𞤥),
						'one' => q({0} 𞤥),
						'other' => q({0} 𞤥),
						'per' => q({0}/𞤥),
					},
					# Core Unit Identifier
					'meter' => {
						'name' => q(𞤥),
						'one' => q({0} 𞤥),
						'other' => q({0} 𞤥),
						'per' => q({0}/𞤥),
					},
					# Long Unit Identifier
					'length-micrometer' => {
						'name' => q(𞤻𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤻𞤥),
						'other' => q({0} 𞤻𞤥),
					},
					# Core Unit Identifier
					'micrometer' => {
						'name' => q(𞤻𞤥𞤫𞥅𞤼𞤭),
						'one' => q({0} 𞤻𞤥),
						'other' => q({0} 𞤻𞤥),
					},
					# Long Unit Identifier
					'length-mile' => {
						'name' => q(𞤥𞤢),
						'one' => q({0} 𞤥𞤢),
						'other' => q({0} 𞤥𞤢),
					},
					# Core Unit Identifier
					'mile' => {
						'name' => q(𞤥𞤢),
						'one' => q({0} 𞤥𞤢),
						'other' => q({0} 𞤥𞤢),
					},
					# Long Unit Identifier
					'length-mile-scandinavian' => {
						'name' => q(𞤥𞤢𞤧),
						'one' => q({0} 𞤥𞤢𞤧),
						'other' => q({0} 𞤥𞤢𞤧),
					},
					# Core Unit Identifier
					'mile-scandinavian' => {
						'name' => q(𞤥𞤢𞤧),
						'one' => q({0} 𞤥𞤢𞤧),
						'other' => q({0} 𞤥𞤢𞤧),
					},
					# Long Unit Identifier
					'length-millimeter' => {
						'name' => q(𞤥𞤥),
						'one' => q({0} 𞤥𞤥),
						'other' => q({0} 𞤥𞤥),
					},
					# Core Unit Identifier
					'millimeter' => {
						'name' => q(𞤥𞤥),
						'one' => q({0} 𞤥𞤥),
						'other' => q({0} 𞤥𞤥),
					},
					# Long Unit Identifier
					'length-nanometer' => {
						'name' => q(𞤲𞤥),
						'one' => q({0} 𞤲𞤥),
						'other' => q({0} 𞤲𞤥),
					},
					# Core Unit Identifier
					'nanometer' => {
						'name' => q(𞤲𞤥),
						'one' => q({0} 𞤲𞤥),
						'other' => q({0} 𞤲𞤥),
					},
					# Long Unit Identifier
					'length-nautical-mile' => {
						'name' => q(𞤥𞤢𞤥),
						'one' => q({0} 𞤥𞤢𞤥),
						'other' => q({0} 𞤥𞤢𞤥),
					},
					# Core Unit Identifier
					'nautical-mile' => {
						'name' => q(𞤥𞤢𞤥),
						'one' => q({0} 𞤥𞤢𞤥),
						'other' => q({0} 𞤥𞤢𞤥),
					},
					# Long Unit Identifier
					'length-parsec' => {
						'name' => q(𞤨𞤧),
						'one' => q({0} 𞤨𞤧),
						'other' => q({0} 𞤨𞤧),
					},
					# Core Unit Identifier
					'parsec' => {
						'name' => q(𞤨𞤧),
						'one' => q({0} 𞤨𞤧),
						'other' => q({0} 𞤨𞤧),
					},
					# Long Unit Identifier
					'length-picometer' => {
						'name' => q(𞤨𞤥),
						'one' => q({0} 𞤨𞤥),
						'other' => q({0} 𞤨𞤥),
					},
					# Core Unit Identifier
					'picometer' => {
						'name' => q(𞤨𞤥),
						'one' => q({0} 𞤨𞤥),
						'other' => q({0} 𞤨𞤥),
					},
					# Long Unit Identifier
					'length-point' => {
						'name' => q(𞤶𞤣),
						'one' => q({0} 𞤶𞤣),
						'other' => q({0} 𞤶𞤣),
					},
					# Core Unit Identifier
					'point' => {
						'name' => q(𞤶𞤣),
						'one' => q({0} 𞤶𞤣),
						'other' => q({0} 𞤶𞤣),
					},
					# Long Unit Identifier
					'length-solar-radius' => {
						'name' => q(𞤤𞤢𞥄𞤧𞤮𞤤 𞤲𞤢𞥄𞤲𞤺𞤫𞤴𞤢𞤲𞤳𞤮),
						'one' => q({0} 𞤂☉),
						'other' => q({0} 𞤂☉),
					},
					# Core Unit Identifier
					'solar-radius' => {
						'name' => q(𞤤𞤢𞥄𞤧𞤮𞤤 𞤲𞤢𞥄𞤲𞤺𞤫𞤴𞤢𞤲𞤳𞤮),
						'one' => q({0} 𞤂☉),
						'other' => q({0} 𞤂☉),
					},
					# Long Unit Identifier
					'length-yard' => {
						'name' => q(𞤧𞤮𞤺𞤮𞤲𞤫),
						'one' => q({0} 𞤧𞤮),
						'other' => q({0} 𞤧𞤮),
					},
					# Core Unit Identifier
					'yard' => {
						'name' => q(𞤧𞤮𞤺𞤮𞤲𞤫),
						'one' => q({0} 𞤧𞤮),
						'other' => q({0} 𞤧𞤮),
					},
					# Long Unit Identifier
					'mass-carat' => {
						'name' => q(𞤳𞤭𞤪𞤭𞤪𞤼𞤭),
						'one' => q({0} 𞤑𞤈),
						'other' => q({0} 𞤑𞤈),
					},
					# Core Unit Identifier
					'carat' => {
						'name' => q(𞤳𞤭𞤪𞤭𞤪𞤼𞤭),
						'one' => q({0} 𞤑𞤈),
						'other' => q({0} 𞤑𞤈),
					},
					# Long Unit Identifier
					'mass-dalton' => {
						'name' => q(𞤣𞤢𞤤𞤼𞤮𞥅𞤲𞤭),
						'one' => q({0} 𞤁𞤢),
						'other' => q({0} 𞤁𞤢),
					},
					# Core Unit Identifier
					'dalton' => {
						'name' => q(𞤣𞤢𞤤𞤼𞤮𞥅𞤲𞤭),
						'one' => q({0} 𞤁𞤢),
						'other' => q({0} 𞤁𞤢),
					},
					# Long Unit Identifier
					'mass-earth-mass' => {
						'name' => q(𞤲𞤭𞥅𞤧𞤵𞥅𞤶𞤭 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'one' => q({0} 𞤐⊕),
						'other' => q({0} 𞤐⊕),
					},
					# Core Unit Identifier
					'earth-mass' => {
						'name' => q(𞤲𞤭𞥅𞤧𞤵𞥅𞤶𞤭 𞤤𞤫𞤴𞤣𞤭 𞤲𞤣𞤭𞤲),
						'one' => q({0} 𞤐⊕),
						'other' => q({0} 𞤐⊕),
					},
					# Long Unit Identifier
					'mass-grain' => {
						'name' => q(𞤺𞤢𞤰𞥆𞤫),
						'one' => q({0} 𞤺𞤢𞤰),
						'other' => q({0} 𞤺𞤢𞤰),
					},
					# Core Unit Identifier
					'grain' => {
						'name' => q(𞤺𞤢𞤰𞥆𞤫),
						'one' => q({0} 𞤺𞤢𞤰),
						'other' => q({0} 𞤺𞤢𞤰),
					},
					# Long Unit Identifier
					'mass-gram' => {
						'name' => q(𞤺𞤢𞤪𞤬𞤭),
						'one' => q({0} 𞤺),
						'other' => q({0} 𞤺),
						'per' => q({0}/𞤺),
					},
					# Core Unit Identifier
					'gram' => {
						'name' => q(𞤺𞤢𞤪𞤬𞤭),
						'one' => q({0} 𞤺),
						'other' => q({0} 𞤺),
						'per' => q({0}/𞤺),
					},
					# Long Unit Identifier
					'mass-kilogram' => {
						'name' => q(𞤳𞤺),
						'one' => q({0} 𞤳𞤺),
						'other' => q({0} 𞤳𞤺),
						'per' => q({0}/𞤳𞤺),
					},
					# Core Unit Identifier
					'kilogram' => {
						'name' => q(𞤳𞤺),
						'one' => q({0} 𞤳𞤺),
						'other' => q({0} 𞤳𞤺),
						'per' => q({0}/𞤳𞤺),
					},
					# Long Unit Identifier
					'mass-metric-ton' => {
						'name' => q(𞤼),
						'one' => q({0} 𞤼),
						'other' => q({0} 𞤼),
					},
					# Core Unit Identifier
					'metric-ton' => {
						'name' => q(𞤼),
						'one' => q({0} 𞤼),
						'other' => q({0} 𞤼),
					},
					# Long Unit Identifier
					'mass-microgram' => {
						'name' => q(𞤻𞤺),
						'one' => q({0} 𞤻𞤺),
						'other' => q({0} 𞤻𞤺),
					},
					# Core Unit Identifier
					'microgram' => {
						'name' => q(𞤻𞤺),
						'one' => q({0} 𞤻𞤺),
						'other' => q({0} 𞤻𞤺),
					},
					# Long Unit Identifier
					'mass-milligram' => {
						'name' => q(𞤥𞤺),
						'one' => q({0} 𞤥𞤺),
						'other' => q({0} 𞤥𞤺),
					},
					# Core Unit Identifier
					'milligram' => {
						'name' => q(𞤥𞤺),
						'one' => q({0} 𞤥𞤺),
						'other' => q({0} 𞤥𞤺),
					},
					# Long Unit Identifier
					'mass-ounce' => {
						'name' => q(𞤱𞤺),
						'one' => q({0} 𞤱𞤺),
						'other' => q({0} 𞤱𞤺),
						'per' => q({0}/𞤱𞤺),
					},
					# Core Unit Identifier
					'ounce' => {
						'name' => q(𞤱𞤺),
						'one' => q({0} 𞤱𞤺),
						'other' => q({0} 𞤱𞤺),
						'per' => q({0}/𞤱𞤺),
					},
					# Long Unit Identifier
					'mass-ounce-troy' => {
						'name' => q(𞤱𞤺 𞤥𞤫𞤲𞤳𞤫𞤤𞤣𞤫),
						'one' => q({0} 𞤱𞤺 𞤥𞤳),
						'other' => q({0} 𞤱𞤺 𞤥𞤳),
					},
					# Core Unit Identifier
					'ounce-troy' => {
						'name' => q(𞤱𞤺 𞤥𞤫𞤲𞤳𞤫𞤤𞤣𞤫),
						'one' => q({0} 𞤱𞤺 𞤥𞤳),
						'other' => q({0} 𞤱𞤺 𞤥𞤳),
					},
					# Long Unit Identifier
					'mass-pound' => {
						'name' => q(𞤺𞤢𞤪𞤤𞤭),
						'one' => q({0} 𞤺𞤤),
						'other' => q({0} 𞤺𞤤),
						'per' => q({0}/𞤺𞤤),
					},
					# Core Unit Identifier
					'pound' => {
						'name' => q(𞤺𞤢𞤪𞤤𞤭),
						'one' => q({0} 𞤺𞤤),
						'other' => q({0} 𞤺𞤤),
						'per' => q({0}/𞤺𞤤),
					},
					# Long Unit Identifier
					'mass-solar-mass' => {
						'name' => q(𞤲𞤭𞥅𞤧𞤵𞥅𞤶𞤭 𞤲𞤢𞥄𞤲𞤺𞤫 𞤲𞤺𞤫𞤲),
						'one' => q({0} 𞤐☉),
						'other' => q({0} 𞤐☉),
					},
					# Core Unit Identifier
					'solar-mass' => {
						'name' => q(𞤲𞤭𞥅𞤧𞤵𞥅𞤶𞤭 𞤲𞤢𞥄𞤲𞤺𞤫 𞤲𞤺𞤫𞤲),
						'one' => q({0} 𞤐☉),
						'other' => q({0} 𞤐☉),
					},
					# Long Unit Identifier
					'mass-ton' => {
						'name' => q(𞤼𞤮𞥅𞤲𞤭),
						'one' => q({0} 𞤼𞤲),
						'other' => q({0} 𞤼𞤲),
					},
					# Core Unit Identifier
					'ton' => {
						'name' => q(𞤼𞤮𞥅𞤲𞤭),
						'one' => q({0} 𞤼𞤲),
						'other' => q({0} 𞤼𞤲),
					},
					# Long Unit Identifier
					'per' => {
						'1' => q({0}/{1}),
					},
					# Core Unit Identifier
					'per' => {
						'1' => q({0}/{1}),
					},
					# Long Unit Identifier
					'power-gigawatt' => {
						'name' => q(𞤘𞤏),
						'one' => q({0} 𞤘𞤏),
						'other' => q({0} 𞤘𞤏),
					},
					# Core Unit Identifier
					'gigawatt' => {
						'name' => q(𞤘𞤏),
						'one' => q({0} 𞤘𞤏),
						'other' => q({0} 𞤘𞤏),
					},
					# Long Unit Identifier
					'power-horsepower' => {
						'name' => q(𞤷𞤨),
						'one' => q({0} 𞤷𞤨),
						'other' => q({0} 𞤷𞤨),
					},
					# Core Unit Identifier
					'horsepower' => {
						'name' => q(𞤷𞤨),
						'one' => q({0} 𞤷𞤨),
						'other' => q({0} 𞤷𞤨),
					},
					# Long Unit Identifier
					'power-kilowatt' => {
						'name' => q(𞤳𞤏),
						'one' => q({0} 𞤳𞤏),
						'other' => q({0} 𞤳𞤏),
					},
					# Core Unit Identifier
					'kilowatt' => {
						'name' => q(𞤳𞤏),
						'one' => q({0} 𞤳𞤏),
						'other' => q({0} 𞤳𞤏),
					},
					# Long Unit Identifier
					'power-megawatt' => {
						'name' => q(𞤃𞤏),
						'one' => q({0} 𞤃𞤏),
						'other' => q({0} 𞤃𞤏),
					},
					# Core Unit Identifier
					'megawatt' => {
						'name' => q(𞤃𞤏),
						'one' => q({0} 𞤃𞤏),
						'other' => q({0} 𞤃𞤏),
					},
					# Long Unit Identifier
					'power-milliwatt' => {
						'name' => q(𞤥𞤏),
						'one' => q({0} 𞤥𞤏),
						'other' => q({0} 𞤥𞤏),
					},
					# Core Unit Identifier
					'milliwatt' => {
						'name' => q(𞤥𞤏),
						'one' => q({0} 𞤥𞤏),
						'other' => q({0} 𞤥𞤏),
					},
					# Long Unit Identifier
					'power-watt' => {
						'name' => q(𞤱𞤢𞥄𞤼𞤭),
						'one' => q({0} 𞤏),
						'other' => q({0} 𞤏),
					},
					# Core Unit Identifier
					'watt' => {
						'name' => q(𞤱𞤢𞥄𞤼𞤭),
						'one' => q({0} 𞤏),
						'other' => q({0} 𞤏),
					},
					# Long Unit Identifier
					'power2' => {
						'one' => q({0}𞥒),
						'other' => q({0}𞥒),
					},
					# Core Unit Identifier
					'power2' => {
						'one' => q({0}𞥒),
						'other' => q({0}𞥒),
					},
					# Long Unit Identifier
					'power3' => {
						'one' => q({0}𞥓),
						'other' => q({0}𞥓),
					},
					# Core Unit Identifier
					'power3' => {
						'one' => q({0}𞥓),
						'other' => q({0}𞥓),
					},
					# Long Unit Identifier
					'pressure-atmosphere' => {
						'name' => q(𞤦𞤫𞤧),
						'one' => q({0} 𞤦𞤫𞤧),
						'other' => q({0} 𞤦𞤫𞤧),
					},
					# Core Unit Identifier
					'atmosphere' => {
						'name' => q(𞤦𞤫𞤧),
						'one' => q({0} 𞤦𞤫𞤧),
						'other' => q({0} 𞤦𞤫𞤧),
					},
					# Long Unit Identifier
					'pressure-bar' => {
						'name' => q(𞤦𞤢𞤪𞤤𞤵),
						'one' => q({0} 𞤦𞤢𞤪),
						'other' => q({0} 𞤦𞤢𞤪),
					},
					# Core Unit Identifier
					'bar' => {
						'name' => q(𞤦𞤢𞤪𞤤𞤵),
						'one' => q({0} 𞤦𞤢𞤪),
						'other' => q({0} 𞤦𞤢𞤪),
					},
					# Long Unit Identifier
					'pressure-hectopascal' => {
						'name' => q(𞤸𞤆𞤢),
						'one' => q({0} 𞤸𞤆𞤢),
						'other' => q({0} 𞤸𞤆𞤢),
					},
					# Core Unit Identifier
					'hectopascal' => {
						'name' => q(𞤸𞤆𞤢),
						'one' => q({0} 𞤸𞤆𞤢),
						'other' => q({0} 𞤸𞤆𞤢),
					},
					# Long Unit Identifier
					'pressure-inch-ofhg' => {
						'name' => q(𞤺𞤮𞤖𞤺),
						'one' => q({0} 𞤺𞤮𞤖𞤺),
						'other' => q({0} 𞤺𞤮𞤖𞤺),
					},
					# Core Unit Identifier
					'inch-ofhg' => {
						'name' => q(𞤺𞤮𞤖𞤺),
						'one' => q({0} 𞤺𞤮𞤖𞤺),
						'other' => q({0} 𞤺𞤮𞤖𞤺),
					},
					# Long Unit Identifier
					'pressure-kilopascal' => {
						'name' => q(𞤳𞤆𞤢),
						'one' => q({0} 𞤳𞤆𞤢),
						'other' => q({0} 𞤳𞤆𞤢),
					},
					# Core Unit Identifier
					'kilopascal' => {
						'name' => q(𞤳𞤆𞤢),
						'one' => q({0} 𞤳𞤆𞤢),
						'other' => q({0} 𞤳𞤆𞤢),
					},
					# Long Unit Identifier
					'pressure-megapascal' => {
						'name' => q(𞤃𞤆𞤢),
						'one' => q({0} 𞤃𞤆𞤢),
						'other' => q({0} 𞤃𞤆𞤢),
					},
					# Core Unit Identifier
					'megapascal' => {
						'name' => q(𞤃𞤆𞤢),
						'one' => q({0} 𞤃𞤆𞤢),
						'other' => q({0} 𞤃𞤆𞤢),
					},
					# Long Unit Identifier
					'pressure-millibar' => {
						'name' => q(𞤥𞤦𞤢𞤪),
						'one' => q({0} 𞤥𞤦𞤢𞤪),
						'other' => q({0} 𞤥𞤦𞤢𞤪),
					},
					# Core Unit Identifier
					'millibar' => {
						'name' => q(𞤥𞤦𞤢𞤪),
						'one' => q({0} 𞤥𞤦𞤢𞤪),
						'other' => q({0} 𞤥𞤦𞤢𞤪),
					},
					# Long Unit Identifier
					'pressure-millimeter-ofhg' => {
						'name' => q(𞤥𞤥𞤖𞤺),
						'one' => q({0} 𞤥𞤥𞤖𞤺),
						'other' => q({0} 𞤥𞤥𞤖𞤺),
					},
					# Core Unit Identifier
					'millimeter-ofhg' => {
						'name' => q(𞤥𞤥𞤖𞤺),
						'one' => q({0} 𞤥𞤥𞤖𞤺),
						'other' => q({0} 𞤥𞤥𞤖𞤺),
					},
					# Long Unit Identifier
					'pressure-pascal' => {
						'name' => q(𞤆𞤢),
						'one' => q({0} 𞤆𞤢),
						'other' => q({0} 𞤆𞤢),
					},
					# Core Unit Identifier
					'pascal' => {
						'name' => q(𞤆𞤢),
						'one' => q({0} 𞤆𞤢),
						'other' => q({0} 𞤆𞤢),
					},
					# Long Unit Identifier
					'pressure-pound-force-per-square-inch' => {
						'name' => q(𞤺𞤣𞤺𞤮),
						'one' => q({0} 𞤺𞤣𞤺𞤮),
						'other' => q({0} 𞤺𞤣𞤺𞤮),
					},
					# Core Unit Identifier
					'pound-force-per-square-inch' => {
						'name' => q(𞤺𞤣𞤺𞤮),
						'one' => q({0} 𞤺𞤣𞤺𞤮),
						'other' => q({0} 𞤺𞤣𞤺𞤮),
					},
					# Long Unit Identifier
					'speed-kilometer-per-hour' => {
						'name' => q(𞤳𞤥/𞤲𞤶𞤢𞤥𞤣𞤭),
						'one' => q({0} 𞤳𞤥/𞤶),
						'other' => q({0} 𞤳𞤥/𞤶),
					},
					# Core Unit Identifier
					'kilometer-per-hour' => {
						'name' => q(𞤳𞤥/𞤲𞤶𞤢𞤥𞤣𞤭),
						'one' => q({0} 𞤳𞤥/𞤶),
						'other' => q({0} 𞤳𞤥/𞤶),
					},
					# Long Unit Identifier
					'speed-knot' => {
						'name' => q(𞤨𞤩),
						'one' => q({0} 𞤨𞤩),
						'other' => q({0} 𞤨𞤩),
					},
					# Core Unit Identifier
					'knot' => {
						'name' => q(𞤨𞤩),
						'one' => q({0} 𞤨𞤩),
						'other' => q({0} 𞤨𞤩),
					},
					# Long Unit Identifier
					'speed-meter-per-second' => {
						'name' => q(𞤥𞤫𞥅𞤼𞤭/𞤳𞤭𞤲),
						'one' => q({0} 𞤥/𞤳𞤭𞤲),
						'other' => q({0} 𞤥/𞤳𞤭𞤲),
					},
					# Core Unit Identifier
					'meter-per-second' => {
						'name' => q(𞤥𞤫𞥅𞤼𞤭/𞤳𞤭𞤲),
						'one' => q({0} 𞤥/𞤳𞤭𞤲),
						'other' => q({0} 𞤥/𞤳𞤭𞤲),
					},
					# Long Unit Identifier
					'speed-mile-per-hour' => {
						'name' => q(𞤥𞤢𞤴𞤤𞤭/𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'one' => q({0} 𞤥𞤢𞥋𞤣𞤶),
						'other' => q({0} 𞤥𞤢𞥋𞤣𞤶),
					},
					# Core Unit Identifier
					'mile-per-hour' => {
						'name' => q(𞤥𞤢𞤴𞤤𞤭/𞤲𞤶𞤢𞤥𞤲𞤣𞤭),
						'one' => q({0} 𞤥𞤢𞥋𞤣𞤶),
						'other' => q({0} 𞤥𞤢𞥋𞤣𞤶),
					},
					# Long Unit Identifier
					'temperature-celsius' => {
						'name' => q(𞤶𞤫𞤩. 𞤅),
						'one' => q({0}°𞤅),
						'other' => q({0}°𞤅),
					},
					# Core Unit Identifier
					'celsius' => {
						'name' => q(𞤶𞤫𞤩. 𞤅),
						'one' => q({0}°𞤅),
						'other' => q({0}°𞤅),
					},
					# Long Unit Identifier
					'temperature-fahrenheit' => {
						'name' => q(𞤶𞤫𞤩. 𞤊),
						'one' => q({0}°𞤊),
						'other' => q({0}°𞤊),
					},
					# Core Unit Identifier
					'fahrenheit' => {
						'name' => q(𞤶𞤫𞤩. 𞤊),
						'one' => q({0}°𞤊),
						'other' => q({0}°𞤊),
					},
					# Long Unit Identifier
					'temperature-kelvin' => {
						'name' => q(𞤑),
						'one' => q({0} 𞤑),
						'other' => q({0} 𞤑),
					},
					# Core Unit Identifier
					'kelvin' => {
						'name' => q(𞤑),
						'one' => q({0} 𞤑),
						'other' => q({0} 𞤑),
					},
					# Long Unit Identifier
					'times' => {
						'1' => q({0}-{1}),
					},
					# Core Unit Identifier
					'times' => {
						'1' => q({0}-{1}),
					},
					# Long Unit Identifier
					'torque-newton-meter' => {
						'name' => q(𞤐.𞤥),
						'one' => q({0} 𞤐.𞤥),
						'other' => q({0} 𞤐.𞤥),
					},
					# Core Unit Identifier
					'newton-meter' => {
						'name' => q(𞤐.𞤥),
						'one' => q({0} 𞤐.𞤥),
						'other' => q({0} 𞤐.𞤥),
					},
					# Long Unit Identifier
					'volume-acre-foot' => {
						'name' => q(𞤺𞤢𞤪𞤳𞤵 𞤼𞤨),
						'one' => q({0} 𞤺𞤢 𞤼𞤨),
						'other' => q({0} 𞤺𞤢 𞤼𞤨),
					},
					# Core Unit Identifier
					'acre-foot' => {
						'name' => q(𞤺𞤢𞤪𞤳𞤵 𞤼𞤨),
						'one' => q({0} 𞤺𞤢 𞤼𞤨),
						'other' => q({0} 𞤺𞤢 𞤼𞤨),
					},
					# Long Unit Identifier
					'volume-barrel' => {
						'name' => q(𞤺𞤮𞤲𞤺𞤮𞥅𞤪𞤵),
						'one' => q({0} 𞤺𞤮𞤺),
						'other' => q({0} 𞤺𞤮𞤺),
					},
					# Core Unit Identifier
					'barrel' => {
						'name' => q(𞤺𞤮𞤲𞤺𞤮𞥅𞤪𞤵),
						'one' => q({0} 𞤺𞤮𞤺),
						'other' => q({0} 𞤺𞤮𞤺),
					},
					# Long Unit Identifier
					'volume-centiliter' => {
						'name' => q(𞤧𞤂),
						'one' => q({0} 𞤧𞤂),
						'other' => q({0} 𞤧𞤂),
					},
					# Core Unit Identifier
					'centiliter' => {
						'name' => q(𞤧𞤂),
						'one' => q({0} 𞤧𞤂),
						'other' => q({0} 𞤧𞤂),
					},
					# Long Unit Identifier
					'volume-cubic-centimeter' => {
						'name' => q(𞤧𞤥𞥓),
						'one' => q({0} 𞤧𞤥𞥓),
						'other' => q({0} 𞤧𞤥𞥓),
						'per' => q({0}/𞤧𞤥𞥓),
					},
					# Core Unit Identifier
					'cubic-centimeter' => {
						'name' => q(𞤧𞤥𞥓),
						'one' => q({0} 𞤧𞤥𞥓),
						'other' => q({0} 𞤧𞤥𞥓),
						'per' => q({0}/𞤧𞤥𞥓),
					},
					# Long Unit Identifier
					'volume-cubic-foot' => {
						'name' => q(𞤼𞤫𞤨𞥆𞤭𞥓),
						'one' => q({0} 𞤼𞤨𞥓),
						'other' => q({0} 𞤼𞤨𞥓),
					},
					# Core Unit Identifier
					'cubic-foot' => {
						'name' => q(𞤼𞤫𞤨𞥆𞤭𞥓),
						'one' => q({0} 𞤼𞤨𞥓),
						'other' => q({0} 𞤼𞤨𞥓),
					},
					# Long Unit Identifier
					'volume-cubic-inch' => {
						'name' => q(𞤲𞤺𞤮𞤪𞤰𞤭𞥓),
						'one' => q({0} 𞤺𞤮𞥓),
						'other' => q({0} 𞤺𞤮𞥓),
					},
					# Core Unit Identifier
					'cubic-inch' => {
						'name' => q(𞤲𞤺𞤮𞤪𞤰𞤭𞥓),
						'one' => q({0} 𞤺𞤮𞥓),
						'other' => q({0} 𞤺𞤮𞥓),
					},
					# Long Unit Identifier
					'volume-cubic-kilometer' => {
						'name' => q(𞤳𞤥𞥓),
						'one' => q({0} 𞤳𞤥𞥓),
						'other' => q({0} 𞤳𞤥𞥓),
					},
					# Core Unit Identifier
					'cubic-kilometer' => {
						'name' => q(𞤳𞤥𞥓),
						'one' => q({0} 𞤳𞤥𞥓),
						'other' => q({0} 𞤳𞤥𞥓),
					},
					# Long Unit Identifier
					'volume-cubic-meter' => {
						'name' => q(𞤥𞥓),
						'one' => q({0} 𞤥𞥓),
						'other' => q({0} 𞤥𞥓),
						'per' => q({0}/𞤥𞥓),
					},
					# Core Unit Identifier
					'cubic-meter' => {
						'name' => q(𞤥𞥓),
						'one' => q({0} 𞤥𞥓),
						'other' => q({0} 𞤥𞥓),
						'per' => q({0}/𞤥𞥓),
					},
					# Long Unit Identifier
					'volume-cubic-mile' => {
						'name' => q(𞤥𞤢𞥓),
						'one' => q({0} 𞤥𞤢𞥓),
						'other' => q({0} 𞤥𞤢𞥓),
					},
					# Core Unit Identifier
					'cubic-mile' => {
						'name' => q(𞤥𞤢𞥓),
						'one' => q({0} 𞤥𞤢𞥓),
						'other' => q({0} 𞤥𞤢𞥓),
					},
					# Long Unit Identifier
					'volume-cubic-yard' => {
						'name' => q(𞤧𞤮𞤺𞤮𞤲𞤫𞥓),
						'one' => q({0} 𞤧𞤮𞥓),
						'other' => q({0} 𞤧𞤮𞥓),
					},
					# Core Unit Identifier
					'cubic-yard' => {
						'name' => q(𞤧𞤮𞤺𞤮𞤲𞤫𞥓),
						'one' => q({0} 𞤧𞤮𞥓),
						'other' => q({0} 𞤧𞤮𞥓),
					},
					# Long Unit Identifier
					'volume-cup' => {
						'name' => q(𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤫),
						'one' => q({0} 𞤳𞤮𞤪),
						'other' => q({0} 𞤳𞤮𞤪),
					},
					# Core Unit Identifier
					'cup' => {
						'name' => q(𞤳𞤮𞤪𞤲𞤣𞤮𞥅𞤤𞤫),
						'one' => q({0} 𞤳𞤮𞤪),
						'other' => q({0} 𞤳𞤮𞤪),
					},
					# Long Unit Identifier
					'volume-cup-metric' => {
						'name' => q(𞤳𞤮𞤪𞤥),
						'one' => q({0} 𞤳𞤮𞤪𞤥),
						'other' => q({0} 𞤳𞤮𞤪𞤥),
					},
					# Core Unit Identifier
					'cup-metric' => {
						'name' => q(𞤳𞤮𞤪𞤥),
						'one' => q({0} 𞤳𞤮𞤪𞤥),
						'other' => q({0} 𞤳𞤮𞤪𞤥),
					},
					# Long Unit Identifier
					'volume-deciliter' => {
						'name' => q(𞤣𞤂),
						'one' => q({0} 𞤣𞤂),
						'other' => q({0} 𞤣𞤂),
					},
					# Core Unit Identifier
					'deciliter' => {
						'name' => q(𞤣𞤂),
						'one' => q({0} 𞤣𞤂),
						'other' => q({0} 𞤣𞤂),
					},
					# Long Unit Identifier
					'volume-dessert-spoon' => {
						'name' => q(𞤳𞤤𞤤),
						'one' => q({0} 𞤳𞤤𞤤),
						'other' => q({0} 𞤳𞤤𞤤),
					},
					# Core Unit Identifier
					'dessert-spoon' => {
						'name' => q(𞤳𞤤𞤤),
						'one' => q({0} 𞤳𞤤𞤤),
						'other' => q({0} 𞤳𞤤𞤤),
					},
					# Long Unit Identifier
					'volume-dessert-spoon-imperial' => {
						'name' => q(𞤳𞤤𞤤 𞤚𞤭𞤤.),
						'one' => q({0} 𞤳𞤤𞤤 𞤚𞤭𞤤.),
						'other' => q({0} 𞤳𞤤𞤤 𞤚𞤭𞤤.),
					},
					# Core Unit Identifier
					'dessert-spoon-imperial' => {
						'name' => q(𞤳𞤤𞤤 𞤚𞤭𞤤.),
						'one' => q({0} 𞤳𞤤𞤤 𞤚𞤭𞤤.),
						'other' => q({0} 𞤳𞤤𞤤 𞤚𞤭𞤤.),
					},
					# Long Unit Identifier
					'volume-dram' => {
						'name' => q(𞤣𞤭𞤪𞤸𞤢𞤥𞤵 𞤧𞤫𞤤𞤦𞤢𞤲),
						'one' => q({0} 𞤣𞤪 𞤧𞤫𞤤),
						'other' => q({0} 𞤣𞤪 𞤧𞤫𞤤),
					},
					# Core Unit Identifier
					'dram' => {
						'name' => q(𞤣𞤭𞤪𞤸𞤢𞤥𞤵 𞤧𞤫𞤤𞤦𞤢𞤲),
						'one' => q({0} 𞤣𞤪 𞤧𞤫𞤤),
						'other' => q({0} 𞤣𞤪 𞤧𞤫𞤤),
					},
					# Long Unit Identifier
					'volume-drop' => {
						'name' => q(𞤧𞤭𞤲𞤼𞤫𞤪𞤫),
						'one' => q({0} 𞤧𞤭𞤲),
						'other' => q({0} 𞤷𞤭𞤲),
					},
					# Core Unit Identifier
					'drop' => {
						'name' => q(𞤧𞤭𞤲𞤼𞤫𞤪𞤫),
						'one' => q({0} 𞤧𞤭𞤲),
						'other' => q({0} 𞤷𞤭𞤲),
					},
					# Long Unit Identifier
					'volume-fluid-ounce' => {
						'name' => q(𞤱𞤺 𞤧𞤫𞤤),
						'one' => q({0} 𞤱𞤺 𞤧𞤫𞤤),
						'other' => q({0} 𞤱𞤺 𞤧𞤫𞤤),
					},
					# Core Unit Identifier
					'fluid-ounce' => {
						'name' => q(𞤱𞤺 𞤧𞤫𞤤),
						'one' => q({0} 𞤱𞤺 𞤧𞤫𞤤),
						'other' => q({0} 𞤱𞤺 𞤧𞤫𞤤),
					},
					# Long Unit Identifier
					'volume-fluid-ounce-imperial' => {
						'name' => q(𞤱𞤺 𞤧𞤫𞤤 𞤚𞤭𞤤.),
						'one' => q({0} 𞤱𞤺 𞤧𞤫𞤤 𞤚𞤭𞤤.),
						'other' => q({0} 𞤱𞤺 𞤧𞤫𞤤 𞤚𞤭𞤤.),
					},
					# Core Unit Identifier
					'fluid-ounce-imperial' => {
						'name' => q(𞤱𞤺 𞤧𞤫𞤤 𞤚𞤭𞤤.),
						'one' => q({0} 𞤱𞤺 𞤧𞤫𞤤 𞤚𞤭𞤤.),
						'other' => q({0} 𞤱𞤺 𞤧𞤫𞤤 𞤚𞤭𞤤.),
					},
					# Long Unit Identifier
					'volume-gallon' => {
						'name' => q(𞤺𞤢𞤤),
						'one' => q({0} 𞤺𞤢𞤤),
						'other' => q({0} 𞤺𞤢𞤤),
						'per' => q({0}/𞤺𞤢𞤤),
					},
					# Core Unit Identifier
					'gallon' => {
						'name' => q(𞤺𞤢𞤤),
						'one' => q({0} 𞤺𞤢𞤤),
						'other' => q({0} 𞤺𞤢𞤤),
						'per' => q({0}/𞤺𞤢𞤤),
					},
					# Long Unit Identifier
					'volume-gallon-imperial' => {
						'name' => q(𞤺𞤢𞤤 𞤚𞤭𞤤.),
						'one' => q({0} 𞤺𞤢𞤤 𞤚𞤭𞤤.),
						'other' => q({0} 𞤺𞤢𞤤 𞤚𞤭𞤤.),
						'per' => q({0}/𞤺𞤢𞤤 𞤚𞤭𞤤.),
					},
					# Core Unit Identifier
					'gallon-imperial' => {
						'name' => q(𞤺𞤢𞤤 𞤚𞤭𞤤.),
						'one' => q({0} 𞤺𞤢𞤤 𞤚𞤭𞤤.),
						'other' => q({0} 𞤺𞤢𞤤 𞤚𞤭𞤤.),
						'per' => q({0}/𞤺𞤢𞤤 𞤚𞤭𞤤.),
					},
					# Long Unit Identifier
					'volume-hectoliter' => {
						'name' => q(𞤸𞤂),
						'one' => q({0} 𞤸𞤂),
						'other' => q({0} 𞤸𞤂),
					},
					# Core Unit Identifier
					'hectoliter' => {
						'name' => q(𞤸𞤂),
						'one' => q({0} 𞤸𞤂),
						'other' => q({0} 𞤸𞤂),
					},
					# Long Unit Identifier
					'volume-jigger' => {
						'name' => q(𞤶𞤭𞤺𞥆𞤮),
						'one' => q({0} 𞤶𞤭𞤺𞥆𞤮),
						'other' => q({0} 𞤶𞤭𞤺𞥆𞤮),
					},
					# Core Unit Identifier
					'jigger' => {
						'name' => q(𞤶𞤭𞤺𞥆𞤮),
						'one' => q({0} 𞤶𞤭𞤺𞥆𞤮),
						'other' => q({0} 𞤶𞤭𞤺𞥆𞤮),
					},
					# Long Unit Identifier
					'volume-liter' => {
						'name' => q(𞤤𞤭𞥅𞤼𞤭),
						'one' => q({0} 𞤂),
						'other' => q({0} 𞤂),
						'per' => q({0}/𞤂),
					},
					# Core Unit Identifier
					'liter' => {
						'name' => q(𞤤𞤭𞥅𞤼𞤭),
						'one' => q({0} 𞤂),
						'other' => q({0} 𞤂),
						'per' => q({0}/𞤂),
					},
					# Long Unit Identifier
					'volume-megaliter' => {
						'name' => q(𞤃𞤂),
						'one' => q({0} 𞤃𞤂),
						'other' => q({0} 𞤃𞤂),
					},
					# Core Unit Identifier
					'megaliter' => {
						'name' => q(𞤃𞤂),
						'one' => q({0} 𞤃𞤂),
						'other' => q({0} 𞤃𞤂),
					},
					# Long Unit Identifier
					'volume-milliliter' => {
						'name' => q(𞤥𞤂),
						'one' => q({0} 𞤥𞤂),
						'other' => q({0} 𞤥𞤂),
					},
					# Core Unit Identifier
					'milliliter' => {
						'name' => q(𞤥𞤂),
						'one' => q({0} 𞤥𞤂),
						'other' => q({0} 𞤥𞤂),
					},
					# Long Unit Identifier
					'volume-pinch' => {
						'name' => q(𞤩𞤵𞤷𞥆𞤢𞤲𞤣𞤫),
						'one' => q({0} 𞤩𞤵𞤷),
						'other' => q({0} 𞤩𞤵𞤷),
					},
					# Core Unit Identifier
					'pinch' => {
						'name' => q(𞤩𞤵𞤷𞥆𞤢𞤲𞤣𞤫),
						'one' => q({0} 𞤩𞤵𞤷),
						'other' => q({0} 𞤩𞤵𞤷),
					},
					# Long Unit Identifier
					'volume-pint' => {
						'name' => q(𞤨𞤭𞤲𞤼𞤭),
						'one' => q({0} 𞤨𞤼),
						'other' => q({0} 𞤨𞤼),
					},
					# Core Unit Identifier
					'pint' => {
						'name' => q(𞤨𞤭𞤲𞤼𞤭),
						'one' => q({0} 𞤨𞤼),
						'other' => q({0} 𞤨𞤼),
					},
					# Long Unit Identifier
					'volume-pint-metric' => {
						'name' => q(𞤨𞤼𞤥),
						'one' => q({0} 𞤨𞤼𞤥),
						'other' => q({0} 𞤨𞤼𞤥),
					},
					# Core Unit Identifier
					'pint-metric' => {
						'name' => q(𞤨𞤼𞤥),
						'one' => q({0} 𞤨𞤼𞤥),
						'other' => q({0} 𞤨𞤼𞤥),
					},
					# Long Unit Identifier
					'volume-quart' => {
						'name' => q(𞤳𞤼𞤭),
						'one' => q({0} 𞤳𞤼),
						'other' => q({0} 𞤳𞤼),
					},
					# Core Unit Identifier
					'quart' => {
						'name' => q(𞤳𞤼𞤭),
						'one' => q({0} 𞤳𞤼),
						'other' => q({0} 𞤳𞤼),
					},
					# Long Unit Identifier
					'volume-quart-imperial' => {
						'name' => q(𞤳𞤼 𞤚𞤭𞤤),
						'one' => q({0} 𞤳𞤼 𞤚𞤭𞤤.),
						'other' => q({0} 𞤳𞤼 𞤚𞤭𞤤.),
					},
					# Core Unit Identifier
					'quart-imperial' => {
						'name' => q(𞤳𞤼 𞤚𞤭𞤤),
						'one' => q({0} 𞤳𞤼 𞤚𞤭𞤤.),
						'other' => q({0} 𞤳𞤼 𞤚𞤭𞤤.),
					},
					# Long Unit Identifier
					'volume-tablespoon' => {
						'name' => q(𞤳𞤤𞤻),
						'one' => q({0} 𞤳𞤤𞤻),
						'other' => q({0} 𞤳𞤤𞤻),
					},
					# Core Unit Identifier
					'tablespoon' => {
						'name' => q(𞤳𞤤𞤻),
						'one' => q({0} 𞤳𞤤𞤻),
						'other' => q({0} 𞤳𞤤𞤻),
					},
					# Long Unit Identifier
					'volume-teaspoon' => {
						'name' => q(𞤳𞤤𞤦),
						'one' => q({0} 𞤳𞤤𞤦),
						'other' => q({0} 𞤳𞤤𞤦),
					},
					# Core Unit Identifier
					'teaspoon' => {
						'name' => q(𞤳𞤤𞤦),
						'one' => q({0} 𞤳𞤤𞤦),
						'other' => q({0} 𞤳𞤤𞤦),
					},
				},
			} }
);

has 'yesstr' => (
	is			=> 'ro',
	isa			=> RegexpRef,
	init_arg	=> undef,
	default		=> sub { qr'^(?i:𞤢𞤱𞤢|𞤢|yes|y)$' }
);

has 'nostr' => (
	is			=> 'ro',
	isa			=> RegexpRef,
	init_arg	=> undef,
	default		=> sub { qr'^(?i:𞤮𞥅𞤮|𞤮|no|n)$' }
);

has 'listPatterns' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
				start => q({0}⹁ {1}),
				middle => q({0}, {1}),
				end => q({0}, {1}),
				2 => q({0} 𞤫 {1}),
		} }
);

has 'default_numbering_system' => (
	is			=> 'ro',
	isa			=> Str,
	init_arg	=> undef,
	default		=> 'adlm',
);

has native_numbering_system => (
	is			=> 'ro',
	isa			=> Str,
	init_arg	=> undef,
	default		=> 'adlm',
);

has 'minimum_grouping_digits' => (
	is			=>'ro',
	isa			=> Int,
	init_arg	=> undef,
	default		=> 1,
);

has 'number_symbols' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'latn' => {
			'decimal' => q(.),
			'group' => q(⹁),
			'minusSign' => q(-),
			'nan' => q(𞤏𞤮𞤈),
			'percentSign' => q(%),
			'plusSign' => q(+),
		},
	} }
);

has 'number_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		decimalFormat => {
			'default' => {
				'standard' => {
					'default' => '#,##0.###',
				},
			},
		},
} },
);

has 'currencies' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'AED' => {
			display_name => {
				'currency' => q(𞤁𞤭𞤪𞤸𞤢𞤥𞤵 𞤋𞤥𞤢𞥄𞤪𞤢𞤼𞤭𞤲𞤳𞤮),
				'one' => q(𞤣𞤭𞤪𞤸𞤢𞤥𞤵 𞤋𞤥𞤢𞥄𞤪𞤢𞤼𞤭𞤲𞤳𞤮),
				'other' => q(𞤣𞤭𞤪𞤸𞤢𞤥𞤵𞥅𞤶𞤭 𞤋𞤥𞤢𞥄𞤪𞤢𞤼𞤭𞤲𞤳𞤮),
			},
		},
		'AFN' => {
			display_name => {
				'currency' => q(𞤀𞤬𞤿𞤢𞤲𞤭 𞤀𞤬𞤿𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤢𞤬𞤿𞤢𞤲𞤭 𞤀𞤬𞤿𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤢𞤬𞤿𞤢𞤲𞤭𞥅𞤶𞤭 𞤀𞤬𞤿𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'ALL' => {
			display_name => {
				'currency' => q(𞤂𞤫𞤳 𞤀𞤤𞤦𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤤𞤫𞤳 𞤀𞤤𞤦𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤤𞤫𞤳𞤭𞥅𞤶𞤭 𞤀𞤤𞤦𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'AMD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤪𞤢𞤥𞤵 𞤀𞤪𞤥𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤣𞤢𞤪𞤢𞤥𞤵 𞤀𞤪𞤥𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤣𞤢𞤪𞤢𞤥𞤵𞥅𞤶𞤭 𞤀𞤪𞤥𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'ANG' => {
			display_name => {
				'currency' => q(𞤊𞤵𞤤𞤮𞤪𞤭𞤲 𞤀𞤲𞤼𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤊𞤵𞤤𞤮𞤪𞤭𞤲 𞤀𞤲𞤼𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤊𞤵𞤤𞤮𞤪𞤭𞤲𞤶𞤭 𞤀𞤲𞤼𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'AOA' => {
			display_name => {
				'currency' => q(𞤑𞤵𞤱𞤢𞤲𞥁𞤢 𞤀𞤲𞤺𞤮𞤤𞤢𞤲𞤳𞤮),
				'one' => q(𞤳𞤵𞤱𞤢𞤲𞥁𞤢 𞤀𞤲𞤺𞤮𞤤𞤢𞤲𞤳𞤮),
				'other' => q(𞤳𞤵𞤱𞤢𞤲𞥁𞤢𞤢𞥄𞤶𞤭 𞤀𞤲𞤺𞤮𞤤𞤢𞤲𞤳𞤮),
			},
		},
		'ARS' => {
			display_name => {
				'currency' => q(𞤆𞤫𞤧𞤮 𞤀𞤪𞤶𞤢𞤲𞤼𞤭𞤲𞤢),
				'one' => q(𞤆𞤫𞤧𞤮 𞤀𞤪𞤶𞤢𞤲𞤼𞤭𞤲𞤢),
				'other' => q(𞤆𞤫𞤧𞤮𞥅𞤶𞤭 𞤀𞤪𞤶𞤢𞤲𞤼𞤭𞤲𞤢),
			},
		},
		'AUD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤁𞤢𞤤𞤢 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'AWG' => {
			display_name => {
				'currency' => q(𞤊𞤵𞤤𞤮𞤪𞤭𞤲 𞤀𞤪𞤵𞤦𞤢𞤲𞤳𞤮),
				'one' => q(𞤊𞤵𞤤𞤮𞤪𞤭𞤲 𞤀𞤪𞤵𞤦𞤢𞤲𞤳𞤮),
				'other' => q(𞤊𞤵𞤤𞤮𞤪𞤭𞤲 𞤀𞤪𞤵𞤦𞤢𞤲𞤳𞤮),
			},
		},
		'AZN' => {
			display_name => {
				'currency' => q(𞤃𞤢𞤲𞤢𞥄𞤼𞤵 𞤀𞥁𞤫𞤪𞤦𞤢𞤴𞤶𞤢𞤲𞤳𞤮),
				'one' => q(𞤃𞤢𞤲𞤢𞥄𞤼𞤵 𞤀𞥁𞤫𞤪𞤦𞤢𞤴𞤶𞤢𞤲𞤳𞤮),
				'other' => q(𞤃𞤢𞤲𞤢𞥄𞤼𞤵𞥅𞤶𞤭 𞤀𞥁𞤫𞤪𞤦𞤢𞤴𞤶𞤢𞤲𞤳𞤮),
			},
		},
		'BAM' => {
			display_name => {
				'currency' => q(𞤃𞤢𞤪𞤳 𞤄𞤮𞤧𞤲𞤭𞤴𞤢-𞤖𞤫𞤪𞤶𞤫𞤺𞤮𞤾𞤭𞤲𞤳𞤮 𞤱𞤢𞤴𞤤𞤮𞤼𞤮𞥅𞤯𞤭),
				'one' => q(𞤃𞤢𞤪𞤳 𞤄𞤮𞤧𞤲𞤭𞤴𞤢-𞤖𞤫𞤪𞤶𞤫𞤺𞤮𞤾𞤭𞤲𞤳𞤮 𞤱𞤢𞤴𞤤𞤮𞤼𞤮𞥅𞤯𞤭),
				'other' => q(𞤃𞤢𞤪𞤳 𞤄𞤮𞤧𞤲𞤭𞤴𞤢-𞤖𞤫𞤪𞤶𞤫𞤺𞤮𞤾𞤭𞤲𞤳𞤮 𞤱𞤢𞤴𞤤𞤮𞤼𞤮𞥅𞤯𞤭),
			},
		},
		'BBD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤄𞤢𞤪𞤦𞤢𞤣𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤁𞤢𞤤𞤢 𞤄𞤢𞤪𞤦𞤢𞤣𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤄𞤢𞤪𞤦𞤢𞤣𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'BDT' => {
			display_name => {
				'currency' => q(𞤚𞤢𞤪𞤢 𞤄𞤢𞤲𞤺𞤭𞤤𞤢𞤣𞤫𞥅𞤧𞤭𞤲𞤳𞤮),
				'one' => q(𞤼𞤢𞤪𞤢 𞤄𞤢𞤲𞤺𞤭𞤤𞤢𞤣𞤫𞥅𞤧𞤭𞤲𞤳𞤮),
				'other' => q(𞤼𞤢𞤪𞤢𞥄𞤶𞤭 𞤄𞤢𞤲𞤺𞤭𞤤𞤢𞤣𞤫𞥅𞤧𞤭𞤲𞤳𞤮),
			},
		},
		'BGN' => {
			symbol => 'BGN',
			display_name => {
				'currency' => q(𞤂𞤫𞥅𞤾 𞤄𞤭𞤤𞤺𞤢𞤪𞤭𞤲𞤳𞤮),
				'one' => q(𞤤𞤫𞥅𞤾 𞤄𞤭𞤤𞤺𞤢𞤪𞤭𞤲𞤳𞤮),
				'other' => q(𞤂𞤫𞥅𞤾𞤢 𞤄𞤭𞤤𞤺𞤢𞤪𞤭𞤲𞤳𞤮),
			},
		},
		'BHD' => {
			display_name => {
				'currency' => q(𞤁𞤭𞤲𞤢𞥄𞤪 𞤄𞤢𞤸𞤢𞤪𞤢𞥄𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤣𞤭𞤲𞤢𞥄𞤪 𞤄𞤢𞤸𞤢𞤪𞤢𞥄𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤣𞤭𞤲𞤢𞥄𞤪𞤶𞤭 𞤄𞤢𞤸𞤢𞤪𞤢𞥄𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'BIF' => {
			display_name => {
				'currency' => q(𞤊𞤢𞤪𞤢𞤲 𞤄𞤵𞤪𞤵𞤲𞤣𞤭𞤲𞤳𞤮),
				'one' => q(𞤬𞤢𞤪𞤢𞤲 𞤄𞤵𞤪𞤵𞤲𞤣𞤭𞤲𞤳𞤮),
				'other' => q(𞤬𞤢𞤪𞤢𞤲𞤶𞤭 𞤄𞤵𞤪𞤵𞤲𞤣𞤭𞤲𞤳𞤮),
			},
		},
		'BMD' => {
			symbol => '$',
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤄𞤫𞤪𞤥𞤵𞤣𞤢𞥄𞤲),
				'one' => q(𞤁𞤢𞤤𞤢 𞤄𞤫𞤪𞤥𞤵𞤣𞤢𞥄𞤲),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤄𞤫𞤪𞤥𞤵𞤣𞤢𞥄𞤲),
			},
		},
		'BND' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤄𞤵𞤪𞤲𞤫𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤣𞤢𞤤𞤢 𞤄𞤵𞤪𞤲𞤫𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤣𞤢𞤤𞤢𞥄𞤶𞤭 𞤄𞤵𞤪𞤲𞤫𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'BOB' => {
			display_name => {
				'currency' => q(𞤄𞤮𞤤𞤭𞤾𞤭𞤴𞤢𞤲𞤮 𞤄𞤮𞤤𞤭𞤾𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤄𞤮𞤤𞤭𞤾𞤭𞤴𞤢𞤲𞤮 𞤄𞤮𞤤𞤭𞤾𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤄𞤮𞤤𞤭𞤾𞤭𞤴𞤢𞤲𞤮𞥅𞤶𞤭 𞤄𞤮𞤤𞤭𞤾𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'BRL' => {
			display_name => {
				'currency' => q(𞤈𞤭𞤴𞤢𞤤 𞤄𞤪𞤢𞤧𞤭𞤤𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤈𞤭𞤴𞤢𞤤 𞤄𞤪𞤢𞤧𞤭𞤤𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤈𞤭𞤴𞤢𞤤𞤶𞤭 𞤄𞤪𞤢𞤧𞤭𞤤𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'BSD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤄𞤢𞤸𞤢𞤥𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤁𞤢𞤤𞤢 𞤄𞤢𞤸𞤢𞤥𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤄𞤢𞤸𞤢𞤥𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'BTN' => {
			display_name => {
				'currency' => q(𞤐𞤘𞤵𞤤𞤼𞤵𞤪𞤵𞤥𞤵 𞤄𞤵𞤼𞤢𞤲𞤭𞤲𞤳𞤮),
				'one' => q(𞤲𞤺𞤵𞤤𞤼𞤵𞤪𞤵𞤥𞤵 𞤄𞤵𞤼𞤢𞤲𞤭𞤲𞤳𞤮),
				'other' => q(𞤐𞤘𞤵𞤤𞤼𞤵𞤪𞤵𞤥𞤶𞤭 𞤄𞤵𞤼𞤢𞤲𞤭𞤲𞤳𞤮),
			},
		},
		'BWP' => {
			display_name => {
				'currency' => q(𞤆𞤵𞤤𞤢 𞤄𞤮𞤼𞤵𞤧𞤱𞤢𞤲𞤢𞤲𞤳𞤮),
				'one' => q(𞤨𞤵𞤤𞤢 𞤄𞤮𞤼𞤵𞤧𞤱𞤢𞤲𞤢𞤲𞤳𞤮),
				'other' => q(𞤨𞤵𞤤𞤢𞥄𞤶𞤭 𞤄𞤮𞤼𞤵𞤧𞤱𞤢𞤲𞤢𞤲𞤳𞤮),
			},
		},
		'BYN' => {
			symbol => 'BYN',
			display_name => {
				'currency' => q(𞤈𞤵𞥅𞤦𞤮𞤤 𞤄𞤫𞤤𞤢𞤪𞤭𞥅𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤈𞤵𞥅𞤦𞤮𞤤 𞤄𞤫𞤤𞤢𞤪𞤭𞥅𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤈𞤵𞥅𞤦𞤮𞤤𞤶𞤭 𞤄𞤫𞤤𞤢𞤪𞤭𞥅𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'BZD' => {
			symbol => 'BZD',
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤄𞤫𞤤𞤭𞥅𞤧),
				'one' => q(𞤁𞤢𞤤𞤢 𞤄𞤫𞤤𞤭𞥅𞤧),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤄𞤫𞤤𞤭𞥅𞤧),
			},
		},
		'CAD' => {
			symbol => 'CA$',
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤑𞤢𞤲𞤢𞤣𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤁𞤢𞤤𞤢 𞤑𞤢𞤲𞤢𞤣𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤑𞤢𞤲𞤢𞤣𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'CDF' => {
			display_name => {
				'currency' => q(𞤊𞤢𞤪𞤢𞤲 𞤑𞤮𞤲𞤺𞤮𞤲𞤳𞤮),
				'one' => q(𞤬𞤢𞤪𞤢𞤲 𞤑𞤮𞤲𞤺𞤮𞤲𞤳𞤮),
				'other' => q(𞤬𞤢𞤪𞤢𞤲𞤶𞤭 𞤑𞤮𞤲𞤺𞤮𞤲𞤳𞤮),
			},
		},
		'CHF' => {
			display_name => {
				'currency' => q(𞤊𞤢𞤪𞤢𞤲 𞤅𞤵𞤱𞤭𞥅𞤧),
				'one' => q(𞤊𞤢𞤪𞤢𞤲 𞤅𞤵𞤱𞤭𞥅𞤧),
				'other' => q(𞤊𞤢𞤪𞤢𞤲𞤶𞤭 𞤅𞤵𞤱𞤭𞥅𞤧),
			},
		},
		'CLP' => {
			display_name => {
				'currency' => q(𞤆𞤫𞤧𞤮 𞤕𞤭𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤆𞤫𞤧𞤮 𞤕𞤭𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤆𞤫𞤧𞤮𞥅𞤶𞤭 𞤕𞤭𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'CNH' => {
			display_name => {
				'currency' => q(𞤒𞤵𞤱𞤢𞤲 𞤕𞤢𞤴𞤲𞤭𞤲𞤳𞤮 \(𞤺𞤢𞥄𞤲𞤭𞤲𞤳𞤮\)),
				'one' => q(𞤴𞤵𞤱𞤢𞤲 𞤕𞤢𞤴𞤲𞤭𞤲𞤳𞤮 \(𞤺𞤢𞥄𞤲𞤭𞤲𞤳𞤮\)),
				'other' => q(𞤴𞤵𞤱𞤢𞤲𞤶𞤭 𞤕𞤢𞤴𞤲𞤭𞤲𞤳𞤮 \(𞤺𞤢𞥄𞤲𞤭𞤲𞤳𞤮\)),
			},
		},
		'CNY' => {
			display_name => {
				'currency' => q(𞤒𞤵𞤱𞤢𞥄𞤲 𞤕𞤢𞤴𞤲𞤭𞤲𞤳𞤮),
				'one' => q(𞤴𞤵𞤱𞤢𞤲 𞤕𞤢𞤴𞤲𞤭𞤲𞤳𞤮),
				'other' => q(𞤴𞤵𞤱𞤢𞤲𞤶𞤭 𞤕𞤢𞤴𞤲𞤭𞤲𞤳𞤮),
			},
		},
		'COP' => {
			display_name => {
				'currency' => q(𞤆𞤫𞤧𞤮 𞤑𞤮𞤤𞤮𞤥𞤦𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤆𞤫𞤧𞤮 𞤑𞤮𞤤𞤮𞤥𞤦𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤆𞤫𞤧𞤮𞥅𞤶𞤭 𞤑𞤮𞤤𞤮𞤥𞤦𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'CRC' => {
			symbol => 'CRC',
			display_name => {
				'currency' => q(𞤑𞤮𞤤𞤮𞥅𞤲 𞤑𞤮𞤧𞤼𞤢 𞤈𞤭𞤳𞤢𞤲),
				'one' => q(𞤑𞤮𞤤𞤮𞥅𞤲 𞤑𞤮𞤧𞤼𞤢 𞤈𞤭𞤳𞤢𞤲),
				'other' => q(𞤑𞤮𞤤𞤮𞥅𞤲𞤶𞤭 𞤑𞤮𞤧𞤼𞤢 𞤈𞤭𞤳𞤢𞤲),
			},
		},
		'CUC' => {
			display_name => {
				'currency' => q(𞤆𞤫𞤧𞤮 𞤑𞤵𞤦𞤢𞤲𞤳𞤮 𞤏𞤢𞤴𞤤𞤮𞤼𞤮𞥅𞤲𞥋𞤺𞤮),
				'one' => q(𞤆𞤫𞤧𞤮 𞤑𞤵𞤦𞤢𞤲𞤳𞤮 𞤏𞤢𞤴𞤤𞤮𞤼𞤮𞥅𞤲𞥋𞤺𞤮),
				'other' => q(𞤆𞤫𞤧𞤮𞥅𞤶𞤭 𞤑𞤵𞤦𞤢𞤲𞤳𞤮 𞤏𞤢𞤴𞤤𞤮𞤼𞤮𞥅𞤲𞥋𞤺𞤮),
			},
		},
		'CUP' => {
			display_name => {
				'currency' => q(𞤆𞤫𞤧𞤮 𞤑𞤵𞤦𞤢𞤲𞤳𞤮),
				'one' => q(𞤨𞤫𞤧𞤮 𞤑𞤵𞤦𞤢𞤲𞤳𞤮),
				'other' => q(𞤨𞤫𞤧𞤮𞥅𞤶𞤭 𞤑𞤵𞤦𞤢𞤲𞤳𞤮),
			},
		},
		'CVE' => {
			display_name => {
				'currency' => q(𞤉𞤧𞤳𞤵𞤣𞤮 𞤑𞤢𞤨-𞤜𞤫𞥅𞤪𞤣𞤢𞤲𞤳𞤮),
				'one' => q(𞤫𞤧𞤳𞤵𞤣𞤮 𞤑𞤢𞤨-𞤜𞤫𞥅𞤪𞤣𞤢𞤲𞤳𞤮),
				'other' => q(𞤫𞤧𞤳𞤵𞤣𞤮𞥅𞤶𞤭 𞤑𞤢𞤨-𞤜𞤫𞥅𞤪𞤣𞤢𞤲𞤳𞤮),
			},
		},
		'CZK' => {
			symbol => 'CZK',
			display_name => {
				'currency' => q(𞤑𞤮𞤪𞤵𞤲𞤢 𞤕𞤫𞥅𞤳𞤭𞤲𞤳𞤮),
				'one' => q(𞤑𞤮𞤪𞤵𞤲𞤢 𞤕𞤫𞥅𞤳𞤭𞤲𞤳𞤮),
				'other' => q(𞤑𞤮𞤪𞤵𞤲𞤢𞥄𞤶𞤭 𞤕𞤫𞥅𞤳𞤭𞤲𞤳𞤮),
			},
		},
		'DJF' => {
			display_name => {
				'currency' => q(𞤊𞤢𞤪𞤢𞤲 𞤔𞤭𞤦𞤵𞤼𞤭𞤲𞤳𞤮),
				'one' => q(𞤬𞤢𞤪𞤢𞤲 𞤔𞤭𞤦𞤵𞤼𞤭𞤲𞤳𞤮),
				'other' => q(𞤬𞤢𞤪𞤢𞤲𞤶𞤭 𞤔𞤭𞤦𞤵𞤼𞤭𞤲𞤳𞤮),
			},
		},
		'DKK' => {
			display_name => {
				'currency' => q(𞤑𞤮𞤪𞤲𞤫 𞤁𞤢𞤲𞤭𞥅𞤧𞤭𞤲𞤳𞤮),
				'one' => q(𞤑𞤮𞤪𞤲𞤫 𞤁𞤢𞤲𞤭𞥅𞤧𞤭𞤲𞤳𞤮),
				'other' => q(𞤑𞤮𞤪𞤲𞤫𞥅𞤶𞤭 𞤁𞤢𞤲𞤭𞥅𞤧),
			},
		},
		'DOP' => {
			display_name => {
				'currency' => q(𞤆𞤫𞤧𞤮 𞤁𞤮𞤥𞤭𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤆𞤫𞤧𞤮 𞤁𞤮𞤥𞤭𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤆𞤫𞤧𞤮𞥅𞤶𞤭 𞤁𞤮𞤥𞤭𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'DZD' => {
			display_name => {
				'currency' => q(𞤁𞤭𞤲𞤢𞥄𞤪 𞤀𞤤𞤶𞤢𞤪𞤭𞤲𞤳𞤮),
				'one' => q(𞤣𞤭𞤲𞤢𞥄𞤪 𞤀𞤤𞤶𞤢𞤪𞤭𞤲𞤳𞤮),
				'other' => q(𞤣𞤭𞤲𞤢𞥄𞤪𞤶𞤭 𞤀𞤤𞤶𞤢𞤪𞤭𞤲𞤳𞤮),
			},
		},
		'EGP' => {
			display_name => {
				'currency' => q(𞤆𞤢𞤱𞤲𞤣𞤵 𞤃𞤭𞤧𞤭𞤪𞤢𞤲𞤳𞤮),
				'one' => q(𞤆𞤢𞤱𞤲𞤣𞤵 𞤃𞤭𞤧𞤭𞤪𞤢𞤲𞤳𞤮),
				'other' => q(𞤆𞤢𞤱𞤯𞤭 𞤃𞤭𞤧𞤭𞤪𞤢𞤲𞤳𞤮),
			},
		},
		'ERN' => {
			display_name => {
				'currency' => q(𞤐𞤢𞤳𞤬𞤢 𞤉𞤪𞤭𞤼𞤫𞤪𞤭𞤲𞤳𞤮),
				'one' => q(𞤐𞤢𞤳𞤬𞤢 𞤉𞤪𞤭𞤼𞤫𞤪𞤭𞤲𞤳𞤮),
				'other' => q(𞤲𞤢𞤳𞤬𞤢𞥄𞤶𞤭 𞤉𞤪𞤭𞤼𞤫𞤪𞤭𞤲𞤳𞤮),
			},
		},
		'ETB' => {
			display_name => {
				'currency' => q(𞤄𞤭𞤪 𞤖𞤢𞤦𞤢𞤧𞤭𞤲𞤳𞤮),
				'one' => q(𞤦𞤭𞤪 𞤖𞤢𞤦𞤢𞤧𞤭𞤲𞤳𞤮),
				'other' => q(𞤄𞤭𞤪𞤶𞤭 𞤖𞤢𞤦𞤢𞤧𞤭𞤲𞤳𞤮),
			},
		},
		'EUR' => {
			display_name => {
				'currency' => q(𞤒𞤵𞤪𞤮𞥅),
				'one' => q(𞤴𞤵𞤪𞤮𞥅),
				'other' => q(𞤴𞤵𞤪𞤮𞥅𞤶𞤭),
			},
		},
		'FJD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤊𞤭𞤶𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤣𞤢𞤤𞤢 𞤊𞤭𞤶𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤣𞤢𞤤𞤢𞥄𞤶𞤭 𞤊𞤭𞤶𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'FKP' => {
			display_name => {
				'currency' => q(𞤆𞤢𞤱𞤲𞤣𞤵 𞤅𞤵𞤪𞤭𞥅𞤶𞤫 𞤊𞤢𞤤𞤳𞤵𞤤𞤢𞤲𞤣𞤭𞤳𞤮),
				'one' => q(𞤆𞤢𞤱𞤲𞤣𞤵 𞤅𞤵𞤪𞤭𞥅𞤶𞤫 𞤊𞤢𞤤𞤳𞤵𞤤𞤢𞤲𞤣𞤭𞤳𞤮),
				'other' => q(𞤆𞤢𞤱𞤯𞤭 𞤅𞤵𞤪𞤭𞥅𞤶𞤫 𞤊𞤢𞤤𞤳𞤵𞤤𞤢𞤲𞤣𞤭𞤳𞤮),
			},
		},
		'GBP' => {
			display_name => {
				'currency' => q(𞤆𞤢𞤱𞤲𞤣𞤵 𞤄𞤪𞤭𞤼𞤭𞥅𞤧𞤭𞤲𞤳𞤮),
				'one' => q(𞤆𞤢𞤱𞤲𞤣𞤵 𞤄𞤪𞤭𞤼𞤭𞥅𞤧𞤭𞤲𞤳𞤮),
				'other' => q(𞤆𞤢𞤱𞤯𞤭 𞤄𞤪𞤭𞤼𞤭𞥅𞤧𞤭𞤲𞤳𞤮),
			},
		},
		'GEL' => {
			display_name => {
				'currency' => q(𞤂𞤢𞥄𞤪𞤭 𞤔𞤮𞤪𞤶𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤤𞤢𞤪𞤭 𞤔𞤮𞤪𞤶𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤤𞤢𞤪𞤭𞥅𞤶𞤭 𞤔𞤮𞤪𞤶𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'GHS' => {
			display_name => {
				'currency' => q(𞤅𞤭𞤣𞤭 𞤘𞤢𞤲𞤢𞤲𞤳𞤮),
				'one' => q(𞤧𞤭𞤣𞤭 𞤘𞤢𞤲𞤢𞤲𞤳𞤮),
				'other' => q(𞤧𞤭𞤣𞤭𞥅𞤶𞤭 𞤘𞤢𞤲𞤢𞤲𞤳𞤮),
			},
		},
		'GIP' => {
			display_name => {
				'currency' => q(𞤆𞤢𞤱𞤲𞥋𞤣𞤵 𞤔𞤭𞤤𞤦𞤪𞤢𞤤𞤼𞤢𞤪),
				'one' => q(𞤆𞤢𞤱𞤲𞥋𞤣𞤵 𞤔𞤭𞤤𞤦𞤪𞤢𞤤𞤼𞤢𞤪),
				'other' => q(𞤆𞤢𞤱𞤯𞤭 𞤔𞤭𞤤𞤦𞤪𞤢𞤤𞤼𞤢𞤪),
			},
		},
		'GMD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢𞤧𞤭 𞤘𞤢𞤥𞤦𞤭𞤲𞤳𞤮),
				'one' => q(𞤣𞤢𞤤𞤢𞤧𞤭 𞤘𞤢𞤥𞤦𞤭𞤲𞤳𞤮),
				'other' => q(𞤣𞤢𞤤𞤢𞤧𞤭𞥅𞤶𞤭 𞤘𞤢𞤥𞤦𞤭𞤲𞤳𞤮),
			},
		},
		'GNF' => {
			symbol => 'FG',
			display_name => {
				'currency' => q(𞤊𞤢𞤪𞤢𞤲 𞤘𞤭𞤲𞤫𞤲𞤳𞤮),
				'one' => q(𞤬𞤢𞤪𞤢𞤲 𞤘𞤭𞤲𞤫𞤲𞤳𞤮),
				'other' => q(𞤬𞤢𞤪𞤢𞤲𞤶𞤭 𞤘𞤭𞤲𞤫𞤲𞤳𞤮),
			},
		},
		'GTQ' => {
			symbol => 'GTQ',
			display_name => {
				'currency' => q(𞤑𞤫𞤼𞤵𞥁𞤢𞤤 𞤘𞤵𞤱𞤢𞤼𞤫𞤥𞤢𞤤𞤢𞤲𞤳𞤮),
				'one' => q(𞤑𞤫𞤼𞤵𞥁𞤢𞤤 𞤘𞤵𞤱𞤢𞤼𞤫𞤥𞤢𞤤𞤢𞤲𞤳𞤮),
				'other' => q(𞤑𞤫𞤼𞤵𞥁𞤫 𞤘𞤵𞤱𞤢𞤼𞤫𞤥𞤢𞤤𞤢𞤲𞤳𞤮),
			},
		},
		'GYD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤘𞤵𞤴𞤢𞤲𞤫𞥅𞤧𞤭𞤲𞤳𞤮),
				'one' => q(𞤁𞤢𞤤𞤢 𞤘𞤵𞤴𞤢𞤲𞤫𞥅𞤧𞤭𞤲𞤳𞤮),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤘𞤵𞤴𞤢𞤲𞤫𞥅𞤧𞤭𞤲𞤳𞤮),
			},
		},
		'HKD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤖𞤮𞤲𞤳𞤮𞤲),
				'one' => q(𞤣𞤢𞤤𞤢 𞤖𞤮𞤲𞤳𞤮𞤲),
				'other' => q(𞤣𞤢𞤤𞤢𞥄𞤶𞤭 𞤖𞤮𞤲𞤳𞤮𞤲),
			},
		},
		'HNL' => {
			display_name => {
				'currency' => q(𞤂𞤫𞤥𞤨𞤭𞤪𞤢 𞤖𞤮𞤲𞤣𞤵𞤪𞤢𞤲𞤳𞤮),
				'one' => q(𞤂𞤫𞤥𞤨𞤭𞤪𞤢 𞤖𞤮𞤲𞤣𞤵𞤪𞤢𞤲𞤳𞤮),
				'other' => q(𞤂𞤫𞤥𞤨𞤭𞤪𞤢𞥄𞤶𞤭 𞤖𞤮𞤲𞤣𞤵𞤪𞤢𞤲𞤳𞤮),
			},
		},
		'HRK' => {
			display_name => {
				'currency' => q(𞤑𞤵𞤲𞤢 𞤑𞤵𞤪𞤢𞥄𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤑𞤵𞤲𞤢 𞤑𞤵𞤪𞤢𞥄𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤑𞤵𞤲𞤢𞥄𞤶𞤭 𞤑𞤵𞤪𞤢𞥄𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'HTG' => {
			display_name => {
				'currency' => q(𞤘𞤵𞥅𞤪𞤣𞤫 𞤖𞤢𞤴𞤼𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'HUF' => {
			symbol => 'HUF',
			display_name => {
				'currency' => q(𞤊𞤮𞤪𞤭𞤲𞤼𞤵 𞤖𞤵𞤲𞤺𞤢𞤪𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤊𞤮𞤪𞤭𞤲𞤼𞤵 𞤖𞤵𞤲𞤺𞤢𞤪𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤊𞤮𞤪𞤭𞤲𞤼𞤵𞥅𞤶𞤭 𞤖𞤵𞤲𞤺𞤢𞤪𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'IDR' => {
			display_name => {
				'currency' => q(𞤈𞤵𞤨𞤭𞤴𞤢 𞤋𞤲𞤣𞤮𞤲𞤫𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤵𞤨𞤭𞤴𞤢 𞤋𞤲𞤣𞤮𞤲𞤫𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤵𞤨𞤭𞤴𞤢𞥄𞤶𞤭 𞤋𞤲𞤣𞤮𞤲𞤫𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'ILS' => {
			display_name => {
				'currency' => q(𞤡𞤫𞤳𞤫𞤤 𞤋𞤧𞤪𞤢𞥄𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞥃𞤫𞤳𞤫𞤤 𞤋𞤧𞤪𞤢𞥄𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞥃𞤫𞤳𞤫𞤤𞤶𞤭 𞤋𞤧𞤪𞤢𞥄𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'INR' => {
			display_name => {
				'currency' => q(𞤈𞤵𞥅𞤨𞤭𞥅 𞤖𞤭𞤲𞤣𞤭𞤧𞤼𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤵𞥅𞤨𞤭𞥅 𞤖𞤭𞤲𞤣𞤭𞤧𞤼𞤢𞤲𞤳𞤮),
				'other' => q(𞤈𞤵𞥅𞤨𞤭𞥅𞤶𞤭 𞤖𞤭𞤲𞤣𞤭𞤧𞤼𞤢𞤲𞤳𞤮),
			},
		},
		'IQD' => {
			display_name => {
				'currency' => q(𞤁𞤭𞤲𞤢𞥄𞤪 𞤋𞤪𞤢𞥄𞤳𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤣𞤭𞤲𞤢𞥄𞤪 𞤋𞤪𞤢𞥄𞤹𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤣𞤭𞤲𞤢𞥄𞤪𞤶𞤭 𞤋𞤪𞤢𞥄𞤹𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'IRR' => {
			display_name => {
				'currency' => q(𞤈𞤭𞤴𞤢𞥄𞤤 𞤋𞤪𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤭𞤴𞤢𞥄𞤤 𞤋𞤪𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤭𞤴𞤢𞥄𞤤𞤶𞤭 𞤋𞤪𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'ISK' => {
			display_name => {
				'currency' => q(𞤑𞤮𞤪𞤮𞤲𞤢 𞤀𞤴𞤧𞤭𞤤𞤢𞤲𞤣𞤭𞤲𞤳𞤮),
				'one' => q(𞤑𞤮𞤪𞤮𞤲𞤢 𞤀𞤴𞤧𞤭𞤤𞤢𞤲𞤣𞤭𞤲𞤳𞤮),
				'other' => q(𞤑𞤮𞤪𞤮𞤲𞤢𞥄𞤶𞤭 𞤀𞤴𞤧𞤭𞤤𞤢𞤲𞤣𞤭𞤲𞤳𞤮),
			},
		},
		'JMD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤔𞤢𞤥𞤢𞤴𞤭𞤲𞤳𞤮),
				'one' => q(𞤁𞤢𞤤𞤢 𞤔𞤢𞤥𞤢𞤴𞤭𞤲𞤳𞤮),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤔𞤢𞤥𞤢𞤴𞤭𞤲𞤳𞤮),
			},
		},
		'JOD' => {
			display_name => {
				'currency' => q(𞤁𞤭𞤲𞤢𞥄𞤪 𞤔𞤮𞤪𞤣𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤣𞤭𞤲𞤢𞥄𞤪 𞤔𞤮𞤪𞤣𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤣𞤭𞤲𞤢𞥄𞤪𞤶𞤭 𞤔𞤮𞤪𞤣𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'JPY' => {
			display_name => {
				'currency' => q(𞤒𞤫𞤲 𞤔𞤢𞤨𞤢𞤲𞤳𞤮),
				'one' => q(𞤴𞤫𞤲 𞤔𞤢𞤨𞤢𞤲𞤳𞤮),
				'other' => q(𞤴𞤫𞤲𞤶𞤭 𞤔𞤢𞤨𞤢𞤲𞤳𞤮),
			},
		},
		'KES' => {
			display_name => {
				'currency' => q(𞤅𞤭𞤤𞤭𞤲 𞤑𞤫𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤧𞤭𞤤𞤭𞤲 𞤑𞤫𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤧𞤭𞤤𞤭𞤲𞤶𞤭 𞤑𞤫𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'KGS' => {
			display_name => {
				'currency' => q(𞤅𞤮𞤥𞤵 𞤑𞤭𞤪𞤺𞤭𞤧𞤼𞤢𞤲𞤭𞤲𞤳𞤮),
				'one' => q(𞤧𞤮𞤥𞤵 𞤑𞤭𞤪𞤺𞤭𞤧𞤼𞤢𞤲𞤭𞤲𞤳𞤮),
				'other' => q(𞤧𞤮𞤥𞤵𞥅𞤶𞤭 𞤑𞤭𞤪𞤺𞤭𞤧𞤼𞤢𞤲𞤭𞤲𞤳𞤮),
			},
		},
		'KHR' => {
			display_name => {
				'currency' => q(𞤈𞤭𞤴𞤢𞤤 𞤑𞤢𞤥𞤦𞤮𞤣𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤭𞤴𞤢𞤤 𞤑𞤢𞤥𞤦𞤮𞤣𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤭𞤴𞤢𞤤𞤶𞤭 𞤑𞤢𞤥𞤦𞤮𞤣𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'KMF' => {
			display_name => {
				'currency' => q(𞤊𞤢𞤪𞤢𞤲 𞤑𞤮𞤥𞤮𞤪𞤭𞤲𞤳𞤮),
				'one' => q(𞤬𞤢𞤪𞤢𞤲 𞤑𞤮𞤥𞤮𞤪𞤭𞤲𞤳𞤮),
				'other' => q(𞤬𞤢𞤪𞤢𞤲𞤶𞤭 𞤑𞤮𞤥𞤮𞤪𞤭𞤲𞤳𞤮),
			},
		},
		'KPW' => {
			display_name => {
				'currency' => q(𞤏𞤮𞤲 𞤁𞤮𞤱𞤣𞤮𞤱𞤪𞤭 𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤱𞤮𞤲 𞤁𞤮𞤱𞤣𞤮𞤱𞤪𞤭 𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤱𞤮𞤲𞤶𞤭 𞤁𞤮𞤱𞤣𞤮𞤱𞤪𞤭 𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'KRW' => {
			display_name => {
				'currency' => q(𞤱𞤮𞤲 𞤂𞤫𞤴𞤤𞤫𞤴𞤪𞤭 𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤱𞤮𞤲 𞤤𞤫𞤴𞤤𞤫𞤴𞤪𞤭 𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤱𞤮𞤲𞤶𞤭 𞤤𞤫𞤴𞤤𞤫𞤴𞤪𞤭 𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'KWD' => {
			display_name => {
				'currency' => q(𞤁𞤋𞤲𞤢𞥄𞤪 𞤑𞤵𞤱𞤢𞤴𞤼𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤣𞤋𞤲𞤢𞥄𞤪 𞤑𞤵𞤱𞤢𞤴𞤼𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤣𞤋𞤲𞤢𞥄𞤪𞤶𞤭 𞤑𞤵𞤱𞤢𞤴𞤼𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'KYD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤅𞤵𞤪𞤭𞥅𞤶𞤫 𞤑𞤢𞤴𞤥𞤢𞥄𞤲),
				'one' => q(𞤁𞤢𞤤𞤢 𞤅𞤵𞤪𞤭𞥅𞤶𞤫 𞤑𞤢𞤴𞤥𞤢𞥄𞤲),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤅𞤵𞤪𞤭𞥅𞤶𞤫 𞤑𞤢𞤴𞤥𞤢𞥄𞤲),
			},
		},
		'KZT' => {
			display_name => {
				'currency' => q(𞤚𞤫𞤲𞤺𞤫 𞤑𞤢𞥁𞤢𞤳𞤭𞤧𞤼𞤢𞤲𞤭𞤲𞤳𞤮),
				'one' => q(𞤼𞤫𞤲𞤺𞤫 𞤑𞤢𞥁𞤢𞤳𞤭𞤧𞤼𞤢𞤲𞤭𞤲𞤳𞤮),
				'other' => q(𞤚𞤫𞤲𞤺𞤫𞥅𞤶𞤭 𞤑𞤢𞥁𞤢𞤳𞤭𞤧𞤼𞤢𞤲𞤭𞤲𞤳𞤮),
			},
		},
		'LAK' => {
			display_name => {
				'currency' => q(𞤑𞤭𞤨𞤵 𞤂𞤢𞤱𞤮𞥅𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤳𞤭𞤨𞤵 𞤂𞤢𞤱𞤮𞥅𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤳𞤭𞤨𞤵𞥅𞤶𞤭 𞤂𞤢𞤱𞤮𞥅𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'LBP' => {
			display_name => {
				'currency' => q(𞤆𞤢𞤱𞤲𞥋𞤣𞤵 𞤂𞤭𞤦𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤨𞤢𞤱𞤲𞥋𞤣𞤵 𞤂𞤭𞤦𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤨𞤢𞤱𞤯𞤭 𞤂𞤭𞤦𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'LKR' => {
			display_name => {
				'currency' => q(𞤈𞤵𞥅𞤨𞤭𞥅 𞤅𞤭𞤪𞤭-𞤂𞤢𞤲𞤳𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤵𞥅𞤨𞤭𞥅 𞤅𞤭𞤪𞤭-𞤂𞤢𞤲𞤳𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤵𞥅𞤨𞤭𞥅𞤶𞤭 𞤅𞤭𞤪𞤭-𞤂𞤢𞤲𞤳𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'LRD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤂𞤭𞤦𞤫𞤪𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤣𞤢𞤤𞤢 𞤂𞤭𞤦𞤫𞤪𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤣𞤢𞤤𞤢𞥄𞤶𞤭 𞤂𞤭𞤦𞤫𞤪𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'LYD' => {
			display_name => {
				'currency' => q(𞤁𞤭𞤲𞤢𞥄𞤪 𞤂𞤭𞤦𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤣𞤭𞤲𞤢𞥄𞤪 𞤂𞤭𞤦𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤣𞤭𞤲𞤢𞥄𞤪𞤶𞤭 𞤂𞤭𞤦𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'MAD' => {
			display_name => {
				'currency' => q(𞤁𞤭𞤪𞤸𞤢𞤥𞤵 𞤃𞤮𞤪𞤮𞤳𞤢𞤲𞤳𞤮),
				'one' => q(𞤣𞤭𞤪𞤸𞤢𞤥𞤵 𞤃𞤮𞤪𞤮𞤳𞤢𞤲𞤳𞤮),
				'other' => q(𞤁𞤭𞤪𞤸𞤢𞤥𞤵𞥅𞤶𞤭 𞤃𞤮𞤪𞤮𞤳𞤢𞤲𞤳𞤮),
			},
		},
		'MDL' => {
			symbol => 'MDL',
			display_name => {
				'currency' => q(𞤂𞤭𞥅𞤱𞤮 𞤃𞤮𞤤𞤣𞤮𞤾𞤢𞤲𞤳𞤮),
				'one' => q(𞤤𞤭𞥅𞤱𞤮 𞤃𞤮𞤤𞤣𞤮𞤾𞤢𞤲𞤳𞤮),
				'other' => q(𞤤𞤭𞥅𞤱𞤮𞥅𞤶𞤭 𞤃𞤮𞤤𞤣𞤮𞤾𞤢𞤲𞤳𞤮),
			},
		},
		'MGA' => {
			display_name => {
				'currency' => q(𞤀𞤪𞤭𞤴𞤢𞤪𞤭 𞤃𞤢𞤤𞤺𞤢𞤲𞤭𞤲𞤳𞤮),
				'one' => q(𞤢𞤪𞤭𞤴𞤢𞤪𞤭 𞤃𞤢𞤤𞤺𞤢𞤲𞤭𞤲𞤳𞤮),
				'other' => q(𞤀𞤪𞤭𞤴𞤢𞤪𞤭𞥅𞤶𞤭 𞤃𞤢𞤤𞤺𞤢𞤲𞤭𞤲𞤳𞤮),
			},
		},
		'MKD' => {
			display_name => {
				'currency' => q(𞤁𞤭𞤲𞤢𞥄𞤪 𞤃𞤢𞤧𞤫𞤣𞤮𞤲𞤭𞤲𞤳𞤮),
				'one' => q(𞤁𞤭𞤲𞤢𞥄𞤪 𞤃𞤢𞤧𞤫𞤣𞤮𞤲𞤭𞤲𞤳𞤮),
				'other' => q(𞤁𞤭𞤲𞤢𞥄𞤪𞤶𞤭 𞤃𞤢𞤧𞤫𞤣𞤮𞤲𞤭𞤲𞤳𞤮),
			},
		},
		'MMK' => {
			display_name => {
				'currency' => q(𞤑𞤭𞤴𞤢𞤼𞤵 𞤃𞤭𞤴𞤢𞤥𞤢𞤪𞤭𞤲𞤳𞤮),
				'one' => q(𞤳𞤭𞤴𞤢𞤼𞤵 𞤃𞤭𞤴𞤢𞤥𞤢𞤪𞤭𞤲𞤳𞤮),
				'other' => q(𞤳𞤭𞤴𞤢𞤼𞤵𞥅𞤶𞤭 𞤃𞤭𞤴𞤢𞤥𞤢𞤪𞤭𞤲𞤳𞤮),
			},
		},
		'MNT' => {
			display_name => {
				'currency' => q(𞤚𞤵𞤺𞤵𞤪𞤭𞤳𞤵 𞤃𞤮𞤲𞤺𞤮𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤼𞤵𞤺𞤵𞤪𞤭𞤳𞤵 𞤃𞤮𞤲𞤺𞤮𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤚𞤵𞤺𞤵𞤪𞤭𞤳𞤵𞥅𞤶𞤭 𞤃𞤮𞤲𞤺𞤮𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'MOP' => {
			display_name => {
				'currency' => q(𞤆𞤢𞤼𞤢𞤳𞤢 𞤃𞤢𞤳𞤢𞤱𞤮𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤨𞤢𞤼𞤢𞤳𞤢 𞤃𞤢𞤳𞤢𞤱𞤮𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤨𞤢𞤼𞤢𞤳𞤢𞥄𞤶𞤭 𞤃𞤢𞤳𞤢𞤱𞤮𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'MRO' => {
			display_name => {
				'currency' => q(𞤓𞤺𞤭𞤴𞤢 𞤃𞤮𞤪𞤭𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮 \(𞥑𞥙𞥗𞥓 - 𞥒𞥐𞥑𞥗\)),
				'one' => q(𞤵𞤺𞤭𞤴𞤢 𞤃𞤮𞤪𞤭𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮 \(𞥑𞥙𞥗𞥓 - 𞥒𞥐𞥑𞥗\)),
				'other' => q(𞤵𞤺𞤭𞤴𞤢 𞤃𞤮𞤪𞤭𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮 \(𞥑𞥙𞥗𞥓 - 𞥒𞥐𞥑𞥗\)),
			},
		},
		'MRU' => {
			display_name => {
				'currency' => q(𞤓𞤺𞤭𞤴𞤢 𞤃𞤮𞤪𞤭𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤵𞤺𞤭𞤴𞤢 𞤃𞤮𞤪𞤭𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤵𞤺𞤭𞤴𞤢𞥄𞤶𞤭 𞤃𞤮𞤪𞤭𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'MUR' => {
			display_name => {
				'currency' => q(𞤈𞤵𞤨𞤭𞥅 𞤃𞤮𞤪𞤭𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤵𞤨𞤭𞥅 𞤃𞤮𞤪𞤭𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤵𞤨𞤭𞥅𞤶𞤭 𞤃𞤮𞤪𞤭𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'MVR' => {
			display_name => {
				'currency' => q(𞤈𞤵𞤬𞤭𞤴𞤢𞥄 𞤃𞤢𞤤𞤣𞤭𞤾𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤵𞤬𞤭𞤴𞤢𞥄 𞤃𞤢𞤤𞤣𞤭𞤾𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤵𞤬𞤭𞤴𞤢𞥄𞤶𞤭 𞤃𞤢𞤤𞤣𞤭𞤾𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'MWK' => {
			display_name => {
				'currency' => q(𞤑𞤢𞤱𞤢𞤷𞤢 𞤃𞤢𞤤𞤢𞤱𞤭𞤲𞤳𞤮),
				'one' => q(𞤳𞤢𞤱𞤢𞤷𞤢 𞤃𞤢𞤤𞤢𞤱𞤭𞤲𞤳𞤮),
				'other' => q(𞤳𞤢𞤱𞤢𞤷𞤢𞥄𞤶𞤭 𞤃𞤢𞤤𞤢𞤱𞤭𞤲𞤳𞤮),
			},
		},
		'MXN' => {
			display_name => {
				'currency' => q(𞤆𞤫𞤧𞤮 𞤃𞤫𞤳𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤆𞤫𞤧𞤮 𞤃𞤫𞤳𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤆𞤫𞤧𞤮𞥅𞤶𞤭 𞤃𞤫𞤳𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'MYR' => {
			display_name => {
				'currency' => q(𞤈𞤭𞤲𞤺𞤵𞤼𞤵 𞤃𞤢𞤤𞤫𞥅𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤭𞤲𞤺𞤵𞤼𞤵 𞤃𞤢𞤤𞤫𞥅𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤭𞤲𞤺𞤵𞤼𞤵𞥅𞤶𞤭 𞤃𞤢𞤤𞤫𞥅𞤧𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'MZN' => {
			display_name => {
				'currency' => q(𞤃𞤫𞤼𞤭𞤳𞤮𞤤 𞤃𞤮𞥁𞤢𞤥𞤦𞤭𞤲𞤳𞤮),
				'one' => q(𞤥𞤫𞤼𞤭𞤳𞤮𞤤 𞤃𞤮𞥁𞤢𞤥𞤦𞤭𞤲𞤳𞤮),
				'other' => q(𞤥𞤫𞤼𞤭𞤳𞤮𞤤𞤶𞤭 𞤃𞤮𞥁𞤢𞤥𞤦𞤭𞤲𞤳𞤮),
			},
		},
		'NAD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤐𞤢𞤥𞤭𞤥𞤦𞤭𞤲𞤳𞤮),
				'one' => q(𞤣𞤢𞤤𞤢 𞤐𞤢𞤥𞤭𞤥𞤦𞤭𞤲𞤳𞤮),
				'other' => q(𞤣𞤢𞤤𞤢𞥄𞤶𞤭 𞤐𞤢𞤥𞤭𞤥𞤦𞤭𞤲𞤳𞤮),
			},
		},
		'NGN' => {
			symbol => '𞤐𞤐𞤘',
			display_name => {
				'currency' => q(𞤐𞤢𞤴𞤪𞤢 𞤐𞤢𞤶𞤭𞤪𞤢𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤲𞤢𞤴𞤪𞤢 𞤐𞤢𞤶𞤭𞤪𞤢𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤲𞤢𞤴𞤪𞤢𞥄𞤶𞤭 𞤐𞤢𞤶𞤭𞤪𞤢𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'NIO' => {
			symbol => 'NIO',
			display_name => {
				'currency' => q(𞤑𞤮𞥅𞤪𞤣𞤮𞤦𞤢 𞤐𞤭𞤳𞤢𞤪𞤢𞤺𞤵𞤱𞤢𞤲𞤳𞤮),
				'one' => q(𞤑𞤮𞥅𞤪𞤣𞤮𞤦𞤢 𞤐𞤭𞤳𞤢𞤪𞤢𞤺𞤵𞤱𞤢𞤲𞤳𞤮),
				'other' => q(𞤑𞤮𞥅𞤪𞤣𞤮𞤦𞤢𞥄𞤶𞤭 𞤐𞤭𞤳𞤢𞤪𞤢𞤺𞤵𞤱𞤢𞤲𞤳𞤮),
			},
		},
		'NOK' => {
			display_name => {
				'currency' => q(𞤑𞤪𞤮𞤲𞤫 𞤐𞤮𞤪𞤱𞤫𞤶𞤭𞤲𞤳𞤮),
				'one' => q(𞤑𞤪𞤮𞤲𞤫 𞤐𞤮𞤪𞤱𞤫𞤶𞤭𞤲𞤳𞤮),
				'other' => q(𞤑𞤪𞤮𞤲𞤫𞥅𞤶𞤭 𞤀𞤴𞤧𞤭𞤤𞤢𞤲𞤣𞤭𞤲𞤳𞤮),
			},
		},
		'NPR' => {
			display_name => {
				'currency' => q(𞤈𞤵𞥅𞤨𞤭𞥅 𞤐𞤫𞤨𞤢𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤵𞥅𞤨𞤭𞥅 𞤐𞤫𞤨𞤢𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤵𞥅𞤨𞤭𞥅𞤶𞤭 𞤐𞤫𞤨𞤢𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'NZD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤐𞤫𞤱 𞤟𞤫𞤤𞤢𞤲𞤣),
				'one' => q(𞤣𞤢𞤤𞤢 𞤐𞤫𞤱 𞤟𞤫𞤤𞤢𞤲𞤣),
				'other' => q(𞤣𞤢𞤤𞤢𞥄𞤶𞤭 𞤐𞤫𞤱 𞤟𞤫𞤤𞤢𞤲𞤣),
			},
		},
		'OMR' => {
			display_name => {
				'currency' => q(𞤈𞤭𞤴𞤢𞥄𞤤 𞤌𞤥𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤭𞤴𞤢𞥄𞤤 𞤌𞤥𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤭𞤴𞤢𞥄𞤤𞤶𞤭 𞤌𞤥𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'PAB' => {
			display_name => {
				'currency' => q(𞤄𞤢𞤤𞤦𞤮𞤱𞤢 𞤆𞤢𞤲𞤢𞤥𞤢𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤄𞤢𞤤𞤦𞤮𞤱𞤢 𞤆𞤢𞤲𞤢𞤥𞤢𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤄𞤢𞤤𞤦𞤮𞤱𞤢𞥄𞤶𞤭 𞤆𞤢𞤲𞤢𞤥𞤢𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'PEN' => {
			display_name => {
				'currency' => q(𞤅𞤮𞤤 𞤆𞤫𞤪𞤵𞤲𞤳𞤮),
				'one' => q(𞤅𞤮𞤤 𞤆𞤫𞤪𞤵𞤲𞤳𞤮),
				'other' => q(𞤅𞤮𞤤𞤶𞤭 𞤆𞤫𞤪𞤵𞤲𞤳𞤮),
			},
		},
		'PGK' => {
			symbol => '𞤑𞤆𞤘',
			display_name => {
				'currency' => q(𞤑𞤭𞤲𞤢 𞤆𞤢𞤨𞤵𞤱𞤢 𞤐𞤫𞤱-𞤘𞤭𞤲𞤫𞤲𞤳𞤮),
				'one' => q(𞤳𞤭𞤲𞤢 𞤆𞤢𞤨𞤵𞤱𞤢 𞤐𞤫𞤱-𞤘𞤭𞤲𞤫𞤲𞤳𞤮),
				'other' => q(𞤳𞤭𞤲𞤢𞥄𞤶𞤭 𞤆𞤢𞤨𞤵𞤱𞤢 𞤐𞤫𞤱-𞤘𞤭𞤲𞤫𞤲𞤳𞤮),
			},
		},
		'PHP' => {
			symbol => '𞤆𞤆𞤖',
			display_name => {
				'currency' => q(𞤆𞤭𞤧𞤮 𞤊𞤭𞤤𞤭𞤨𞥆𞤭𞤲𞤳𞤮),
				'one' => q(𞤨𞤭𞤧𞤮 𞤊𞤭𞤤𞤭𞤨𞥆𞤭𞤲𞤳𞤮),
				'other' => q(𞤨𞤭𞤧𞤮𞥅𞤶𞤭 𞤊𞤭𞤤𞤭𞤨𞥆𞤭𞤲𞤳𞤮),
			},
		},
		'PKR' => {
			display_name => {
				'currency' => q(𞤈𞤵𞥅𞤨𞤭𞥅 𞤆𞤢𞤳𞤭𞤧𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤵𞥅𞤨𞤭𞥅 𞤆𞤢𞤳𞤭𞤧𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤵𞥅𞤨𞤭𞥅𞤶𞤭 𞤆𞤢𞤳𞤭𞤧𞤼𞤢𞤲𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'PLN' => {
			symbol => 'PLN',
			display_name => {
				'currency' => q(𞤔𞤢𞤤𞤮𞤼𞤵 𞤆𞤮𞤤𞤭𞥅𞤧𞤭𞤲𞤳𞤮),
				'one' => q(𞤔𞤢𞤤𞤮𞤼𞤵 𞤆𞤮𞤤𞤭𞥅𞤧𞤭𞤲𞤳𞤮),
				'other' => q(𞤔𞤢𞤤𞤮𞤼𞤵𞥅𞤶𞤭 𞤆𞤮𞤤𞤭𞥅𞤧𞤭𞤲𞤳𞤮),
			},
		},
		'PYG' => {
			display_name => {
				'currency' => q(𞤘𞤵𞤱𞤢𞤪𞤢𞤲𞤭 𞤆𞤢𞥄𞤪𞤢𞤺𞤵𞤴𞤫𞤲𞤳𞤮),
				'one' => q(𞤘𞤵𞤱𞤢𞤪𞤢𞤲𞤭 𞤆𞤢𞥄𞤪𞤢𞤺𞤵𞤴𞤫𞤲𞤳𞤮),
				'other' => q(𞤘𞤵𞤱𞤢𞤪𞤢𞤲𞤭𞥅𞤶𞤭 𞤆𞤢𞥄𞤪𞤢𞤺𞤵𞤴𞤫𞤲𞤳𞤮),
			},
		},
		'QAR' => {
			display_name => {
				'currency' => q(𞤈𞤭𞤴𞤢𞥄𞤤 𞤗𞤢𞤼𞤢𞤪𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤭𞤴𞤢𞥄𞤤 𞤗𞤢𞤼𞤢𞤪𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤭𞤴𞤢𞥄𞤤𞤶𞤭 𞤗𞤢𞤼𞤢𞤪𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'RON' => {
			display_name => {
				'currency' => q(𞤂𞤫𞤱𞤵 𞤈𞤮𞤥𞤢𞤲𞤭𞤲𞤳𞤮),
				'one' => q(𞤤𞤫𞤱𞤵 𞤈𞤮𞤥𞤢𞤲𞤭𞤲𞤳𞤮),
				'other' => q(𞤂𞤫𞤱𞤵𞥅𞤶𞤭 𞤈𞤮𞤥𞤢𞤲𞤭𞤲𞤳𞤮),
			},
		},
		'RSD' => {
			display_name => {
				'currency' => q(𞤁𞤭𞤲𞤢𞥄𞤪 𞤅𞤫𞤪𞤦𞤭𞤲𞤳𞤮),
				'one' => q(𞤁𞤭𞤲𞤢𞥄𞤪 𞤅𞤫𞤪𞤦𞤭𞤲𞤳𞤮),
				'other' => q(𞤁𞤭𞤲𞤢𞥄𞤪𞤶𞤭 𞤅𞤫𞤪𞤦𞤭𞤲𞤳𞤮),
			},
		},
		'RUB' => {
			display_name => {
				'currency' => q(𞤈𞤵𞥅𞤦𞤮𞤤 𞤈𞤭𞥅𞤧𞤭𞤲𞤳𞤮),
				'one' => q(𞤈𞤵𞥅𞤦𞤮𞤤 𞤈𞤭𞥅𞤧𞤭𞤲𞤳𞤮),
				'other' => q(𞤈𞤵𞥅𞤦𞤮𞤤𞤶𞤭 𞤈𞤭𞥅𞤧𞤭𞤲𞤳𞤮),
			},
		},
		'RWF' => {
			display_name => {
				'currency' => q(𞤊𞤢𞤪𞤢𞤲 𞤈𞤵𞤱𞤢𞤲𞤣𞤢𞤲𞤳𞤮),
				'one' => q(𞤬𞤢𞤪𞤢𞤲 𞤈𞤵𞤱𞤢𞤲𞤣𞤢𞤲𞤳𞤮),
				'other' => q(𞤬𞤢𞤪𞤢𞤲𞤶𞤭 𞤈𞤵𞤱𞤢𞤲𞤣𞤢𞤲𞤳𞤮),
			},
		},
		'SAR' => {
			display_name => {
				'currency' => q(𞤈𞤭𞤴𞤢𞤤 𞤅𞤢𞤵𞥅𞤣𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤭𞤴𞤢𞤤 𞤅𞤢𞤵𞥅𞤣𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤭𞤴𞤢𞤤𞤶𞤭 𞤅𞤢𞤵𞥅𞤣𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'SBD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤅𞤵𞤤𞤢𞤴𞤥𞤢𞥄𞤲),
				'one' => q(𞤣𞤢𞤤𞤢 𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤅𞤵𞤤𞤢𞤴𞤥𞤢𞥄𞤲),
				'other' => q(𞤣𞤢𞤤𞤢𞥄𞤶𞤭 𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤅𞤵𞤤𞤢𞤴𞤥𞤢𞥄𞤲),
			},
		},
		'SCR' => {
			display_name => {
				'currency' => q(𞤈𞤵𞤨𞤭𞥅 𞤅𞤫𞤴𞤧𞤭𞤤𞤭𞤲𞤳𞤮),
				'one' => q(𞤪𞤵𞤨𞤭𞥅 𞤅𞤫𞤴𞤧𞤭𞤤𞤭𞤲𞤳𞤮),
				'other' => q(𞤪𞤵𞤨𞤭𞥅𞤶𞤭 𞤅𞤫𞤴𞤧𞤭𞤤𞤭𞤲𞤳𞤮),
			},
		},
		'SDG' => {
			display_name => {
				'currency' => q(𞤆𞤢𞤱𞤲𞤣𞤵 𞤅𞤵𞤣𞤢𞤲𞤳𞤮),
				'one' => q(𞤨𞤢𞤱𞤲𞤣𞤵 𞤅𞤵𞤣𞤢𞤲𞤳𞤮),
				'other' => q(𞤨𞤢𞤱𞤯𞤭 𞤅𞤵𞤣𞤢𞤲𞤳𞤮),
			},
		},
		'SEK' => {
			display_name => {
				'currency' => q(𞤑𞤪𞤮𞤲𞤢 𞤅𞤵𞤱𞤫𞤣𞤭𞤲𞤳𞤮),
				'one' => q(𞤑𞤪𞤮𞤲𞤢 𞤅𞤵𞤱𞤫𞤣𞤭𞤲𞤳𞤮),
				'other' => q(𞤑𞤪𞤮𞤲𞤢𞥄𞤶𞤭 𞤅𞤵𞤱𞤫𞤣𞤭𞤲𞤳𞤮),
			},
		},
		'SGD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤅𞤭𞤲𞤺𞤢𞤨𞤮𞤪𞤫𞤲𞤳𞤮),
				'one' => q(𞤣𞤢𞤤𞤢 𞤅𞤭𞤲𞤺𞤢𞤨𞤮𞤪𞤫𞤲𞤳𞤮),
				'other' => q(𞤣𞤢𞤤𞤢𞥄𞤶𞤭 𞤅𞤭𞤲𞤺𞤢𞤨𞤮𞤪𞤫𞤲𞤳𞤮),
			},
		},
		'SHP' => {
			display_name => {
				'currency' => q(𞤆𞤢𞤱𞤲𞤣𞤵 𞤅𞤫𞤲-𞤖𞤫𞤤𞤫𞤲𞤢),
				'one' => q(𞤨𞤢𞤱𞤲𞤣𞤵 𞤅𞤫𞤲-𞤖𞤫𞤤𞤫𞤲𞤢),
				'other' => q(𞤆𞤢𞤱𞤯𞤭 𞤅𞤫𞤲-𞤖𞤫𞤤𞤫𞤲𞤢),
			},
		},
		'SLL' => {
			display_name => {
				'currency' => q(𞤂𞤫𞤴𞤮𞤲 𞤅𞤫𞤪𞤢𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤤𞤫𞤴𞤮𞤲 𞤅𞤫𞤪𞤢𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤤𞤫𞤴𞤮𞤲𞤶𞤭 𞤅𞤫𞤪𞤢𞤤𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'SOS' => {
			display_name => {
				'currency' => q(𞤅𞤭𞤤𞤭𞤲 𞤅𞤮𞤥𞤢𞤤𞤭𞤲𞤳𞤮),
				'one' => q(𞤧𞤭𞤤𞤭𞤲 𞤅𞤮𞤥𞤢𞤤𞤭𞤲𞤳𞤮),
				'other' => q(𞤧𞤭𞤤𞤭𞤲𞤶𞤭 𞤅𞤮𞤥𞤢𞤤𞤭𞤲𞤳𞤮),
			},
		},
		'SRD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤅𞤵𞤪𞤵𞤲𞤢𞤥𞤭𞤲𞤳𞤮),
				'one' => q(𞤁𞤢𞤤𞤢 𞤅𞤵𞤪𞤵𞤲𞤢𞤥𞤭𞤲𞤳𞤮),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤅𞤵𞤪𞤵𞤲𞤢𞤥𞤭𞤲𞤳𞤮),
			},
		},
		'SSP' => {
			display_name => {
				'currency' => q(𞤆𞤢𞤱𞤲𞤣𞤵 𞤂𞤫𞤴𞤤𞤫𞤴𞤪𞤭 𞤅𞤵𞤣𞤢𞤲𞤭𞤲𞤳𞤮),
				'one' => q(𞤨𞤢𞤱𞤲𞤣𞤵 𞤂𞤫𞤴𞤤𞤫𞤴𞤪𞤭 𞤅𞤵𞤣𞤢𞤲𞤭𞤲𞤳𞤮),
				'other' => q(𞤨𞤢𞤱𞤯𞤭 𞤂𞤫𞤴𞤤𞤫𞤴𞤪𞤭 𞤅𞤵𞤣𞤢𞤲𞤭𞤲𞤳𞤮),
			},
		},
		'STN' => {
			display_name => {
				'currency' => q(𞤁𞤮𞤦𞤢𞤪𞤢 𞤅𞤢𞤱𞤮-𞤚𞤮𞤥𞤫 & 𞤆𞤫𞤪𞤫𞤲𞤧𞤭𞤨),
				'one' => q(𞤣𞤮𞤦𞤢𞤪𞤢 𞤅𞤢𞤱𞤮-𞤚𞤮𞤥𞤫 & 𞤆𞤫𞤪𞤫𞤲𞤧𞤭𞤨),
				'other' => q(𞤣𞤮𞤦𞤢𞤪𞤢𞥄𞤶𞤭 𞤅𞤢𞤱𞤮-𞤚𞤮𞤥𞤫 & 𞤆𞤫𞤪𞤫𞤲𞤧𞤭𞤨),
			},
		},
		'SYP' => {
			display_name => {
				'currency' => q(𞤆𞤢𞤱𞤲𞥋𞤣𞤵 𞤅𞤭𞤪𞤢𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤨𞤢𞤱𞤲𞥋𞤣𞤵 𞤅𞤭𞤪𞤢𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤨𞤢𞤱𞤯𞤭 𞤅𞤭𞤪𞤢𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'SZL' => {
			display_name => {
				'currency' => q(𞤂𞤭𞤤𞤢𞤲𞤺𞤫𞤲𞤭 𞤅𞤵𞤱𞤢𞤶𞤭),
				'one' => q(𞤤𞤭𞤤𞤢𞤲𞤺𞤫𞤲𞤭 𞤅𞤵𞤱𞤢𞤶𞤭),
				'other' => q(𞤤𞤭𞤤𞤢𞤲𞤺𞤫𞤲𞤭𞥅𞤶𞤭 𞤅𞤵𞤱𞤢𞤶𞤭),
			},
		},
		'THB' => {
			display_name => {
				'currency' => q(𞤄𞤢𞤸𞤼𞤵 𞤚𞤢𞤴𞤤𞤢𞤲𞤣𞤭𞤲𞤳𞤮),
				'one' => q(𞤦𞤢𞤸𞤼𞤵 𞤚𞤢𞤴𞤤𞤢𞤲𞤣𞤭𞤲𞤳𞤮),
				'other' => q(𞤦𞤢𞤸𞤼𞤵𞥅𞤶𞤭 𞤚𞤢𞤴𞤤𞤢𞤲𞤣𞤭𞤲𞤳𞤮),
			},
		},
		'TJS' => {
			display_name => {
				'currency' => q(𞤅𞤢𞤥𞤮𞥅𞤲𞤭 𞤚𞤢𞤶𞤭𞤳𞤭𞤧𞤼𞤢𞤲𞤳𞤮),
				'one' => q(𞤧𞤢𞤥𞤮𞥅𞤲𞤭 𞤚𞤢𞤶𞤭𞤳𞤭𞤧𞤼𞤢𞤲𞤳𞤮),
				'other' => q(𞤧𞤢𞤥𞤮𞥅𞤲𞤭𞥅𞤶𞤭 𞤚𞤢𞤶𞤭𞤳𞤭𞤧𞤼𞤢𞤲𞤳𞤮),
			},
		},
		'TMT' => {
			display_name => {
				'currency' => q(𞤃𞤢𞤲𞤢𞤼𞤵 𞤚𞤵𞤪𞤳𞤵𞤥𞤫𞤲𞤭𞤧𞤼𞤢𞤲𞤳𞤮),
				'one' => q(𞤥𞤢𞤲𞤢𞤼𞤵 𞤚𞤵𞤪𞤳𞤵𞤥𞤫𞤲𞤭𞤧𞤼𞤢𞤲𞤳𞤮),
				'other' => q(𞤥𞤢𞤲𞤢𞤼𞤵𞥅𞤶𞤭 𞤚𞤵𞤪𞤳𞤵𞤥𞤫𞤲𞤭𞤧𞤼𞤢𞤲𞤳𞤮),
			},
		},
		'TND' => {
			display_name => {
				'currency' => q(𞤁𞤭𞤲𞤢𞥄𞤪 𞤚𞤵𞥅𞤲𞤭𞤧𞤭𞤲𞤳𞤮),
				'one' => q(𞤣𞤭𞤲𞤢𞥄𞤪 𞤚𞤵𞥅𞤲𞤭𞤧𞤭𞤲𞤳𞤮),
				'other' => q(𞤣𞤭𞤲𞤢𞥄𞤪𞤶𞤭 𞤚𞤵𞥅𞤲𞤭𞤧𞤭𞤲𞤳𞤮),
			},
		},
		'TOP' => {
			display_name => {
				'currency' => q(𞤆𞤢𞤢𞤲𞤺𞤢 𞤚𞤮𞤲𞤺𞤢𞤲𞤳𞤮),
				'one' => q(𞤨𞤢𞤢𞤲𞤺𞤢 𞤚𞤮𞤲𞤺𞤢𞤲𞤳𞤮),
				'other' => q(𞤨𞤢𞤢𞤲𞤺𞤢𞥄𞤶𞤭 𞤚𞤮𞤲𞤺𞤢𞤲𞤳𞤮),
			},
		},
		'TRY' => {
			display_name => {
				'currency' => q(𞤂𞤭𞤪𞤢 𞤚𞤵𞤪𞤳𞤭𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤤𞤭𞤪𞤢 𞤚𞤵𞤪𞤳𞤭𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤤𞤭𞤪𞤢𞥄𞤶𞤭 𞤚𞤵𞤪𞤳𞤭𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'TTD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤚𞤭𞤪𞤲𞤭𞤣𞤢𞥄𞤣 & 𞤚𞤮𞤦𞤢𞤺𞤮),
				'one' => q(𞤁𞤢𞤤𞤢 𞤚𞤭𞤪𞤲𞤭𞤣𞤢𞥄𞤣 & 𞤚𞤮𞤦𞤢𞤺𞤮),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤚𞤭𞤪𞤲𞤭𞤣𞤢𞥄𞤣 & 𞤚𞤮𞤦𞤢𞤺𞤮),
			},
		},
		'TWD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤚𞤢𞤴𞤱𞤢𞥄𞤲𞤳𞤮),
				'one' => q(𞤣𞤢𞤤𞤢 𞤚𞤢𞤴𞤱𞤢𞥄𞤲𞤳𞤮),
				'other' => q(𞤣𞤢𞤤𞤢𞥄𞤶𞤭 𞤚𞤢𞤴𞤱𞤢𞥄𞤲𞤳𞤮),
			},
		},
		'TZS' => {
			display_name => {
				'currency' => q(𞤅𞤭𞤤𞤭𞤲 𞤚𞤢𞤲𞥁𞤢𞤲𞤭𞤲𞤳𞤮),
				'one' => q(𞤧𞤭𞤤𞤭𞤲 𞤚𞤢𞤲𞥁𞤢𞤲𞤭𞤲𞤳𞤮),
				'other' => q(𞤧𞤭𞤤𞤭𞤲𞤶𞤭 𞤚𞤢𞤲𞥁𞤢𞤲𞤭𞤲𞤳𞤮),
			},
		},
		'UAH' => {
			display_name => {
				'currency' => q(𞤖𞤵𞤪𞤢𞤾𞤫𞤲𞤭𞤴𞤢 𞤒𞤵𞤳𞤫𞤪𞤫𞥅𞤲𞤭𞤲𞤳𞤮),
				'one' => q(𞤖𞤵𞤪𞤢𞤾𞤫𞤲𞤭𞤴𞤢 𞤒𞤵𞤳𞤫𞤪𞤫𞥅𞤲𞤭𞤲𞤳𞤮),
				'other' => q(𞤖𞤵𞤪𞤢𞤾𞤫𞤲𞤭𞤴𞤢𞥄𞤶𞤭 𞤒𞤵𞤳𞤫𞤪𞤫𞥅𞤲𞤭𞤲𞤳𞤮),
			},
		},
		'UGX' => {
			display_name => {
				'currency' => q(𞤅𞤭𞤤𞤭𞤲 𞤓𞤺𞤢𞤲𞤣𞤢𞤲𞤳𞤮),
				'one' => q(𞤧𞤭𞤤𞤭𞤲 𞤓𞤺𞤢𞤲𞤣𞤢𞤲𞤳𞤮),
				'other' => q(𞤧𞤭𞤤𞤭𞤲𞤶𞤭 𞤓𞤺𞤢𞤲𞤣𞤢𞤲𞤳𞤮),
			},
		},
		'USD' => {
			symbol => 'US$',
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤁𞤫𞤲𞤼𞤢𞤤 𞤂𞤢𞤪𞤫 𞤀𞤥𞤫𞤪𞤭𞤳),
				'one' => q(𞤁𞤢𞤤𞤢 𞤁𞤫𞤲𞤼𞤢𞤤 𞤂𞤢𞤪𞤫 𞤀𞤥𞤫𞤪𞤭𞤳),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤁𞤫𞤲𞤼𞤢𞤤 𞤂𞤢𞤪𞤫 𞤀𞤥𞤫𞤪𞤭𞤳),
			},
		},
		'UYU' => {
			display_name => {
				'currency' => q(𞤆𞤫𞤧𞤮 𞤓𞤪𞤵𞤺𞤵𞤪𞤭𞤲𞤳𞤮),
				'one' => q(𞤆𞤫𞤧𞤮 𞤓𞤪𞤵𞤺𞤵𞤪𞤭𞤲𞤳𞤮),
				'other' => q(𞤆𞤫𞤧𞤮𞥅𞤶𞤭 𞤓𞤪𞤵𞤺𞤵𞤪𞤭𞤲𞤳𞤮),
			},
		},
		'UZS' => {
			display_name => {
				'currency' => q(𞤅𞤮𞤥𞤵 𞤓𞥁𞤦𞤫𞤳𞤭𞤧𞤼𞤢𞤲𞤳𞤮),
				'one' => q(𞤧𞤮𞤥𞤵 𞤓𞥁𞤦𞤫𞤳𞤭𞤧𞤼𞤢𞤲𞤳𞤮),
				'other' => q(𞤧𞤮𞤥𞤵𞥅𞤶𞤭 𞤓𞥁𞤦𞤫𞤳𞤭𞤧𞤼𞤢𞤲𞤳𞤮),
			},
		},
		'VEF' => {
			display_name => {
				'currency' => q(𞤄𞤮𞤤𞤭𞤾𞤢𞥄𞤪 𞤜𞤫𞤲𞤭𞥅𞤧𞤫𞤤𞤢𞤲𞤳𞤮 \(𞥒𞥐𞥐𞥘 - 𞥒𞥐𞥑𞥘\)),
				'one' => q(𞤄𞤮𞤤𞤭𞤾𞤢𞥄𞤪 𞤜𞤫𞤲𞤭𞥅𞤧𞤫𞤤𞤢𞤲𞤳𞤮 \(𞥒𞥐𞥐𞥘 - 𞥒𞥐𞥑𞥘\)),
				'other' => q(𞤄𞤮𞤤𞤭𞤾𞤢𞥄𞤪𞤶𞤭 𞤜𞤫𞤲𞤭𞥅𞤧𞤫𞤤𞤢𞤲𞤳𞤮 \(𞥒𞥐𞥐𞥘 - 𞥒𞥐𞥑𞥘\)),
			},
		},
		'VES' => {
			display_name => {
				'currency' => q(𞤄𞤮𞤤𞤭𞤾𞤢𞥄𞤪 𞤜𞤫𞤲𞤭𞥅𞤧𞤫𞤤𞤢𞤲𞤳𞤮),
				'one' => q(𞤄𞤮𞤤𞤭𞤾𞤢𞥄𞤪 𞤜𞤫𞤲𞤭𞥅𞤧𞤫𞤤𞤢𞤲𞤳𞤮),
				'other' => q(𞤄𞤮𞤤𞤭𞤾𞤢𞥄𞤪𞤶𞤭 𞤜𞤫𞤲𞤭𞥅𞤧𞤫𞤤𞤢𞤲𞤳𞤮),
			},
		},
		'VND' => {
			display_name => {
				'currency' => q(𞤁𞤮𞤲𞤺𞤵 𞤜𞤭𞤴𞤫𞤼𞤭𞤲𞤢𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤣𞤮𞤲𞤺𞤵 𞤜𞤭𞤴𞤫𞤼𞤭𞤲𞤢𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤣𞤮𞤲𞤺𞤵𞥅𞤶𞤭 𞤜𞤭𞤴𞤫𞤼𞤭𞤲𞤢𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'VUV' => {
			display_name => {
				'currency' => q(𞤜𞤢𞤼𞤵 𞤜𞤢𞤲𞤵𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤾𞤢𞤼𞤵 𞤜𞤢𞤲𞤵𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤾𞤢𞤼𞤵𞥅𞤶𞤭 𞤜𞤢𞤲𞤵𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'WST' => {
			display_name => {
				'currency' => q(𞤚𞤢𞤤𞤢 𞤅𞤢𞤥𞤮𞤱𞤢𞤴𞤢𞤲𞤳𞤮),
				'one' => q(𞤼𞤢𞤤𞤢 𞤅𞤢𞤥𞤮𞤱𞤢𞤴𞤢𞤲𞤳𞤮),
				'other' => q(𞤼𞤢𞤤𞤢𞥄𞤶𞤭 𞤅𞤢𞤥𞤮𞤱𞤢𞤴𞤢𞤲𞤳𞤮),
			},
		},
		'XAF' => {
			symbol => '𞤊𞤅𞤊𞤀',
			display_name => {
				'currency' => q(𞤊𞤢𞤪𞤢𞤲 𞤚𞤵𞤦𞤮𞥅𞤪𞤭 𞤀𞤬𞤪𞤭𞤳𞤭𞤲𞤳𞤮),
				'one' => q(𞤬𞤢𞤪𞤢𞤲 𞤚𞤵𞤦𞤮𞥅𞤪𞤭 𞤀𞤬𞤪𞤭𞤳𞤭𞤲𞤳𞤮),
				'other' => q(𞤬𞤢𞤪𞤢𞤲𞤶𞤭 𞤚𞤵𞤦𞤮𞥅𞤪𞤭 𞤀𞤬𞤪𞤭𞤳𞤭𞤲𞤳𞤮),
			},
		},
		'XCD' => {
			display_name => {
				'currency' => q(𞤁𞤢𞤤𞤢 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤑𞤢𞤪𞤭𞤦𞤭𞤴𞤢),
				'one' => q(𞤁𞤢𞤤𞤢 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤑𞤢𞤪𞤭𞤦𞤭𞤴𞤢),
				'other' => q(𞤁𞤢𞤤𞤢𞥄𞤶𞤭 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤑𞤢𞤪𞤭𞤦𞤭𞤴𞤢),
			},
		},
		'XOF' => {
			symbol => '𞤅𞤊𞤀',
			display_name => {
				'currency' => q(𞤊𞤢𞤪𞤢𞤲 𞤅𞤊𞤀 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫 𞤀𞤬𞤪𞤭𞤳𞤢),
				'one' => q(𞤬𞤢𞤪𞤢𞤲 𞤅𞤊𞤀 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫 𞤀𞤬𞤪𞤭𞤳𞤢),
				'other' => q(𞤬𞤢𞤪𞤢𞤲𞤶𞤭 𞤅𞤊𞤀 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫 𞤀𞤬𞤪𞤭𞤳𞤢),
			},
		},
		'XPF' => {
			display_name => {
				'currency' => q(𞤊𞤢𞤪𞤢𞤲 𞤅𞤊𞤆),
				'one' => q(𞤬𞤢𞤪𞤢𞤲 𞤅𞤊𞤆),
				'other' => q(𞤬𞤢𞤪𞤢𞤲𞤶𞤭 𞤅𞤊𞤆),
			},
		},
		'XXX' => {
			display_name => {
				'currency' => q(𞤐𞤄𞤵𞥅𞤯𞤭 𞤢𞤧-𞤢𞤲𞤣𞤢𞥄𞤯𞤭),
				'one' => q(\(𞤲𞤦𞤵𞥅𞤯𞤭 𞤲𞤺𞤵𞤥𞤭 𞤢𞤧-𞤢𞤲𞤣𞤢𞥄𞤯𞤭\)),
				'other' => q(𞤲𞤦𞤵𞥅𞤯𞤭 𞤢𞤧-𞤢𞤲𞤣𞤢𞥄𞤯𞤭),
			},
		},
		'YER' => {
			display_name => {
				'currency' => q(𞤈𞤭𞤴𞤢𞥄𞤤 𞤒𞤫𞤥𞤫𞤲𞤭𞤲𞤳𞤮),
				'one' => q(𞤪𞤭𞤴𞤢𞥄𞤤 𞤒𞤫𞤥𞤫𞤲𞤭𞤲𞤳𞤮),
				'other' => q(𞤪𞤭𞤴𞤢𞥄𞤤𞤶𞤭 𞤒𞤫𞤥𞤫𞤲𞤭𞤲𞤳𞤮),
			},
		},
		'ZAR' => {
			display_name => {
				'currency' => q(𞤈𞤢𞤲𞤣𞤭 𞤂𞤫𞤴𞤤𞤫𞤴𞤪𞤭 𞤀𞤬𞤪𞤭𞤳𞤢𞤲𞤳𞤮),
				'one' => q(𞤪𞤢𞤲𞤣𞤭 𞤂𞤫𞤴𞤤𞤫𞤴𞤪𞤭 𞤀𞤬𞤪𞤭𞤳𞤢𞤲𞤳𞤮),
				'other' => q(𞤪𞤢𞤲𞤶𞤭 𞤂𞤫𞤴𞤤𞤫𞤴𞤪𞤭 𞤀𞤬𞤪𞤭𞤳𞤢𞤲𞤳𞤮),
			},
		},
		'ZMW' => {
			display_name => {
				'currency' => q(𞤑𞤢𞤱𞤢𞤧𞤢 𞤟𞤢𞤥𞤦𞤭𞤲𞤳𞤮),
				'one' => q(𞤳𞤢𞤱𞤢𞤧𞤢 𞤟𞤢𞤥𞤦𞤭𞤲𞤳𞤮),
				'other' => q(𞤳𞤢𞤱𞤢𞤧𞤢𞥄𞤶𞤭 𞤟𞤢𞤥𞤦𞤭𞤲𞤳𞤮),
			},
		},
	} },
);


has 'calendar_months' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
			'gregorian' => {
				'format' => {
					abbreviated => {
						nonleap => [
							'𞤅𞤭𞥅𞤤𞤮',
							'𞤕𞤮𞤤𞤼𞤮',
							'𞤐𞤦𞤮𞥅𞤴𞤮',
							'𞤅𞤫𞥅𞤼𞤮',
							'𞤁𞤵𞥅𞤶𞤮',
							'𞤑𞤮𞤪𞤧𞤮',
							'𞤃𞤮𞤪𞤧𞤮',
							'𞤔𞤵𞤳𞤮',
							'𞤅𞤭𞤤𞤼𞤮',
							'𞤒𞤢𞤪𞤳𞤮',
							'𞤔𞤮𞤤𞤮',
							'𞤄𞤮𞤱𞤼𞤮'
						],
						leap => [
							
						],
					},
					narrow => {
						nonleap => [
							'𞤅',
							'𞤕',
							'𞤄',
							'𞤅',
							'𞤁',
							'𞤑',
							'𞤃',
							'𞤔',
							'𞤅',
							'𞤒',
							'𞤔',
							'𞤄'
						],
						leap => [
							
						],
					},
					wide => {
						nonleap => [
							'𞤅𞤭𞥅𞤤𞤮',
							'𞤕𞤮𞤤𞤼𞤮',
							'𞤐𞤦𞤮𞥅𞤴𞤮',
							'𞤅𞤫𞥅𞤼𞤮',
							'𞤁𞤵𞥅𞤶𞤮',
							'𞤑𞤮𞤪𞤧𞤮',
							'𞤃𞤮𞤪𞤧𞤮',
							'𞤔𞤵𞤳𞤮',
							'𞤅𞤭𞤤𞤼𞤮',
							'𞤒𞤢𞤪𞤳𞤮',
							'𞤔𞤮𞤤𞤮',
							'𞤄𞤮𞤱𞤼𞤮'
						],
						leap => [
							
						],
					},
				},
				'stand-alone' => {
					abbreviated => {
						nonleap => [
							'𞤅𞤭𞥅𞤤',
							'𞤕𞤮𞤤',
							'𞤐𞤦𞤮𞥅𞤴',
							'𞤅𞤫𞥅𞤼',
							'𞤁𞤵𞥅𞤶',
							'𞤑𞤮𞤪',
							'𞤃𞤮𞤪',
							'𞤔𞤵𞤳',
							'𞤅𞤭𞤤',
							'𞤒𞤢𞤪',
							'𞤔𞤮𞤤',
							'𞤄𞤮𞤱'
						],
						leap => [
							
						],
					},
					narrow => {
						nonleap => [
							'𞤅',
							'𞤕',
							'𞤄',
							'𞤅',
							'𞤁',
							'𞤑',
							'𞤃',
							'𞤔',
							'𞤅',
							'𞤒',
							'𞤔',
							'𞤄'
						],
						leap => [
							
						],
					},
					wide => {
						nonleap => [
							'𞤅𞤭𞥅𞤤𞤮',
							'𞤕𞤮𞤤𞤼𞤮',
							'𞤐𞤦𞤮𞥅𞤴𞤮',
							'𞤅𞤫𞥅𞤼𞤮',
							'𞤁𞤵𞥅𞤶𞤮',
							'𞤑𞤮𞤪𞤧𞤮',
							'𞤃𞤮𞤪𞤧𞤮',
							'𞤔𞤵𞤳𞤮',
							'𞤅𞤭𞤤𞤼𞤮',
							'𞤒𞤢𞤪𞤳𞤮',
							'𞤔𞤮𞤤𞤮',
							'𞤄𞤮𞤱𞤼𞤮'
						],
						leap => [
							
						],
					},
				},
			},
			'islamic' => {
				'format' => {
					abbreviated => {
						nonleap => [
							'𞤔𞤮𞤦.',
							'𞤅𞤢𞤨.',
							'𞤆𞤢𞤪.',
							'𞤃𞤭𞤨.',
							'𞤄𞤢𞤨.',
							'𞤅𞤢𞤪.',
							'𞤈𞤢𞤶.',
							'𞤅𞤢𞤧.',
							'𞤅𞤵𞤥.',
							'𞤔𞤵𞤤.',
							'𞤅𞤢𞤣.',
							'𞤁𞤮𞤲.'
						],
						leap => [
							
						],
					},
					narrow => {
						nonleap => [
							'𞥑',
							'𞥒',
							'𞥓',
							'𞥔',
							'𞥕',
							'𞥖',
							'𞥗',
							'𞥘',
							'𞥙',
							'𞥑𞥐',
							'𞥑𞥑',
							'𞥑𞥒'
						],
						leap => [
							
						],
					},
					wide => {
						nonleap => [
							'𞤔𞤮𞤥𞤦𞤫𞤲𞤼𞤫',
							'𞤅𞤢𞤦𞥆𞤮𞤪𞤣𞤵-𞤆𞤢𞤪𞤢𞤲',
							'𞤆𞤢𞤪𞤢𞤲',
							'𞤃𞤭𞤥𞤨𞤢𞤪𞤢𞤲',
							'𞤄𞤢𞤨𞥆𞤢𞤪𞤢𞤲',
							'𞤅𞤢𞤦𞥆𞤮𞤪𞤣𞤵-𞤈𞤢𞥄𞤶𞤭𞤦𞤭',
							'𞤈𞤢𞥄𞤶𞤭𞤦𞤭',
							'𞤅𞤢𞤦𞥆𞤮𞤪𞤣𞤵-𞤅𞤵𞥅𞤥𞤢𞤴𞤫𞥅',
							'𞤅𞤵𞥅𞤥𞤢𞤴𞤫𞥅',
							'𞤔𞤵𞥅𞤤𞤣𞤢𞥄𞤲𞥋𞤣𞤵',
							'𞤅𞤢𞤦𞥆𞤮𞤪𞤣𞤵-𞤁𞤮𞤲𞤳𞤭𞤲',
							'𞤁𞤵𞤲𞤳𞤭𞤲'
						],
						leap => [
							
						],
					},
				},
				'stand-alone' => {
					abbreviated => {
						nonleap => [
							'𞤔𞤮𞤦.',
							'𞤅𞤢𞤨.',
							'𞤆𞤢𞤪.',
							'𞤃𞤭𞤨.',
							'𞤄𞤢𞤨.',
							'𞤅𞤢𞤪.',
							'𞤈𞤢𞤶.',
							'𞤅𞤢𞤧.',
							'𞤅𞤵𞤥.',
							'𞤔𞤵𞤤.',
							'𞤅𞤢𞤣.',
							'𞤁𞤮𞤲.'
						],
						leap => [
							
						],
					},
					narrow => {
						nonleap => [
							'𞥑',
							'𞥒',
							'𞥓',
							'𞥔',
							'𞥕',
							'𞥖',
							'𞥗',
							'𞥘',
							'𞥙',
							'𞥑𞥐',
							'𞥑𞥑',
							'𞥑𞥒'
						],
						leap => [
							
						],
					},
					wide => {
						nonleap => [
							'𞤔𞤮𞤥𞤦𞤫𞤲𞤼𞤫',
							'𞤅𞤢𞤦𞥆𞤮𞤪𞤣𞤵-𞤆𞤢𞤪𞤢𞤲',
							'𞤆𞤢𞤪𞤢𞤲',
							'𞤃𞤭𞤥𞤨𞤢𞤪𞤢𞤲',
							'𞤄𞤢𞤨𞥆𞤢𞤪𞤢𞤲',
							'𞤅𞤢𞤦𞥆𞤮𞤪𞤣𞤵-𞤈𞤢𞥄𞤶𞤭𞤦𞤭',
							'𞤈𞤢𞥄𞤶𞤭𞤦𞤭',
							'𞤅𞤢𞤦𞥆𞤮𞤪𞤣𞤵-𞤅𞤵𞥅𞤥𞤢𞤴𞤫𞥅',
							'𞤅𞤵𞥅𞤥𞤢𞤴𞤫𞥅',
							'𞤔𞤵𞥅𞤤𞤣𞤢𞥄𞤲𞥋𞤣𞤵',
							'𞤅𞤢𞤦𞥆𞤮𞤪𞤣𞤵-𞤁𞤮𞤲𞤳𞤭𞤲',
							'𞤁𞤵𞤲𞤳𞤭𞤲'
						],
						leap => [
							
						],
					},
				},
			},
	} },
);

has 'calendar_days' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
			'gregorian' => {
				'format' => {
					abbreviated => {
						mon => '𞤀𞥄𞤩𞤵',
						tue => '𞤃𞤢𞤦',
						wed => '𞤔𞤫𞤧',
						thu => '𞤐𞤢𞥄𞤧',
						fri => '𞤃𞤢𞤣',
						sat => '𞤖𞤮𞤪',
						sun => '𞤈𞤫𞤬'
					},
					narrow => {
						mon => '𞤀𞥄',
						tue => '𞤃',
						wed => '𞤔',
						thu => '𞤐',
						fri => '𞤃',
						sat => '𞤖',
						sun => '𞤈'
					},
					short => {
						mon => '𞤀𞥄𞤩𞤵',
						tue => '𞤃𞤢𞤦',
						wed => '𞤔𞤫𞤧',
						thu => '𞤐𞤢𞥄𞤧',
						fri => '𞤃𞤢𞤣',
						sat => '𞤖𞤮𞤪',
						sun => '𞤈𞤫𞤬'
					},
					wide => {
						mon => '𞤀𞥄𞤩𞤵𞤲𞥋𞤣𞤫',
						tue => '𞤃𞤢𞤱𞤦𞤢𞥄𞤪𞤫',
						wed => '𞤐𞤶𞤫𞤧𞤤𞤢𞥄𞤪𞤫',
						thu => '𞤐𞤢𞥄𞤧𞤢𞥄𞤲𞤣𞤫',
						fri => '𞤃𞤢𞤱𞤲𞤣𞤫',
						sat => '𞤖𞤮𞤪𞤦𞤭𞤪𞥆𞤫',
						sun => '𞤈𞤫𞤬𞤦𞤭𞤪𞥆𞤫'
					},
				},
				'stand-alone' => {
					abbreviated => {
						mon => '𞤀𞥄𞤩𞤵',
						tue => '𞤃𞤢𞤦',
						wed => '𞤔𞤫𞤧',
						thu => '𞤐𞤢𞥄𞤧',
						fri => '𞤃𞤢𞤣',
						sat => '𞤖𞤮𞤪',
						sun => '𞤈𞤫𞤬'
					},
					narrow => {
						mon => '𞤀𞥄',
						tue => '𞤃',
						wed => '𞤔',
						thu => '𞤐',
						fri => '𞤃',
						sat => '𞤖',
						sun => '𞤈'
					},
					short => {
						mon => '𞤀𞥄𞤩𞤵',
						tue => '𞤃𞤢𞤦',
						wed => '𞤔𞤫𞤧',
						thu => '𞤐𞤢𞥄𞤧',
						fri => '𞤃𞤢𞤣',
						sat => '𞤖𞤮𞤪',
						sun => '𞤈𞤫𞤬'
					},
					wide => {
						mon => '𞤀𞥄𞤩𞤵𞤲𞥋𞤣𞤫',
						tue => '𞤃𞤢𞤱𞤦𞤢𞥄𞤪𞤫',
						wed => '𞤐𞤶𞤫𞤧𞤤𞤢𞥄𞤪𞤫',
						thu => '𞤐𞤢𞥄𞤧𞤢𞥄𞤲𞤣𞤫',
						fri => '𞤃𞤢𞤱𞤲𞤣𞤫',
						sat => '𞤖𞤮𞤪𞤦𞤭𞤪𞥆𞤫',
						sun => '𞤈𞤫𞤬𞤦𞤭𞤪𞥆𞤫'
					},
				},
			},
	} },
);

has 'calendar_quarters' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
			'gregorian' => {
				'format' => {
					abbreviated => {0 => '𞤐𞥑',
						1 => '𞤐𞥒',
						2 => '𞤐𞥓',
						3 => '𞤐𞥔'
					},
					narrow => {0 => '𞥑',
						1 => '𞥒',
						2 => '𞥓',
						3 => '𞥔'
					},
					wide => {0 => '𞤐𞥑',
						1 => '𞤐𞥒',
						2 => '𞤐𞥓',
						3 => '𞤐𞥔'
					},
				},
				'stand-alone' => {
					abbreviated => {0 => '𞤐𞥑',
						1 => '𞤐𞥒',
						2 => '𞤐𞥓',
						3 => '𞤐𞥔'
					},
					narrow => {0 => '𞥑',
						1 => '𞥒',
						2 => '𞥓',
						3 => '𞥔'
					},
					wide => {0 => '𞤐𞤢𞤴𞤩𞤭𞥅𞤪𞤫 𞥑𞤪𞤫',
						1 => '𞤐𞤢𞤴𞤩𞤭𞥅𞤪𞤫 𞥒𞤪𞤫',
						2 => '𞤐𞤢𞤴𞤩𞤭𞥅𞤪𞤫 𞥓𞤪𞤫',
						3 => '𞤐𞤢𞤴𞤩𞤭𞥅𞤪𞤫 𞥔𞤪𞤫'
					},
				},
			},
	} },
);

has 'day_periods' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'gregorian' => {
			'format' => {
				'abbreviated' => {
					'am' => q{𞤀𞤎},
					'pm' => q{𞤇𞤎},
				},
				'narrow' => {
					'am' => q{𞤢},
					'pm' => q{𞤩},
				},
				'wide' => {
					'am' => q{𞤀𞤎},
					'pm' => q{𞤇𞤎},
				},
			},
			'stand-alone' => {
				'abbreviated' => {
					'am' => q{𞤀𞤎},
					'pm' => q{𞤇𞤎},
				},
				'narrow' => {
					'am' => q{𞤀𞤎},
					'pm' => q{𞤇𞤎},
				},
				'wide' => {
					'am' => q{𞤀𞤎},
					'pm' => q{𞤇𞤎},
				},
			},
		},
	} },
);

has 'eras' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'buddhist' => {
			abbreviated => {
				'0' => '𞤘𞤄'
			},
			wide => {
				'0' => '𞤘𞤭𞤪𞤢𞤤 𞤄𞤵𞥅𞤣𞤢𞤲𞤳𞤮𞤱𞤢𞤤'
			},
		},
		'chinese' => {
		},
		'generic' => {
		},
		'gregorian' => {
			abbreviated => {
				'0' => '𞤀𞤀𞤋',
				'1' => '𞤇𞤀𞤋'
			},
			wide => {
				'0' => '𞤀𞤣𞤮 𞤀𞤲𞥆𞤢𞤦𞤭 𞤋𞥅𞤧𞤢𞥄',
				'1' => '𞤇𞤢𞥄𞤱𞤮 𞤀𞤲𞥆𞤢𞤦𞤭 𞤋𞥅𞤧𞤢𞥄'
			},
		},
		'hebrew' => {
			wide => {
				'0' => '𞤀𞤃'
			},
		},
		'indian' => {
			abbreviated => {
				'0' => '𞤅𞤢𞤳𞤢'
			},
			wide => {
				'0' => '𞤅𞤢𞤳𞤢'
			},
		},
		'islamic' => {
			abbreviated => {
				'0' => '𞤇𞤊'
			},
		},
	} },
);

has 'date_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'buddhist' => {
		},
		'chinese' => {
		},
		'generic' => {
			'full' => q{EEEE d MMMM⹁ y G},
			'long' => q{d MMMM⹁ y G},
			'medium' => q{d MMM⹁ y G},
			'short' => q{d-M-y GGGGG},
		},
		'gregorian' => {
			'full' => q{EEEE d MMMM⹁ y},
			'long' => q{d MMMM⹁ y},
			'medium' => q{d MMM⹁ y},
			'short' => q{d-M-y},
		},
		'hebrew' => {
		},
		'indian' => {
		},
		'islamic' => {
		},
	} },
);

has 'time_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'buddhist' => {
		},
		'chinese' => {
		},
		'generic' => {
		},
		'gregorian' => {
			'full' => q{HH:mm:ss zzzz},
			'long' => q{HH:mm:ss z},
			'medium' => q{HH:mm:ss},
			'short' => q{HH:mm},
		},
		'hebrew' => {
		},
		'indian' => {
		},
		'islamic' => {
		},
	} },
);

has 'datetime_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'buddhist' => {
		},
		'chinese' => {
		},
		'generic' => {
			'full' => q{{1} {0}},
			'long' => q{{1} {0}},
			'medium' => q{{1} {0}},
			'short' => q{{1} {0}},
		},
		'gregorian' => {
			'full' => q{{1} 𞤉 {0}},
			'long' => q{{1} 𞤉 {0}},
			'medium' => q{{1} {0}},
			'short' => q{{1} {0}},
		},
		'hebrew' => {
		},
		'indian' => {
		},
		'islamic' => {
		},
	} },
);

has 'datetime_formats_available_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'generic' => {
			Ed => q{E d},
			Gy => q{y G},
			GyMMM => q{MMM y G},
			GyMMMEd => q{E⹁ d MMM⹁ y G},
			GyMMMd => q{d MMM⹁ y G},
			GyMd => q{d-M-y GGGGG},
			MEd => q{E d-M},
			MMMEd => q{E d MMM},
			MMMMd => q{d MMMM},
			MMMd => q{d MMM},
			Md => q{d-M},
			y => q{y G},
			yyyy => q{y G},
			yyyyM => q{M-y GGGGG},
			yyyyMEd => q{E⹁ d-M-y GGGGG},
			yyyyMMM => q{MMM y G},
			yyyyMMMEd => q{E⹁ d MMM⹁ y G},
			yyyyMMMM => q{MMMM y G},
			yyyyMMMd => q{d MMM⹁ y G},
			yyyyMd => q{d-M-y GGGGG},
			yyyyQQQ => q{QQQ y G},
			yyyyQQQQ => q{QQQQ y G},
		},
		'gregorian' => {
			Ed => q{E d},
			Gy => q{y G},
			GyMMM => q{MMM y G},
			GyMMMEd => q{E⹁ d MMM⹁ y G},
			GyMMMd => q{d MMM⹁ y G},
			GyMd => q{d-M-y GGGGG},
			MEd => q{E d-M},
			MMMEd => q{E d MMM},
			MMMMW => q{𞤴𞤮𞤲𞤼𞤫𞤪𞤫 W 𞤲𞤣𞤫𞤪 MMMM},
			MMMMd => q{d MMMM},
			MMMd => q{d MMM},
			Md => q{d-M},
			yM => q{M-y},
			yMEd => q{E⹁ d-M-y},
			yMMM => q{MMM y},
			yMMMEd => q{E⹁ d MMM⹁ y},
			yMMMM => q{MMMM y},
			yMMMd => q{d MMM⹁ y},
			yMd => q{d-M-y},
			yQQQ => q{QQQ y},
			yQQQQ => q{QQQQ y},
			yw => q{𞤴𞤮𞤲𞤼𞤫𞤪𞤫 w 𞤲𞤣𞤫𞤪 Y},
		},
	} },
);

has 'datetime_formats_append_item' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
	} },
);

has 'datetime_formats_interval' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'gregorian' => {
			Bh => {
				h => q{h – h B},
			},
			Bhm => {
				h => q{h:mm – h:mm B},
				m => q{h:mm – h:mm B},
			},
			Gy => {
				G => q{y G – y G},
				y => q{y – y G},
			},
			GyM => {
				G => q{M-y GGGGG – M-y GGGGG},
				M => q{M-y – M-y GGGGG},
				y => q{M-y – M-y GGGGG},
			},
			GyMEd => {
				G => q{E d-M-y GGGGG – E d-M-y GGGGG},
				M => q{E d-M-y – E d-M-y GGGGG},
				d => q{E d-M-y – E d-M-y GGGGG},
				y => q{E d-M-y – E d-M-y GGGGG},
			},
			GyMMM => {
				G => q{MMM y G – MMM y G},
				M => q{MMM – MMM y G},
				y => q{MMM y – MMM y G},
			},
			GyMMMEd => {
				G => q{E d MMM⹁ y G – E d MMM⹁ y G},
				M => q{E d MMM – E d MMM⹁ y G},
				d => q{E d MMM – E d MMM⹁ y G},
				y => q{E d MMM⹁ y – E d MMM⹁ y G},
			},
			GyMMMd => {
				G => q{d MMM⹁ y G – d MMM⹁ y G},
				M => q{d MMM – d MMM⹁ y G},
				d => q{d – d MMM⹁ y G},
				y => q{d MMM⹁ y – d MMM⹁ y G},
			},
			GyMd => {
				G => q{d-M-y GGGGG – d-M-y GGGGG},
				M => q{d-M-y – d-M-y GGGGG},
				d => q{d-M-y – d-M-y GGGGG},
				y => q{d-M-y – d-M-y GGGGG},
			},
			M => {
				M => q{M – M},
			},
			MEd => {
				M => q{E d-M – E d-M},
				d => q{E d-M – E d-M},
			},
			MMM => {
				M => q{LLL – LLL},
			},
			MMMEd => {
				M => q{E d MMM – E d MMM},
				d => q{E d MMM – E d MMM},
			},
			MMMd => {
				M => q{d MMM – d MMM},
				d => q{d – d MMM},
			},
			Md => {
				M => q{d-M – d-M},
				d => q{d-M – d-M},
			},
			yM => {
				M => q{MM-y – MM-y},
				y => q{MM-y – MM-y},
			},
			yMEd => {
				M => q{E d-M⹁ y – E d-M⹁ y},
				d => q{E d-M⹁ y – E d-M⹁ y},
				y => q{E d-M⹁ y – E d-M⹁ y},
			},
			yMMM => {
				M => q{MMM – MMM y},
				y => q{MMM y – MMM y},
			},
			yMMMEd => {
				M => q{E d MMM – E d MMM⹁ y},
				d => q{E d MMM – E d MMM⹁ y},
				y => q{E d MMM⹁ y – E d MMM⹁ y},
			},
			yMMMM => {
				M => q{MMMM – MMMM y},
				y => q{MMMM y – MMMM y},
			},
			yMMMd => {
				M => q{d MMM – d MMM⹁ y},
				d => q{d – d MMM⹁ y},
				y => q{d MMM⹁ y – d MMM⹁ y},
			},
			yMd => {
				M => q{d-M-y – d-M-y},
				d => q{d-M-y – d-M-y},
				y => q{d-M-y – d-M-y},
			},
		},
	} },
);

has 'cyclic_name_sets' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'chinese' => {
			'dayParts' => {
				'format' => {
					'abbreviated' => {
						0 => q(𞤶𞤭),
						1 => q(𞤅𞤵),
						2 => q(𞤴𞤭𞤲),
						3 => q(𞤥𞤢𞤱𞤮),
						4 => q(𞤷𞤫𞤲),
						5 => q(𞤧𞤭),
						6 => q(𞤱𞤵),
						7 => q(𞤱𞤫𞤭),
						8 => q(𞥃𞤫𞥅𞤲),
						9 => q(𞤴𞤵𞥅),
						10 => q(𞤿𞤵),
						11 => q(𞤸𞤢𞤴),
					},
				},
			},
		},
	} },
);

has 'time_zone_names' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default	=> sub { {
		gmtFormat => q(𞤑𞤖𞤘{0}),
		gmtZeroFormat => q(𞤑𞤖𞤘),
		regionFormat => q({0} 𞤑𞤭𞤶𞤮𞥅𞤪𞤫),
		regionFormat => q({0} 𞤐𞤶𞤢𞤥𞤲𞤣𞤭 𞤕𞤫𞥅𞤯𞤵),
		regionFormat => q({0} 𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫),
		'Afghanistan' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤀𞤬𞤺𞤢𞤲𞤭𞤧𞤼𞤢𞥄𞤲#,
			},
		},
		'Africa/Abidjan' => {
			exemplarCity => q#𞤀𞤦𞤭𞤶𞤢𞤲#,
		},
		'Africa/Accra' => {
			exemplarCity => q#𞤀𞤳𞤢𞤪𞤢#,
		},
		'Africa/Addis_Ababa' => {
			exemplarCity => q#𞤀𞤣𞤭𞤧𞤢𞤦𞤢𞤦𞤢#,
		},
		'Africa/Algiers' => {
			exemplarCity => q#𞤀𞤤𞤶𞤢𞤪𞤭𞥅#,
		},
		'Africa/Asmera' => {
			exemplarCity => q#𞤀𞤧𞤥𞤢𞤪𞤢#,
		},
		'Africa/Bamako' => {
			exemplarCity => q#𞤄𞤢𞤥𞤢𞤳𞤮𞥅#,
		},
		'Africa/Bangui' => {
			exemplarCity => q#𞤄𞤢𞤲𞤺𞤭#,
		},
		'Africa/Banjul' => {
			exemplarCity => q#𞤄𞤢𞤲𞤶𞤵𞤤#,
		},
		'Africa/Bissau' => {
			exemplarCity => q#𞤄𞤭𞤱𞤢𞤱𞤮#,
		},
		'Africa/Blantyre' => {
			exemplarCity => q#𞤄𞤭𞤤𞤢𞤲𞤼𞤭𞤪𞤫#,
		},
		'Africa/Brazzaville' => {
			exemplarCity => q#𞤄𞤢𞤪𞥁𞤢𞤾𞤭𞤤#,
		},
		'Africa/Bujumbura' => {
			exemplarCity => q#𞤄𞤵𞤶𞤵𞤥𞤦𞤵𞤪𞤢#,
		},
		'Africa/Cairo' => {
			exemplarCity => q#𞤑𞤢𞤴𞤪𞤢#,
		},
		'Africa/Casablanca' => {
			exemplarCity => q#𞤑𞤢𞥄𞤧𞤢𞤦𞤵𞤤𞤢𞤲𞤳𞤢𞥄#,
		},
		'Africa/Ceuta' => {
			exemplarCity => q#𞤅𞤭𞥅𞤼𞤢#,
		},
		'Africa/Conakry' => {
			exemplarCity => q#𞤑𞤮𞤲𞤢𞥄𞤳𞤭𞤪𞤭#,
		},
		'Africa/Dakar' => {
			exemplarCity => q#𞤁𞤢𞤳𞤢𞥄𞤪#,
		},
		'Africa/Dar_es_Salaam' => {
			exemplarCity => q#𞤁𞤢𞥄𞤪𞤫-𞤅𞤢𞤤𞤢𞥄𞤥𞤵#,
		},
		'Africa/Djibouti' => {
			exemplarCity => q#𞤔𞤭𞤦𞤵𞥅𞤼𞤭#,
		},
		'Africa/Douala' => {
			exemplarCity => q#𞤁𞤵𞤱𞤢𞤤𞤢#,
		},
		'Africa/El_Aaiun' => {
			exemplarCity => q#𞤂𞤢𞤴𞤵𞥅𞤲𞤢#,
		},
		'Africa/Freetown' => {
			exemplarCity => q#𞤊𞤭𞤪𞤼𞤮𞤲#,
		},
		'Africa/Gaborone' => {
			exemplarCity => q#𞤘𞤢𞤦𞤮𞤪𞤮𞥅𞤲#,
		},
		'Africa/Harare' => {
			exemplarCity => q#𞤖𞤢𞤪𞤢𞤪𞤫#,
		},
		'Africa/Johannesburg' => {
			exemplarCity => q#𞤔𞤮𞤸𞤢𞤲𞤢𞤧𞤦𞤵𞥅𞤪#,
		},
		'Africa/Juba' => {
			exemplarCity => q#𞤔𞤵𞤦𞤢#,
		},
		'Africa/Kampala' => {
			exemplarCity => q#𞤑𞤢𞤥𞤨𞤢𞤤𞤢#,
		},
		'Africa/Khartoum' => {
			exemplarCity => q#𞤝𞤢𞤪𞤼𞤵𞥅𞤥#,
		},
		'Africa/Kigali' => {
			exemplarCity => q#𞤑𞤭𞤺𞤢𞤤𞤭#,
		},
		'Africa/Kinshasa' => {
			exemplarCity => q#𞤑𞤭𞤲𞤧𞤢𞤧𞤢#,
		},
		'Africa/Lagos' => {
			exemplarCity => q#𞤂𞤢𞤺𞤮𞥅𞤧#,
		},
		'Africa/Libreville' => {
			exemplarCity => q#𞤂𞤭𞥅𞤦𞤫𞤪𞤾𞤭𞥅𞤤#,
		},
		'Africa/Lome' => {
			exemplarCity => q#𞤂𞤮𞤥𞤫#,
		},
		'Africa/Luanda' => {
			exemplarCity => q#𞤂𞤵𞤱𞤢𞤲𞤣𞤢𞥄#,
		},
		'Africa/Lubumbashi' => {
			exemplarCity => q#𞤂𞤵𞤦𞤵𞤥𞤦𞤢𞥃𞤭#,
		},
		'Africa/Lusaka' => {
			exemplarCity => q#𞤂𞤵𞤧𞤢𞤳𞤢#,
		},
		'Africa/Malabo' => {
			exemplarCity => q#𞤃𞤢𞤤𞤢𞤦𞤮𞥅#,
		},
		'Africa/Maputo' => {
			exemplarCity => q#𞤃𞤢𞤨𞤵𞤼𞤮#,
		},
		'Africa/Maseru' => {
			exemplarCity => q#𞤃𞤢𞤧𞤫𞤪𞤵#,
		},
		'Africa/Mbabane' => {
			exemplarCity => q#𞤐𞥋𞤄𞤢𞤦𞤢𞥄𞤲𞤫#,
		},
		'Africa/Mogadishu' => {
			exemplarCity => q#𞤃𞤵𞤹𞥆𞤢𞤧𞤮𞥅#,
		},
		'Africa/Monrovia' => {
			exemplarCity => q#𞤃𞤮𞤪𞤮𞤦𞤭𞤴𞤢#,
		},
		'Africa/Nairobi' => {
			exemplarCity => q#𞤐𞤢𞤴𞤪𞤮𞤦𞤭#,
		},
		'Africa/Ndjamena' => {
			exemplarCity => q#𞤐𞥋𞤔𞤢𞤥𞤫𞤲𞤢#,
		},
		'Africa/Niamey' => {
			exemplarCity => q#𞤐𞤭𞤴𞤢𞤥𞤫#,
		},
		'Africa/Nouakchott' => {
			exemplarCity => q#𞤐𞤵𞤱𞤢𞥄𞤳𞥃𞤵𞥅𞤼#,
		},
		'Africa/Ouagadougou' => {
			exemplarCity => q#𞤏𞤢𞤺𞤢𞤣𞤴𞤺𞤵#,
		},
		'Africa/Porto-Novo' => {
			exemplarCity => q#𞤆𞤮𞤪𞤼𞤮-𞤐𞤮𞤾𞤮𞥅#,
		},
		'Africa/Sao_Tome' => {
			exemplarCity => q#𞤅𞤢𞤱𞤮-𞤚𞤮𞤥𞤫𞥅#,
		},
		'Africa/Tripoli' => {
			exemplarCity => q#𞤚𞤪𞤭𞤨𞤮𞤤𞤭#,
		},
		'Africa/Tunis' => {
			exemplarCity => q#𞤚𞤵𞥅𞤲𞤵𞤧#,
		},
		'Africa/Windhoek' => {
			exemplarCity => q#𞤏𞤭𞤲𞤣𞤵𞥅𞤳#,
		},
		'Africa_Central' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤵𞤥𞤦𞤮𞥅𞤪𞤭 𞤀𞤬𞤪𞤭𞤳𞤢𞥄#,
			},
		},
		'Africa_Eastern' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫 𞤀𞤬𞤪𞤭𞤳𞤢𞥄#,
			},
		},
		'Africa_Southern' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤬𞤪𞤭𞤳𞤢𞥄#,
			},
		},
		'Africa_Western' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫 𞤀𞤬𞤪𞤭𞤳𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫 𞤀𞤬𞤪𞤭𞤳𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫 𞤀𞤬𞤪𞤭𞤳𞤢𞥄#,
			},
		},
		'Alaska' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤀𞤤𞤢𞤧𞤳𞤢𞥄 𞤲𞤣𞤫𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤀𞤤𞤢𞤧𞤳𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤀𞤤𞤢𞤧𞤳𞤢𞥄 𞤲𞤣𞤫𞤲#,
			},
		},
		'Amazon' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤀𞤥𞤢𞥁𞤮𞥅𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤀𞤥𞤢𞥁𞤮𞥅𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤀𞤥𞤢𞥁𞤮𞥅𞤲#,
			},
		},
		'America/Adak' => {
			exemplarCity => q#𞤀𞤣𞤢𞤳#,
		},
		'America/Anchorage' => {
			exemplarCity => q#𞤀𞤲𞤧𞤮𞤪𞤢𞥄𞤶𞤵#,
		},
		'America/Anguilla' => {
			exemplarCity => q#𞤀𞤲𞤺𞤭𞤤𞤢𞥄#,
		},
		'America/Antigua' => {
			exemplarCity => q#𞤀𞤲𞤼𞤭𞤺𞤢#,
		},
		'America/Araguaina' => {
			exemplarCity => q#𞤀𞤪𞤢𞤺𞤵𞤱𞤢𞤲𞤢#,
		},
		'America/Argentina/La_Rioja' => {
			exemplarCity => q#𞤂𞤢-𞤈𞤭𞤴𞤮𞤸𞤢#,
		},
		'America/Argentina/Rio_Gallegos' => {
			exemplarCity => q#𞤈𞤭𞤮-𞤘𞤢𞤤𞤫𞤺𞤮𞤧#,
		},
		'America/Argentina/Salta' => {
			exemplarCity => q#𞤅𞤢𞤤𞤼𞤢#,
		},
		'America/Argentina/San_Juan' => {
			exemplarCity => q#𞤅𞤢𞤲-𞤝𞤵𞤱𞤢𞥄𞤲#,
		},
		'America/Argentina/San_Luis' => {
			exemplarCity => q#𞤅𞤢𞤲-𞤂𞤵𞤱𞤭𞥅𞤧#,
		},
		'America/Argentina/Tucuman' => {
			exemplarCity => q#𞤚𞤵𞤳𞤵𞤥𞤢𞥄𞤲#,
		},
		'America/Argentina/Ushuaia' => {
			exemplarCity => q#𞤓𞤧𞤱𞤢𞤭𞥅𞤶#,
		},
		'America/Aruba' => {
			exemplarCity => q#𞤀𞤪𞤵𞥅𞤦𞤢#,
		},
		'America/Asuncion' => {
			exemplarCity => q#𞤀𞤧𞤵𞤲𞤧𞤭𞤴𞤮𞤲#,
		},
		'America/Bahia' => {
			exemplarCity => q#𞤄𞤢𞤸𞤭𞤴𞤢#,
		},
		'America/Bahia_Banderas' => {
			exemplarCity => q#𞤄𞤢𞤸𞤭𞤴𞤢𞥄 𞤄𞤢𞤲𞤣𞤫𞤪𞤢𞥄𞤧#,
		},
		'America/Barbados' => {
			exemplarCity => q#𞤄𞤢𞤪𞤦𞤢𞥄𞤣𞤮𞤧#,
		},
		'America/Belem' => {
			exemplarCity => q#𞤄𞤫𞤤𞤫𞤥#,
		},
		'America/Belize' => {
			exemplarCity => q#𞤄𞤫𞤤𞤭𞥅𞥁#,
		},
		'America/Blanc-Sablon' => {
			exemplarCity => q#𞤄𞤵𞤤𞤢𞤲 𞤅𞤢𞤦𞤵𞤤𞤮𞤲#,
		},
		'America/Boa_Vista' => {
			exemplarCity => q#𞤄𞤮𞤱𞤢-𞤜𞤭𞤧𞤼𞤢#,
		},
		'America/Bogota' => {
			exemplarCity => q#𞤄𞤮𞤺𞤮𞤼𞤢#,
		},
		'America/Boise' => {
			exemplarCity => q#𞤄𞤮𞤴𞥁𞤭𞥅#,
		},
		'America/Buenos_Aires' => {
			exemplarCity => q#𞤄𞤭𞤴𞤲𞤮𞤧-𞤉𞥅𞤶𞤫𞤪𞤫𞥅𞤧#,
		},
		'America/Cambridge_Bay' => {
			exemplarCity => q#𞤑𞤢𞤥𞤦𞤭𞤪𞤭𞥅𞤶 𞤄𞤫𞥅#,
		},
		'America/Campo_Grande' => {
			exemplarCity => q#𞤑𞤢𞤥𞤨𞤮-𞤘𞤪𞤢𞤲𞤣𞤫#,
		},
		'America/Cancun' => {
			exemplarCity => q#𞤑𞤢𞤲𞤳𞤵𞥅𞤲#,
		},
		'America/Caracas' => {
			exemplarCity => q#𞤑𞤢𞤪𞤢𞤳𞤢𞤧#,
		},
		'America/Catamarca' => {
			exemplarCity => q#𞤑𞤢𞤼𞤢𞤥𞤢𞤪𞤳𞤢𞥄#,
		},
		'America/Cayenne' => {
			exemplarCity => q#𞤑𞤢𞤴𞤫𞥅𞤲#,
		},
		'America/Cayman' => {
			exemplarCity => q#𞤑𞤢𞤴𞤥𞤢𞥄𞤲#,
		},
		'America/Chicago' => {
			exemplarCity => q#𞤕𞤭𞤳𞤢𞥄𞤺𞤮𞥅#,
		},
		'America/Chihuahua' => {
			exemplarCity => q#𞤕𞤋𞤱𞤢𞥄𞤱𞤢𞥄#,
		},
		'America/Coral_Harbour' => {
			exemplarCity => q#𞤀𞤼𞤭𞤳𞤮𞥅𞤳𞤢𞤲#,
		},
		'America/Cordoba' => {
			exemplarCity => q#𞤑𞤮𞤪𞤣𞤮𞤦𞤢𞥄#,
		},
		'America/Costa_Rica' => {
			exemplarCity => q#𞤑𞤮𞤧𞤼𞤢 𞤈𞤭𞤳𞤢𞥄#,
		},
		'America/Creston' => {
			exemplarCity => q#𞤑𞤪𞤫𞤧𞤼𞤮𞤲#,
		},
		'America/Cuiaba' => {
			exemplarCity => q#𞤑𞤵𞤶𞤢𞤦𞤢𞥄#,
		},
		'America/Curacao' => {
			exemplarCity => q#𞤑𞤵𞤪𞤢𞤧𞤢𞤱𞤮𞥅#,
		},
		'America/Danmarkshavn' => {
			exemplarCity => q#𞤁𞤢𞥄𞤲𞤥𞤢𞤪𞤳𞥃𞤢𞥄𞤾𞤲#,
		},
		'America/Dawson' => {
			exemplarCity => q#𞤁𞤮𞥅𞤧𞤮𞤲#,
		},
		'America/Dawson_Creek' => {
			exemplarCity => q#𞤁𞤮𞥅𞤧𞤮𞤲-𞤑𞤪𞤫𞤳#,
		},
		'America/Denver' => {
			exemplarCity => q#𞤁𞤫𞤲𞤾𞤮𞥅#,
		},
		'America/Detroit' => {
			exemplarCity => q#𞤁𞤭𞤼𞤪𞤮𞤴𞤼#,
		},
		'America/Dominica' => {
			exemplarCity => q#𞤁𞤮𞤥𞤭𞤲𞤭𞤳𞤢𞥄#,
		},
		'America/Edmonton' => {
			exemplarCity => q#𞤉𞤣𞤥𞤮𞤲𞤼𞤮𞤲#,
		},
		'America/Eirunepe' => {
			exemplarCity => q#𞤉𞤪𞤵𞤲𞤫𞤨𞤫#,
		},
		'America/El_Salvador' => {
			exemplarCity => q#𞤉𞤤-𞤅𞤢𞤤𞤾𞤢𞤣𞤮𞥅𞤪#,
		},
		'America/Fort_Nelson' => {
			exemplarCity => q#𞤊𞤮𞤪𞤼-𞤐𞤫𞤤𞤧𞤮𞤲;#,
		},
		'America/Fortaleza' => {
			exemplarCity => q#𞤊𞤮𞤪𞤼𞤢𞤤𞤫𞥅𞥁𞤢#,
		},
		'America/Glace_Bay' => {
			exemplarCity => q#𞤘𞤤𞤫𞤧-𞤄𞤫𞥅#,
		},
		'America/Godthab' => {
			exemplarCity => q#𞤐𞤵𞥅𞤳#,
		},
		'America/Goose_Bay' => {
			exemplarCity => q#𞤘𞤮𞥅𞤧-𞤄𞤫𞥅#,
		},
		'America/Grand_Turk' => {
			exemplarCity => q#𞤘𞤪𞤢𞤲𞤣-𞤚𞤵𞤪𞤳#,
		},
		'America/Grenada' => {
			exemplarCity => q#𞤘𞤪𞤫𞤲𞤢𞥄𞤣𞤢#,
		},
		'America/Guadeloupe' => {
			exemplarCity => q#𞤘𞤵𞤱𞤢𞤣𞤫𞤤𞤵𞤨𞥆𞤫𞥅#,
		},
		'America/Guatemala' => {
			exemplarCity => q#𞤘𞤵𞤱𞤢𞤼𞤫𞤥𞤢𞤤𞤢#,
		},
		'America/Guayaquil' => {
			exemplarCity => q#𞤘𞤵𞤴𞤢𞤳𞤭𞤤#,
		},
		'America/Guyana' => {
			exemplarCity => q#𞤘𞤵𞤴𞤢𞤲𞤢𞥄#,
		},
		'America/Halifax' => {
			exemplarCity => q#𞤖𞤢𞤤𞤭𞤬𞤢𞤳𞤧𞤭#,
		},
		'America/Havana' => {
			exemplarCity => q#𞤖𞤢𞤾𞤢𞤲𞤢𞥄#,
		},
		'America/Hermosillo' => {
			exemplarCity => q#𞤖𞤢𞤪𞤥𞤮𞤧𞤭𞤤𞤭𞤴𞤮𞥅#,
		},
		'America/Indiana/Knox' => {
			exemplarCity => q#𞤐𞤮𞤳𞤧𞤵, 𞤋𞤣𞤭𞤴𞤢𞤲𞤢𞥄#,
		},
		'America/Indiana/Marengo' => {
			exemplarCity => q#𞤃𞤢𞤪𞤫𞤲𞤺𞤮, 𞤋𞤲𞤣𞤭𞤴𞤢𞤲𞤢𞥄#,
		},
		'America/Indiana/Petersburg' => {
			exemplarCity => q#𞤆𞤫𞤼𞤮𞤧𞤄𞤵𞥅𞤪𞤺, 𞤋𞤲𞤣𞤭𞤴𞤢𞤲𞤢𞥄#,
		},
		'America/Indiana/Tell_City' => {
			exemplarCity => q#𞤚𞤫𞤤-𞤅𞤭𞤼𞤭𞥅, 𞤋𞤲𞤣𞤭𞤴𞤢𞤲𞤢𞥄#,
		},
		'America/Indiana/Vevay' => {
			exemplarCity => q#𞤜𞤫𞥅𞤾𞤫𞤴, 𞤋𞤲𞤣𞤭𞤴𞤢𞤲𞤢𞥄#,
		},
		'America/Indiana/Vincennes' => {
			exemplarCity => q#𞤜𞤭𞤲𞤧𞤫𞥅𞤲, 𞤋𞤲𞤣𞤭𞤴𞤢𞤲𞤢𞥄#,
		},
		'America/Indiana/Winamac' => {
			exemplarCity => q#𞤏𞤭𞤲𞤢𞤥𞤢𞤳, 𞤋𞤲𞤣𞤭𞤴𞤢𞤲𞤢𞥄#,
		},
		'America/Indianapolis' => {
			exemplarCity => q#𞤋𞤲𞤣𞤭𞤴𞤢𞤲𞤢𞥄𞤨𞤮𞤤𞤭𞤧#,
		},
		'America/Inuvik' => {
			exemplarCity => q#𞤋𞤲𞤵𞤾𞤭𞤳#,
		},
		'America/Iqaluit' => {
			exemplarCity => q#𞤋𞤳𞤢𞤤𞤵𞤱𞤭𞤼#,
		},
		'America/Jamaica' => {
			exemplarCity => q#𞤔𞤢𞤥𞤢𞥄𞤴𞤳𞤢#,
		},
		'America/Jujuy' => {
			exemplarCity => q#𞤔𞤵𞤶𞤵𞤴#,
		},
		'America/Juneau' => {
			exemplarCity => q#𞤔𞤵𞥅𞤲𞤮𞥅#,
		},
		'America/Kentucky/Monticello' => {
			exemplarCity => q#𞤃𞤮𞤲𞤼𞤭𞤷𞤫𞤤𞤮𞥅, 𞤑𞤫𞤲𞤼𞤮𞥅𞤳𞤭𞥅#,
		},
		'America/Kralendijk' => {
			exemplarCity => q#𞤑𞤪𞤢𞤤𞤫𞤲𞤶𞤭𞥅𞤳#,
		},
		'America/La_Paz' => {
			exemplarCity => q#𞤂𞤢-𞤆𞤢𞥄𞥁#,
		},
		'America/Lima' => {
			exemplarCity => q#𞤂𞤭𞥅𞤥𞤢#,
		},
		'America/Los_Angeles' => {
			exemplarCity => q#𞤂𞤮𞤧-𞤀𞤺𞤫𞤤𞤫𞥅𞤧#,
		},
		'America/Louisville' => {
			exemplarCity => q#𞤂𞤵𞤭𞤾𞤭𞤤#,
		},
		'America/Lower_Princes' => {
			exemplarCity => q#𞤂𞤮𞤱𞤮 𞤆𞤪𞤫𞤲𞤧𞤫𞥅𞤧 𞤑𞤮𞤣𞤮𞥅#,
		},
		'America/Maceio' => {
			exemplarCity => q#𞤃𞤢𞤧𞤫𞤴𞤮#,
		},
		'America/Managua' => {
			exemplarCity => q#𞤃𞤢𞤲𞤢𞤱𞤢𞥄#,
		},
		'America/Manaus' => {
			exemplarCity => q#𞤃𞤢𞤲𞤵𞥅𞤧#,
		},
		'America/Marigot' => {
			exemplarCity => q#𞤃𞤢𞤪𞤭𞤺𞤮𞥅#,
		},
		'America/Martinique' => {
			exemplarCity => q#𞤃𞤢𞤪𞤼𞤭𞤲𞤭𞤳#,
		},
		'America/Matamoros' => {
			exemplarCity => q#𞤃𞤢𞤼𞤢𞤥𞤮𞤪𞤮𞥅𞤧#,
		},
		'America/Mazatlan' => {
			exemplarCity => q#𞤃𞤢𞥁𞤢𞤼𞤤𞤢𞤲#,
		},
		'America/Mendoza' => {
			exemplarCity => q#𞤃𞤫𞤲𞤣𞤮𞥅𞥁𞤢#,
		},
		'America/Menominee' => {
			exemplarCity => q#𞤃𞤫𞤲𞤮𞤥𞤭𞤲𞤭#,
		},
		'America/Merida' => {
			exemplarCity => q#𞤃𞤫𞤪𞤭𞤣𞤢#,
		},
		'America/Metlakatla' => {
			exemplarCity => q#𞤃𞤫𞤼𞤤𞤢𞤳𞤢𞤼𞤤𞤢#,
		},
		'America/Mexico_City' => {
			exemplarCity => q#𞤃𞤫𞤳𞤧𞤭𞤳𞤮𞥅 𞤅𞤭𞤼𞤭𞥅#,
		},
		'America/Miquelon' => {
			exemplarCity => q#𞤃𞤫𞤳𞤫𞤤𞤮𞤲#,
		},
		'America/Moncton' => {
			exemplarCity => q#𞤃𞤮𞤲𞤳𞤼𞤮𞥅𞤲#,
		},
		'America/Monterrey' => {
			exemplarCity => q#𞤃𞤮𞤲𞤼𞤫𞤪𞤫𞥅𞤴#,
		},
		'America/Montevideo' => {
			exemplarCity => q#𞤃𞤮𞤲𞤼𞤫𞤾𞤭𞤣𞤭𞤴𞤮𞥅#,
		},
		'America/Montserrat' => {
			exemplarCity => q#𞤃𞤮𞤲𞤼𞤧𞤭𞤪𞤢𞤴𞤼#,
		},
		'America/Nassau' => {
			exemplarCity => q#𞤐𞤢𞤧𞤮𞥅#,
		},
		'America/New_York' => {
			exemplarCity => q#𞤐𞤫𞤱-𞤒𞤮𞤪𞤳#,
		},
		'America/Nipigon' => {
			exemplarCity => q#𞤐𞤭𞤨𞤭𞤺𞤮𞤲#,
		},
		'America/Nome' => {
			exemplarCity => q#𞤐𞤮𞤱𞤥𞤵#,
		},
		'America/Noronha' => {
			exemplarCity => q#𞤃𞤢𞤪𞤮𞤲𞤿𞤢#,
		},
		'America/North_Dakota/Beulah' => {
			exemplarCity => q#𞤄𞤵𞤤𞤢𞥄, 𞤐𞤮𞤪𞤬-𞤁𞤢𞤳𞤮𞤼𞤢#,
		},
		'America/North_Dakota/Center' => {
			exemplarCity => q#𞤅𞤫𞤲𞤼𞤮𞥅, 𞤐𞤮𞤪𞤬-𞤁𞤢𞤳𞤮𞤼𞤢𞥄#,
		},
		'America/North_Dakota/New_Salem' => {
			exemplarCity => q#𞤐𞤫𞤱-𞤅𞤫𞤤𞤫𞤥, 𞤐𞤮𞤪𞤬-𞤁𞤢𞤳𞤮𞤼𞤢𞥄#,
		},
		'America/Ojinaga' => {
			exemplarCity => q#𞤌𞤶𞤭𞤲𞤢𞤺𞤢#,
		},
		'America/Panama' => {
			exemplarCity => q#𞤆𞤢𞤲𞤢𞤲𞤥𞤢𞥄#,
		},
		'America/Pangnirtung' => {
			exemplarCity => q#𞤆𞤢𞤲𞤺#,
		},
		'America/Paramaribo' => {
			exemplarCity => q#𞤆𞤢𞤪𞤢𞤥𞤢𞤪𞤭𞤦𞤮#,
		},
		'America/Phoenix' => {
			exemplarCity => q#𞤊𞤭𞤲𞤭𞤳𞤧#,
		},
		'America/Port-au-Prince' => {
			exemplarCity => q#𞤆𞤮𞤪𞤼-𞤮-𞤆𞤪𞤫𞤲𞤧#,
		},
		'America/Port_of_Spain' => {
			exemplarCity => q#𞤆𞤮𞤪𞤼 𞤮𞤬 𞤅𞤭𞤨𞤫𞥅𞤲#,
		},
		'America/Porto_Velho' => {
			exemplarCity => q#𞤆𞤮𞤪𞤼𞤮-𞤜𞤫𞤤𞤸𞤮𞥅#,
		},
		'America/Puerto_Rico' => {
			exemplarCity => q#𞤆𞤮𞤪𞤼-𞤈𞤭𞤳𞤮𞥅#,
		},
		'America/Punta_Arenas' => {
			exemplarCity => q#𞤆𞤵𞤲𞤼𞤢-𞤀𞤪𞤫𞤲𞤢𞥁#,
		},
		'America/Rainy_River' => {
			exemplarCity => q#𞤈𞤫𞤲𞤭𞥅-𞤈𞤭𞤾𞤮𞥅#,
		},
		'America/Rankin_Inlet' => {
			exemplarCity => q#𞤈𞤢𞤲𞤳𞤭𞤲 𞤋𞤲𞤤𞤫𞤼#,
		},
		'America/Recife' => {
			exemplarCity => q#𞤈𞤫𞤧𞤭𞤬𞤭#,
		},
		'America/Regina' => {
			exemplarCity => q#𞤈𞤭𞤺𞤭𞤲𞤢𞥄#,
		},
		'America/Resolute' => {
			exemplarCity => q#𞤈𞤭𞤧𞤮𞤤𞤵𞥅𞤼#,
		},
		'America/Rio_Branco' => {
			exemplarCity => q#𞤈𞤭𞤴𞤮-𞤄𞤪𞤢𞤲𞤳𞤮#,
		},
		'America/Santarem' => {
			exemplarCity => q#𞤅𞤢𞤲𞤼𞤢𞤪𞤫𞥅𞤥#,
		},
		'America/Santiago' => {
			exemplarCity => q#𞤅𞤢𞤲𞤼𞤭𞤴𞤢𞤺𞤮𞥅#,
		},
		'America/Santo_Domingo' => {
			exemplarCity => q#𞤅𞤢𞤲𞤼𞤢-𞤁𞤮𞤥𞤭𞤲𞤺𞤮𞥅#,
		},
		'America/Sao_Paulo' => {
			exemplarCity => q#𞤅𞤢𞥄𞤱-𞤆𞤮𞤤𞤮𞥅#,
		},
		'America/Scoresbysund' => {
			exemplarCity => q#‮𞤋𞤼𞥆𞤮𞤳𞤮𞤪𞤼𞤮𞥅𞤪𞤥𞤭𞥅𞤼#,
		},
		'America/Sitka' => {
			exemplarCity => q#𞤅𞤭𞤼𞤳𞤢#,
		},
		'America/St_Barthelemy' => {
			exemplarCity => q#𞤅𞤫𞤲𞤼-𞤄𞤢𞤼𞤫𞤤𞤫𞤥𞤭𞥅#,
		},
		'America/St_Johns' => {
			exemplarCity => q#𞤅𞤫𞤲𞤼-𞤔𞤮𞥅𞤲𞤧#,
		},
		'America/St_Kitts' => {
			exemplarCity => q#𞤅𞤫𞤲𞤼-𞤑𞤭𞤼𞥆𞤭𞤧#,
		},
		'America/St_Lucia' => {
			exemplarCity => q#𞤅𞤫𞤲𞤼-𞤂𞤵𞤧𞤭𞤢#,
		},
		'America/St_Thomas' => {
			exemplarCity => q#𞤅𞤫𞤲𞤼-𞤚𞤮𞤥𞤢𞥄𞤧#,
		},
		'America/St_Vincent' => {
			exemplarCity => q#𞤅𞤫𞤲𞤼-𞤜𞤫𞤲𞤧𞤫𞤲𞤼#,
		},
		'America/Swift_Current' => {
			exemplarCity => q#𞤅𞤭𞤬𞤼-𞤑𞤭𞤪𞥆𞤢𞤲𞤼#,
		},
		'America/Tegucigalpa' => {
			exemplarCity => q#𞤚𞤵𞤺𞤵𞤧𞤭𞤺𞤵𞤤𞤨𞤢#,
		},
		'America/Thule' => {
			exemplarCity => q#𞤚𞤵𞤤𞤫#,
		},
		'America/Thunder_Bay' => {
			exemplarCity => q#𞤚𞤵𞤲𞤣𞤮𞥅 𞤄𞤫𞥅#,
		},
		'America/Tijuana' => {
			exemplarCity => q#𞤚𞤭𞤶𞤵𞤱𞤢𞥄𞤲𞤢#,
		},
		'America/Toronto' => {
			exemplarCity => q#𞤚𞤮𞤪𞤮𞤲𞤼𞤮𞥅#,
		},
		'America/Tortola' => {
			exemplarCity => q#𞤚𞤮𞤪𞤼𞤮𞤤𞤢𞥄#,
		},
		'America/Vancouver' => {
			exemplarCity => q#𞤜𞤫𞤲𞤳𞤵𞥅𞤾𞤮#,
		},
		'America/Whitehorse' => {
			exemplarCity => q#𞤏𞤢𞤴𞤼𞤸𞤮𞤪𞤧𞤫#,
		},
		'America/Winnipeg' => {
			exemplarCity => q#𞤏𞤭𞤲𞤭𞤨𞤫𞥅𞤺#,
		},
		'America/Yakutat' => {
			exemplarCity => q#𞤒𞤢𞤳𞤵𞤼𞤢𞤼#,
		},
		'America/Yellowknife' => {
			exemplarCity => q#𞤒𞤫𞤤𞤮𞥅𞤲𞤢𞤴𞤬#,
		},
		'America_Central' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤚𞤵𞤥𞤦𞤮 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤵𞤥𞤦𞤮 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤚𞤵𞤥𞤦𞤮 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄#,
			},
		},
		'America_Eastern' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄#,
			},
		},
		'America_Mountain' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤆𞤫𞤤𞥆𞤭𞤲𞤳𞤮𞥅𞤪𞤫 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤆𞤫𞤤𞥆𞤭𞤲𞤳𞤮𞥅𞤪𞤫 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄#,
			},
		},
		'America_Pacific' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤁𞤫𞤰𞥆𞤮 𞤕𞤫𞥅𞤯𞤵 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤁𞤫𞤰𞥆𞤮 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤁𞤫𞤰𞥆𞤮 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤐𞤢𞤲𞥆𞤢𞥄𞤲𞤺𞤫 𞤀𞤥𞤫𞤪𞤭𞤳𞤢𞥄#,
			},
		},
		'Antarctica/Casey' => {
			exemplarCity => q#𞤑𞤢𞤴𞤧𞤫#,
		},
		'Antarctica/Davis' => {
			exemplarCity => q#𞤁𞤢𞤾𞤭𞥅𞤧#,
		},
		'Antarctica/DumontDUrville' => {
			exemplarCity => q#𞤁𞤭𞤥𞤮𞤲𞤼𞤵-𞤁𞤵𞤪𞤾𞤭𞤤#,
		},
		'Antarctica/Macquarie' => {
			exemplarCity => q#𞤃𞤢𞤳𞤢𞥄𞤪𞤭#,
		},
		'Antarctica/Mawson' => {
			exemplarCity => q#𞤃𞤢𞤱𞤧𞤮𞤲#,
		},
		'Antarctica/McMurdo' => {
			exemplarCity => q#𞤃𞤢𞤳𞤥𞤵𞥅𞤪𞤣𞤮#,
		},
		'Antarctica/Palmer' => {
			exemplarCity => q#𞤆𞤢𞤤𞤥𞤫𞥅𞤪#,
		},
		'Antarctica/Rothera' => {
			exemplarCity => q#𞤈𞤮𞤼𞤫𞤪𞤢#,
		},
		'Antarctica/Syowa' => {
			exemplarCity => q#𞤅𞤢𞥄𞤴𞤵𞤱𞤢#,
		},
		'Antarctica/Troll' => {
			exemplarCity => q#𞤚𞤢𞤪𞤮𞥅𞤤#,
		},
		'Antarctica/Vostok' => {
			exemplarCity => q#𞤜𞤮𞤧𞤼𞤮𞤳#,
		},
		'Apia' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤀𞥄𞤨𞤭𞤴𞤢#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤀𞥄𞤨𞤭𞤴𞤢#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤀𞥄𞤨𞤭𞤴𞤢#,
			},
		},
		'Arabian' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤀𞥄𞤪𞤢𞤦𞤭𞤴𞤢#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤀𞥄𞤪𞤢𞤦𞤭𞤴𞤢#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤀𞥄𞤪𞤢𞤦𞤭𞤴𞤢#,
			},
		},
		'Arctic/Longyearbyen' => {
			exemplarCity => q#𞤂𞤮𞤲𞤶𞤭𞤪𞤦𞤭𞤴𞤫𞥅𞤲#,
		},
		'Argentina' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤀𞤪𞤶𞤢𞤲𞤼𞤭𞤲𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤀𞤪𞤶𞤢𞤲𞤼𞤭𞤲𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤀𞤪𞤶𞤢𞤲𞤼𞤭𞤲𞤢𞥄#,
			},
		},
		'Argentina_Western' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤀𞤪𞤶𞤢𞤲𞤼𞤭𞤲𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤀𞤪𞤶𞤢𞤲𞤼𞤭𞤲𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤀𞤪𞤶𞤢𞤲𞤼𞤭𞤲𞤢𞥄#,
			},
		},
		'Armenia' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤀𞤪𞤥𞤫𞤲𞤭𞤴𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤀𞤪𞤥𞤫𞤲𞤭𞤴𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤀𞤪𞤥𞤫𞤲𞤭𞤴𞤢𞥄#,
			},
		},
		'Asia/Aden' => {
			exemplarCity => q#𞤀𞤣𞤫𞤲#,
		},
		'Asia/Almaty' => {
			exemplarCity => q#𞤀𞤤𞤥𞤢𞥄𞤼𞤭#,
		},
		'Asia/Amman' => {
			exemplarCity => q#𞤀𞤥𞤢𞥄𞤲𞤵#,
		},
		'Asia/Anadyr' => {
			exemplarCity => q#𞤀𞤲𞤢𞤣𞤭𞥅𞤪#,
		},
		'Asia/Aqtau' => {
			exemplarCity => q#𞤀𞤳𞤼𞤢𞥄𞤱𞤵#,
		},
		'Asia/Aqtobe' => {
			exemplarCity => q#𞤀𞤳𞤼𞤮𞥅𞤦𞤫#,
		},
		'Asia/Ashgabat' => {
			exemplarCity => q#𞤀𞤧𞤺𞤢𞤦𞤢𞤼𞤵#,
		},
		'Asia/Atyrau' => {
			exemplarCity => q#𞤀𞤼𞤭𞤪𞤢𞤱𞤵#,
		},
		'Asia/Baghdad' => {
			exemplarCity => q#𞤄𞤢𞤿𞤣𞤢𞥄𞤣𞤵#,
		},
		'Asia/Bahrain' => {
			exemplarCity => q#𞤄𞤢𞤸𞤪𞤢𞤴𞤲𞤵#,
		},
		'Asia/Baku' => {
			exemplarCity => q#𞤄𞤢𞥄𞤳𞤵#,
		},
		'Asia/Bangkok' => {
			exemplarCity => q#𞤄𞤢𞤲𞤳𞤮𞥅𞤳𞤵#,
		},
		'Asia/Barnaul' => {
			exemplarCity => q#𞤄𞤢𞤪𞤲𞤢𞥄𞤤𞤵#,
		},
		'Asia/Beirut' => {
			exemplarCity => q#𞤄𞤫𞤴𞤪𞤵𞥅𞤼𞤵#,
		},
		'Asia/Bishkek' => {
			exemplarCity => q#𞤄𞤭𞤧𞤳𞤫𞥅𞤳𞤵#,
		},
		'Asia/Brunei' => {
			exemplarCity => q#𞤄𞤵𞤪𞤲𞤢𞤴#,
		},
		'Asia/Calcutta' => {
			exemplarCity => q#𞤑𞤮𞤤𞤳𞤢𞤼𞤢#,
		},
		'Asia/Chita' => {
			exemplarCity => q#𞤕𞤭𞥅𞤼𞤢#,
		},
		'Asia/Choibalsan' => {
			exemplarCity => q#𞤕𞤮𞤴𞤦𞤢𞤤𞤧𞤢𞤲#,
		},
		'Asia/Colombo' => {
			exemplarCity => q#𞤑𞤮𞤤𞤮𞤥𞤦𞤢#,
		},
		'Asia/Damascus' => {
			exemplarCity => q#𞤁𞤢𞤥𞤢𞤧𞤹𞤢#,
		},
		'Asia/Dhaka' => {
			exemplarCity => q#𞤁𞤢𞤳𞤢𞥄#,
		},
		'Asia/Dili' => {
			exemplarCity => q#𞤁𞤫𞤤𞤭𞥅#,
		},
		'Asia/Dubai' => {
			exemplarCity => q#𞤁𞤵𞤦𞤢𞤴#,
		},
		'Asia/Dushanbe' => {
			exemplarCity => q#𞤁𞤵𞤧𞤢𞤲𞤦𞤫#,
		},
		'Asia/Famagusta' => {
			exemplarCity => q#𞤊𞤢𞤥𞤢𞤺𞤵𞤧𞤼𞤢#,
		},
		'Asia/Gaza' => {
			exemplarCity => q#𞤘𞤢𞥄𞥁𞤢#,
		},
		'Asia/Hebron' => {
			exemplarCity => q#𞤝𞤭𞤤𞤢𞥄𞤤𞤵#,
		},
		'Asia/Hong_Kong' => {
			exemplarCity => q#𞤖𞤮𞤲𞤺 𞤑𞤮𞤲𞤺#,
		},
		'Asia/Hovd' => {
			exemplarCity => q#𞤖𞤮𞤬𞤣𞤵#,
		},
		'Asia/Irkutsk' => {
			exemplarCity => q#𞤋𞤪𞤳𞤵𞤼𞤭𞤧𞤳𞤵#,
		},
		'Asia/Jakarta' => {
			exemplarCity => q#𞤔𞤢𞤳𞤢𞤪𞤼𞤢𞥄#,
		},
		'Asia/Jayapura' => {
			exemplarCity => q#𞤔𞤢𞤴𞤢𞤨𞤵𞤪𞤢#,
		},
		'Asia/Jerusalem' => {
			exemplarCity => q#𞤗𞤵𞤣𞤵𞤧𞤵#,
		},
		'Asia/Kabul' => {
			exemplarCity => q#𞤑𞤢𞤦𞤵𞤤#,
		},
		'Asia/Kamchatka' => {
			exemplarCity => q#𞤑𞤢𞤥𞤷𞤢𞤼𞤭𞤳𞤢#,
		},
		'Asia/Karachi' => {
			exemplarCity => q#𞤑𞤢𞤪𞤢𞤷𞤭𞥅#,
		},
		'Asia/Katmandu' => {
			exemplarCity => q#𞤑𞤢𞤼𞤭𞤥𞤢𞤲𞤣𞤵#,
		},
		'Asia/Khandyga' => {
			exemplarCity => q#𞤝𞤢𞤲𞤣𞤭𞤺𞤢#,
		},
		'Asia/Krasnoyarsk' => {
			exemplarCity => q#𞤑𞤢𞤪𞤢𞤧𞤲𞤮𞤴𞤢𞤪𞤧𞤵𞤳𞤵#,
		},
		'Asia/Kuala_Lumpur' => {
			exemplarCity => q#𞤑𞤵𞤱𞤢𞤤𞤢-𞤂𞤮𞤥𞤨𞤵𞥅𞤪#,
		},
		'Asia/Kuching' => {
			exemplarCity => q#𞤑𞤵𞤷𞤭𞤲#,
		},
		'Asia/Kuwait' => {
			exemplarCity => q#𞤑𞤵𞤱𞤢𞤴𞤼𞤭#,
		},
		'Asia/Macau' => {
			exemplarCity => q#𞤃𞤢𞤳𞤢𞤱𞤮#,
		},
		'Asia/Magadan' => {
			exemplarCity => q#𞤃𞤢𞤺𞤢𞤣𞤢𞤲#,
		},
		'Asia/Makassar' => {
			exemplarCity => q#𞤃𞤢𞤳𞤢𞤧𞤢𞥄𞤪#,
		},
		'Asia/Manila' => {
			exemplarCity => q#𞤃𞤢𞤲𞤭𞤤𞤢#,
		},
		'Asia/Muscat' => {
			exemplarCity => q#𞤃𞤵𞤧𞤳𞤢𞤼𞤵#,
		},
		'Asia/Nicosia' => {
			exemplarCity => q#𞤐𞤭𞤳𞤮𞤧𞤭𞤴𞤢#,
		},
		'Asia/Novokuznetsk' => {
			exemplarCity => q#𞤐𞤮𞤾𞤮𞤳𞤵𞥁𞤲𞤫𞤼𞤭𞤧𞤳𞤵#,
		},
		'Asia/Novosibirsk' => {
			exemplarCity => q#𞤐𞤮𞤾𞤮𞤧𞤭𞤦𞤭𞤪𞤧𞤵𞤳#,
		},
		'Asia/Omsk' => {
			exemplarCity => q#𞤌𞤥𞤧𞤵𞤳𞤵#,
		},
		'Asia/Oral' => {
			exemplarCity => q#𞤓𞤪𞤢𞤤#,
		},
		'Asia/Phnom_Penh' => {
			exemplarCity => q#𞤆𞤢𞤲𞤮𞤥-𞤆𞤫𞤲#,
		},
		'Asia/Pontianak' => {
			exemplarCity => q#𞤆𞤮𞤲𞤼𞤭𞤴𞤢𞤲𞤢𞤳#,
		},
		'Asia/Pyongyang' => {
			exemplarCity => q#𞤆𞤭𞤴𞤮𞤲𞤴𞤢𞤲#,
		},
		'Asia/Qatar' => {
			exemplarCity => q#𞤗𞤢𞤼𞤢𞤪#,
		},
		'Asia/Qostanay' => {
			exemplarCity => q#𞤑𞤮𞤧𞤼𞤢𞤲𞤢𞤴#,
		},
		'Asia/Qyzylorda' => {
			exemplarCity => q#𞤑𞤭𞥁𞤭𞤤𞤮𞤪𞤣𞤢#,
		},
		'Asia/Rangoon' => {
			exemplarCity => q#𞤈𞤢𞤲𞤺𞤵𞥅𞤲#,
		},
		'Asia/Riyadh' => {
			exemplarCity => q#𞤈𞤭𞤴𞤢𞥄𞤣#,
		},
		'Asia/Saigon' => {
			exemplarCity => q#𞤅𞤢𞤸𞤪𞤫 𞤖𞤮𞥅-𞤕𞤭 𞤃𞤭𞥅𞤲#,
		},
		'Asia/Sakhalin' => {
			exemplarCity => q#𞤅𞤢𞤿𞤢𞤤𞤭𞥅𞤲#,
		},
		'Asia/Samarkand' => {
			exemplarCity => q#𞤅𞤢𞤥𞤢𞤪𞤳𞤢𞤲𞤣𞤵#,
		},
		'Asia/Seoul' => {
			exemplarCity => q#𞤅𞤫𞤱𞤵𞤤#,
		},
		'Asia/Shanghai' => {
			exemplarCity => q#𞤅𞤢𞤲𞤸𞤢𞤴#,
		},
		'Asia/Singapore' => {
			exemplarCity => q#𞤅𞤭𞤲𞤺𞤢𞤨𞤵𞥅𞤪#,
		},
		'Asia/Srednekolymsk' => {
			exemplarCity => q#𞤅𞤭𞤪𞤫𞤣𞤳𞤮𞤤𞤭𞤥𞤧𞤵#,
		},
		'Asia/Taipei' => {
			exemplarCity => q#𞤚𞤢𞤴𞤨𞤫𞥅#,
		},
		'Asia/Tashkent' => {
			exemplarCity => q#𞤚𞤢𞤧𞤳𞤫𞤲𞤼𞤵#,
		},
		'Asia/Tbilisi' => {
			exemplarCity => q#𞤚𞤭𞤦𞤭𞤤𞤭𞤧𞤭𞥅#,
		},
		'Asia/Tehran' => {
			exemplarCity => q#𞤚𞤫𞤸𞤭𞤪𞤢𞥄𞤲#,
		},
		'Asia/Thimphu' => {
			exemplarCity => q#𞤚𞤭𞤥𞤨𞤵#,
		},
		'Asia/Tokyo' => {
			exemplarCity => q#𞤚𞤮𞤳𞤭𞤴𞤮#,
		},
		'Asia/Tomsk' => {
			exemplarCity => q#𞤚𞤮𞤥𞤧𞤵𞤳𞤵#,
		},
		'Asia/Ulaanbaatar' => {
			exemplarCity => q#𞤓𞤤𞤢𞤲𞤦𞤢𞤼𞤢𞤪#,
		},
		'Asia/Urumqi' => {
			exemplarCity => q#𞤓𞤪𞤵𞤥𞤳𞤵#,
		},
		'Asia/Ust-Nera' => {
			exemplarCity => q#𞤓𞤧𞤼𞤢-𞤐𞤫𞤪𞤢#,
		},
		'Asia/Vientiane' => {
			exemplarCity => q#𞤜𞤭𞤴𞤫𞤲𞤷𞤢𞥄𞤲#,
		},
		'Asia/Vladivostok' => {
			exemplarCity => q#𞤜𞤭𞤤𞤢𞤣𞤭𞤾𞤮𞤧𞤼𞤮𞥅𞤳𞤵#,
		},
		'Asia/Yakutsk' => {
			exemplarCity => q#𞤒𞤢𞤳𞤵𞤼𞤵𞤧𞤳𞤵#,
		},
		'Asia/Yekaterinburg' => {
			exemplarCity => q#𞤒𞤢𞤳𞤢𞤼𞤫𞤪𞤭𞤲𞤦𞤵𞤪𞤺𞤵#,
		},
		'Asia/Yerevan' => {
			exemplarCity => q#𞤒𞤫𞤪𞤫𞤾𞤢𞥄𞤲#,
		},
		'Atlantic' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤚𞤫𞤳𞤵#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤫𞤳𞤵#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤫𞤳𞤵 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫#,
			},
		},
		'Atlantic/Azores' => {
			exemplarCity => q#𞤀𞥁𞤮𞤪𞤫𞥅𞤧#,
		},
		'Atlantic/Bermuda' => {
			exemplarCity => q#𞤄𞤢𞤪𞤥𞤵𞥅𞤣𞤢#,
		},
		'Atlantic/Canary' => {
			exemplarCity => q#𞤑𞤢𞤲𞤢𞤪𞤭#,
		},
		'Atlantic/Cape_Verde' => {
			exemplarCity => q#𞤑𞤢𞥄𞤦𞤮-𞤜𞤫𞤪𞤣𞤫#,
		},
		'Atlantic/Faeroe' => {
			exemplarCity => q#𞤊𞤢𞤪𞤮𞥅#,
		},
		'Atlantic/Madeira' => {
			exemplarCity => q#𞤃𞤢𞤴𞤣𞤫𞤪𞤢#,
		},
		'Atlantic/Reykjavik' => {
			exemplarCity => q#𞤈𞤫𞤴𞤳𞤢𞤾𞤭𞤳𞤭#,
		},
		'Atlantic/South_Georgia' => {
			exemplarCity => q#𞤅𞤢𞤱𞤬-𞤔𞤮𞤪𞤶𞤭𞤴𞤢𞥄#,
		},
		'Atlantic/St_Helena' => {
			exemplarCity => q#𞤅𞤫𞤲𞤼-𞤖𞤫𞤤𞤫𞤲𞤢𞥄#,
		},
		'Atlantic/Stanley' => {
			exemplarCity => q#𞤅𞤭𞤼𞤢𞤲𞤤𞤫𞥅#,
		},
		'Australia/Adelaide' => {
			exemplarCity => q#𞤀𞤣𞤢𞤤𞤢𞤴𞤣𞤭#,
		},
		'Australia/Brisbane' => {
			exemplarCity => q#𞤄𞤭𞤪𞤧𞤭𞤦𞤢𞥄𞤲𞤵#,
		},
		'Australia/Broken_Hill' => {
			exemplarCity => q#𞤄𞤪𞤮𞤳𞤭𞤲-𞤖𞤭𞥅𞤤#,
		},
		'Australia/Currie' => {
			exemplarCity => q#𞤑𞤵𞥅𞤪𞤭𞥅#,
		},
		'Australia/Darwin' => {
			exemplarCity => q#𞤁𞤢𞥄𞤪𞤱𞤭𞤲#,
		},
		'Australia/Eucla' => {
			exemplarCity => q#𞤓𞥅𞤳𞤵𞤤𞤢#,
		},
		'Australia/Hobart' => {
			exemplarCity => q#𞤖𞤵𞥅𞤦𞤢𞤪𞤼𞤵#,
		},
		'Australia/Lindeman' => {
			exemplarCity => q#𞤂𞤭𞤲𞤣𞤭𞥅𞤥𞤢𞥄𞤲#,
		},
		'Australia/Lord_Howe' => {
			exemplarCity => q#𞤂𞤮𞤪𞤣𞤵-𞤖𞤮𞤱𞤫#,
		},
		'Australia/Melbourne' => {
			exemplarCity => q#𞤃𞤫𞤤𞤦𞤵𞥅𞤪𞤲𞤵#,
		},
		'Australia/Perth' => {
			exemplarCity => q#𞤆𞤫𞤪𞤧𞤭#,
		},
		'Australia/Sydney' => {
			exemplarCity => q#𞤅𞤭𞤣𞤲𞤫𞥅#,
		},
		'Australia_Central' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤚𞤵𞤥𞤦𞤮𞥅𞤪𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤵𞤥𞤦𞤮𞥅𞤪𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤚𞤵𞤥𞤦𞤮𞥅𞤪𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄#,
			},
		},
		'Australia_CentralWestern' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤚𞤵𞤥𞤦𞤮 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤵𞤥𞤦𞤮 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤚𞤵𞤥𞤦𞤮 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄#,
			},
		},
		'Australia_Eastern' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄#,
			},
		},
		'Australia_Western' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫𞥅𞤪𞤭 𞤌𞤧𞤼𞤢𞤪𞤤𞤭𞤴𞤢𞥄#,
			},
		},
		'Azerbaijan' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤀𞤶𞤫𞤪𞤦𞤢𞤴𞤶𞤢𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤀𞤶𞤫𞤪𞤦𞤢𞤴𞤶𞤢𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤀𞤶𞤫𞤪𞤦𞤢𞤴𞤶𞤢𞤲#,
			},
		},
		'Azores' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤀𞥁𞤮𞤪𞤫𞤧#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤀𞥁𞤮𞤪𞤫𞤧#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤀𞥁𞤮𞤪𞤫𞤧#,
			},
		},
		'Bangladesh' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤄𞤢𞤲𞤺𞤭𞤤𞤢𞤣𞤫𞥅𞤧#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤄𞤢𞤲𞤺𞤭𞤤𞤢𞤣𞤫𞥅𞤧#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤄𞤢𞤲𞤺𞤭𞤤𞤢𞤣𞤫𞥅𞤧#,
			},
		},
		'Bhutan' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤄𞤵𞤼𞤢𞥄𞤲#,
			},
		},
		'Bolivia' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤄𞤮𞤤𞤭𞤾𞤭𞤴𞤢𞥄#,
			},
		},
		'Brasilia' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤄𞤪𞤢𞤧𞤭𞤤𞤭𞤴𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤄𞤪𞤢𞤧𞤭𞤤𞤭𞤴𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤄𞤪𞤢𞤧𞤭𞤤𞤭𞤴𞤢𞥄#,
			},
		},
		'Brunei' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤄𞤵𞤪𞤲𞤢𞤴#,
			},
		},
		'Cape_Verde' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤑𞤢𞥄𞤦𞤮-𞤜𞤫𞤪𞤣𞤫#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤑𞤢𞥄𞤦𞤮-𞤜𞤫𞤪𞤣𞤫#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤑𞤢𞥄𞤦𞤮 𞤜𞤫𞤪𞤣𞤫#,
			},
		},
		'Chamorro' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤕𞤮𞤥𞤮𞥅𞤪𞤮#,
			},
		},
		'Chatham' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤕𞤢𞥄𞤼𞤢𞤥#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤢𞤼𞤢𞥄𞤥#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤕𞤢𞤼𞤢𞥄𞤥#,
			},
		},
		'Chile' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤕𞤭𞤤𞤫𞥅#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤭𞤤𞤫𞥅#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤕𞤭𞤤𞤫𞥅#,
			},
		},
		'China' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤕𞤢𞤴𞤲𞤢#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤢𞤴𞤲𞤢#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤕𞤢𞤴𞤲𞤢#,
			},
		},
		'Choibalsan' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤅𞤮𞤴𞤦𞤢𞤤𞤧𞤢𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤮𞤴𞤦𞤢𞤤𞤧𞤢𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤅𞤮𞤴𞤦𞤢𞤤𞤧𞤢𞤲#,
			},
		},
		'Christmas' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤑𞤭𞤪𞤧𞤭𞤥𞤢𞥄𞤧#,
			},
		},
		'Cocos' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤑𞤮𞥅𞤳𞤮𞤧#,
			},
		},
		'Colombia' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤑𞤮𞤤𞤮𞤥𞤦𞤭𞤴𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤑𞤮𞤤𞤮𞤥𞤦𞤭𞤴𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤑𞤮𞤤𞤮𞤥𞤦𞤭𞤴𞤢𞥄#,
			},
		},
		'Cook' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤆𞤫𞤷𞥆𞤵 𞤕𞤫𞥅𞤯𞤵 𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤑𞤵𞥅𞤳#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤑𞤵𞥅𞤳#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤑𞤵𞥅𞤳#,
			},
		},
		'Cuba' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤑𞤵𞥅𞤦𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤑𞤵𞥅𞤦𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤑𞤵𞥅𞤦𞤢𞥄#,
			},
		},
		'Davis' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤁𞤫𞥅𞤾𞤭𞤧#,
			},
		},
		'DumontDUrville' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤁𞤭𞤥𞤮𞤲𞤼𞤵-𞤁𞤵𞤪𞤾𞤭𞤤#,
			},
		},
		'East_Timor' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤚𞤭𞥅𞤥𞤮𞤪#,
			},
		},
		'Easter' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤋𞤧𞤼𞤮𞥅-𞤀𞤴𞤤𞤢𞤲𞤣#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤋𞤧𞤼𞤮𞥅-𞤀𞤴𞤤𞤢𞤲𞤣#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤋𞤧𞤼𞤮𞥅-𞤀𞤴𞤤𞤢𞤲𞤣#,
			},
		},
		'Ecuador' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤋𞤳𞤵𞤱𞤢𞤣𞤮𞥅𞤪#,
			},
		},
		'Etc/UTC' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤭𞤤𞥆𞤢𞤲𞤳𞤮𞥅𞤪𞤫 𞤊𞤮𞤲𞤣𞤢𞥄𞤲𞤣𞤫#,
			},
		},
		'Etc/Unknown' => {
			exemplarCity => q#𞤅𞤢𞤸𞤪𞤫 𞤀𞤧-𞤢𞤲𞤣𞤢𞥄𞤲𞤣𞤫#,
		},
		'Europe/Amsterdam' => {
			exemplarCity => q#𞤀𞤥𞤧𞤭𞤼𞤫𞤪𞤣𞤢𞥄𞤥#,
		},
		'Europe/Andorra' => {
			exemplarCity => q#𞤀𞤲𞤣𞤮𞥅𞤪𞤢#,
		},
		'Europe/Astrakhan' => {
			exemplarCity => q#𞤀𞤧𞤼𞤢𞤪𞤿𞤢𞥄𞤲#,
		},
		'Europe/Athens' => {
			exemplarCity => q#𞤀𞤼𞤫𞤲𞤧𞤭#,
		},
		'Europe/Belgrade' => {
			exemplarCity => q#𞤄𞤫𞤤𞤺𞤢𞤪𞤢𞥄𞤣#,
		},
		'Europe/Berlin' => {
			exemplarCity => q#𞤄𞤫𞤪𞤤𞤫𞤲#,
		},
		'Europe/Bratislava' => {
			exemplarCity => q#𞤄𞤢𞤪𞤢𞤼𞤭𞤧𞤤𞤢𞤾𞤢#,
		},
		'Europe/Brussels' => {
			exemplarCity => q#𞤄𞤭𞤪𞤭𞤳𞤧𞤫𞤤#,
		},
		'Europe/Bucharest' => {
			exemplarCity => q#𞤄𞤵𞤳𞤢𞤪𞤫𞤧𞤼𞤭#,
		},
		'Europe/Budapest' => {
			exemplarCity => q#𞤄𞤵𞤣𞤢𞤨𞤫𞤧𞤼#,
		},
		'Europe/Busingen' => {
			exemplarCity => q#𞤄𞤵𞤧𞤭𞤲𞤶𞤫𞤲#,
		},
		'Europe/Chisinau' => {
			exemplarCity => q#𞤕𞤭𞤧𞤭𞥅𞤲𞤮𞤱𞤢#,
		},
		'Europe/Copenhagen' => {
			exemplarCity => q#𞤑𞤮𞤨𞤫𞤲𞥆𞤢𞥄𞤺#,
		},
		'Europe/Dublin' => {
			exemplarCity => q#𞤁𞤵𞤦𞤵𞤤𞤫𞤲#,
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤋𞤪𞤤𞤢𞤲𞤣𞤭𞤲𞤳𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫#,
			},
		},
		'Europe/Gibraltar' => {
			exemplarCity => q#𞤔𞤭𞤦𞤢𞤪𞤢𞤤𞤼𞤢𞤪#,
		},
		'Europe/Guernsey' => {
			exemplarCity => q#𞤔𞤭𞤪𞤲𞤭𞤧𞤫𞤴#,
		},
		'Europe/Helsinki' => {
			exemplarCity => q#𞤖𞤫𞤤𞤧𞤭𞤲𞤳𞤭#,
		},
		'Europe/Isle_of_Man' => {
			exemplarCity => q#𞤅𞤵𞤪𞤭𞥅𞤪𞤫-𞤃𞤢𞥄𞤲#,
		},
		'Europe/Istanbul' => {
			exemplarCity => q#𞤋𞤧𞤼𞤢𞤥𞤦𞤵𞤤#,
		},
		'Europe/Jersey' => {
			exemplarCity => q#𞤔𞤫𞤪𞤧𞤭𞥅#,
		},
		'Europe/Kaliningrad' => {
			exemplarCity => q#𞤑𞤢𞤤𞤭𞤲𞤺𞤢𞤪𞤣#,
		},
		'Europe/Kiev' => {
			exemplarCity => q#𞤑𞤭𞤴𞤫𞥅𞤾#,
		},
		'Europe/Kirov' => {
			exemplarCity => q#𞤑𞤭𞤪𞤮𞥅𞤾𞤵#,
		},
		'Europe/Lisbon' => {
			exemplarCity => q#𞤂𞤭𞤧𞤦𞤮𞥅𞤲#,
		},
		'Europe/Ljubljana' => {
			exemplarCity => q#𞤋𞤶𞤵𞤦𞤵𞤤𞤶𞤢𞤲𞤢#,
		},
		'Europe/London' => {
			exemplarCity => q#𞤂𞤮𞤲𞤣𞤮𞤲#,
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤄𞤪𞤭𞤼𞤭𞥅𞤧𞤭𞤲𞤳𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵#,
			},
		},
		'Europe/Luxembourg' => {
			exemplarCity => q#𞤂𞤭𞤳𞤧𞤢𞤲𞤦𞤵𞤪𞤺𞤵#,
		},
		'Europe/Madrid' => {
			exemplarCity => q#𞤃𞤢𞤣𞤭𞤪𞤭𞤣#,
		},
		'Europe/Malta' => {
			exemplarCity => q#𞤃𞤢𞤤𞤼𞤢#,
		},
		'Europe/Mariehamn' => {
			exemplarCity => q#𞤃𞤢𞤪𞤭𞤴𞤢𞤸𞤢𞥄𞤥𞤢𞥄𞤲#,
		},
		'Europe/Minsk' => {
			exemplarCity => q#𞤃𞤭𞤲𞤧𞤭𞤳𞤭#,
		},
		'Europe/Monaco' => {
			exemplarCity => q#𞤃𞤮𞤲𞤢𞤳𞤮𞤸#,
		},
		'Europe/Moscow' => {
			exemplarCity => q#𞤃𞤮𞤧𞤳𞤮#,
		},
		'Europe/Oslo' => {
			exemplarCity => q#𞤌𞤧𞤤𞤮𞤸#,
		},
		'Europe/Paris' => {
			exemplarCity => q#𞤆𞤢𞤪𞤭#,
		},
		'Europe/Podgorica' => {
			exemplarCity => q#𞤆𞤮𞤣𞤭𞤺𞤮𞤪𞤭𞤳𞤢#,
		},
		'Europe/Prague' => {
			exemplarCity => q#𞤆𞤢𞤪𞤢𞥄𞤺𞤭#,
		},
		'Europe/Riga' => {
			exemplarCity => q#𞤈𞤭𞤺𞤢#,
		},
		'Europe/Rome' => {
			exemplarCity => q#𞤈𞤮𞥅𞤥𞤵#,
		},
		'Europe/Samara' => {
			exemplarCity => q#𞤅𞤢𞤥𞤢𞤪𞤢#,
		},
		'Europe/San_Marino' => {
			exemplarCity => q#𞤅𞤢𞤲-𞤃𞤢𞤪𞤭𞤲𞤮#,
		},
		'Europe/Sarajevo' => {
			exemplarCity => q#𞤅𞤢𞤪𞤢𞤴𞤫𞤾𞤮𞥅#,
		},
		'Europe/Saratov' => {
			exemplarCity => q#𞤅𞤢𞤪𞤢𞤼𞤮𞥅𞤾#,
		},
		'Europe/Simferopol' => {
			exemplarCity => q#𞤅𞤭𞤥𞤬𞤫𞤪𞤨𞤮𞥅𞤤#,
		},
		'Europe/Skopje' => {
			exemplarCity => q#𞤅𞤭𞤳𞤮𞥅𞤨𞤭𞤴𞤢#,
		},
		'Europe/Sofia' => {
			exemplarCity => q#𞤅𞤮𞤬𞤭𞤴𞤢#,
		},
		'Europe/Stockholm' => {
			exemplarCity => q#𞤅𞤭𞤼𞤮𞤳𞤮𞤤𞤥𞤵#,
		},
		'Europe/Tallinn' => {
			exemplarCity => q#𞤚𞤢𞤤𞤭𞥅𞤲𞤵#,
		},
		'Europe/Tirane' => {
			exemplarCity => q#𞤚𞤭𞤪𞤢𞤲𞤢#,
		},
		'Europe/Ulyanovsk' => {
			exemplarCity => q#𞤓𞤤𞤴𞤢𞤲𞤮𞤾𞤮𞤧𞤳𞤵#,
		},
		'Europe/Uzhgorod' => {
			exemplarCity => q#𞤓𞥅𞤶𞤢𞤪𞤵𞥅𞤣𞤵#,
		},
		'Europe/Vaduz' => {
			exemplarCity => q#𞤜𞤢𞤣𞤵𞥅𞤶𞤵#,
		},
		'Europe/Vatican' => {
			exemplarCity => q#𞤜𞤢𞤼𞤭𞤳𞤢𞤲#,
		},
		'Europe/Vienna' => {
			exemplarCity => q#𞤜𞤭𞤴𞤫𞤲𞤢𞥄#,
		},
		'Europe/Vilnius' => {
			exemplarCity => q#𞤜𞤫𞤤𞤲𞤵𞥅𞤧#,
		},
		'Europe/Volgograd' => {
			exemplarCity => q#𞤜𞤮𞤤𞤺𞤮𞤺𞤢𞤪𞤢𞤣#,
		},
		'Europe/Warsaw' => {
			exemplarCity => q#𞤏𞤢𞤪𞤧𞤮#,
		},
		'Europe/Zagreb' => {
			exemplarCity => q#𞤟𞤢𞤺𞤪𞤫𞤦𞤵#,
		},
		'Europe/Zaporozhye' => {
			exemplarCity => q#𞤟𞤢𞤨𞤮𞤪𞤵𞥅𞥁#,
		},
		'Europe/Zurich' => {
			exemplarCity => q#𞤟𞤵𞤪𞤵𞤳#,
		},
		'Europe_Central' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤚𞤵𞤥𞤦𞤮𞥅𞤪𞤭 𞤀𞤪𞤮𞥅𞤦𞤢#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤵𞤥𞤦𞤮𞥅𞤪𞤭 𞤀𞤪𞤮𞥅𞤦𞤢#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤚𞤵𞤥𞤦𞤮𞥅𞤪𞤭 𞤀𞤪𞤮𞥅𞤦𞤢#,
			},
		},
		'Europe_Eastern' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤀𞤪𞤮𞥅𞤦𞤢#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤀𞤪𞤮𞥅𞤦𞤢#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤀𞤪𞤮𞥅𞤦𞤢#,
			},
		},
		'Europe_Further_Eastern' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞥋𞤺𞤫𞥅𞤪𞤭 𞤀𞤪𞤮𞥅𞤦𞤢#,
			},
		},
		'Europe_Western' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤀𞤪𞤮𞥅𞤦𞤢#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤀𞤪𞤮𞥅𞤦𞤢#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤀𞤪𞤮𞥅𞤦𞤢#,
			},
		},
		'Falkland' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤊𞤮𞤤𞤳𞤤𞤢𞤲𞤣-𞤀𞤴𞤤𞤢𞤲𞤣#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤊𞤮𞤤𞤳𞤤𞤢𞤲𞤣-𞤀𞤴𞤤𞤢𞤲𞤣#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤊𞤮𞤤𞤳𞤤𞤢𞤲𞤣-𞤀𞤴𞤤𞤢𞤲𞤣#,
			},
		},
		'Fiji' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤊𞤭𞤶𞤭𞥅#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤊𞤭𞤶𞤭𞥅#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤊𞤭𞤶𞤭𞥅#,
			},
		},
		'French_Guiana' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤘𞤢𞤴𞤢𞤲𞤢𞥄-𞤊𞤪𞤢𞤲𞤧𞤭#,
			},
		},
		'French_Southern' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤂𞤫𞤴𞤪𞤭 𞤊𞤪𞤢𞤲𞤧𞤭 & 𞤀𞤪𞤼𞤢𞤲𞤼𞤭𞤳𞤢#,
			},
		},
		'GMT' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤳𞤭𞤲𞤭𞥅𞤲𞥋𞤣𞤫 𞤘𞤪𞤭𞤲𞤱𞤭𞥅𞤧#,
			},
		},
		'Galapagos' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤘𞤢𞤤𞤢𞤨𞤢𞤺𞤮𞥅𞤧#,
			},
		},
		'Gambier' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤘𞤢𞤥𞤦𞤭𞤴𞤫𞤪#,
			},
		},
		'Georgia' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤔𞤮𞤪𞤶𞤭𞤴𞤢#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤔𞤮𞤪𞤶𞤭𞤴𞤢#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤔𞤮𞤪𞤶𞤭𞤴𞤢#,
			},
		},
		'Gilbert_Islands' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤵𞤪𞤭𞥅𞤶𞤫 𞤘𞤭𞤤𞤦𞤫𞤪𞤼𞤵#,
			},
		},
		'Greenland_Eastern' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫 𞤘𞤭𞤪𞤤𞤢𞤲𞤣#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫 𞤘𞤭𞤪𞤤𞤢𞤲𞤣#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤬𞤵𞤯𞤲𞤢𞥄𞤲𞤺𞤫 𞤘𞤭𞤪𞤤𞤢𞤲𞤣#,
			},
		},
		'Greenland_Western' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫 𞤘𞤭𞤪𞤤𞤢𞤲𞤣#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫 𞤘𞤭𞤪𞤤𞤢𞤲𞤣#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫 𞤘𞤭𞤪𞤤𞤢𞤲𞤣#,
			},
		},
		'Gulf' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤂𞤮𞥅𞤻𞤵#,
			},
		},
		'Guyana' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤘𞤢𞤴𞤢𞤲𞤢𞥄#,
			},
		},
		'Hawaii_Aleutian' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤖𞤢𞤱𞤢𞥄𞤴𞤭𞥅-𞤀𞤤𞤮𞤧𞤭𞤴𞤢𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤢𞥄𞤴𞤭𞥅-𞤀𞤤𞤮𞤧𞤭𞤴𞤢𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤖𞤢𞤱𞤢𞥄𞤴𞤭𞥅-𞤀𞤤𞤮𞤧𞤭𞤴𞤢𞤲#,
			},
		},
		'Hong_Kong' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤖𞤮𞤲𞤺 𞤑𞤮𞤲𞤺#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤮𞤲𞤺 𞤑𞤮𞤲𞤺#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤖𞤮𞤲𞤺 𞤑𞤮𞤲𞤺#,
			},
		},
		'Hovd' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤖𞤮𞤬𞤣𞤵#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤮𞤬𞤣𞤵#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤖𞤮𞤬𞤣𞤵#,
			},
		},
		'India' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤋𞤲𞤣𞤭𞤴𞤢#,
			},
		},
		'Indian/Antananarivo' => {
			exemplarCity => q#𞤀𞤲𞤼𞤢𞤲𞤢𞤲𞤢𞤪𞤭𞥅𞤾𞤮𞥅#,
		},
		'Indian/Chagos' => {
			exemplarCity => q#𞤅𞤢𞤺𞤮𞤧#,
		},
		'Indian/Christmas' => {
			exemplarCity => q#𞤑𞤭𞤪𞤧𞤭𞤥𞤢𞥄𞤧#,
		},
		'Indian/Cocos' => {
			exemplarCity => q#𞤑𞤮𞥅𞤳𞤮𞤧#,
		},
		'Indian/Comoro' => {
			exemplarCity => q#𞤑𞤮𞤥𞤮𞥅𞤪𞤮#,
		},
		'Indian/Kerguelen' => {
			exemplarCity => q#𞤑𞤫𞤪𞤺𞤫𞤤𞤫𞤲#,
		},
		'Indian/Mahe' => {
			exemplarCity => q#𞤃𞤢𞤸𞤫𞥅#,
		},
		'Indian/Maldives' => {
			exemplarCity => q#𞤃𞤢𞤤𞤣𞤢𞥄𞤴𞤭𞤧#,
		},
		'Indian/Mauritius' => {
			exemplarCity => q#𞤃𞤮𞤪𞤭𞥅𞤧𞤭#,
		},
		'Indian/Mayotte' => {
			exemplarCity => q#𞤃𞤢𞤴𞤮𞥅𞤼𞤵#,
		},
		'Indian/Reunion' => {
			exemplarCity => q#𞤈𞤫𞥅𞤲𞤭𞤴𞤮𞤲#,
		},
		'Indian_Ocean' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤃𞤢𞥄𞤴𞤮 𞤋𞤲𞤣𞤭𞤴𞤢𞤱𞤮#,
			},
		},
		'Indochina' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤋𞤲𞤣𞤮𞤧𞤭𞥅𞤲#,
			},
		},
		'Indonesia_Central' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤮𞤥𞤦𞤮𞥅𞤪𞤭 𞤋𞤲𞤣𞤮𞤲𞤭𞥅𞤧𞤭𞤴𞤢#,
			},
		},
		'Indonesia_Eastern' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤊𞤵𞤯𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤋𞤲𞤣𞤮𞤲𞤭𞥅𞤧𞤭𞤴𞤢#,
			},
		},
		'Indonesia_Western' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤋𞤲𞤣𞤮𞤲𞤭𞥅𞤧𞤭𞤴𞤢#,
			},
		},
		'Iran' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤋𞤪𞤢𞥄𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤋𞤪𞤢𞥄𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤋𞤪𞤢𞥄𞤲#,
			},
		},
		'Irkutsk' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤋𞤪𞤳𞤵𞤼𞤭𞤧𞤳𞤵#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤋𞤪𞤳𞤵𞤼𞤭𞤧𞤳𞤵#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤋𞤪𞤳𞤵𞤼𞤭𞤧𞤳𞤵#,
			},
		},
		'Israel' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤋𞤧𞤪𞤢𞥄𞤭𞥅𞤤𞤵#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤋𞤧𞤪𞤢𞥄𞤭𞥅𞤤𞤵#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤋𞤧𞤪𞤢𞥄𞤭𞥅𞤤𞤵#,
			},
		},
		'Japan' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤐𞤭𞤨𞥆𞤮𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤐𞤭𞤨𞥆𞤮𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤐𞤭𞤨𞥆𞤮𞤲#,
			},
		},
		'Kazakhstan_Eastern' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤑𞤢𞥁𞤢𞤿𞤢𞤧𞤼𞤢𞥄𞤲#,
			},
		},
		'Kazakhstan_Western' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤭𞤪𞤲𞤢𞥄𞤲𞥋𞤺𞤫 𞤑𞤢𞥁𞤢𞤿𞤢𞤧𞤼𞤢𞥄𞤲#,
			},
		},
		'Korea' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤑𞤮𞥅𞤪𞤫𞤴𞤢𞥄#,
			},
		},
		'Kosrae' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤑𞤮𞤧𞤪𞤢𞤴#,
			},
		},
		'Krasnoyarsk' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤑𞤢𞤪𞤢𞤧𞤲𞤮𞤴𞤢𞤪𞤧𞤭𞤳#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤑𞤢𞤪𞤢𞤧𞤲𞤮𞤴𞤢𞤪𞤧𞤭𞤳#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤑𞤪𞤢𞤧𞤲𞤮𞤴𞤢𞤪𞤧𞤭𞤳#,
			},
		},
		'Kyrgystan' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤑𞤭𞤪𞤺𞤭𞤧𞤼𞤢𞥄𞤲#,
			},
		},
		'Line_Islands' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤂𞤢𞤴𞤲𞤵#,
			},
		},
		'Lord_Howe' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤂𞤮𞤪𞤣𞤵-𞤖𞤮𞤱𞤫#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤂𞤮𞤪𞤣𞤵-𞤖𞤮𞤱𞤫#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤂𞤮𞤪𞤣𞤵-𞤖𞤮𞤱𞤫#,
			},
		},
		'Macquarie' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤃𞤢𞤳𞤢𞥄𞤪𞤭#,
			},
		},
		'Magadan' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤃𞤢𞤺𞤢𞤣𞤢𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤃𞤢𞤺𞤢𞤣𞤢𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤃𞤢𞤺𞤢𞤣𞤢𞤲#,
			},
		},
		'Malaysia' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤃𞤢𞤤𞤫𞥅𞤧𞤭𞤴𞤢#,
			},
		},
		'Maldives' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤃𞤢𞤤𞤣𞤢𞥄𞤴𞤭𞤧#,
			},
		},
		'Marquesas' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤃𞤢𞤪𞤳𞤫𞤧𞤢𞤧#,
			},
		},
		'Marshall_Islands' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤵𞤪𞤭𞥅𞤶𞤫 𞤃𞤢𞤪𞤧𞤢𞤤#,
			},
		},
		'Mauritius' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤃𞤮𞤪𞤭𞥅𞤧𞤭#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤃𞤮𞤪𞤭𞥅𞤧𞤭#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤃𞤮𞤪𞤭𞥅𞤧𞤭#,
			},
		},
		'Mawson' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤃𞤢𞤱𞤧𞤮𞤲#,
			},
		},
		'Mexico_Northwest' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤐𞤢𞤲𞤮-𞤸𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫 𞤃𞤫𞤳𞤧𞤭𞤳𞤮𞥅#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤐𞤢𞤲𞤮-𞤸𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫 𞤃𞤫𞤳𞤧𞤭𞤳𞤮𞥅#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤐𞤢𞤲𞤮-𞤸𞤭𞥅𞤪𞤲𞤢𞥄𞤲𞤺𞤫 𞤃𞤫𞤳𞤧𞤭𞤳𞤮𞥅#,
			},
		},
		'Mexico_Pacific' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤁𞤫𞤰𞥆𞤮 𞤃𞤫𞤳𞤧𞤭𞤳𞤮𞥅#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤁𞤫𞤰𞥆𞤮 𞤃𞤫𞤳𞤧𞤭𞤳𞤮𞥅#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤁𞤫𞤰𞥆𞤮 𞤃𞤫𞤳𞤧𞤭𞤳𞤮𞥅#,
			},
		},
		'Mongolia' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤓𞤤𞤢𞤲𞤦𞤢𞤼𞤢𞤪#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤓𞤤𞤢𞤲𞤦𞤢𞤼𞤢𞤪#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤓𞤤𞤢𞤲𞤦𞤢𞤼𞤢𞤪#,
			},
		},
		'Moscow' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤃𞤮𞤧𞤳𞤮#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤃𞤮𞤧𞤳𞤮#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤃𞤮𞤧𞤳𞤮#,
			},
		},
		'Myanmar' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤃𞤭𞤴𞤢𞤥𞤢𞥄𞤪#,
			},
		},
		'Nauru' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤐𞤵𞥅𞤪𞤵#,
			},
		},
		'Nepal' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤐𞤫𞤨𞤢𞤤#,
			},
		},
		'New_Caledonia' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤑𞤢𞤤𞤭𞤣𞤮𞤲𞤭𞤴𞤢𞥄 𞤖𞤫𞤧𞤮#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤑𞤢𞤤𞤭𞤣𞤮𞤲𞤭𞤴𞤢𞥄 𞤖𞤫𞤧𞤮#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤑𞤢𞤤𞤭𞤣𞤮𞤲𞤭𞤴𞤢𞥄 𞤖𞤫𞤧𞤮#,
			},
		},
		'New_Zealand' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤐𞤫𞤱-𞤟𞤫𞤤𞤢𞤲𞤣𞤭#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤐𞤫𞤱-𞤟𞤫𞤤𞤢𞤲𞤣𞤭#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤐𞤫𞤱-𞤟𞤫𞤤𞤢𞤲𞤣𞤭#,
			},
		},
		'Newfoundland' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤐𞤫𞤱-𞤊𞤵𞤲𞤣𞤵𞤤𞤢𞤲𞤣#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤐𞤫𞤱-𞤊𞤵𞤲𞤣𞤵𞤤𞤢𞤲𞤣#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤐𞤫𞤱-𞤊𞤵𞤲𞤣𞤵𞤤𞤢𞤲𞤣#,
			},
		},
		'Niue' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤐𞤵𞥅𞤱𞤭#,
			},
		},
		'Norfolk' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤐𞤮𞤪𞤬𞤮𞤤𞤳𞤵#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤐𞤮𞤪𞤬𞤮𞤤𞤳𞤵#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤐𞤮𞤪𞤬𞤮𞤤𞤳𞤵#,
			},
		},
		'Noronha' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤊𞤫𞤪𞤲𞤢𞤲𞤣𞤮𞥅 𞤣𞤫 𞤐𞤮𞤪𞤮𞤲𞤽𞤢𞥄#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤊𞤫𞤪𞤲𞤢𞤲𞤣𞤮𞥅 𞤣𞤫 𞤐𞤮𞤪𞤮𞤲𞤽𞤢𞥄#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤊𞤫𞤪𞤲𞤢𞤲𞤣𞤮𞥅 𞤣𞤫 𞤐𞤮𞤪𞤮𞤲𞤽𞤢𞥄#,
			},
		},
		'Novosibirsk' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤐𞤮𞤾𞤮𞤧𞤦𞤭𞤪𞤧𞤭𞤳#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤐𞤮𞤾𞤮𞤧𞤦𞤭𞤪𞤧𞤭𞤳#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤐𞤮𞤾𞤮𞤧𞤦𞤭𞤪𞤧𞤭𞤳#,
			},
		},
		'Omsk' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤌𞤥𞤧𞤵𞤳𞤵#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤌𞤥𞤧𞤵𞤳𞤵#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤌𞤥𞤧𞤵𞤳𞤵#,
			},
		},
		'Pacific/Apia' => {
			exemplarCity => q#𞤀𞥄𞤨𞤭𞤴𞤢#,
		},
		'Pacific/Auckland' => {
			exemplarCity => q#𞤌𞤳𞤤𞤢𞤲𞤣𞤭#,
		},
		'Pacific/Bougainville' => {
			exemplarCity => q#𞤄𞤵𞤺𞤫𞤲𞤾𞤭𞥅𞤤#,
		},
		'Pacific/Chatham' => {
			exemplarCity => q#𞤕𞤢𞥃𞤢𞥄𞤥#,
		},
		'Pacific/Easter' => {
			exemplarCity => q#𞤋𞤧𞤼𞤮𞥅#,
		},
		'Pacific/Efate' => {
			exemplarCity => q#𞤉𞤬𞤢𞤼𞤵#,
		},
		'Pacific/Enderbury' => {
			exemplarCity => q#𞤉𞤲𞤣𞤫𞤪𞤦𞤵𞥅𞤪𞤭#,
		},
		'Pacific/Fakaofo' => {
			exemplarCity => q#𞤊𞤢𞤳𞤢𞤱𞤬𞤮#,
		},
		'Pacific/Fiji' => {
			exemplarCity => q#𞤊𞤭𞤶𞤭𞥅#,
		},
		'Pacific/Funafuti' => {
			exemplarCity => q#𞤊𞤵𞤲𞤢𞤬𞤵𞤼𞤭𞥅#,
		},
		'Pacific/Galapagos' => {
			exemplarCity => q#𞤘𞤢𞤤𞤢𞤨𞤢𞤺𞤮𞤧#,
		},
		'Pacific/Gambier' => {
			exemplarCity => q#𞤘𞤢𞤥𞤦𞤭𞤴𞤫𞤪#,
		},
		'Pacific/Guadalcanal' => {
			exemplarCity => q#𞤘𞤵𞤱𞤢𞤣𞤢𞤤𞤳𞤢𞤲𞤢𞤤#,
		},
		'Pacific/Guam' => {
			exemplarCity => q#𞤘𞤵𞤱𞤢𞥄𞤥#,
		},
		'Pacific/Johnston' => {
			exemplarCity => q#𞤔𞤮𞤲𞤧𞤼𞤮𞤲#,
		},
		'Pacific/Kiritimati' => {
			exemplarCity => q#𞤑𞤭𞤪𞤭𞤼𞤭𞤥𞤢𞤼𞤭#,
		},
		'Pacific/Kosrae' => {
			exemplarCity => q#𞤑𞤮𞤧𞤪𞤫𞤴#,
		},
		'Pacific/Kwajalein' => {
			exemplarCity => q#𞤑𞤢𞤱𞤢𞤶𞤢𞤤𞤭𞥅𞤲#,
		},
		'Pacific/Majuro' => {
			exemplarCity => q#𞤃𞤢𞤶𞤵𞤪𞤮𞥅#,
		},
		'Pacific/Marquesas' => {
			exemplarCity => q#𞤃𞤢𞤪𞤳𞤫𞤧𞤢𞥄𞤧#,
		},
		'Pacific/Midway' => {
			exemplarCity => q#𞤃𞤭𞤣𞤱𞤫𞥅#,
		},
		'Pacific/Nauru' => {
			exemplarCity => q#𞤐𞤢𞤱𞤪𞤵#,
		},
		'Pacific/Niue' => {
			exemplarCity => q#𞤐𞤵𞥅𞤱𞤭#,
		},
		'Pacific/Norfolk' => {
			exemplarCity => q#𞤐𞤮𞤪𞤬𞤮𞤤𞤳𞤵#,
		},
		'Pacific/Noumea' => {
			exemplarCity => q#𞤐𞤵𞤥𞤫𞤴𞤢#,
		},
		'Pacific/Pago_Pago' => {
			exemplarCity => q#𞤆𞤢𞤺𞤮-𞤆𞤢𞤺𞤮#,
		},
		'Pacific/Palau' => {
			exemplarCity => q#𞤆𞤢𞤤𞤢𞤱#,
		},
		'Pacific/Pitcairn' => {
			exemplarCity => q#𞤆𞤭𞤼𞤳𞤭𞥅𞤪𞤲𞤵#,
		},
		'Pacific/Ponape' => {
			exemplarCity => q#𞤆𞤮𞤥𞤨𞤫𞥅#,
		},
		'Pacific/Port_Moresby' => {
			exemplarCity => q#𞤆𞤮𞤪𞤼𞤵-𞤃𞤮𞤪𞤫𞤧𞤦𞤭#,
		},
		'Pacific/Rarotonga' => {
			exemplarCity => q#𞤈𞤢𞤪𞤮𞤼𞤮𞤲𞤺𞤢#,
		},
		'Pacific/Saipan' => {
			exemplarCity => q#𞤅𞤢𞤴𞤨𞤢𞥄𞤲#,
		},
		'Pacific/Tahiti' => {
			exemplarCity => q#𞤚𞤢𞤸𞤭𞤼𞤭𞥅#,
		},
		'Pacific/Tarawa' => {
			exemplarCity => q#𞤚𞤫𞥅𞤪𞤢𞤱𞤢#,
		},
		'Pacific/Tongatapu' => {
			exemplarCity => q#𞤚𞤮𞤲𞤺𞤢𞤼𞤢𞥄𞤨𞤵#,
		},
		'Pacific/Truk' => {
			exemplarCity => q#𞤕𞤵𞥅𞤳𞤵#,
		},
		'Pacific/Wake' => {
			exemplarCity => q#𞤏𞤫𞥅𞤳𞤵#,
		},
		'Pacific/Wallis' => {
			exemplarCity => q#𞤏𞤢𞤤𞥆𞤭𞥅𞤧#,
		},
		'Pakistan' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤆𞤢𞤳𞤭𞤧𞤼𞤢𞥄𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤆𞤢𞤳𞤭𞤧𞤼𞤢𞥄𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤆𞤢𞤳𞤭𞤧𞤼𞤢𞥄𞤲#,
			},
		},
		'Palau' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤆𞤮𞤤𞤢𞥄𞤱𞤮#,
			},
		},
		'Papua_New_Guinea' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤆𞤢𞤨𞤵𞤱𞤢 𞤘𞤭𞤲𞤫 𞤖𞤫𞤧𞤮#,
			},
		},
		'Paraguay' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤆𞤢𞥄𞤪𞤢𞤺𞤮𞤴#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤆𞤢𞥄𞤪𞤢𞤺𞤮𞤴#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤆𞤢𞥄𞤪𞤢𞤺𞤮𞤴#,
			},
		},
		'Peru' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤕𞤫𞥅𞤯𞤵 𞤆𞤫𞤪𞤵𞥅#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤆𞤫𞤪𞤵𞥅#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤆𞤫𞤪𞤵𞥅#,
			},
		},
		'Philippines' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤊𞤭𞤤𞤭𞤨𞤭𞥅𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤊𞤭𞤤𞤭𞤨𞤭𞥅𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤊𞤭𞤤𞤭𞤨𞤭𞥅𞤲#,
			},
		},
		'Phoenix_Islands' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤊𞤫𞤲𞤭𞤳𞤧𞤭#,
			},
		},
		'Pierre_Miquelon' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤅𞤼. 𞤆𞤭𞤴𞤫𞥅𞤪 & 𞤃𞤭𞤳𞤫𞤤𞤮𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤼. 𞤆𞤭𞤪𞤫𞥅𞤴 & 𞤃𞤭𞤳𞤫𞤤𞤮𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤅𞤼. 𞤆𞤭𞤴𞤫𞥅𞤪 & 𞤃𞤭𞤳𞤫𞤤𞤮𞤲#,
			},
		},
		'Pitcairn' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤆𞤭𞤼𞤳𞤭𞥅𞤪𞤲𞤵#,
			},
		},
		'Ponape' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤆𞤮𞤲𞤢𞥄𞤨𞤫#,
			},
		},
		'Pyongyang' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤆𞤭𞤴𞤮𞤲𞤴𞤢𞤲#,
			},
		},
		'Reunion' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤈𞤫𞤲𞤭𞤴𞤮𞤲#,
			},
		},
		'Rothera' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤈𞤮𞤼𞤫𞤪𞤢#,
			},
		},
		'Sakhalin' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤅𞤢𞤿𞤢𞤤𞤭𞥅𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤢𞤿𞤢𞤤𞤭𞥅𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤅𞤢𞤿𞤢𞤤𞤭𞥅𞤲#,
			},
		},
		'Samoa' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤅𞤢𞤥𞤵𞤱𞤢#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤢𞤥𞤵𞤱𞤢#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤅𞤢𞤥𞤵𞤱𞤢#,
			},
		},
		'Seychelles' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤫𞤴𞤭𞤧𞤫𞤤#,
			},
		},
		'Singapore' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤅𞤭𞤲𞤺𞤢𞤨𞤵𞥅𞤪#,
			},
		},
		'Solomon' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤵𞤪𞤭𞥅𞤶𞤫 𞤅𞤵𞤤𞤢𞤴𞤥𞤢𞥄𞤲#,
			},
		},
		'South_Georgia' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤢𞤱𞤬-𞤔𞤮𞤪𞤶𞤭𞤴𞤢𞥄#,
			},
		},
		'Suriname' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤭𞤪𞤭𞤲𞤢𞤥#,
			},
		},
		'Syowa' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤢𞥄𞤴𞤵𞤱𞤢#,
			},
		},
		'Tahiti' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤢𞤸𞤭𞤼𞤭𞥅#,
			},
		},
		'Taipei' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤚𞤢𞤴𞤨𞤫𞥅#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤢𞤴𞤨𞤫𞥅#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤚𞤢𞤴𞤨𞤫𞥅#,
			},
		},
		'Tajikistan' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤢𞤶𞤭𞤳𞤭𞤧𞤼𞤢𞥄𞤲#,
			},
		},
		'Tokelau' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤮𞥅𞤳𞤮𞤤𞤢𞥄𞤱𞤵#,
			},
		},
		'Tonga' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤚𞤮𞤲𞤺𞤢#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤮𞤲𞤺𞤢#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤮𞤲𞤺𞤢 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫#,
			},
		},
		'Truk' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤵𞥅𞤳𞤵#,
			},
		},
		'Turkmenistan' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤚𞤵𞤪𞤳𞤵𞤥𞤫𞤲𞤭𞤧𞤼𞤢𞥄𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤵𞤪𞤳𞤵𞤥𞤫𞤲𞤭𞤧𞤼𞤢𞥄𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤚𞤵𞤪𞤳𞤵𞤥𞤫𞤲𞤭𞤧𞤼𞤢𞥄𞤲#,
			},
		},
		'Tuvalu' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤚𞤵𞥅𞤾𞤢𞤤𞤵#,
			},
		},
		'Uruguay' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤒𞤵𞥅𞤪𞤺𞤮𞤴#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤒𞤵𞥅𞤪𞤺𞤮𞤴#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤭𞤼𞤵𞤲𞥋𞤣𞤫 𞤒𞤵𞥅𞤪𞤺𞤮𞤴#,
			},
		},
		'Uzbekistan' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤓𞥁𞤦𞤫𞤳𞤭𞤧𞤼𞤢𞥄𞤲#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤓𞥁𞤦𞤫𞤳𞤭𞤧𞤼𞤢𞥄𞤲#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤓𞥁𞤦𞤫𞤳𞤭𞤧𞤼𞤢𞥄𞤲#,
			},
		},
		'Vanuatu' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤜𞤢𞤲𞤵𞤱𞤢𞥄𞤼𞤵#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤜𞤢𞤲𞤵𞤱𞤢𞥄𞤼𞤵#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤜𞤢𞤲𞤵𞤱𞤢𞥄𞤼𞤵#,
			},
		},
		'Venezuela' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤜𞤫𞤲𞤭𞥅𞥁𞤮𞥅𞤤𞤢#,
			},
		},
		'Vladivostok' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤜𞤭𞤤𞤢𞤾𞤮𞤧𞤼𞤮𞤳#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤜𞤭𞤤𞤢𞤾𞤮𞤧𞤼𞤮𞤳#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤜𞤭𞤤𞤢𞤾𞤮𞤧𞤼𞤮𞤳#,
			},
		},
		'Volgograd' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤜𞤮𞤤𞤺𞤮𞤺𞤢𞤪𞤢𞥄𞤣#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤜𞤮𞤤𞤺𞤮𞤺𞤢𞤪𞤢𞥄𞤣#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤜𞤮𞤤𞤺𞤮𞤺𞤢𞤪𞤢𞥄𞤣#,
			},
		},
		'Vostok' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤜𞤮𞤧𞤼𞤮𞤳#,
			},
		},
		'Wake' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤅𞤵𞤪𞤭𞥅𞤪𞤫 𞤏𞤫𞥅𞤳𞤵#,
			},
		},
		'Wallis' => {
			long => {
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤏𞤢𞤤𞥆𞤭𞥅𞤧 & 𞤊𞤵𞤼𞤵𞤲𞤢#,
			},
		},
		'Yakutsk' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤒𞤢𞤳𞤢𞤼𞤭𞤧𞤳𞤵#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤒𞤢𞤳𞤢𞤼𞤭𞤧𞤳𞤵#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤒𞤢𞤳𞤢𞤼𞤭𞤧𞤳𞤵#,
			},
		},
		'Yekaterinburg' => {
			long => {
				'daylight' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤕𞤫𞥅𞤯𞤵 𞤒𞤫𞤳𞤢𞤼𞤫𞤪𞤭𞤲𞤦𞤵𞤪𞤺𞤵#,
				'generic' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤒𞤫𞤳𞤢𞤼𞤫𞤪𞤭𞤲𞤦𞤵𞤪𞤺𞤵#,
				'standard' => q#𞤑𞤭𞤶𞤮𞥅𞤪𞤫 𞤖𞤢𞤱𞤪𞤵𞤲𞥋𞤣𞤫 𞤒𞤫𞤳𞤢𞤼𞤫𞤪𞤭𞤲𞤦𞤵𞤪𞤺𞤵#,
			},
		},
	 } }
);
no Moo;

1;

# vim: tabstop=4

=encoding utf8

=head1 NAME

Locale::CLDR::Locales::En::Dsrt - Package for language English

=cut

package Locale::CLDR::Locales::En::Dsrt;
# This file auto generated from Data\common\main\en_Dsrt.xml
#	on Sun 25 Feb 10:41:40 am GMT

use strict;
use warnings;
use version;

our $VERSION = version->declare('v0.44.0');

use v5.10.1;
use mro 'c3';
use utf8;
use if $^V ge v5.12.0, feature => 'unicode_strings';
use Types::Standard qw( Str Int HashRef ArrayRef CodeRef RegexpRef );
use Moo;

extends('Locale::CLDR::Locales::Root');
has 'display_name_language' => (
	is			=> 'ro',
	isa			=> CodeRef,
	init_arg	=> undef,
	default		=> sub {
		 sub {
			 my %languages = (
				'an' => '𐐈𐑉𐐲𐑀𐐱𐑌𐐨𐑆',
 				'ar' => '𐐇𐑉𐐲𐐺𐐮𐐿',
 				'br' => '𐐒𐑉𐐯𐐻𐐲𐑌',
 				'byn' => '𐐒𐑊𐐮𐑌',
 				'ca' => '𐐗𐐪𐐻𐐲𐑊𐐪𐑌',
 				'chr' => '𐐕𐐯𐑉𐐬𐐿𐐨',
 				'chy' => '𐐟𐐴𐐰𐑌',
 				'co' => '𐐗𐐬𐑉𐑅𐐮𐐿𐐲𐑌',
 				'cop' => '𐐗𐐬𐐹𐐻𐐮𐐿',
 				'cr' => '𐐗𐑉𐐨',
 				'cs' => '𐐕𐐯𐐿',
 				'cy' => '𐐎𐐯𐑊𐑇',
 				'da' => '𐐔𐐩𐑌𐐮𐑇',
 				'dak' => '𐐔𐐲𐐿𐐬𐐻𐐲',
 				'de' => '𐐖𐐲𐑉𐑋𐑌𐐲',
 				'dsb' => '𐐢𐐬𐐲𐑉 𐐝𐐬𐑉𐐺𐐨𐐲𐑌',
 				'dum' => '𐐣𐐮𐐼𐐲𐑊 𐐔𐐲𐐽',
 				'egy' => '𐐁𐑌𐐽𐐲𐑌𐐻 𐐀𐐾𐐮𐐹𐐽𐐲𐑌',
 				'el' => '𐐘𐑉𐐨𐐿',
 				'en' => '𐐀𐑍𐑊𐐮𐑇',
 				'enm' => '𐐣𐐮𐐼𐐲𐑊 𐐀𐑍𐑊𐐮𐑇',
 				'eo' => '𐐇𐑅𐐹𐐯𐑉𐐪𐑌𐐻𐐬',
 				'es' => '𐐝𐐹𐐰𐑌𐐮𐑇',
 				'et' => '𐐀𐑅𐐻𐐬𐑌𐐨𐐲𐑌',
 				'eu' => '𐐒𐐰𐑅𐐿',
 				'fr' => '𐐙𐑉𐐯𐑌𐐽',
 				'frm' => '𐐣𐐮𐐼𐐲𐑊 𐐙𐑉𐐯𐑌𐐽',
 				'ga' => '𐐌𐑉𐐮𐑇',
 				'gil' => '𐐘𐐮𐑊𐐺𐐯𐑉𐐻𐐨𐑆',
 				'gmh' => '𐐣𐐮𐐼𐐲𐑊 𐐐𐐴 𐐖𐐲𐑉𐑋𐐲𐑌',
 				'got' => '𐐘𐐱𐑃𐐮𐐿',
 				'grc' => '𐐁𐑌𐐽𐐲𐑌𐐻 𐐘𐑉𐐨𐐿',
 				'gv' => '𐐣𐐰𐑌𐐿𐑅',
 				'haw' => '𐐐𐐲𐐶𐐴𐐲𐑌',
 				'hi' => '𐐐𐐮𐑌𐐼𐐨',
 				'hit' => '𐐐𐐮𐐻𐐴𐐻',
 				'hr' => '𐐗𐑉𐐬𐐩𐑇𐐲𐑌',
 				'ht' => '𐐐𐐩𐑇𐐲𐑌',
 				'hy' => '𐐂𐑉𐑋𐐨𐑌𐐨𐐲𐑌',
 				'ia' => '𐐆𐑌𐐻𐐲𐑉𐑊𐐮𐑍𐐶𐐲',
 				'id' => '𐐆𐑌𐐼𐐬𐑌𐐨𐑈𐐲𐑌',
 				'is' => '𐐌𐑅𐑊𐐰𐑌𐐼𐐮𐐿',
 				'it' => '𐐆𐐻𐐰𐑊𐐷𐐲𐑌',
 				'ja' => '𐐖𐐰𐐹𐐲𐑌𐐨𐑆',
 				'jpr' => '𐐖𐐭𐐼𐐨𐐬-𐐑𐐯𐑉𐑈𐐲𐑌',
 				'jrb' => '𐐖𐐭𐐼𐐨𐐬-𐐈𐑉𐐲𐐺𐐮𐐿',
 				'jv' => '𐐖𐐪𐑂𐐲𐑌𐐨𐑆',
 				'ka' => '𐐖𐐬𐑉𐐾𐐲𐑌',
 				'km' => '𐐗𐐲𐑋𐐯𐑉',
 				'ko' => '𐐗𐐬𐑉𐐨𐐲𐑌',
 				'ku' => '𐐗𐐲𐑉𐐼𐐮𐑇',
 				'kut' => '𐐢𐐰𐐼𐐨𐑌𐐬',
 				'kw' => '𐐗𐐬𐑉𐑌𐐮𐑇',
 				'la' => '𐐢𐐰𐐻𐐮𐑌',
 				'lb' => '𐐢𐐲𐐿𐑅𐐯𐑋𐐺𐐲𐑉𐑀𐐮𐑇',
 				'lo' => '𐐢𐐵',
 				'lv' => '𐐢𐐰𐐻𐑂𐐨𐐲𐑌',
 				'mga' => '𐐣𐐮𐐼𐐲𐑊 𐐌𐑉𐐮𐑇',
 				'mi' => '𐐣𐐵𐑉𐐨',
 				'mk' => '𐐣𐐰𐑅𐐯𐐼𐐬𐑌𐐨𐐲𐑌',
 				'mn' => '𐐣𐐱𐑍𐐬𐑊𐐨𐐲𐑌',
 				'mnc' => '𐐣𐐰𐑌𐐽𐐭',
 				'moh' => '𐐐𐐬𐐸𐐪𐐿',
 				'mul' => '𐐣𐐲𐑊𐐻𐐮𐐹𐐲𐑊 𐐢𐐩𐑍𐐶𐐮𐐾𐐲𐑆',
 				'mus' => '𐐗𐑉𐐨𐐿',
 				'my' => '𐐒𐐲𐑉𐑋𐐨𐑆',
 				'nap' => '𐐤𐐨𐐲𐐹𐐱𐑊𐐮𐐻𐐲𐑌',
 				'nds' => '𐐢𐐬 𐐖𐐯𐑉𐑋𐐲𐑌',
 				'nl' => '𐐔𐐲𐐽',
 				'nv' => '𐐤𐐪𐑂𐐲𐐸𐐬',
 				'ro_MD' => '𐐣𐐬𐑊𐐼𐐩𐑂𐐨𐐲𐑌',
 				'tlh' => '𐐗𐑊𐐮𐑍𐐱𐑌',
 				'zbl' => '𐐒𐑊𐐮𐑅-𐑅𐐮𐑋𐐺𐐲𐑊𐑆',
 				'zh' => '𐐕𐐴𐑌𐐨𐑆',
 				'zxx' => '𐐤𐐬 𐑊𐐨𐑍𐐶𐐮𐑅𐐻𐐮𐐿 𐐿𐐱𐑌𐐻𐐯𐑌𐐻',

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
			'Arab' => '𐐇𐑉𐐲𐐺𐐮𐐿',
 			'Armi' => '𐐆𐑋𐐹𐐮𐑉𐐨𐐲𐑊 𐐁𐑉𐐲𐑋𐐩𐐮𐐿',
 			'Armn' => '𐐂𐑉𐑋𐐨𐑌𐐨𐐲𐑌',
 			'Avst' => '𐐊𐑂𐐯𐑅𐐻𐐲𐑌',
 			'Bali' => '𐐒𐐪𐑊𐐲𐑌𐐨𐑆',
 			'Batk' => '𐐒𐐲𐐻𐐪𐐿',
 			'Beng' => '𐐒𐐯𐑌𐑀𐐪𐑊𐐨',
 			'Blis' => '𐐒𐑊𐐮𐑅𐐮𐑋𐐺𐐲𐑊𐑆',
 			'Bopo' => '𐐒𐐱𐐹𐐱𐑋𐐱𐑁𐐱',
 			'Brah' => '𐐒𐑉𐐪𐑋𐐨',
 			'Brai' => '𐐒𐑉𐐩𐑊',
 			'Bugi' => '𐐒𐐭𐑀𐐮𐑌𐐨𐑆',
 			'Buhd' => '𐐒𐐭𐐸𐐮𐐼',
 			'Cakm' => '𐐕𐐪𐐿𐑋𐐲',
 			'Cans' => '𐐏𐐭𐑌𐐮𐑁𐐴𐐼 𐐗𐐲𐑌𐐩𐐼𐐨𐐲𐑌 𐐈𐐺𐐬𐑉𐐮𐐾𐐲𐑊𐐲𐑊 𐐝𐐮𐑊𐐰𐐺𐐮𐐿𐑅',
 			'Cari' => '𐐗𐐱𐑉𐐨𐐲𐑌',
 			'Cham' => '𐐗𐐰𐑋',
 			'Cher' => '𐐕𐐯𐑉𐐬𐐿𐐨',
 			'Cirt' => '𐐗𐐲𐑉𐑃',
 			'Copt' => '𐐗𐐱𐐹𐐻𐐮𐐿',
 			'Cprt' => '𐐝𐐮𐐹𐑉𐐨𐐲𐐻',
 			'Cyrl' => '𐐝𐐲𐑉𐐮𐑊𐐮𐐿',
 			'Cyrs' => '𐐄𐑊𐐼 𐐕𐐲𐑉𐐽 𐐝𐑊𐐲𐑂𐐱𐑌𐐮𐐿 𐐗𐐲𐑉𐐮𐑊𐐮𐐿',
 			'Deva' => '𐐔𐐩𐑂𐐲𐑌𐐪𐑀𐐲𐑉𐐨',
 			'Dsrt' => '𐐔𐐯𐑆𐐲𐑉𐐯𐐻',
 			'Egyd' => '𐐀𐐾𐐮𐐹𐐽𐐲𐑌 𐐼𐐲𐑋𐐱𐐻𐐮𐐿',
 			'Egyh' => '𐐀𐐾𐐮𐐹𐐽𐐲𐑌 𐐸𐐴𐑉𐐰𐐻𐐮𐐿',
 			'Egyp' => '𐐀𐐾𐐮𐐹𐐽𐐲𐑌 𐐸𐐴𐑉𐐬𐑀𐑊𐐮𐑁𐐮𐐿𐑅',
 			'Ethi' => '𐐀𐑃𐐨𐐪𐐹𐐮𐐿',
 			'Geok' => '𐐖𐐱𐑉𐐾𐐲𐑌 𐐗𐐳𐐻𐑅𐐭𐑉𐐨',
 			'Geor' => '𐐖𐐬𐑉𐐾𐐲𐑌',
 			'Glag' => '𐐘𐑊𐐰𐑀𐐬𐑊𐐮𐐻𐐮𐐿',
 			'Goth' => '𐐘𐐱𐑃𐐮𐐿',
 			'Grek' => '𐐘𐑉𐐨𐐿',
 			'Gujr' => '𐐘𐐳𐐾𐐲𐑉𐐪𐐼𐐨',
 			'Guru' => '𐐘𐐳𐑉𐑋𐐲𐐿𐐨',
 			'Hang' => '𐐐𐐪𐑌𐑀𐐲𐑊',
 			'Hani' => '𐐐𐐪𐑌',
 			'Hano' => '𐐐𐐲𐑌𐐭𐐲𐑌𐐭',
 			'Hans' => '𐐝𐐮𐑋𐐹𐑊𐐮𐑁𐐴𐐼 𐐐𐐪𐑌',
 			'Hant' => '𐐓𐑉𐐲𐐼𐐮𐑇𐐲𐑌𐐲𐑊 𐐐𐐪𐑌',
 			'Hebr' => '𐐐𐐨𐐺𐑉𐐭',
 			'Hira' => '𐐐𐐮𐑉𐐲𐑀𐐪𐑌𐐲',
 			'Hrkt' => '𐐗𐐪𐐻𐐲𐐿𐐪𐑌𐐲 𐐬𐑉 𐐐𐐮𐑉𐐲𐑀𐐪𐑌𐐲',
 			'Hung' => '𐐄𐑊𐐼 𐐐𐐲𐑍𐐩𐑉𐐨𐐲𐑌',
 			'Inds' => '𐐆𐑌𐐼𐐲𐑅',
 			'Ital' => '𐐄𐑊𐐼 𐐆𐐻𐐰𐑊𐐮𐐿',
 			'Java' => '𐐖𐐪𐑂𐐲𐑌𐐨𐑆',
 			'Jpan' => '𐐖𐐪𐐹𐐲𐑌𐐨𐑆',
 			'Kali' => '𐐗𐐪𐐷𐐪 𐐢𐐨',
 			'Kana' => '𐐗𐐪𐐻𐐲𐐿𐐪𐑌𐐲',
 			'Khar' => '𐐗𐐲𐑉𐐬𐑇𐑃𐐨',
 			'Khmr' => '𐐗𐐲𐑋𐐯𐑉',
 			'Knda' => '𐐗𐐪𐑌𐐲𐐼𐐲',
 			'Kore' => '𐐗𐐬𐑉𐐨𐐲𐑌',
 			'Kthi' => '𐐗𐐴𐐮𐐻𐐨',
 			'Lana' => '𐐢𐐪𐑌𐐲',
 			'Laoo' => '𐐢𐐵',
 			'Latf' => '𐐙𐑉𐐰𐐿𐐻𐐲𐑉 𐐢𐐰𐐻𐐮𐑌',
 			'Latg' => '𐐘𐐩𐑊𐐮𐐿 𐐢𐐰𐐻𐐮𐑌',
 			'Latn' => '𐐢𐐰𐐻𐐮𐑌',
 			'Lepc' => '𐐢𐐯𐐹𐐽𐐲',
 			'Limb' => '𐐢𐐮𐑋𐐺𐐭',
 			'Lina' => '𐐢𐐮𐑌𐐨𐐲𐑉 𐐁',
 			'Linb' => '𐐢𐐮𐑌𐐨𐐲𐑉 𐐒',
 			'Lyci' => '𐐢𐐮𐑇𐐲𐑌',
 			'Lydi' => '𐐢𐐮𐐼𐐨𐐲𐑌',
 			'Mand' => '𐐣𐐰𐑌𐐼𐐨𐐲𐑌',
 			'Mani' => '𐐣𐐰𐑌𐐲𐐿𐐨𐐲𐑌',
 			'Maya' => '𐐣𐐴𐐲𐑌 𐐸𐐴𐑉𐐬𐑀𐑊𐐮𐑁𐐮𐐿',
 			'Mero' => '𐐣𐐯𐑉𐐬𐐮𐐻𐐮𐐿',
 			'Mlym' => '𐐣𐐲𐑊𐐩𐐲𐑊𐐪𐑋',
 			'Mong' => '𐐣𐐱𐑍𐐬𐑊𐐨𐐲𐑌',
 			'Moon' => '𐐣𐐭𐑌',
 			'Mtei' => '𐐣𐐩𐐻𐐩 𐐣𐐴𐐯𐐿',
 			'Mymr' => '𐐣𐐨𐐲𐑌𐑋𐐪𐑉',
 			'Nkoo' => '𐐤’𐐗𐐬',
 			'Ogam' => '𐐄𐐲𐑋',
 			'Olck' => '𐐄𐑊 𐐕𐐨𐐿𐐨',
 			'Orkh' => '𐐄𐑉𐐿𐐱𐑌',
 			'Orya' => '𐐉𐑉𐐨𐐲',
 			'Osma' => '𐐉𐑅𐑋𐐪𐑌𐐷𐐪',
 			'Perm' => '𐐄𐑊𐐼 𐐑𐐯𐑉𐑋𐐮𐐿',
 			'Phli' => '𐐆𐑌𐑅𐐿𐑉𐐮𐐹𐑇𐐲𐑌𐐲𐑊 𐐑𐐪𐑊𐐲𐑂𐐨',
 			'Phlp' => '𐐝𐐱𐑊𐐻𐐲𐑉 𐐑𐐪𐑊𐐲𐑂𐐨',
 			'Phlv' => '𐐒𐐳𐐿 𐐑𐐪𐑊𐐲𐑂𐐨',
 			'Phnx' => '𐐙𐐬𐑌𐐨𐑇𐐲𐑌',
 			'Plrd' => '𐐑𐐱𐑊𐐲𐑉𐐼 𐐙𐐬𐑌𐐯𐐻𐐮𐐿',
 			'Prti' => '𐐆𐑌𐑅𐐿𐑉𐐮𐐹𐑇𐐲𐑌𐐲𐑊 𐐑𐐱𐑉𐑃𐐨𐐲𐑌',
 			'Rjng' => '𐐡𐐲𐐾𐐰𐑍',
 			'Roro' => '𐐡𐐪𐑍𐑀𐐬𐑉𐐪𐑌𐑀𐐬',
 			'Runr' => '𐐡𐐭𐑌𐐮𐐿',
 			'Samr' => '𐐝𐐲𐑋𐐯𐑉𐐲𐐻𐐲𐑌',
 			'Sara' => '𐐝𐐪𐑉𐐪𐐮𐐻𐐨',
 			'Saur' => '𐐝𐐰𐐭𐑉𐐪𐑇𐐻𐑉𐐪',
 			'Sgnw' => '𐐝𐐴𐑌 𐐡𐐴𐐻𐐨𐑍',
 			'Shaw' => '𐐟𐐩𐑂𐐨𐐲𐑌',
 			'Sinh' => '𐐝𐐮𐑌𐐸𐐪𐑊𐐲',
 			'Sund' => '𐐝𐐲𐑌𐐼𐐲𐑌𐐨𐑆',
 			'Sylo' => '𐐝𐐴𐑊𐐱𐐻𐐨 𐐤𐐰𐑀𐑉𐐨',
 			'Syrc' => '𐐝𐐮𐑉𐐨𐐰𐐿',
 			'Syre' => '𐐇𐑅𐐻𐑉𐐪𐑍𐐾𐐯𐑊𐐬 𐐝𐐮𐑉𐐨𐐰𐐿',
 			'Syrj' => '𐐎𐐯𐑅𐐻𐐲𐑉𐑌 𐐝𐐮𐑉𐐨𐐰𐐿',
 			'Syrn' => '𐐀𐑅𐐻𐐲𐑉𐑌 𐐝𐐮𐑉𐐨𐐰𐐿',
 			'Tagb' => '𐐓𐐲𐑀𐐺𐐪𐑌𐐶𐐪',
 			'Tale' => '𐐓𐐴 𐐢𐐯',
 			'Talu' => '𐐤𐐭 𐐓𐐴 𐐢𐐭𐐯',
 			'Taml' => '𐐓𐐰𐑋𐐮𐑊',
 			'Tavt' => '𐐓𐐴 𐐚𐐨𐐯𐐻',
 			'Telu' => '𐐓𐐯𐑊𐐭𐑀𐐭',
 			'Teng' => '𐐓𐐯𐑍𐐶𐐪𐑉',
 			'Tfng' => '𐐓𐐮𐑁𐐮𐑌𐐪',
 			'Tglg' => '𐐓𐐲𐑀𐐪𐑊𐐲𐑀',
 			'Thaa' => '𐐓𐐪𐐱𐑌𐐲',
 			'Thai' => '𐐓𐐴',
 			'Tibt' => '𐐓𐐮𐐺𐐯𐐻𐐲𐑌',
 			'Ugar' => '𐐏𐐭𐑀𐐲𐑉𐐮𐐻𐐮𐐿',
 			'Vaii' => '𐐚𐐴',
 			'Visp' => '𐐚𐐱𐑆𐐱𐐺𐐲𐑊 𐐝𐐹𐐨𐐽',
 			'Xpeo' => '𐐄𐑊𐐼 𐐑𐐲𐑉𐑈𐐲𐑌',
 			'Xsux' => '𐐝𐐭𐑋𐐯𐑉𐐬-𐐊𐐿𐐩𐐼𐐨𐐲𐑌 𐐗𐐷𐐭𐑌𐐨𐐲𐑁𐐱𐑉𐑋',
 			'Yiii' => '𐐏𐐨',
 			'Zinh' => '𐐆𐑌𐐸𐐯𐑉𐐮𐐻𐐲𐐼',
 			'Zmth' => '𐐣𐐰𐑃𐐲𐑋𐐰𐐻𐐲𐐿𐐲𐑊 𐐤𐐬𐐻𐐩𐑇𐐲𐑌',
 			'Zsym' => '𐐣𐐰𐑃𐐯𐑋𐐰𐐻𐐮𐐿𐐲𐑊 𐑌𐐬𐐻𐐩𐑇𐐲𐑌',
 			'Zxxx' => '𐐊𐑌𐑉𐐮𐐻𐐲𐑌',
 			'Zyyy' => '𐐗𐐱𐑋𐐲𐑌',
 			'Zzzz' => '𐐊𐑌𐐬𐑌 𐐬𐑉 𐐆𐑌𐑂𐐰𐑊𐐮𐐼 𐐝𐐿𐑉𐐮𐐹𐐻',

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
			'001' => '𐐎𐐲𐑉𐑊𐐼',
 			'002' => '𐐈𐑁𐑉𐐲𐐿𐐲',
 			'003' => '𐐤𐐱𐑉𐑃 𐐊𐑋𐐯𐑉𐐲𐐿𐐲',
 			'005' => '𐐝𐐵𐑃 𐐊𐑋𐐯𐑉𐐲𐐿𐐲',
 			'009' => '𐐄𐑇𐐨𐐰𐑌𐐨𐐲',
 			'011' => '𐐎𐐯𐑅𐐻𐐲𐑉𐑌 𐐈𐑁𐑉𐐲𐐿𐐲',
 			'013' => '𐐝𐐯𐑌𐐻𐑉𐐲𐑊 𐐊𐑋𐐯𐑉𐐲𐐿𐐲',
 			'014' => '𐐀𐑅𐐻𐐲𐑉𐑌 𐐈𐑁𐑉𐐲𐐿𐐲',
 			'015' => '𐐤𐐱𐑉𐑄𐐲𐑉𐑌 𐐈𐑁𐑉𐐲𐐿𐐲',
 			'017' => '𐐣𐐮𐐼𐑊 𐐈𐑁𐑉𐐮𐐿𐐲',
 			'018' => '𐐝𐐲𐑄𐐲𐑉𐑌 𐐈𐑁𐑉𐐲𐐿𐐲',
 			'019' => '𐐊𐑋𐐯𐑉𐐲𐐿𐐲𐑆',
 			'021' => '𐐤𐐱𐑉𐑄𐐲𐑉𐑌 𐐊𐑋𐐯𐑉𐐲𐐿𐐲',
 			'029' => '𐐗𐐯𐑉𐐲𐐺𐐨𐐲𐑌',
 			'030' => '𐐀𐑅𐐻𐐲𐑉𐑌 𐐁𐑈𐐲',
 			'034' => '𐐝𐐲𐑄𐐲𐑉𐑌 𐐁𐑈𐐲',
 			'035' => '𐐝𐐵𐑃-𐐀𐑅𐐻𐐲𐑉𐑌 𐐁𐑈𐐲',
 			'039' => '𐐝𐐲𐑄𐐲𐑉𐑌 𐐏𐐲𐑉𐐲𐐹',
 			'053' => '𐐉𐑅𐐻𐑉𐐩𐑊𐐨𐐲 𐐰𐑌𐐼 𐐤𐐭 𐐞𐐨𐑊𐐲𐑌𐐼',
 			'054' => '𐐣𐐯𐑊𐐲𐑌𐐨𐑈𐐲',
 			'057' => '𐐣𐐴𐐿𐑉𐐲𐑌𐐨𐑈𐐲𐑌 𐐡𐐨𐐾𐐲𐑌',
 			'061' => '𐐑𐐪𐑊𐐲𐑌𐐨𐑈𐐲',
 			'142' => '𐐁𐑈𐐲',
 			'143' => '𐐝𐐯𐑌𐐻𐑉𐐲𐑊 𐐁𐑈𐐲',
 			'145' => '𐐎𐐯𐑅𐐻𐐲𐑉𐑌 𐐁𐑈𐐲',
 			'150' => '𐐏𐐲𐑉𐐲𐐹',
 			'151' => '𐐀𐑅𐐻𐐲𐑉𐑌 𐐏𐐲𐑉𐐲𐐹',
 			'154' => '𐐤𐐱𐑉𐑄𐐲𐑉𐑌 𐐏𐐲𐑉𐐲𐐹',
 			'155' => '𐐎𐐯𐑅𐐻𐐲𐑉𐑌 𐐏𐐲𐑉𐐲𐐹',
 			'419' => '𐐢𐐰𐐻𐑌 𐐊𐑋𐐯𐑉𐐲𐐿𐐲 𐐰𐑌𐐼 𐑄 𐐗𐐯𐑉𐐲𐐺𐐨𐐲𐑌',
 			'AD' => '𐐈𐑌𐐼𐐱𐑉𐐲',
 			'AE' => '𐐏𐐭𐑌𐐴𐐼𐐮𐐼 𐐇𐑉𐐲𐐺 𐐇𐑋𐐲𐑉𐐩𐐻𐑅',
 			'AF' => '𐐈𐑁𐑀𐐰𐑌𐐲𐑅𐐻𐐰𐑌',
 			'AG' => '𐐈𐑌𐐻𐐨𐑀𐐶𐐲 𐐰𐑌𐐼 𐐒𐐪𐑉𐐺𐐷𐐭𐐼𐐲',
 			'AI' => '𐐈𐑍𐑀𐐶𐐮𐑊𐐲',
 			'AL' => '𐐈𐑊𐐺𐐩𐑌𐐨𐐲',
 			'AM' => '𐐂𐑉𐑋𐐨𐑌𐐨𐐲',
 			'AO' => '𐐈𐑌𐑀𐐬𐑊𐐲',
 			'AQ' => '𐐈𐑌𐐻𐐪𐑉𐐿𐐻𐐮𐐿𐐲',
 			'AR' => '𐐂𐑉𐐾𐐲𐑌𐐻𐐨𐑌𐐲',
 			'AS' => '𐐊𐑋𐐯𐑉𐐲𐐿𐐲𐑌 𐐝𐐲𐑋𐐬𐐲',
 			'AT' => '𐐉𐑅𐐻𐑉𐐨𐐲',
 			'AU' => '𐐉𐑅𐐻𐑉𐐩𐑊𐐨𐐲',
 			'AW' => '𐐊𐑉𐐭𐐺𐐲',
 			'AX' => '𐐈𐑊𐐰𐑌𐐼 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'AZ' => '𐐈𐑆𐐲𐑉𐐺𐐴𐑈𐐪𐑌',
 			'BA' => '𐐒𐐱𐑆𐑌𐐨𐐲 𐐰𐑌𐐼 𐐐𐐲𐑉𐐻𐑅𐐲𐑀𐐬𐑂𐐨𐑌𐐲',
 			'BB' => '𐐒𐐪𐑉𐐺𐐩𐐼𐐬𐑅',
 			'BD' => '𐐒𐐪𐑍𐑀𐑊𐐲𐐼𐐯𐑇',
 			'BE' => '𐐒𐐯𐑊𐐾𐐲𐑋',
 			'BF' => '𐐒𐐲𐑉𐐿𐐩𐑌𐐲 𐐙𐐰𐑅𐐬',
 			'BG' => '𐐒𐐲𐑊𐑀𐐯𐑉𐐨𐐲',
 			'BH' => '𐐒𐐪𐑉𐐩𐑌',
 			'BI' => '𐐒𐐲𐑉𐐳𐑌𐐼𐐨',
 			'BJ' => '𐐒𐐲𐑌𐐨𐑌',
 			'BL' => '𐐝𐐩𐑌𐐻 𐐒𐐪𐑉𐐻𐐩𐑊𐐲𐑋𐐨',
 			'BM' => '𐐒𐐲𐑉𐑋𐐷𐐭𐐼𐐲',
 			'BN' => '𐐒𐑉𐐭𐑌𐐴',
 			'BO' => '𐐒𐐬𐑊𐐮𐑂𐐨𐐲',
 			'BR' => '𐐒𐑉𐐲𐑆𐐮𐑊',
 			'BS' => '𐐒𐐲𐐸𐐪𐑋𐐲𐑅',
 			'BT' => '𐐒𐐭𐐻𐐪𐑌',
 			'BV' => '𐐒𐐭𐑂𐐩 𐐌𐑊𐐲𐑌𐐼',
 			'BW' => '𐐒𐐪𐐻𐑅𐐶𐐪𐑌𐐲',
 			'BY' => '𐐒𐐯𐑊𐐲𐑉𐐭𐑅',
 			'BZ' => '𐐒𐐲𐑊𐐨𐑆',
 			'CA' => '𐐗𐐰𐑌𐐲𐐼𐐲',
 			'CC' => '𐐗𐐬𐐿𐐬𐑆 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'CD' => '𐐗𐐪𐑍𐑀𐐬 - 𐐗𐐲𐑌𐑇𐐪𐑅𐐲',
 			'CF' => '𐐝𐐯𐑌𐐻𐑉𐐲𐑊 𐐈𐑁𐑉𐐲𐐿𐐲𐑌 𐐡𐐨𐐹𐐲𐐺𐑊𐐮𐐿',
 			'CG' => '𐐗𐐪𐑍𐑀𐐬 - 𐐒𐑉𐐪𐑆𐐲𐑂𐐮𐑊',
 			'CH' => '𐐝𐐶𐐮𐐻𐑅𐐲𐑉𐑊𐐲𐑌𐐼',
 			'CI' => '𐐌𐑂𐑉𐐨 𐐗𐐬𐑅𐐻',
 			'CK' => '𐐗𐐳𐐿 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'CL' => '𐐕𐐨𐑊𐐩',
 			'CM' => '𐐗𐐰𐑋𐐲𐑉𐐭𐑌',
 			'CN' => '𐐕𐐴𐑌𐐲',
 			'CO' => '𐐗𐐲𐑊𐐲𐑋𐐺𐐨𐐲',
 			'CR' => '𐐗𐐱𐑅𐐻𐐲 𐐡𐐨𐐿𐐲',
 			'CU' => '𐐗𐐷𐐭𐐺𐐲',
 			'CV' => '𐐗𐐩𐐹 𐐚𐐯𐑉𐐼𐐨',
 			'CX' => '𐐗𐑉𐐮𐑅𐑋𐐲𐑅 𐐌𐑊𐐲𐑌𐐼',
 			'CY' => '𐐝𐐴𐐹𐑉𐐲𐑅',
 			'CZ' => '𐐕𐐯𐐿 𐐡𐐨𐐹𐐲𐐺𐑊𐐮𐐿',
 			'DE' => '𐐖𐐲𐑉𐑋𐐲𐑌𐐨',
 			'DJ' => '𐐖𐐲𐐺𐐭𐐼𐐨',
 			'DK' => '𐐔𐐯𐑌𐑋𐐪𐑉𐐿',
 			'DM' => '𐐔𐐪𐑋𐐲𐑌𐐨𐐿𐐲',
 			'DO' => '𐐔𐐲𐑋𐐮𐑌𐐲𐐿𐐲𐑌 𐐡𐐨𐐹𐐲𐐺𐑊𐐮𐐿',
 			'DZ' => '𐐈𐑊𐐾𐐮𐑉𐐨𐐲',
 			'EC' => '𐐇𐐿𐐶𐐲𐐼𐐱𐑉',
 			'EE' => '𐐇𐑅𐐻𐐬𐑌𐐨𐐲',
 			'EG' => '𐐀𐐾𐐲𐐹𐐻',
 			'EH' => '𐐎𐐯𐑅𐐻𐐲𐑉𐑌 𐐝𐐲𐐸𐐱𐑉𐐲',
 			'ER' => '𐐇𐑉𐐮𐐻𐑉𐐨𐐲',
 			'ES' => '𐐝𐐹𐐩𐑌',
 			'ET' => '𐐀𐑃𐐨𐐬𐐹𐐨𐐲',
 			'EU' => '𐐏𐐲𐑉𐐲𐐹𐐨𐐲𐑌 𐐏𐐭𐑌𐐷𐐲𐑌',
 			'FI' => '𐐙𐐮𐑌𐑊𐐲𐑌𐐼',
 			'FJ' => '𐐙𐐨𐐾𐐨',
 			'FK' => '𐐙𐐪𐑊𐐿𐑊𐐲𐑌𐐼 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'FM' => '𐐣𐐴𐐿𐑉𐐲𐑌𐐨𐑈𐐲',
 			'FO' => '𐐙𐐯𐑉𐐬 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'FR' => '𐐙𐑉𐐰𐑌𐑅',
 			'GA' => '𐐘𐐲𐐺𐐪𐑌',
 			'GB' => '𐐏𐐭𐑌𐐴𐐻𐐲𐐼 𐐗𐐨𐑍𐐼𐐲𐑋',
 			'GD' => '𐐘𐑉𐐲𐑌𐐩𐐼𐐲',
 			'GE' => '𐐖𐐱𐑉𐐾𐐲',
 			'GF' => '𐐙𐑉𐐯𐑌𐐽 𐐘𐐨𐐪𐑌𐐲',
 			'GG' => '𐐘𐐲𐑉𐑌𐑆𐐨',
 			'GH' => '𐐘𐐪𐑌𐐲',
 			'GI' => '𐐖𐐲𐐺𐑉𐐱𐑊𐐻𐐲𐑉',
 			'GL' => '𐐘𐑉𐐨𐑌𐑊𐐲𐑌𐐼',
 			'GM' => '𐐘𐐰𐑋𐐺𐐨𐐲',
 			'GN' => '𐐘𐐮𐑌𐐨',
 			'GP' => '𐐘𐐶𐐪𐐼𐐲𐑊𐐭𐐹',
 			'GQ' => '𐐇𐐿𐐶𐐲𐐻𐐱𐑉𐐨𐐲𐑊 𐐘𐐮𐑌𐐨',
 			'GR' => '𐐘𐑉𐐨𐑅',
 			'GS' => '𐐝𐐵𐑃 𐐖𐐱𐑉𐐾𐐲 𐐰𐑌𐐼 𐑄 𐐝𐐵𐑃 𐐝𐐰𐑌𐐼𐐶𐐮𐐽 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'GT' => '𐐘𐐶𐐪𐐼𐐲𐑋𐐪𐑊𐐲',
 			'GU' => '𐐘𐐶𐐪𐑋',
 			'GW' => '𐐘𐐮𐑌𐐨-𐐒𐐮𐑅𐐵',
 			'GY' => '𐐘𐐴𐐰𐑌𐐲',
 			'HK' => '𐐐𐐬𐑍 𐐗𐐬𐑍 𐐝𐐈𐐡 𐐕𐐴𐑌𐐲',
 			'HK@alt=short' => '𐐐𐐬𐑍 𐐗𐐬𐑍',
 			'HM' => '𐐐𐐲𐑉𐐼 𐐌𐑊𐐲𐑌𐐼 𐐰𐑌𐐼 𐐣𐐿𐐔𐐱𐑌𐐲𐑊𐐼 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'HN' => '𐐐𐐪𐑌𐐼𐐭𐑉𐐲𐑅',
 			'HR' => '𐐗𐑉𐐬𐐩𐑇𐐲',
 			'HT' => '𐐐𐐩𐐻𐐨',
 			'HU' => '𐐐𐐲𐑍𐑀𐐲𐑉𐐨',
 			'ID' => '𐐆𐑌𐐼𐐲𐑌𐐨𐑈𐐲',
 			'IE' => '𐐌𐑉𐑊𐐲𐑌𐐼',
 			'IL' => '𐐆𐑆𐑉𐐨𐐲𐑊',
 			'IM' => '𐐌𐐲𐑊 𐐲𐑁 𐐣𐐰𐑌',
 			'IN' => '𐐆𐑌𐐼𐐨𐐲',
 			'IO' => '𐐒𐑉𐐮𐐼𐐮𐑇 𐐆𐑌𐐼𐐨𐐲𐑌 𐐄𐑇𐐲𐑌 𐐓𐐯𐑉𐐲𐐻𐐱𐑉𐐨',
 			'IQ' => '𐐆𐑉𐐰𐐿',
 			'IR' => '𐐆𐑉𐐪𐑌',
 			'IS' => '𐐌𐑅𐑊𐐲𐑌𐐼',
 			'IT' => '𐐆𐐻𐐲𐑊𐐨',
 			'JE' => '𐐖𐐲𐑉𐑆𐐨',
 			'JM' => '𐐖𐐲𐑋𐐩𐐿𐐲',
 			'JO' => '𐐖𐐱𐑉𐐼𐐲𐑌',
 			'JP' => '𐐖𐐲𐐹𐐰𐑌',
 			'KE' => '𐐗𐐯𐑌𐐷𐐲',
 			'KG' => '𐐗𐐮𐑉𐑀𐐲𐑅𐐻𐐰𐑌',
 			'KH' => '𐐗𐐰𐑋𐐺𐐬𐐼𐐨𐐲',
 			'KI' => '𐐗𐐮𐑉𐐲𐐺𐐪𐐻𐐨',
 			'KM' => '𐐗𐐪𐑋𐐲𐑉𐐬𐑆',
 			'KN' => '𐐝𐐩𐑌𐐻 𐐗𐐮𐐻𐑅 𐐰𐑌𐐼 𐐤𐐨𐑂𐐮𐑅',
 			'KP' => '𐐤𐐱𐑉𐑃 𐐗𐐲𐑉𐐨𐐲',
 			'KR' => '𐐝𐐵𐑃 𐐗𐐲𐑉𐐨𐐲',
 			'KW' => '𐐗𐐲𐐶𐐩𐐻',
 			'KY' => '𐐗𐐩𐑋𐐲𐑌 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'KZ' => '𐐗𐐲𐑆𐐪𐐿𐑅𐐻𐐪𐑌',
 			'LA' => '𐐢𐐪𐐬𐑅',
 			'LB' => '𐐢𐐯𐐺𐐲𐑌𐐪𐑌',
 			'LI' => '𐐢𐐮𐐿𐐻𐐲𐑌𐑅𐐻𐐴𐑌',
 			'LK' => '𐐟𐑉𐐨 𐐢𐐰𐑍𐐿𐐲',
 			'LR' => '𐐢𐐴𐐺𐐮𐑉𐐨𐐲',
 			'LS' => '𐐢𐐲𐑅𐐬𐑃𐐬',
 			'LT' => '𐐢𐐮𐑃𐐲𐐶𐐩𐑌𐐨𐐲',
 			'LU' => '𐐢𐐲𐐿𐑅𐐲𐑋𐐺𐐲𐑉𐑀',
 			'LV' => '𐐢𐐰𐐻𐑂𐐨𐐲',
 			'LY' => '𐐢𐐮𐐺𐐨𐐲',
 			'MA' => '𐐣𐐲𐑉𐐪𐐿𐐬',
 			'MC' => '𐐣𐐪𐑌𐐲𐐿𐐬',
 			'MD' => '𐐣𐐱𐑊𐐼𐐬𐑂𐐲',
 			'ME' => '𐐣𐐪𐑌𐐲𐑌𐐨𐑀𐑉𐐬',
 			'MF' => '𐐝𐐩𐑌𐐻 𐐣𐐪𐑉𐐻𐑌',
 			'MG' => '𐐣𐐰𐐼𐐲𐑀𐐰𐑅𐐿𐐲𐑉',
 			'MH' => '𐐣𐐪𐑉𐑇𐐲𐑊 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'MK' => '𐐣𐐰𐑅𐐲𐐼𐐬𐑌𐐨𐐲',
 			'ML' => '𐐣𐐪𐑊𐐨',
 			'MM' => '𐐣𐐨𐐲𐑌𐑋𐐪𐑉',
 			'MN' => '𐐣𐐪𐑍𐑀𐐬𐑊𐐨𐐲',
 			'MO' => '𐐣𐐲𐐿𐐵 𐐝𐐈𐐡 𐐕𐐴𐑌𐐲',
 			'MO@alt=short' => '𐐣𐐲𐐿𐐵',
 			'MP' => '𐐤𐐱𐑉𐑄𐐲𐑉𐑌 𐐣𐐰𐑉𐐨𐐱𐑌𐐲 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'MQ' => '𐐣𐐪𐑉𐐻𐑌𐐨𐐿',
 			'MR' => '𐐣𐐱𐑉𐐲𐐻𐐩𐑌𐐨𐐲',
 			'MS' => '𐐣𐐪𐑌𐐻𐑅𐐲𐑉𐐪𐐻',
 			'MT' => '𐐣𐐱𐑊𐐻𐐲',
 			'MU' => '𐐣𐐱𐑉𐐮𐑇𐐲𐑅',
 			'MV' => '𐐣𐐪𐑊𐐼𐐨𐑂𐑆',
 			'MW' => '𐐣𐐲𐑊𐐪𐐶𐐨',
 			'MX' => '𐐣𐐯𐐿𐑅𐐲𐐿𐐬',
 			'MY' => '𐐣𐐲𐑊𐐩𐑈𐐲',
 			'MZ' => '𐐣𐐬𐑆𐐰𐑋𐐺𐐨𐐿',
 			'NA' => '𐐤𐐲𐑋𐐮𐐺𐐨𐐲',
 			'NC' => '𐐤𐐭 𐐗𐐰𐑊𐐲𐐼𐐬𐑌𐐷𐐲',
 			'NE' => '𐐤𐐴𐐾𐐲𐑉',
 			'NF' => '𐐤𐐱𐑉𐑁𐐲𐐿 𐐌𐑊𐐲𐑌𐐼',
 			'NG' => '𐐤𐐴𐐾𐐮𐑉𐐨𐐲',
 			'NI' => '𐐤𐐮𐐿𐐲𐑉𐐪𐑀𐐶𐐲',
 			'NL' => '𐐤𐐯𐑄𐐲𐑉𐑊𐐲𐑌𐐼𐑆',
 			'NO' => '𐐤𐐱𐑉𐐶𐐩',
 			'NP' => '𐐤𐐩𐐹𐐪𐑊',
 			'NR' => '𐐤𐐪𐐭𐑉𐐭',
 			'NU' => '𐐤𐐷𐐭𐐩',
 			'NZ' => '𐐤𐐭 𐐞𐐨𐑊𐐲𐑌𐐼',
 			'OM' => '𐐄𐑋𐐲𐑌',
 			'PA' => '𐐑𐐰𐑌𐐲𐑋𐐪',
 			'PE' => '𐐑𐐲𐑉𐐭',
 			'PF' => '𐐙𐑉𐐯𐑌𐐽 𐐑𐐪𐑊𐐲𐑌𐐨𐑈𐐲',
 			'PG' => '𐐑𐐰𐐹𐐷𐐳𐐲 𐐤𐐭 𐐘𐐮𐑌𐐨',
 			'PH' => '𐐙𐐮𐑊𐐲𐐹𐐨𐑌𐑆',
 			'PK' => '𐐑𐐰𐐿𐐲𐑅𐐻𐐰𐑌',
 			'PL' => '𐐑𐐬𐑊𐐲𐑌𐐼',
 			'PM' => '𐐝𐐩𐑌𐐻 𐐑𐐨𐐯𐑉 𐐰𐑌𐐼 𐐣𐐨𐐿𐐲𐑊𐐪𐑌',
 			'PN' => '𐐑𐐮𐐻𐐿𐐯𐑉𐑌',
 			'PR' => '𐐑𐐶𐐯𐑉𐐻𐐬 𐐡𐐨𐐿𐐬',
 			'PS' => '𐐑𐐰𐑊𐐲𐑅𐐻𐐮𐑌𐐨𐐲𐑌 𐐓𐐯𐑉𐐲𐐻𐐱𐑉𐐨',
 			'PT' => '𐐑𐐱𐑉𐐽𐐲𐑀𐐲𐑊',
 			'PW' => '𐐑𐐲𐑊𐐵',
 			'PY' => '𐐑𐐯𐑉𐐲𐑀𐐶𐐴',
 			'QA' => '𐐗𐐲𐐻𐐪𐑉',
 			'QO' => '𐐍𐐻𐑊𐐴𐐮𐑍 𐐄𐑇𐐨𐐰𐑌𐐨𐐲',
 			'RE' => '𐐡𐐨𐐷𐐭𐑌𐐷𐐲𐑌',
 			'RO' => '𐐡𐐬𐑋𐐩𐑌𐐨𐐲',
 			'RS' => '𐐝𐐲𐑉𐐺𐐨𐐲',
 			'RU' => '𐐡𐐲𐑇𐐲',
 			'RW' => '𐐡𐐲𐐶𐐪𐑌𐐼𐐲',
 			'SA' => '𐐝𐐵𐐼𐐨 𐐊𐑉𐐩𐐺𐐨𐐲',
 			'SB' => '𐐝𐐪𐑊𐐲𐑋𐐲𐑌 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'SC' => '𐐝𐐩𐑇𐐯𐑊𐑆',
 			'SD' => '𐐝𐐭𐐼𐐰𐑌',
 			'SE' => '𐐝𐐶𐐨𐐼𐑌',
 			'SG' => '𐐝𐐮𐑍𐐲𐐹𐐱𐑉',
 			'SH' => '𐐝𐐩𐑌𐐻 𐐐𐐯𐑊𐐲𐑌𐐲',
 			'SI' => '𐐝𐑊𐐬𐑂𐐨𐑌𐐨𐐲',
 			'SJ' => '𐐝𐑂𐐪𐑊𐐺𐐪𐑉𐐼 𐐰𐑌𐐼 𐐖𐐰𐑌 𐐣𐐴𐐲𐑌',
 			'SK' => '𐐝𐑊𐐬𐑂𐐪𐐿𐐨𐐲',
 			'SL' => '𐐝𐐨𐐯𐑉𐐲 𐐢𐐨𐐬𐑌',
 			'SM' => '𐐝𐐪𐑌 𐐣𐐲𐑉𐐨𐑌𐐬',
 			'SN' => '𐐝𐐯𐑌𐐲𐑀𐐱𐑊',
 			'SO' => '𐐝𐐲𐑋𐐪𐑊𐐨𐐲',
 			'SR' => '𐐝𐐭𐑉𐐲𐑌𐐪𐑋',
 			'ST' => '𐐝𐐵 𐐓𐐬𐑋 𐐰𐑌𐐼 𐐑𐑉𐐮𐑌𐐽𐐮𐐹𐐩',
 			'SV' => '𐐇𐑊 𐐝𐐰𐑊𐑂𐐲𐐼𐐱𐑉',
 			'SY' => '𐐝𐐮𐑉𐐨𐐲',
 			'SZ' => '𐐝𐐶𐐪𐑆𐐨𐑊𐐰𐑌𐐼',
 			'TC' => '𐐓𐐲𐑉𐐿𐑅 𐐰𐑌𐐼 𐐗𐐴𐐿𐐬𐑆 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'TD' => '𐐕𐐰𐐼',
 			'TF' => '𐐙𐑉𐐯𐑌𐐽 𐐝𐐲𐑄𐐲𐑉𐑌 𐐓𐐯𐑉𐐲𐐻𐐱𐑉𐐨𐑆',
 			'TG' => '𐐓𐐬𐑀𐐬',
 			'TH' => '𐐓𐐴𐑊𐐰𐑌𐐼',
 			'TJ' => '𐐓𐐲𐐾𐐨𐐿𐐲𐑅𐐻𐐰𐑌',
 			'TK' => '𐐓𐐬𐐿𐐯𐑊𐐵',
 			'TL' => '𐐀𐑅𐐻 𐐓𐐨𐑋𐐱𐑉',
 			'TM' => '𐐓𐐲𐑉𐐿𐑋𐐯𐑌𐐲𐑅𐐻𐐰𐑌',
 			'TO' => '𐐓𐐪𐑍𐑀𐐲',
 			'TR' => '𐐓𐐲𐑉𐐿𐐨',
 			'TT' => '𐐓𐑉𐐮𐑌𐐮𐐼𐐰𐐼 𐐰𐑌𐐼 𐐓𐐲𐐺𐐩𐑀𐐬',
 			'TV' => '𐐓𐐲𐑂𐐪𐑊𐐭',
 			'TW' => '𐐓𐐴𐐶𐐪𐑌',
 			'TZ' => '𐐓𐐰𐑌𐑆𐐲𐑌𐐨𐐲',
 			'UG' => '𐐏𐐭𐑀𐐰𐑌𐐼𐐲',
 			'UM' => '𐐏𐐭𐑌𐐰𐐮𐐻𐐲𐐼 𐐝𐐻𐐩𐐻𐑅 𐐣𐐴𐑌𐐬𐑉 𐐍𐐻𐑊𐐴𐐨𐑍 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'US' => '𐐏𐐭𐑌𐐴𐐻𐐲𐐼 𐐝𐐻𐐩𐐻𐑅',
 			'UY' => '𐐏𐐳𐑉𐐲𐑀𐐶𐐴',
 			'UZ' => '𐐅𐑆𐐺𐐯𐐿𐐲𐑅𐐻𐐰𐑌',
 			'VA' => '𐐚𐐰𐐼𐐲𐐿𐐲𐑌',
 			'VC' => '𐐝𐐩𐑌𐐻 𐐚𐐮𐑌𐑅𐐲𐑌𐐻 𐐰𐑌𐐼 𐑄 𐐘𐑉𐐯𐑌𐐲𐐼𐐨𐑌𐑆',
 			'VG' => '𐐒𐑉𐐮𐐼𐐮𐑇 𐐚𐐲𐑉𐐾𐐲𐑌 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'VI' => '𐐏.𐐝. 𐐚𐐲𐑉𐐾𐐲𐑌 𐐌𐑊𐐲𐑌𐐼𐑆',
 			'VN' => '𐐚𐐨𐐯𐐻𐑌𐐪𐑋',
 			'VU' => '𐐚𐐪𐑌𐐳𐐪𐐼𐐭',
 			'WF' => '𐐎𐐪𐑊𐐮𐑅 𐐰𐑌𐐼 𐐙𐐭𐐻𐐭𐑌𐐲',
 			'WS' => '𐐝𐐲𐑋𐐬𐐲',
 			'YE' => '𐐏𐐯𐑋𐐲𐑌',
 			'YT' => '𐐣𐐪𐐷𐐱𐐻',
 			'ZA' => '𐐝𐐵𐑃 𐐈𐑁𐑉𐐲𐐿𐐲',
 			'ZM' => '𐐞𐐰𐑋𐐺𐐨𐐲',
 			'ZW' => '𐐞𐐮𐑋𐐺𐐪𐐺𐐶𐐩',
 			'ZZ' => '𐐊𐑌𐐬𐑌 𐐬𐑉 𐐆𐑌𐑂𐐰𐑊𐐮𐐼 𐐡𐐨𐐾𐐲𐑌',

		}
	},
);

has 'display_name_variant' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub {
		{
			'1901' => '𐐓𐑉𐐲𐐼𐐮𐑇𐐲𐑌𐑊 𐐖𐐲𐑉𐑋𐐲𐑌 𐐱𐑉𐑃𐐪𐑀𐑉𐐲𐑁𐐨',
 			'1996' => '𐐖𐐲𐑉𐑋𐐲𐑌 𐐱𐑉𐑃𐐪𐑀𐑉𐐲𐑁𐐨 𐐲𐑂 1996',
 			'1606NICT' => '𐐢𐐩𐐻 𐐣𐐮𐐼𐑊 𐐙𐑉𐐯𐑌𐐽 𐐻𐐭 1606',
 			'1694ACAD' => '𐐊𐑉𐑊𐐨 𐐣𐐪𐐼𐐲𐑉𐑌 𐐙𐑉𐐯𐑌𐐽',
 			'AREVELA' => '𐐀𐑅𐐻𐐲𐑉𐑌 𐐂𐑉𐑋𐐨𐑌𐐨𐐲𐑌',
 			'AREVMDA' => '𐐎𐐯𐑅𐐻𐐲𐑉𐑌 𐐂𐑉𐑋𐐨𐑌𐐨𐐲𐑌',
 			'BAKU1926' => '𐐏𐐭𐑌𐐲𐑁𐐴𐐼 𐐓𐐲𐑉𐐿𐐮𐐿 𐐢𐐰𐐻𐑌 𐐈𐑊𐑁𐐲𐐺𐐲𐐻',
 			'FONIPA' => '𐐆𐐙𐐈 𐐙𐐬𐑌𐐯𐐻𐐮𐐿𐑅',
 			'MONOTON' => '𐐣𐐪𐑌𐐲𐐻𐐪𐑌𐐮𐐿',
 			'POLYTON' => '𐐑𐐱𐑊𐐨𐐻𐐱𐑌𐐮𐐿',
 			'POSIX' => '𐐗𐐲𐑋𐐹𐐷𐐭𐐻𐐯𐑉',
 			'REVISED' => '𐐡𐐲𐑂𐐴𐑆𐐼 𐐉𐑉𐑃𐐪𐑀𐑉𐐲𐑁𐐨',
 			'SCOTLAND' => '𐐝𐐿𐐪𐐼𐐮𐑇 𐐝𐐻𐐰𐑌𐐼𐐲𐑉𐐼 𐐆𐑍𐑊𐐮𐑇',

		}
	},
);

has 'display_name_measurement_system' => (
	is			=> 'ro',
	isa			=> HashRef[Str],
	init_arg	=> undef,
	default		=> sub {
		{
			'metric' => q{𐑋𐐯𐐻𐑉𐐮𐐿},
 			'US' => q{𐐏𐐝},

		}
	},
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
			index => ['𐐀', '𐐁', '𐐂', '𐐃', '𐐄', '𐐅', '𐐆', '𐐇', '𐐈', '𐐉', '𐐊', '𐐋', '𐐌', '𐐍', '𐐎', '𐐏', '𐐐', '𐐑', '𐐒', '𐐓', '𐐔', '𐐕', '𐐖', '𐐗', '𐐘', '𐐙', '𐐚', '𐐛', '𐐜', '𐐝', '𐐞', '𐐟', '𐐠', '𐐡', '𐐢', '𐐣', '𐐤', '𐐥', '𐐦', '𐐧'],
			main => qr{[𐐨 𐐩 𐐪 𐐫 𐐬 𐐭 𐐮 𐐯 𐐰 𐐱 𐐲 𐐳 𐐴 𐐵 𐐶 𐐷 𐐸 𐐹 𐐺 𐐻 𐐼 𐐽 𐐾 𐐿 𐑀 𐑁 𐑂 𐑃 𐑄 𐑅 𐑆 𐑇 𐑈 𐑉 𐑊 𐑋 𐑌 𐑍 𐑎 𐑏]},
		};
	},
EOT
: sub {
		return { index => ['𐐀', '𐐁', '𐐂', '𐐃', '𐐄', '𐐅', '𐐆', '𐐇', '𐐈', '𐐉', '𐐊', '𐐋', '𐐌', '𐐍', '𐐎', '𐐏', '𐐐', '𐐑', '𐐒', '𐐓', '𐐔', '𐐕', '𐐖', '𐐗', '𐐘', '𐐙', '𐐚', '𐐛', '𐐜', '𐐝', '𐐞', '𐐟', '𐐠', '𐐡', '𐐢', '𐐣', '𐐤', '𐐥', '𐐦', '𐐧'], };
},
);


has 'units' => (
	is			=> 'ro',
	isa			=> HashRef[HashRef[HashRef[Str]]],
	init_arg	=> undef,
	default		=> sub { {
				'long' => {
					# Long Unit Identifier
					'duration-day' => {
						'one' => q({0} 𐐼𐐩),
						'other' => q({0} 𐐼𐐩𐑆),
					},
					# Core Unit Identifier
					'day' => {
						'one' => q({0} 𐐼𐐩),
						'other' => q({0} 𐐼𐐩𐑆),
					},
					# Long Unit Identifier
					'duration-hour' => {
						'one' => q({0} 𐐵𐑉),
						'other' => q({0} 𐐵𐑉𐑆),
					},
					# Core Unit Identifier
					'hour' => {
						'one' => q({0} 𐐵𐑉),
						'other' => q({0} 𐐵𐑉𐑆),
					},
					# Long Unit Identifier
					'duration-minute' => {
						'one' => q({0} 𐑋𐐮𐑌𐐲𐐻),
						'other' => q({0} 𐑋𐐮𐑌𐐲𐐻𐑅),
					},
					# Core Unit Identifier
					'minute' => {
						'one' => q({0} 𐑋𐐮𐑌𐐲𐐻),
						'other' => q({0} 𐑋𐐮𐑌𐐲𐐻𐑅),
					},
					# Long Unit Identifier
					'duration-month' => {
						'one' => q({0} 𐑋𐐲𐑌𐑃𐑅),
						'other' => q({0} 𐑋𐐲𐑌𐑃),
					},
					# Core Unit Identifier
					'month' => {
						'one' => q({0} 𐑋𐐲𐑌𐑃𐑅),
						'other' => q({0} 𐑋𐐲𐑌𐑃),
					},
					# Long Unit Identifier
					'duration-second' => {
						'one' => q({0} 𐑅𐐯𐐿𐐲𐑌𐐼),
						'other' => q({0} 𐑅𐐯𐐿𐐲𐑌𐐼𐑆),
					},
					# Core Unit Identifier
					'second' => {
						'one' => q({0} 𐑅𐐯𐐿𐐲𐑌𐐼),
						'other' => q({0} 𐑅𐐯𐐿𐐲𐑌𐐼𐑆),
					},
					# Long Unit Identifier
					'duration-week' => {
						'one' => q({0} 𐐶𐐨𐐿),
						'other' => q({0} 𐐶𐐨𐐿𐑅),
					},
					# Core Unit Identifier
					'week' => {
						'one' => q({0} 𐐶𐐨𐐿),
						'other' => q({0} 𐐶𐐨𐐿𐑅),
					},
					# Long Unit Identifier
					'duration-year' => {
						'one' => q({0} 𐐷𐐮𐑉),
						'other' => q({0} 𐐷𐐮𐑉𐑆),
					},
					# Core Unit Identifier
					'year' => {
						'one' => q({0} 𐐷𐐮𐑉),
						'other' => q({0} 𐐷𐐮𐑉𐑆),
					},
				},
			} }
);

has 'yesstr' => (
	is			=> 'ro',
	isa			=> RegexpRef,
	init_arg	=> undef,
	default		=> sub { qr'^(?i:𐐷𐐯𐑅|𐐷|yes|y)$' }
);

has 'nostr' => (
	is			=> 'ro',
	isa			=> RegexpRef,
	init_arg	=> undef,
	default		=> sub { qr'^(?i:𐑌𐐬|𐑌|no|n)$' }
);

has 'currencies' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'USD' => {
			symbol => '$',
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
							'𐐖𐐰𐑌',
							'𐐙𐐯𐐺',
							'𐐣𐐪𐑉',
							'𐐁𐐹𐑉',
							'𐐣𐐩',
							'𐐖𐐭𐑌',
							'𐐖𐐭𐑊',
							'𐐂𐑀',
							'𐐝𐐯𐐹',
							'𐐉𐐿𐐻',
							'𐐤𐐬𐑂',
							'𐐔𐐨𐑅'
						],
						leap => [
							
						],
					},
					wide => {
						nonleap => [
							'𐐖𐐰𐑌𐐷𐐭𐐯𐑉𐐨',
							'𐐙𐐯𐐺𐑉𐐭𐐯𐑉𐐨',
							'𐐣𐐪𐑉𐐽',
							'𐐁𐐹𐑉𐐮𐑊',
							'𐐣𐐩',
							'𐐖𐐭𐑌',
							'𐐖𐐭𐑊𐐴',
							'𐐂𐑀𐐲𐑅𐐻',
							'𐐝𐐯𐐹𐐻𐐯𐑋𐐺𐐲𐑉',
							'𐐉𐐿𐐻𐐬𐐺𐐲𐑉',
							'𐐤𐐬𐑂𐐯𐑋𐐺𐐲𐑉',
							'𐐔𐐨𐑅𐐯𐑋𐐺𐐲𐑉'
						],
						leap => [
							
						],
					},
				},
				'stand-alone' => {
					narrow => {
						nonleap => [
							'𐐖',
							'𐐙',
							'𐐣',
							'𐐁',
							'𐐣',
							'𐐖',
							'𐐖',
							'𐐂',
							'𐐝',
							'𐐉',
							'𐐤',
							'𐐔'
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
						mon => '𐐣𐐲𐑌',
						tue => '𐐓𐐭𐑆',
						wed => '𐐎𐐯𐑌',
						thu => '𐐛𐐲𐑉',
						fri => '𐐙𐑉𐐴',
						sat => '𐐝𐐰𐐻',
						sun => '𐐝𐐲𐑌'
					},
					wide => {
						mon => '𐐣𐐲𐑌𐐼𐐩',
						tue => '𐐓𐐭𐑆𐐼𐐩',
						wed => '𐐎𐐯𐑌𐑆𐐼𐐩',
						thu => '𐐛𐐲𐑉𐑆𐐼𐐩',
						fri => '𐐙𐑉𐐴𐐼𐐩',
						sat => '𐐝𐐰𐐻𐐲𐑉𐐼𐐩',
						sun => '𐐝𐐲𐑌𐐼𐐩'
					},
				},
				'stand-alone' => {
					narrow => {
						mon => '𐐣',
						tue => '𐐓',
						wed => '𐐎',
						thu => '𐐛',
						fri => '𐐙',
						sat => '𐐝',
						sun => '𐐝'
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
					abbreviated => {0 => '𐐗1',
						1 => '𐐗2',
						2 => '𐐗3',
						3 => '𐐗4'
					},
					wide => {0 => '1𐑅𐐻 𐐿𐐶𐐪𐑉𐐻𐐲𐑉',
						1 => '2𐑌𐐼 𐐿𐐶𐐪𐑉𐐻𐐲𐑉',
						2 => '3𐑉𐐼 𐐿𐐶𐐪𐑉𐐻𐐲𐑉',
						3 => '4𐑉𐑃 𐐿𐐶𐐪𐑉𐐻𐐲𐑉'
					},
				},
			},
	} },
);

has 'day_period_data' => (
	is			=> 'ro',
	isa			=> CodeRef,
	init_arg	=> undef,
	default		=> sub { sub {
		# Time in hhmm format
		my ($self, $type, $time, $day_period_type) = @_;
		$day_period_type //= 'default';
		SWITCH:
		for ($type) {
			if ($_ eq 'gregorian') {
				if($day_period_type eq 'default') {
					return 'midnight' if $time == 0;
					return 'noon' if $time == 1200;
					return 'afternoon1' if $time >= 1200
						&& $time < 1800;
					return 'evening1' if $time >= 1800
						&& $time < 2100;
					return 'morning1' if $time >= 600
						&& $time < 1200;
					return 'night1' if $time >= 2100;
					return 'night1' if $time < 600;
				}
				if($day_period_type eq 'selection') {
					return 'afternoon1' if $time >= 1200
						&& $time < 1800;
					return 'evening1' if $time >= 1800
						&& $time < 2100;
					return 'morning1' if $time >= 600
						&& $time < 1200;
					return 'night1' if $time >= 2100;
					return 'night1' if $time < 600;
				}
				last SWITCH;
				}
		}
	} },
);

around day_period_data => sub {
    my ($orig, $self) = @_;
    return $self->$orig;
};

has 'day_periods' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'gregorian' => {
			'format' => {
				'abbreviated' => {
					'am' => q{𐐰𐑋},
					'pm' => q{𐐹𐑋},
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
		'gregorian' => {
			abbreviated => {
				'0' => '𐐒𐐗',
				'1' => '𐐈𐐔'
			},
			narrow => {
				'0' => '𐐒',
				'1' => '𐐈'
			},
			wide => {
				'0' => '𐐒𐐲𐑁𐐬𐑉 𐐗𐑉𐐴𐑅𐐻',
				'1' => '𐐈𐑌𐐬 𐐔𐐱𐑋𐐮𐑌𐐨'
			},
		},
	} },
);

has 'date_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'gregorian' => {
		},
	} },
);

has 'time_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'gregorian' => {
		},
	} },
);

has 'datetime_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'gregorian' => {
		},
	} },
);

has 'datetime_formats_available_formats' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
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
	} },
);

has 'time_zone_names' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default	=> sub { {
		gmtFormat => q(𐐘𐐣𐐓 {0}),
		gmtZeroFormat => q(𐐘𐐣𐐓),
		regionFormat => q({0} 𐐓𐐴𐑋),
		'Alaska' => {
			long => {
				'daylight' => q#𐐊𐑊𐐰𐑅𐐿𐐲 𐐔𐐩𐑊𐐴𐐻 𐐓𐐴𐑋#,
				'generic' => q#𐐊𐑊𐐰𐑅𐐿𐐲 𐐓𐐴𐑋#,
				'standard' => q#𐐊𐑊𐐰𐑅𐐿𐐲 𐐝𐐻𐐰𐑌𐐼𐐲𐑉𐐼 𐐓𐐴𐑋#,
			},
		},
		'America/Adak' => {
			exemplarCity => q#𐐈𐐼𐐰𐐿#,
		},
		'America/Anchorage' => {
			exemplarCity => q#𐐁𐑍𐐿𐐲𐑉𐐮𐐾#,
		},
		'America/Boise' => {
			exemplarCity => q#𐐒𐐱𐐮𐑆𐐨#,
		},
		'America/Chicago' => {
			exemplarCity => q#𐐟𐐮𐐿𐐪𐑀𐐬#,
		},
		'America/Denver' => {
			exemplarCity => q#𐐔𐐯𐑌𐑂𐐲𐑉#,
		},
		'America/Detroit' => {
			exemplarCity => q#𐐔𐐲𐐻𐑉𐐱𐐮𐐻#,
		},
		'America/Indiana/Knox' => {
			exemplarCity => q#𐐤𐐪𐐿𐑅, 𐐆𐑌𐐼𐐨𐐰𐑌𐐲#,
		},
		'America/Indiana/Marengo' => {
			exemplarCity => q#𐐣𐐲𐑉𐐯𐑍𐑀𐐬, 𐐆𐑌𐐼𐐨𐐰𐑌𐐲#,
		},
		'America/Indiana/Petersburg' => {
			exemplarCity => q#𐐑𐐨𐐻𐐲𐑉𐑆𐐺𐐲𐑉𐑀, 𐐆𐑌𐐼𐐨𐐰𐑌𐐲#,
		},
		'America/Indiana/Tell_City' => {
			exemplarCity => q#𐐓𐐯𐑊 𐐝𐐮𐐼𐐨, 𐐆𐑌𐐼𐐨𐐰𐑌𐐲#,
		},
		'America/Indiana/Vevay' => {
			exemplarCity => q#𐐚𐐯𐑂𐐩, 𐐆𐑌𐐼𐐨𐐰𐑌𐐲#,
		},
		'America/Indiana/Vincennes' => {
			exemplarCity => q#𐐚𐐮𐑌𐑅𐐯𐑌𐑆, 𐐆𐑌𐐼𐐨𐐰𐑌𐐲#,
		},
		'America/Indiana/Winamac' => {
			exemplarCity => q#𐐎𐐮𐑌𐐲𐑋𐐰𐐿, 𐐆𐑌𐐼𐐨𐐰𐑌𐐲#,
		},
		'America/Indianapolis' => {
			exemplarCity => q#𐐆𐑌𐐼𐐨𐐲𐑌𐐰𐐹𐐬𐑊𐐲𐑅#,
		},
		'America/Juneau' => {
			exemplarCity => q#𐐖𐐭𐑌𐐬#,
		},
		'America/Kentucky/Monticello' => {
			exemplarCity => q#𐐣𐐪𐑌𐐻𐐲𐑅𐐯𐑊𐐬, 𐐗𐐲𐑌𐐻𐐲𐐿𐐨#,
		},
		'America/Los_Angeles' => {
			exemplarCity => q#𐐢𐐱𐑅 𐐈𐑌𐐾𐐲𐑊𐑅#,
		},
		'America/Louisville' => {
			exemplarCity => q#𐐢𐐭𐐶𐐨𐑂𐐮𐑊#,
		},
		'America/Menominee' => {
			exemplarCity => q#𐐣𐐲𐑌𐐪𐑋𐐲𐑌𐐨#,
		},
		'America/New_York' => {
			exemplarCity => q#𐐤𐐭 𐐏𐐱𐑉𐐿#,
		},
		'America/Nome' => {
			exemplarCity => q#𐐤𐐬𐑋#,
		},
		'America/North_Dakota/Center' => {
			exemplarCity => q#𐐝𐐯𐑌𐐻𐐲𐑉, 𐐤𐐱𐑉𐑃 𐐔𐐲𐐿𐐬𐐼𐐲#,
		},
		'America/North_Dakota/New_Salem' => {
			exemplarCity => q#𐐤𐐭 𐐝𐐩𐑊𐐲𐑋, 𐐤𐐱𐑉𐑃 𐐔𐐲𐐿𐐬𐐼𐐲#,
		},
		'America/Phoenix' => {
			exemplarCity => q#𐐙𐐨𐑌𐐮𐐿𐑅#,
		},
		'America/Yakutat' => {
			exemplarCity => q#𐐏𐐰𐐿𐐭𐐻𐐰𐐻#,
		},
		'America_Central' => {
			long => {
				'daylight' => q#𐐝𐐯𐑌𐐻𐑉𐐲𐑊 𐐔𐐩𐑊𐐴𐐻 𐐓𐐴𐑋#,
				'generic' => q#𐐝𐐯𐑌𐐻𐑉𐐲𐑊 𐐓𐐴𐑋#,
				'standard' => q#𐐝𐐯𐑌𐐻𐑉𐐲𐑊 𐐝𐐻𐐰𐑌𐐼𐐲𐑉𐐼 𐐓𐐴𐑋#,
			},
		},
		'America_Eastern' => {
			long => {
				'daylight' => q#𐐀𐑅𐐻𐐲𐑉𐑌 𐐔𐐩𐑊𐐴𐐻 𐐓𐐴𐑋#,
				'generic' => q#𐐀𐑅𐐻𐐲𐑉𐑌 𐐓𐐴𐑋#,
				'standard' => q#𐐀𐑅𐐻𐐲𐑉𐑌 𐐝𐐻𐐰𐑌𐐼𐐲𐑉𐐼 𐐓𐐴𐑋#,
			},
		},
		'America_Mountain' => {
			long => {
				'daylight' => q#𐐣𐐵𐑌𐐻𐐲𐑌 𐐔𐐩𐑊𐐴𐐻 𐐓𐐴𐑋#,
				'generic' => q#𐐣𐐵𐑌𐐻𐐲𐑌 𐐓𐐴𐑋#,
				'standard' => q#𐐣𐐵𐑌𐐻𐐲𐑌 𐐝𐐻𐐰𐑌𐐼𐐲𐑉𐐼 𐐓𐐴𐑋#,
			},
		},
		'America_Pacific' => {
			long => {
				'daylight' => q#𐐑𐐲𐑅𐐮𐑁𐐮𐐿 𐐔𐐩𐑊𐐴𐐻 𐐓𐐴𐑋#,
				'generic' => q#𐐑𐐲𐑅𐐮𐑁𐐮𐐿 𐐓𐐴𐑋#,
				'standard' => q#𐐑𐐲𐑅𐐮𐑁𐐮𐐿 𐐝𐐻𐐰𐑌𐐼𐐲𐑉𐐼 𐐓𐐴𐑋#,
			},
		},
		'Atlantic' => {
			long => {
				'daylight' => q#𐐈𐐻𐑊𐐰𐑌𐐻𐐮𐐿 𐐔𐐩𐑊𐐴𐐻 𐐓𐐴𐑋#,
				'generic' => q#𐐈𐐻𐑊𐐰𐑌𐐻𐐮𐐿 𐐓𐐴𐑋#,
				'standard' => q#𐐈𐐻𐑊𐐰𐑌𐐻𐐮𐐿 𐐝𐐻𐐰𐑌𐐼𐐲𐑉𐐼 𐐓𐐴𐑋#,
			},
		},
		'Etc/Unknown' => {
			exemplarCity => q#𐐊𐑌𐑌𐐬𐑌#,
		},
		'Hong_Kong' => {
			long => {
				'daylight' => q#𐐐𐐱𐑍 𐐗𐐱𐑍 𐐔𐐩𐑊𐐴𐐻 𐐓𐐴𐑋#,
				'generic' => q#𐐐𐐱𐑍 𐐗𐐱𐑍 𐐓𐐴𐑋#,
				'standard' => q#𐐐𐐱𐑍 𐐗𐐱𐑍 𐐝𐐻𐐰𐑌𐐼𐐲𐑉𐐼 𐐓𐐴𐑋#,
			},
		},
		'Newfoundland' => {
			long => {
				'daylight' => q#𐐤𐐭𐑁𐐲𐑌𐐼𐑊𐐲𐑌𐐼 𐐔𐐩𐑊𐐴𐐻 𐐓𐐴𐑋#,
				'generic' => q#𐐤𐐭𐑁𐐲𐑌𐐼𐑊𐐲𐑌𐐼 𐐓𐐴𐑋#,
				'standard' => q#𐐤𐐭𐑁𐐲𐑌𐐼𐑊𐐲𐑌𐐼 𐐝𐐻𐐰𐑌𐐼𐐲𐑉𐐼 𐐓𐐴𐑋#,
			},
		},
		'Pacific/Honolulu' => {
			exemplarCity => q#𐐐𐐪𐑌𐐲𐑊𐐭𐑊𐐭#,
		},
		'Pacific/Johnston' => {
			exemplarCity => q#𐐖𐐪𐑌𐑅𐐻𐐲𐑌#,
		},
		'Pacific/Midway' => {
			exemplarCity => q#𐐣𐐮𐐼𐐶𐐩#,
		},
		'Pacific/Wake' => {
			exemplarCity => q#𐐎𐐩𐐿#,
		},
	 } }
);
no Moo;

1;

# vim: tabstop=4

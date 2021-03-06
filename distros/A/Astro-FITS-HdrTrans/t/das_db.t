#!perl

use strict;

use Test::More tests => 14;

require_ok( 'Astro::FITS::HdrTrans' );

my %header = ();
$header{'DATE_OBS'} = "2006-02-03 06:29:00";
$header{SCAN} = 22;
$header{'NORSECT'} = 4;
$header{'NOFCHAN'} = 2;
$header{'NOBCHAN'} = 2048;
$header{'OBSMODE'} = 'sample';
$header{'CYCLLEN'} = 60;
$header{'FRONTEND'} = 'rxb';
$header{'BACKEND'} = 'DAS';
$header{'SWMODE'} = 'beamswitch';
$header{'NSCAN'} = 1;
$header{'NCYCLE'} = 2;
$header{'VDEF'} = 'radio';
$header{'VREF'} = 'lsr';
$header{'INSTRUME'} = 'JCMT_GSD_DB';
$header{'GSDFILE'} = "xxx";
$header{'SCA#'} = 52;

my %generic_header = Astro::FITS::HdrTrans::translate_from_FITS( \%header );

# Test constant mapping.
is( $generic_header{'INST_DHS'}, "HET_GSD", "INST_DHS constant mapping is HET_GSD" );
is( $generic_header{'COORDINATE_UNITS'}, "decimal", "COORDINATE_UNITS constant mapping is decimal" );
is( $generic_header{'EQUINOX'}, "current", "EQUINOX constant mapping is current" );
is( $generic_header{'TELESCOPE'}, "JCMT", "TELESCOPE constant mapping is JCMT" );

# Test computed headers.
is( $generic_header{'UTDATE'}, 20060203, "UTDATE 20060203");
isa_ok( $generic_header{'UTSTART'}, "Time::Piece", "UTSTART" );
is( $generic_header{'UTSTART'}, "Fri Feb  3 06:29:00 2006", "UTSTART stringifies to Fri Feb  3 06:29:00 2006" );
isa_ok( $generic_header{'UTEND'}, "Time::Piece", "UTEND" );
is( $generic_header{'UTEND'}, "Fri Feb  3 06:31:34 2006", "UTEND stringifies to Fri Feb  3 06:31:34 2006" );
is( $generic_header{'BANDWIDTH_MODE'}, "250MHzx2048", "BANDWIDTH_MODE is 250MHzx2048" );
is( $generic_header{'EXPOSURE_TIME'}, 154.8, "EXPOSURE_TIME is 154.8" );
is( $generic_header{'INSTRUMENT'}, "RXB3", "INSTRUMENT is RXB3" );
is( $generic_header{'SYSTEM_VELOCITY'}, "RADLSR", "SYSTEM_VELOCITY is RADLSR" );

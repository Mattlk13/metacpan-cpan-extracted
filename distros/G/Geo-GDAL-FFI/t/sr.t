use v5.10;
use strict;
use warnings;
use Carp;
use Encode qw(decode encode);
use Geo::GDAL::FFI;
use Test::More;
use Data::Dumper;
use JSON;
use FFI::Platypus::Buffer;

my $gdal = Geo::GDAL::FFI->get_instance();

{
    SKIP: {
      skip "GDAL support files not found.", 1 if !$gdal->FindFile('gcs.csv');
      my $sr = Geo::GDAL::FFI::SpatialReference->new(EPSG => 3067);
      ok($sr->Export('Wkt') eq 'PROJCS["ETRS89 / TM35FIN(E,N)",GEOGCS["ETRS89",DATUM["European_Terrestrial_Reference_System_1989",SPHEROID["GRS 1980",6378137,298.257222101,AUTHORITY["EPSG","7019"]],TOWGS84[0,0,0,0,0,0,0],AUTHORITY["EPSG","6258"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4258"]],PROJECTION["Transverse_Mercator"],PARAMETER["latitude_of_origin",0],PARAMETER["central_meridian",27],PARAMETER["scale_factor",0.9996],PARAMETER["false_easting",500000],PARAMETER["false_northing",0],UNIT["metre",1,AUTHORITY["EPSG","9001"]],AXIS["Easting",EAST],AXIS["Northing",NORTH],AUTHORITY["EPSG","3067"]]',
      'Import/export');
    }
}

done_testing();

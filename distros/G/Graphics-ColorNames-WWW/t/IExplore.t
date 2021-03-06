use Test::More tests => 140 + 7;
use Test::NoWarnings;

use strict;
use Carp;

use Graphics::ColorNames 0.20, qw( hex2tuple tuple2hex );
ok(1);

tie my %colors, 'Graphics::ColorNames', 'IE';
ok(1);

is(keys %colors, 140);

my $count = 0;
foreach my $name (keys %colors)
  {
    my @RGB = hex2tuple( $colors{$name} );
    is(tuple2hex(@RGB), $colors{$name} );
  }

is(uc $colors{'white'}, 'FFFFFF');
is(uc $colors{'blue'}, '0000FF');
is(uc $colors{'cyan'}, '00FFFF');

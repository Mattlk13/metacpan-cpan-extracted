use strict;
use warnings;

use Test::More;
use Prima::Test;

plan tests => 26;

my $a = Prima::Drawable-> create( width => 1, height => 1, type => im::RGB);

$a-> color( 0x123456);
is( $a-> color, 0x123456, 'color' );

$a-> backColor( 0x654321);
is( $a-> backColor, 0x654321, 'backColor' );

$a-> fillPattern( [0..7]); my $i = 0;
my $fillPatternCount = scalar grep { $i++ != $_ } @{$a-> fillPattern};
is( $fillPatternCount, 0, 'fillPattern' );

$a-> lineEnd( le::Square);
is( $a-> lineEnd, le::Square, 'lineEnd' );

$a-> lineWidth( 5);
is( $a-> lineWidth, 5, 'lineWidth' );

$a-> linePattern( lp::Dash);
is( $a-> linePattern, lp::Dash, 'linePattern' );

$a-> rop( rop::NotSrcXor);
is( $a-> rop, rop::NotSrcXor, 'rop' );

$a-> rop2( rop::NotSrcXor);
is( $a-> rop2, rop::NotSrcXor, 'rop2' );

$a-> translate( 1, 2);
my @z = $a-> translate;
is_deeply( \@z, [1,2], 'translate' );

$a-> textOpaque( 1);
is( $a-> textOpaque, 1, 'textOpaque' );

$a-> textOutBaseline( 1);
is( $a-> textOutBaseline, 1, 'textOutBaseline' );

$a-> lineJoin( lj::Bevel);
is( $a-> lineJoin ,lj::Bevel, "lineJoin");

$a-> fillWinding( 1);
ok( $a-> fillWinding, "fillWinding");

$a-> begin_paint;
$a-> end_paint;
is( $a-> color, 0x123456, 'color' );
is( $a-> backColor, 0x654321, 'backColor' );

$i = 0;
$fillPatternCount = scalar grep { $i++ != $_ } @{$a-> fillPattern};
is( $fillPatternCount, 0, "fillPattern" );
is( $a-> lineEnd, le::Square, "lineEnd" );
is( $a-> lineWidth, 5, "lineWidth" );
is( $a-> linePattern, lp::Dash, "linePattern" );
is( $a-> rop, rop::NotSrcXor, "rop" );
is( $a-> rop2 , rop::NotSrcXor, "rop2");

@z = $a-> translate;
is_deeply( \@z, [1,2], "translate" );
is( $a-> textOpaque, 1, "textOpaque" );
is( $a-> textOutBaseline, 1, "textOutBaseline" );
is( $a-> lineJoin, lj::Bevel, "lineJoin" );
ok( $a-> fillWinding, "fillWinding");

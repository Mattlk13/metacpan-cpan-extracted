
use strict;
use warnings;

use Test::More;
use Prima::Test qw(noX11);

sub is_pict
{
	my ( $i, $name, $pict ) = @_;
	my $ok = 1;
	ALL: for ( my $y = 0; $y < $i->height; $y++) {
		for ( my $x = 0; $x < $i->width; $x++) {
			my $actual   = ( $i->pixel($x,$y) > 0) ? 1 : 0;
			my $expected = (substr($pict, ($i->height-$y-1) * $i->width + $x, 1) eq ' ') ? 0 : 1;
			next if $actual == $expected;
			$ok = 0;
			last ALL;
		}
	}
	ok( $ok, $name );
	return 1 if $ok;
	warn "# Actual vs expected:\n";
	for ( my $y = 0; $y < $i->height; $y++) {
		my $actual   = join '', map { ($i->pixel($_,$i->height-$y-1) > 0) ? '*' : ' ' } 0..$i->width-1;
		my $expected = substr($pict, $y * $i->width, $i->width);
		warn "$actual  | $expected\n";
	}
	return 0;
}

# check optimizers 
for my $bpp ( 1, 4, 8, 24 ) {
	my $i = Prima::Image->create(
		width     => 5,
		height    => 5,
		type      => $bpp,
		color     => cl::White,
		backColor => cl::Black,
	);

	$i->clear;
	$i->line(1,1,3,1);
	is_pict($i, "$bpp: unclipped hline",
		"     ".
		"     ".
		"     ".
		" *** ".
		"     "
	);
	
	$i->clear;
	$i->line(-1,1,3,1);
	is_pict($i, "$bpp: left clipped hline",
		"     ".
		"     ".
		"     ".
		"**** ".
		"     "
	);

	$i->clear;
	$i->line(1,1,9,1);
	is_pict($i, "$bpp: left clipped hline",
		"     ".
		"     ".
		"     ".
		" ****".
		"     "
	);

	$i->clear;
	$i->line(-1,1,9,1);
	is_pict($i, "$bpp: clipped hline",
		"     ".
		"     ".
		"     ".
		"*****".
		"     "
	);
	
	$i->clear;
	$i->rop(rop::XorPut);
	$i->rectangle( 1,1,3,3);
	is_pict($i, "$bpp: rectangle",
		"     ".
		" *** ".
		" * * ".
		" *** ".
		"     "
	);
}

# those are unoptimized
my $i = Prima::Image->create(
	width     => 5,
	height    => 5,
	type      => im::bpp1,
	color     => cl::White,
	backColor => cl::Black,
);
$i->clear;
$i->line(1,1,3,3);
is_pict($i, "line",
	"     ".
	"   * ".
	"  *  ".
	" *   ".
	"     "
);


$i->clear;
$i->linePattern(lp::DotDot);
$i->rop2(rop::NoOper);
$i->line(1,1,3,3);
$i->linePattern(lp::Solid);
is_pict($i, "line dotted transparent",
	"     ".
	"   * ".
	"     ".
	" *   ".
	"     "
);

$i->clear;
$i->linePattern(lp::DotDot);
$i->rop2(rop::CopyPut);
$i->line(1,1,3,3);
$i->linePattern(lp::Solid);
is_pict($i, "line dotted opaque white",
	"     ".
	"   * ".
	"     ".
	" *   ".
	"     "
);

$i->clear;
$i->backColor(cl::White);
$i->linePattern(lp::DotDot);
$i->rop2(rop::CopyPut);
$i->line(1,1,3,3);
$i->backColor(cl::Black);
$i->linePattern(lp::Solid);
is_pict($i, "line dotted opaque black",
	"     ".
	"   * ".
	"  *  ".
	" *   ".
	"     "
);

$i->clear;
$i->region( Prima::Region->new( box => [2,2,1,1]));
$i->line(1,1,3,3);
is_pict($i, "line with simple region",
	"     ".
	"     ".
	"  *  ".
	"     ".
	"     "
);
$i->region( undef );

$i->clear;
$i->region( Prima::Region->new( box => [1,1,1,1, 3,3,1,1]));
$i->line(1,1,3,3);
is_pict($i, "line with complex region",
	"     ".
	"   * ".
	"     ".
	" *   ".
	"     "
);
$i->region( undef );

$i->clear;
$i->region( Prima::Region->new( box => [10,10,10,10]));
$i->line(1,1,3,3);
is_pict($i, "line outside region",
	"     ".
	"     ".
	"     ".
	"     ".
	"     "
);
$i->region( undef );

$i->clear;
$i->region( Prima::Region->new( box => [1,1,1,1, 3,3,1,1]));
$i->translate(-1,-1);
$i->line(1,1,3,3);
is_pict($i, "line with complex region and transform",
	"     ".
	"     ".
	"     ".
	" *   ".
	"     "
);
$i->translate(0,0);
$i->region( undef );

$i->linePattern(lp::Solid);
$i->clear;
$i->ellipse(2,2,5,5);
is_pict($i, "ellipse",
	"  *  ".
	" * * ".
	"*   *".
	" * * ".
	"  *  "
);

$i->clear;
$i->arc(2,2,5,5,0,90);
is_pict($i, "arc",
	"  *  ".
	"   * ".
	"    *".
	"     ".
	"     "
);

$i->clear;
$i->chord(2,2,5,5,180,0);
is_pict($i, "chord",
	"  *  ".
	" * * ".
	"*****".
	"     ".
	"     "
);

$i->clear;
$i->sector(2,2,5,5,0,270);
is_pict($i, "sector",
	"  *  ".
	" * * ".
	"* ***".
	" **  ".
	"  *  "
);

$i->clear;
$i->lines([1,1,3,1, 1,3,3,3, 1,4,4,4]);
is_pict($i, "lines",
	" ****".
	" *** ".
	"     ".
	" *** ".
	"     "
);

$i->clear;
$i->polyline([1,1,4,1,1,4,4,4]);
is_pict($i, "polyline",
	" ****".
	"  *  ".
	"   * ".
	" ****".
	"     "
);

$i->clear;
$i->fillMode(fm::Overlay|fm::Winding);
$i->fill_ellipse(2,2,5,5);
is_pict($i, "fill_ellipse",
	"  *  ".
	" *** ".
	"*****".
	" *** ".
	"  *  "
);

$i->clear;
$i->fill_sector(2,2,5,5,0,90);
is_pict($i, "fill_sector",
	"  *  ".
	"  ** ".
	"  ***".
	"     ".
	"     "
);

$i->clear;
$i->fill_chord(2,2,5,5,0,90);
is_pict($i, "fill_chord",
	"  *  ".
	"   * ".
	"    *".
	"     ".
	"     "
);

done_testing;

# Copyright (C) 1998 Tuomas J. Lukka.
# All rights reserved, except redistribution
# with PDL under the PDL License permitted.

package PDL::Demos::TriD1;

use PDL::Graphics::TriD;
use PDL::Graphics::TriD::Image;

sub info {('3d', '3d demo (requires TriD with OpenGL or Mesa)')}
sub init {'
use PDL::Graphics::TriD;
use PDL::Graphics::TriD::Image;
'}

my @demo = (
[comment => q|
	Welcome to a short tour of the capabilities of
	PDL::Graphics::TriD.

	Press 'q' in the graphics window for the next screen.
	Rotate the image by pressing mouse button one and
	dragging in the graphics window.
	Zoom in/out by pressing MB3 and drag up/down.
	Note that a standalone TriD script must start with

		use PDL;
		use PDL::Graphics::TriD;
		use PDL::Graphics::TriD::Image;

	to work properly.
|],

[actnw => q|
	# See if we had a 3D window open already
	$|.__PACKAGE__.q|::we_opened = !defined $PDL::Graphics::TriD::current_window;

	# Number of subdivisions for lines / surfaces.
	$size = 25;

	$cz = (xvals zeroes $size+1) / $size;  # interval 0..1
	$cx = sin($cz*12.6);	# Corkscrew
	$cy = cos($cz*12.6);
	line3d [$cx,$cy,$cz];	# Draw a line
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	$r = sin($cz*6.3)/2 + 0.5;
	$g = cos($cz*6.3)/2 + 0.5;
	$b = $cz;
	line3d [$cx,$cy,$cz], [$r,$g,$b];    # Draw a colored line
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	$x = (xvals zeroes $size+1,$size+1) / $size;
	$y = (yvals zeroes $size+1,$size+1) / $size;
	$z = 0.5 + 0.5 * (sin($x*6.3) * sin($y*6.3)) ** 3;   # Bumps
	line3d [$x,$y,$z];	# Draw several lines
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	$r = $x;
	$g = $y;
	$b = $z;
	line3d [$x,$y,$z], [$r,$g,$b];	# Draw several colored lines
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	lattice3d [$x,$y,$z], [$r,$g,$b];  # Draw a colored lattice
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	points3d [$x,$y,$z], [$r,$g,$b], {PointSize=>4};  # Draw colored points
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	imag3d_ns [$x,$y,$z], [$r,$g,$b];  # Draw a colored surface
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	imag3d [$x,$y,$z]; # Draw a shaded surface
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	# Draw a textured surface
	imag3d [$x,$y,$z], [$x,$y,$z], {
	  Material => PDL::Graphics::TriD::Material->new(
	    Shine => 0.212766,
	    Specular =>[0.753217,0.934416,1],
	    Ambient =>[0,0,0],
	    Diffuse =>[0.09855,0.153113,0.191489],
	    Emissive =>[0, 0, 0]
	  ),
	};
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	hold3d();	# Leave the previous object in..
	imag3d_ns [$x,$y,$z+1], [$r,$g,$b];
			# ...and draw a colored surface on top of it...
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	lattice3d [$x,$y,$z-1], [$r,$g,$b];
			# ...and draw a colored lattice under it...
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	nokeeptwiddling3d(); # Don't wait for user while drawing
	for(-2,-1,0,1,2) {
		line3d [$cx,$cy,$cz+$_]; # ... and corkscrews...
	}
	keeptwiddling3d();   # Do wait for user while drawing...
	twiddle3d();	     # and actually, wait right now.
	release3d();
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	# The reason for the [] around $x,$y,$z:
	# 1. You can give all the coordinates and colors in one ndarray.
	$c = (zeroes 3,$size+1) / $size;
	$coords =
		sin((3+3*xvals $c)*yvals $c);
	$colors = $coords;
	line3d $coords, $colors;        # Draw a curved line, colored
					# (this works also for lattices, etc.)
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	# 2. You can use defaults inside the brackets:
	lattice3d [$z], [$r];  # Note: no $x, $y, and $r is greyscale
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	# 3. You can plot in certain other systems as defaults
	imag3d_ns [POLAR2D, $z], [$r, $g, $b];  # Draw the familiar
						# bumpy surface in polar
						# coordinates
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	# One last thing: you can plot a color image like this
	imagrgb([$r,$g,$b]);
	# [press 'q' in the graphics window when done]
|],

[actnw => q|
	# '3d2' contains some of the more special constructions available
	# in the PDL::Graphics::TriD modules.

	# close 3D window if we opened it
	close3d() if $|.__PACKAGE__.q|::we_opened;
|],
);

sub demo { @demo }

1;

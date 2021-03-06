
#
# GENERATED WITH PDLA::PP! Don't modify!
#
package PDLA::FFT;

@EXPORT_OK  = qw( PDLA::PP _fft PDLA::PP _ifft  fft ifft fftnd ifftnd fftconvolve realfft realifft kernctr PDLA::PP convmath PDLA::PP cmul PDLA::PP cdiv );
%EXPORT_TAGS = (Func=>[@EXPORT_OK]);

use PDLA::Core;
use PDLA::Exporter;
use DynaLoader;



   
   @ISA    = ( 'PDLA::Exporter','DynaLoader' );
   push @PDLA::Core::PP, __PACKAGE__;
   bootstrap PDLA::FFT ;




=head1 NAME

PDLA::FFT - FFTs for PDLA

=head1 DESCRIPTION

!!!!!!!!!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
As of PDLA-2.006_04, the direction of the FFT/IFFT has been
reversed to match the usage in the FFTW library and the convention
in use generally.
!!!!!!!!!!!!!!!!!!!!!!!!!!WARNING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

FFTs for PDLA.  These work for arrays of any dimension, although ones
with small prime factors are likely to be the quickest.  The forward
FFT is unnormalized while the inverse FFT is normalized so that the
IFFT of the FFT returns the original values.

For historical reasons, these routines work in-place and do not recognize
the in-place flag.  That should be fixed.

=head1 SYNOPSIS

        use PDLA::FFT qw/:Func/;

	fft($real, $imag);
	ifft($real, $imag);
	realfft($real);
	realifft($real);

	fftnd($real,$imag);
	ifftnd($real,$imag);

	$kernel = kernctr($image,$smallk);
	fftconvolve($image,$kernel);

=head1 DATA TYPES

The underlying C library upon which this module is based performs FFTs
on both single precision and double precision floating point piddles.
Performing FFTs on integer data types is not reliable.  Consider the
following FFT on piddles of type 'double':

	$r = pdl(0,1,0,1);
	$i = zeroes($r);
	fft($r,$i);
	print $r,$i;
	[2 0 -2 0] [0 0 0 0]

But if $r and $i are unsigned short integers (ushorts):

	$r = pdl(ushort,0,1,0,1);
	$i = zeroes($r);
	fft($r,$i);
	print $r,$i;
	[2 0 65534 0] [0 0 0 0]

This used to occur because L<PDLA::PP|PDLA::PP> converts the ushort
piddles to floats or doubles, performs the FFT on them, and then
converts them back to ushort, causing the overflow where the amplitude
of the frequency should be -2.

Therefore, if you pass in a piddle of integer datatype (byte, short,
ushort, long) to any of the routines in PDLA::FFT, your data will be
promoted to a double-precision piddle.  If you pass in a float, the
single-precision FFT will be performed.

=head1 FREQUENCIES

For even-sized input arrays, the frequencies are packed like normal
for FFTs (where N is the size of the array and D is the physical step
size between elements):

 0, 1/ND, 2/ND, ..., (N/2-1)/ND, 1/2D, -(N/2-1)/ND, ..., -1/ND.

which can easily be obtained (taking the Nyquist frequency to be
positive) using

C<< $kx = $real->xlinvals(-($N/2-1)/$N/$D,1/2/$D)->rotate(-($N/2 -1)); >>

For odd-sized input arrays the Nyquist frequency is not directly
acessible, and the frequencies are

 0, 1/ND, 2/ND, ..., (N/2-0.5)/ND, -(N/2-0.5)/ND, ..., -1/ND.

which can easily be obtained using

C<< $kx = $real->xlinvals(-($N/2-0.5)/$N/$D,($N/2-0.5)/$N/$D)->rotate(-($N-1)/2); >>


=head1 ALTERNATIVE FFT PACKAGES

Various other modules - such as 
L<PDLA::FFTW|PDLA::FFTW> and L<PDLA::Slatec|PDLA::Slatec> - 
contain FFT routines.
However, unlike PDLA::FFT, these modules are optional,
and so may not be installed.

=cut







=head1 FUNCTIONS



=cut






*_fft = \&PDLA::_fft;





*_ifft = \&PDLA::_ifft;




use Carp;
use PDLA::Core qw/:Func/;
use PDLA::Basic qw/:Func/;
use PDLA::Types;
use PDLA::ImageND qw/kernctr/; # moved to ImageND since FFTW uses it too

END {
  # tidying up required after using fftn
  print "Freeing FFT space\n" if $PDLA::verbose;
  fft_free();
}

sub todecimal {
    my ($arg) = @_;
    $arg = $arg->double if (($arg->get_datatype != $PDLA_F) && 
			   ($arg->get_datatype != $PDLA_D));
    $_[0] = $arg;
1;}

=head2 fft()

=for ref

Complex 1-D FFT of the "real" and "imag" arrays [inplace].

=for sig

  Signature: ([o,nc]real(n); [o,nc]imag(n))

=for usage

fft($real,$imag);

=cut

*fft = \&PDLA::fft;

sub PDLA::fft {
	# Convert the first argument to decimal and check for trouble.
	eval {	todecimal($_[0]);	};
	if ($@) {
		$@ =~ s/ at .*//s;
		barf("Error in FFT with first argument: $@");
	}
	# Convert the second argument to decimal and check for trouble.
	eval {	todecimal($_[1]);	};
	if ($@) {
		$@ =~ s/ at .*//s;
		my $message = "Error in FFT with second argument: $@";
		$message .= '. Did you forget to supply the second (imaginary) piddle?'
			if ($message =~ /undefined value/);
		barf($message);
	}
	_fft($_[0],$_[1]);
}


=head2 ifft()

=for ref

Complex inverse 1-D FFT of the "real" and "imag" arrays [inplace].

=for sig

  Signature: ([o,nc]real(n); [o,nc]imag(n))

=for usage

ifft($real,$imag);

=cut

*ifft = \&PDLA::ifft;

sub PDLA::ifft {
	# Convert the first argument to decimal and check for trouble.
	eval {	todecimal($_[0]);	};
	if ($@) {
		$@ =~ s/ at .*//s;
		barf("Error in FFT with first argument: $@");
	}
	# Convert the second argument to decimal and check for trouble.
	eval {	todecimal($_[1]);	};
	if ($@) {
		$@ =~ s/ at .*//s;
		my $message = "Error in FFT with second argument: $@";
		$message .= '. Did you forget to supply the second (imaginary) piddle?'
			if ($message =~ /undefined value/);
		barf($message);
	}
	_ifft($_[0],$_[1]);
}

=head2 realfft()

=for ref

One-dimensional FFT of real function [inplace].

The real part of the transform ends up in the first half of the array
and the imaginary part of the transform ends up in the second half of
the array.

=for usage

	realfft($real);

=cut

*realfft = \&PDLA::realfft;

sub PDLA::realfft {
    barf("Usage: realfft(real(*)") if $#_ != 0;
    my ($x) = @_;
    todecimal($x);
# FIX: could eliminate $y
    my ($y) = 0*$x;
    fft($x,$y);
    my ($n) = int((($x->dims)[0]-1)/2); my($t);
    ($t=$x->slice("-$n:-1")) .= $y->slice("1:$n");
    undef;
}

=head2 realifft()

=for ref

Inverse of one-dimensional realfft routine [inplace].

=for usage

	realifft($real);

=cut

*realifft = \&PDLA::realifft;

sub PDLA::realifft {
    use PDLA::Ufunc 'max';
    barf("Usage: realifft(xfm(*)") if $#_ != 0;
    my ($x) = @_;
    todecimal($x);
    my ($n) = int((($x->dims)[0]-1)/2); my($t);
# FIX: could eliminate $y
    my ($y) = 0*$x;
    ($t=$y->slice("1:$n")) .= $x->slice("-$n:-1");
    ($t=$x->slice("-$n:-1")) .= $x->slice("$n:1");
    ($t=$y->slice("-$n:-1")) .= -$y->slice("$n:1");
    ifft($x,$y);
# Sanity check -- shouldn't happen
    carp "Bad inverse transform in realifft" if max(abs($y)) > 1e-6*max(abs($x));
    undef;
}

=head2 fftnd()

=for ref

N-dimensional FFT over all pdl dims of input (inplace) 

=for example

	fftnd($real,$imag);

=cut

*fftnd = \&PDLA::fftnd;

sub PDLA::fftnd {
    barf "Must have real and imaginary parts for fftnd" if $#_ != 1;
    my ($r,$i) = @_;
    my ($n) = $r->getndims;
    barf "Dimensions of real and imag must be the same for fft"
        if ($n != $i->getndims);
    $n--;
    todecimal($r);
    todecimal($i);
    # need the copy in case $r and $i point to same memory
    $i = $i->copy;
    foreach (0..$n) {
      fft($r,$i);
      $r = $r->mv(0,$n);
      $i = $i->mv(0,$n);
    }
    $_[0] = $r; $_[1] = $i;
    undef;
}

=head2 ifftnd()

=for ref

N-dimensional inverse FFT over all pdl dims of input (inplace) 

=for example

	ifftnd($real,$imag);

=cut

*ifftnd = \&PDLA::ifftnd;

sub PDLA::ifftnd {
    barf "Must have real and imaginary parts for ifftnd" if $#_ != 1;
    my ($r,$i) = @_;
    my ($n) = $r->getndims;
    barf "Dimensions of real and imag must be the same for ifft"
        if ($n != $i->getndims);
    todecimal($r);
    todecimal($i);
    # need the copy in case $r and $i point to same memory
    $i = $i->copy;
    $n--;
    foreach (0..$n) {
      ifft($r,$i);
      $r = $r->mv(0,$n);
      $i = $i->mv(0,$n);
    }
    $_[0] = $r; $_[1] = $i;
    undef;
}




=head2 fftconvolve()

=for ref

N-dimensional convolution with periodic boundaries (FFT method)

=for usage

	$kernel = kernctr($image,$smallk);
	fftconvolve($image,$kernel);

fftconvolve works inplace, and returns an error array in kernel as an
accuracy check -- all the values in it should be negligible.

See also L<PDLA::ImageND::convolveND|PDLA::ImageND/convolveND>, which 
performs speed-optimized convolution with a variety of boundary conditions.

The sizes of the image and the kernel must be the same.
L<kernctr|PDLA::ImageND/kernctr> centres a small kernel to emulate the
behaviour of the direct convolution routines.

The speed cross-over between using straight convolution 
(L<PDLA::Image2D::conv2d()|PDLA::Image2D/conv2d>) and
these fft routines is for kernel sizes roughly 7x7.

=cut

*fftconvolve = \&PDLA::fftconvolve;

sub PDLA::fftconvolve {
    barf "Must have image & kernel for fftconvolve" if $#_ != 1;
    my ($im, $k) = @_;

    my ($ar,$ai,$kr,$ki,$cr,$ci);

    $imr = $im->copy;
    $imi = $imr->zeros;
    fftnd($imr, $imi);

    $kr = $k->copy;
    $ki = $kr->zeroes;
    fftnd($kr,$ki);

    $cr = $imr->zeroes;
    $ci = $imi->zeroes;
    cmul($imr,$imi,$kr,$ki,$cr,$ci);

    ifftnd($cr,$ci);
    $_[0] = $cr;
    $_[1] = $ci;

    ($cr,$ci);
}

sub PDLA::fftconvolve_inplace {
    barf "Must have image & kernel for fftconvolve" if $#_ != 1;
    my ($hr, $hi) = @_;
    my ($n) = $hr->getndims;
    todecimal($hr);   # Convert to double unless already float or double
    todecimal($hi);   # Convert to double unless already float or double
    # need the copy in case $r and $i point to same memory
    $hi = $hi->copy;
    $hr = $hr->copy;
    fftnd($hr,$hi);
    convmath($hr->clump(-1),$hi->clump(-1));
    my ($str1, $str2, $tmp, $i);
    chop($str1 = '-1:1,' x $n);
    chop($str2 = '1:-1,' x $n);

# FIX: do these inplace -- cuts the arithmetic by a factor 2 as well.

    ($tmp = $hr->slice($str2)) += $hr->slice($str1)->copy;
    ($tmp = $hi->slice($str2)) -= $hi->slice($str1)->copy;
    for ($i = 0; $i<$n; $i++) {
	chop ($str1 = ('(0),' x $i).'-1:1,'.('(0),'x($n-$i-1)));
	chop ($str2 = ('(0),' x $i).'1:-1,'.('(0),'x($n-$i-1)));
	($tmp = $hr->slice($str2)) += $hr->slice($str1)->copy;
        ($tmp = $hi->slice($str2)) -= $hi->slice($str1)->copy;
    }
    $hr->clump(-1)->set(0,$hr->clump(-1)->at(0)*2);
    $hi->clump(-1)->set(0,0.);
    ifftnd($hr,$hi);
    $_[0] = $hr; $_[1] = $hi;
    ($hr,$hi);
}





=head2 convmath

=for sig

  Signature: ([o,nc]a(m); [o,nc]b(m))

=for ref

Internal routine doing maths for convolution

=for bad

convmath does not process bad values.
It will set the bad-value flag of all output piddles if the flag is set for any of the input piddles.


=cut






*convmath = \&PDLA::convmath;





=head2 cmul

=for sig

  Signature: (ar(); ai(); br(); bi(); [o]cr(); [o]ci())

=for ref

Complex multiplication

=for bad

cmul does not process bad values.
It will set the bad-value flag of all output piddles if the flag is set for any of the input piddles.


=cut






*cmul = \&PDLA::cmul;





=head2 cdiv

=for sig

  Signature: (ar(); ai(); br(); bi(); [o]cr(); [o]ci())

=for ref

Complex division

=for bad

cdiv does not process bad values.
It will set the bad-value flag of all output piddles if the flag is set for any of the input piddles.


=cut






*cdiv = \&PDLA::cdiv;




1; # OK




=head1 BUGS

Where the source is marked `FIX', could re-implement using phase-shift
factors on the transforms and some real-space bookkeeping, to save
some temporary space and redundant transforms.

=head1 AUTHOR

This file copyright (C) 1997, 1998 R.J.R. Williams
(rjrw@ast.leeds.ac.uk), Karl Glazebrook (kgb@aaoepp.aao.gov.au),
Tuomas J. Lukka, (lukka@husc.harvard.edu).  All rights reserved. There
is no warranty. You are allowed to redistribute this software /
documentation under certain conditions. For details, see the file
COPYING in the PDLA distribution. If this file is separated from the
PDLA distribution, the copyright notice should be included in the file.


=cut



;



# Exit with OK status

1;

		   
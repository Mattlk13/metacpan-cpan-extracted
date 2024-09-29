use strict;
use warnings;
use PDL::LiteF;
use PDL::Transform;
use PDL::Transform::Cartography; # raster2fits helps limit mem consumption
use Test::More;
use Test::Exception;

{
	##############################
	##############################
	# Test basic transformation
	my $t = t_linear(scale=>[2]);
	ok( $t->{idim} == 1 && $t->{odim} == 1, "t_linear can make a 1-d transform" );

	my $pa = sequence(2,2)+1;
	my $pb = $pa->apply($t);

	ok( all( approx( $pb, pdl( [2, 2], [6, 4] ) )), "1-d apply on a collection of vectors ignors higher dim");

	my $t2 = t_linear(scale=>[2,3]);

	ok( $t2->{idim} == 2 && $t2->{odim} == 2, "t_linear can make a 2-d transform" );

	$pb = $pa->apply($t2);

	ok( all( approx( $pb, pdl( [2, 6], [6, 12] ) )), "2-d apply treats the higher dim");

	$pb = pdl(2,3)->invert($t2);
	ok( all( approx($pb, 1) ), "invert works");

	my $t3 = t_rot([45,45,45]);
	$pa = PDL::MatrixOps::identity(3);
	my $got = $pa->apply($t3);
	ok all(approx $got, pdl(<<'EOF'), 1e-4), 't_rot works' or diag 'got=', $got;
[
  [        0.5 -0.14644661  0.85355339]
  [        0.5  0.85355339 -0.14644661]
  [-0.70710678         0.5         0.5]
]
EOF
}




{
	##############################
	# Simple testing of the map autoscaling

	my $pa = sequence(5,5);

	{
		# Identity transformation should be an expensive no-op
		# (autoscaled correctly)
		my $pb = $pa->map(t_identity());
		ok( all($pa==$pb) );
	}

	{
		# Identity transformation on pixels should be a slightly less expensive
		# no-op (no autoscaling)
		my $pb = $pa->map(t_identity,{pix=>1});
		ok( all($pa==$pb) );
	}

	{
		# Scaling by 2 and then autoscaling should be an expensive no-op
		# (scaled, then autoscaled back down)
		my $pb = $pa->map(t_scale(2));
		ok( all($pa==$pb) );
	}

	{
		# Scaling by 2 in pixel coordinates should actually scale the image
		my $pb = $pa->map(t_scale(2),{pix=>1});
		ok(all($pb == $pa*0.5));
	}
}

{
	##############################
	# diab jerius' t_scale crash
	# (this is due to a problem with inplace flag handling in PDL <= 2.6; transform works around it)

	lives_ok {
		my $pa = pdl(49,49);
		my $t = t_linear({scale=>pdl([1,3]), offset=>pdl([12,8])});
		my $pb = pdl( double, 2.2, 9.3);
		$pa->inplace->apply($t);
		my $q = 0;
		$pa += $q;
	};
}

##############################
# bad value handling...
{
	my $pa = sequence(5,5);
	no warnings;
	my $t1 = t_linear(pre=>[1.5,2]);
	my $t2 = t_linear(pre=>[1,2]);
	use warnings;
	$pa->badflag(1);
	my $pb;
	lives_ok { $pb = $pa->map($t1,{pix=>1,method=>'l'}) };
	ok(($pb->slice("0:1")->isbad->all  and  $pb->slice(":,0:1")->isbad->all  and ($pb->isbad->sum==16)), "Bad values happen");
	eval { $pb = $pa->map($t1,{pix=>1,method=>'h'}) };
	ok(($pb->slice("0")->isbad->all  and  $pb->slice(":,0:1")->isbad->all and $pb->isbad->sum==13), "Bad values happen with 'h' method") or diag "got: $pb";
}

{
	use PDL::IO::FITS;
	my $m51 = raster2fits(sequence(long, 10, 10), @PDL::Transform::Cartography::PLATE_CARREE);
	my $m51map = $m51->map(t_identity,{method=>'s'}); #SHOULD be a no-op
	ok(all($m51==$m51map));

	$m51map = $m51->map(t_identity, $m51->hdr,{method=>'s'}); #SHOULD be a no-op
	ok(all($m51==$m51map), 'map works with FITS hashref');

	my $m51_coords = pdl(0,0)->apply(t_fits($m51));
	my $m51map_coords = pdl(0,0)->apply(t_fits($m51map));
	ok(all(approx($m51_coords, $m51map_coords,1e-8)));
}

########################################
########################################
###
### Give map a workout...

{
	##############################
	# Basic testing of resampling methods

	my $pa = rvals(7,7) == 0;

	{
		my $pb = $pa->match($pa,{method=>'s'});
		ok(all($pa==$pb),"self-match with 's' method is a no-op");
	}

	{
		my $pb = $pa->match($pa,{method=>'l'});
		ok(all(approx($pa,$pb)),"self-match with 'l' method is an approximate no-op");
	}

	{
		my $pb = $pa->match($pa,{method=>'h'});
		ok(all(approx($pa,$pb)),"self-match with hanning method is an approximate no-op");
	}

	{
		my $pb = $pa->match($pa,{method=>'h',blur=>2});
		my $b0 = zeroes($pa);
		$b0->slice([2,4],[2,4]) .= pdl([[0.0625,0.125,0.0625],[0.125,0.25,0.125],[0.0625,0.125,0.0625]]);
		ok(all(approx($pb,$b0)),"self-match with hanning method and blur of 2 blurs right");
	}

	{
		my $pb = $pa->match($pa,{method=>'g'});
		my $b0 = zeroes($pa)-9;
		my $bc = pdl([-9,-3.3658615,-2.7638017],[-3.3658615,-1.5608028,-0.95874296],[-2.7638017,-0.95874296,-0.35668313]);
		#$bc = pdl([-9,-9,-2.762678-4.4e-8],[-9,-1.5593078,-0.95724797],[-2.762678-4.4e-8,-0.95724797,-0.35518814]);

		$b0->slice([1,3],[1,3]) .= $bc;
		$b0->slice([5,3],[1,3]) .= $bc;
		$b0->slice([1,5],[5,4]) .= $b0->slice([1,5],[1,2]);
		ok(all(approx($pb->clip(1e-9)->log10,$b0,1e-7)),"self-match with Gaussian method gives understood blur");
	}

	{
		my $t = t_linear(pre=>[0.5,1]);
		{
			my $pb = $pa->map($t,{method=>'s',pix=>1});
			my $wndb = $pb->whichND;
			ok(all($wndb==pdl([[3,4]])),'right boolean') or diag $wndb;
			ok(approx($pb->slice(3,4),1),'offset with sample is a simple offset') or diag $pb;
		}

		{
			my $pb = $pa->map($t,{method=>'l',pix=>1});
			my $wndb = $pb->whichND;
			ok(all($wndb==pdl([[3,4],[4,4]])),'right boolean') or diag $wndb;
			ok(all(approx($pb->slice([3,4],4),0.5)),'offset with linear interpolation does the right thing') or diag $pb;
		}

		{
			my $pb = $pa->map($t,{method=>'h',pix=>1});
			my $wndb = $pb->whichND;
			ok(all($wndb==pdl([[3,4],[4,4]])),'right boolean') or diag $wndb;
			ok(all(approx($pb->slice([3,4],4),0.5)),'offset with hanning interpolation does the right thing') or diag $pb;
		}
	}

	{
	    ##############################
	    #check that no resampling methods produce segfaults for transformations
	    #was segfaulting on 'g' only
	    use PDL::IO::FITS;
	    use PDL::Transform::Cartography;
	    my $m51 = raster2fits(sequence(long, 10, 10), @PDL::Transform::Cartography::PLATE_CARREE);
	    my $tp = t_perspective(r0=>200,iu=>'arcmin',origin=>[-10,3]);
	    foreach my $method(qw/s l c h g j H G/){ #f doesn't work so well on images this big
		lives_ok {$m51->map(!$tp,{nofits=>1,method=>$method})} "no map segfault m=>$method";
	    }
	}

}

{
use PDL::Transform::Cartography;
my $pa = raster2fits(sequence(byte, 10, 10), @PDL::Transform::Cartography::PLATE_CARREE);
eval { $pa->match([100,100]) };
is $@, '', 't_fits invertible';

is earth_coast()->nbad, 0, 'earth_coast no BAD';

my $in = pdl '[178.5 63.1 NaN; NaN NaN 0; 178.5 63.1 1; 179 63.2 1; 179.6 63.3 1; -179.8 65 1; -179.5 65.1 0]';
my $exp = pdl '[178.5 63.1 0; 1000 1000 0; 178.5 63.1 1; 179 63.2 1; 179.6 63.3 0; -179.8 65 1; -179.5 65.1 0]';
my $got;
my @cl_tests = (
  [sub {clean_lines($in,{fn=>0})}, 'l'],
  [sub {clean_lines((map $in->slice($_), qw(0:1 (2))),{fn=>0})}, 'l p'],
  [sub {clean_lines((map $in->slice($_), qw(0:1 (2))), 0.1,{fn=>0})}, 'l p t'],
  [sub {clean_lines($in, 0.1,{fn=>0})}, 'lp t']
);
for (['', sub {}], ["broadcast ", sub {
  $_ = $_->dummy(2,2)->copy, $_->slice('0:1,,1')->where($_->slice('0:1,,1') < 500) += 2 for $in, $exp;
}]) {
  my ($prefix, $mod) = @$_;
  $mod->();
  ok all(approx $got=$_->[0]()->setnantobad->setbadtoval(1000), $exp), "${prefix}scalar $_->[1]" or diag "got=$got\nexp=".$exp for @cl_tests;
  ok all(approx $got=($_->[0]())[0]->setnantobad->setbadtoval(1000), $exp->slice('0:1')), "${prefix}listl $_->[1]" or diag "got=$got\nexp=".$exp->slice('0:1') for @cl_tests;
  ok all(approx $got=($_->[0]())[1]->setnantobad->setbadtoval(1000), $exp->slice('(2)')), "${prefix}listp $_->[1]" or diag "got=$got\nexp=".$exp->slice('(2)') for @cl_tests;
}
$in = pdl '[178.5 63.1 1; 179 62 1; 178.8 63.1 1; 179 64.2 1; 179.2 63.7 1; 179.3 65 1; 179.4 63 1; 179.6 63.3 1; 179.8 65 1; 179.5 65.3 0]';
$exp = pdl '[179 64.2 1; 179.2 63.7 0; 179.4 63 1; 179.6 63.3 0]';
my $or = [[178.9,179.7], [62.8,64.5]];
ok all(approx $got=$in->clean_lines(1.1,{or=>$or}), $exp), "scalar orange" or diag "got=$got\nexp=".$exp;
$in = pdl '[178.5 63.1 1; NaN NaN 0; 178.5 63.1 1; 179 63.2 0]';
$exp = pdl '[178.5 63.1 0; 178.5 63.1 1; 179 63.2 0]';
ok all(approx $got=$in->clean_lines(1.1), $exp), "with filter_nan (default)" or diag "got=$got\nexp=".$exp;
}

{
##############################
# Test boundary conditions
my $pa = sequence(5,5);

{
my $pb = $pa->match([10,10],{pix=>1,method=>'s'});
ok( all($pb->slice([0,4],[0,4])==$pa) && all($pb->slice([5,9])==0) && all($pb->slice('x',[5,9])==0), "truncation boundary condition works");
}

{
my $pb = $pa->match([10,10],{pix=>1,method=>'h'});
ok( all($pb->slice([0,4],[0,4])==$pa) && all($pb->slice([5,9])==0) && all($pb->slice('x',[5,9])==0), "truncation boundary condition works for jacobian methods");
}

{
my $pb = $pa->match([10,10],{pix=>1,method=>'s',bound=>'mp'});
ok( all($pb->slice([0,4],[0,4])==$pa) && all($pb->slice([9,5])==$pb->slice([0,4])) && all($pb->slice('x',[5,9])==$pb->slice('x',[0,4])), "periodic and mirror boundary conditions work");
}

{
my $pb = $pa->match([10,10],{pix=>1,method=>'h',bound=>'mp'});
ok( all($pb->slice([0,4],[0,4])==$pa) && all($pb->slice([9,5])==$pb->slice([0,4])) && all($pb->slice('x',[5,9])==$pb->slice('x',[0,4])), "periodic and mirror boundary conditions work for jacobian methods");
}
}

done_testing;

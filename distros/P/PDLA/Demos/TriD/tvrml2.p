BEGIN {
   $PDLA::Graphics::TriD::device = "VRML";
   print "====================================\n";
   print " VRML not available...stopping demo \n";
   print "====================================\n";
   exit;
}


BEGIN{
  PDLA::Graphics::VRMLNode->import();
  PDLA::Graphics::VRMLProto->import();
}
use PDLA::Graphics::TriD;
use PDLA::LiteF;
use Carp;

$SIG{__DIE__} = sub {print Carp::longmess(@_); die;};
$set = tridsettings();
$set->browser_com('netscape/unix');
#$set->set(Compress => 1);

$nx = 20;

$t =  (xvals zeroes $nx+1,$nx+1)/$nx;
$u =  (yvals zeroes $nx+1,$nx+1)/$nx;

$x = sin($u*15 + $t * 3)/2+0.5 + 5*($t-0.5)**2;
$cx = PDLA->zeroes(3,$nx+1,$nx+1);
random($cx->inplace);
$pdl = PDLA->zeroes(3,20);
$pdl->inplace->random;
$cols = PDLA->zeroes(3,20);
$cols->inplace->random;

$g = PDLA::Graphics::TriD::get_new_graph;
$name = $g->add_dataseries(new PDLA::Graphics::TriD::Points($pdl,$cols));
$g->bind_default($name);
$name = $g->add_dataseries(new PDLA::Graphics::TriD::Lattice([SURF2D,$x]));
$g->bind_default($name);
$name = $g->add_dataseries(new PDLA::Graphics::TriD::SLattice_S([SURF2D,$x+1],$cx,
						     {Smooth=>1,Lines=>0}));
$g->bind_default($name);
$g->scalethings();
$win = PDLA::Graphics::TriD::get_current_window();


require PDLA::Graphics::VRML::Protos;
PDLA::Graphics::VRML::Protos->import();


#$win->{VRMLTop}->register_proto(PDLA::Graphics::VRML::Protos::PDLABlockText10());


#$win->{VRMLTop}->uses('PDLABlockText10');



#$win->current_viewport()->add_object(new PDLA::Graphics::TriD::VRMLObject(
#																	  vrn(Transform,
#																			translation => '0 0 -1',
#																			children =>
#																			[new PDLA::Graphics::VRMLNode('PDLABlockText10')
#																			]
#																		  )
#																	 ));




$win->display('netscape');
exit;

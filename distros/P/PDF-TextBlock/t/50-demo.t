BEGIN {
  my $rc;
  $rc = eval {
    require PDF::API2;
    1;
  };
  if (!defined $rc) { $rc = 0; }
  unless($rc) {
    print qq{1..0 # SKIP these tests; PDF::API2 is not installed\n};
    exit;
  }
}

use Test::More tests => 6;

# https://github.com/jhannah/pdf-textblock/issues/1
# Attempting to reproduce github bug report...
# Can't reproduce?

use PDF::API2;
use PDF::TextBlock;

ok(my $pdf = PDF::API2->new( -file => "50-demo.pdf" ), "PDF::API2->new()");
ok(my $tb  = PDF::TextBlock->new({
   pdf       => $pdf,
   fonts     => {
      b => PDF::TextBlock::Font->new({
         pdf  => $pdf,
         font => $pdf->corefont( 'Helvetica-Bold', -encoding => 'latin1' ),
      }),
   },
}),                                                   "new()");
ok($tb->text(
   $tb->garbledy_gook . 
   ("\x{0x00A0}" x 50) . 
   $tb->garbledy_gook
),                                                    "text()");
ok(my ($endw, $ypos) = $tb->apply(),                  "apply()");

$tb->y($ypos);
$tb->text("Generated by t/50-demo.t");
$tb->fonts->{default}->fillcolor('darkblue');
ok(() = $tb->apply(),                                 "apply()");

$pdf->save;    # Doesn't return true, even when it succeeds. -sigh-
$pdf->end;     # Doesn't return true, even when it succeeds. -sigh-
ok(-r "50-demo.pdf",                                  "50-demo.pdf created");

diag( "Testing PDF::TextBlock $PDF::TextBlock::VERSION, Perl $], $^X" );




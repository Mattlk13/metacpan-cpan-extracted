#! /usr/bin/perl
#---------------------------------------------------------------------
# This example report is hereby placed in the public domain.
# You may copy from it freely.
#
# This is the same as image.pl, but it uses PostScript::Convert
# to generate a PDF file.
#---------------------------------------------------------------------

use strict;
use warnings;

use PostScript::Convert;
use PostScript::Report ();

# Describe the report:
my $desc = {
  report_header => [ HBox => { border => 0 },
    { _class => 'Image',
      file   => 'recycle.eps' },
    [ VBox => { width => 100 },
      { value => \'Foo Bar Recycling' },
      { value => \'123 Any Street' },
      { value => \'Your Town, USA' },
    ],
  ], # end report_header

  stripe => [ 0.85, '#FF0' ],   # Grey & yellow

  columns => {
    data => [
      #                  Header is centered    Column is right justified
      [ 'Number' =>  40, { align => 'center'}, { align => 'right'} ],
      [ 'Letter' =>  40 ],
      [ 'Text'   => 320 ],
      #                  Both header and column are right justified
      [ 'Right'  =>  60, { align => 'right'}, { align => 'right'} ],
    ],
  }, # end columns
};

# Generate sample data for the report:
my $letter = 'A';

my @rows = map { my $r=[ $_, $letter, "$_ $letter", "Right $_" ];
                 ++$letter;
                 $r } 1 .. 76;

# Build the report and run it:
my $rpt = PostScript::Report->build($desc);

psconvert($rpt->run(\@rows), 'pdf_image.pdf');

#$rpt->output("pdf_image.ps");

#$rpt->dump;

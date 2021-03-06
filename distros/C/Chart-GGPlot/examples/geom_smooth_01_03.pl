#!/usr/bin/env perl

# Instead of a loess smooth, you can use any other modelling function.

use 5.016;
use warnings;

use Getopt::Long;
use Chart::GGPlot qw(:all);
use Data::Frame::Examples qw(mpg);

my $save_as;
GetOptions( 'o=s' => \$save_as );

my $mpg = mpg();

my $p = ggplot(
    data    => $mpg,
    mapping => aes( x => 'displ', y => 'hwy' )
)->geom_point()->geom_smooth(method => 'glm');

if (defined $save_as) {
    $p->save($save_as);
} else {
    $p->show();
}


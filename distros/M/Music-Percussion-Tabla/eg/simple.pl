#!/usr/bin/env perl
use strict;
use warnings;

use Data::Dumper::Compact qw(ddc);
use Music::Percussion::Tabla ();

my $t = Music::Percussion::Tabla->new(
  signature => '3/4',
  bars      => 64,
  bpm       => 320,
);

my @specs;

for (1 .. $t->bars) {
  push @specs, $t->strike(['ta', 'ke']);
  push @specs, $t->strike('ge');
  push @specs, $t->strike('ke');
  push @specs, $t->strike('ta');
  push @specs, $t->strike(['ge', 'ke']);
  push @specs, $t->strike('dha');
}

print ddc \@specs;

$t->write;

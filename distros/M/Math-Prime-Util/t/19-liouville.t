#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;
use Math::Prime::Util qw/liouville/;

#my $extra = defined $ENV{EXTENDED_TESTING} && $ENV{EXTENDED_TESTING};
#my $usexs = Math::Prime::Util::prime_get_config->{'xs'};
#my $usegmp= Math::Prime::Util::prime_get_config->{'gmp'};
my $use64 = Math::Prime::Util::prime_get_config->{'maxbits'} > 32;
$use64 = 0 if $use64 && 18446744073709550592 == ~0;

my @liouville_pos = (qw/24 51 94 183 294 629 1488 3684 8006 8510 32539 57240
   103138 238565 444456 820134 1185666 3960407 4429677 13719505 29191963
   57736144 134185856 262306569 324235872 563441153 1686170713 2489885844/);
my @liouville_neg = (qw/23 47 113 163 378 942 1669 2808 8029 9819 23863 39712
   87352 210421 363671 562894 1839723 3504755 7456642 14807115 22469612
   49080461 132842464 146060791 279256445 802149183 1243577750 3639860654/);
if ($use64) {
  push @liouville_pos, (qw/1260238066729040 10095256575169232896/);
  push @liouville_neg, (qw/1807253903626380 12063177829788352512/);
}


plan tests => scalar(@liouville_pos) + scalar(@liouville_neg);

###### liouville
foreach my $i (@liouville_pos) {
  is( liouville($i),  1, "liouville($i) = 1" );
}
foreach my $i (@liouville_neg) {
  is( liouville($i), -1, "liouville($i) = -1" );
}

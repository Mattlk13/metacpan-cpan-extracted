use 5.00503;
use strict;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Test::Simply tests => 1;
BEGIN {
    if ($] > 5.00503) {
        for (1..1) {
            ok(1, " # PASS $^X @{[__FILE__]}");
        }
        exit;
    }
}

use Fake::Encode;

ok('��' eq Encode::decode('cp932','��'), q{'��' eq Encode::decode('cp932','��')});

__END__

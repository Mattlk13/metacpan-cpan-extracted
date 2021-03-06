use Test::More qw(no_plan);

BEGIN { use_ok('Date::ICal') };

my $harness = $ENV{HARNESS_ACTIVE};
$|=1 unless $harness;

# test greg2jd and jd2greg for various dates
# 2 tests are performed for each date (on greg2jd and jd2greg)
# dates are specified as [jd,year,month,day]
for (
     # min and max supported days (for 32-bit system)
     [-2**31,-5879610,6,22],[2**31-1,5879611,7,11],

     # some miscellaneous dates I had day numbers for (these are
     # actually epoch dates for various calendars from Calendrical
     # Calculations (1st ed) Table 1.1)

     [-1721425,-4713,11,24],[-1373427,-3760,9,7],[-1137142,-3113,8,11],
     [-1132959,-3101,1,23],[-963099,-2636,2,15],[-1,0,12,30],[1,1,1,1],
     [2796,8,8,27],[103605,284,8,29],[226896,622,3,22],[227015,622,7,19],
     [654415,1792,9,22],[673222,1844,3,21]
) {
    is(join('/',Date::ICal::jd2greg($_->[0])), join('/',@{$_}[1..3]),
       $_->[0]."   \t=> ".join'/',@{$_}[1..3]);
    is(Date::ICal::greg2jd(@{$_}[1..3]), $_->[0],
       join('/',@{$_}[1..3])."   \t=> ".$_->[0]);
}

# normalization tests
for (
     [-1753469,-4797,-33,1],[-1753469,-4803,39,1],
     [-1753105,-4796,-34,28],[-1753105,-4802,38,28]
) {
    is(Date::ICal::greg2jd(@{$_}[1..3]), $_->[0],
       join('/',@{$_}[1..3])." \t=> ".$_->[0]." (normalization)");
}

# test first and last day of each month from Jan -4800..Dec 4800
# this test bails after the first failure with a not ok.
# if it comlpetes successfully, only one ok is issued.

my @mlen=(0,31,0,31,30,31,30,31,31,30,31,30,31);
my ($dno,$y,$m,$dno2,$y2,$m2,$d2,$mlen) = (-1753530,-4800,1);

print "# this may take a minute...\n";
while ( $y <= 4800 ) {

    # test $y,$m,1
    ++$dno;
    $dno2 = Date::ICal::greg2jd( $y, $m, 1 );
    if ( $dno != $dno2 ) {
        is( $dno2, $dno, "greg torture test: greg2jd($y,$m,1) should be $dno" );
        last;
    }
    ( $y2, $m2, $d2 ) = Date::ICal::jd2greg($dno);

    if ( $y2 != $y || $m2 != $m || $d2 != 1 ) {
        is( "$y2/$m2/$d2", "$y/$m/1",
          "greg torture test: jd2greg($dno) should be $y/$m/1" );
        last;
    }

    # test $y,$m,$mlen
    $mlen = $mlen[$m] || ( $y % 4 ? 28 : $y % 100 ? 29 : $y % 400 ? 28 : 29 );
    $dno += $mlen - 1;
    $dno2 = Date::ICal::greg2jd( $y, $m, $mlen );
    if ( $dno != $dno2 ) {
        is( $dno2, $dno,
          "greg torture test: greg2jd($y,$m,$mlen) should be $dno" );
        last;
    }
    ( $y2, $m2, $d2 ) = Date::ICal::jd2greg($dno);

    if ( $y2 != $y || $m2 != $m || $d2 != $mlen ) {
        is( "$y2/$m2/$d2", "$y/$m/$mlen",
          "greg torture test: jd2greg($dno) should be $y/$m/$mlen" );
        last;
    }

    # and on to the next month...
    if ( ++$m > 12 ) {
        $m = 1;
        ++$y;
        print "\r$y     " unless $harness || $y % 100;
    }
}
print "\n" unless $harness;
pass("greg torture test") if $y==4801;


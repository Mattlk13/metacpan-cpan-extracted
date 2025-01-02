use strict;
use warnings;
use Test::More;
use PDL::LiteF;
use Test::PDL;

subtest 'cmpvec' => sub {
    is_pdl pdl( 1, 2, 3 )->cmpvec( pdl( 3, 2, 1 ) ), sbyte( -1 ), 'less';
    is_pdl pdl( 3, 2, 1 )->cmpvec( pdl( 1, 2, 3 ) ), sbyte( 1 ),  'more';
    is_pdl pdl( 3, 2, 1 )->cmpvec( pdl( 3, 2, 1 ) ), sbyte( 0 ),  'same';

    is_deeply pdl('[1 BAD]')->cmpvec( pdl( 3, 2 ) )->unpdl, [-1],    'bad before';
    is_deeply pdl('[BAD 1]')->cmpvec( pdl( 3, 2 ) )->unpdl, ['BAD'], 'bad';

    my $vdim = 4;
    my $v1   = zeroes($vdim);
    my $v2   = pdl($v1);
    $v2->set( -1, 1 );

    ok $v1->cmpvec($v2) < 0, "1d:<";
    ok $v2->cmpvec($v1) > 0, "1d:>";
    is $v1->cmpvec($v1)->sclr, 0, "1d:==";
};

subtest 'eqvec' => sub {
    is_pdl pdl( 3, 2, 1 )->eqvec( pdl( 1, 2, 3 ) ), sbyte( 0 ), 'diff';
    is_pdl pdl( 3, 2, 1 )->eqvec( pdl( 3, 2, 1 ) ), sbyte( 1 ), 'same';
    is_deeply pdl('[2 1 BAD]')->eqvec( pdl( 1, 3, 2 ) )->unpdl, ['BAD'], 'bad before';
    is_deeply pdl('[2 BAD 1]')->eqvec( pdl( 2, 3, 2 ) )->unpdl, ['BAD'], 'bad';
};

subtest 'uniqvec' => sub {

    is_deeply pdl( [ [ 0, 1 ], [ 2, 2 ], [ 0, 1 ] ] )->uniqvec->unpdl,
        [ [ 0, 1 ], [ 2, 2 ] ], '2x3';

    is_deeply pdl( [ [ 0, 1 ] ] )->uniqvec->unpdl, [ [ 0, 1 ] ], '1x2';

    is_deeply pdl( [ [ 0, 1, 2 ], [ 0, 1, 2 ], [ 0, 1, 2 ], ] )->uniqvec->unpdl,
      [ [ 0, 1, 2 ] ], '3x3';
};

subtest 'qsortvec' => sub {
    my $p2d = pdl( [ [ 1, 2 ], [ 3, 4 ], [ 1, 3 ], [ 1, 2 ], [ 3, 3 ] ] );
    is_pdl $p2d->qsortvec,
        my $p2de = pdl( [ [ 1, 2 ], [ 1, 2 ], [ 1, 3 ], [ 3, 3 ], [ 3, 4 ] ] ),
      "qsortvec";
    is_pdl $p2d->dice_axis( 1, $p2d->qsortveci ), $p2de, "qsortveci";
};

subtest 'vsearchvec' => sub {
    my $which = pdl(
        long,
        [
            [ 0, 0 ], [ 0, 0 ], [ 0, 1 ], [ 0, 1 ],
            [ 1, 0 ], [ 1, 0 ], [ 1, 1 ], [ 1, 1 ]
        ]
    );
    my $find = $which->slice(",0:-1:2");
    is_pdl $find->vsearchvec($which), indx([ 0, 2, 4, 6 ]), "match";
    is_pdl pdl( [ -1, -1 ] )->vsearchvec($which), indx(0),              "<<";
    is_pdl pdl( [ 2, 2 ] )->vsearchvec($which), indx($which->dim(1)-1), ">>";
};

subtest 'unionvec' => sub {
    my $vtype    = long;
    my $universe = pdl( $vtype, [ [ 0, 0 ], [ 0, 1 ], [ 1, 0 ], [ 1, 1 ] ] );
    my $v1       = $universe->dice_axis( 1, pdl( [ 0, 1, 2 ] ) );
    my $v2       = $universe->dice_axis( 1, pdl( [ 1, 2, 3 ] ) );
    my ( $c, $nc ) = $v1->unionvec($v2);
    is_pdl $c, pdl($vtype, [ [0,0], [0,1], [1,0], [1,1], [0,0], [0,0] ]),
      "list:c";
    is $nc, $universe->dim(1), "list:nc";
    my $cc = $v1->unionvec($v2);
    is_pdl $cc, $universe, "scalar";
};

subtest 'intersectvec' => sub {
    my $vtype    = long;
    my $universe = pdl( $vtype, [ [ 0, 0 ], [ 0, 1 ], [ 1, 0 ], [ 1, 1 ] ] );
    my $v1       = $universe->dice_axis( 1, pdl( [ 0, 1, 2 ] ) );
    my $v2       = $universe->dice_axis( 1, pdl( [ 1, 2, 3 ] ) );
    my ( $c, $nc ) = $v1->intersectvec($v2);
    is_pdl $c, pdl( $vtype, [ [ 0, 1 ], [ 1, 0 ], [ 0, 0 ] ] ), "list:c";
    is $nc->sclr, 2, "list:nc";
    my $cc = $v1->intersectvec($v2);
    is_pdl $cc, $universe->slice(",1:2"), "scalar";
};

subtest 'setdiffvec' => sub {
    my $vtype    = long;
    my $universe = pdl( $vtype, [ [ 0, 0 ], [ 0, 1 ], [ 1, 0 ], [ 1, 1 ] ] );
    my $v1       = $universe->dice_axis( 1, pdl( [ 0, 1, 2 ] ) );
    my $v2       = $universe->dice_axis( 1, pdl( [ 1, 2, 3 ] ) );
    my ( $c, $nc ) = $v1->setdiffvec($v2);
    is_pdl $c, pdl( $vtype, [ [ 0, 0 ], [ 0, 0 ], [ 0, 0 ] ] ), "list:c";
    is $nc, 1, "list:nc";
    my $cc = $v1->setdiffvec($v2);
    is_pdl $cc, pdl( $vtype, [ [ 0, 0 ] ] ), "scalar";
};

subtest '*_sorted' => sub {
    my $all   = sequence(20);
    my $amask = ( $all % 2 ) == 0;
    my $bmask = ( $all % 3 ) == 0;
    my $alpha = $all->where($amask);
    my $beta  = $all->where($bmask);
    is_pdl scalar($alpha->union_sorted($beta)), $all->where( $amask | $bmask ),
      "union_sorted";
    is_pdl scalar($alpha->intersect_sorted($beta)),
      $all->where( $amask & $bmask ),
      "intersect_sorted";
    is_pdl scalar($alpha->setdiff_sorted($beta)),
      $all->where( $amask & $bmask->not ),
      "setdiff_sorted";
};

##--------------------------------------------------------------
## dim-checks and implicit broadcast dimensions
##  + see https://github.com/moocow-the-bovine/PDL-VectorValued/issues/4

subtest 'broadcast_dimensions' => sub {
    ##-- unionvec
    my $empty = zeroes( 3, 0 );
    my $uw    = pdl( [ [ -3, -2, -1 ], [ 1, 2, 3 ] ] );
    my $wx    = pdl( [ [ 1,  2,  3 ],  [ 4, 5, 6 ] ] );
    my $xy    = pdl( [ [ 4,  5,  6 ],  [ 7, 8, 9 ] ] );

    # unionvec: basic
    is_pdl scalar( $uw->unionvec($wx) ),
      pdl( [ [ -3, -2, -1 ], [ 1, 2, 3 ], [ 4, 5, 6 ] ] ),
      "unionvec - broadcast dims - uw+wx";
    is_pdl scalar( $uw->unionvec($xy) ),
      pdl( [ [ -3, -2, -1 ], [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ] ),
      "unionvec - broadcast dims - uw+xy";
    is_pdl scalar( $empty->unionvec($wx) ), $wx,
      "unionvec - broadcast dims - 0+wx";
    is_pdl scalar( $wx->unionvec($empty) ), $wx,
      "unionvec - broadcast dims - wx+0";
    is_pdl scalar( $empty->unionvec($empty) ), $empty,
      "unionvec - broadcast dims - 0+0";

    # unionvec: broadcasting
    my $k      = 2;
    my $kempty = $empty->slice(",,*$k");
    my $kuw    = $uw->slice(",,*$k");
    my $kwx    = $wx->slice(",,*$k");
    my $kxy    = $xy->slice(",,*$k");
    is_pdl scalar( $kuw->unionvec($wx) ),
      pdl( [ [ -3, -2, -1 ], [ 1, 2, 3 ], [ 4, 5, 6 ] ] )->slice(",,*$k"),
      "unionvec - broadcast dims - uw(*k)+wx";
    is_pdl scalar( $kuw->unionvec($xy) ),
      pdl( [ [-3,-2,-1], [1,2,3], [4,5,6], [7,8,9] ] )->slice(",,*$k"),
      "unionvec - broadcast dims - uw(*k)+xy";
    is_pdl scalar( $kempty->unionvec($wx) ), $kwx,
      "unionvec - broadcast dims - 0(*k)+wx";
    is_pdl scalar( $kwx->unionvec($empty) ), $kwx,
      "unionvec - broadcast dims - wx(*k)+0";
    is_pdl scalar( $kempty->unionvec($empty) ), $kempty,
      "unionvec - broadcast dims - 0(*k)+0";

    ##-- intersectvec

    my $needle0 = pdl( [ [ -3, -2, -1 ] ] );
    my $needle1 = pdl( [ [ 1,  2,  3 ] ] );
    my $needles = pdl( [ [ -3, -2, -1 ], [ 1, 2, 3 ] ] );
    my $haystack =
      pdl( [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ], [ 10, 11, 12 ] ] );

    # intersectvec: basic
    is_pdl scalar( $needle0->intersectvec($haystack) ), $empty,
      "intersectvec - broadcast dims - needle0&haystack";
    is_pdl scalar( $needle1->intersectvec($haystack) ), $needle1,
      "intersectvec - broadcast dims - needle1&haystack";
    is_pdl scalar( $needles->intersectvec($haystack) ), $needle1,
      "intersectvec - broadcast dims - needles&haystack";
    is_pdl scalar( $haystack->intersectvec($haystack) ), $haystack,
      "intersectvec - broadcast dims - haystack&haystack";
    is_pdl scalar( $haystack->intersectvec($empty) ), $empty,
      "intersectvec - broadcast dims - haystack&empty";
    is_pdl scalar( $empty->intersectvec($haystack) ), $empty,
      "intersectvec - broadcast dims - empty&haystack";

    # intersectvec: broadcasting
    my $kneedle0  = $needle0->slice(",,*$k");
    my $kneedle1  = $needle1->slice(",,*$k");
    my $kneedles  = pdl( [ [ [ -3, -2, -1 ] ], [ [ 1, 2, 3 ] ] ] );
    my $khaystack = $haystack->slice(",,*$k");
    is_pdl scalar( $kneedle0->intersectvec($haystack) ), $kempty,
      "intersectvec - broadcast dims - needle0(*k)&haystack";
    is_pdl scalar( $kneedle1->intersectvec($haystack) ), $kneedle1,
      "intersectvec - broadcast dims - needle1(*k)&haystack";
    is_pdl scalar( $kneedles->intersectvec($haystack) ),
      pdl( [ [ [ 0, 0, 0 ] ], [ [ 1, 2, 3 ] ] ] ),
      "intersectvec - broadcast dims - needles(*k)&haystack";
    is_pdl scalar( $khaystack->intersectvec($haystack) ), $khaystack,
      "intersectvec - broadcast dims - haystack(*k)&haystack";
    is_pdl scalar( $khaystack->intersectvec($empty) ), $kempty,
      "intersectvec - broadcast dims - haystack(*k)&empty";
    is_pdl scalar( $kempty->intersectvec($haystack) ), $kempty,
      "intersectvec - broadcast dims - empty(*k)&haystack";

    # setdiffvec: basic
    is_pdl scalar( $haystack->setdiffvec($needle0) ), $haystack,
      "setdiffvec - broadcast dims - haystack-needle0";
    is_pdl scalar( $haystack->setdiffvec($needle1) ),
      $haystack->slice(",1:-1"),
      "setdiffvec - broadcast dims - haystack-needle1";
    is_pdl scalar( $haystack->setdiffvec($needles) ),
      $haystack->slice(",1:-1"),
      "setdiffvec - broadcast dims - haystack-needles";
    is_pdl scalar( $haystack->setdiffvec($haystack) ), $empty,
      "setdiffvec - broadcast dims - haystack-haystack";
    is_pdl scalar( $haystack->setdiffvec($empty) ), $haystack,
      "setdiffvec - broadcast dims - haystack-empty";
    is_pdl scalar( $empty->setdiffvec($haystack) ), $empty,
      "setdiffvec - broadcast dims - empty-haystack";

    # setdiffvec: broadcasting
    is_pdl scalar( $khaystack->setdiffvec($needle0) ), $khaystack,
      "setdiffvec - broadcast dims - haystack(*k)-needle0";
    is_pdl scalar( $khaystack->setdiffvec($needle1) ),
      $khaystack->slice(",1:-1,"),
      "setdiffvec - broadcast dims - haystack(*k)-needle1";
    is_pdl scalar( $khaystack->setdiffvec($needles) ),
      $khaystack->slice(",1:-1,"),
      "setdiffvec - broadcast dims - haystack(*k)-needles";
    is_pdl scalar( $khaystack->setdiffvec($haystack) ), $kempty,
      "setdiffvec - broadcast dims - haystack(*k)-haystack";
    is_pdl scalar( $khaystack->setdiffvec($empty) ), $khaystack,
      "setdiffvec - broadcast dims - haystack(*k)-empty";
    is_pdl scalar( $kempty->setdiffvec($haystack) ), $kempty,
      "setdiffvec - broadcast dims - empty(*k)-haystack";
};

## see https://github.com/moocow-the-bovine/PDL-VectorValued/issues/4
subtest intersect_implicit_dims => sub {

# intersectvec: from ETJ/mowhawk2 a la https://stackoverflow.com/a/71446817/3857002
    my $toto  = pdl( [ 1, 2, 3 ], [ 4, 5, 6 ] );
    my $titi  = pdl( 1, 2, 3 );
    my $notin = pdl( 7, 8, 9 );
    my ($c);

    is_pdl $c = intersectvec( $titi, $toto ), pdl([ [ 1, 2, 3 ] ]),
      'intersectvec - implicit dims - titi&toto';
    is_pdl $c = intersectvec( $notin, $toto ), zeroes( 3, 0 ),
      'intersectvec - implicit dims - notin&toto';
    is_pdl $c = intersectvec( $titi->dummy(1), $toto ), pdl([ [ 1, 2, 3 ] ]),
      'intersectvec - implicit dims - titi(*1)&toto';
    is_pdl $c = intersectvec( $notin->dummy(1), $toto ), zeroes( 3, 0 ),
      'intersectvec - implicit dims - notin(*1)&toto';

    my $needle0_in    = pdl( [ 1, 2, 3 ] );                  # 3
    my $needle0_notin = pdl( [ 9, 9, 9 ] );                  # 3
    my $needle_in     = $needle0_in->dummy(1);               # 3x1: [[1 2 3]]
    my $needle_notin  = $needle0_notin->dummy(1);            # 3x1: [[-3 -2 -1]]
    my $needles       = pdl( [ [ 1, 2, 3 ], [ 9, 9, 9 ] ] )
      ;    # 3x2: $needle0_in->cat($needle0_notin)
    my $haystack = pdl( [ [ 1, 2, 3 ], [ 4, 5, 6 ] ] );    # 3x2

    sub intersect_ok {
        my ( $label, $a, $b, $c_want, $nc_want, $c_sclr_want ) = @_;
        my ( $c, $nc ) = intersectvec( $a, $b );
        my $c_sclr = intersectvec( $a, $b );
        is_pdl $c,      pdl($c_want),      "$label - result";
        is_pdl $nc,     pdl(indx,$nc_want),"$label - counts";
        is_pdl $c_sclr, pdl($c_sclr_want), "$label - scalar";
    }

    intersect_ok(
        'intersectvec - implicit dims - needle0_in&haystack',
        $needle0_in, $haystack, [ [ 1, 2, 3 ] ],
        1, [ [ 1, 2, 3 ] ]
    );
    intersect_ok(
        'intersectvec - implicit dims - needle_in&haystack',
        $needle_in, $haystack, [ [ 1, 2, 3 ] ],
        1, [ [ 1, 2, 3 ] ]
    );

    intersect_ok(
        'intersectvec - implicit dims - needle0_notin&haystack',
        $needle0_notin, $haystack, [ [ 0, 0, 0 ] ],
        0, zeroes( 3, 0 )
    );
    intersect_ok(
        'intersectvec - implicit dims - needle_notin&haystack',
        $needle_notin, $haystack, [ [ 0, 0, 0 ] ],
        0, zeroes( 3, 0 )
    );

    intersect_ok(
        'intersectvec - implicit dims - needles&haystack',
        $needles, $haystack, [ [ 1, 2, 3 ], [ 0, 0, 0 ] ],
        1, [ [ 1, 2, 3 ] ]
    );

    # now we want to know whether each needle is "in" one by one, not really
    # a normal intersect, so we insert a dummy in haystack in order to broadcast
    # the "nc" needs to come back as a 4x2
    my $needles8 = pdl(
        [
            [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 8, 8, 8 ], [ 8, 8, 8 ] ],
            [ [ 4, 5, 6 ], [ 9, 9, 9 ], [ 1, 2, 3 ], [ 9, 9, 9 ] ]
        ]
    );    # 3x4x2

# need to manipulate above into suitable inputs for intersect to get right output
# + dummy dim here also ensures singleton query-vector-sets are (trivially) sorted
    my $needles8x =
      $needles8->slice(",*1,,");   # 3x*x4x2 # dummy of size 1 inserted in dim 1

# haystack: no changes needed; don't need same number of dims, broadcast engine will add dummy/1s at top
    my $haystack8 = $haystack;
    my $c_want8   = [
        [ [ [ 1, 2, 3 ] ], [ [ 4, 5, 6 ] ], [ [ 0, 0, 0 ] ], [ [ 0, 0, 0 ] ] ],
        [ [ [ 4, 5, 6 ] ], [ [ 0, 0, 0 ] ], [ [ 1, 2, 3 ] ], [ [ 0, 0, 0 ] ] ],
    ];
    my $nc_want8 = [ [ 1, 1, 0, 0 ], [ 1, 0, 1, 0 ] ];

    intersect_ok( 'intersectvec - implicit dims - needles8x&haystack8',
        $needles8x, $haystack8, $c_want8, $nc_want8, $c_want8 );
};

## dim-checks and implicit broadcast dimensions
##  + analogous to https://github.com/moocow-the-bovine/PDL-VectorValued/issues/4
subtest v_broadcast_dimensions => sub {

    # data: basic
    my $empty = zeroes(0);
    my $v1_2  = pdl( [ 1, 2 ] );
    my $v3_4  = pdl( [ 3, 4 ] );
    my $v1_4  = $v1_2->cat($v3_4)->flat;

    # data: broadcasting
    my $k      = 2;
    my $kempty = $empty->slice(",*$k");
    my $kv1_2  = $v1_2->slice(",*$k");
    my $kv3_4  = $v3_4->slice(",*$k");
    my $kv1_4  = $v1_4->slice(",*$k");

    #-- union_sorted
    is_pdl scalar( $v1_2->union_sorted($v3_4) ), $v1_4,
      "union_sorted - broadcast dims - 12+34";
    is_pdl scalar( $v3_4->union_sorted($v1_4) ), $v1_4,
      "union_sorted - broadcast dims - 34+1234";
    is_pdl scalar( $empty->union_sorted($v1_4) ), $v1_4,
      "union_sorted - broadcast dims - 0+1234";
    is_pdl scalar( $v1_4->union_sorted($empty) ), $v1_4,
      "union_sorted - broadcast dims - 1234+0";
    is_pdl scalar( $empty->union_sorted($empty) ), $empty,
      "union_sorted - broadcast dims - 0+0";
    #
    is_pdl scalar( $kv1_2->union_sorted($v3_4) ), $kv1_4,
      "union_sorted - broadcast dims - 12(*k)+34";
    is_pdl scalar( $kv3_4->union_sorted($v1_4) ), $kv1_4,
      "union_sorted - broadcast dims - 34(*k)+1234";
    is_pdl scalar( $kempty->union_sorted($v1_4) ), $kv1_4,
      "union_sorted - broadcast dims - 0(*k)+1234";
    is_pdl scalar( $kv1_4->union_sorted($empty) ), $kv1_4,
      "union_sorted - broadcast dims - 1234(*k)+0";
    is_pdl scalar( $kempty->union_sorted($empty) ), $kempty,
      "union_sorted - broadcast dims - 0(*k)+0";

    #-- intersect_sorted
    is_pdl scalar( $v1_2->intersect_sorted($v3_4) ), $empty,
      "intersect_sorted - broadcast dims - 12&34";
    is_pdl scalar( $v3_4->intersect_sorted($v1_4) ), $v3_4,
      "intersect_sorted - broadcast dims - 34&1234";
    is_pdl scalar( $empty->intersect_sorted($v1_4) ), $empty,
      "intersect_sorted - broadcast dims - 0&1234";
    is_pdl scalar( $v1_4->intersect_sorted($empty) ), $empty,
      "intersect_sorted - broadcast dims - 1234&0";
    is_pdl scalar( $empty->intersect_sorted($empty) ), $empty,
      "intersect_sorted - broadcast dims - 0&0";
    #
    is_pdl scalar( $kv1_2->intersect_sorted($v3_4) ), $kempty,
      "intersect_sorted - broadcast dims - 12(*k)&34";
    is_pdl scalar( $kv3_4->intersect_sorted($v1_4) ), $kv3_4,
      "intersect_sorted - broadcast dims - 34(*k)&1234";
    is_pdl scalar( $kempty->intersect_sorted($v1_4) ), $kempty,
      "intersect_sorted - broadcast dims - 0(*k)&1234";
    is_pdl scalar( $kv1_4->intersect_sorted($empty) ), $kempty,
      "intersect_sorted - broadcast dims - 1234(*k)&0";
    is_pdl scalar( $kempty->intersect_sorted($empty) ), $kempty,
      "intersect_sorted - broadcast dims - 0(*k)&0";

    #-- setdiff_sorted
    is_pdl scalar( $v1_2->setdiff_sorted($v3_4) ), $v1_2,
      "setdiff_sorted - broadcast dims - 12-34";
    is_pdl scalar( $v3_4->setdiff_sorted($v1_4) ), $empty,
      "setdiff_sorted - broadcast dims - 34-1234";
    is_pdl scalar( $v1_4->setdiff_sorted($empty) ), $v1_4,
      "setdiff_sorted - broadcast dims - 1234-0";
    is_pdl scalar( $empty->setdiff_sorted($v1_4) ), $empty,
      "setdiff_sorted - broadcast dims - 0-1234";
    is_pdl scalar( $empty->setdiff_sorted($empty) ), $empty,
      "setdiff_sorted - broadcast dims - 0-0";
    #
    is_pdl scalar( $kv1_2->setdiff_sorted($v3_4) ), $kv1_2,
      "setdiff_sorted - broadcast dims - 12(*k)-34";
    is_pdl scalar( $kv3_4->setdiff_sorted($v1_4) ), $kempty,
      "setdiff_sorted - broadcast dims - 34(*k)-1234";
    is_pdl scalar( $kv1_4->setdiff_sorted($empty) ), $kv1_4,
      "setdiff_sorted - broadcast dims - 1234(*k)-0";
    is_pdl scalar( $kempty->setdiff_sorted($v1_4) ), $kempty,
      "setdiff_sorted - broadcast dims - 0(*k)-1234";
    is_pdl scalar( $kempty->setdiff_sorted($empty) ), $kempty,
      "setdiff_sorted - broadcast dims - 0(*k)-0";
};

subtest v_vcos => sub {
  my $a = pdl([[1,2,3,4],[1,2,2,1],[-1,-2,-3,-4]]);
  my $b = pdl([1,2,3,4]);
  my $c_want = pdl([1,0.8660254,-1]);

  ##-- 1..2: vcos: basic
  is_pdl $a->vcos($b), $c_want, {atol=>1e-4, test_name=>"vcos:flat"};
  is_pdl $a->vcos($b->slice(",*3")), $c_want->slice(",*3"), {atol=>1e-4, test_name=>"vcos:broadcasted"};

  ##-- 3: vcos: nullvec: a
  my $a0 = $a->pdl;
  my $nan = $^O =~ /MSWin32/i ? ((99**99)**99) - ((99**99)**99) : 'nan';
  (my $tmp=$a0->slice(",1")) .= 0;
  is_pdl $a0->vcos($b), pdl([1,$nan,-1]), {atol=>1e-4, test_name=>"vcos:nullvec:a:nan"};

  ##-- 4: vcos: nullvec: b
  my $b0 = $b->zeroes;
  ok all($a->vcos($b0)->isfinite->not), "vcos:nullvec:b:all-nan";

  ##-- 5-6: bad values
  my $abad       = $a->pdl->setbadif($a->abs==2);
  my $abad_cwant = pdl([0.93094,0.64549,-0.93094]);
  is_pdl $abad->vcos($b), $abad_cwant, {atol=>1e-4, test_name=>"vcos:bad:a"};

  my $bbad       = $b->pdl->setbadif($b->xvals==2);
  my $bbad_cwant = pdl([0.8366,0.6211,-0.8366]);
  is_pdl $a->vcos($bbad), $bbad_cwant, {atol=>1e-4, test_name=>"vcos:bad:b"};
};

done_testing;

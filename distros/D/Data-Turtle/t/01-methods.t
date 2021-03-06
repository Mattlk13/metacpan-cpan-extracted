#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

use_ok 'Data::Turtle';

my $t = Data::Turtle->new;

$t->forward(10);
my @x = $t->position;
cmp_ok $x[0], '==', 250, 'forward x';
cmp_ok $x[1], '==', 240, 'forward y';

$t->backward(10);
@x = $t->position;
cmp_ok $x[0], '==', 250, 'backward x';
cmp_ok $x[1], '==', 250, 'backward y';

@x = $t->goto( 10, 10 );

cmp_ok $x[0], '==', 250, 'goto x0';
cmp_ok $x[1], '==', 250, 'goto y0';
cmp_ok $x[2], '==', 10, 'goto x';
cmp_ok $x[3], '==', 10, 'goto y';
is $x[4], 'black', 'goto color';
cmp_ok $x[5], '==', 1, 'goto thick';

$t->home;
@x = $t->get_state;

cmp_ok $x[0], '==', 250, 'get_state x';
cmp_ok $x[1], '==', 250, 'get_state y';
cmp_ok $x[2], '==', 270, 'get_state head';
cmp_ok $x[3], '==', 1, 'get_state pen';
is $x[4], 'black', 'get_state color';
cmp_ok $x[5], '==', 1, 'get_state thick';

$t->pen_up;
cmp_ok $t->pen_status, '==', 0, 'pen_up';

$t->pen_down;
cmp_ok $t->pen_status, '==', 1, 'pen_down';

$t->right(45);
cmp_ok $t->heading, '==', 315, 'right';

$t->right(1);
cmp_ok $t->heading, '==', 316, 'right';

$t->left(1);
cmp_ok $t->heading, '==', 315, 'left';

@x = $t->position;
cmp_ok $x[0], '==', 250, 'position x';
cmp_ok $x[1], '==', 250, 'position y';

$t->mirror;
cmp_ok $t->heading, '==', -315, 'mirror';

$t->set_state( 10, 10, 10, 0, 'red', 10 );
@x = $t->get_state;

cmp_ok $x[0], '==', 10, 'set_state x';
cmp_ok $x[1], '==', 10, 'set_state y';
cmp_ok $x[2], '==', 10, 'set_state head';
cmp_ok $x[3], '==', 0, 'set_state pen';
is $x[4], 'red', 'get_state color';
cmp_ok $x[5], '==', 10, 'set_state thick';

done_testing();

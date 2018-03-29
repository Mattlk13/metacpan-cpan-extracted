#!/usr/bin/perl -w

# ICC::Profile::curv test module / 2018-03-27
#
# Copyright © 2004-2018 by William B. Birkett

use strict;

use File::Spec;
use t::lib::Boot;
use Test::More tests => 6;

# local variables
my ($profile, $tag, $temp, $raw1, $raw2);

# does module load
BEGIN { use_ok('ICC::Profile::curv') };

# test class methods
can_ok('ICC::Profile::curv', qw(new new_fh write_fh size inverse derivative transform array sdump));

# make empty curv object
$tag = ICC::Profile::curv->new;

# test object class
isa_ok($tag, 'ICC::Profile::curv');

# read eciRGB_v2 profile
$profile = t::lib::Boot->new(File::Spec->catfile('t', 'data', 'eciRGB_v2.icc'));

# read 'rTRC' tag
$tag = ICC::Profile::curv->new_fh($profile, $profile->fh, $profile->tag_table->[3]);

# test object class
isa_ok($tag, 'ICC::Profile::curv');

# test size method
ok($tag->size == $profile->tag_table->[3][2], 'tag size');

# open temporary file for write-read access
open($temp, '+>' . File::Spec->catfile('t', 'data', 'temp.dat'));

# set binary mode
binmode($temp);

# write tag to temporary file
$tag->write_fh($profile, $temp, $profile->tag_table->[3]);

# read profile raw data
seek($profile->fh, $profile->tag_table->[3][1], 0);
read($profile->fh, $raw1, $tag->size);

# read temporary raw data
seek($temp, $profile->tag_table->[3][1], 0);
read($temp, $raw2, $tag->size);

# test raw data round-trip integrity
ok($raw1 eq $raw2, 'raw data round-trip');

# close profile
close($profile->fh);

# close temporary file
close($temp);

##### more tests needed #####

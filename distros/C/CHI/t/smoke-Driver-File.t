#!perl -w

BEGIN {
  unless ($ENV{AUTOMATED_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for "smoke bot" testing');
  }
}

use CHI::t::Driver::File;
CHI::t::Driver::File->runtests;

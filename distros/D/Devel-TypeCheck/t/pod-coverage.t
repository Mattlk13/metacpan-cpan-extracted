#!perl -T

use Test::More;
eval "use Test::Pod::Coverage 1.04";
plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage" if $@;
plan tests => 1;


pod_coverage_ok( 'Devel::TypeCheck' );

# TODO: All modules will have docs
#all_pod_coverage_ok();

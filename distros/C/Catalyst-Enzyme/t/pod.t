#!perl -T

use Test::More;
use lib "../lib";
(chdir("..") or die) unless(-d "t");

eval "use Test::Pod 1.14";
plan skip_all => "Test::Pod 1.14 required for testing POD" if $@;
all_pod_files_ok();

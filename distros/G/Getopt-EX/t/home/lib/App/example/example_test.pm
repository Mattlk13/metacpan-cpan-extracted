package App::example::example_test;
use strict;
use warnings;
1;

__DATA__

option default --default

option --deprecated $<move(0,0)>
option --ignore-me $<ignore>
option --shift-here --shift-$<shift>
option --exch $<move(1,1)>
option --remove-next $<remove(0,1)>
option --double-next $<copy(0,1)>

define what poison
option --drink-me what

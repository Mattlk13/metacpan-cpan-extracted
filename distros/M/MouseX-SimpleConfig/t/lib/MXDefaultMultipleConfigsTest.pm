#
# This file is part of MouseX-SimpleConfig
#
# This software is copyright (c) 2011 by Infinity Interactive.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use 5.006;
use strict;
use warnings;

package MXDefaultMultipleConfigsTest;
use Mouse;

extends 'MXDefaultConfigTest';

has '+configfile' => ( default => sub { ['test.yaml'] } );

no Mouse;
1;

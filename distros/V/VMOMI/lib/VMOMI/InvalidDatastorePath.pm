package VMOMI::InvalidDatastorePath;
use parent 'VMOMI::InvalidDatastore';

use strict;
use warnings;

our @class_ancestors = ( 
    'InvalidDatastore',
    'VimFault',
    'MethodFault',
);

our @class_members = ( 
    ['datastorePath', undef, 0, ],
);

sub get_class_ancestors {
    return @class_ancestors;
}

sub get_class_members {
    my $class = shift;
    my @super_members = $class->SUPER::get_class_members();
    return (@super_members, @class_members);
}

1;

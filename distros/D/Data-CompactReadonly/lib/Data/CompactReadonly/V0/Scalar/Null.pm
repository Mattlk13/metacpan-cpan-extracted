package Data::CompactReadonly::V0::Scalar::Null;
our $VERSION = '0.0.4';

use warnings;
use strict;
use base 'Data::CompactReadonly::V0::Scalar';

sub _create {
    my($class, %args) = @_;
    my $fh = $args{fh};
    $class->_stash_already_seen(%args);
    print $fh $class->_type_byte_from_class();
    $class->_set_next_free_ptr(%args);
}

sub _init { return undef; }

1;

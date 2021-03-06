package MyClass::Attribute::Test;

use strict;
use warnings;
use base 'Class::Component::Attribute';

sub register {
    my($class, $plugin, $c, $method, $value, $code) = @_;

    no strict 'refs'; 
    no warnings 'redefine';
    my $cname = ref($plugin) or return;
    *{"$cname\::$method"} = sub {
        $code->(@_);
        'attribute return';
    };
}

1;

package next::XS;
use 5.012;
use mro();
use XS::Loader;

our $VERSION = '1.0.4';

{
    local $^W;
    XS::Loader::load();
}

1;

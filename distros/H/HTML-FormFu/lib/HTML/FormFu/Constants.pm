package HTML::FormFu::Constants;

use strict;
use warnings;

our $VERSION = '2.05'; # VERSION

use Readonly;
use Exporter qw( import );

Readonly our $EMPTY_STR => q{};
Readonly our $SPACE     => q{ };

our @EXPORT_OK = qw(
    $EMPTY_STR
    $SPACE
);

1;

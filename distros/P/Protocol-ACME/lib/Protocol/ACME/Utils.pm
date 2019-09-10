package Protocol::ACME::Utils;

use strict;
use warnings;

our $VERSION = '1.02';

sub looks_like_pem
{
  my ($str) = @_;
  return (substr($str, 0, 4) eq '----') ? 1 : 0;
}

1;

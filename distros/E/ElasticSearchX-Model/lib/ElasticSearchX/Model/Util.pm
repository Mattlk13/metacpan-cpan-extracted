#
# This file is part of ElasticSearchX-Model
#
# This software is Copyright (c) 2019 by Moritz Onken.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#
package ElasticSearchX::Model::Util;
$ElasticSearchX::Model::Util::VERSION = '2.0.1';
use strict;
use warnings;

use Digest::SHA;

sub digest {
    my $digest = join( "\0", @_ );
    $digest = Digest::SHA::sha1_base64($digest);
    $digest =~ tr/[+\/]/-_/;
    return $digest;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

ElasticSearchX::Model::Util

=head1 VERSION

version 2.0.1

=head1 AUTHOR

Moritz Onken

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2019 by Moritz Onken.

This is free software, licensed under:

  The (three-clause) BSD License

=cut

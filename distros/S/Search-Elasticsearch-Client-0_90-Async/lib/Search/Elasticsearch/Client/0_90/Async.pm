package Search::Elasticsearch::Client::0_90::Async;

our $VERSION='6.81';
use Search::Elasticsearch::Client::0_90 6.00 ();

1;

=pod

=encoding UTF-8

=head1 NAME

Search::Elasticsearch::Client::0_90::Async - Thin async client with full support for Elasticsearch 2.x APIs

=head1 VERSION

version 6.81

=head1 DESCRIPTION

The L<Search::Elasticsearch::Client::0_90::Async> package provides a client
compatible with Elasticsearch 0.90.x.  It should be used in conjunction
with L<Search::Elasticsearch::Async> as follows:

    $e = Search::Elasticsearch::Async->new(
        client => "0_90::Direct"
    );

See L<Search::Elasticsearch::Client::0_90::Direct> for documentation
about how to use the client itself.

=head1 AUTHOR

Enrico Zimuel <enrico.zimuel@elastic.co>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2020 by Elasticsearch BV.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut

__END__

# ABSTRACT: Thin async client with full support for Elasticsearch 2.x APIs


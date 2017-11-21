package Search::Elasticsearch::Plugin::XPack::6_0;

use Moo::Role;
use namespace::clean;

has 'graph'       => ( is => 'lazy', init_arg => undef );
has 'license'     => ( is => 'lazy', init_arg => undef );
has 'migration'   => ( is => 'lazy', init_arg => undef );
has 'ml'          => ( is => 'lazy', init_arg => undef );
has 'security'    => ( is => 'lazy', init_arg => undef );
has 'watcher'     => ( is => 'lazy', init_arg => undef );

sub _build_graph {
    shift->_build_namespace(
        '+Search::Elasticsearch::Plugin::XPack::6_0::Graph');
}

sub _build_license {
    shift->_build_namespace(
        '+Search::Elasticsearch::Plugin::XPack::6_0::License');
}

sub _build_migration {
    shift->_build_namespace(
        '+Search::Elasticsearch::Plugin::XPack::6_0::Migration');
}

sub _build_ml {
    shift->_build_namespace('+Search::Elasticsearch::Plugin::XPack::6_0::ML');
}

sub _build_security {
    shift->_build_namespace(
        '+Search::Elasticsearch::Plugin::XPack::6_0::Security');
}

sub _build_watcher {
    shift->_build_namespace(
        '+Search::Elasticsearch::Plugin::XPack::6_0::Watcher');
}

1;

# ABSTRACT: Plugin providing XPack APIs for Search::Elasticsearch v6.x

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::Elasticsearch::Plugin::XPack::6_0 - Plugin providing XPack APIs for Search::Elasticsearch v6.x

=head1 VERSION

version 6.00

=head1 SYNOPSIS

    use Search::Elasticsearch();

    my $es = Search::Elasticsearch->new(
        nodes   => \@nodes,
        plugins => ['XPack']
    );

    $es->xpack->graph;
    $es->xpack->license;
    $es->xpack->security;
    $es->xpack->watcher;

=head2 DESCRIPTION

This class extends the L<Search::Elasticsearch> client to add support
for the X-Pack commercial plugins for Elasticsearch 6.x.

It extends the L<Search::Elasticsearch> client with a C<graph>, C<license>, C<migration>, C<ml>,
C<security>, and C<watcher> namespace, to support the APIs for the X-Pack plugins:
Graph, License, Shield, and Watcher.

In other words, it can be used as follows:

    use Search::Elasticsearch();
    my $es = Search::Elasticsearch->new(
        nodes   => \@nodes,
        plugins => ['XPack']
    );

    my $response = $es->xpack->watcher->start();

For details about the supported methods in each namespace, see:

=over

=item *

L<graph()/Search::Elasticsearch::Plugin::XPack::6_0::Graph>

=item *

L<license()/Search::Elasticsearch::Plugin::XPack::6_0::License>

=item *

L<shield()/Search::Elasticsearch::Plugin::XPack::6_0::Migration>

=item *

L<shield()/Search::Elasticsearch::Plugin::XPack::6_0::ML>

=item *

L<shield()/Search::Elasticsearch::Plugin::XPack::6_0::Security>

=item *

L<watcher()/Search::Elasticsearch::Plugin::XPack::6_0::Watcher>

=back

=head1 AUTHOR

Clinton Gormley <drtech@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2017 by Elasticsearch BV.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut

# Licensed to Elasticsearch B.V. under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Elasticsearch B.V. licenses this file to you under
# the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

package Search::Elasticsearch::Client::8_0::Direct::Fleet;
$Search::Elasticsearch::Client::8_0::Direct::Fleet::VERSION = '8.00';
use Moo;
with 'Search::Elasticsearch::Client::8_0::Role::API';
with 'Search::Elasticsearch::Role::Client::Direct';
use namespace::clean;

__PACKAGE__->_install_api('fleet');

1;

=pod

=encoding UTF-8

=head1 NAME

Search::Elasticsearch::Client::8_0::Direct::Fleet - Fleet APIs for Search::Elasticsearch 8.x

=head1 VERSION

version 8.00

=head1 SYNOPSIS

    my $response = $es->fleet->search(...);

=head2 DESCRIPTION

This class extends the L<Search::Elasticsearch> client with a C<fleet>
namespace, to support the API for the
L<Fleet|https://www.elastic.co/guide/en/elasticsearch/reference/current/fleet-apis.html> plugin for Elasticsearch.

=head1 METHODS

The full documentation for the Fleet plugin is available here:
L<https://www.elastic.co/guide/en/elasticsearch/reference/current/fleet-apis.html>

=head1 AUTHOR

Enrico Zimuel <enrico.zimuel@elastic.co>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2022 by Elasticsearch BV.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut

__END__

# ABSTRACT: Fleet APIs for Search::Elasticsearch 8.x

The following APIs support Fleet’s use of Elasticsearch as a data store for internal
agent and action data. These APIs are experimental and for internal use by Fleet only.


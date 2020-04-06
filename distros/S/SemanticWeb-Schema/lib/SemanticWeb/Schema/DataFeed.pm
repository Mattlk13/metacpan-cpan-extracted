use utf8;

package SemanticWeb::Schema::DataFeed;

# ABSTRACT: A single feed providing structured information about one or more entities or topics.

use Moo;

extends qw/ SemanticWeb::Schema::Dataset /;


use MooX::JSON_LD 'DataFeed';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v7.0.3';


has data_feed_element => (
    is        => 'rw',
    predicate => '_has_data_feed_element',
    json_ld   => 'dataFeedElement',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::DataFeed - A single feed providing structured information about one or more entities or topics.

=head1 VERSION

version v7.0.3

=head1 DESCRIPTION

A single feed providing structured information about one or more entities
or topics.

=head1 ATTRIBUTES

=head2 C<data_feed_element>

C<dataFeedElement>

An item within in a data feed. Data feeds may have many elements.

A data_feed_element should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::DataFeedItem']>

=item C<InstanceOf['SemanticWeb::Schema::Thing']>

=item C<Str>

=back

=head2 C<_has_data_feed_element>

A predicate for the L</data_feed_element> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::Dataset>

=head1 SOURCE

The development version is on github at L<https://github.com/robrwo/SemanticWeb-Schema>
and may be cloned from L<git://github.com/robrwo/SemanticWeb-Schema.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/robrwo/SemanticWeb-Schema/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018-2020 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

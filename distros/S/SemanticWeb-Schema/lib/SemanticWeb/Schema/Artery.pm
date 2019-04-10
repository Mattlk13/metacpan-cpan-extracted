use utf8;

package SemanticWeb::Schema::Artery;

# ABSTRACT: A type of blood vessel that specifically carries blood away from the heart.

use Moo;

extends qw/ SemanticWeb::Schema::Vessel /;


use MooX::JSON_LD 'Artery';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v3.5.0';


has arterial_branch => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'arterialBranch',
);



has source => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'source',
);



has supply_to => (
    is        => 'rw',
    predicate => 1,
    json_ld   => 'supplyTo',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::Artery - A type of blood vessel that specifically carries blood away from the heart.

=head1 VERSION

version v3.5.0

=head1 DESCRIPTION

A type of blood vessel that specifically carries blood away from the heart.

=head1 ATTRIBUTES

=head2 C<arterial_branch>

C<arterialBranch>

The branches that comprise the arterial structure.

A arterial_branch should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::AnatomicalStructure']>

=back

=head2 C<source>

The anatomical or organ system that the artery originates from.

A source should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::AnatomicalStructure']>

=back

=head2 C<supply_to>

C<supplyTo>

The area to which the artery supplies blood.

A supply_to should be one of the following types:

=over

=item C<InstanceOf['SemanticWeb::Schema::AnatomicalStructure']>

=back

=head1 SEE ALSO

L<SemanticWeb::Schema::Vessel>

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

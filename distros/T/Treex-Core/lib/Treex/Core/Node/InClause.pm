package Treex::Core::Node::InClause;
$Treex::Core::Node::InClause::VERSION = '2.20160630';
use Moose::Role;

# with Moose >= 2.00, this must be present also in roles
use MooseX::SemiAffordanceAccessor;
use Treex::Core::Log;
use List::Util qw(first);    # TODO: this wouldn't be needed if there was Treex::Core::Common for roles

has clause_number => (
    is            => 'rw',
    isa           => 'Maybe[Int]',
    documentation => 'ordinal number that is shared by all nodes of a clause',
);

has is_clause_head => (
    is            => 'rw',
    isa           => 'Bool',
    documentation => 'Is this node a head of a finite clause?',
);

sub get_clause_root {
    log_fatal 'Incorrect number of arguments' if @_ != 1;
    my $self      = shift;
    my $my_number = $self->clause_number;
    log_warn( 'Attribute clause_number not defined in ' . $self->id ) if !defined $my_number;
    return $self if !$my_number;

    my $highest = $self;
    my $parent  = $self->get_parent();
    while ( $parent && ( $parent->clause_number || 0 ) == $my_number ) {
        $highest = $parent;
        $parent  = $parent->get_parent();
    }
    if ( $parent && !$highest->is_member && $parent->is_coap_root() ) {
        my $eff_parent = first { $_->is_member && ( $_->clause_number || 0 ) == $my_number } $parent->get_children();
        return $eff_parent if $eff_parent;
    }
    return $highest;
}

# Clauses may by split in more subtrees ("Peter eats and drinks.")
sub get_clause_nodes {
    log_fatal 'Incorrect number of arguments' if @_ != 1;
    my $self        = shift;
    my $root        = $self->get_root();
    my @descendants = $root->get_descendants( { ordered => 1 } );
    my $my_number   = $self->clause_number;
    return grep { ( $_->clause_number || '' ) eq $my_number } @descendants;
}

# TODO: same purpose as get_clause_root but instead of clause_number uses is_clause_head
sub get_clause_head {
    log_fatal 'Incorrect number of arguments' if @_ != 1;
    my $self = shift;
    my $node = $self;
    while ( !$node->is_clause_head && $node->get_parent() ) {
        $node = $node->get_parent();
    }
    return $node;
}

sub get_clause_ehead {
    log_fatal 'Incorrect number of arguments' if @_ != 1;
    my $self = shift;
    return $self if $self->is_clause_head;
    my ($node) = $self->get_eparents( { or_topological => 1 } );
    while ( !$node->is_clause_head && $node->get_parent() ) {
        $node = $node->get_parent();
    }
    return $node;
}

# Alternative API could be: $node->get_descendants({within_clause=>1});
sub get_clause_descendants {
    log_fatal 'Incorrect number of arguments' if @_ != 1;
    my $self = shift;

    my @clause_children = grep { !$_->is_clause_head } $self->get_children();
    return ( @clause_children, map { $_->get_clause_descendants() } @clause_children );
}

# A variant of the previous, using effective children instead of children.
sub get_clause_edescendants {
    log_fatal 'Incorrect number of arguments' if @_ != 1;
    my $self = shift;

    my @clause_children = grep { !$_->is_clause_head } $self->get_echildren({or_topological=>1});

    # we can use normal get_clause_descendants here, using echildren would no longer make any difference
    return ( @clause_children, map { $_->get_clause_descendants() } @clause_children );
}

1;

__END__

=encoding utf-8

=head1 NAME

Treex::Core::Node::InClause

=head1 VERSION

version 2.20160630

=head1 DESCRIPTION

Moose role for nodes in trees where (linguistic) clauses can be recognized
based on attributes C<clause_number> and C<is_clause_head>.

=head1 ATTRIBUTES

=over

=item clause_number

Ordinal number that is shared by all nodes of a same clause.

=item is_clause_head

Is this node a head of a finite clause.

=back

=head1 METHODS

=over

=item my $clause_head_node = $node->get_clause_root();

Returns the head node of a clause.
This implementation is based on the attribute C<clause_number>.
Note that it may give different results than C<get_clause_head>. 

=item $clause_head_node = $node->get_clause_head();

Returns the head node of a clause.
This implementation is based on the attribute C<is_clause_head>.
Note that it may give different results than C<get_clause_root>.

=item $clause_head_node = $node->get_clause_ehead();

Returns the (first) effective head node of a clause. 
Same as previous, but based on the effective parent relation.

=item my @nodes = $node->get_clause_descendants();

Returns those descendants which are in the same clause as C<$node>.
The current implementation is based on the attribute C<is_clause_head>.

=item my @nodes = $node->get_clause_edescendants();

Same as previous, but using the effective children relation.

=item my @nodes = $node->get_clause_nodes();

Returns all nodes of the clause (to which the C<$node> belongs).
The current implementation is based on the attribute C<clause_number>.

=back


=head1 AUTHOR

Martin Popel <popel@ufal.mff.cuni.cz>

=head1 COPYRIGHT AND LICENSE

Copyright © 2011 by Institute of Formal and Applied Linguistics, Charles University in Prague

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

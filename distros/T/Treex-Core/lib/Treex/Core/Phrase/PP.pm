package Treex::Core::Phrase::PP;
$Treex::Core::Phrase::PP::VERSION = '2.20201228';
use utf8;
use namespace::autoclean;

use Moose;
use Treex::Core::Log;

extends 'Treex::Core::Phrase::BaseNTerm';



has 'fun' =>
(
    is       => 'rw',
    isa      => 'Treex::Core::Phrase',
    required => 1,
    writer   => '_set_fun',
    reader   => 'fun'
);

has 'arg' =>
(
    is       => 'rw',
    isa      => 'Treex::Core::Phrase',
    required => 1,
    writer   => '_set_arg',
    reader   => 'arg'
);

has 'fun_is_head' =>
(
    is       => 'rw',
    isa      => 'Bool',
    required => 1
);

has 'deprel_at_fun' =>
(
    is       => 'rw',
    isa      => 'Bool',
    required => 1,
    documentation =>
        'Where (at what core child) is the label of the relation between this '.
        'phrase and its parent? It is either at the function word or at the '.
        'argument, regardless which of them is the head.'
);

has 'core_deprel' =>
(
    is       => 'rw',
    isa      => 'Str',
    required => 1,
    default  => 'case', # mark, AuxP, PrepArg
    documentation =>
        'The deprel that does not describe the relation of the PP to its parent. '.
        'There are always two important relations in PPs, one of them is reachable via '.
        '$self->deprel() and the other via $self->core_deprel(). '.
        'In Prague treebanks, the PP is headed by preposition but the parent '.
        'relation (indicated by deprel) is labeled at the argument. The label of the preposition '.
        '(indicated by core_deprel) is always AuxP. In Universal Dependencies, '.
        'the PP is headed by the argument which also bears the deprel '.
        'of the parent relation. The preposition is attached to the argument and '.
        'its label (indicated by core_deprel) is case or mark. '.
        'Other treebanks may have the preposition as both the head and the parent-deprel bearer, '.
        'while the argument would be attached as PrepArg (indicated by core_deprel). '
);



#------------------------------------------------------------------------------
# After the object is constructed, this block makes sure that the core children
# refer back to it as their parent.
#------------------------------------------------------------------------------
sub BUILD
{
    my $self = shift;
    if(defined($self->fun()->parent()) || defined($self->arg()->parent()))
    {
        log_fatal("The core child already has another parent");
    }
    $self->fun()->_set_parent($self);
    $self->arg()->_set_parent($self);
}



#------------------------------------------------------------------------------
# Returns the head child of the phrase. Depending on the current preference,
# it is either the function word or its argument.
#------------------------------------------------------------------------------
sub head
{
    my $self = shift;
    log_fatal('Dead') if($self->dead());
    return $self->fun_is_head() ? $self->fun() : $self->arg();
}



#------------------------------------------------------------------------------
# Returns the list of non-head children of the phrase, i.e. the dependents plus
# either the function word or the argument (whichever is currently not the head).
#------------------------------------------------------------------------------
sub nonhead_children
{
    my $self = shift;
    log_fatal('Dead') if($self->dead());
    my @children = (($self->fun_is_head() ? $self->arg() : $self->fun()), $self->dependents());
    return $self->_order_required(@_) ? $self->order_phrases(@children) : @children;
}



#------------------------------------------------------------------------------
# Returns the list of the children of the phrase that are not dependents, i.e.
# both the function word and the argument.
#------------------------------------------------------------------------------
sub core_children
{
    my $self = shift;
    log_fatal('Dead') if($self->dead());
    my @children = ($self->fun(), $self->arg());
    return $self->_order_required(@_) ? $self->order_phrases(@children) : @children;
}



#------------------------------------------------------------------------------
# A shortcut to the attributes.
#------------------------------------------------------------------------------
sub deprel_at_head
{
    my $self = shift;
    return ($self->fun_is_head() && $self->deprel_at_fun()) || (!$self->fun_is_head() && !$self->deprel_at_fun());
}



#------------------------------------------------------------------------------
# Returns the type of the dependency relation of the phrase to the governing
# phrase. A prepositional phrase has the same deprel as one of its core
# children. Depending on the current preference it is either the function word or
# the argument. This is not necessarily the same child that is the current
# head. For example, in the Prague annotation style, the preposition is head
# but its deprel is always 'AuxP' while the real deprel of the whole phrase is
# stored at the argument.
#------------------------------------------------------------------------------
sub deprel
{
    my $self = shift;
    log_fatal('Dead') if($self->dead());
    return $self->deprel_at_fun() ? $self->fun()->deprel() : $self->arg()->deprel();
}



#------------------------------------------------------------------------------
# Sets a new type of the dependency relation of the phrase to the governing
# phrase. For PPs the label is propagated to one of the core children.
# Depending on the current preference it is either the function word or the
# argument. This is not necessarily the same child that is the current head.
# The label is not propagated to the underlying dependency tree
# (the project_dependencies() method would have to be called to achieve that).
#------------------------------------------------------------------------------
sub set_deprel
{
    my $self = shift;
    log_fatal('Dead') if($self->dead());
    if($self->deprel_at_fun())
    {
        $self->fun()->set_deprel(@_);
        $self->arg()->set_deprel($self->core_deprel());
    }
    else
    {
        $self->arg()->set_deprel(@_);
        $self->fun()->set_deprel($self->core_deprel());
    }
}



#------------------------------------------------------------------------------
# Returns the deprel that should be used when the phrase tree is projected back
# to a dependency tree (see the method project_dependencies()). In most cases
# this is identical to what deprel() returns. However, for instance
# prepositional phrases in Prague treebanks are attached using AuxP. Their
# relation to the parent (returned by deprel()) is projected to the argument of
# the preposition.
#------------------------------------------------------------------------------
sub project_deprel
{
    my $self = shift;
    log_fatal('Dead') if($self->dead());
    # fun_is_head  && deprel_at_fun  => project_deprel == deprel      # many treebanks
    # fun_is_head  && !deprel_at_fun => project_deprel == core_deprel # Prague style
    # !fun_is_head && !deprel_at_fun => project_deprel == deprel      # UD style
    # !fun_is_head && deprel_at_fun  => project_deprel == core_deprel # not used anywhere
    # Here we always return the project_deprel of the head phrase. If our main deprel is not at the head
    # (and thus the head deprel / project deprel is the core_deprel, e.g. 'AuxP'), we have to trust the
    # previous code that the head deprel has been set and maintained correctly. We cannot just return the
    # core_deprel here. If the head is not a normal phrase (e.g. if it is a coordination of prepositions),
    # then the core deprel may be buried deeper and the actual projected deprel may be Coord, not AuxP!
    # In consequence, the only difference between this implementation of project_deprel() and
    # that of the ancestor class BaseNTerm is currently this comment.
    return $self->head()->project_deprel();
}



#------------------------------------------------------------------------------
# Replaces one of the core children (function word or argument) by another
# phrase. This is used when we want to transform the child to a different class
# of phrase. The replacement must not have a parent yet.
#------------------------------------------------------------------------------
sub replace_core_child
{
    my $self = shift;
    my $old_child = shift; # Treex::Core::Phrase
    my $new_child = shift; # Treex::Core::Phrase
    log_fatal('Dead') if($self->dead());
    $self->_check_old_new_child($old_child, $new_child);
    $old_child->_set_parent(undef);
    $new_child->_set_parent($self);
    if($old_child == $self->fun())
    {
        $self->_set_fun($new_child);
    }
    elsif($old_child == $self->arg())
    {
        $self->_set_arg($new_child);
    }
    else
    {
        log_fatal("The child to be replaced is not in my core");
    }
}



#------------------------------------------------------------------------------
# Returns a textual representation of the phrase and all subphrases. Useful for
# debugging.
#------------------------------------------------------------------------------
sub as_string
{
    my $self = shift;
    my $fun = 'FUN '.$self->fun()->as_string();
    my $arg = 'ARG '.$self->arg()->as_string();
    my @dependents = $self->dependents('ordered' => 1);
    my $deps = join(', ', map {$_->as_string()} (@dependents));
    $deps = 'DEPS '.$deps if($deps);
    my $subtree = join(' ', ($fun, $arg, $deps));
    $subtree .= ' _M' if($self->is_member());
    return "(PP $subtree)";
}



__PACKAGE__->meta->make_immutable();

1;



=for Pod::Coverage BUILD

=encoding utf-8

=head1 NAME

Treex::Core::Phrase::PP

=head1 VERSION

version 2.20201228

=head1 SYNOPSIS

  use Treex::Core::Document;
  use Treex::Core::Phrase::Term;
  use Treex::Core::Phrase::PP;

  my $document = new Treex::Core::Document;
  my $bundle   = $document->create_bundle();
  my $zone     = $bundle->create_zone('en');
  my $root     = $zone->create_atree();
  my $prep     = $root->create_child();
  my $noun     = $prep->create_child();
  $prep->set_deprel('AuxP');
  $noun->set_deprel('Adv');
  my $prepphr  = new Treex::Core::Phrase::Term ('node' => $prep);
  my $argphr   = new Treex::Core::Phrase::Term ('node' => $noun);
  my $pphrase  = new Treex::Core::Phrase::PP ('fun' => $prepphr, 'arg' => $argphr, 'fun_is_head' => 1);

=head1 DESCRIPTION

C<Phrase::PP> (standing for I<prepositional phrase>) is a special case of
C<Phrase::NTerm>. The model example is a preposition (possibly compound) and
its argument (typically a noun phrase), plus possible dependents of the whole,
such as emphasizers or punctuation. However, it can be also used for
subordinating conjunctions plus relative clauses, or for any pair of a function
word and its (one) argument.

While we know the two key children (let's call them the preposition and the
argument), we do not take for fixed which one of them is the head (but the head
is indeed one of these two, and not any other child). Depending on the
preferred annotation style, we can pick the preposition or the argument as the
current head.

=head1 ATTRIBUTES

=over

=item fun

A sub-C<Phrase> of this phrase that contains the preposition (or another
function word if this is not a true prepositional phrase).

=item arg

A sub-C<Phrase> (typically a noun phrase) of this phrase that contains the
argument of the preposition (or of the other function word if this is not
a true prepositional phrase).

=item fun_is_head

Boolean attribute that defines the currently preferred annotation style.
C<True> means that the function word is considered the head of the phrase.
C<False> means that the argument is the head.

=item deprel_at_fun

Where (at what core child) is the label of the relation between this phrase and
its parent? It is either at the function word or at the argument, regardless
which of them is the head.

=item core_deprel

The deprel that does not describe the relation of the PP to its parent. There
are always two important relations in PPs, one of them is reachable via
deprel() and the other via core_deprel(). In Prague treebanks, the PP is headed
by preposition but the parent relation (indicated by deprel) is labeled at the
argument. The label of the preposition (indicated by core_deprel) is always
C<AuxP>. In Universal Dependencies, the PP is headed by the argument which also
bears the deprel of the parent relation. The preposition is attached to the
argument and its label (indicated by core_deprel) is C<case> or C<mark>. Other
treebanks may have the preposition as both the head and the parent-deprel
bearer, while the argument would be attached as PrepArg (indicated by
core_deprel).

=back

=head1 METHODS

=over

=item head

A sub-C<Phrase> of this phrase that is at the moment considered the head phrase
(in the sense of dependency syntax).
Depending on the current preference, it is either the function word or its
argument.

=item nonhead_children

Returns the list of non-head children of the phrase, i.e. the dependents plus either
the function word or the argument (whichever is currently not the head).

=item core_children

Returns the list of the children of the phrase that are not dependents, i.e. both the
function word and the argument.

=item deprel

Returns the type of the dependency relation of the phrase to the governing
phrase. A prepositional phrase has the same deprel as one of its core
children. Depending on the current preference it is either the function word or
the argument. This is not necessarily the same child that is the current
head. For example, in the Prague annotation style, the preposition is head
but its deprel is always C<AuxP> while the real deprel of the whole phrase is
stored at the argument.

=item set_deprel

Sets a new type of the dependency relation of the phrase to the governing
phrase. For PPs the label is propagated to one of the core children.
Depending on the current preference it is either the function word or the
argument. This is not necessarily the same child that is the current head.
The label is not propagated to the underlying dependency tree
(the project_dependencies() method would have to be called to achieve that).

=item project_deprel

Returns the deprel that should be used when the phrase tree is projected back
to a dependency tree (see the method project_dependencies()). In most cases
this is identical to what deprel() returns. However, for instance
prepositional phrases in Prague treebanks are attached using C<AuxP>. Their
relation to the parent (returned by deprel()) is projected as the label of
the dependency between the preposition and its argument.

=item replace_core_child

Replaces one of the core children (function word or argument) by another
phrase. This is used when we want to transform the child to a different class
of phrase. The replacement must not have a parent yet.

=item as_string

Returns a textual representation of the phrase and all subphrases. Useful for
debugging.

=back

=head1 AUTHORS

Daniel Zeman <zeman@ufal.mff.cuni.cz>

=head1 COPYRIGHT AND LICENSE

Copyright © 2013, 2015 by Institute of Formal and Applied Linguistics, Charles University in Prague
This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

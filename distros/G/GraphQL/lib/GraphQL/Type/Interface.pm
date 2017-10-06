package GraphQL::Type::Interface;

use 5.014;
use strict;
use warnings;
use Moo;
use Types::Standard qw(CodeRef);
extends qw(GraphQL::Type);
with qw(
  GraphQL::Role::Output
  GraphQL::Role::Composite
  GraphQL::Role::Abstract
  GraphQL::Role::Nullable
  GraphQL::Role::Named
  GraphQL::Role::FieldsOutput
);

our $VERSION = '0.02';

=head1 NAME

GraphQL::Type::Interface - GraphQL interface type

=head1 SYNOPSIS

  use GraphQL::Type::Interface;
  my $ImplementingType;
  my $InterfaceType = GraphQL::Type::Interface->new(
    name => 'Interface',
    fields => { field_name => { type => $scalar_type } },
    resolve_type => sub {
      return $ImplementingType;
    },
  );

=head1 ATTRIBUTES

Has C<name>, C<description> from L<GraphQL::Role::Named>.
Has C<fields> from L<GraphQL::Role::FieldsOutput>.

=head2 resolve_type

Optional code-ref to resolve types.

=cut

has resolve_type => (is => 'ro', isa => CodeRef);

__PACKAGE__->meta->make_immutable();

1;

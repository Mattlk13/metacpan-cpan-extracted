package GraphQL::Schema;

use 5.014;
use strict;
use warnings;
use Moo;
use Types::Standard -all;
use GraphQL::Type::Library -all;
use Return::Type;
use Function::Parameters;
use GraphQL::Debug qw(_debug);
use GraphQL::Directive;
use GraphQL::Introspection qw($SCHEMA_META_TYPE);

our $VERSION = '0.02';
use constant DEBUG => $ENV{GRAPHQL_DEBUG};

=head1 NAME

GraphQL::Schema - GraphQL schema object

=head1 SYNOPSIS

  use GraphQL::Schema;
  use GraphQL::Type::Object;
  my $schema = GraphQL::Schema->new(
    query => GraphQL::Type::Object->new(
      name => 'Query',
      fields => {
        getObject => {
          type => $interfaceType,
          resolve => sub {
            return {};
          }
        }
      }
    )
  );

=head1 DESCRIPTION

Class implementing GraphQL schema.

=head1 ATTRIBUTES

=head2 query

=cut

has query => (is => 'ro', isa => InstanceOf['GraphQL::Type::Object'], required => 1);

=head2 mutation

=cut

has mutation => (is => 'ro', isa => InstanceOf['GraphQL::Type::Object']);

=head2 subscription

=cut

has subscription => (is => 'ro', isa => InstanceOf['GraphQL::Type::Object']);

=head2 types

=cut

has types => (
  is => 'ro',
  isa => ArrayRef[ConsumerOf['GraphQL::Role::Named']],
  default => sub { [] },
);

=head2 directives

=cut

has directives => (
  is => 'ro',
  isa => ArrayRef[InstanceOf['GraphQL::Directive']],
  default => sub { \@GraphQL::Directive::SPECIFIED_DIRECTIVES },
);

=head1 METHODS

=head2 name2type

In this schema, returns a hash-ref mapping all types' names to their
type object.

=cut

has name2type => (is => 'lazy', isa => Map[StrNameValid, ConsumerOf['GraphQL::Role::Named']]);
sub _build_name2type {
  my ($self) = @_;
  my @types = grep $_, (map $self->$_, qw(query mutation subscription)), $SCHEMA_META_TYPE;
  push @types, @{ $self->types || [] };
  my %name2type;
  map _expand_type(\%name2type, $_), @types;
  \%name2type;
}

=head2 get_possible_types($abstract_type)

In this schema, get all of either the implementation types
(if interface) or possible types (if union) of the C<$abstract_type>.

=cut

fun _expand_type(
  (Map[StrNameValid, ConsumerOf['GraphQL::Role::Named']]) $map,
  (InstanceOf['GraphQL::Type']) $type,
) :ReturnType(ArrayRef[ConsumerOf['GraphQL::Role::Named']]) {
  return _expand_type($map, $type->of) if $type->can('of');
  my $name = $type->name if $type->can('name');
  return [] if $name and $map->{$name} and $map->{$name} == $type; # seen
  die "Duplicate type $name" if $map->{$name};
  $map->{$name} = $type;
  my @types;
  push @types, ($type, map @{ _expand_type($map, $_) }, @{ $type->interfaces || [] })
    if $type->isa('GraphQL::Type::Object');
  push @types, ($type, map @{ _expand_type($map, $_) }, @{ $type->get_types })
    if $type->isa('GraphQL::Type::Union');
  if (grep $type->DOES($_), qw(GraphQL::Role::FieldsInput GraphQL::Role::FieldsOutput)) {
    my $fields = $type->fields||{};
    push @types, map {
      map @{ _expand_type($map, $_->{type}) }, $_, values %{ $_->{args}||{} }
    } values %$fields;
  }
  DEBUG and _debug('_expand_type', \@types);
  \@types;
}

has _interface2types => (is => 'lazy', isa => Map[StrNameValid, ArrayRef[InstanceOf['GraphQL::Type::Object']]]);
sub _build__interface2types {
  my ($self) = @_;
  my $name2type = $self->name2type||{};
  my %interface2types;
  map {
    my $o = $_;
    map {
      push @{$interface2types{$_->name}}, $o;
      # TODO assert_object_implements_interface
    } @{ $o->interfaces||[] };
  } grep $_->isa('GraphQL::Type::Object'), values %$name2type;
  \%interface2types;
}

method get_possible_types(
  (ConsumerOf['GraphQL::Role::Abstract']) $abstract_type
) :ReturnType(ArrayRef[InstanceOf['GraphQL::Type::Object']]) {
  return $abstract_type->get_types if $abstract_type->isa('GraphQL::Type::Union');
  $self->_interface2types->{$abstract_type->name} || [];
}

=head2 is_possible_type($abstract_type, $possible_type)

In this schema, is the given C<$possible_type> either an implementation
(if interface) or a possibility (if union) of the C<$abstract_type>?

=cut

has _possible_type_map => (is => 'rw', isa => Map[StrNameValid, Map[StrNameValid, Bool]]);
method is_possible_type(
  (ConsumerOf['GraphQL::Role::Abstract']) $abstract_type,
  (InstanceOf['GraphQL::Type::Object']) $possible_type,
) :ReturnType(Bool) {
  my $map = $self->_possible_type_map || {};
  return $map->{$abstract_type->name}{$possible_type->name}
    if $map->{$abstract_type->name}; # we know about the abstract_type
  my @possibles = @{ $self->get_possible_types($abstract_type)||[] };
  die <<EOF if !@possibles;
Could not find possible implementing types for @{[$abstract_type->name]}
in schema. Check that schema.types is defined and is an array of
all possible types in the schema.
EOF
  $map->{$abstract_type->name} = { map { ($_->name => 1) } @possibles };
  $self->_possible_type_map($map);
  $map->{$abstract_type->name}{$possible_type->name};
}

=head2 assert_object_implements_interface($type, $iface)

In this schema, does the given C<$type> implement interface C<$iface>? If
not, throw exception.

=cut

method assert_object_implements_interface(
  (ConsumerOf['GraphQL::Role::Abstract']) $abstract_type,
  (InstanceOf['GraphQL::Type::Object']) $possible_type,
) {
  my @types = @{ $self->types };
  return;
}

__PACKAGE__->meta->make_immutable();

1;

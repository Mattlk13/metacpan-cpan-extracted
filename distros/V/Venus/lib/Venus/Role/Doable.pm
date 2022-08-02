package Venus::Role::Doable;

use 5.018;

use strict;
use warnings;

use Venus::Role 'with';

# METHODS

sub do {
  my ($self, $code, @args) = @_;

  $code ||= sub{};

  local $_ = $self;
  $self->$code(@args);

  return $self;
}

# EXPORTS

sub EXPORT {
  ['do']
}

1;



=head1 NAME

Venus::Role::Doable - Doable Role

=cut

=head1 ABSTRACT

Doable Role for Perl 5

=cut

=head1 SYNOPSIS

  package Example;

  use Venus::Class;

  with 'Venus::Role::Doable';

  attr 'time';

  sub execute {
    return;
  }

  package main;

  my $example = Example->new;

  # $example->do(time => time)->execute;

=cut

=head1 DESCRIPTION

This package modifies the consuming package and provides methods for chaining
any chainable and non-chainable methods (by ignoring their return values).

=cut

=head1 METHODS

This package provides the following methods:

=cut

=head2 do

  do(Str | CodeRef $method, Any @args) (Self)

The do method dispatches the method call or executes the callback and returns
the invocant. This method supports dispatching, i.e. providing a method name
and arguments whose return value will be acted on by this method.

I<Since C<0.01>>

=over 4

=item do example 1

  package main;

  my $example = Example->new;

  $example = $example->do(time => time);

  # bless({ time => 0000000000 }, "Example")

  # $example->execute;

=back

=cut
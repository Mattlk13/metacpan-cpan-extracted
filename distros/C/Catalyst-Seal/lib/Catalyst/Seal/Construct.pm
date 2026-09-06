package Catalyst::Seal::Construct;

use strict;
use warnings;

use Scalar::Util ();

use Catalyst::Seal ();
use Catalyst::Seal::Guard ();

our $VERSION = '0.04';

my %EMPTY;
my %DECIDED;

sub _clear { %EMPTY = (); %DECIDED = (); return }
sub empty_classes { scalar keys %EMPTY }

sub _stock_controller_build {
    my $orig = $Catalyst::Seal::Guard::ORIGINAL{'Catalyst::Controller::BUILD'};
    return $orig;
}

sub _controller_build {
    my ($self, $args) = @_;

    my $class = ref $self;
    my $plain = !exists $args->{action} && !exists $args->{actions};

    if ($plain && $EMPTY{$class}) {
        $self->{actions}                 = {};
        $self->{_all_actions_attributes} = {};
        $self->{_action_roles}           = [];
        return;
    }

    my $orig = _stock_controller_build() or return;
    $orig->($self, $args);

    return unless $plain;
    return if $DECIDED{$class}++;

    my $actions = $self->{actions};
    my $attrs   = $self->{_all_actions_attributes};
    my $roles   = $self->{_action_roles};

    $EMPTY{$class} = 1
        if ref $actions eq 'HASH'  && !keys %$actions
        && ref $attrs   eq 'HASH'  && !keys %$attrs
        && ref $roles   eq 'ARRAY' && !@$roles;

    return;
}

our %LAZY_STATS;

my %STATS_ORIG;

sub _make_stats_reader {
    my ($class) = @_;
    my $orig = $class->can('stats') or return;
    $STATS_ORIG{$class} = $orig;

    return sub {
        my $self = shift;
        return $orig->($self, @_) if @_;

        my $v = $self->{stats};
        return $v if defined $v;

        my $stats = $self->stats_class->new;
        $stats->enable($self->use_stats);
        return $self->{stats} = $stats;
    };
}

use constant {
    D_NONE  => 0,
    D_CONST => 1,
    D_HASH  => 2,
    D_ARRAY => 3,
    D_CODE  => 4,
};

use constant {
    A_GUARDED  => 1,
    A_REQUIRED => 2,
    A_WEAK     => 4,
    A_TYPED    => 8,
};

sub _default_kind {
    my ($attr) = @_;

    return (D_NONE, undef) unless $attr->has_default;

    my $d = $attr->default;
    return (D_CONST, $d) unless ref $d eq 'CODE';

    my ($one, $two) = (eval { $d->() }, eval { $d->() });
    return (D_CODE, $d) if $@;

    for my $pair ([ 'HASH', D_HASH ], [ 'ARRAY', D_ARRAY ]) {
        my ($type, $kind) = @$pair;
        next unless ref $one eq $type && ref $two eq $type;
        next if Scalar::Util::blessed($one) || Scalar::Util::blessed($two);
        next if Scalar::Util::refaddr($one) == Scalar::Util::refaddr($two);
        next if $type eq 'HASH'  && keys %$one;
        next if $type eq 'ARRAY' && @$one;
        return ($kind, undef);
    }

    return (D_CODE, $d);
}

sub _ctor_attr {
    my ($attr) = @_;

    my @slots = $attr->slots;
    return undef unless @slots == 1 && $slots[0] eq $attr->name;
    return undef if $attr->has_initializer;

    my ($kind, $default) = $attr->is_lazy ? (D_NONE, undef) : _default_kind($attr);

    my $flags = 0;
    my $check;
    $flags |= A_WEAK if $attr->is_weak_ref;

    if ($attr->has_trigger || $attr->should_coerce) {
        $flags |= A_GUARDED;
    }
    elsif ($attr->has_type_constraint) {
        my $tc = $attr->type_constraint;
        $check = eval { $tc->_compiled_type_constraint };
        $check = sub { $tc->check($_[0]) } unless ref $check eq 'CODE';
        $flags |= A_TYPED;
    }

    $flags |= A_REQUIRED
        if $attr->is_required && !$attr->has_default && !$attr->has_builder;

    if ($kind == D_NONE && !$attr->is_lazy && $attr->has_builder) {
        return undef;
    }

    if ($kind != D_NONE && $attr->has_type_constraint) {
        return undef if $kind == D_CODE;
        my $tc = $attr->type_constraint;
        my $probe = $kind == D_CONST ? $default
                  : $kind == D_HASH  ? {}
                  :                    [];
        return undef unless eval { $tc->check($probe) };
    }

    my $init = $attr->init_arg;
    return [ $init, $attr->name, $kind, $default, $flags, $check ];
}

my %CTOR;

sub sealed_constructors { sort keys %CTOR }

sub stock_constructor { $CTOR{ $_[0] } }

sub _unseal_constructors {
    my $undone = 0;
    for my $class (sort keys %CTOR) {
        my $orig = delete $CTOR{$class};
        no strict 'refs';
        no warnings 'redefine';
        *{"${class}::new"} = $orig;
        Catalyst::Seal::note("$class\::new un-sealed, a BUILD changed after seal");
        $undone++;
    }
    return $undone;
}

sub _seal_constructor {
    my ($class) = @_;

    return 0 if $CTOR{$class};

    my $meta = Class::MOP::class_of($class)                 or return 0;
    return 0 unless $meta->isa('Class::MOP::Class');
    unless ($meta->is_immutable) {
        Catalyst::Seal::note("$class is mutable, its constructor was not sealed");
        return 0;
    }
    return 0 unless $meta->instance_metaclass->isa('Class::MOP::Instance');

    my $orig = $class->can('new') or return 0;

    my @attrs;
    for my $attr ($meta->get_all_attributes) {
        my $row = _ctor_attr($attr);
        unless ($row) {
            Catalyst::Seal::note(
                "$class\::new not sealed: " . $attr->name . ' is not describable');
            return 0;
        }
        push @attrs, $row;
    }

    my @builds;
    for my $cl (reverse $meta->linearized_isa) {
        no strict 'refs';
        my $code = *{"${cl}::BUILD"}{CODE} or next;
        push @builds, $code;
    }

    my $buildargs = $class->can('BUILDARGS');
    $buildargs = undef
        if $buildargs && $buildargs == Moose::Object->can('BUILDARGS');

    my $ok = eval {
        no warnings 'redefine';
        Catalyst::Seal::_install_ctor(
            $class, 'new', $orig, $buildargs, \@attrs, \@builds);
        1;
    };
    unless ($ok) {
        Catalyst::Seal::note("could not seal $class\::new: $@");
        return 0;
    }

    $CTOR{$class} = $orig;
    return 1;
}

sub _constructor_classes {
    my ($app) = @_;

    my @classes = ($app->context_class || $app);
    push @classes, eval { $app->composed_request_class }  || ();
    push @classes, eval { $app->composed_response_class } || ();

    my %seen;
    return grep { !$seen{$_}++ } grep { defined && length } @classes;
}

my $PATCHED = 0;

Catalyst::Seal::register_step('construct' => sub {
    my ($app) = @_;

    require Class::MOP;
    require Moose::Object;

    my $build = 0;
    unless ($PATCHED++) {
        $build = Catalyst::Seal::Guard::replace(
            'Catalyst::Controller::BUILD' => \&_controller_build);
    }

    my $ctx = $app->context_class || $app;
    my $stats = 0;
    if (my $reader = _make_stats_reader($ctx)) {
        my $ok = eval {
            no strict 'refs';
            no warnings 'redefine';
            *{"${ctx}::stats"} = $reader;
            1;
        };
        if ($ok) {
            $LAZY_STATS{$ctx} = 1;
            $stats = 1;
        }
        else {
            Catalyst::Seal::note("could not install a lazy stats reader on $ctx: $@");
        }
    }

    my $ctors = 0;
    $ctors += _seal_constructor($_) for _constructor_classes($app);

    Catalyst::Seal::note(
        "construct: controller-build=$build stats-lazy=$stats constructors=$ctors")
        if $Catalyst::Seal::DEBUG;
    return;
});

1;

__END__

=head1 NAME

Catalyst::Seal::Construct - two things built per request that need not be

=head1 DESCRIPTION

=head2 A controller's BUILD on the context object

The application class's linearized ISA is

    MyApp, Catalyst, Catalyst::Component, Moose::Object, Catalyst::Controller

so the per-request context object inherits C<Catalyst::Controller::BUILD>, and
C<BUILDALL> runs it on a throwaway object every request:

    my $attr_value = $self->merge_config_hashes($actions, $action);
    $self->_controller_actions($attr_value);
    $self->_all_actions_attributes;   # trigger lazy builder
    $self->_action_roles;             # trigger lazy builder

Two lazy builders fired to compute values derived from class data that stopped
changing at C<setup_finalize>. 17.5 us per request inclusive.

The memo here is deliberately narrow. It runs the stock body once per class, and
remembers the class only when all three results came out empty, which is the
case for a context object built with no arguments. Then it stores *fresh* empty
containers into each new instance rather than sharing the remembered ones: a
shared C<actions> hash that something wrote to would leak between requests, and
C<_build__all_actions_attributes> deletes a key from that hash as it goes.

Anything else, including a real controller being configured at setup with
C<action> or C<actions> arguments, takes the stock body.

=head2 A Stats object built when stats are off

C<prepare> does

    $c->stats($class->stats_class->new)->enable($c->use_stats);

unconditionally, and C<Catalyst::Stats> has C<tree> as a required, non-lazy
attribute defaulting to C<Tree::Simple-E<gt>new({t =E<gt> [gettimeofday]})>. So
a tree is built and the clock read on every request for an object that, with
stats disabled, nothing reads again.

With stats enabled this changes nothing: the object is constructed eagerly, at
the same point, because the timestamp in that default is the request start and
deferring it would move the elapsed time that gets reported.

With stats disabled the construction is deferred to the first read of
C<$c-E<gt>stats>, which usually never comes. It is not shared between requests:
a request calling C<$c-E<gt>stats-E<gt>enable(1)> would otherwise profile into a
tree that outlives it and grows for the life of the worker.

=cut

=head2 The constructors

Three objects are built per request - the context, the request and the response
- and Moose's inlined constructor asks the same questions of the same
attributes every time. Best of five, in nanoseconds:

                            stock     here
    Catalyst::Request->new   2373     1010
    Catalyst::Response->new  1914     1016
    MyApp->new               3764     2275
    bless {} (the floor)      292

The template is resolved once, at seal time: which key each attribute reads,
whether it has a default and whether that default is a value, an empty
container or a code reference to call, and which attributes Moose would do more
than a store for.

A default that is C<sub { {} }> or C<sub { [] }> is made in C. That is decided
by making two of them and looking - two distinct empty containers of the same
kind - rather than by reading the code, because what matters is what the
default produces and not how it is spelled.

=head3 What goes the long way

The escape hatch is the whole safety argument, and it is taken before anything
is built, so there is never a half-built instance to hand over.

=over 4

=item * A value passed for an attribute with a B<trigger> or a B<coercion>.
Both do something beyond storing, and a store that skipped them would be a
different operation.

=item * A value passed for a B<typed> attribute that fails the constraint's own
check. One that passes is stored here - C<data_handlers> is typed and is passed
on every single request, and delegating on that alone would leave the request
constructor never once taken. A value that fails goes to Moose, which raises
the error it would have raised anyway and words it as Moose words it.

=item * A B<required> attribute with no default and no builder, absent.

=item * A B<subclass> created after the seal, an odd argument list, or an
C<__INSTANCE__> to build into.

=back

A weak attribute is stored and then weakened, which is what Moose does, and
C<_log> on the request is the one that matters: a strong copy there would hold
the application's logger through every request object that ever referred to it.

=head3 The BUILD methods are pinned

The bodies C<BUILDALL> would call are resolved when the constructor is sealed,
which is exactly what Moose's own inlined constructor does and for the same
reason. They are read out of the stash rather than out of the metaclass,
because half of this distribution installs a replacement by assigning a glob -
the controller C<BUILD> above is one - and that is what C<BUILDALL> would find.

A modifier landing on a C<BUILD> afterwards makes the pinned set wrong, so
every sealed constructor is given back at that point rather than kept. A C<BUILD>
added to a class that had none is not noticed, which is the same contract Moose
offers: it would want C<make_immutable> run again too.

=cut

=head1 AUTHOR

LNATION <email@lnation.org>

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2026 by LNATION <email@lnation.org>.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

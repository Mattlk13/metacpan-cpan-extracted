package Catalyst::Seal::Execute;

use strict;
use warnings;

use Carp ();
use Scalar::Util ();

use Catalyst::Seal ();
use Catalyst::Seal::Guard ();

our $VERSION = '0.04';

sub _plain_slot {
    my ($class, $name, %want) = @_;

    my $meta = Class::MOP::class_of($class)                      or return 0;
    return 0 unless $meta->isa('Class::MOP::Class');
    return 0 unless $meta->is_immutable;

    my $im = $meta->instance_metaclass;
    return 0 unless $im->isa('Class::MOP::Instance');

    my $attr = $meta->find_attribute_by_name($name)              or return 0;

    my @slots = $attr->slots;
    return 0 unless @slots == 1 && $slots[0] eq $name;

    return 0 if $attr->is_lazy;
    return 0 if $attr->has_type_constraint;
    return 0 if $attr->has_trigger;
    return 0 if $attr->should_coerce;
    return 0 if $attr->is_weak_ref;
    return 0 if $attr->has_initializer;

    if ($want{write}) {
        my $w = $attr->get_write_method;
        return 0 unless defined $w;
    }

    return 1;
}

sub _execute {
    my ( $c, $class, $code ) = @_;
    $class = $c->component($class) || $class;

    my $stack = $c->{stack};

    if ( @$stack >= $Catalyst::RECURSION ) {
        my $action = $code->reverse();
        $action = "/$action" unless $action =~ /->/;
        my $error = qq/Deep recursion detected calling "${action}"/;
        $c->log->error($error);
        $c->error($error);
        $c->{state} = 0;
        return $c->{state};
    }

    push @$stack, $code;

    no warnings 'recursion';
    eval {
        my $ret = $code->execute( $class, $c, @{ $c->{request}{arguments} } ) || 0;
        $c->{state} = $ret;
    };

    my $last = pop @$stack;

    if ( my $error = $@ ) {
        if ( $c->_handle_http_exception($error) ) {
            foreach my $err (@{ $c->error }) {
                $c->log->error($err);
            }
            $c->clear_errors;
            $c->log->_flush if $c->log->can('_flush');

            $error->can('rethrow') ? $error->rethrow : Carp::croak $error;
        }
        if ( Scalar::Util::blessed($error)
             and $error->isa('Catalyst::Exception::Detach') ) {
            $error->rethrow if @$stack > 1;
        }
        elsif ( Scalar::Util::blessed($error)
                and $error->isa('Catalyst::Exception::Go') ) {
            $error->rethrow if @$stack > 0;
        }
        else {
            unless ( ref $error ) {
                no warnings 'uninitialized';
                chomp $error;
                my $class = $last->class;
                my $name  = $last->name;
                $error = qq/Caught exception in $class->$name "$error"/;
            }
            $c->error($error);
        }
    }
    return $c->{state};
}

sub _execute_stats {
    my ( $c, $class, $code ) = @_;
    $class = $c->component($class) || $class;

    my $stack = $c->{stack};

    if ( @$stack >= $Catalyst::RECURSION ) {
        my $action = $code->reverse();
        $action = "/$action" unless $action =~ /->/;
        my $error = qq/Deep recursion detected calling "${action}"/;
        $c->log->error($error);
        $c->error($error);
        $c->{state} = 0;
        return $c->{state};
    }

    my $stats_info = $c->_stats_start_execute( $code );

    push @$stack, $code;

    no warnings 'recursion';
    eval {
        my $ret = $code->execute( $class, $c, @{ $c->{request}{arguments} } ) || 0;
        $c->{state} = $ret;
    };

    $c->_stats_finish_execute( $stats_info ) if $stats_info;

    my $last = pop @$stack;

    if ( my $error = $@ ) {
        if ( $c->_handle_http_exception($error) ) {
            foreach my $err (@{ $c->error }) {
                $c->log->error($err);
            }
            $c->clear_errors;
            $c->log->_flush if $c->log->can('_flush');

            $error->can('rethrow') ? $error->rethrow : Carp::croak $error;
        }
        if ( Scalar::Util::blessed($error)
             and $error->isa('Catalyst::Exception::Detach') ) {
            $error->rethrow if @$stack > 1;
        }
        elsif ( Scalar::Util::blessed($error)
                and $error->isa('Catalyst::Exception::Go') ) {
            $error->rethrow if @$stack > 0;
        }
        else {
            unless ( ref $error ) {
                no warnings 'uninitialized';
                chomp $error;
                my $class = $last->class;
                my $name  = $last->name;
                $error = qq/Caught exception in $class->$name "$error"/;
            }
            $c->error($error);
        }
    }
    return $c->{state};
}

sub _seal_execute {
    my ($app) = @_;

    my $ctx = $app->context_class || $app;
    my $req = eval { $app->composed_request_class } || $app->request_class;

    unless (_plain_slot($ctx, 'stack')
            && _plain_slot($ctx, 'state', write => 1)
            && _plain_slot($req, 'arguments')) {
        Catalyst::Seal::note(
            'execute not hoisted: stack, state or arguments is not a plain slot');
        return 0;
    }

    my $stats = eval { $app->use_stats } ? 1 : 0;

    return Catalyst::Seal::Guard::replace(
        'Catalyst::execute' => $stats ? \&_execute_stats : \&_execute);
}

sub _seal_use_stats {
    my ($app) = @_;

    my $ctx  = $app->context_class || $app;
    my $orig = $ctx->can('use_stats') or return 0;

    my $value = eval { $app->use_stats };
    if ($@) {
        Catalyst::Seal::note("could not resolve use_stats, not sealed: $@");
        return 0;
    }

    my $ok = eval {
        no warnings 'redefine';
        Catalyst::Seal::_install_const($ctx, 'use_stats', $value, $orig, undef);
        1;
    };
    unless ($ok) {
        Catalyst::Seal::note("could not seal use_stats: $@");
        return 0;
    }
    return 1;
}

sub _seal_depth {
    my ($app) = @_;

    my $ctx = $app->context_class || $app;
    return 0 unless _plain_slot($ctx, 'stack');

    my $orig = $ctx->can('depth') or return 0;

    my $ok = eval {
        no warnings 'redefine';
        Catalyst::Seal::_install_count($ctx, 'depth', 'stack', $orig);
        1;
    };
    unless ($ok) {
        Catalyst::Seal::note("could not seal depth: $@");
        return 0;
    }
    return 1;
}

my @ACTION_SLOTS = qw(code instance class);

sub _seal_actions {
    my ($app) = @_;

    my $class = 'Catalyst::Action';
    my $meta  = Class::MOP::class_of($class) or return 0;
    return 0 unless $meta->isa('Class::MOP::Class');

    for my $slot (@ACTION_SLOTS) {
        next if _plain_slot($class, $slot);
        Catalyst::Seal::note(
            "Catalyst::Action::$slot is not a plain slot, the action pair was not sealed");
        return 0;
    }

    my $sealed = 0;
    for my $name (qw(execute dispatch)) {
        my $method = $meta->get_method($name) or next;
        if ($method->isa('Class::MOP::Method::Wrapped')) {
            Catalyst::Seal::note("Catalyst::Action::$name is wrapped, not sealed");
            next;
        }

        my $body      = $method->body                or next;
        my $installed = $class->can($name)           or next;
        next unless $installed == $body;

        my $ok = eval {
            no warnings 'redefine';
            Catalyst::Seal::_install_action(
                $class, $name, $name, 'code', 'instance', 'class', $body);
            1;
        };
        unless ($ok) {
            Catalyst::Seal::note("could not seal Catalyst::Action::$name: $@");
            next;
        }
        $sealed++;
    }

    return $sealed;
}

my $PATCHED = 0;

Catalyst::Seal::register_step('execute' => sub {
    my ($app) = @_;

    require Class::MOP;

    my $stats = _seal_use_stats($app);
    my $depth = _seal_depth($app);

    my ($execute, $actions) = (0, 0);
    unless ($PATCHED++) {
        $execute = _seal_execute($app);
        $actions = _seal_actions($app);
    }

    Catalyst::Seal::note(
        "execute: hoisted=$execute actions=$actions use_stats=$stats depth=$depth")
        if $Catalyst::Seal::DEBUG;
    return;
});

1;

__END__

=head1 NAME

Catalyst::Seal::Execute - the nine executions a request makes

=head1 DESCRIPTION

A request that reaches one action executes nine times: the private C<_BEGIN>,
C<_AUTO>, C<_ACTION> and C<_END> steps, the action itself, and the forwards
between them. Each of those goes through C<Catalyst::execute>,
C<Catalyst::Action::dispatch> and C<Catalyst::Action::execute>, and between
them those three spend most of their time reaching values through accessors.

=head2 execute

The stock body calls C<depth>, C<use_stats> twice, C<stack> twice, C<req>,
C<args>, and writes and reads C<state> - nine accessor calls, nine times a
request, before any of them has done anything. They are all reads of a plain
hash slot on an immutable class, so this reads the slot.

Worth about 5 us a request. Nothing else about the body changes: the recursion
guard, the C<detach> and C<go> rethrows, the C<_handle_http_exception> path and
the exact wording of a caught exception are the stock ones.

The two C<use_stats> calls are gone from the common body rather than answered
more cheaply, because C<setup_stats> has already decided the answer by the time
this runs. An application with stats on gets a body that keeps them.

A slot is only read directly where the metaclass says it is a plain one: stored
in a hash under its own name, not lazy, and with no type constraint, coercion,
trigger, weak reference or initializer for the accessor to apply and a slot read
to miss. Anything else and the stock C<execute> stays.

=cut

=head2 use_stats and depth

C<use_stats> is C<sub use_stats { 0 }>, or the C<sub { 1 }> that C<setup_stats>
installs when stats are on. Twenty calls a request, to something setup decided;
it becomes the same XS constant the class data uses.

C<depth> is C<scalar @{ shift->stack || [] }> - a method call to reach a method
call to count an array - nine times a request. It becomes an XSUB that counts
the array in the slot. An absent or undefined slot is 0, which is what the
stock body's C<|| []> says; anything that is not an array reference delegates.

=cut

=head2 Catalyst::Action::execute and ::dispatch

    sub execute  { my $self = shift; $self->code->(@_) }
    sub dispatch { $_[0]->has_instance ? $_[1]->execute($_[0]->instance, $_[0])
                                       : $_[1]->execute($_[0]->class,    $_[0]) }

Five accessor frames between them, nine times each a request, to reach two
calls that are a hash fetch. Both become XSUBs that fetch the slot and make the
call.

C<dispatch> asks for the C<instance> slot the way Moose's C<has_instance>
predicate does, by presence and not by definedness, and calls C<execute> on the
context as a method rather than as a resolved body, so a plugin's C<execute> is
found exactly as the stock code would find it.

Neither XSUB checks the invocant's class. Every action class is a
C<Catalyst::Action> subclass and one that did not override the method is
precisely who should arrive here; an invocant with no such slot delegates to
the body that was there before, so a wrong caller gets the stock error rather
than a wrong answer. A role that wrapped either method leaves a
C<Class::MOP::Method::Wrapped> in the stash, and neither is sealed then.

=cut

=head1 AUTHOR

LNATION <email@lnation.org>

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2026 by LNATION <email@lnation.org>.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

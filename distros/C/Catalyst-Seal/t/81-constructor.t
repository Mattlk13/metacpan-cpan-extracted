#!/usr/bin/env perl
use strict;
use warnings;

use FindBin ();
use lib "$FindBin::Bin/lib";

use Test::More;
use Scalar::Util ();

BEGIN { $ENV{CATALYST_DEBUG} = 0; $ENV{CATALYST_SEAL} = 1 }

require SealTest;
require TestApp;
my $app = TestApp->psgi_app;

my @CLASSES = ('TestApp', 'Catalyst::Request', 'Catalyst::Response');

is_deeply([Catalyst::Seal::Construct::sealed_constructors()],
          [sort @CLASSES],
          'the three per-request constructors were sealed');

sub counts { return Catalyst::Seal::_ctor_counts($_[0]->can('new')) }

# An installed XSUB that never answers a construction is indistinguishable
# from one that works, so every claim below is paired with the count.
{
    my %before = map { $_ => [ counts($_) ] } @CLASSES;
    SealTest::response($app, PATH_INFO => '/');
    for my $class (@CLASSES) {
        my @after = counts($class);
        cmp_ok($after[0], '>', $before{$class}[0],
               "$class: a request went through the sealed constructor");
        is($after[1], $before{$class}[1],
           "$class: ... and nothing was handed to the stock one");
    }
}

# ---- the same object, built both ways --------------------------------------
#
# The strongest thing that can be asked of a constructor replacement, and it
# does not require this test to know what any of these attributes mean.

sub built_both_ways {
    my ($class, @args) = @_;
    my $stock = Catalyst::Seal::Construct::stock_constructor($class);
    return ($class->new(@args), $stock->($class, @args));
}

{
    my %args = (env => SealTest::env(), _log => TestApp->log);
    my ($xs, $stock) = built_both_ways('Catalyst::Request', \%args);

    is_deeply([sort keys %$xs], [sort keys %$stock],
              'a sealed request has exactly the slots the stock one has');

    for my $k (sort keys %$stock) {
        is(ref $xs->{$k}, ref $stock->{$k}, "Catalyst::Request: $k is the same kind");
        next if ref $stock->{$k};
        is($xs->{$k}, $stock->{$k}, "Catalyst::Request: $k has the same value");
    }

    # A weak reference has to come out weak. _log is the one that is, and a
    # strong copy would keep the application's logger alive through every
    # request object that ever referred to it.
    ok(Scalar::Util::isweak($xs->{_log}), 'a weak attribute is still weak');
    ok(Scalar::Util::isweak($stock->{_log}), '...as it is in the stock one');
}

{
    my ($xs, $stock) = built_both_ways('Catalyst::Response');
    is_deeply([sort keys %$xs], [sort keys %$stock],
              'a sealed response has exactly the slots the stock one has');
    is($xs->{status}, $stock->{status}, 'a constant default is the same');
    is(ref $xs->{cookies}, ref $stock->{cookies}, 'a container default is the same kind');
}

{
    my ($xs, $stock) = built_both_ways('TestApp', {});
    is_deeply([sort keys %$xs], [sort keys %$stock],
              'a sealed context has exactly the slots the stock one has');
    is($xs->{state}, $stock->{state}, 'and the same state');
}

# ---- fresh containers, not shared ------------------------------------------

{
    my $one = Catalyst::Request->new(env => {}, _log => TestApp->log);
    my $two = Catalyst::Request->new(env => {}, _log => TestApp->log);
    isnt(Scalar::Util::refaddr($one->{arguments}),
         Scalar::Util::refaddr($two->{arguments}),
         'each instance gets its own container default');
    push @{ $one->{arguments} }, 'x';
    is(scalar @{ $two->{arguments} }, 0, '...so writing to one does not reach the other');
}

# ---- what the fast path refuses --------------------------------------------

# A typed attribute is asked of its own constraint. `data_handlers` is one, and
# every request passes it, so this is the ordinary path and not a corner.
{
    my ($before_fast, $before_slow) = counts('Catalyst::Request');
    my $req = Catalyst::Request->new(
        env => {}, _log => TestApp->log, data_handlers => { a => sub { 1 } });
    my ($after_fast, $after_slow) = counts('Catalyst::Request');
    is($after_fast, $before_fast + 1, 'a typed value that passes its check is stored here');
    is($after_slow, $before_slow, '...without the stock constructor');
    is(ref $req->{data_handlers}, 'HASH', 'and the value arrived');
}

# A value that fails takes the long way, which is the point: the error is
# Moose's, raised where Moose raises it and worded as Moose words it.
{
    my ($before_fast, $before_slow) = counts('Catalyst::Request');
    my $ok = eval { Catalyst::Request->new(
        env => {}, _log => TestApp->log, data_handlers => 'not a hashref'); 1 };
    my (undef, $after_slow) = counts('Catalyst::Request');
    ok(!$ok, 'a value that fails its type constraint still dies');
    like($@, qr/data_handlers/, '...naming the attribute');
    is($after_slow, $before_slow + 1, '...from the stock constructor');
}

# A required attribute with nothing to fall back on.
{
    my $ok = eval { Catalyst::Request->new(env => {}); 1 };
    ok(!$ok, 'a missing required attribute still dies');
    like($@, qr/_log/, '...naming the attribute');
}

# An odd-length argument list is Moose's error to describe.
{
    my ($before_fast, $before_slow) = counts('Catalyst::Response');
    eval { Catalyst::Response->new('lonely') };
    my (undef, $after_slow) = counts('Catalyst::Response');
    is($after_slow, $before_slow + 1, 'an odd argument list takes the long way');
}

# A subclass created after the seal inherits the XSUB but not the template.
{
    package SealTest::Response::Sub;
    our @ISA = ('Catalyst::Response');
}
{
    my ($before_fast, $before_slow) = counts('Catalyst::Response');
    my $sub = SealTest::Response::Sub->new;
    my ($after_fast, $after_slow) = counts('Catalyst::Response');
    isa_ok($sub, 'SealTest::Response::Sub');
    is($after_slow, $before_slow + 1, 'a subclass takes the long way');
    is($after_fast, $before_fast, '...and is not handed its parent\'s template');
}

# ---- a BUILD that changes after the seal -----------------------------------
#
# The bodies BUILDALL would run are pinned when the constructor is sealed,
# which is what Moose's own inlined constructor does too. A modifier landing on
# one afterwards makes the pinned set wrong, so the sealed constructors are
# given back rather than kept.

{
    my @before = Catalyst::Seal::Construct::sealed_constructors();
    ok(scalar @before, 'constructors are sealed before the modifier');

    # The path every modifier addition goes through, whichever door it came
    # in by - the same one t/42-modifier-late.t uses.
    my $wrapped = Class::MOP::class_of('Catalyst::Response')->get_method('BUILD');
    isa_ok($wrapped, 'Class::MOP::Method::Wrapped');
    $wrapped->add_before_modifier(sub { });

    my @after = Catalyst::Seal::Construct::sealed_constructors();
    is(scalar @after, 0, 'a modifier on a BUILD un-seals every constructor');

    my $res = Catalyst::Response->new;
    isa_ok($res, 'Catalyst::Response');
    is($res->status, 200, '...and the stock constructor still builds one');
}

done_testing;

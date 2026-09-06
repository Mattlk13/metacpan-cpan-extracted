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

# ---- what was installed ----------------------------------------------------

ok(Catalyst->can('execute') == \&Catalyst::Seal::Execute::_execute,
   'execute was hoisted');
ok(Catalyst::Seal::_is_sealed(Catalyst::Action->can('execute')),
   'Catalyst::Action::execute is the XSUB');
ok(Catalyst::Seal::_is_sealed(Catalyst::Action->can('dispatch')),
   'Catalyst::Action::dispatch is the XSUB');
ok(Catalyst::Seal::_is_sealed(TestApp->can('depth')), 'depth is the XSUB');
ok(Catalyst::Seal::_is_sealed(TestApp->can('use_stats')),
   'use_stats is a constant');

# ---- depth answers what the stock body answered ----------------------------

my $depth = TestApp->can('depth');
is($depth->(bless { stack => [] },        'TestApp'), 0, 'depth of an empty stack');
is($depth->(bless { stack => [1, 2, 3] }, 'TestApp'), 3, 'depth of three');

# `scalar @{ shift->stack || [] }`: the stock body answers 0 for both of these
# rather than dying, and so must this.
is($depth->(bless { stack => undef }, 'TestApp'), 0, 'depth of an undef stack');
is($depth->(bless {},                 'TestApp'), 0, 'depth of no stack at all');

# An invocant that is not one of ours goes to the body that was there before.
# This one answers, which is how the delegation is visible: the stock body is
# `scalar @{ shift->stack || [] }` and reaches a stack this XSUB never looked
# at, because the slot it would have read is not the one holding it.
{
    # 'once': the glob is assigned here and never named again, because
    # everything that reaches it does so by method dispatch.
    no strict 'refs';
    no warnings 'once';
    *SealTest::NotTheApp::stack = sub { [1, 2] };
    my $other = bless { elsewhere => [1, 2, 3] }, 'SealTest::NotTheApp';
    is($depth->($other), 2,
       'a foreign invocant is answered by the stock body, not by us');
}

# ---- use_stats is still false, and still a method --------------------------

is(TestApp->use_stats, 0, 'use_stats as a class method');
is(TestApp->new->use_stats, 0, 'use_stats on an instance');

# ---- the action pair -------------------------------------------------------

# Catalyst::Action overloads stringification to its `reverse`, so every action
# built here carries one - without it a failure diagnostic is an empty string.
sub action {
    my (%slots) = @_;
    return bless { name => 'fake', reverse => 'fake', %slots }, 'Catalyst::Action';
}

my $action = action(
    code  => sub { return "code(@_[1 .. $#_])" },
    class => 'The::Class',
);

is(Catalyst::Action::execute($action, 'ctl', 'ctx', 'a', 'b'),
   'code(ctx a b)',
   'Action::execute passes everything but the invocant to the code');

# has_instance is Moose's predicate: it asks whether the slot is there, not
# whether it holds something. An instance explicitly set to undef is still an
# instance as far as dispatch is concerned.
{
    my @seen;
    my $ctx = bless {}, 'SealTest::Ctx';
    no strict 'refs';
    no warnings 'once';
    *SealTest::Ctx::execute = sub { shift; @seen = @_; return 'executed' };

    my $with = action(class => 'C', instance => 'I');
    is(Catalyst::Action::dispatch($with, $ctx), 'executed',
       'dispatch returns what execute returned');
    is($seen[0], 'I', '...and passed the instance when the slot is there');

    my $without = action(class => 'C');
    Catalyst::Action::dispatch($without, $ctx);
    is($seen[0], 'C', '...and the class when it is not');

    my $held_undef = action(class => 'C', instance => undef);
    Catalyst::Action::dispatch($held_undef, $ctx);
    is(Scalar::Util::refaddr($seen[1]), Scalar::Util::refaddr($held_undef),
       'dispatch passes the action itself as the second argument');
    ok(!defined $seen[0], 'an instance slot holding undef is still an instance');

    # A list-context call must not leave the stack short or long.
    my @list = Catalyst::Action::dispatch($with, $ctx);
    is_deeply(\@list, ['executed'], 'dispatch in list context returns one value');
}

# An invocant with no code slot delegates, so the error is the stock one -
# raised from Catalyst::Action itself rather than from here.
{
    my $ok = eval { Catalyst::Action::execute(action(), 1); 1 };
    ok(!$ok, 'an action with no code slot dies rather than returning nothing');
    like($@, qr/Catalyst\/Action\.pm/,
         '...raised by the body that was there before');
}

# ---- and the application still answers -------------------------------------

my $res = SealTest::response($app, PATH_INFO => '/');
is($res->[0], 200, 'a request still gets a response');
is(join('', @{ $res->[2] }), 'hello', '...with the right body');

my $chain = SealTest::response($app, PATH_INFO => '/steps/ok');
like(join('', @{ $chain->[2] }), qr/begin/,
     'the private chain still runs through the hoisted execute');

done_testing;

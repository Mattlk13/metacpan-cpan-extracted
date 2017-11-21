use Mojo::Base -strict;

BEGIN { $ENV{MOJO_REACTOR} = 'Mojo::Reactor::Poll' }

use Test::More;

use Mojolicious::Lite;
use Mojo::SQLite;
use Test::Mojo;

my $sql = Mojo::SQLite->new;
plugin Minion => {SQLite => $sql};

app->minion->add_task(test => sub { });
my $finished = app->minion->enqueue('test');
app->minion->perform_jobs;
my $inactive = app->minion->enqueue('test');
get '/home' => 'test_home';

plugin 'Minion::Admin';

my $t = Test::Mojo->new;

# Dashboard
$t->get_ok('/minion')->status_is(200)->content_like(qr/Dashboard/)
  ->element_exists('a[href=/]');

# Stats
$t->get_ok('/minion/stats')->status_is(200)->json_is('/finished_jobs' => 1)
  ->json_is('/inactive_jobs' => 1)->json_is('/delayed_jobs' => 0);

# Jobs
$t->get_ok('/minion/jobs?state=inactive')->status_is(200)
  ->text_like('tbody td a' => qr/$inactive/)
  ->text_unlike('tbody td a' => qr/$finished/);
$t->get_ok('/minion/jobs?state=finished')->status_is(200)
  ->text_like('tbody td a' => qr/$finished/)
  ->text_unlike('tbody td a' => qr/$inactive/);

# Workers
$t->get_ok('/minion/workers')->status_is(200)->element_exists_not('tbody td a');
my $worker = app->minion->worker->register;
$t->get_ok('/minion/workers')->status_is(200)->element_exists('tbody td a')
  ->text_like('tbody td a' => qr/@{[$worker->id]}/);
$worker->unregister;
$t->get_ok('/minion/workers')->status_is(200)->element_exists_not('tbody td a');

# Manage jobs
is app->minion->job($finished)->info->{state}, 'finished', 'right state';
$t->post_ok('/minion/jobs' => form => {id => $finished, do => 'retry'})
  ->status_is(302)->header_like(Location => qr/id=$finished/);
is app->minion->job($finished)->info->{state}, 'inactive', 'right state';
$t->post_ok('/minion/jobs' => form => {id => $finished, do => 'remove'})
  ->status_is(302)->header_like(Location => qr/id=$finished/);
is app->minion->job($finished), undef, 'job has been removed';

# Different prefix and return route
plugin 'Minion::Admin' =>
  {route => app->routes->any('/also_minion'), return_to => 'test_home'};
$t->get_ok('/also_minion')->status_is(200)->content_like(qr/Dashboard/)
  ->element_exists('a[href=/home]');

done_testing();

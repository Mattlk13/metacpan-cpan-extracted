#!/usr/bin/perl
use strict;
use warnings;
use Usergrid::Client;
use IO::Socket::INET;
use Test::More;

# TEST DATA
my $hostname        = 'localhost';
my $port            = '8080';
my $api_url         = "http://$hostname:$port";
my $organization    = 'test-organization';
my $application     = 'test-app';
my $username        = 'testuser';
my $password        = 'Testuser123$';
###########

if (_check_port($hostname, $port)) {
  plan tests => 10;
} else {
  plan skip_all => "server $api_url not reachable"
}

sub _check_port {
  my ($hostname, $port) = @_;
  new IO::Socket::INET ( PeerAddr => $hostname, PeerPort => $port,
    Proto => 'tcp' ) || return 0;
  return 1;
}

my ($user, $token, $book, $collection);

# Create the client object that will be used for all subsequent requests
my $client = Usergrid::Client->new(
  organization => $organization,
  application  => $application,
  api_url      => $api_url,
  trace        => 0
);

# Create a test user
$user = $client->add_entity("users", { username=>$username, password=>$password });

$token = $client->login($username, $password);

eval {

  $collection = $client->get_collection("books");

  ok ( $collection->count() == 0, "count must be initially zero" );

  $client->add_entity("books", { name => "Ulysses", author => "James Joyce" });
  $client->add_entity("books", { name => "Neuromancer", author => "William Gibson" });
  $client->add_entity("books", { name => "On the Road", author => "Jack Kerouac" });
  $client->add_entity("books", { name => "Ubik", author => "Philip K. Dick" });
  $client->add_entity("books", { name => "Reef", author => "Romesh Gunasekera" });

  $collection = $client->get_collection("books");

  ok ( $collection->count() == 5, "count must now be five" );

  while ($collection->has_next_entity()) {
    $book = $collection->get_next_entity();
    ok ( length($book->get('name')) > 3, "check the book titles" );
  }

  $collection->reset_iterator();

  ok ( $collection->iterator == -1, "iterator must be reset" );

  ok ( $collection->count() == 5, "count must be five" );

  while ($collection->has_next_entity()) {
    $book = $collection->get_next_entity();
    $client->delete_entity($book);
  }

  $collection = $client->get_collection("books");

  ok ( $collection->count() == 0, "count must now be again zero" );

};

diag($@) if $@;

# Cleanup
$collection = $client->delete_collection("books", undef, 30);
$client->delete_entity($user);

#!perl
use 5.010;
use strict;
use warnings;
use File::Basename qw//; use lib File::Basename::dirname(__FILE__).'/lib';
use Test::More;
use TestCassandra;

plan skip_all => "Missing Cassandra test environment" unless TestCassandra->is_ok;
plan tests => 7;

my $client= TestCassandra->new;
$client->connect();

my $db= 'perl_cassandra_client_tests';
$client->execute("drop keyspace if exists $db");
$client->execute("create keyspace $db with replication={'class':'SimpleStrategy', 'replication_factor': 1}");
$client->execute("create table $db.test_int (id int primary key, value int)");
$client->execute("insert into $db.test_int (id, value) values (:id, :value)", { id => 6, value => 7 });
{
    my ($result)= $client->execute("select id, value from $db.test_int where id=:id", { id => 6 });
    my $rows= $result->rows;
    ok(@$rows == 1);
    ok($rows->[0][0] == 6);
    ok($rows->[0][1] == 7);
}

$client->execute("delete from $db.test_int where id=?", { id => 6 });
{
    my ($result)= $client->execute("select id, value from $db.test_int where id=?", { id => 6 });
    my $rows= $result->rows;
    ok(@$rows == 0);
}

$client->execute("insert into $db.test_int (id, value) values (:num, :num)", { num => 9 });
{
    my ($result)= $client->execute("select id, value from $db.test_int where id=?", { id => 9 });
    my $rows= $result->rows;
    ok(@$rows == 1);
    ok($rows->[0][0] == 9);
    ok($rows->[0][1] == 9);
}

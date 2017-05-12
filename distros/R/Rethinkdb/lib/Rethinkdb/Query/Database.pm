package Rethinkdb::Query::Database;
use Rethinkdb::Base 'Rethinkdb::Query';

use Scalar::Util 'weaken';

has [qw{ _rdb name }];
has '_type' => sub { return Rethinkdb::Protocol->new->term->termType->db; };

sub create {
  my $self = shift;
  my $name = shift || $self->name;

  my $q = Rethinkdb::Query->new(
    _rdb  => $self->_rdb,
    _type => $self->_termType->db_create,
    args  => $name,
  );

  weaken $q->{_rdb};
  return $q;
}

sub drop {
  my $self = shift;
  my $name = shift || $self->name;

  my $q = Rethinkdb::Query->new(
    _rdb  => $self->_rdb,
    _type => $self->_termType->db_drop,
    args  => $name,
  );

  weaken $q->{_rdb};
  return $q;
}

sub list {
  my $self = shift;

  my $q = Rethinkdb::Query->new(
    _rdb  => $self->_rdb,
    _type => $self->_termType->db_list,
  );

  weaken $q->{_rdb};
  return $q;
}

sub table_create {
  my $self    = shift;
  my $args    = shift;
  my $optargs = ref $_[0] ? $_[0] : {@_};

  my $q = Rethinkdb::Query->new(
    _parent => $self,
    _type   => $self->_termType->table_create,
    args    => $args,
    optargs => $optargs,
  );

  return $q;
}

sub table_drop {
  my $self = shift;
  my $args = shift;

  my $q = Rethinkdb::Query->new(
    _parent => $self,
    _type   => $self->_termType->table_drop,
    args    => $args,
  );

  return $q;
}

sub table_list {
  my $self = shift;

  my $q = Rethinkdb::Query->new(
    _parent => $self,
    _type   => $self->_termType->table_list,
  );

  return $q;
}

sub table {
  my $self     = shift;
  my $name     = shift;
  my $outdated = shift;

  my $optargs = {};
  if ($outdated) {
    $optargs = { use_outdated => 1 };
  }

  my $t = Rethinkdb::Query::Table->new(
    _parent => $self,
    _type   => $self->_termType->table,
    name    => $name,
    args    => $name,
    optargs => $optargs,
  );

  return $t;
}

sub grant {
  my $self  = shift;
  my $user  = shift;
  my $perms = shift;

  my $q = Rethinkdb::Query->new(
    _rdb  => $self->_rdb,
    _type => $self->_termType->grant,
    args  => [ $user, $perms ]
  );

  return $q;
}

sub config {
  my $self = shift;

  my $q = Rethinkdb::Query->new(
    _parent => $self,
    _type   => $self->_termType->config,
  );

  return $q;
}

sub rebalance {
  my $self = shift;

  my $q = Rethinkdb::Query->new(
    _parent => $self,
    _type   => $self->_termType->rebalance,
  );

  return $q;
}

sub reconfigure {
  my $self = shift;
  my $args = shift;

  my $q = Rethinkdb::Query->new(
    _parent => $self,
    _type   => $self->_termType->reconfigure,
    optargs => $args
  );

  return $q;
}

sub wait {
  my $self = shift;

  my $q = Rethinkdb::Query->new(
    _parent => $self,
    _type   => $self->_termType->wait,
  );

  return $q;
}

1;

=encoding utf8

=head1 NAME

Rethinkdb::Query::Database - RethinkDB Query Database

=head1 SYNOPSIS

=head1 DESCRIPTION

L<Rethinkdb::Query::Database> is a type of query that represents a database.
This classes contains methods to interact with a database or the underlying
tables.

=head1 ATTRIBUTES

L<Rethinkdb::Query::Database> implements the following attributes.

=head2 name

  my $db = r->db('better');
  say $db->name;

The name of the database.

=head1 METHODS

=head2 create

  r->db('test')->create('superheroes')->run;

Create a database. A RethinkDB database is a collection of tables, similar to
relational databases.

If successful, the operation returns an object: C<< {created => 1} >>. If a
database with the same name already exists the operation returns an
C<runtime_error>.

B<Note>: that you can only use alphanumeric characters and underscores for the
database name.

=head2 drop

  r->db('comics')->drop('superheroes')->run;

Drop a database. The database, all its tables, and corresponding data will be
deleted.

If successful, the operation returns the object C<< {dropped => 1} >>. If the
specified database doesn't exist a C<runtime_error> will be returned.

=head2 list

  r->db('sillyStuff')->list->run;

List all database names in the system. The result is a list of strings.

=head2 table

  r->db('newStuff')->table('weapons')->run;

Select all documents in a table from this database. This command can be chained
with other commands to do further processing on the data.

=head2 table_create

  r->db('test')->table_create('dc_universe')->run;

Create a table. A RethinkDB table is a collection of JSON documents.

If successful, the operation returns an object: C<< {created => 1} >>. If a
table with the same name already exists, the operation returns a
C<runtime_error>.

B<Note:> that you can only use alphanumeric characters and underscores for the
table name.

=head2 table_drop

  r->db('test')->table_drop('dc_universe')->run;

Drop a table. The table and all its data will be deleted.

If successful, the operation returns an object: C<< {dropped => 1} >>. If the
specified table doesn't exist a C<runtime_error> is returned.

=head2 table_list

  r->db('test')->table_list->run;

List all table names in a database. The result is a list of strings.

=head2 grant

r->db('test')->grant( 'username', { read => r->true, write => r->false } )
  ->run;

Grant or deny access permissions for a user account on a database.

=head2 config

  r->db('test')->config->run;

Query (read and/or update) the configurations for individual databases.

=head2 rebalance

  r->db('test')->rebalance->run;

Rebalances the shards of all tables in the database.

=head2 reconfigure

  r->db('test')->reconfigure({ shards => 2, replicas => 1 })->run;
  r->db('test')->reconfigure(
    {
      shards              => 2,
      replicas            => { wooster => 1, wayne => 1 },
      primary_replica_tag => 'wooster'
    }
  )->run;

Reconfigure all table's sharding and replication.

=head2 wait

  r->db('test')->wait->run;

Wait for all the tables in a database to be ready. A table may be
temporarily unavailable after creation, rebalancing or reconfiguring.
The L</wait> command blocks until the given database is fully up to date.

=cut

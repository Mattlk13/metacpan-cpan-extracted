package GraphViz::DBI::FromSchema;

=head1 NAME

GraphViz::DBI::FromSchema - Create a diagram of database tables, using the
foreign key information in the schema

=head1 SYNOPSIS

  use DBI;
  use GraphViz::DBI::FromSchema;

  my $db = DBI->connect(@dsn_etc);

  my $filename = 'DB_diagram.ps';
  open my $file, '>', $filename or die "Opening $filename failed: $!\n";
  print $file GraphViz::DBI::FromSchema->new($db)->graph_tables->as_ps;

=cut


use warnings;
use strict;


use base qw<GraphViz::DBI>;

our $VERSION = 0.5;


=head1 DESCRIPTION

This module creates a diagram of the tables in a database, listing the fields
in each table and with arrows indicating foreign keys between tables.

Note if you simply wish to create a diagram for a database and save it to a
file, the provided L<schema_diagram> command does this. You only need to use
this module if you want to manipulate the diagram programmatically.

L<GraphViz::DBI> provides functionality for creating database diagrams.  By
default it identifies foreign keys based on fields being named in a particular
way, and suggests subclassing it to implement different heuristics.  This
module is a subclass which uses the L<DBI> to interrogate the database about
the foreign keys defined for each table -- which, for databases which support
referential integrity, should work irrespective of your naming scheme.

The interface is identical to L<GraphViz::DBI>'s, so see its documentation for
details.

=cut

{
  my %column_name_name =
  (
    PKTABLE_NAME => 'FKCOLUMN_NAME',
    UK_TABLE_NAME => 'FK_COLUMN_NAME',
  );


  sub is_foreign_key {
    my ($self, $table, $field) = @_;

    # Grab all the foreign keys for this table (unless we've already done so):
    unless ($self->{foreign_key}{$table})
    {
      my $keys_query = $self->get_dbh
          ->foreign_key_info(undef, undef, undef, undef, undef, $table);
      if ($keys_query)
      {

        while (local $_ = $keys_query->fetchrow_hashref)
        {

          # There are two different standards for the names of columns that could
          # be returned here, so try each of them in turn:
          while (my ($pk_table_name_name, $fk_column_name_name)
              = each %column_name_name)
          {
            if ($_->{$pk_table_name_name})
            {
              $self->{foreign_key}{$table}{$_->{$fk_column_name_name}}
                  = $_->{$pk_table_name_name};
              last;
            }
          }

        }

      }
    }

    $self->{foreign_key}{$table}{$field};
  }

}


=head2 Printing Large Diagrams

For reasonably sized databases, the diagrams generated by this module can be
too large to fit on to paper that fits in your printer.  Unix has a C<poster>
command which can help with this, splitting a large diagram up into 'tiles'
printed on separate sheets, complete with crop marks for trimming and
assembling into a giant poster.  Sample usage:

  $ poster -m A4 -s 0.45 DB_diagram_big.ps > DB_diagram_A4.ps

=head2 Fixing Table Names

The table names retrieved by C<GraphViz::DBI> can suffer from a couple of
problems:

=over 2

=item *

They are prefixed by the database name (and a dot).

=item *

With MySQL they are surrounded by backticks.  There are several reports of this
in the C<GraphViz::DBI> RT queue.

=back

Both of these get in the way of matching up foreign keys with the tables they
reference, so this module overrides fetching the list of table names to remove
them. It's currently hacky and fragile; I'm planning on improving this.

=cut


sub get_tables
{
  my ($self) = @_;

  my $db = $self->get_dbh;
  my $driver = $db->{Driver}{Name};

  # TODO See if there's a better way round this, such as filtering out bogus
  # rows from the return call before stripping the leading parts off. If we
  # need to switch on driver type then use subclasses, not hardcoding all the
  # logic in here:
  my $schema;
  $schema = 'public' if $driver eq 'Pg';

  $self->{tables} ||= [map
  {

    # TODO Get the separator char from DBI, rather than presuming dot:
    s/ .* \. //x;

    # TODO Work out what to do here. Maybe quote table names returned by
    # foreign_key_info rather than unquoting them here. Deal with table names
    # that are also keywords, and with Postgres only quoting those that need to
    # be and MySQL quoting everything by default.
    tr/`//d if $driver eq 'mysql';

    $_;
  } $self->get_dbh->tables(undef, $schema, undef, undef)];

  # TODO Option to include views or not? ('table' as final param)

  @{$self->{tables}};
}

=head1 FUTURE PLANS

In the common case where you have a C<DBI> object and you want a diagram (like
in the L</SYNOPSIS>) it's irritating to have deal with the
C<GraphViz::DBI::FromSchema> object, which is really an implementation detail.
So it may be worth creating a functional interface to hide this.

It may further make sense to have a function which saves the diagram to a file
as well, since that's likely to be what people want to do with it.

=head1 CAVEATS

This has been developed and tried out with Postgres and MySQL. It should work
with other database software, but given there are some differences between
MySQL and Postgres, others may have further differences which are not yet taken
into account.

The L<table-name 'fixing'|/Fixing Table Names> described above may be a bad
idea, or not work in some circumstances.  Arguably this should be done in
C<GraphViz::DBI> rather than here.

This module is lacking substantive tests, because of the difficulty of
automatically testing something which needs a database and generates graphical
output.  Suggestions on what to do about this welcome.

=head1 SEE ALSO

=over 2

=item *

L<GraphViz::DBI>, which provides most of the functionality

=back

=head1 CREDITS

Written by Ovid and Smylers at Webfusion,
L<http://www.webfusion.com/>.

Maintained by Smylers <smylers@cpan.org>

Thanks to Marcel GrE<uuml>nauer for writing C<GraphViz::DBI>.

=head1 COPYRIGHT & LICENCE

Copyright 2007-2008 by Pipex Communications UK Ltd, 2008-2011 Webfusion Ltd

This library is software libre; you may redistribute it and modify it under the
terms of any of these licences:

=over 2

=item *

L<The GNU General Public License, version 2|perlgpl>

=item *

The GNU General Public License, version 3

=item *

L<The Artistic License|perlartistic>

=item *

The Artistic License 2.0

=back

=cut


1;

use utf8;
package Schema::RackTables::0_19_8::Result::CactiGraph;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::RackTables::0_19_8::Result::CactiGraph

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<CactiGraph>

=cut

__PACKAGE__->table("CactiGraph");

=head1 ACCESSORS

=head2 object_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 graph_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 caption

  data_type: 'char'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "object_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "graph_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "caption",
  { data_type => "char", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</graph_id>

=back

=cut

__PACKAGE__->set_primary_key("graph_id");

=head1 RELATIONS

=head2 object

Type: belongs_to

Related object: L<Schema::RackTables::0_19_8::Result::RackObject>

=cut

__PACKAGE__->belongs_to(
  "object",
  "Schema::RackTables::0_19_8::Result::RackObject",
  { id => "object_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-10-22 23:02:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2bCyQ4nhdOR1CSd+Ho5DIw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

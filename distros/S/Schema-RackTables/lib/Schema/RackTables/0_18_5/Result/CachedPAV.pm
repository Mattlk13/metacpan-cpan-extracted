use utf8;
package Schema::RackTables::0_18_5::Result::CachedPAV;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::RackTables::0_18_5::Result::CachedPAV

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

=head1 TABLE: C<CachedPAV>

=cut

__PACKAGE__->table("CachedPAV");

=head1 ACCESSORS

=head2 object_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 port_name

  data_type: 'char'
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 vlan_id

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "object_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "port_name",
  { data_type => "char", is_foreign_key => 1, is_nullable => 0, size => 255 },
  "vlan_id",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</object_id>

=item * L</port_name>

=item * L</vlan_id>

=back

=cut

__PACKAGE__->set_primary_key("object_id", "port_name", "vlan_id");

=head1 RELATIONS

=head2 cached_pnv

Type: might_have

Related object: L<Schema::RackTables::0_18_5::Result::CachedPNV>

=cut

__PACKAGE__->might_have(
  "cached_pnv",
  "Schema::RackTables::0_18_5::Result::CachedPNV",
  {
    "foreign.object_id" => "self.object_id",
    "foreign.port_name" => "self.port_name",
    "foreign.vlan_id"   => "self.vlan_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cached_pvm

Type: belongs_to

Related object: L<Schema::RackTables::0_18_5::Result::CachedPVM>

=cut

__PACKAGE__->belongs_to(
  "cached_pvm",
  "Schema::RackTables::0_18_5::Result::CachedPVM",
  { object_id => "object_id", port_name => "port_name" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);

=head2 vlan

Type: belongs_to

Related object: L<Schema::RackTables::0_18_5::Result::VLANValidID>

=cut

__PACKAGE__->belongs_to(
  "vlan",
  "Schema::RackTables::0_18_5::Result::VLANValidID",
  { vlan_id => "vlan_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-10-22 23:03:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:isD8ZQzenvNEHTmDfB88xw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

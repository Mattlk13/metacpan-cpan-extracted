# NEVER EDIT this file.  It was generated and will be overwritten without
# notice upon regeneration of this application.  You have been warned.
package Contact::Model::tshirt_author;
use strict; use warnings;

__PACKAGE__->load_components( qw/ PK::Auto Core / );
__PACKAGE__->table( 'tshirt_author' );
__PACKAGE__->add_columns( qw/
    id
    tshirt
    author
/ );
__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->base_model( 'Contact::Model' );
__PACKAGE__->belongs_to( tshirt => 'Contact::Model::tshirt' );
__PACKAGE__->belongs_to( author => 'Contact::Model::author' );

sub get_foreign_tables {
    return qw(
    );
}

sub table_name {
    return 'tshirt_author';
}

1;

=head1 NAME

Contact::Model::GEN::tshirt_author - model for tshirt_author table (generated part)

=head1 DESCRIPTION

This model inherits from Gantry::Utils::DBIxClass.
It was generated by Bigtop, and IS subject to regeneration.

=head1 METHODS

You may use all normal Gantry::Utils::DBIxClass methods and the
ones listed here:

=over 4

=item get_foreign_display_fields

=item get_foreign_tables

=item foreign_display

=item table_name

=back

=cut

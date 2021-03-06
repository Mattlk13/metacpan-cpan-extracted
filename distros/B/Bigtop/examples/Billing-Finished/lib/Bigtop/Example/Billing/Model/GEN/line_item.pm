# NEVER EDIT this file.  It was generated and will be overwritten without
# notice upon regeneration of this application.  You have been warned.
package Bigtop::Example::Billing::Model::line_item;
use strict; use warnings;

__PACKAGE__->load_components( qw/ PK::Auto Core / );
__PACKAGE__->table( 'line_item' );
__PACKAGE__->add_columns( qw/
    id
    due_date
    name
    invoice
    hours
    charge_per_hour
    notes
    description
/ );
__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->belongs_to( invoice => 'Bigtop::Example::Billing::Model::invoice' );
__PACKAGE__->base_model( 'Bigtop::Example::Billing::Model' );

sub get_foreign_display_fields {
    return [ qw( name ) ];
}

sub get_foreign_tables {
    return qw(
        Bigtop::Example::Billing::Model::invoice
    );
}

sub foreign_display {
    my $self = shift;

    my $name = $self->name() || '';

    return "$name";
}

sub table_name {
    return 'line_item';
}

1;

=head1 NAME

Bigtop::Example::Billing::Model::GEN::line_item - model for line_item table (generated part)

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

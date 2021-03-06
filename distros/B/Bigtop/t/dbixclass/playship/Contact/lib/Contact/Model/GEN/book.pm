# NEVER EDIT this file.  It was generated and will be overwritten without
# notice upon regeneration of this application.  You have been warned.
package Contact::Model::book;
use strict; use warnings;

__PACKAGE__->load_components( qw/ InflateColumn::DateTime Core / );
__PACKAGE__->table( 'book' );
__PACKAGE__->add_columns( qw/
    id
    ident
/ );
__PACKAGE__->set_primary_key( 'id' );
__PACKAGE__->base_model( 'Contact::Model' );
__PACKAGE__->has_many(
    author_books => 'Contact::Model::author_book',
    'book'
);
__PACKAGE__->many_to_many(
    writers => 'author_books',
    'author'
);

sub get_foreign_tables {
    return qw(
    );
}

sub table_name {
    return 'book';
}

1;

=head1 NAME

Contact::Model::GEN::book - model for book table (generated part)

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

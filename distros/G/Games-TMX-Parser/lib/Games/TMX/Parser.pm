
=head1 NAME

Games::TMX::Parser - parse tiled game maps from http://www.mapeditor.org

=head1 SYNOPSIS

    use Games::TMX::Parser;

    $map = Games::TMX::Parser->new(
        map_dir  => 'maps',
        map_file => 'tower_defense.tmx',
    )->map;

    # ----- the map ------------------
    $width       = $map->width; # all sizes in pixels
    $height      = $map->height;
    $tile_width  = $map->tile_width;
    $tile_height = $map->tile_height;

    $tileset     = $map->tilesets->[3];
    $tile        = $map->get_tile('some_tile_id'); # find in all tilesets
    $layer       = $map->get_layer('some_layer_name');

    # ----- a tileset of tiles --------
    $tile        = $tileset->tiles->[2];
    $image       = $tileset->image; # image file name in map_dir directory
    $width       = $tileset->width;
    $height      = $tileset->height;
    $tile_width  = $tileset->tile_width;
    $tile_height = $tileset->tile_height;
    $tile_count  = $tileset->tile_count;

    # ----- a tile from a tileset -----
    %props       = %{ $tile->properties };
    $value       = $tile->get_prop('some_tile_property_name');
    $tileset     = $tile->tileset;

    # ----- a layer on the map --------
    $cell        = $layer->get_cell($column, $row);
    $cell        = $layer->rows->[$row]->[$column]; # same as above
    @cells       = $layer->find_cells_with_property('some_tile_property_name');
    @cells       = $layer->all_cells;

    # ----- a cell in a layer ---------
    $tile        = $cell->tile;
    $layer       = $cell->layer;
    ($col, $row) = $cell->xy;
    $cell        = $cell->left;
    $cell        = $cell->right;
    $cell        = $cell->above;
    $cell        = $cell->below;
    $cell        = $cell->seek_next_cell; # follow a path of tiled cells on a layer

=head1 DESCRIPTION

From http://www.mapeditor.org:

    Tiled is a general purpose tile map editor. It's built to be easy to use,
    yet flexible enough to work with varying game engines, whether your game is
    an RPG, platformer or Breakout clone.

This package provides Perl access to the maps generated by Tiled, the general
purpose tile map editor. You could use it for drawing you perl game maps in
Tiled, or for writing Perl scripts which improve/analyze maps- extract
waypoints, decorate corners with shadows, add random trees, etc.

Drawing your maps in Tiled is more fun that writing your own map format and
then drawing ASCII art.

The TMX map format documentation describes the main entities:

    https://github.com/bjorn/tiled/wiki/TMX-Map-Format

=head1 HOW TO USE

In Tiled, draw your map and place properties as markers on special tiles you
want to read in Perl. Then in your Perl game, read the map and use:

    my @cells = $map->get_layer('layer_with_stuff')
                    ->find_cells_with_property('my_special_tile_marker');
 
To find your special cells (spawn points, enemy locations, etc.).

Draw a layer by iteating over:

    @{ $layer->rows };

Which will give you an ARRAY ref of cells, one per column. Then you can find
the tile of the cell using:

    $cell->tile;

And then access its properties, or cut the correct image from the tileset image file:

    $tile->tileset->image;


=head1 EXAMPLE

The distribution contains an example which computes creep waypoint column/row
for any map with a simple path drawn on it.

=head1 TODO

No support for base64 or compression of maps, uncheck the correct check boxes
in Tiled before you save.

No support for object layers.

=head1 DEVELOPMENT

Send pull requests to:

    https://github.com/eilara/Games-TMX-Parser


=head1 AUTHOR

Ran Eilam <eilara@cpan.org>

A big hug to mst for namespacing help.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Ran Eilam

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut

package Games::TMX::Parser;

use Moose;
use File::Spec;
use XML::Twig;

has [qw(map_dir map_file)] => (is => 'ro', isa => 'Str', required => 1);

has map => (is => 'ro', lazy_build => 1, handles => [qw(get_layer)]);

has twig => (is => 'ro', lazy_build => 1);

sub _build_twig {
    my $self = shift;
    my $twig = XML::Twig->new;
    $twig->parsefile
        ( File::Spec->catfile($self->map_dir, $self->map_file) );
    return $twig;
}

sub _build_map {
    my $self = shift;
    return Games::TMX::Parser::Map->new(el => $self->twig->root);
}

# ------------------------------------------------------------------------------

package Games::TMX::Parser::MapElement;

use Moose;

has el => (is => 'ro', required => 1, handles => [qw(
    att att_exists first_child children print
)]);

# ------------------------------------------------------------------------------

package Games::TMX::Parser::Map;

use Moose;

extends 'Games::TMX::Parser::MapElement';

has [qw(layers tilesets width height tile_width tile_height tiles_by_id)] =>
    (is => 'ro', lazy_build => 1);

sub _build_layers {
    my $self = shift;
    return {map { $_->att('name') =>
        Games::TMX::Parser::Layer->new(el => $_, map => $self)
    } $self->children('layer') };
}

sub _build_tiles_by_id {
    my $self  = shift;
    my @tiles = map { @{$_->tiles} } @{ $self->tilesets };
    return {map { $_->id => $_ } @tiles};
}

sub _build_tilesets {
    my $self = shift;
    return [map {
        Games::TMX::Parser::TileSet->new(el => $_)
    } $self->children('tileset') ];
}

sub _build_width       { shift->att('width') }
sub _build_height      { shift->att('height') }
sub _build_tile_width  { shift->att('tile_width') }
sub _build_tile_height { shift->att('tile_height') }

sub get_layer { shift->layers->{pop()} }
sub get_tile  { shift->tiles_by_id->{pop()} }

# ------------------------------------------------------------------------------

package Games::TMX::Parser::TileSet;

use Moose;
use List::MoreUtils qw(natatime);

extends 'Games::TMX::Parser::MapElement';

has [qw(first_gid image tiles width height tile_width tile_height tile_count)] =>
    (is => 'ro', lazy_build => 1);

sub _build_tiles {
    my $self = shift;
    my $first_gid = $self->first_gid;

    # index tiles with properties
    my $prop_tiles = {map {
        my $el = $_;
        my $id = $first_gid + $el->att('id');
        my $properties = {map {
           $_->att('name'), $_->att('value') 
        } $el->first_child('properties')->children};
        my $tile = Games::TMX::Parser::Tile->new
            (id => $id, properties => $properties, tileset => $self);
        ($id => $tile);
    } $self->children('tile')};

    # create a tile object for each tile in the tileset
    # unless it is a tile with properties
    my @tiles;
    my $it = natatime $self->width, 1..$self->tile_count;
    while (my @ids = $it->()) {
        for my $id (@ids) {
            my $gid = $first_gid + $id;
            my $tile = $prop_tiles->{$gid} || 
                Games::TMX::Parser::Tile->new(id => $gid, tileset => $self);
            push @tiles, $tile;
        }
    }
    return [@tiles];
}

sub _build_tile_count {
    my $self = shift;
    return ($self->width      * $self->height     ) /
           ($self->tile_width * $self->tile_height);
}

sub _build_first_gid   { shift->att('firstgid') }
sub _build_tile_width  { shift->att('tilewidth') }
sub _build_tile_height { shift->att('tileheight') }
sub _build_image       { shift->first_child('image')->att('source') }
sub _build_width       { shift->first_child('image')->att('width') }
sub _build_height      { shift->first_child('image')->att('height') }

# ------------------------------------------------------------------------------

package Games::TMX::Parser::Tile;

use Moose;

has id      => (is => 'ro', isa => 'Int', required => 1);
has tileset => (is => 'ro', weak_ref => 1, required => 1);

has properties => (is => 'ro', isa => 'HashRef', default => sub { {} });

sub get_prop {
    my ($self, $name) = @_;
    return $self->properties->{$name};
}

# ------------------------------------------------------------------------------

package Games::TMX::Parser::Layer;

use Moose;
use List::MoreUtils qw(natatime);

has map => (is => 'ro', required => 1, weak_ref => 1, handles => [qw(
    width height tile_width tile_height get_tile
)]);

has rows => (is => 'ro', lazy_build => 1);

extends 'Games::TMX::Parser::MapElement';

sub _build_rows {
    my $self = shift;
    my @rows;
    my $it = natatime $self->width, $self->first_child->children('tile');
    my $y = 0;
    while (my @row = $it->()) {
        my $x = 0;
        push @rows, [map {
            my $el = $_;
            my $id = $el->att('gid');
            my $tile;
            $tile = $self->get_tile($id) if $id;
            Games::TMX::Parser::Cell->new
                (x => $x++, y => $y, tile => $tile, layer => $self)
        } @row];
        $y++;
    }
    return [@rows];
}

sub find_cells_with_property {
    my ($self, $prop) = @_;
    return grep {
        my $cell = $_;
        my $tile = $cell->tile;
        $tile && exists $tile->properties->{$prop};
    } $self->all_cells;
}

sub get_cell {
    my ($self, $col, $row) = @_;
    return $self->rows->[$row]->[$col];
}

sub all_cells { return map { @$_ } @{ shift->rows } }

# ------------------------------------------------------------------------------

package Games::TMX::Parser::Cell;

use Moose;

has [qw(x y)] => (is => 'ro', isa => 'Int', required => 1);

has tile => (is => 'ro');

has layer => (is => 'ro', required => 1, weak_ref => 1, handles => [qw(
    get_cell width height
)]);

my %Dirs      = map { $_ => 1 } qw(below left right above);
my %Anti_Dirs = (below => 'above', left => 'right', right => 'left', above => 'below');

sub left  { shift->neighbor(-1, 0) }
sub right { shift->neighbor( 1, 0) }
sub above { shift->neighbor( 0,-1) }
sub below { shift->neighbor( 0, 1) }

sub xy { ($_[0]->x, $_[0]->y) }

sub neighbor {
    my ($self, $dx, $dy) = @_;
    my $x = $self->x + $dx;
    my $y = $self->y + $dy;
    return undef if $x < 0            || $y < 0;
    return undef if $x > $self->width || $y > $self->height;
    return $self->get_cell($x, $y);
}

sub seek_next_cell {
    my ($self, $dir) = @_;
    my %dirs = %Dirs;
    delete $dirs{$Anti_Dirs{$dir}} if $dir;
    for my $d (keys %dirs) {
        my $c = $self->$d;
        return [$c, $d] if $c && $c->tile;
    }
    return undef;
}

1;

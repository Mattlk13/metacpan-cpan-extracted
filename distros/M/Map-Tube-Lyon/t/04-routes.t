#!perl

use strict;
use Test::More tests => 9;
use Map::Tube::Lyon;

my $map = new_ok( 'Map::Tube::Lyon' );

eval { $map->get_shortest_route(); };
like($@, qr/ERROR: Either FROM\/TO node is undefined/);

eval { $map->get_shortest_route('Foch'); };
like($@, qr/ERROR: Either FROM\/TO node is undefined/);

eval { $map->get_shortest_route('XYZ', 'Foch'); };
like($@, qr/\QMap::Tube::get_shortest_route(): ERROR: Received invalid FROM node 'XYZ'\E/);

eval { $map->get_shortest_route('Foch', 'XYZ'); };
like($@, qr/\QMap::Tube::get_shortest_route(): ERROR: Received invalid TO node 'XYZ'\E/);

{
  my $ret = $map->get_shortest_route('Foch', 'Flachet');
  isa_ok( $ret, 'Map::Tube::Route' );
  is( $ret, 'Foch (A), Mass�na (A), Charpennes - Charles Hernu (A, B), R�publique - Villeurbanne (A), Gratte-Ciel (A), Flachet (A)', 'Foch - Flachet' );
}

{
  my $ret = $map->get_shortest_route('cuire', 'GARIBALDI');
  isa_ok( $ret, 'Map::Tube::Route' );
  is( $ret, 'Cuire (C), H�non (C), Croix-Rousse (C), Croix-Paquet (C), H�tel de Ville - Louis Pradel (A, C), Cordeliers (A), Bellecour (A, D), Guilloti�re - Gabriel P�ri (D), Saxe - Gambetta (B, D), Garibaldi (D)', 'cuire - GARIBALDI case-insensitive' );
}


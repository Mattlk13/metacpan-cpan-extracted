use strict;
use warnings;

use Games::Ratings::Chess::DWZ;

use Test::More tests => 3;

my %expected;
my %computed;

## see the following two links for the official calculation 
## * http://schachbund.de/dwz/turniere/2007.html?code=9810-F00-VFB (Player
##   Bartolomaeus, Christian

my $player = Games::Ratings::Chess::DWZ->new();
$player->set_rating(2165);
$player->set_coefficient(30);
$player->add_game( {
                     opponent_rating => 1790,
                     result          => 'win',
                   }
                 );
$player->add_game( {
                     opponent_rating => 1989,
                     result          => 'win',
                   }
                 );
$player->add_game( {
                     opponent_rating => 2057,
                     result          => 'win',
                   }
                 );
$player->add_game( {
                     opponent_rating => 2460,
                     result          => 'draw',
                   }
                 );
$player->add_game( {
                     opponent_rating => 2435,
                     result          => 'loss',
                   }
                 );
$player->add_game( {
                     opponent_rating => 2210,
                     result          => 'draw',
                   }
                 );
$player->add_game( {
                     opponent_rating => 2036,
                     result          => 'win',
                   }
                 );
$player->add_game( {
                     opponent_rating => 2064,
                     result          => 'draw',
                   }
                 );
$player->add_game( {
                     opponent_rating => 2098,
                     result          => 'draw',
                   }
                 );

## test 1: check new rating after this games
$expected{t07_new_rating_all_games} = '2186';
$computed{t07_new_rating_all_games} = $player->get_new_rating();

## test 2: check expected points
$expected{t08_expected_points_all_games} = '4.954';
$computed{t08_expected_points_all_games} = $player->get_points_expected();

## test 3: check performance
$expected{t12_performance} = '2273';
$computed{t12_performance} = $player->get_performance();

## run actual tests for all test_items in %expected
foreach my $test_item ( sort keys %expected ) {
    is( $computed{$test_item}, $expected{$test_item}, 
        "$test_item: $computed{$test_item} -> $expected{$test_item}" );
}

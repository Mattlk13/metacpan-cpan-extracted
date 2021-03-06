package Games::Score;

use 5.006;
use strict;
use warnings;

=head1 NAME

Games::Score - Keep track of score in games

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

    use Games::Score;

    # these three values are the default ones, by the way
    Games::Score->default_score(0);
    Games::Score->default_step(1);
    Games::Score->step_method('inc');

    # start two players
    my $player1 = Games::Score->new();
    my $player2 = Games::Score->new();

    # set a winning condition
    Games::Score->victory_is( sub { $_[0] >= 20 } );

    # and something to do if it is achieved
    Games::Score->on_victory_do( sub { print "Won!" } );

    # give points to the players
    $player1->add(2);
    $player2->step();

    # look at section FUNCTIONS for more functionalities, such as
    Games::Score->invalidate_if( sub { $_[0] > 20 } );

=head1 DESCRIPTION

Games::Score can be use to keep track of several players' points in a game,
regardless of the starting amount of points, winning and/or losing conditions,
etc.

It provides several useful methods so that the user doesn't have to keep
testing values to see if they're valid or if the player condition has changed.

=head1 FUNCTIONS

=head2 BASIC METHODS

=head3 new

  new();
  new(PLAYERNAME);
  new(PLAYER_NAME,PLAYER_SCORE);

Creates a new Games::Score object. Default name is "Player" and default score
is 0.

  # start a player with the default points
  my $player1 = Games::Score->new();

  # start a player named "BANZAI"
  my $player2 = Games::Score->new("BANZAI");

  # start a player named "BANZAI" with 20 points
  my $player2 = Games::Score->new("BANZAI",20);

=cut

sub new {
  my ($self, $name, $score) = @_;
  $name  ||= default_name();
  $score ||= default_score();
  my %player = (NAME => $name, SCORE => $score);
  bless \%player => $self;
}

=head2 VICTORY AND DEFEAT METHODS

=head3 victory_is

  victory_is(CODE)

Allows for defining a funtion which, receiving the player's score, will return
true if the player has won the game.

This function is used by has_won().

In addition, if both victory_is() and on_victory_do() are defined, as soon as
the player's score changes and the victory condition (defined with
victory_is()) is verified, the function defined with on_victory_do() is
executed.

The function defined with victory_is() receives the score as a parameter.

  # set the winning condition to be "score is greater or equal than 20"
  Games::Score->victory_is( sub { $_[0] >= 20 } )

=cut

our $victory_is = sub { undef };

sub victory_is {
  shift;
  ref($_[0]) eq 'CODE' || return undef;

  $victory_is = shift;
}

=head3 defeat_is

  defeat_is(CODE);

Allows for defining a funtion which, receiving the player's score, will return
true if the player has lost the game.

This function is used by has_lost().

In addition, if both defeat_is() and on_defeat_do() are defined, as soon as the
player's score changes and the defeat condition (defined with defeat_is()) is
verified, the function defined with on_defeat_do() is executed.

The function defined with defeat_is() receives the score as a parameter.

  # set the winning condition to be "score is negative"
  Games::Score->defeat_is( sub { $_[0] < 0 } )

=cut

our $defeat_is = sub { undef };

sub defeat_is {
  shift;
  ref($_[0]) eq 'CODE' || return undef;

  $defeat_is = shift;
}

=head3 on_victory_do

  on_victory_do(CODE);

This method lets you define a function that will be called as soon as has_won()
starts returning a true value. In other words, when the score changes and the
function defined with is_victory() returns true, the function defined with
on_victory_do() is called.

The function receives as parameters the score of the player and its name.

  # set a new condition for on_victory_do()
  our $game_ended;
  Games::Score->on_victory_do( sub { $game_ended = 1 } );

  # assuming this:
  my $player1 = Games::Score->new();
  Games::Score->victory_is( sub { $_[0] == 1 } );

  # the following line will trigger sub { $game_ended = 1 }
  $player1->score(1);

=cut

our $on_victory_do = sub { undef };

sub on_victory_do {
  shift;
  ref($_[0]) eq 'CODE' || return undef;

  $on_victory_do = shift;
}

=head3 on_defeat_do

  on_defeat_do(CODE);

This method lets you define a function that will be called as soon as has_lost()
starts returning a true value. In other words, when the score changes and the
function defined with is_defeat() returns true, the function defined with
on_defeat_do() is called.

The function receives as parameters the score of the player and its name.

  # set a new condition for on_defeat_do()
  our $game_ended;
  Games::Score->on_defeat_do( sub { $game_ended = 1 } );

  # assuming this:
  my $player1 = Games::Score->new();
  Games::Score->defeat_is( sub { $_[0] == -1 } );

  # the following line will trigger sub { $game_ended = 1 }
  $player1->score(-1);

=cut

our $on_defeat_do = sub { undef };

sub on_defeat_do {
  shift;
  ref($_[0]) eq 'CODE' || return undef;

  $on_defeat_do = shift;
}

=head3 has_won

  has_won();

Returns true if the function defined with victory_is() returns true;

  if ($player1->has_won()) {
    print "$player1->name() has won";
  }

=cut

sub has_won {
  my $self = shift;
  &{$victory_is}($self->score(), $self->name());
}

=head3 has_lost

  has_lost();

Returns true if the function defined with defeat_is() returns true;

  if ($player1->has_lost()) {
    print "$player1->name() has lost";
  }

=cut

sub has_lost {
  my $self = shift;
  &{$defeat_is}($self->score(), $self->name());
}

=head3 is_ok

  is_ok();

Returns true if the player hasn't won or lost.

  # keep playing until player either wins or loses
  while ($player1->is_ok()) {
    # your game code here
  }

=cut

sub is_ok {
  my $self = shift;
  return 0 if $self->has_won() or $self->has_lost();
  1;
}

=head2 SCORE METHODS

=head3 add

  add(NUMBER);
  add(NUMBER, NUMBER, ...);

Give X points to the player (this always increases, regardless of
step_method()).

  # player1 gets 5 more points
  $player1->add(5);

  # player1 gets 2, 3 and 4 more points
  $player1->add(2,3,4);

=cut

sub add {
  my $self = shift;

  for (@_) {
    $_ || next;
    $self->score() == $self->score($self->score + $_) && last;
  }

  $self->score();
}

=head3 subtract

  subtract(NUMBER);
  subtract(NUMBER, NUMBER, ...);

Take X points from the player (this always decreases, regardless of
step_method()).

  # player1 loses 5 points
  $player1->subtract(5);

  # player1 loses 2, 3 and 4 more points
  $player1->subtract(2,3,4);

=cut

sub subtract {
  my $self = shift;

  for (@_) {
    $_ || next;
    $self->score() == $self->score($self->score - $_) && last;
  }

  $self->score();
}

=head3 invalidate_if

  invalidate_if(CODE);

When the score is about to change, score doesn't change if the function defined
with invalidate_if() returns true.

  # sets the condition so that negative values are not allowed
  Games::Score->invalidate_if( sub { $_[0] < 0 } );

  # here's an example of how this works:
  Games::Score->invalidate_if( sub { $_[0] < 0 } );
  my $player1 = Games::Score->new();
  $player1->score(3);
  # this line subtracts the player's score by 2
  $player1->subtract(2);
  # this one doesn't, as his score is already 1 and the result would be
  # invalid
  $player1->subtract(2);

If one is, for instance, adding several numbers to the score, no more numbers
are added as soon as the score can be invalidated.

  # assuming the same configuration as before:
  Games::Score->invalidate_if( sub { $_[0] > 20 } );
  my $player1 = Games::Score->new();
  $player1->score(18);

  # the following line adds 1 point to the score, doesn't add 2 more as
  # that would take the score up do 21, and skips the rest of the
  # instruction, even though it wouldn't invalidate anything by itself
  $player1->add(1,2,1);

To remove the condition, assign it an empty function

  # assign an empty function to victory_if
  Games::Score->invalidate_if( sub { } );

=cut

our $invalidate_if = sub { undef };

sub invalidate_if {
  shift;
  ref($_[0]) eq 'CODE' || return undef;

  $invalidate_if = shift;
}

=head3 step_method

  step_method();
  step_method('inc');
  step_method('dec');

Defines whether the set() method increases or decreases score; possible values
are 'inc' (increase) and 'dec' (decrease). Assigning multiple values stops at
the first valid one. Default value is 'inc', increase.

  # step method is inc (increase)
  Games::Score->step_method('inc');

  # step method is dec (decrease)
  Games::Score->step_method('dec');

  # check the step method
  my $step_method = Games::Score->step_method();

=cut

our $step_method = 'inc';

sub step_method {
  for (@_) {
    if (/^(?:inc|dec)$/) {
      $step_method = $_;
      last;
    }
  }

  $step_method;
}

=head3 default_step

  default_step();
  default_step(NUMBER);

Set or check the default number of points the step() method uses. Assigning
multiple values makes the last of them to be it. Default value is 1.

  # step() function now increases (or decreases, see step_method()) in
  # 2 points
  Games::Score->default_step(2);

  # check the default_step
  my $default_step = Games::Score->default_step();

=cut

our $default_step = 1;

sub default_step {
  shift;

  for (@_) {
    $default_step = $_;
  }

  return $default_step;
}

=head3 step

  step();
  step(NUMBER);

The basic operation to change score. Default is "add one point"; that can be
changed with default_step() and method().

  # the score from player1 steps once
  $player1->step;

  # the score from player1 steps twice
  $player1->step(2);

=cut

sub step {
  my $self = shift;

  for (1 .. ($_[0] || 1)) {
    for (step_method()) {
      $self->score( $self->score() + (/^inc$/ ?   default_step()  :
                                                - default_step()));
    }
  }

  $self->score();
}

=head3 default_score

  default_score();
  default_score(NUMBER);

Set or check the default score with which new players start. Default is 0.

  # all players start with 301 points
  Games::Score->default_score(301);

  # check the default_score
  my $default_score = Games::Score->default_score();

=cut

our $default_score = 0;

sub default_score {
  for (@_) {
    /^\d+$/ || next;
    $default_score = $_;
  }

  $default_score;
}

=head3 priority_is

  priority_is();
  priority_is('win');
  priority_is('lose');
  priority_is('win_lose');
  priority_is('lose_win');

Get or set the priority for actions involving winning or losing.

Possible values are:

=over 6

=item lose

If the player wins and loses at the same time, only the action for defeat is
run.

=item win

If the player wins and loses at the same time, only the action for victory is
run.

=item win_lose

If the player wins and loses at the same time, the action for victory is run
first and than the action for defeat is run too.

=item lose_win

If the player wins and loses at the same time, the action for defeat is run
first and than the action for victory is run too.

=back

Default_value is 'lose'.

  # Assuming this configuration
  Games::Score->on_victory_do( sub { "You won!" } );
  Games::Score->on_defeat( sub { "You lost!" } );

  # The following line states that if the player wins and loses at the
  # same time, he loses
  Games::Score->priority_is('lose');

=cut

our $priority = "lose";

sub priority_is {
  shift;
  for (@_) {
    /^(?:win|lose|win_lose|lose_win)$/ || return $priority;
    $priority = $_;
    last;
  }

  $priority;
}

=head3 score

  score();
  score(NUMBER);
  score(NUMBER, NUMBER, ...);

Get or set the score of the player. Assigning multiple values goes through all
of them, skipping when invalidate_if() returns true, and stopping at the last
one. Default score is 0.

  # get the score of the player
  my $score = $player->score();

  # player now has 10 points
  $player->score(10);

=cut

sub score { # this should change, but it will have to do for now
  my $self = shift;

  for (@_) {
    &{$invalidate_if}($_) && last;
    $$self{SCORE} = $_;
    for ($priority) {
      if (/^win$/) {
        if ($self->has_won()) {
          &{$on_victory_do}($self->score(), $self->name());
        }
        elsif ($self->has_lost()) {
          &{$on_defeat_do}($self->score(), $self->name());
        }
      }
      elsif (/^lose$/) {
        if ($self->has_lost()) {
          &{$on_defeat_do}($self->score(), $self->name());
        }
        elsif ($self->has_won()) {
          &{$on_victory_do}($self->score(), $self->name());
        }
      }
      elsif (/^win_lose$/) {
        if ($self->has_won()) {
          &{$on_victory_do}($self->score(), $self->name());
        }
        if ($self->has_lost()) {
          &{$on_defeat_do}($self->score(), $self->name());
        }
      }
      elsif (/^lose_win$/) {
        if ($self->has_lost()) {
          &{$on_defeat_do}($self->score(), $self->name());
        }
        if ($self->has_won()) {
          &{$on_victory_do}($self->score(), $self->name());
        }
      }
    }
  }

  $$self{SCORE};
}

=head2 OTHER METHODS

=head3 default_name

  default_name();
  default_name(DEFAULT_NAME);

Set or check the default name with which new players start. Default name is
'Player'.

  # all players are by default named "PLAYER"
  Games::Score->default_name("PLAYER");

  # check the default_name
  my $default_name = Games::Score->default_name();

=cut

our $default_name = 'Player';

sub default_name {
  shift;

  for (@_) {
    $default_name = $_;
    last;
  }

  $default_name;
}

=head3 name

  name();
  name(NEW_NAME);

Get or set the name of the player. Default name is 'Player', which can be
changed with default_name().

  # get the name of the player
  my $name = $player->name();

  # player is now named "WARRIOR"
  $player->name("WARRIOR");

=cut

sub name {
  my $self = shift;

  for (@_) {
    $$self{NAME} = $_;
  }

  return $$self{NAME};
}

=head1 REGARDING DRAWS

Please note the following: if you happen to have two players, change the score
for both of them and both of them get in the same situation (victory, for
instance), one of them is going to have his on_victory_do() function (if
defined) run before the other one.

Always consider the possibility of draws in your game with disregard to
Games::Score (at least for now).

=head1 EXAMPLES

=head2 START AT 0, WIN AT 20 OR MORE

Example of a game where users start with 0 points and win as soon as they get
more than 20 points. There is no way of losing.

  # These two lines aren't actually needed, as these are the default
  # values
  Games::Score->default_score(0);
  Games::Score->step_method('inc');

  # Set the victory condition
  Games::Score->victory_is( sub { $_[0] > 20; } );

  # Set what to do on victory
  our $game_ended = 0;
  our $message = '';
  Games::Score->on_victory_do( sub {
                                      $game_ended = 1;
                                      $message = "$_[1] has won!\n";
                                   } );

  # Start two players, "Shiribi" and "Zuncucu"
  my $player1 = Games::Score->new("Shiribi");
  my $player2 = Games::Score->new("Zuncucu");
  my @players = ($player1, $player2);

  # And have a random game
  until ($game_ended) {
    for (@players) {
      if (rand(1)) {
        $_->step();
        print "Player $_->name() scored ",
              "and now has $_->score() point(s).\n";
        last if $_->has_won();
      }
      else {
        print "Player $_->name() didn't score.\n"
      }
    }
  }

=head2 START AT 301, GO DOWN AND WIN ON 0, PRECISELY

Example of a game where users start with 301 points, always lose points instead
of gaining them, and win when they reach 0 points. Getting less than 0 points
invalidates the score update.

  # default score is 301, points decrease, winning on 0, negative score
  # disallowed
  Games::Score->default_score(301);
  Games::Score->step_method('dec');
  Games::Score->invalidate_if( sub { $_[0] < 0 } );
  Games::Score->victory_is( sub { $_[0] == 0 } );

=head1 AUTHOR

Jose Castro, C<< <cog@cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2004 Jose Castro, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;

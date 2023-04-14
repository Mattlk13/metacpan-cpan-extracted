#!/usr/bin/perl

use v5.14;
use warnings;

use Test::More;

use Future::XS;

BEGIN {
   plan skip_all => "Test::MemoryGrowth is not available" unless
      defined eval { require Test::MemoryGrowth };

   Test::MemoryGrowth->import;
}

# Just to keep the in-dist unit tests happy; when loaded via Future.pm the
# one provided there takes precedence
sub Future::XS::wrap_cb
{
   my $self = shift;
   my ( $name, $cb ) = @_;
   return $cb;
}

no_growth {
   my $f = Future::XS->new;
   $f->done( 123 );
   $f->result;
} 'Future::XS->new->done does not leak';

no_growth {
   my $f = Future::XS->new;
   $f->fail( "Oopsie\n" );
   $f->failure;
} 'Future::XS->new->fail does not leak';

no_growth {
   my $f = Future::XS->new;
   $f->cancel;
} 'Future::XS->new->cancel does not leak';

no_growth {
   my $fret = ( my $f1 = Future::XS->new )
      ->then( sub { Future::XS->done } );

   $f1->done;
   $fret->result;
} 'Future::XS->then does not leak';

no_growth {
   my $fret = ( my $f1 = Future::XS->done )
      ->then( sub { Future::XS->done } );

   $fret->result;
} 'Future::XS->then immediate does not leak';

no_growth {
   my $fret = ( my $f1 = Future::XS->new )
      ->else( sub { Future::XS->done } );

   $f1->done;
   $fret->result;
} 'Future::XS->else does not leak';

no_growth {
   my $fret = ( my $f1 = Future::XS->fail( "oopsie" ) )
      ->else( sub { Future::XS->done } );

   $fret->result;
} 'Future::XS->else does not leak';

no_growth {
   my $fret = ( my $f1 = Future::XS->new )
      ->followed_by( sub { Future::XS->done } );

   $f1->done;
   $fret->result;
} 'Future::XS->followed_by does not leak';

no_growth {
   my $fret = ( my $f1 = Future::XS->done )
      ->followed_by( sub { Future::XS->done } );

   $fret->result;
} 'Future::XS->followed_by immediate does not leak';

no_growth {
   my $fret = ( my $f1 = Future::XS->new )
      ->catch( fail => sub { Future::XS->done } );

   $f1->done;
   $fret->result;
} 'Future::XS->catch does not leak';

no_growth {
   my $fret = ( my $f1 = Future::XS->done )
      ->catch( fail => sub { Future::XS->done } );

   $fret->result;
} 'Future::XS->catch immediate does not leak';

no_growth {
   Future::XS->wait_all(
      Future::XS->new, Future::XS->new, Future::XS->new,
   )->cancel;
} 'Future::XS->wait_all on three subfutures does not leak';

no_growth {
   Future::XS->wait_any(
      Future::XS->new, Future::XS->new, Future::XS->new,
   )->cancel;
} 'Future::XS->wait_any on three subfutures does not leak';

no_growth {
   Future::XS->needs_all(
      Future::XS->new, Future::XS->new, Future::XS->new,
   )->cancel;
} 'Future::XS->needs_all on three subfutures does not leak';

no_growth {
   Future::XS->needs_any(
      Future::XS->new, Future::XS->new, Future::XS->new,
   )->cancel;
} 'Future::XS->needs_any on three subfutures does not leak';

no_growth {
   my $f = Future::XS->new;
   $f->set_label( "A string label here" );
} 'Future::XS->set_label does not leak';

no_growth {
   my $f = Future::XS->new;
   $f->set_udata( datum => [] );
} 'Future::XS->set_label does not leak';

# Test the compaction logic on revocation list
{
   my $f1 = Future::XS->new;

   no_growth {
      my $f2 = Future::XS->new;
      $f1->on_cancel( $f2 );
      $f2->cancel;
   } 'Future::XS on_cancel chaining does not grow';
}

done_testing;

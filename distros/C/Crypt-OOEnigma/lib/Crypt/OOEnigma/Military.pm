#!/usr/bin/perl -w
#
# Military.pm
#
# Copyright (c) 2002 Ambriel Consulting
# sjb Mon Mar 18 20:55:53 GMT 2002
#

package Crypt::OOEnigma::Military ;
$VERSION="0.3";
=head1 NAME

Crypt::OOEnigma::Military -  A military Enigma machine circa 1940.  It
differs from the Commercial Enigma in the addition of a plugboard before
the rotors.

=head1 SYNOPSIS

  use Crypt::OOEnigma::Military;
  # An Enigma with 3 default Rotors (with identity substitutions)
  my $enigma = new Crypt::OOEnigma::Military;

  # OR
  use Crypt::OOEnigma::Military;
  use Crypt::OOEnigma::Rotor;
  my @rotors = ()
  # Populate the list of Crypt::OOEnigma::Rotor
  Crypt::OOEnigma::Military->new( rotors => [@rotors] );

  # OR EVEN

  use Crypt::OOEnigma::Military;
  use Crypt::OOEnigma::Rotor;
  use Crypt::OOEnigma::Reflector;
  use Crypt::OOEnigma::Plugboard;
  my @rotors = ()
  # Populate the list of Crypt::OOEnigma::Rotor, see relevant pod
  my $reflector = new Crypt:OOEnigma::Reflector(params); # see relevant pod
  my $plugboard = new Crypt:OOEnigma::Plugboard(params); # see relevant pod
  Crypt::OOEnigma::Military->new( rotors => [@rotors],
                                  plugboard => $plugboard,
                                  reflector => $reflector);

  my $cipher = $enigma->encipher($mesg);
  my $decode = $enigma->encipher($cipher); # self-inverse

  # for internal use

  $enigma->init(); # returns the rotors to their initial state

=head1 DESCRIPTION

This module provides a Military Enigma machine which differs in that a
Plugboard is added before the Rotors.

You should usually create a Military Enigma with your own Plugboard,
Rotors and Reflector.

=head1 NOTES

None

=head1 BUGS and CAVEATS

=head2 Enigma is weak!

Cryptographers talk of the strength of a cryptographic algorithm in term of
whether it is computationally feasible to break it.  It is, of course,
computationally feasible to break an Enigma cipher so don't use it for
anything serious!

=head1 HISTORY

This package was created in spring 2002 as an exercise in OO Perl and
preparing modules properly for CPAN.  More importantly, the Enigma is
interesting.

CPAN already has a Crypt::Enigma which is not object oriented and implements
only one Enigma (whereas you can create any Enigma-like machine with these
objects).  Hence the package name Crypt::OOEnigma

=head1 SEE ALSO

The Pleasures of Counting, T W Korner, CUP 1996.  A great book for anyone with
the slightest interest in mathematics
  ISBN 0 521 56087 X hardback
  ISBN 0 521 56823 4 paperback 

Crypt::OOEnigma::Military

The components:
  Crypt::OOEnigma::Rotor
  Crypt::OOEnigma::Reflector
  Crypt::OOEnigma::Plugboard

=head1 AUTHOR

S J Baker, Ambriel Consulting, http://ambrielconsulting.com

=head1 COPYRIGHT

This package is licenced under the same terms as Perl itself.

=cut
use Carp ;
use Crypt::OOEnigma::Rotor ;
use Crypt::OOEnigma::Reflector ;
use Crypt::OOEnigma::Plugboard ;


# use Autoloading for accessors
use subs qw( rotors reflector plugboard  );

my %fields = (
  rotors          => undef,
  reflector       => undef,
  plugboard       => undef
);

sub new {
  my $invocant = shift ;
  my $class = ref($invocant) || $invocant ;
  my $self = { %fields, @_ } ; 
  bless $self, $class ;
  
  # only set valid rotors
  if( defined($self->rotors())){
    foreach my $r (@{$self->rotors()}){
      if(keys(%{$r->cipher()}) == 26){
        # This rotor is ok
      } else {
        croak("An invalid rotor was provided.");
      }
    }
  } else {
    # use three default rotors
    my $r1 = Crypt::OOEnigma::Rotor->new();
    my $r2 = Crypt::OOEnigma::Rotor->new();
    my $r3 = Crypt::OOEnigma::Rotor->new();
    $self->rotors([$r1, $r2, $r3]);
  }
  
  # only set a valid plugboard
  if( defined($self->plugboard()) ){
    if(keys(%{$self->plugboard()->cipher()}) == 26){
      # This plugboard is ok TODO: improve checking - self-inverse?
    } else {
      croak("An invalid plugboard was provided.");
    }
  } else {
    $self->plugboard(Crypt::OOEnigma::Plugboard->new());
  }
  
  # Reflector does not require setup
  $self->reflector(Crypt::OOEnigma::Reflector->new());
  
  $self->init();
  return $self ;
}

sub init {
  my $self = shift ; 
  # Initialise all the rotors
  foreach my $r (@{$self->rotors()}){
    $r->init();
  }
  # Plugboard and reflector require no initialisation
}


sub encipher {
  my $self = shift;
  my $work = shift ;
  $work    =~ s/\s/X/g;
  $work    = uc($work);
  my $result = "";
  my @rotors = @{$self->rotors()};

  foreach my $ch ( split //, $work ){
    # pass through plugboard
    $ch = $self->plugboard()->encode($ch);
    # encipher in every rotor
    foreach $r (@rotors){
      $ch = $r->encode($ch);
    }
    # reflect
    $ch = $self->reflector()->reflect($ch);
    # reverse encipher in every rotor
    foreach $r (reverse @rotors){
      $ch = $r->revencode($ch);
    }
    # nudge all the rotors
    foreach $r (@rotors){
      $r->next();
    }
    # pass through plugboard - self-inverse
    $ch = $self->plugboard()->encode($ch);
    $result .= $ch ;
  }

  $self->init();
  return $result;
}

sub AUTOLOAD {
  my $self = shift;
  # only access instance methods not class methods
  croak "$self is not an object" unless(ref($self));
  my $name = our $AUTOLOAD;
  return if($name =~ /::DESTROY/ );
  $name =~ s/.*://;   # strip fully-qualified portion
  unless (exists $self->{$name} ) {
    croak "Can't access `$name' field in object of class $self";
  } 
  if (@_) {
    return $self->{$name} = shift;
  } else {
    return $self->{$name};
  } 
}

1;

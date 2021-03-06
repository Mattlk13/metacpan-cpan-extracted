#!/usr/bin/perl

use v5.14;
use warnings;

use Test::More;

use Object::Pad;

role ARole {
   method one { return 1 }

   method own_cvname {
      return +(caller(0))[3];
   }
}

class AClass implements ARole {
}

{
   my $obj = AClass->new;
   isa_ok( $obj, "AClass", '$obj' );

   is( $obj->one, 1, 'AClass has a ->one method' );
   is( $obj->own_cvname, "AClass::own_cvname", '->own_cvname sees correct subname' );
}

role BRole {
   method two { return 2 }
}

class BClass implements ARole, BRole {
}

{
   my $obj = BClass->new;

   is( $obj->one, 1, 'BClass has a ->one method' );
   is( $obj->two, 2, 'BClass has a ->two method' );
   is( $obj->own_cvname, "BClass::own_cvname", '->own_cvname sees correct subname' );
}

role CRole {
   requires three;
}

class CClass implements CRole {
   method three { return 3 }
}

pass( 'CClass compiled OK' );

# Because we store embedding info in the pad of a method CV, we should check
# that recursion and hence CvDEPTH > 1 works fine
{
   role RecurseRole {
      method recurse {
         my ( $x ) = @_;
         return $x ? $self->recurse( $x - 1 ) + 1 : 0;
      }
   }

   class RecurseClass implements RecurseRole {}

   is( RecurseClass->new->recurse( 5 ), 5, 'role methods can be reëntrant' );
}

done_testing;

#!/usr/bin/env perl

package Prty::String::Test;
use base qw/Prty::Test::Class/;

use strict;
use warnings;
use v5.10.0;
use utf8;

# -----------------------------------------------------------------------------

sub test_loadClass : Init(1) {
    shift->useOk('Prty::String');
}

# -----------------------------------------------------------------------------

sub test_indent : Test(5) {
    my $self = shift;

    my $str1 = Prty::String->indent(<<'    __TEXT__');
    a b

    c d
    __TEXT__

    # mit Whitspace

    my $str2 = Prty::String->indent(<<'    __TEXT__');

    a b

    c d   
       
    __TEXT__

    # ~ der Sichtbarkeit wegen in Debug-Ausgabe

    my $res1 = $str1;
    $res1 =~ s/^(.)/~~$1/mg; # nur nicht-Leerzeilen einrücken

    my $res2 = $str1;
    $res2 =~ s/^/~~/mg; # alle Zeilen einrücken

    my $res3 = $res1;
    chomp $res3;

    my $val = Prty::String->indent($str1,'~~');
    $self->is($val,$res1);
    $self->isnt($val,$res2);

    $val = Prty::String->indent($str1,'~~',-indentBlankLines=>1);
    $self->is($val,$res2);
    $self->isnt($val,$res1);

    $val = Prty::String->indent($str2,'~~',-strip=>1);
    $self->is($val,$res3);
}

# -----------------------------------------------------------------------------

my $Ind1Str0 = '';
my $Ind1Str1 = ' ' x 8;
my $Ind1Str2 = <<'__STR__';
Dies
    ist
        ein
            Test
__STR__

sub test_determineIndentation : Test(3) {
    my $self = shift;

    my $n = Prty::String->determineIndentation($Ind1Str0);
    $self->is($n,0);

    $n = Prty::String->determineIndentation($Ind1Str1);
    $self->is($n,8);

    $n = Prty::String->determineIndentation($Ind1Str2);
    $self->is($n,4);
}

# -----------------------------------------------------------------------------

my $Ind2Str0 = '';
my $Ind2Str1a = '        x';
my $Ind2Str1b = '  x';
my $Ind2Str2a = <<'__STR__';
Dies
    ist
        ein
            Test
__STR__
my $Ind2Str2b = <<'__STR__';
Dies
  ist
    ein
      Test
__STR__

sub test_reduceIndentation : Test(3) {
    my $self = shift;

    my $str = Prty::String->reduceIndentation(2,$Ind2Str0);
    $self->is($str,$Ind2Str0);

    $str = Prty::String->reduceIndentation(2,$Ind2Str1a);
    $self->is($str,$Ind2Str1b);

    $str = Prty::String->reduceIndentation(2,$Ind2Str2a);
    $self->is($str,$Ind2Str2b);
}

# -----------------------------------------------------------------------------

my $IndStr1 = <<'__STR__';

    Dies ist
  ein Test-
  Text.

    Nächster
  Absatz

__STR__

my $IndStr2 =  <<'__STR__';
  Dies ist
ein Test-
Text.

  Nächster
Absatz
__STR__
chomp $IndStr2;

sub test_removeIndentation : Test(5) {
    my $self = shift;

    my $val = Prty::String->removeIndentation($IndStr1);
    $self->is($val,$IndStr2,'removeIndentation: String');

    my $str = $IndStr1;
    $val = Prty::String->removeIndentation(\$str);
    $self->is($str,$IndStr2,'removeIndentation: String-Ref');
    $self->is($val,undef,'removeIndentation: String-Ref');

    $str = undef;
    $val = Prty::String->removeIndentation(\$str);
    $self->is($str,undef,'removeIndentation: undef str');
    $self->is($val,undef,'removeIndentation: undef ret');
}

# -----------------------------------------------------------------------------

my $IndStr21 = <<'__STR__';

    Dies ist
  ein Test-
  Text.

    Nächster
  Absatz

__STR__

my $IndStr22 =  <<'__STR__';
  Dies ist
ein Test-
Text.

  Nächster
Absatz
__STR__

sub test_removeIndentationNl : Test(5) {
    my $self = shift;

    my $val = Prty::String->removeIndentationNl($IndStr21);
    $self->is($val,$IndStr22);

    my $str = $IndStr21;
    $val = Prty::String->removeIndentationNl(\$str);
    $self->is($str,$IndStr22);
    $self->is($val,undef);

    $str = undef;
    $val = Prty::String->removeIndentationNl(\$str);
    $self->is($str,undef);
    $self->is($val,undef);
}

# -----------------------------------------------------------------------------

my $Code1 = <<'__CODE__';
# Anfangs-
# Kommentar

sub x {
    my $self = shift;

    my $x = 1; # teilzeiliger Kommentar

    # noch
    # mehr
    # Kommentar

    return;
}

# eof
__CODE__

my $Result1 = <<'__CODE__';
sub x {
    my $self = shift;

    my $x = 1;

    return;
}
__CODE__

sub test_removeComments_1 : Test(1) {
    my $self = shift;

   my $code = Prty::String->removeComments($Code1,'#');
    $self->is($code,$Result1);
}

# -----------------------------------------------------------------------------

my $Code3 = <<'__CODE__';
# Dies ist
# ein Kommentar

sub myMethod {
    my $self = shift;
    # @_: $arg

    if ($x == $y) {
        # Dies ist ein Kommentar
        $x++;
    }
    elsif ($x) {
        # Dies ist ein Kommentar

        $y--;
    }
    else {
        $x--;

        # Dies ist ein Kommentar

        $y++;
    }

    return; # Dies ist ein Kommentar
}
__CODE__

my $Result3 = <<'__CODE__';
sub myMethod {
    my $self = shift;

    if ($x == $y) {
        $x++;
    }
    elsif ($x) {
        $y--;
    }
    else {
        $x--;

        $y++;
    }

    return;
}
__CODE__

sub test_removeComments_3 : Test(1) {
    my $self = shift;

    my $code = Prty::String->removeComments($Code3,'#');
    $self->is($code,$Result3);
}

# -----------------------------------------------------------------------------

my $Code2 = <<'__CODE__';
/*
    Setup Text
    und Farbe
*/

body {
    font-family: sans-serif; /* Font */
    font-size: 12px;
    /* Schriftfarbe */
    color: black; /* Hintergrund
                     Farbe */
    background: white;
}

/* Schluss-
   Kommentar */
__CODE__

my $Result2 = <<'__CODE__';
body {
    font-family: sans-serif;
    font-size: 12px;
    color: black;
    background: white;
}
__CODE__

sub test_removeComments_2 : Test(1) {
    my $self = shift;

    my $code = Prty::String->removeComments($Code2,'/*','*/');
    $self->is($code,$Result2);
}

# -----------------------------------------------------------------------------

sub test_wrap : Test(4) {
    my $self = shift;

    # Leerer Text

    my $txt = Prty::String->wrap('');
    $self->is($txt,'');

    # Einfacher Text

    my $t1 = "Dies ist ein Test mit einem kurzen Text.";
    my $r1 = "Dies ist ein\nTest mit\neinem kurzen\nText.";

    $txt = Prty::String->wrap($t1,-width=>12);
    $self->is($txt,$r1);

    # Text mit einem langen Wort

    my $t2 = "Dies ist ein ganzLangesWort in einem kurzen Text.";
    my $r2 = "Dies ist ein\nganzLangesWort\nin einem\nkurzen Text.";

    $txt = Prty::String->wrap($t2,-width=>12);
    $self->is($txt,$r2);

    # Text mit zusätzlichem Whitespace

    my $t3 = "   Dies  ist ein Test\n\nmit    einem\t kurzen Text. ";
    my $r3 = "Dies ist ein\nTest mit\neinem kurzen\nText.";

    $txt = Prty::String->wrap($t3,-width=>12);
    $self->is($txt,$r3);

}

# -----------------------------------------------------------------------------

package main;
Prty::String::Test->runTests;

# eof

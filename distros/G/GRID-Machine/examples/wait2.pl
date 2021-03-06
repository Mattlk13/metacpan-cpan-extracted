#!/usr/bin/perl -w
use strict;
use GRID::Machine;
use Data::Dumper;
$Data::Dumper::Indent = 1;

my $host = $ENV{GRID_REMOTE_MACHINE};
my $machine = GRID::Machine->new( host => $host );

my $p = $machine->fork( q{

   print "stdout: Hello from process $$. args = (@_)\n";
   print STDERR "stderr: Hello from process $$\n";

   use List::Util qw{sum};
   return { s => sum(@_), args => [ @_ ] };
 },
 args => [ 1..4 ],
);

my $p1 = $machine->fork( q{
   use List::Util qw{sum};
   return { s => sum(@_), args => [ @_ ] };
 },
 args => [ 1..9 ],
);

# GRID::Machine::Process objects are overloaded
print "Doing something while $p is still alive  ...\n" if $p; 

my $r = $machine->waitall();

print "Result object from process:\n",Dumper($r),"\n";
print "GRID::Machine::Process::Result objects are overloaded in a string context:\n$r\n";

$r = $machine->waitall();

print "Result from process:\n",Dumper($r),"\n";
print "GRID::Machine::Process::Result objects are overloaded in a string context:\n$r\n";

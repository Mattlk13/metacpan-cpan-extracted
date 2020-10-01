#!/usr/bin/env perl
#---AUTOPRAGMASTART---
use 5.020;
use strict;
use warnings;
use diagnostics;
use mro 'c3';
use English;
use Carp;
our $VERSION = 17;
use autodie qw( close );
use Array::Contains;
use utf8;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
#---AUTOPRAGMAEND---

# PAGECAMEL  (C) 2008-2016 Rene Schickbauer
# Developed under Artistic license

print "Searching files...\n";
my @files = (find_pm('lib'), find_pm('devscripts'), find_pm('example'));

print "Changing files:\n";
foreach my $file (@files) {
    if($file =~ /setcopyright/) {
        print "Skipping my own program\n";
        next;
    }
    print "Editing $file...\n";

    my @lines;
    open(my $ifh, "<", $file) or die($ERRNO);
    @lines = <$ifh>;
    close $ifh;

    open(my $ofh, ">", $file) or die($ERRNO);
    foreach my $line (@lines) {
        $line =~ s/\(C\)\ \d\d\d\d-\d\d\d\d\ Rene\ Schickbauer/\(C\) 2008-2020 Rene Schickbauer/ig;
        $line =~ s/\(C\)\ \d\d\d\d-\d\d\d\d\ by\ Rene\ Schickbauer/\(C\) 2008-2020 Rene Schickbauer/ig;
        print $ofh $line;
    }
    close $ofh;
}
print "Done.\n";
exit(0);



sub find_pm {
    my ($workDir) = @_;

    my @files;
    opendir(my $dfh, $workDir) or die($ERRNO);
    while((my $fname = readdir($dfh))) {
        next if($fname eq "." || $fname eq ".." || $fname eq ".hg");
        $fname = $workDir . "/" . $fname;
        if(-d $fname) {
            push @files, find_pm($fname);
        } elsif(($fname =~ /\.p[lm]$/i || $fname =~ /\.pod$/i) && -f $fname) {
            push @files, $fname;
        }
    }
    closedir($dfh);
    return @files;
}

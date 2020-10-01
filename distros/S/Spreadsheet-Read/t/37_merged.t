#!/usr/bin/perl

use strict;
use warnings;

use     Test::More;
require Test::NoWarnings;

use     Spreadsheet::Read;

my $parser = Spreadsheet::Read::parses ("xls") or
    plan skip_all => "No M\$-Excel parser found";

ok (my $ss = ReadData ("files/merged.xls", attr => 1)->[1], "Read merged xls");

is ($ss->{attr}[1][1]{merged}, 0, "unmerged A1");
is ($ss->{attr}[2][1]{merged}, 1, "  merged B1");
is ($ss->{attr}[3][1]{merged}, 1, "  merged C1");
is ($ss->{attr}[1][2]{merged}, 1, "  merged A2");
is ($ss->{attr}[2][2]{merged}, 1, "  merged B2");
is ($ss->{attr}[3][2]{merged}, 1, "  merged C2");
is ($ss->{attr}[1][3]{merged}, 1, "  merged A3");
is ($ss->{attr}[2][3]{merged}, 0, "unmerged B3");
is ($ss->{attr}[3][3]{merged}, 0, "unmerged C3");

is_deeply ($ss->{merged}, [[1,2,1,3],[2,1,3,2]], "Merged areas");

ok ($ss = Spreadsheet::Read->new ("files/merged.xls",
    attr => 1, merge => 1)->sheet (1), "Read merged xls");

is ($ss->attr (1, 1)->merged, 0,    "unmerged A1");
is ($ss->attr (2, 1)->merged, "B1", "  merged B1");
is ($ss->attr (3, 1)->merged, "B1", "  merged C1");
is ($ss->attr (1, 2)->merged, "A2", "  merged A2");
is ($ss->attr (2, 2)->merged, "B1", "  merged B2");
is ($ss->attr (3, 2)->merged, "B1", "  merged C2");
is ($ss->attr (1, 3)->merged, "A2", "  merged A3");
is ($ss->attr (2, 3)->merged, 0,    "unmerged B3");
is ($ss->attr (3, 3)->merged, 0,    "unmerged C3");

is ($ss->attr ("A1")->merged, 0,    "unmerged A1");
is ($ss->attr ("B1")->merged, "B1", "  merged B1");
is ($ss->attr ("C1")->merged, "B1", "  merged C1");
is ($ss->attr ("A2")->merged, "A2", "  merged A2");
is ($ss->attr ("B2")->merged, "B1", "  merged B2");
is ($ss->attr ("C2")->merged, "B1", "  merged C2");
is ($ss->attr ("A3")->merged, "A2", "  merged A3");
is ($ss->attr ("B3")->merged, 0,    "unmerged B3");
is ($ss->attr ("C3")->merged, 0,    "unmerged C3");

is_deeply ($ss->{merged}, [[1,2,1,3],[2,1,3,2]], "Merged areas");

is ($ss->merged_from ("A1"),	"",	"merged_from (A1)");
is ($ss->merged_from (1, 1),	"",	"merged_from (1, 1)");
is ($ss->merged_from ("B1"),	"B1",	"merged_from (B1)");
is ($ss->merged_from (2, 1),	"B1",	"merged_from (2, 1)");
is ($ss->merged_from ("C2"),	"B1",	"merged_from (C2)");
is ($ss->merged_from (3, 2),	"B1",	"merged_from (3, 2)");

# out of range
is ($ss->merged_from ("E5"),	undef,	"merged_from (E5)");

# illegal ID
is ($ss->merged_from (999),	undef,	"merged_from (999)");
is ($ss->merged_from ("9X"),	undef,	"merged_from (9X)");
is ($ss->merged_from (999, 99),	undef,	"merged_from (999, 99)");
is ($ss->merged_from (9, 9, 9),	undef,	"merged_from (9, 9, 9)");

done_testing;

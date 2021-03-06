#!/usr/bin/perl -w

# Copyright 2007, 2008, 2009, 2010 Kevin Ryde

# This file is part of Glib-Ex-ConnectProperties.
#
# Glib-Ex-ConnectProperties is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation; either version 3, or (at your option) any
# later version.
#
# Glib-Ex-ConnectProperties is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Glib-Ex-ConnectProperties.  If not, see <http://www.gnu.org/licenses/>.

use 5.010;
use strict;
use warnings;
use Glib::Ex::ConnectProperties;
use Gtk2;
use Gtk2 1.220; # 1.240 for find_child_property()

use FindBin;
my $progname = $FindBin::Script;

my $model = Gtk2::TreeStore->new ('Glib::String');
foreach my $str ('Item one',
                 'Item two',
                 'Item three',
                 'Item four',
                 'Item five') {
  $model->insert_with_values (undef, 9999, 0 => $str);
}
{
  my $iter = $model->iter_nth_child (undef, 2);
  $model->insert_with_values ($iter, 9999, 0 => 'Subitem one');
  $model->insert_with_values ($iter, 9999, 0 => 'Subitem two');
}

$model->signal_connect_after
  (row_deleted => sub {
     my ($model, $path) = @_;
     say "row-deleted: ",$path->to_string;
   });
$model->foreach (sub {
                   my ($model, $path, $iter) = @_;
                   say $path->to_string;
                   return 0; # continue
                 });

my $iter = $model->iter_nth_child (undef, 2);
$model->remove ($iter);

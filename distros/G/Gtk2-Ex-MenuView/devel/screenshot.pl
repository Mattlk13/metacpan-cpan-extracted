#!/usr/bin/perl -w

# Copyright 2008, 2009, 2010 Kevin Ryde

# This file is part of Gtk2-Ex-MenuView.
#
# Gtk2-Ex-MenuView is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation; either version 3, or (at your option) any later
# version.
#
# Gtk2-Ex-MenuView is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License along
# with Gtk2-Ex-MenuView.  If not, see <http://www.gnu.org/licenses/>.


# Usage: perl screenshot.pl [outputfile.png]
#
# Popup a MenuView and write it to the given output file in PNG format.
# The default output file is /tmp/screenshot.png
#
# Must manually wave the mouse over the submenu to make it display.  Then
# there's some weirdness needing $submenu->popup before its $submenu->window
# is set to get its root position ...

use 5.010;
use strict;
use warnings;
use File::Basename;
use FindBin;
use POSIX;
use Gtk2 1.220 '-init';
use Gtk2::Ex::MenuView;
use Gtk2::Ex::WidgetBits;


# PNG spec 11.3.4.2 suggests RFC822 (or rather RFC1123) for CreationTime
use constant STRFTIME_FORMAT_RFC822 => '%a, %d %b %Y %H:%M:%S %z';

my $progname = $FindBin::Script; # basename part
print "progname '$progname'\n";
my $output_filename = (@ARGV >= 1 ? $ARGV[0] : '/tmp/screenshot.png');

my $treestore = Gtk2::TreeStore->new ('Glib::String');
foreach my $str ('Row Zero',
                 'Row One',
                 'Row Two',
                 'Row Three',
                 'Row Four') {
  $treestore->set ($treestore->append(undef), 0 => $str);
}
{
  my $iter = $treestore->iter_nth_child (undef, 2);
  $treestore->insert_with_values ($iter, 9999, 0 => 'Sub-Row One');
  $treestore->insert_with_values ($iter, 9999, 0 => 'Sub-Row Two');
}

my $toplevel = Gtk2::Window->new('toplevel');
$toplevel->modify_bg ('normal', Gtk2::Gdk::Color->parse('black'));
$toplevel->set_default_size (500, 500);
$toplevel->signal_connect (destroy => sub { Gtk2->main_quit });
$toplevel->show_all;

my $menuview = Gtk2::Ex::MenuView->new (model => $treestore);

$menuview->signal_connect (item_create_or_update => \&do_item_create_or_update);
sub do_item_create_or_update {
  my ($menuview, $item, $treestore, $path, $iter) = @_;
  return Gtk2::MenuItem->new_with_label ($treestore->get_value ($iter, 0));
}

$toplevel->signal_connect
  (map_event => sub {
     $menuview->popup (undef, undef,
                       \&position_in_toplevel, undef,
                       1, 0);
     return Gtk2::EVENT_PROPAGATE;
   });
sub position_in_toplevel {
  my ($x, $y) = Gtk2::Ex::WidgetBits::get_root_position($toplevel);
  $x += 10;
  $y += 10;
  print "popup position $x,$y\n";
  return ($x, $y);
}

$menuview->signal_connect
  (map_event => sub {
     Glib::Timeout->add (3000, \&screenshot);
     return Gtk2::EVENT_PROPAGATE;
   });

sub screenshot {
  # system "xwd -id ".$toplevel->window->XID." >/tmp/screenshot.xwd";
  #      system "xwd -root >/tmp/screenshot.xwd";
  #      system "convert /tmp/screenshot.xwd /tmp/screenshot.png";
  # system "convert -crop 27,65,115,116 /tmp/screenshot.xwd /tmp/screenshot.png";
  my ($x, $y) = Gtk2::Ex::WidgetBits::get_root_position ($toplevel);

  my ($mx, $my) = Gtk2::Ex::WidgetBits::get_root_position ($menuview);
  print "menuview at $mx,$my\n";
  my ($mw, $mh) = $menuview->window->get_size;
  my $rx = $mx + $mw;
  my $ry = $my + $mh;

  my $submenu = $menuview->item_at_indices(2)->get_submenu;
  $submenu->popup (undef,undef,undef,undef,1,0);
  my $window = $submenu->window;
  { my ($sx, $sy) = Gtk2::Ex::WidgetBits::get_root_position ($submenu);
    print "submenu at ",($sx//'undef'),",",($sy//'undef'),
      " ",($window//'nowin'),"\n"; }
  my $req = $submenu->size_request;
  $rx += $req->width;

  $rx += 8;
  $ry += 10;
  my $width = $rx - $x;
  my $height = $ry - $y;

  my $screen = $toplevel->get_screen;
  my $rootwin = $screen->get_root_window;
  my $pixbuf = Gtk2::Gdk::Pixbuf->get_from_drawable ($rootwin,
                                                     undef, # colormap
                                                     $x,$y, 0,0,
                                                     $width, $height);
  $pixbuf->save
    ($output_filename, 'png',
     'tEXt::Title'         => 'MenuView Screenshot',
     'tEXt::Author'        => 'Kevin Ryde',
     'tEXt::Copyright'     => 'Copyright 2010 Kevin Ryde',
     'tEXt::Creation Time' => POSIX::strftime (STRFTIME_FORMAT_RFC822,
                                               localtime(time)),
     'tEXt::Description'   => 'A sample screenshot of a Gtk2::Ex::MenuView display',
     'tEXt::Software'      => "Generated by $progname",
     'tEXt::Homepage'      => 'http://user42.tuxfamily.org/gtk2-ex-menuview/index.html',
     # must be last or gtk 2.18 botches the text keys
     compression           => 9,
    );
  print "wrote $output_filename\n";

  Gtk2->main_quit;
  return 0; # Glib::SOURCE_REMOVE
}

$toplevel->show_all;
Gtk2->main;
exit 0



__END__

Glib::Timeout->add
  (1000,
   sub {
     my $submenu = $menuview->item_at_indices(2,0)->get_parent;
     $submenu->show_all;
   });


#        if (my $window = $submenu->window) {
#          ($mx, $my) = Gtk2::Ex::WidgetBits::get_root_position ($submenu);
#          ($mw, $mh) = $window->get_size;
#          $rx = max ($rx, $mx + $mw);
#          $ry = max ($ry, $mx + $mw);
#        }
#      }
     #      my $mpixbuf = Gtk2::Gdk::Pixbuf->get_from_drawable
     #        ($menuview->window,
     #         undef, # colormap
     #         0,0, 0,0,
     #         $menuview->window->get_size);
     #
     #      {
     #        my ($mx, $my) = Gtk2::Ex::WidgetBits::get_root_position($menuview);
     #        my $rx = $mx - $x;
     #        my $ry = $my - $y;
     #        print "at $rx,$ry\n";
     #        $mpixbuf->composite ($pixbuf,
     #                             $rx,$ry,$mpixbuf->get_width,$mpixbuf->get_height,
     #                             $rx,$ry,1,1,
     #                             'nearest',
     #                             255);
     #      }
     #          my $spixbuf = Gtk2::Gdk::Pixbuf->get_from_drawable
     #            ($window,
     #             undef, # colormap
     #             0,0, 0,0,
     #             $window->get_size);
     #
     #          {
     #            my ($mx, $my) = Gtk2::Ex::WidgetBits::get_root_position($submenu);
     #            my $rx = $mx-$x;
     #            my $ry = $my-$y;
     #            print "submenu at $rx,$ry\n";
     #            $spixbuf->composite ($pixbuf,
     #                                 $rx,$ry,$mpixbuf->get_width,$mpixbuf->get_height,
     #                                 $rx,$ry,1,1,
     #                                 'nearest',
     #                                 255);
     #          }
     #        }
     #      }

     #      my ($width, undef) = Gtk2::Ex::WidgetBits::get_root_position($submenu);
     #      $width -= $x;
     #      $width += $submenu->allocation->width + 10;
     #
     #      my (undef, $height) = Gtk2::Ex::WidgetBits::get_root_position($menuview);
     #      $height -= $y;
     #      $height += $menuview->allocation->height + 10;
     #
     #      print "$x,$y ${width}x$height\n";

# Glib::Timeout->add
#   (1000,
#    sub {
#      my $item = $menuview->item_at_indices(2);
#      print "item 2: $item ",$item->get_child->get_text, "\n";
#      # $item->get_submenu->popup ($menuview, $item, undef, undef, 0, 0);
#      # $item->activate;
#
#      Gtk2::Ex::WidgetBits::warp_pointer ($item->get_child, 200, 200);
#
#      #      my ($x, $y) = Gtk2::Ex::WidgetBits::get_root_position($menuview);
#      #      print "menu position $x,$y\n";
#      #      ($x, $y) = Gtk2::Ex::WidgetBits::get_root_position($item);
#      #      print "item position $x,$y\n";
#      #      print "item alloc ",$item->get_child->allocation->x,",",$item->get_child->allocation->y,"\n";
#      #      $x += 40;
#      #      $y += 45;
#      #      my $screen = $item->get_screen;
#      #      my $display = $screen->get_display;
#      #      $display->warp_pointer ($screen, $x, $y);
#    });
# Glib::Timeout->add
#   (3500,
#    sub {
#      my $item = $menuview->item_at_indices(2);
#      Gtk2::Ex::WidgetBits::warp_pointer ($item->get_child, 40,45);
#    });


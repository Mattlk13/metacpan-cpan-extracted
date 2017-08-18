# ABSTRACT: Pages that are converted during the output process


package HiD::Page;
our $AUTHORITY = 'cpan:GENEHACK';
$HiD::Page::VERSION = '1.991';
use Moose;
with 'HiD::Role::IsConverted';
with 'HiD::Role::IsPublished';
use namespace::autoclean;

use 5.014;  # strict, unicode_strings
use utf8;
use autodie;
use warnings    qw/ FATAL  utf8     /;
use open        qw/ :std  :utf8     /;
use charnames   qw/ :full           /;

use Path::Tiny;


sub get_default_layout { 'default' }


sub publish {
  my $self = shift;

  my $out = path( $self->output_filename );
  my $dir = $out->parent;

  $dir->mkpath unless $dir->is_dir;

  $out->spew_utf8( $self->rendered_content );
}

# used to populate the 'url' attr in Role::IsPublished
sub _build_url {
  my $self = shift;

  my $format = $self->get_metadata( 'permalink' ) // 'none';

  my $source = $self->source;

  my $path_frag = $self->input_path;
  $path_frag =~ s/^$source//;
  $path_frag ||= Path::Tiny->rootdir();

  my $naive = path( $path_frag , $self->basename() );

  my %_valid_exts = map { $_=>1 } qw(rss xml html htm xhtml xhtm shtml shtm);
  my $ext = exists $_valid_exts{$self->ext} ? $self->ext : 'html';

  my $url;

  if(    $format eq 'none'   ) { $url = $naive . ".$ext" }
  elsif( $format eq 'pretty' ) { $url = $naive . '/'     }
  else                         { $url = "/$format"       }

  $url =~ s|//+|/|g;

  return $url;
}

__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

HiD::Page - Pages that are converted during the output process

=head1 SYNOPSIS

    my $page = HiD::Page->new({
      dest_dir       => 'path/to/output/dir' ,
      hid            => $hid_object ,
      input_filename => 'path/to/page/file' ,
      layouts        => $hash_of_hid_layout_objects,
    });

=head1 DESCRIPTION

Class representing a "page" object -- i.e., a file that is not a blog post,
but that is still processed (e.g., converted from Markdown or Textile to HTML
and run through a layout rendering step) during publication.

=head1 METHODS

=head2 get_default_layout

Get the name of the default page layout. (The default is 'default'.)

=head2 publish

Publish -- convert, render through any associated layouts, and write out to
disk -- this data from this object.

=head1 NOTE

Also consumes L<HiD::Role::IsConverted> and L<HiD::Role::IsPublished>; see
documentation for that role as well if you're trying to figure out how an
object from this class works.

=head1 VERSION

version 1.991

=head1 AUTHOR

John SJ Anderson <genehack@genehack.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by John SJ Anderson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

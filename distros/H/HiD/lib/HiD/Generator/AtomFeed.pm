# ABSTRACT: Atom feed generator


package HiD::Generator::AtomFeed;
our $AUTHORITY = 'cpan:GENEHACK';
$HiD::Generator::AtomFeed::VERSION = '1.98';
use Moose;
with 'HiD::Generator';

use 5.014; # strict, unicode_strings

use DateTime;
use XML::Feed;
use XML::Feed::Entry;

use HiD::VirtualPage;


sub generate {
  my( $self , $site ) = @_;

  if ( exists $site->config->{atom_feed} && ref $site->config->{atom_feed} ne 'HASH' ){
    $site->WARN( "Using deprecated atom_feed config! Please see docs on how to update!" );

    $site->config->{atom_feed} = _upgrade_atom_config( $site->config );
  }

  return unless $site->config->{atom_feed}{generate};

  my $destination = $site->config->{atom_feed}{destination};
  my $post_limit  = $site->config->{atom_feed}{posts} // 20;
  my $post_count  = 1;

  my $feed = $self->_new_feed($site);

 POST: for my $post( @{ $site->posts }) {
    $feed->add_entry($self->_new_entry($post));

    $post_count++;
    last POST if $post_count > $post_limit;
  }

  # XML::Feed (I suspect, really XML::Atom) plays silly buggers with the UTF-8
  # flag...
  my $xml_feed = $feed->as_xml;
  utf8::decode($xml_feed)  # in place
      or die "Unable to properly decode feed";

  my $feed_page = HiD::VirtualPage->new({
    output_filename => $site->destination . $destination ,
    content         => $xml_feed ,
  });

  $site->add_input( "ATOM FEED" => 'page' );
  $site->add_object( $feed_page );

  $site->INFO( "* Injected Atom feed");
}

sub _new_entry {
  my( $self , $post ) = @_;

  my $entry = XML::Feed::Entry->new('Atom');
  $entry->title($post->title);
  $entry->author($post->author);
  $entry->link($post->url);
  $entry->id($post->baseurl . $post->url);
  $entry->modified($post->date);
  $entry->summary($post->description) if $post->description;
  $entry->content($post->converted_content);

  return $entry;
}

sub _new_feed {
  my( $self , $site ) = @_;

  my $feed  = XML::Feed->new('Atom');
  my $title = $site->config->{atom_feed}{title} // $site->config->{title};
  $feed->title( $title );

  $feed->base( $site->config->{atom_feed}{base} )
    if $site->config->{atom_feed}{base};

  if( $site->config->{atom_feed}{link}) {
    $feed->link( $site->config->{atom_feed}{link} );
    $feed->id( $site->config->{atom_feed}{link} );
  }

  $feed->modified(DateTime->now());

  return $feed;
}


sub _upgrade_atom_config {
  my( $old_config ) = @_;

  my $new_config = {
    generate    => 1 ,
    destination => $old_config->{atom_feed}
  };

  foreach (qw/ base link posts title /) {
    if ( exists $old_config->{"atom_feed_$_"} ) {
      $new_config->{$_} = $old_config->{"atom_feed_$_"}
    };
  }

  return $new_config;
}

__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

HiD::Generator::AtomFeed - Atom feed generator

=head1 DESCRIPTION

This Generator produces an Atom feed of your posts.

Enable it by setting the 'atom_feed.generate' key in your config to 1. Also
set an 'atom_feed.destination' key indicating where the feed should be
generated.

You may also set optional 'atom_feed.base' and 'atom_feed.link' keys to set
the 'rel=alternate' base link and the 'rel=self' link to the atom feed,
respectively.

The 'atom.title' config key can be used to give the feed a title. Otherwise
the site title will be used.

The 'atom.posts' config key can be used to control the number of posts in the
feed. It defaults to 20.

=head2 DEPRECATED CONFIG

This module formerly used different config keys. If this older configuration
is detected, a warning will be emitted and the configuration will be
internally upgraded to the new format. If you wish to silence this warning,
convert your config to use these new keys:

    OLD                   NEW
    atom_feed ----------> atom_feed.generate
                    *AND* atom_feed.destination
    atom_feed_base  ----> atom_feed.base
    atom_feed_link  ----> atom_feed.link
    atom_feed_posts ----> atom_feed.posts
    atom_feed_title ----> atom_feed.title

See the documentation above to understand what each key controls.

=head1 METHODS

=head2 generate

=head1 VERSION

version 1.98

=head1 AUTHOR

John SJ Anderson <genehack@genehack.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by John SJ Anderson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

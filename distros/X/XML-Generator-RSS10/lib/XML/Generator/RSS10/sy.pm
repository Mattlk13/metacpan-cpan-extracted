package XML::Generator::RSS10::sy;
{
  $XML::Generator::RSS10::sy::VERSION = '0.02';
}

use strict;

use base 'XML::Generator::RSS10::Module';

sub NamespaceURI { 'http://purl.org/rss/1.0/modules/syndication/' }

1;

# ABSTRACT: Support for the Syndication (sy) RSS 1.0 module



=pod

=head1 NAME

XML::Generator::RSS10::sy - Support for the Syndication (sy) RSS 1.0 module

=head1 VERSION

version 0.02

=head1 SYNOPSIS

    use XML::Generator::RSS10;

    my $rss = XML::Generator::RSS10->new( Handler => $sax_handler );

    $rss->item( title => 'Exciting News About my Pants!',
                link  => 'http://pants.example.com/my/news.html',
                description => 'My pants are full of ants!',
              );

    $rss->channel( title => 'Pants',
                   link  => 'http://pants.example.com/',
                   description => 'A fascinating pants site',
                   sy    => { updatePeriod    => 'hourly',
                              updateFrequency => 2,
                            },
                 );

=head1 DESCRIPTION

This module provides support for the Syndication (sy) RSS 1.0 module.

=head1 PARAMETERS

This module handles all of the Syndication elements: "updatePeriod",
"updateFrequency", and "updateBase".

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Dave Rolsky.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut


__END__


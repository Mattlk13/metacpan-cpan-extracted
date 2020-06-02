package Media::Info;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2020-06-02'; # DATE
our $DIST = 'Media-Info'; # DIST
our $VERSION = '0.132'; # VERSION

use 5.010001;
use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
                       get_media_info
               );

our %SPEC;

sub _type_from_name {
    require Filename::Audio;
    require Filename::Video;
    require Filename::Image;
    my $name = shift;

    Filename::Video::check_video_filename(filename => $name) ? "video" :
    Filename::Audio::check_audio_filename(filename => $name) ? "audio" :
    Filename::Image::check_image_filename(filename => $name) ? "image" : "unknown";
}

$SPEC{get_media_info} = {
    v => 1.1,
    summary => 'Return information on media file/URL',
    args => {
        media => {
            summary => 'Media file/URL',
            description => <<'_',

Note that not every backend can retrieve URL. At the time of this writing, only
the Mplayer backend can.

Many fields will depend on the backend used. Common fields returned include:

* `backend`: the `Media::Info::*` backend module used, e.g. `Ffmpeg`.
* `type_from_name`: either `image`, `audio`, `video`, or `unknown`. This
  is determined from filename (extension).


_
            schema  => 'str*',
            pos     => 0,
            req     => 1,
        },
        backend => {
            summary => "Choose specific backend",
            schema  => ['str*', match => '\A\w+\z'],
            completion => sub {
                require Complete::Module;

                my %args = @_;
                Complete::Module::complete_module(
                    word => $args{word},
                    ns_prefix => 'Media::Info',
                );
            },
        },
    },
};
sub get_media_info {
    no strict 'refs';

    my %args = @_;

    my @backends;
    if ($args{backend}) {
        @backends = ($args{backend});
    } else {
        @backends = qw(Ffmpeg Mplayer Mediainfo);
    }

    # try the first backend that succeeds
    for my $backend (@backends) {
        my $mod;
        my $mod_pm;
        if ($backend =~ /\A\w+\z/) {
            $mod    = "Media::Info::$backend";
            $mod_pm = "Media/Info/$backend.pm";
        } else {
            return [400, "Invalid backend '$backend'"];
        }
        next unless eval { require $mod_pm; 1 };
        my $func = \&{"$mod\::get_media_info"};
        my $res = $func->(media => $args{media});
        if ($res->[0] == 200) {
            # add some common fields

            # backend
            $res->[3]{'func.backend'} = $backend;
            $res->[2]{backend} = $backend;
            $res->[2]{type_from_name} = _type_from_name($args{media});

            # video_longest_side, video_shortest_side, video_orientation (if not set by backend)
            if ($res->[2]{video_height} && $res->[2]{video_width}) {
                if ($res->[2]{video_height} > $res->[2]{video_width}) {
                    $res->[2]{video_longest_side}  = $res->[2]{video_height};
                    $res->[2]{video_shortest_side} = $res->[2]{video_width};
                    $res->[2]{video_orientation} = 'portrait' unless $res->[2]{video_orientation};
                } else {
                    $res->[2]{video_longest_side}  = $res->[2]{video_width};
                    $res->[2]{video_shortest_side} = $res->[2]{video_height};
                    $res->[2]{video_orientation} = 'landscape' unless $res->[2]{video_orientation};
                }
            }
        }
        return $res unless $res->[0] == 412;
    }

    if ($args{backend}) {
        return [412, "Backend '$args{backend}' not available, please install it first"];
    } else {
        return [412, "No Media::Info::* backends available, please install one"];
    }
}

1;
# ABSTRACT: Return information on media file/URL

__END__

=pod

=encoding UTF-8

=head1 NAME

Media::Info - Return information on media file/URL

=head1 VERSION

This document describes version 0.132 of Media::Info (from Perl distribution Media-Info), released on 2020-06-02.

=head1 SYNOPSIS

 use Media::Info qw(get_media_info);
 my $res = get_media_info(media => '/path/to/celine.mp4');

Sample result:

 [
   200,
   "OK",
   {
     audio_bitrate => 128000,
     audio_format  => 85,
     audio_rate    => 44100,
     duration      => 2081.25,
     num_channels  => 2,
     num_chapters  => 0,
   },
   {
     "func.raw_output" => "ID_AUDIO_ID=0\n...",
   },
 ]

=head1 DESCRIPTION

This module provides a common interface for Media::Info::* modules, which you
can use to get information about a media file (like video, music, etc) using
specific backends. Currently the available backends include
L<Media::Info::Mplayer>, L<Media::Info::Ffmpeg>, L<Media::Info::Mediainfo>.

=head1 FUNCTIONS


=head2 get_media_info

Usage:

 get_media_info(%args) -> [status, msg, payload, meta]

Return information on media fileE<sol>URL.

This function is not exported by default, but exportable.

Arguments ('*' denotes required arguments):

=over 4

=item * B<backend> => I<str>

Choose specific backend.

=item * B<media>* => I<str>

Media fileE<sol>URL.

Note that not every backend can retrieve URL. At the time of this writing, only
the Mplayer backend can.

Many fields will depend on the backend used. Common fields returned include:

=over

=item * C<backend>: the C<Media::Info::*> backend module used, e.g. C<Ffmpeg>.

=item * C<type_from_name>: either C<image>, C<audio>, C<video>, or C<unknown>. This
is determined from filename (extension).

=back


=back

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (payload) is optional, the actual result. Fourth
element (meta) is called result metadata and is optional, a hash
that contains extra information.

Return value:  (any)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Media-Info>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Media-Info>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Media-Info>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Video::Info> - C<Media::Info> is first written because I couldn't install
Video::Info. That module doesn't seem maintained (last release is in 2003 at the
time of this writing), plus I want a per-backend namespace organization instead
of per-format one, and a simple functional interface instead of OO interface.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020, 2019, 2016, 2015, 2014, 2013 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

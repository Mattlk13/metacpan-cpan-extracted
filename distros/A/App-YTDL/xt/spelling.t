use 5.010000;
use strict;
use warnings;
use Test::More;

use Test::Spelling;


add_stopwords(<DATA>);

all_pod_files_spelling_ok( 'bin', 'lib' );


__DATA__
YouTube
youtube
dl
ids
playlists
playlist
Kuerbis
UserAgent
useragent
stackoverflow
Vimeo
vimeo
getvideo
ffmpeg
ffprobe
unmappable
Unmappable
Uploader
Uploaders
netrc
uploader
uploaders

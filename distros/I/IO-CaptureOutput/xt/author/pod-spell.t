use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.007005
use Test::Spelling 0.12;
use Pod::Wordlist;


add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib ) );
__DATA__
Atria
CaptureOutput
Cook
David
Flack
Golden
IO
Joaquín
José
Latimer
Mengué
Mike
Olivier
Simon
Tony
and
dagolden
dolmen
jjatria
lib
mlatimer
simonflk
tony
xdg

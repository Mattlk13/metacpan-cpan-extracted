use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.007005
use Test::Spelling 0.12;
use Pod::Wordlist;

set_spell_cmd('aspell list');
add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib ) );
__DATA__
Brian
CPAN
Chase
Daemon
Dave
David
Dubois
Håkon
Hægland
Jan
Konojacki
Mengué
MidLifeXis
Olivier
Roth
Steinbrunner
Tomasz
Whitener
Wightman
Win32
capoeirab
daveroth
dolmen
dsteinbrunner
github
hakon
jand
lib
me

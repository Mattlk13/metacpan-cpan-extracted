use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.007005
use Test::Spelling 0.12;
use Pod::Wordlist;


add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib ) );
__DATA__
AWS
Alders
Alders'
CreateZip
Eilam
Eilam's
Fowler
Lambda
MAXMIND
MAXMIND's
Mark
MaxMind
MaxMind's
Oschwald
Oschwald's
PayPal
Processor
Quick
Rolsky
Rolsky's
Upload
lib
mark

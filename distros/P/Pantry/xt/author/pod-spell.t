use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.002005
eval "use Test::Spelling 0.12; use Pod::Wordlist::hanekomu; 1" or die $@;


add_stopwords(<DATA>);
all_pod_files_spelling_ok('bin', 'lib');
__DATA__
DNS
OpenSSH
Opscode
ROADMAP
littlechef
runlist
runlists
subclasses
subcommand
subkeys
subshell
thawer
webserver
wildcard
David
Golden
lib
Pantry
App
Model
Cookbook
Command
show
rename
create
init
Util
list
strip
Node
sync
EnvRunList
edit
Role
Serializable
Environment
apply
Runlist
delete
DataBag

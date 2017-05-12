#!/bin/bash
SRC=script/perl-build
DST=perl-build
export PLENV_VERSION=5.8.5
export PERL5LIB=`dirname $0`/../lib/

plenv install-cpanm

cpanm Test::More
cpanm Perl::Strip
cpanm App::FatPacker
cpanm CPAN::Perl::Releases File::pushd HTTP::Tiny Devel::PatchPerl File::Temp Getopt::Long Pod::Usage

fatpack trace $SRC
fatpack packlists-for `cat fatpacker.trace` >packlists
fatpack tree `cat packlists`

if type perlstrip >/dev/null 2>&1; then
    find fatlib -type f -name '*.pm' |grep -v 'Pod/Simple/BlackBox.pm'|xargs -n1 perlstrip -s
fi

(echo "#!/usr/bin/env perl"; fatpack file; cat $SRC) > $DST
perl -pi -e 's|^#!/usr/bin/perl|#!/usr/bin/env perl|' $DST
chmod +x $DST


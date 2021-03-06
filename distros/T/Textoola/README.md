# Textoola

# DESCRIPTION

A set of text analysis and manipulation tools like

  * textpatterndiff.pl : show the text pattern change between two texts
  * textpatternstats.pl : show statistics in text pattern change between multiple texts

# DISTRIBUTION

Textoola can be installed
 1.  as a binary package (a rpm-file generated by Dist::Zilla) 
 2.  or by unpacking a .tar.gz file and using Perls traditional Makefile.PL approach

# BUILD REQUIREMENTS

Installation of Perl-packages 
  * Dist::Zilla
  * Dist::Zilla::Plugin::Git
  * Dist::Zilla::Plugin::RPM
  * Dist::Zilla::Plugin::CopyFilesFromBuild
  * Test::Exception
  * Test::More

Other requirements:
  * the tool 'rpmbuild'
  * an valid rpmbuild-directory setup

# Build, release and deploy as rpm with Dist::Zilla

## Build base-package

With Dist::Zilla the build of the binary base-packages

    > dzil build

## Test build-artefacts

Testing the artefacts before distribution can be done by writing

    > dzil test

## Releasing the rpm and code-changes

    > dzil release

When releasing it will

 1. tag the local git repository
 2. push git commits to origin repository
 3. generate automatically a rpm (Textoola-<version>.noarch.rpm ) for distribution / installation under the rpmbuild-destination (~/rpmbuild/RPMS/noarch/)

## Deployment of the rpm-file

On the RPM-based Linux host the rpm can be installed either by the rpm-tool

    > rpm -i Textoola-<version>.noarch.rpm

or by yum, when the rpm is placed in accessible your repository

    > yum install Textoola

# Build and deploy by traditional Makefile.PL approach


## Building the binary package (.tar.gz)

Unpack the .tar.gz file and run

    > perl Makefile.PL
    > make test
    > make

## Install the binary package

Unpack the .tar.gz file and run

    > perl Makefile.PL
    > make test
    > make install

# SEE ALSO

Unix man-pages are generated or perldoc-pages in source code can be browsed about following themes 

  * textpatterndiff.pl : show the text pattern change between two texts
  * textpatternstats.pl : show statistics in text pattern change between multiple texts

# LICENSE

See LICENSE file.

# AUTHORS

 *  Sascha Dibbern [http://sascha.dibbern.info/](http://sascha.dibbern.info/)
    (email: sascha at dibbern.info)


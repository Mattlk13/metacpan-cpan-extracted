#!/bin/bash

perl -pe '/^=head1 DESCRIPTION/ and print <STDIN>' \
     lib/Apache2/ScoreBoardFile.pm >README.pod <<EOF
=head1 INSTALLATION

 perl Makefile.PL -apxs /path/to/apxs
 make
 make test
 make install

EOF

perldoc -tU README.pod >README
rm README.pod

#!/usr/bin/perl -w
#########################################################
# Sample Program for Perl Module "Shell::POSIX::Select" #
#  tim@TeachMePerl.com  (888) DOC-PERL  (888) DOC-UNIX  #
#  Copyright 2002-2003, Tim Maher. All Rights Reserved  #
#########################################################
 use Shell::POSIX::Select ;

# Extract man-page names from the TOC portion of the output of "perldoc perl"
select $manpage ( sort ( `perldoc perl` =~ /^\s+(perl\w+)\s/mg) ) {
    system "perldoc '$manpage'" ;
}

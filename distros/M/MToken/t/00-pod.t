#!/usr/bin/perl -w
#########################################################################
#
# Serz Minus (Sergey Lepenkov), <abalama@cpan.org>
#
# Copyright (C) 1998-2019 D&D Corporation. All Rights Reserved
#
# This is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.
#
# $Id: 00-pod.t 54 2019-06-03 16:37:49Z minus $
#
#########################################################################
use strict;
use Test::More;

my $ver = 1.22; # Ensure a recent version of Test::Pod
eval "use Test::Pod $ver";
plan skip_all => "Test::Pod $ver required for testing POD" if $@;
all_pod_files_ok();

1;
__END__

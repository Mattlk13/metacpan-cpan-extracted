# -*- Mode: Makefile -*-
#
# Makefile.am - automake file for Rasqal tests
#
# $Id: Makefile.am 11293 2006-09-23 20:27:59Z dajobe $
#
# Copyright (C) 2004-2006, David Beckett http://purl.org/net/dajobe/
# Copyright (C) 2004-2004, University of Bristol, UK http://www.bristol.ac.uk/
# 
# This package is Free Software and part of Redland http://librdf.org/
# 
# It is licensed under the following three licenses as alternatives:
#   1. GNU Lesser General Public License (LGPL) V2.1 or any newer version
#   2. GNU General Public License (GPL) V2 or any newer version
#   3. Apache License, V2.0 or any newer version
# 
# You may not use this file except in compliance with at least one of
# the above three licenses.
# 
# See LICENSE.html or LICENSE.txt at the top of this package for the
# complete terms and further detail along with the license texts for
# the licenses in COPYING.LIB, COPYING and LICENSE-2.0.txt respectively.
# 

local_tests=rasqal_order_test

SUBDIRS= engine
if RASQAL_QUERY_RDQL
SUBDIRS += rdql
endif
if RASQAL_QUERY_SPARQL
SUBDIRS += sparql
endif

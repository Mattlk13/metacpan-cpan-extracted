#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< PARSE_ERROR: 'ERROR ECOPARP00' >>>
# <<< PARSE_ERROR: 'Unexpected Token:  <<< NO TOKEN FOUND >>>' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use types;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my hashref::hashref $hash_hash = {
    key0 => my hashref::integer $TYPED_key0 = { a => 17, b => -23, c => 1_701 },
    key1 => my hashref::number $TYPED_key1 = { d => 42 / 1_701, e => 21.12, f => 2_112.23 },
    key2 => my hashref::string $TYPED_key2 = { g => 'strings are scalars, too', h => 'hello world', i => 'last one' }
    }

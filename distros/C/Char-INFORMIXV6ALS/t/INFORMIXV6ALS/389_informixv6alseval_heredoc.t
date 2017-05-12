# encoding: INFORMIXV6ALS
# This file is encoded in INFORMIX V6 ALS.
die "This file is not encoded in INFORMIX V6 ALS.\n" if q{��} ne "\x82\xa0";

use INFORMIXV6ALS;

print "1..12\n";

# INFORMIXV6ALS::eval <<END has INFORMIXV6ALS::eval "..."
if (INFORMIXV6ALS::eval <<END) {
INFORMIXV6ALS::eval " if ('�A�\' !~ /A/) { return 1 } else { return 0 } "
END
    print qq{ok - 1 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 1 $^X @{[__FILE__]}\n};
}

# INFORMIXV6ALS::eval <<END has INFORMIXV6ALS::eval qq{...}
if (INFORMIXV6ALS::eval <<END) {
INFORMIXV6ALS::eval qq{ if ('�A�\' !~ /A/) { return 1 } else { return 0 } }
END
    print qq{ok - 2 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 2 $^X @{[__FILE__]}\n};
}

# INFORMIXV6ALS::eval <<END has INFORMIXV6ALS::eval '...'
if (INFORMIXV6ALS::eval <<END) {
INFORMIXV6ALS::eval ' if (qq{�A�\} !~ /A/) { return 1 } else { return 0 } '
END
    print qq{ok - 3 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 3 $^X @{[__FILE__]}\n};
}

# INFORMIXV6ALS::eval <<END has INFORMIXV6ALS::eval q{...}
if (INFORMIXV6ALS::eval <<END) {
INFORMIXV6ALS::eval q{ if ('�A�\' !~ /A/) { return 1 } else { return 0 } }
END
    print qq{ok - 4 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 4 $^X @{[__FILE__]}\n};
}

# INFORMIXV6ALS::eval <<END has INFORMIXV6ALS::eval $var
my $var = q{q{ if ('�A�\' !~ /A/) { return 1 } else { return 0 } }};
if (INFORMIXV6ALS::eval <<END) {
INFORMIXV6ALS::eval $var
END
    print qq{ok - 5 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 5 $^X @{[__FILE__]}\n};
}

# INFORMIXV6ALS::eval <<END has INFORMIXV6ALS::eval (omit)
$_ = "if ('�A�\' !~ /A/) { return 1 } else { return 0 }";
if (INFORMIXV6ALS::eval <<END) {
INFORMIXV6ALS::eval
END
    print qq{ok - 6 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 6 $^X @{[__FILE__]}\n};
}

# INFORMIXV6ALS::eval <<END has INFORMIXV6ALS::eval {...}
if (INFORMIXV6ALS::eval <<END) {
INFORMIXV6ALS::eval { if ('�A�\' !~ /A/) { return 1 } else { return 0 } }
END
    print qq{ok - 7 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 7 $^X @{[__FILE__]}\n};
}

# INFORMIXV6ALS::eval <<END has "..."
if (INFORMIXV6ALS::eval <<END) {
if ('�A�\' !~ /A/) { return \"1\" } else { return \"0\" }
END
    print qq{ok - 8 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 8 $^X @{[__FILE__]}\n};
}

# INFORMIXV6ALS::eval <<END has qq{...}
if (INFORMIXV6ALS::eval <<END) {
if ('�A�\' !~ /A/) { return qq{1} } else { return qq{0} }
END
    print qq{ok - 9 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 9 $^X @{[__FILE__]}\n};
}

# INFORMIXV6ALS::eval <<END has '...'
if (INFORMIXV6ALS::eval <<END) {
if ('�A�\' !~ /A/) { return '1' } else { return '0' }
END
    print qq{ok - 10 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 10 $^X @{[__FILE__]}\n};
}

# INFORMIXV6ALS::eval <<END has q{...}
if (INFORMIXV6ALS::eval <<END) {
if ('�A�\' !~ /A/) { return q{1} } else { return q{0} }
END
    print qq{ok - 11 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 11 $^X @{[__FILE__]}\n};
}

# INFORMIXV6ALS::eval <<END has $var
my $var1 = 1;
my $var0 = 0;
if (INFORMIXV6ALS::eval <<END) {
if ('�A�\' !~ /A/) { return $var1 } else { return $var0 }
END
    print qq{ok - 12 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 12 $^X @{[__FILE__]}\n};
}

__END__

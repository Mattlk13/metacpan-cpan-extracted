# encoding: UHC
# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;

print "1..12\n";

# UHC::eval <<'END' has UHC::eval "..."
if (UHC::eval <<'END') {
UHC::eval " if ('�A�\' !~ /A/) { return 1 } else { return 0 } "
END
    print qq{ok - 1 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 1 $^X @{[__FILE__]}\n};
}

# UHC::eval <<'END' has UHC::eval qq{...}
if (UHC::eval <<'END') {
UHC::eval qq{ if ('�A�\' !~ /A/) { return 1 } else { return 0 } }
END
    print qq{ok - 2 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 2 $^X @{[__FILE__]}\n};
}

# UHC::eval <<'END' has UHC::eval '...'
if (UHC::eval <<'END') {
UHC::eval ' if (qq{�A�\} !~ /A/) { return 1 } else { return 0 } '
END
    print qq{ok - 3 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 3 $^X @{[__FILE__]}\n};
}

# UHC::eval <<'END' has UHC::eval q{...}
if (UHC::eval <<'END') {
UHC::eval q{ if ('�A�\' !~ /A/) { return 1 } else { return 0 } }
END
    print qq{ok - 4 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 4 $^X @{[__FILE__]}\n};
}

# UHC::eval <<'END' has UHC::eval $var
my $var = q{ if ('�A�\' !~ /A/) { return 1 } else { return 0 } };
if (UHC::eval <<'END') {
UHC::eval $var
END
    print qq{ok - 5 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 5 $^X @{[__FILE__]}\n};
}

# UHC::eval <<'END' has UHC::eval (omit)
$_ = "if ('�A�\' !~ /A/) { return 1 } else { return 0 }";
if (UHC::eval <<'END') {
UHC::eval
END
    print qq{ok - 6 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 6 $^X @{[__FILE__]}\n};
}

# UHC::eval <<'END' has UHC::eval {...}
if (UHC::eval <<'END') {
UHC::eval { if ('�A�\' !~ /A/) { return 1 } else { return 0 } }
END
    print qq{ok - 7 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 7 $^X @{[__FILE__]}\n};
}

# UHC::eval <<'END' has "..."
if (UHC::eval <<'END') {
if ('�A�\' !~ /A/) { return "1" } else { return "0" }
END
    print qq{ok - 8 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 8 $^X @{[__FILE__]}\n};
}

# UHC::eval <<'END' has qq{...}
if (UHC::eval <<'END') {
if ('�A�\' !~ /A/) { return qq{1} } else { return qq{0} }
END
    print qq{ok - 9 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 9 $^X @{[__FILE__]}\n};
}

# UHC::eval <<'END' has '...'
if (UHC::eval <<'END') {
if ('�A�\' !~ /A/) { return '1' } else { return '0' }
END
    print qq{ok - 10 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 10 $^X @{[__FILE__]}\n};
}

# UHC::eval <<'END' has q{...}
if (UHC::eval <<'END') {
if ('�A�\' !~ /A/) { return q{1} } else { return q{0} }
END
    print qq{ok - 11 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 11 $^X @{[__FILE__]}\n};
}

# UHC::eval <<'END' has $var
my $var1 = 1;
my $var0 = 0;
if (UHC::eval <<'END') {
if ('�A�\' !~ /A/) { return $var1 } else { return $var0 }
END
    print qq{ok - 12 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 12 $^X @{[__FILE__]}\n};
}

__END__

# encoding: UHC
# This file is encoded in UHC.
die "This file is not encoded in UHC.\n" if q{��} ne "\x82\xa0";

use UHC;

print "1..12\n";

my $var = '';

# UHC::eval $var has UHC::eval "..."
$var = <<'END';
UHC::eval " if ('�A�\' !~ /A/) { return 1 } else { return 0 } "
END
if (UHC::eval $var) {
    print qq{ok - 1 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 1 $^X @{[__FILE__]}\n};
}

# UHC::eval $var has UHC::eval qq{...}
$var = <<'END';
UHC::eval qq{ if ('�A�\' !~ /A/) { return 1 } else { return 0 } }
END
if (UHC::eval $var) {
    print qq{ok - 2 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 2 $^X @{[__FILE__]}\n};
}

# UHC::eval $var has UHC::eval '...'
$var = <<'END';
UHC::eval ' if (qq{�A�\} !~ /A/) { return 1 } else { return 0 } '
END
if (UHC::eval $var) {
    print qq{ok - 3 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 3 $^X @{[__FILE__]}\n};
}

# UHC::eval $var has UHC::eval q{...}
$var = <<'END';
UHC::eval q{ if ('�A�\' !~ /A/) { return 1 } else { return 0 } }
END
if (UHC::eval $var) {
    print qq{ok - 4 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 4 $^X @{[__FILE__]}\n};
}

# UHC::eval $var has UHC::eval $var
$var = <<'END';
UHC::eval $var2
END
my $var2 = q{ if ('�A�\' !~ /A/) { return 1 } else { return 0 } };
if (UHC::eval $var) {
    print qq{ok - 5 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 5 $^X @{[__FILE__]}\n};
}

# UHC::eval $var has UHC::eval (omit)
$var = <<'END';
UHC::eval
END
$_ = "if ('�A�\' !~ /A/) { return 1 } else { return 0 }";
if (UHC::eval $var) {
    print qq{ok - 6 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 6 $^X @{[__FILE__]}\n};
}

# UHC::eval $var has UHC::eval {...}
$var = <<'END';
UHC::eval { if ('�A�\' !~ /A/) { return 1 } else { return 0 } }
END
if (UHC::eval $var) {
    print qq{ok - 7 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 7 $^X @{[__FILE__]}\n};
}

# UHC::eval $var has "..."
$var = <<'END';
if ('�A�\' !~ /A/) { return "1" } else { return "0" }
END
if (UHC::eval $var) {
    print qq{ok - 8 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 8 $^X @{[__FILE__]}\n};
}

# UHC::eval $var has qq{...}
$var = <<'END';
if ('�A�\' !~ /A/) { return qq{1} } else { return qq{0} }
END
if (UHC::eval $var) {
    print qq{ok - 9 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 9 $^X @{[__FILE__]}\n};
}

# UHC::eval $var has '...'
$var = <<'END';
if ('�A�\' !~ /A/) { return '1' } else { return '0' }
END
if (UHC::eval $var) {
    print qq{ok - 10 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 10 $^X @{[__FILE__]}\n};
}

# UHC::eval $var has q{...}
$var = <<'END';
if ('�A�\' !~ /A/) { return q{1} } else { return q{0} }
END
if (UHC::eval $var) {
    print qq{ok - 11 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 11 $^X @{[__FILE__]}\n};
}

# UHC::eval $var has $var
$var = <<'END';
if ('�A�\' !~ /A/) { return $var1 } else { return $var0 }
END
my $var1 = 1;
my $var0 = 0;
if (UHC::eval $var) {
    print qq{ok - 12 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 12 $^X @{[__FILE__]}\n};
}

__END__

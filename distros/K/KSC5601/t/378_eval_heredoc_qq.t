# encoding: KSC5601
# This file is encoded in KS C 5601.
die "This file is not encoded in KS C 5601.\n" if q{��} ne "\xa4\xa2";

use KSC5601;

print "1..12\n";

# eval <<"END" has eval "..."
if (eval KSC5601::escape <<"END") {
eval KSC5601::escape " if ('����' !~ /��/) { return 1 } else { return 0 } "
END
    print qq{ok - 1 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 1 $^X @{[__FILE__]}\n};
}

# eval <<"END" has eval qq{...}
if (eval KSC5601::escape <<"END") {
eval KSC5601::escape qq{ if ('����' !~ /��/) { return 1 } else { return 0 } }
END
    print qq{ok - 2 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 2 $^X @{[__FILE__]}\n};
}

# eval <<"END" has eval '...'
if (eval KSC5601::escape <<"END") {
eval KSC5601::escape ' if (qq{����} !~ /��/) { return 1 } else { return 0 } '
END
    print qq{ok - 3 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 3 $^X @{[__FILE__]}\n};
}

# eval <<"END" has eval q{...}
if (eval KSC5601::escape <<"END") {
eval KSC5601::escape q{ if ('����' !~ /��/) { return 1 } else { return 0 } }
END
    print qq{ok - 4 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 4 $^X @{[__FILE__]}\n};
}

# eval <<"END" has eval $var
my $var = q{q{ if ('����' !~ /��/) { return 1 } else { return 0 } }};
if (eval KSC5601::escape <<"END") {
eval KSC5601::escape $var
END
    print qq{ok - 5 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 5 $^X @{[__FILE__]}\n};
}

# eval <<"END" has eval (omit)
$_ = "if ('����' !~ /��/) { return 1 } else { return 0 }";
if (eval KSC5601::escape <<"END") {
eval KSC5601::escape
END
    print qq{ok - 6 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 6 $^X @{[__FILE__]}\n};
}

# eval <<"END" has eval {...}
if (eval KSC5601::escape <<"END") {
eval { if ('����' !~ /��/) { return 1 } else { return 0 } }
END
    print qq{ok - 7 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 7 $^X @{[__FILE__]}\n};
}

# eval <<"END" has "..."
if (eval KSC5601::escape <<"END") {
if ('����' !~ /��/) { return \"1\" } else { return \"0\" }
END
    print qq{ok - 8 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 8 $^X @{[__FILE__]}\n};
}

# eval <<"END" has qq{...}
if (eval KSC5601::escape <<"END") {
if ('����' !~ /��/) { return qq{1} } else { return qq{0} }
END
    print qq{ok - 9 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 9 $^X @{[__FILE__]}\n};
}

# eval <<"END" has '...'
if (eval KSC5601::escape <<"END") {
if ('����' !~ /��/) { return '1' } else { return '0' }
END
    print qq{ok - 10 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 10 $^X @{[__FILE__]}\n};
}

# eval <<"END" has q{...}
if (eval KSC5601::escape <<"END") {
if ('����' !~ /��/) { return q{1} } else { return q{0} }
END
    print qq{ok - 11 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 11 $^X @{[__FILE__]}\n};
}

# eval <<"END" has $var
my $var1 = 1;
my $var0 = 0;
if (eval KSC5601::escape <<"END") {
if ('����' !~ /��/) { return $var1 } else { return $var0 }
END
    print qq{ok - 12 $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 12 $^X @{[__FILE__]}\n};
}

__END__

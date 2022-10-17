######################################################################
#
# t/6003_getcode_jis.t
#
# Copyright (c) 2022 INABA Hitoshi <ina@cpan.org> in a CPAN
######################################################################

sub BEGIN {
    eval q<
        use FindBin;
        use lib "$FindBin::Bin/..";
    >;
}
require 'lib/jacode.pl';

@todo = (
    '(I6E6^VJAVFTAVF;;^Z2<I2\5DEXC:9IQ=OC^(B','jis',
    '$B#0#1#2#3#4#5(B','jis',
    '$B#A#B#C#D#E#F(B','jis',
    '$B$$$m$O$K$[$X$H$A$j$L$k$r$o$+$h$?$l$=$D$M$J$i$`$&$p$N$*$/$d$^$1$U$3$($F$"$5$-$f$a$_$7$q$R$b$;$9(B','jis',
    '$B%H%j%J%/%3%q%9%f%a%5%^%;%_%h%"%1%o%?%k%R%s%+%7%r%=%i%$%m%O%(%F%*%-%D%X%K%[%U%M%`%l%p%L%b%d%N%&%A(B','jis',
    '$B;3@n0[0hIw7nF1E7(B','jis',
    '$B$3$N%5%$%H$O(B Perl $B$N8x<0%I%-%e%a%s%H!"%b%8%e!<%k%I%-%e%a%s%H$rF|K\8l$KK]Lu$7$?$b$N$rI=<($9$k%5%$%H$G$9!#(B','jis',
    '$B%5%$%HFb$NK]Lu%G!<%?$O!"(BJapanized Perl Resources Project(JPRP)$B$GK]Lu$5$l$?$b$N!"M-;V$,K]Lu$7$F$$$k(Bgithub$B$N%j%]%8%H%j!"(BJPA$B$NK]LuJ8=q$+$i<hF@$7$F$$$^$9!#(B','jis',
    '$B:G6a$N99?7(B / RSS','jis',
    'CVS$B5Z$S(Bgit$B$N(Bcommit$B%m%0$+$i:G?7$N(B50$B7o$r<hF@$7$F$$$^$9!#5)$KK]Lu<T$H(Bcommit$B$7$??M$,0c$&>l9g$,$"$j$^$9!#$^$?!"=$@5$N(Bcommit$B!"EPO?$7$?$@$1$GL$K]Lu$N$b$N$b4^$^$l$k>l9g$,$"$j$^$9!#(B','jis',
);

print "1..", scalar(@todo)/2, "\n";
if ('$B$"(B' !~ /\x24\x22/) {
    for $tno (1 .. scalar(@todo)/2) {
        print "ok $tno - SKIP (script '$0' must be 'jis')\n";
    }
    exit;
}

$tno = 1;

while (($give,$want) = splice(@todo,0,2)) {
    $got = &jacode'getcode(*give);
    if ($got eq $want) {
        print     "ok $tno - want=($want) got=($got)\n";
    }
    else {
        print "not ok $tno - want=($want) got=($got)\n";
    }
    $tno++;
}

__END__

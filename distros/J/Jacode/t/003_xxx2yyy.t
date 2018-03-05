# This file is encoded in EUC-JP.
die "This file is not encoded in EUC-JP.\n" if q{��} ne "\xa4\xa2";
######################################################################
#
# 003_xxx2yyy.t for testing jacode.pl
#
# Copyright (c) 2016 INABA Hitoshi <ina@cpan.org>
#
######################################################################

sub BEGIN {
    eval q<
        use FindBin;
        use lib "$FindBin::Bin/..";
    >;
}
require 'lib/jacode.pl';

print "1..240\n";
$tno = 1;

&test('��','��','��','��','��','��','��','��','��','��','��','��','��','��');
&test('��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��');
&test('��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��','��');
&test('A','B','C','D','E','F','Z','H','I','K','L','M','N','O','P','Q','R','S','T','V','X');
&test('A','��','��','A','��','��','��','A','��','��','��','A','��','A','��','��','��','A');

sub test {
    local(@char) = @_;

    $string_jis  =
    $string_sjis =
    $string_euc  =
    $string_utf8 = join('',@char);
    &jcode'euc2jis(*string_jis);
    &jcode'euc2sjis(*string_sjis);
    &jcode'euc2utf8(*string_utf8);

    for $option ('','h','z') {
        if ( $option eq '' ) {
            $chars = grep( ! /^[\x00-\x7f]$/, @char);
        }
        elsif ( $option eq 'h' ) {
            $chars = grep( ! /^[\x00-\x7f]$/, @char);
            for $char (@char) {
                if (0) { }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
                elsif ($char eq '��') { $chars++; }
            }
        }
        elsif ( $option eq 'z' ) {
            $chars = 0;
            for $char (@char) {
                if (0) { }
                elsif ($char eq '��') { }
                elsif ($char eq '��') { }
                elsif ($char =~ /^[\x00-\x7f]$/) { }
                else {
                    $chars++;
                }
            }
        }

        #-----------------------------------------------------------
        # sjis2yyy
        #-----------------------------------------------------------

        $string = $string_sjis;
        if (($rc = &jcode'sjis2jis(*string,$option)) == $chars) {
            print "ok - $tno sjis2jis (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno sjis2jis (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        $string = $string_sjis;
        if (($rc = &jcode'sjis2sjis(*string,$option)) == 0) {
            print "ok - $tno sjis2sjis (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno sjis2sjis (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        $string = $string_sjis;
        if (($rc = &jcode'sjis2euc(*string,$option)) == $chars) {
            print "ok - $tno sjis2euc (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno sjis2euc (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        $string = $string_sjis;
        if (($rc = &jcode'sjis2utf8(*string,$option)) == $chars) {
            print "ok - $tno sjis2utf8 (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno sjis2utf8 (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        #-----------------------------------------------------------
        # jis2yyy
        #-----------------------------------------------------------

        $string = $string_jis;
        if (($rc = &jcode'jis2jis(*string,$option)) == 0) {
            print "ok - $tno jis2jis (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno jis2jis (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        $string = $string_jis;
        if (($rc = &jcode'jis2sjis(*string,$option)) == $chars) {
            print "ok - $tno jis2sjis (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno jis2sjis (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        $string = $string_jis;
        if (($rc = &jcode'jis2euc(*string,$option)) == $chars) {
            print "ok - $tno jis2euc (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno jis2euc (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        $string = $string_jis;
        if (($rc = &jcode'jis2utf8(*string,$option)) == $chars) {
            print "ok - $tno jis2utf8 (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno jis2utf8 (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        #-----------------------------------------------------------
        # euc2yyy
        #-----------------------------------------------------------

        $string = $string_euc;
        if (($rc = &jcode'euc2jis(*string,$option)) == $chars) {
            print "ok - $tno euc2jis (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno euc2jis (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        $string = $string_euc;
        if (($rc = &jcode'euc2sjis(*string,$option)) == $chars) {
            print "ok - $tno euc2sjis (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno euc2sjis (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        $string = $string_euc;
        if (($rc = &jcode'euc2euc(*string,$option)) == 0) {
            print "ok - $tno euc2euc (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno euc2euc (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        $string = $string_euc;
        if (($rc = &jcode'euc2utf8(*string,$option)) == $chars) {
            print "ok - $tno euc2utf8 (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno euc2utf8 (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        #-----------------------------------------------------------
        # utf82yyy
        #-----------------------------------------------------------

        $string = $string_utf8;
        if (($rc = &jcode'utf82jis(*string,$option)) == $chars) {
            print "ok - $tno utf82jis (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno utf82jis (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        $string = $string_utf8;
        if (($rc = &jcode'utf82sjis(*string,$option)) == $chars) {
            print "ok - $tno utf82sjis (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno utf82sjis (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        $string = $string_utf8;
        if (($rc = &jcode'utf82euc(*string,$option)) == $chars) {
            print "ok - $tno utf82euc (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno utf82euc (option='$option') returned $rc expect $chars\n";
        }
        $tno++;

        $string = $string_utf8;
        if (($rc = &jcode'utf82utf8(*string,$option)) == 0) {
            print "ok - $tno utf82utf8 (option='$option') returned $rc expect $chars\n";
        }
        else {
            print "not ok - $tno utf82utf8 (option='$option') returned $rc expect $chars\n";
        }
        $tno++;
    }
}

__END__

#
# what happens if Time::HiRes is not available ?
#
#BEGIN {  # use this for a fake Time::HiRes
#    unshift @INC, sub {
#        my (undef, $what) = @_;
#        print "include -> $what\n";
#        return if $what ne 'Time/HiRes.pm';
#        open my $fh, '<', 't/1cover/no-time-hires.t' or die "open: $!";
#        while (my $junk = <$fh>) {
#            $junk =~ s/[\r\n]+$//g; #chomp
#            last if $junk eq '__DA'.'TA__';
#        }
#        return \'', $fh;
#    };
#}
use strict;
use warnings;
BEGIN {
    # need to pre-load modules used
    # everywhere else EXCEPT Time::HiRes
    require vars;
    require constant;
    require Exporter;
    require Carp;
    require DynaLoader;
    require File::Temp;
    #require Time::HiRes;
    local @INC = ( 't/0LIB', @INC );
    require MyTest;  # this requires UUID if note() or diag() called, so dont do that
    MyTest::pass('loaded');
}

MyTest::pass('running');

eval {
    local @INC = qw(blib/lib blib/arch);
    require UUID;
};
if ($@ =~ /Time::HiRes is required/) {
    MyTest::pass('died as expected');
}
elsif ($@ ne '') {
    my $e = $@;
    chomp $e;
    my @lines = split $/, $e;
    MyTest::fail('died with wrong error');
    print "# $_\n" for @lines;
}
else {
    MyTest::fail('did not die');
}

MyTest::done_testing();

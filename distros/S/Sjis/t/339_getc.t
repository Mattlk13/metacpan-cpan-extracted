# encoding: Sjis
# This file is encoded in ShiftJIS.
die "This file is not encoded in ShiftJIS.\n" if q{��} ne "\x82\xa0";

use Sjis;
print "1..1\n";

my $__FILE__ = __FILE__;

my @getc = ();
while (my $c = Sjis::getc(DATA)) {
    last if $c =~ /\A[\r\n]\z/;
    push @getc, $c;
}
my $result = join('', map {"($_)"} @getc);

if ($result eq '(1)(2)(�)(�)(��)(��)') {
    print "ok - 1 $^X $__FILE__ 12������ --> $result.\n";
}
else {
    print "not ok - 1 $^X $__FILE__ 12������ --> $result.\n";
}

__END__
12������

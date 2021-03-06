
use Test::More tests => 17;
#use Test::More no_plan => 1;

BEGIN { use_ok('Term::Size::ReadKey'); }

my @handles = (
    # name args handle
    [ 'implicit STDIN', [], *STDIN ], # default: implicit STDIN
    [ 'STDIN', [*STDIN], *STDIN ],
    [ 'STDERR', [*STDERR], *STDERR ],
    [ 'STDOUT', [*STDOUT], *STDOUT ],
);

if ( not exists $ENV{COLUMNS} ) {
    $ENV{COLUMNS} = 80;
    $ENV{LINES}   = 24;
}


for (@handles) {
    my $h_name = $_->[0];
    my @args = @{$_->[1]};
    my $h = $_->[2];

SKIP: {
    skip "$h_name is not tty", 4 unless -t $h;

    my @chars = Term::Size::ReadKey::chars @args;
    is(scalar @chars, 2, "$h_name: chars return (cols, rows) - $h_name");

    my $cols = Term::Size::ReadKey::chars @args;
    is($cols, $chars[0], "$h_name: chars return cols");

    my @pixels = Term::Size::ReadKey::pixels @args;
    is(scalar @pixels, 2, "$h_name: pixels return (x, y)");

    my $x = Term::Size::ReadKey::pixels @args;
    is($x, $pixels[0], "$h_name: pixels return x");

}

}

if (-t STDIN) {
    # this is not at test, only a show-off
    my @chars = Term::Size::ReadKey::chars;
    my @pixels = Term::Size::ReadKey::pixels;
    diag("This terminal is $chars[0]x$chars[1] characters,"),
    diag("             and $pixels[0]x$pixels[1] pixels.");

}

# Are unrecognized characters silently ignored?

use Test::More tests => 3;
use Text::TypingEffort qw( effort );

my $text = "   \tThe quick brown fox jumps over the �lazy� dog\n";
$text   .= "\t  The quick brown fox  jumps over the lazy dog����\n";

# establish the expected values
my %ok = (
    characters => 88,
    presses    => 90,
    distance   => 2040,
    energy     => 4.7618,
);

# test the default value of 'unknowns'
my $effort = effort( \$text );
$effort->{energy} = sprintf("%.4f", $effort->{energy});
is_deeply( $effort, \%ok, 'ignore unrecognized characters' );


# add in the expected values for the unknowns histogram
$ok{unknowns} = {
    presses => {
        ' ' => 1,
        '' => 1,
        '�' => 2,
        '�' => 2,
        '�' => 1,
        '�' => 1,
    },
    distance => {
        ' ' => 1,
        '' => 1,
        '�' => 2,
        '�' => 2,
        '�' => 1,
        '�' => 1,
    },
};

# check the value of 'unknowns' when it's turned on
$effort = effort(
    text     => \$text,
    unknowns => 1,
);
$effort->{energy} = sprintf("%.4f", $effort->{energy});
is_deeply( $effort, \%ok, 'tally unrecognized characters' );


# check the behavior of 'unknowns' when there are no
# unrecognized characters
$text = 'This is a simple test';
$effort = effort( text=>$text, unknowns=>1 );
is_deeply( $effort->{unknowns}, {}, 'no unrecognized characters' );

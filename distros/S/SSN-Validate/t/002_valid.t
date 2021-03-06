use Test::More tests => 45;

require_ok('SSN::Validate');

my $ssn = new SSN::Validate;

my %ssns = (
    '001-34-2283' => [ 1, 'NH' ],
    '004-34-2283' => [ 1, 'ME' ],
    '044-56-2283' => [ 1, 'CT' ],
    '212-21-2283' => [ 1, 'MD' ],
    '223789983'   => [ 1, 'VA' ],
    '144563349'   => [ 1, 'NJ' ],
    '123 56 3749' => [ 1, 'NY' ],
    '122 66 3749' => [ 1, 'NY' ],
    '801-33-2245' => [ 1, '??' ],
    '580-22-1345' => [ 1, 'VI' ],
    '258-22-1345' => [ 1, 'GA' ],
    '612-40-3145' => [ 1, '??' ],
    '764-32-3145' => [ 1, '??' ],
    '586-22-7722' => [ 1, '??' ],
    '710-18-7722' => [ 1, 'RB' ],
    '234-18-7722' => [ 1, 'WV' ],
    '250-28-2738' => [ 1, 'SC' ],
    '411-11-2228' => [ 1, 'TN' ],
    '528-11-2228' => [ 1, 'UT' ],
    '585-18-1234' => [ 1, 'NM' ],
    '537-55-1234' => [ 1, 'WA' ],
    '681-18-1234' => [ 1, '??' ],
);

for my $num ( sort { $a cmp $b } keys %ssns ) {
    ok( $ssn->valid_ssn($num) == $ssns{$num}->[0], "valid_ssn($num)" );
    ok( $ssn->get_state($num) eq $ssns{$num}->[1], "get_state($num)" );
}

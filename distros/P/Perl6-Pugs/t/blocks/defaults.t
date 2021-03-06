use v6-alpha;

use Test;

=kwid

Tests assigning default values to variables of type code in sub definitions.
L<S06/"Optional parameters" /Default values can be calculated at run-time/>
=cut

plan 2;

sub doubler($x) { return 2 * $x }

sub value_v(Code :$func = &doubler) {
    return $func(5);
}

is(value_v, 10, "default sub called");

package MyPack {

sub double($x) { return 2 * $x }

sub val_v(Code :$func = &double) is export {
    return $func(5);
}

}

use Test;

ok((MyPack::val_v), "default sub called in package namespace");

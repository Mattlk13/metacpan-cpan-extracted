# This code can be redistributed and modified under the terms of the GNU
# General Public License as published by the Free Software Foundation, either
# version 3 of the License, or (at your option) any later version.
# See the "COPYING" file for details.
package HTML::Blitz::Atom 0.1001;
use HTML::Blitz::pragma;
use constant ();

method import($class: @names) {
    @_ = (
        $class,
        { map +($_ => ':' . tr/_/-/r), @names },
    );
    goto &{constant->can('import')};
}

1

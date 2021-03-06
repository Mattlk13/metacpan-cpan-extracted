use 5.014;

use strict;
use warnings;

use Test::More;

# POD

=name

Data::Object::Regexp::Func::Search

=abstract

Data-Object Regexp Function (Search) Class

=synopsis

  use Data::Object::Regexp::Func::Search;

  my $func = Data::Object::Regexp::Func::Search->new(@args);

  $func->execute;

=inherits

Data::Object::Regexp::Func

=attributes

arg1(RegexpLike, req, ro)
arg2(StringLike, req, ro)

=libraries

Data::Object::Library

=description

Data::Object::Regexp::Func::Search is a function object for
Data::Object::Regexp.

=cut

# TESTING

use_ok 'Data::Object::Regexp::Func::Search';

ok 1 and done_testing;

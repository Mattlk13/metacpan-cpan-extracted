use strict;
use warnings;

use constant ATTRIBUTE_TRAIT      => 'MooseX::AttributeShortcuts::Trait::Attribute';
use constant ROLE_ATTRIBUTE_TRAIT => 'MooseX::AttributeShortcuts::Trait::Role::Attribute';

use Moose::Util 'find_meta';
use Test::More;
use Test::Moose::More 0.047;

{
    package TestRole::A;
    use Moose::Role;
    use MooseX::AttributeShortcuts;

    has bar => (is => 'ro', builder => sub { 2 });
}
{
    package TestRole::B;
    use Moose::Role;
    sub _build_bar { 4 }
}
{
    package TestRole::Combined;
    use Moose::Role;
    with 'TestRole::A', 'TestRole::B';
    sub _build_bar { 16 }
}
{
    package TestClass;
    use Moose;
    with 'TestRole::Combined';
}

validate_role 'TestRole::A' => (
    -subtest => 1,
    methods  => [ qw{ _build_bar } ],
    role_metaroles => {
        attribute         => [ ROLE_ATTRIBUTE_TRAIT ],
        applied_attribute => [ ATTRIBUTE_TRAIT      ],
    },
    attributes => [
        bar => {
            -does => [ ROLE_ATTRIBUTE_TRAIT ],
        },
    ],
);

validate_role 'TestRole::B' => (
    -subtest => 1,
    methods  => [ qw{ _build_bar } ],
);

validate_role 'TestRole::Combined' => (
    -subtest   => 1,
    does       => ['TestRole::A', 'TestRole::B'],
    attributes => ['bar'],
    methods    => [ qw{ _build_bar } ],
);

validate_class TestClass => (
    -subtest => 1,
    does     => ['TestRole::Combined'],
    methods  => ['_build_bar'],
    attributes => [
        bar => {
            -does   => [ATTRIBUTE_TRAIT],
            builder => '_build_bar',
        },
    ],
);

is TestClass::_build_bar() => 16, '...::_build_bar() is correct (16)';
my $tc = TestClass->new;
is $tc->bar() => 16, 'builder method as expected (16)';

method_from_pkg_ok TestClass => '_build_bar', 'TestRole::Combined';

done_testing;

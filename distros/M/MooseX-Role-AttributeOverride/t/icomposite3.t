# Submitted by mmcleric
use strict;
use warnings;

{
    package MyApp::Role;
    use Moose::Role;

    has 'fun' => ( is => 'ro' );
    no Moose::Role;
}

{
    package MyApp::Role2;
    use Moose::Role;
    use MooseX::Role::AttributeOverride;

    with 'MyApp::Role';

    has_plus 'fun' => ( default => 'yep', );
    no Moose::Role;

}

{

    package MyApp;
    use Moose;

    with qw(MyApp::Role2);
    __PACKAGE__->meta->make_immutable;
    no Moose;
}

{
    package main;

    #use MyApp;

    use Test::More tests => 1;    # last test to print

    my $test = MyApp->new();

    is( $test->fun, 'yep', "Default was set by role" );

}

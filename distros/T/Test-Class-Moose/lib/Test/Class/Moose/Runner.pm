package Test::Class::Moose::Runner;

# ABSTRACT: Runner for Test::Class::Moose tests

use strict;
use warnings;
use namespace::autoclean;

use 5.010000;

our $VERSION = '1.00';

use Moose 2.0000;
use Carp;

use Test::Class::Moose::Config;

has 'test_configuration' => (
    is  => 'ro',
    isa => 'Test::Class::Moose::Config',
);

has 'jobs' => (
    is      => 'ro',
    isa     => 'Int',
    default => 1,
);

has 'show_parallel_progress' => (
    is      => 'ro',
    isa     => 'Bool',
    default => 1,
);

has 'color_output' => (
    is      => 'ro',
    isa     => 'Bool',
    default => 1,
);

has 'executor_roles' => (
    traits  => ['Array'],
    is      => 'ro',
    isa     => 'ArrayRef[RoleName]',
    default => sub { [] },
    handles => {
        _has_executor_roles => 'count',
    },
);

has '_executor' => (
    is         => 'ro',
    init_arg   => undef,
    lazy_build => 1,
    handles    => [ 'runtests', 'test_classes', 'test_report' ],
);

my %config_attrs = map { $_->init_arg => 1 }
  Test::Class::Moose::Config->meta->get_all_attributes;

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    my $p = $class->$orig(@_);

    my %config_p = map { $config_attrs{$_} ? ( $_ => delete $p->{$_} ) : () }
      keys %{$p};

    $p->{test_configuration} ||= Test::Class::Moose::Config->new(%config_p);

    return $p;
};

sub _build__executor {
    my $self = shift;

    my $executor;
    if ( $self->jobs == 1 ) {
        require Test::Class::Moose::Executor::Sequential;
        $executor = Test::Class::Moose::Executor::Sequential->new(
            test_configuration => $self->test_configuration );
    }
    else {
        require Test::Class::Moose::Executor::Parallel;
        $executor = Test::Class::Moose::Executor::Parallel->new(
            test_configuration     => $self->test_configuration,
            jobs                   => $self->jobs,
            color_output           => $self->color_output,
            show_parallel_progress => $self->show_parallel_progress,
        );
    }

    return $executor unless $self->_has_executor_roles;

    require Moose::Util;
    Moose::Util::apply_all_roles( $executor, @{ $self->executor_roles } );

    return $executor;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Test::Class::Moose::Runner - Runner for Test::Class::Moose tests

=head1 VERSION

version 1.00

=head1 SYNOPSIS

 use Test::Class::Moose::Load 't/lib';
 use Test::Class::Moose::Runner;
 Test::Class::Moose::Runner->new->runtests;

=head1 DESCRIPTION

This class is responsible for running tests. Internally, most of the work is
done by either a C<Test::Class::Moose::Executor::Sequential> or
C<Test::Class::Moose::Executor::Parallel> object.

=head1 LOADING TESTS

We I<strongly> recommend using the L<Test::Class::Moose::Load> driver for your
test suite. Simply point it at the directory or directories containing your
test classes:

 use Test::Class::Moose::Load 't/lib';
 use Test::Class::Moose::Runner;
 Test::Class::Moose::Runner->new->runtests;

By running your C<Test::Class::Moose> tests with a single driver script like
this, all classes are loaded once and this can be a significant performance
boost. This does mean a global state will be shared, so keep this in mind.

=head1 CONSTRUCTOR ATTRIBUTES

=over 4

=item * C<show_timing>

Boolean. Will display verbose information on the amount of time it takes each
test class/test method to run. Defaults to false, but see C<use_environment>.

=item * C<set_process_name>

Boolean. If this is true, then C<$0> will be updated to include the test
instance name for each test instance as it is run, and then further updated as
each test control method and test method are run, This can be helpful when
debugging hanging tests. Defaults to false.

=item * C<statistics>

Boolean. Will display number of classes, test methods and tests run. Defaults
to false, but see C<use_environment>.

=item * C<use_environment>

If this is true, then the default value for show_timing and statistics will be
true if the C<HARNESS_IS_VERBOSE> environment variable is true. This is set
when running C<prove -v ...>, for example.

=item * C<jobs>

This defaults to 1. If you set this to a larger number than test instances will
be run in parallel. See the L</PARALLEL RUNNING> section below for more
details.

=item * C<show_parallel_progress>

This defaults to 1. This only impacts the output when running tests in
parallel. If this is true then when running tests in parallel the runner will
output one dot per class being executed. This makes it clear that the test
suite is not stuck.

However, this output can cause issues with things like the
L<TAP::Harness::Archive> module, so you can disable it if needed.

=item * C<color_output>

This defaults to 1. This only impacts the output when running tests in
parallel. If this is true then parallel test progress output will use ANSI
coloring to indicate each class's pass/fail status.

=item * C<randomize>

Boolean. Will run test methods in a random order.

=item * C<randomize_classes>

Boolean. Will run test classes in a random order. Note that if you specify an
explicit list of classes in C<test_classes>, these classes will be run in the
order you specify.

=item * C<test_classes>

Takes a class name or an array reference of class names. If it is present, only
these test classes will be run. This is very useful if you wish to run an
individual class as a test:

    My::Base::Class->new(
        test_classes => $ENV{TEST_CLASS}, # ignored if undef
    )->runtests;

You can also achieve this effect by writing a subclass and overriding the
C<test_classes> method, but this makes it trivial to do this:

    TEST_CLASS=TestsFor::Our::Company::Invoice prove -lv t/test_classes.t

Alternatively:

    My::Base::Class->new(
        test_classes => \@ARGV, # ignored if empty
    )->runtests;

That lets you use the arisdottle to provide arguments to your test driver
script:

    prove -lv t/test_classes.t :: TestsFor::Our::Company::Invoice TestsFor::Something::Else

=item * C<include>

Regex. If present, only test methods whose name matches C<include> will be
included. B<However>, they must still start with C<test_>.

For example:

 my $test_suite = Test::Class::Moose->new({
     include => qr/customer/,
 });

The above constructor will let you match test methods named C<test_customer>
and C<test_customer_account>, but will not suddenly match a method named
C<default_customer>.

By enforcing the leading C<test_> behavior, we don't surprise developers who
are trying to figure out why C<default_customer> is being run as a test. This
means an C<include> such as C<< /^customer.*/ >> will never run any tests.

=item * C<exclude>

Regex. If present, only test methods whose names don't match C<exclude> will be
included. B<However>, they must still start with C<test_>. See C<include>.

=item * C<include_tags>

Array ref of strings matching method tags (a single string is also ok). If
present, only test methods whose tags match C<include_tags> or whose tags don't
match C<exclude_tags> will be included. B<However>, they must still start with
C<test_>.

For example:

 my $test_suite = Test::Class::Moose->new({
     include_tags => [qw/api database/],
 });

The above constructor will only run tests tagged with C<api> or C<database>.

=item * C<exclude_tags>

The same as C<include_tags>, but will exclude the tests rather than include
them. For example, if your network is down:

 my $test_suite = Test::Class::Moose->new({
     exclude_tags => [ 'network' ],
 });

 # or
 my $test_suite = Test::Class::Moose->new({
     exclude_tags => 'network',
 });

=item * C<executor_roles>

An array reference containing one or more roles to be applied to the executor
object. This allows you to apply plugins on top of the normal TCM behavior.

See the L<Test::Class::Moose::Role::Executor> docs for details of what methods
you can modify as part of such roles.

=back

=head1 METHODS

In addition to the C<new> method, this class provides several  additional
public methods

=head2 C<< $runner->runtests >>

This method runs your tests. It accepts no arguments.

=head2 C<< $runner->test_configuration >>

This returns a L<Test::Class::Moose::Config> for the runner.

Most of the attributes passed to the runner are actually available in a
L<Test::Class::Moose::Config> rather than the runner itself. This may change in
a future release, in which case this method will simply return the runner
itself for backwards compatibility.

=head2 C<< $runner->test_report >>

This returns a L<Test::Class::Moose::Report> for the runner. After running
tests you can use this object to get information about the test run.

=head1 PARALLEL RUNNING

Running tests in parallel requires you to have L<Parallel::ForkManager>
installed. This is not a prereq of this distro so you will need to install
manually.

To run tests in parallel, simply pass a value greater than 1 for the C<jobs>
parameter when creating a runner object:

  Test::Class::Moose::Runner->new( jobs => 4 )->runtests;

Your test classes will be run in parallel in separate child processes. Test
classes are parallelized on a B<per instance basis>. This means that each child
process constructs a single instance of a test class and runs all of the
methods belonging to that class.

If you are using parameterized test instances (see the L<Test::Class::Moose>
docs for details) then the same class may have instances running in different
child processes.

If any of the methods in a class are marked with the C<noparallel> tag, then
that class will be not be run in a child process. All test classes which can't
be run in parallel are run sequentially after all parallelizable classes have
run.

=head1 SUPPORT

Bugs may be submitted at L<https://github.com/Test-More/test-class-moose/issues>.

=head1 SOURCE

The source code repository for Test-Class-Moose can be found at L<https://github.com/Test-More/test-class-moose>.

=head1 AUTHORS

=over 4

=item *

Curtis "Ovid" Poe <ovid@cpan.org>

=item *

Dave Rolsky <autarch@urth.org>

=item *

Chad Granum <exodist@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 - 2025 by Curtis "Ovid" Poe.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

The full text of the license can be found in the
F<LICENSE> file included with this distribution.

=cut

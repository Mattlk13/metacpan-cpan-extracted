package Test::Class::Moose::Role::Executor;

# ABSTRACT: Common code for Runner classes

use strict;
use warnings;
use namespace::autoclean;

use 5.010000;

our $VERSION = '1.00';

use Moose::Role 2.0000;
use Carp;

use List::SomeUtils qw(uniq);
use List::Util qw(shuffle);
use Test2::API qw( test2_stack );
use Test2::Tools::AsyncSubtest qw( async_subtest );
BEGIN {
    require Test2::AsyncSubtest::Hub;
    Test2::AsyncSubtest::Hub->do_not_warn_on_plan();
}
use Test::Class::Moose::AttributeRegistry;
use Test::Class::Moose::Config;
use Test::Class::Moose::Report::Class;
use Test::Class::Moose::Report::Instance;
use Test::Class::Moose::Report::Method;
use Test::Class::Moose::Report;
use Test::Class::Moose::Util qw( context_do );
use Try::Tiny;

has 'test_configuration' => (
    is       => 'ro',
    isa      => 'Test::Class::Moose::Config',
    required => 1,
);

has 'test_report' => (
    is      => 'ro',
    isa     => 'Test::Class::Moose::Report',
    builder => '_build_test_report',
);

has 'is_parallel' => (
    is      => 'ro',
    isa     => 'Bool',
    default => sub { ( ref $_[0] ) =~ /::Parallel$/ ? 1 : 0 },
);

sub runtests {
    my $self = shift;

    my $report = $self->test_report;
    $report->_start_benchmark;
    my @test_classes = $self->test_classes;

    $self->_validate_test_classes(@test_classes);

    context_do {
        my $ctx = shift;

        $ctx->plan( scalar @test_classes );

        $self->_run_test_classes(@test_classes);

        $ctx->diag(<<"END") if $self->test_configuration->statistics;
Test classes:    @{[ $report->num_test_classes ]}
Test instances:  @{[ $report->num_test_instances ]}
Test methods:    @{[ $report->num_test_methods ]}
Total tests run: @{[ $report->num_tests_run ]}
END

        $ctx->done_testing;
    };

    $report->_end_benchmark;
    return $self;
}

sub _validate_test_classes {
    my $self = shift;

    my @bad = grep { !$_->isa('Test::Class::Moose') } @_
      or return;

    my $msg = 'Found the following class';
    $msg .= 'es' if @bad > 1;
    $msg
      .= ' that '
      . ( @bad > 1 ? 'are'        : 'is' ) . ' not '
      . ( @bad > 1 ? 'subclasses' : 'a subclass' )
      . " of Test::Class::Moose: @bad";
    $msg .= ' (did you load '
      . ( @bad > 1 ? 'these classes' : 'this class' ) . '?)';
    die $msg;
}

sub _run_test_classes {
    my $self         = shift;
    my @test_classes = @_;

    for my $test_class (@test_classes) {
        async_subtest(
            $test_class,
            { manual_skip_all => 1 },
            sub { $self->run_test_class($test_class) }
        )->finish;
    }
}

sub _build_test_report { Test::Class::Moose::Report->new }

sub run_test_class {
    my $self       = shift;
    my $test_class = shift;

    my $class_report
      = Test::Class::Moose::Report::Class->new( name => $test_class );

    $self->test_report->add_test_class($class_report);

    $class_report->_start_benchmark;

    my $passed = $self->_run_test_instances( $test_class, $class_report );

    $class_report->passed($passed);

    $class_report->_end_benchmark;

    return $class_report;
}

sub _run_test_instances {
    my $self         = shift;
    my $test_class   = shift;
    my $class_report = shift;

    my @test_instances = $test_class->_tcm_make_test_class_instances(
        test_report => $self->test_report,
    );

    unless (@test_instances) {
        context_do {
            my $ctx = shift;

            my $message = "Skipping '$test_class': no test instances found";
            $class_report->skipped($message);
            $class_report->passed(1);
            $ctx->plan( 0, 'SKIP' => $message );
        };
        return 1;
    }

    return context_do {
        my $ctx = shift;

        $ctx->plan( scalar @test_instances )
          if @test_instances > 1;

        my $passed = 1;
        for my $test_instance (
            sort { $a->test_instance_name cmp $b->test_instance_name }
            @test_instances )
        {
            my $instance_report = $self->_maybe_wrap_test_instance(
                $test_instance,
                $class_report,
                @test_instances > 1,
            );
            $passed = 0 if not $instance_report->passed;
        }

        return $passed;
    };
}

sub _maybe_wrap_test_instance {
    my $self          = shift;
    my $test_instance = shift;
    my $class_report  = shift;
    my $in_subtest    = shift;

    return $self->run_test_instance(
        $test_instance,
        $class_report,
    ) unless $in_subtest;

    my $instance_report;
    async_subtest(
        $test_instance->test_instance_name,
        { manual_skip_all => 1 },
        sub {
            $instance_report = $self->run_test_instance(
                $test_instance,
                $class_report,
            );
        },
    )->finish;

    return $instance_report;
}

sub run_test_instance {
    my ( $self, $test_instance, $class_report ) = @_;

    my $test_instance_name = $test_instance->test_instance_name;
    my $instance_report    = Test::Class::Moose::Report::Instance->new(
        {   name => $test_instance_name,
        }
    );

    local $0 = "$0 - $test_instance_name"
      if $self->test_configuration->set_process_name;

    $instance_report->_start_benchmark;

    $class_report->add_test_instance($instance_report);

    my @test_methods = $self->_test_methods_for($test_instance);

    context_do {
        my $ctx = shift;

        unless (@test_methods) {

            my $message
              = "Skipping '$test_instance_name': no test methods found";
            $instance_report->skipped($message);
            $instance_report->passed(1);
            $ctx->plan( 0, SKIP => $message );
            return;
        }

        my $report = $self->test_report;

        unless (
            $self->run_test_control_method(
                $test_instance, 'test_startup', $instance_report,
            )
          )
        {
            $instance_report->passed(0);
            return;
        }

        if ( my $message = $test_instance->test_skip ) {

            # test_startup skipped the class
            $instance_report->skipped($message);

            if ( $test_instance->run_control_methods_on_skip ) {
                $self->_run_shutdown( $test_instance, $instance_report )
                  or return;
            }

            $instance_report->passed(1);
            $ctx->plan( 0, SKIP => $message );
            return;
        }

        $ctx->plan( scalar @test_methods );

        my $all_passed = 1;
        foreach my $test_method (@test_methods) {
            my $method_report = $self->run_test_method(
                $test_instance,
                $test_method,
                $instance_report,
            );
            $all_passed = 0 if not $method_report->passed;
        }
        $instance_report->passed($all_passed);

        $self->_run_shutdown( $test_instance, $instance_report );

        # finalize reporting
        $instance_report->_end_benchmark;
        if ( $self->test_configuration->show_timing ) {
            my $time = $instance_report->time->duration;
            $ctx->diag("$test_instance_name: $time");
        }
    };

    return $instance_report;
}

sub _run_shutdown {
    my ( $self, $test_instance, $instance_report ) = @_;

    return 1
      if $self->run_test_control_method(
        $test_instance, 'test_shutdown', $instance_report,
      );

    $instance_report->passed(0);

    return 0;
}

sub _test_methods_for {
    my ( $self, $thing ) = @_;

    my @filtered = $self->_filtered_test_methods($thing);
    return uniq(
        $self->test_configuration->randomize
        ? shuffle(@filtered)
        : sort @filtered
    );
}

sub _filtered_test_methods {
    my ( $self, $thing ) = @_;

    my @method_list = $thing->test_methods;
    if ( my $include = $self->test_configuration->include ) {
        @method_list = grep {/$include/} @method_list;
    }
    if ( my $exclude = $self->test_configuration->exclude ) {
        @method_list = grep { !/$exclude/ } @method_list;
    }

    my $test_class = ref $thing ? $thing->test_class : $thing;
    return $self->_filter_by_tag(
        $test_class,
        \@method_list
    );
}

sub _filter_by_tag {
    my ( $self, $class, $methods ) = @_;

    my @filtered_methods = @$methods;
    if ( my $include = $self->test_configuration->include_tags ) {
        my @new_method_list;
        foreach my $method (@filtered_methods) {
            foreach my $tag (@$include) {
                if (Test::Class::Moose::AttributeRegistry->method_has_tag(
                        $class, $method, $tag
                    )
                  )
                {
                    push @new_method_list => $method;
                }
            }
        }
        @filtered_methods = @new_method_list;
    }
    if ( my $exclude = $self->test_configuration->exclude_tags ) {
        my @new_method_list = @filtered_methods;
        foreach my $method (@filtered_methods) {
            foreach my $tag (@$exclude) {
                if (Test::Class::Moose::AttributeRegistry->method_has_tag(
                        $class, $method, $tag
                    )
                  )
                {
                    @new_method_list
                      = grep { $_ ne $method } @new_method_list;
                }
            }
        }
        @filtered_methods = @new_method_list;
    }
    return @filtered_methods;
}

my %TEST_CONTROL_METHODS = map { $_ => 1 } qw/
  test_startup
  test_setup
  test_teardown
  test_shutdown
  /;

sub run_test_control_method {
    my ( $self, $test_instance, $phase, $report_object ) = @_;

    local $0 = "$0 - $phase"
      if $self->test_configuration->set_process_name;

    $TEST_CONTROL_METHODS{$phase}
      or croak("Unknown test control method ($phase)");

    my %report_args = (
        name     => $phase,
        instance => (
              $report_object->isa('Test::Class::Moose::Report::Method')
            ? $report_object->instance
            : $report_object
        )
    );
    my $phase_method_report
      = Test::Class::Moose::Report::Method->new( \%report_args );

    my $set_meth = "set_${phase}_method";
    $report_object->$set_meth($phase_method_report);

    # It'd be nicer to start and end immediately after we call
    # $test_instance->$phase but we can't guarantee that those calls would
    # happen inside the try block.
    $phase_method_report->_start_benchmark;

    my $success = context_do {
        my $ctx = shift;

        return try {
            my $count = $ctx->hub->count;
            $test_instance->$phase($report_object);
            croak "Tests may not be run in test control methods ($phase)"
              unless $count == $ctx->hub->count;
            1;
        }
        catch {
            my $error = $_;
            my $class = $test_instance->test_class;
            $ctx->ok( 0, "$class->$phase failed", [$error] );
            0;
        };
    };

    $phase_method_report->_end_benchmark;

    return $success;
}

sub run_test_method {
    my ( $self, $test_instance, $test_method, $instance_report ) = @_;

    local $0 = "$0 - $test_method"
      if $self->test_configuration->set_process_name;

    my $method_report = Test::Class::Moose::Report::Method->new(
        { name => $test_method, instance => $instance_report } );

    $instance_report->add_test_method($method_report);

    $test_instance->test_skip_clear;
    $self->run_test_control_method(
        $test_instance,
        'test_setup',
        $method_report,
    );

    $method_report->_start_benchmark;

    my $num_tests  = 0;
    my $test_class = $test_instance->test_class;

    context_do {
        my $ctx = shift;

        my $skipped;

        # If the call to ->$test_method fails then this subtest will fail and
        # Test2::API will also include a diagnostic message with the error.
        my $p = async_subtest(
            $test_method,
            { manual_skip_all => 1 },
            sub {
                my $hub = test2_stack()->top;
                if ( my $message = $test_instance->test_skip ) {
                    $method_report->skipped($message);

                    # I can't figure out how to get our current context in
                    # order to call $ctx->plan instead.
                    context_do {
                        shift->plan( 0, SKIP => $message );
                    };
                    $skipped = 1;
                    return 1;
                }

                $test_instance->$test_method($method_report);
                $num_tests = $hub->count;
            },
        )->finish;

        $method_report->_end_benchmark;
        if ( $self->test_configuration->show_timing ) {
            my $time = $method_report->time->duration;
            $ctx->diag( $method_report->name . ": $time" );
        }

        # $p will be undef if the tests failed but we want to stick to 0
        # or 1.
        $method_report->passed( $p ? 1 : 0 );

        if ( !$skipped || $test_instance->run_control_methods_on_skip ) {
            $self->run_test_control_method(
                $test_instance,
                'test_teardown',
                $method_report,
            ) or $method_report->passed(0);
        }

        return $p;
    };

    return $method_report unless $num_tests && !$method_report->is_skipped;

    $method_report->num_tests_run($num_tests);
    $method_report->tests_planned($num_tests)
      unless $method_report->has_plan;

    return $method_report;
}

sub test_classes {
    my $self = shift;

    if ( my $classes = $self->test_configuration->test_classes ) {
        return @{$classes} if @{$classes};
    }

    my %metaclasses = Class::MOP::get_all_metaclasses();
    my @classes;
    foreach my $class ( keys %metaclasses ) {
        next if $class eq 'Test::Class::Moose';
        push @classes => $class if $class->isa('Test::Class::Moose');
    }

    if ( $self->test_configuration->randomize_classes ) {
        return shuffle(@classes);
    }

    @classes = sort @classes;
    return @classes;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Test::Class::Moose::Role::Executor - Common code for Runner classes

=head1 VERSION

version 1.00

=head1 DESCRIPTION

This role implements the guts of this distribution, running all of your test
classes. It's public API can be wrapped by additional roles to provide
extensions to the default TCM behavior.

The actual implementations are provided by
C<Test::Class::Moose::Executor::Sequential> and
C<Test::Class::Moose::Executor::Parallel>.

=head1 API

This role provides the following public methods for extensions. If you wrap any
of the methods related to test execution you are strongly encouraged to make
sure that the original method is called, as these methods implement the core
functionality of TCM.

=head2 $executor->is_parallel

This returns a boolean indicating whether or not this executor will run test
classes in parallel or not.

=head2 $executor->test_configuration

Returns the L<Test::Class::Moose::Config> object for this executor.

=head2 $executor->test_report

Returns the L<Test::Class::Moose::Report> object for this executor.

=head2 $executor->test_classes

Returns the list of test classes to be run, in the order that they should be
run.

=head2 $executor->runtests

This is the primary entry method for test executor. It is called without any
arguments and is expected to run all of the test classes defined in the test
configuration.

=head2 $executor->run_test_class($test_class)

This method is called once for each test class to be run. It is passed a single
argument, the I<name> of the test class to be run.

=head2 $executor->run_test_instance($test_instance, $class_report)

This method is called once for each instance of a test class to be run. For
most classes this is just called once but for classes which consume the
L<Test::Class::Moose::Role::Parameterized> role, it will be called more than
once.

The first argument is the test class object to be run, and the second is an
instance of L<Test::Class::Moose::Report::Class> for the class being run.

=head2 $executor->run_test_method($test_instance, $test_method, $instance_report)

This method is called once for each test method in an instance to be run.

The first argument is the test class object to be run, the second is a method
name, and the third is an instance of L<Test::Class::Moose::Report::Instance>
for the instance being run.

=head2 $executor->run_test_control_method($test_instance, $control_method, $instance_report)

This method is called once for each test method in an instance to be run.

The first argument is the test class object to be run, the second is a control
method name (like C<'test_startup'>), and the third is an instance of
L<Test::Class::Moose::Report::Instance> for the instance being run.

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

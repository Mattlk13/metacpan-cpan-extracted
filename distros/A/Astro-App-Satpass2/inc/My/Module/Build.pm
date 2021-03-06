package My::Module::Build;

use strict;
use warnings;

use Module::Build;
our @ISA = qw{ Module::Build };

use Carp;
# use lib 'inc';	# Already done because this module is running.
use My::Module::Recommend;

sub ACTION_authortest {
##  my ( $self, @args ) = @_;	# Arguments unused
    my ( $self ) = @_;

    local $ENV{AUTHOR_TESTING} = 1;

    my @depends_on = ( qw{ build } );
    -e 'META.json' or push @depends_on, 'distmeta';
    $self->depends_on( @depends_on );

    $self->test_files( qw{ t xt/author },
	My::Module::Recommend->make_optional_modules_tests() );

    $self->depends_on( 'test' );

    return;
}

sub harness_switches {
    my ( $self ) = @_;
    my @res = $self->SUPER::harness_switches();
    foreach ( @res ) {
	'-MDevel::Cover' eq $_
	    or next;
	$_ .= '=-db,cover_db,-ignore,inc/,-ignore,eg/';
    }
    return @res;
}

1;

__END__

=head1 NAME

My::Module::Build - Extend Module::Build for My::Module

=head1 SYNOPSIS

 perl Build.PL
 ./Build
 ./Build test
 ./Build authortest # supplied by this module
 ./Build install

=head1 DESCRIPTION

This extension of L<Module::Build|Module::Build> adds the following
action to those provided by L<Module::Build|Module::Build>:

  authortest

=head1 ACTIONS

This module provides the following action:

=over

=item authortest

This action runs not only those tests which appear in the F<t>
directory, but those that appear in the F<xt> directory. The F<xt> tests
are provided for information only, since some of them (notably
F<xt/critic.t> and F<xt/pod_spelling.t>) are very sensitive to the
configuration under which they run.

Some of the F<xt> tests require modules that are not named as
requirements. These should disable themselves if the required modules
are not present.

This test is sensitive to the C<verbose=1> argument, but not to the
C<--test_files> argument.

=item distmeta

This action overrides the standard C<distmeta> to generate a generic
F<META.yml>.

=item make_optional_modules_tests

This action creates the tests in the F<xt/author/optionals> directory.
These generally duplicate the tests in the F<t> directory, but the
optional modules are made unavailable using either
L<Test::Without::Module|Test::Without::Module> or
L<Devel::Hide|Devel::Hide>, in that order. If neither of these modules
is available, nothing is done.

There should be no need to invoke this action directly, since the
C<authortest> action depends on it.

=back

=head1 SUPPORT

Support is by the author. Please file bug reports at
L<https://github.com/trwyant/perl-Astro-App-Satpass2/issues>, or in
electronic mail to the author.

=head1 AUTHOR

Thomas R. Wyant, III F<wyant at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009-2021 by Thomas R. Wyant, III

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl 5.10.0. For more details, see the full text
of the licenses in the directory LICENSES.

This program is distributed in the hope that it will be useful, but
without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.

=cut

# ex: set textwidth=72 :

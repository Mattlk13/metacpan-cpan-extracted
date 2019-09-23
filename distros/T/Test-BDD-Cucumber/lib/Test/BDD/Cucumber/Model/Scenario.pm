package Test::BDD::Cucumber::Model::Scenario;
$Test::BDD::Cucumber::Model::Scenario::VERSION = '0.660001';
use Moo;
use Types::Standard qw( Str ArrayRef HashRef Bool InstanceOf );

use Carp;

=head1 NAME

Test::BDD::Cucumber::Model::Scenario - Model to represent a scenario

=head1 VERSION

version 0.660001

=head1 DESCRIPTION

Model to represent a scenario

=head1 ATTRIBUTES

=head2 name

The text after the C<Scenario:> keyword

=cut

has 'name' => ( is => 'rw', isa => Str );

=head2 description

The text between the Scenario line and the first step line

=cut

has 'description' => (
    is      => 'rw',
    isa     => ArrayRef[InstanceOf['Test::BDD::Cucumber::Model::Line']],
    default => sub { [] },
    );

=head2 steps

The associated L<Test:BDD::Cucumber::Model::Step> objects

=cut

has 'steps' => (
    is      => 'rw',
    isa     => ArrayRef[InstanceOf['Test::BDD::Cucumber::Model::Step']],
    default => sub { [] }
);

=head2 data [deprecated]

In case the scenario has associated datasets, returns the first one,
unless it has tags associated (which wasn't supported until v0.63 of
this module), in which case this method will die with an incompatibility
error.

This (since v0.65 read-only) accessor will be removed upon release of v1.0.

=cut

sub data {
    # "pseudo" accessor
    my $self = shift;
    croak 'Scenario "data" accessor is read-only since 0.65' if @_;

    return [] unless @{$self->datasets};

    croak q{Scenario "data" accessor incompatible with multiple Examples}
        if @{$self->datasets} > 1;
    # Datasets without tags re-use the tags of the scenario
    croak q{Scenario "data" accessor incompatible with Examples tags}
        if $self->datasets->[0]->tags != $self->tags;

    return $self->datasets->[0]->data;
}

=head2 datasets

The dataset(s) associated with a scenario.

=cut

has 'datasets' => (
    is      => 'rw',
    isa     => ArrayRef[InstanceOf['Test::BDD::Cucumber::Model::Dataset']],
    default => sub { [] }
);

=head2 background

Boolean flag to mark whether this was the background section

=cut

has 'background' => ( is => 'rw', isa => Bool, default => 0 );

=head2 keyword

=head2 keyword_original

The keyword used in the input file (C<keyword_original>) and its specification
equivalent (C<keyword>) used to start this scenario. (I.e. C<Background>,
C<Scenario> and C<Scenario Outiline>.)

=cut

has 'keyword'          => ( is => 'rw', isa => Str );
has 'keyword_original' => ( is => 'rw', isa => Str );


=head2 line

A L<Test::BDD::Cucumber::Model::Line> object corresponding to the line where
the C<Scenario> keyword is.

=cut

has 'line' => ( is => 'rw', isa => InstanceOf['Test::BDD::Cucumber::Model::Line'] );

=head2 tags

Tags that the scenario has been tagged with, and has inherited from its
feature.

=cut

has 'tags' => ( is => 'rw', isa => ArrayRef[Str], default => sub { [] } );

=head1 AUTHOR

Peter Sergeant C<pete@clueball.com>

=head1 LICENSE

Copyright 2011-2016, Peter Sergeant; Licensed under the same terms as Perl

=cut

1;

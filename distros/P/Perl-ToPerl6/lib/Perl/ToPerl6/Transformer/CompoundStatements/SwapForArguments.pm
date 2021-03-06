package Perl::ToPerl6::Transformer::CompoundStatements::SwapForArguments;

use 5.006001;
use strict;
use warnings;
use Readonly;

use Perl::ToPerl6::Utils qw{ :severities };
use Perl::ToPerl6::Utils::PPI qw{
    is_ppi_statement_compound
    insert_trailing_whitespace
    remove_trailing_whitespace
};

use base 'Perl::ToPerl6::Transformer';

#-----------------------------------------------------------------------------

Readonly::Scalar my $DESC => q{Transform 'if()' to 'if ()'};
Readonly::Scalar my $EXPL =>
    q{if(), elsif() and unless() need whitespace in order to not be interpreted as function calls};

#-----------------------------------------------------------------------------

sub run_after            { return 'Operators::FormatOperators' }
sub supported_parameters { return ()                 }
sub default_necessity    { return $NECESSITY_HIGHEST }
sub default_themes       { return qw( core )         }

#-----------------------------------------------------------------------------

my %map = (
    for     => 1,
    foreach => 1,
);

my %scope_map = (
    my => 1,
    local => 1,
    our => 1
);

sub applies_to           {
    return sub {
        is_ppi_statement_compound($_[1], %map) and
        ( $_[1]->schild(1)->isa('PPI::Token::Word') or
          $_[1]->schild(1)->isa('PPI::Token::Symbol') )
    }
}

#-----------------------------------------------------------------------------

sub transform {
    my ($self, $elem, $doc) = @_;

    # This ASCII art may be of use.
    #
    # $elem                        $loop_variable
    # |                            |
    # |                            |      $whitespace
    # |                            |      |
    # [ q{for}, q{ }, q{my}, q{ }, q{$x}, q{ }, q{(@x)} ]
    #   |       |     |      |     |      |     |
    #   |       |     X      X     |      |     |
    #   |       |                  |      |     |
    #   |       |     ,-----------'       |     |
    #   |       |     |      ,------------'     |
    #   |       |     |      |     ,------------'
    #   |       |     |      |     |
    #   V       |     V      V     V
    # [ q{for}, q{ }, q{$x}, q{ }, q{(@x)} ]
    #   |       |     |      |     |
    #   |       |     '------|-----|--------------,
    #   |       `-------------,    |              |
    #   |                    | |   |              |
    #   |       ,------------' |   |              |
    #   |       |      .-------|---'              |
    #   |       |     |        |                  |
    #   |       |     |        |     +      +     |
    #   V       V     V        |     |      |     V
    # [ q{for}, q{ }, q{(@x)}, q{ }, q{->}, q{ }, q{$x} ]
    #
    if ( $scope_map{$elem->schild(1)->content} ) {
        remove_trailing_whitespace($elem->schild(1));
        $elem->schild(1)->delete;
    }

    my $whitespace = remove_trailing_whitespace($elem->schild(1));
    my $loop_variable = $elem->schild(1)->clone;
    $elem->schild(1)->remove;

    $elem->schild(1)->insert_after(
        $loop_variable
    );
    insert_trailing_whitespace($elem->schild(1));
    $elem->schild(1)->insert_after(
        PPI::Token::Operator->new('->')
    );
    insert_trailing_whitespace($elem->schild(1));

    return $self->transformation( $DESC, $EXPL, $elem );
}

1;

#-----------------------------------------------------------------------------

__END__

=pod

=head1 NAME

Perl::ToPerl6::Transformer::CompoundStatements::SwapForArguments - Swap C<for my $x ( @x ) { }> --> C<<for ( @x ) -> $x { }>>


=head1 AFFILIATION

This Transformer is part of the core L<Perl::ToPerl6|Perl::ToPerl6>
distribution.


=head1 DESCRIPTION

Perl6 formats C<for my $x (@x) { }> as C<<for (@a) -> $x>>:

  for $x (@x) { } --> for (@x) -> $x { }
  for my $x (@x) { } --> for (@x) -> $x { }

=head1 CONFIGURATION

This Transformer is not configurable except for the standard options.

=head1 AUTHOR

Jeffrey Goff <drforr@pobox.com>

=head1 COPYRIGHT

Copyright (c) 2015 Jeffrey Goff

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

##############################################################################
# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

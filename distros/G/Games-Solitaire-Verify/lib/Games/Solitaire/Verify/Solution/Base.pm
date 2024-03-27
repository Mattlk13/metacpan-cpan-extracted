package Games::Solitaire::Verify::Solution::Base;
$Games::Solitaire::Verify::Solution::Base::VERSION = '0.2600';
use strict;
use warnings;


use parent 'Games::Solitaire::Verify::Base';

# "_ln" is line number
# "_st" is the "state" (or board/layout).
# "_i" is input filehandle.
# "_V" is short for variant arguments.
__PACKAGE__->mk_acc_ref(
    [
        qw(
            _V
            _i
            _ln
            _variant
            _variant_params
            _st
            _max_rank
            _move
            _reached_end
        )
    ]
);

# _l is short for _get_line()
sub _l
{
    my $s = shift;

    # We use this instead of the accessor for speed.
    ++$s->{_ln};

    return shift( @{ $s->{_i} } );
}

sub _calc_variant_args
{
    my $self = shift;

    return [
        variant => $self->_variant(),
        (
              ( $self->_variant eq 'custom' )
            ? ( 'variant_params' => $self->_variant_params() )
            : ()
        )
    ];
}

sub _init
{
    my ( $self, $args ) = @_;

    $self->_max_rank( exists( $args->{max_rank} ) ? $args->{max_rank} : 13 );
    $self->_i(
        [
            split /^/ms,
            do
            {
                local $/;
                my $t = readline( $args->{input_fh} );
                $t =~ s/ +$//gms;
                $t;
            }
        ]
    );
    $self->_ln(0);

    $self->_variant( $args->{variant} );

    $self->_variant_params(
          $self->_variant eq 'custom'
        ? $args->{variant_params}
        : Games::Solitaire::Verify::VariantsMap->get_variant_by_id(
            $self->_variant()
        )
    );

    $self->_V( $self->_calc_variant_args() );

    return;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Games::Solitaire::Verify::Solution::Base - common base class for
all Games::Solitaire::Verify::Solution::* classes.

=head1 VERSION

version 0.2600

=for :stopwords cpan testmatrix url bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

MetaCPAN

A modern, open-source CPAN search engine, useful to view POD in HTML format.

L<https://metacpan.org/release/Games-Solitaire-Verify>

=item *

RT: CPAN's Bug Tracker

The RT ( Request Tracker ) website is the default bug/issue tracking system for CPAN.

L<https://rt.cpan.org/Public/Dist/Display.html?Name=Games-Solitaire-Verify>

=item *

CPANTS

The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

L<http://cpants.cpanauthors.org/dist/Games-Solitaire-Verify>

=item *

CPAN Testers

The CPAN Testers is a network of smoke testers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/G/Games-Solitaire-Verify>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

L<http://matrix.cpantesters.org/?dist=Games-Solitaire-Verify>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=Games::Solitaire::Verify>

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests by email to C<bug-games-solitaire-verify at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/Public/Bug/Report.html?Queue=Games-Solitaire-Verify>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<https://github.com/shlomif/fc-solve>

  git clone git://github.com/shlomif/fc-solve.git

=head1 AUTHOR

Shlomi Fish <shlomif@cpan.org>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/shlomif/fc-solve/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2008 by Shlomi Fish.

This is free software, licensed under:

  The MIT (X11) License

=cut

package Games::Solitaire::Verify::State::LaxParser;
$Games::Solitaire::Verify::State::LaxParser::VERSION = '0.2600';
use warnings;
use strict;


use parent 'Games::Solitaire::Verify::State';

sub _from_string
{
    my ( $self, $str ) = @_;

    my $rank_re = '[0A1-9TJQK]';

    my $founds_s;
    if ( $str =~ m{\A(Foundations:[^\n]*)\n}cgms )
    {
        $founds_s = $1;
    }
    else
    {
        $founds_s = "Foundations: H-0 C-0 D-0 S-0";
    }

    $self->set_foundations(
        Games::Solitaire::Verify::Foundations->new(
            {
                num_decks => $self->num_decks(),
                string    => $founds_s,
            }
        )
    );

    my $fc = 'Freecells:';
    if ( $str =~ m{\G(Freecells:[^\n]*)\n}cgms )
    {
        $fc = $1;
    }
    $self->_assign_freecells_from_string($fc);

    foreach my $col_idx ( 0 .. ( $self->num_columns() - 1 ) )
    {
        if ( $str !~ m{\G([^\n]*)\n}msg )
        {
            Games::Solitaire::Verify::Exception::Parse::State::Column->throw(
                error => "Cannot parse column",
                index => $col_idx,
            );
        }
        my $column_str = $1;
        if ( $column_str !~ /\A:/ )
        {
            $column_str =~ s/\A\s*/: /;
        }

        $self->add_column(
            Games::Solitaire::Verify::Column->new(
                {
                    string => $column_str,
                }
            )
        );
    }

    return;
}

1;    # End of Games::Solitaire::Verify::State

__END__

=pod

=encoding UTF-8

=head1 NAME

Games::Solitaire::Verify::State - a class for Solitaire
states (or positions) of the entire board.

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

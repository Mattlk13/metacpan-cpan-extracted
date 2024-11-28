package Games::Solitaire::Verify;
$Games::Solitaire::Verify::VERSION = '0.2601';
use warnings;
use strict;

use 5.008;



1;    # End of Games::Solitaire::Verify

__END__

=pod

=encoding UTF-8

=head1 NAME

Games::Solitaire::Verify - verify solutions for solitaire games.

=head1 VERSION

version 0.2601

=head1 SYNOPSIS

    use Games::Solitaire::Verify::Solution ();

    my $verifier = Games::Solitaire::Verify::Solution->new();

    $verifier->verify_solution({ fh => \*STDIN });

=head1 DESCRIPTION

This is a CPAN Perl module that verifies the solutions of various variants
of card Solitaire. It does not aim to try to be a solver for them, because
this is too CPU intensive to be adequately done using perl5 (as of
perl-5.10.0). If you're interested in the latter, look at:

=over 4

=item * L<https://fc-solve.shlomifish.org/>

=item * L<https://fc-solve.shlomifish.org/links.html#other_solvers>

=back

Instead, what Games-Solitaire-Verify does is verify the solutions
and makes sure they are correct.

See L<https://pysolfc.sourceforge.io/> for more about card solitaire.

=head1 SEE ALSO

L<Games::Solitaire::Verify::Solution> , L<Games::Solitaire::Verify::State>

=head1 AUTHOR

Shlomi Fish, L<http://www.shlomifish.org/>.

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

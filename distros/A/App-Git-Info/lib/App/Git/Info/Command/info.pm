package App::Git::Info::Command::info;
$App::Git::Info::Command::info::VERSION = '0.6.1';
use App::Git::Info -command;

use strict;
use warnings;
use autodie;
use 5.016;

sub abstract
{
    return "Displays a summary of information about the git repository.";
}

sub description { return abstract(); }

sub opt_spec
{
    return ();
}

sub validate_args
{
    my ( $self, $opt, $args ) = @_;

    # no args allowed but options!
    $self->usage_error("No args allowed") if @$args;
}

sub execute
{
    my ( $self, $opt, $args ) = @_;

    my $ST = `git status`;
    if ($?)
    {
        return;
    }

    my $ret =
        ( $ST =~
s#\A(On branch \S+\n)((?:\S[^\n]*\n)?).*#"⇒ $1".($2 ? "⇒ $2" : "")#emrs
            . `git status -s`
            . "⇒ Remotes:\n"
            . `git remote -v` );
    chomp $ret;
    say $ret;

    return;
}

1;

__END__

=pod

=encoding UTF-8

=head1 VERSION

version 0.6.1

=for :stopwords cpan testmatrix url bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

MetaCPAN

A modern, open-source CPAN search engine, useful to view POD in HTML format.

L<https://metacpan.org/release/App-Git-Info>

=item *

RT: CPAN's Bug Tracker

The RT ( Request Tracker ) website is the default bug/issue tracking system for CPAN.

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-Git-Info>

=item *

CPANTS

The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

L<http://cpants.cpanauthors.org/dist/App-Git-Info>

=item *

CPAN Testers

The CPAN Testers is a network of smoke testers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/A/App-Git-Info>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

L<http://matrix.cpantesters.org/?dist=App-Git-Info>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=App::Git::Info>

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests by email to C<bug-app-git-info at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/Public/Bug/Report.html?Queue=App-Git-Info>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<https://github.com/shlomif/perl-App-Git-Info>

  git clone https://github.com/shlomif/perl-App-Git-Info.git

=head1 AUTHOR

Shlomi Fish <shlomif@cpan.org>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/shlomif/app-git-info/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Shlomi Fish.

This is free software, licensed under:

  The MIT (X11) License

=cut

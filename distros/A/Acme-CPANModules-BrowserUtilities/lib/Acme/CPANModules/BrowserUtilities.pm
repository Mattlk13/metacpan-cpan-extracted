package Acme::CPANModules::BrowserUtilities;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2020-06-03'; # DATE
our $DIST = 'Acme-CPANModules-BrowserUtilities'; # DIST
our $VERSION = '0.002'; # VERSION

use strict;
use Acme::CPANModulesUtil::Misc;

our $text_general = <<'_';
_

our $text_firefox = <<'_';

<pm:App::FirefoxUtils> (comes with CLIs like <prog:pause-firefox>,
<prog:unpause-firefox>, <prog:kill-firefox>, <prog:list-firefox-profiles>, etc).

<pm:App::DumpFirefoxHistory> (comes with CLI: <prog:dump-firefox-history>).

<pm:App::FirefoxMultiAccountContainersUtils> (comes with CLIs like:
<prog:firefox-mua-sort-containers>, <prog:firefox-mua-modify-containers>).

<pm:Firefox::Util::Profile>

<pm:Firefox::Sync::Client>

Install latest Firefox using <prog:instopt> (from <pm:App::instopt>) and
<pm:Software::Catalog::SW::firefox>.

<pm:WordList::HTTP::UserAgentString::Browser::Firefox>

***Automating Firefox***

TODO: Comparison between these

<pm:WWW::Mechanize::Firefox>, <pm:WWW::Mechanize::Firefox::Extended>.

<pm:Firefox::Application>

<pm:Firefox::Marionette>

<pm:Selenium::Firefox>

_

our $text_chrome = <<'_';

<pm:App::ChromeUtils> (comes with CLIs like <prog:pause-chrome>,
<prog:unpause-chrome>, <prog:kill-chrome>, <prog:list-chrome-profiles>, etc).

<pm:App::DumpChromeHistory> (comes with CLI: <prog:dump-chrome-history>).

<pm:Chrome::Util::Profile>

<pm:WWW::Mechanize::Chrome>

_

our $text_opera = <<'_';

<pm:App::OperaUtils> (comes with CLIs like <prog:pause-opera>,
<prog:unpause-opera>, <prog:kill-opera>, etc).

<pm:App::DumpOperaHistory> (comes with CLI: <prog:dump-opera-history>).

_

our $text_vivaldi = <<'_';

<pm:App::VivaldiUtils> (comes with CLIs like <prog:pause-vivaldi>,
<prog:unpause-vivaldi>, <prog:kill-vivaldi>, <prog:list-vivaldi-profiles>, etc).

<pm:App::DumpVivaldiHistory> (comes with CLI: <prog:dump-vivaldi-history>).

<pm:Vivaldi::Util::Profile>

_


my $text = <<_;
**General**

$text_general

**Firefox**

$text_firefox

**Google Chrome**

$text_chrome

**Opera**

$text_opera

**Vivaldi**

$text_vivaldi

_

our $LIST = {
    summary => "Utilities for web browsers",
    description => $text,
};

Acme::CPANModulesUtil::Misc::populate_entries_from_module_links_in_description;

1;
# ABSTRACT: Utilities for web browsers

__END__

=pod

=encoding UTF-8

=head1 NAME

Acme::CPANModules::BrowserUtilities - Utilities for web browsers

=head1 VERSION

This document describes version 0.002 of Acme::CPANModules::BrowserUtilities (from Perl distribution Acme-CPANModules-BrowserUtilities), released on 2020-06-03.

=head1 DESCRIPTION

B<General>

B<Firefox>

L<App::FirefoxUtils> (comes with CLIs like L<pause-firefox>,
L<unpause-firefox>, L<kill-firefox>, L<list-firefox-profiles>, etc).

L<App::DumpFirefoxHistory> (comes with CLI: L<dump-firefox-history>).

L<App::FirefoxMultiAccountContainersUtils> (comes with CLIs like:
L<firefox-mua-sort-containers>, L<firefox-mua-modify-containers>).

L<Firefox::Util::Profile>

L<Firefox::Sync::Client>

Install latest Firefox using L<instopt> (from L<App::instopt>) and
L<Software::Catalog::SW::firefox>.

L<WordList::HTTP::UserAgentString::Browser::Firefox>

B<I<Automating Firefox>>

TODO: Comparison between these

L<WWW::Mechanize::Firefox>, L<WWW::Mechanize::Firefox::Extended>.

L<Firefox::Application>

L<Firefox::Marionette>

L<Selenium::Firefox>

B<Google Chrome>

L<App::ChromeUtils> (comes with CLIs like L<pause-chrome>,
L<unpause-chrome>, L<kill-chrome>, L<list-chrome-profiles>, etc).

L<App::DumpChromeHistory> (comes with CLI: L<dump-chrome-history>).

L<Chrome::Util::Profile>

L<WWW::Mechanize::Chrome>

B<Opera>

L<App::OperaUtils> (comes with CLIs like L<pause-opera>,
L<unpause-opera>, L<kill-opera>, etc).

L<App::DumpOperaHistory> (comes with CLI: L<dump-opera-history>).

B<Vivaldi>

L<App::VivaldiUtils> (comes with CLIs like L<pause-vivaldi>,
L<unpause-vivaldi>, L<kill-vivaldi>, L<list-vivaldi-profiles>, etc).

L<App::DumpVivaldiHistory> (comes with CLI: L<dump-vivaldi-history>).

L<Vivaldi::Util::Profile>

=head1 INCLUDED MODULES

=over

=item * L<App::FirefoxUtils>

=item * L<App::DumpFirefoxHistory>

=item * L<App::FirefoxMultiAccountContainersUtils>

=item * L<Firefox::Util::Profile>

=item * L<Firefox::Sync::Client>

=item * L<App::instopt>

=item * L<Software::Catalog::SW::firefox>

=item * L<WordList::HTTP::UserAgentString::Browser::Firefox>

=item * L<WWW::Mechanize::Firefox>

=item * L<WWW::Mechanize::Firefox::Extended>

=item * L<Firefox::Application>

=item * L<Firefox::Marionette>

=item * L<Selenium::Firefox>

=item * L<App::ChromeUtils>

=item * L<App::DumpChromeHistory>

=item * L<Chrome::Util::Profile>

=item * L<WWW::Mechanize::Chrome>

=item * L<App::OperaUtils>

=item * L<App::DumpOperaHistory>

=item * L<App::VivaldiUtils>

=item * L<App::DumpVivaldiHistory>

=item * L<Vivaldi::Util::Profile>

=back

=head1 FAQ

=head2 What are ways to use this module?

Aside from reading it, you can install all the listed modules using
L<cpanmodules>:

    % cpanmodules ls-entries BrowserUtilities | cpanm -n

or L<Acme::CM::Get>:

    % perl -MAcme::CM::Get=BrowserUtilities -E'say $_->{module} for @{ $LIST->{entries} }' | cpanm -n

This module also helps L<lcpan> produce a more meaningful result for C<lcpan
related-mods> when it comes to finding related modules for the modules listed
in this Acme::CPANModules module.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Acme-CPANModules-BrowserUtilities>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Acme-CPANModules-BrowserUtilities>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Acme-CPANModules-BrowserUtilities>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Acme::CPANModules> - about the Acme::CPANModules namespace

L<cpanmodules> - CLI tool to let you browse/view the lists

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

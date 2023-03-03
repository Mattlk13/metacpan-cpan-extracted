package App::manwrap::pm;

use strict;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2023-01-17'; # DATE
our $DIST = 'App-manwrap-pm'; # DIST
our $VERSION = '0.006'; # VERSION

1;
# ABSTRACT: man + Perl stuffs

__END__

=pod

=encoding UTF-8

=head1 NAME

App::manwrap::pm - man + Perl stuffs

=head1 VERSION

This document describes version 0.006 of App::manwrap::pm (from Perl distribution App-manwrap-pm), released on 2023-01-17.

=head1 SYNOPSIS

See L<manwrap-pm> included in this distribution.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/App-manwrap-pm>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-manwrap-pm>.

=head1 SEE ALSO

L<pmman> from L<App::PMUtils>

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 CONTRIBUTING


To contribute, you can send patches by email/via RT, or send pull requests on
GitHub.

Most of the time, you don't need to build the distribution yourself. You can
simply modify the code, then test via:

 % prove -l

If you want to build the distribution (e.g. to try to install it locally on your
system), you can install L<Dist::Zilla>,
L<Dist::Zilla::PluginBundle::Author::PERLANCAR>,
L<Pod::Weaver::PluginBundle::Author::PERLANCAR>, and sometimes one or two other
Dist::Zilla- and/or Pod::Weaver plugins. Any additional steps required beyond
that are considered a bug and can be reported to me.

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2023, 2019, 2017, 2016 by perlancar <perlancar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-manwrap-pm>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=cut

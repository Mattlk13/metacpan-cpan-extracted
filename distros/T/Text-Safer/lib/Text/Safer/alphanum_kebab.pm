package Text::Safer::alphanum_kebab;

use 5.010001;
use strict;
use warnings;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2025-06-11'; # DATE
our $DIST = 'Text-Safer'; # DIST
our $VERSION = '0.002'; # VERSION

our %META = (
    args => {
        lc => {
            schema => 'bool*',
        },
    },
);

sub encode_safer {
    my ($text, $args) = @_;
    $args //= {};

    $text =~ s/[^A-Za-z0-9_-]+/-/g;
    $args->{lc} ? lc($text) : $text;
}

1;
# ABSTRACT: Convert text to a safer (e.g. more restricted) encoding using only alphanumeric and dash characters

__END__

=pod

=encoding UTF-8

=head1 NAME

Text::Safer::alphanum_kebab - Convert text to a safer (e.g. more restricted) encoding using only alphanumeric and dash characters

=head1 VERSION

This document describes version 0.002 of Text::Safer::alphanum_kebab (from Perl distribution Text-Safer), released on 2025-06-11.

=head1 SYNOPSIS

=head1 DESCRIPTION

- Multiple non-alphanumeric characters are converted to a single dash
- Underscores are not converted to dash

=head1 FUNCTIONS

=head2 encode_safer

Arguments:

=over

=item * lc

=back

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Text-Safer>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Text-Safer>.

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

This software is copyright (c) 2025 by perlancar <perlancar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Text-Safer>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=cut

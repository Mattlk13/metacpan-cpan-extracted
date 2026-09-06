package Desktop::KDE::Util;

use 5.010001;
use strict;
use warnings;
use Log::ger;

use Exporter qw(import);
use IPC::System::Options 'system', -log=>1;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2026-06-17'; # DATE
our $DIST = 'Desktop-KDE-Util'; # DIST
our $VERSION = '0.001'; # VERSION

our @EXPORT_OK = qw(
                       which_qdbus
               );

our %SPEC;

$SPEC{':package'} = {
    v => 1.1,
    summary => 'Utilities related to KDE',
};

$SPEC{which_qdbus} = {
    v => 1.1,
    summary => "List paths to qdbus",
    args => {
    },
    result_naked => 1,
    result => {
        schema => 'array*',
    },
};
sub which_qdbus {
    require File::Which;

    my @paths;
    if (my $path = File::Which::which("qdbus")) {
        log_trace "qdbus found in PATH: $path";
        push @paths, $path;
    } else {
        for my $dir ("/usr/lib/qt6/bin", "/usr/lib/qt5/bin") {
            if ((-d $dir) && (-x "$dir/qdbus")) {
                log_trace "qdbus found in $dir";
                push @paths, "$dir/qdbus";
            }
        }
    }

    \@paths;
}

1;
# ABSTRACT: Utilities related to KDE

__END__

=pod

=encoding UTF-8

=head1 NAME

Desktop::KDE::Util - Utilities related to KDE

=head1 VERSION

This document describes version 0.001 of Desktop::KDE::Util (from Perl distribution Desktop-KDE-Util), released on 2026-06-17.

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FUNCTIONS


=head2 which_qdbus

Usage:

 which_qdbus() -> array

List paths to qdbus.

This function is not exported by default, but exportable.

No arguments.

Return value:  (array)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Desktop-KDE-Util>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Desktop-KDE-Util>.

=head1 SEE ALSO

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 CONTRIBUTOR

=for stopwords perlancar

perlancar <perlancar@gmail.com>

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

This software is copyright (c) 2026 by perlancar <perlancar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Desktop-KDE-Util>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=cut

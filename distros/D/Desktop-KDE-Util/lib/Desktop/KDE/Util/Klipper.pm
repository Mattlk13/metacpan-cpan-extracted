package Desktop::KDE::Util::Klipper;

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
                       klipper_available
                       klipper_enabled
               );

our %SPEC;

$SPEC{':package'} = {
    v => 1.1,
    summary => 'Utilities related to Klipper, the KDE clipboard service',
};

$SPEC{klipper_available} = {
    v => 1.1,
    summary => "Check whether klipper is available",
    description => <<'MARKDOWN',

Note that even though klipper is available, it can be *disabled*.

Use `klipper_enabled()` routine to check whether klipper is enabled.

MARKDOWN
    args => {
    },
    result_naked => 1,
    result => {
        schema => 'bool*',
    },
};
sub klipper_available {
    log_trace "Checking whether clipboard manager klipper is available ...";

    require Desktop::KDE::Util;
    my $paths = Desktop::KDE::Util::which_qdbus();

    unless (@$paths) {
        log_trace "qdbus not found, assuming klipper is not available";
        return 0;
    }

    for my $path (@$paths) {
        my $out;
        system({capture_merged=>\$out}, $path, "org.kde.klipper");
        unless ($? == 0) {
            log_trace "Failed listing org.kde.klipper (using qdus at $path)";
            next;
        }
        log_trace "org.kde.klipper object active";
        return 1;
    }

    log_trace "No org.kde.klipper object available anywhere, assuming klipper is not available";
    0;
}

$SPEC{klipper_enabled} = {
    v => 1.1,
    summary => "Check whether klipper is enabled",
    description => <<'MARKDOWN',

See also: `klipper_available()`.

MARKDOWN
    args => {
    },
    result_naked => 1,
    result => {
        schema => 'bool*',
    },
};
sub klipper_enabled {
    log_trace "Checking whether clipboard manager klipper is enabled ...";

    require Desktop::KDE::Util;
    my $paths = Desktop::KDE::Util::which_qdbus();

    unless (@$paths) {
        log_trace "qdbus not found, assuming klipper is not enabled";
        return 0;
    }

    for my $path (@$paths) {
        my $out;
        system({capture_merged=>\$out}, $path, "org.kde.klipper");
        unless ($? == 0) {
            log_trace "Failed listing org.kde.klipper (using qdus at $path)";
            next;
        }
        log_trace "org.kde.klipper object active";
        return 1;
    }
}

1;
# ABSTRACT: Utilities related to Klipper, the KDE clipboard service

__END__

=pod

=encoding UTF-8

=head1 NAME

Desktop::KDE::Util::Klipper - Utilities related to Klipper, the KDE clipboard service

=head1 VERSION

This document describes version 0.001 of Desktop::KDE::Util::Klipper (from Perl distribution Desktop-KDE-Util), released on 2026-06-17.

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 FUNCTIONS


=head2 klipper_available

Usage:

 klipper_available() -> bool

Check whether klipper is available.

Note that even though klipper is available, it can be I<disabled>.

Use C<klipper_enabled()> routine to check whether klipper is enabled.

This function is not exported by default, but exportable.

No arguments.

Return value:  (bool)



=head2 klipper_enabled

Usage:

 klipper_enabled() -> bool

Check whether klipper is enabled.

See also: C<klipper_available()>.

This function is not exported by default, but exportable.

No arguments.

Return value:  (bool)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Desktop-KDE-Util>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Desktop-KDE-Util>.

=head1 SEE ALSO

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

This software is copyright (c) 2026 by perlancar <perlancar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Desktop-KDE-Util>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=cut

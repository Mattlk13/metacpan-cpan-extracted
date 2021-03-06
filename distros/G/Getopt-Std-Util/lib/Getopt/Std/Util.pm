package Getopt::Std::Util;

our $DATE = '2016-10-30'; # DATE
our $VERSION = '0.001'; # VERSION

use 5.010001;
use strict;
use warnings;

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(
                       detect_getopt_std_script
               );

our %SPEC;

$SPEC{detect_getopt_std_script} = {
    v => 1.1,
    summary => 'Detect whether a file is a Getopt::Std-based CLI script',
    description => <<'_',

The criteria are:

* the file must exist and readable;

* (optional, if `include_noexec` is false) file must have its executable mode
  bit set;

* content must start with a shebang C<#!>;

* either: must be perl script (shebang line contains 'perl') and must contain
  something like `use Getopt::Std`;

_
    args => {
        filename => {
            summary => 'Path to file to be checked',
            schema => 'str*',
            pos => 0,
            cmdline_aliases => {f=>{}},
        },
        string => {
            summary => 'String to be checked',
            schema => 'buf*',
        },
        include_noexec => {
            summary => 'Include scripts that do not have +x mode bit set',
            schema  => 'bool*',
            default => 1,
        },
    },
    args_rels => {
        'req_one' => ['filename', 'string'],
    },
};
sub detect_getopt_std_script {
    my %args = @_;

    (defined($args{filename}) xor defined($args{string}))
        or return [400, "Please specify either filename or string"];
    my $include_noexec  = $args{include_noexec}  // 1;

    my $yesno = 0;
    my $reason = "";
    my %extrameta;

    my $str = $args{string};
  DETECT:
    {
        if (defined $args{filename}) {
            my $fn = $args{filename};
            unless (-f $fn) {
                $reason = "'$fn' is not a file";
                last;
            };
            if (!$include_noexec && !(-x _)) {
                $reason = "'$fn' is not an executable";
                last;
            }
            my $fh;
            unless (open $fh, "<", $fn) {
                $reason = "Can't be read";
                last;
            }
            # for efficiency, we read a bit only here
            read $fh, $str, 2;
            unless ($str eq '#!') {
                $reason = "Does not start with a shebang (#!) sequence";
                last;
            }
            my $shebang = <$fh>;
            unless ($shebang =~ /perl/) {
                $reason = "Does not have 'perl' in the shebang line";
                last;
            }
            seek $fh, 0, 0;
            {
                local $/;
                $str = <$fh>;
            }
        }
        unless ($str =~ /\A#!/) {
            $reason = "Does not start with a shebang (#!) sequence";
            last;
        }
        unless ($str =~ /\A#!.*perl/) {
            $reason = "Does not have 'perl' in the shebang line";
            last;
        }

        # NOTE: the presence of \s* pattern after ^ causes massive slowdown of
        # the regex when we reach many thousands of lines, so we use split()

        #if ($str =~ /^\s*(use|require)\s+(Getopt::Std)(\s|;)/m) {
        #    $yesno = 1;
        #    $extrameta{'func.module'} = $2;
        #    last DETECT;
        #}

        for (split /^/, $str) {
            if (/^\s*(use|require)\s+(Getopt::Std)(\s|;|\(|$)/) {
                $yesno = 1;
                $extrameta{'func.module'} = $2;
                last DETECT;
            }
        }

        $reason = "Can't find any statement requiring Getopt::Std module";
    } # DETECT

    [200, "OK", $yesno, {"func.reason"=>$reason, %extrameta}];
}

# ABSTRACT: Utilities for Getopt::Std

__END__

=pod

=encoding UTF-8

=head1 NAME

Getopt::Std::Util - Utilities for Getopt::Std

=head1 VERSION

This document describes version 0.001 of Getopt::Std::Util (from Perl distribution Getopt-Std-Util), released on 2016-10-30.

=head1 FUNCTIONS


=head2 detect_getopt_std_script(%args) -> [status, msg, result, meta]

Detect whether a file is a Getopt::Std-based CLI script.

The criteria are:

=over

=item * the file must exist and readable;

=item * (optional, if C<include_noexec> is false) file must have its executable mode
bit set;

=item * content must start with a shebang C<#!>;

=item * either: must be perl script (shebang line contains 'perl') and must contain
something like C<use Getopt::Std>;

=back

This function is not exported by default, but exportable.

Arguments ('*' denotes required arguments):

=over 4

=item * B<filename> => I<str>

Path to file to be checked.

=item * B<include_noexec> => I<bool> (default: 1)

Include scripts that do not have +x mode bit set.

=item * B<string> => I<buf>

String to be checked.

=back

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (result) is optional, the actual result. Fourth
element (meta) is called result metadata and is optional, a hash
that contains extra information.

Return value:  (any)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Getopt-Std-Util>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Getopt-Std-Util>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Getopt-Std-Util>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Getopt::Std>

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

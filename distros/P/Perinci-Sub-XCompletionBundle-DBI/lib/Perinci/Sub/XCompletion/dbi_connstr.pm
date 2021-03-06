package Perinci::Sub::XCompletion::dbi_connstr;

our $DATE = '2019-01-20'; # DATE
our $VERSION = '0.001'; # VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

use Complete::Util qw(complete_array_elem);

our %SPEC;

$SPEC{gen_completion} = {
    v => 1.1,
};
sub gen_completion {
    require PERLANCAR::Module::List;

    my %fargs = @_;

    sub {
        my %cargs = @_;
        my $word    = $cargs{word} // '';

        if ($word =~ /\A(\w*|dbi:\w*)\z/) {
            my $mods = PERLANCAR::Module::List::list_modules(
                'DBD::',
                {list_modules=>1},
            );
            my @ary;
            for (keys %$mods) { s/\ADBD:://; push @ary, "dbi:$_" }

            return complete_array_elem(
                word => $word,
                array => \@ary,
            );
        } else {
            return undef;
        }
    };
}

1;
# ABSTRACT: Complete DBD name after "dbi:" in DBI connection string

__END__

=pod

=encoding UTF-8

=head1 NAME

Perinci::Sub::XCompletion::dbi_connstr - Complete DBD name after "dbi:" in DBI connection string

=head1 VERSION

This document describes version 0.001 of Perinci::Sub::XCompletion::dbi_connstr (from Perl distribution Perinci-Sub-XCompletionBundle-DBI), released on 2019-01-20.

=head1 FUNCTIONS


=head2 gen_completion

Usage:

 gen_completion() -> [status, msg, payload, meta]

This function is not exported.

No arguments.

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (payload) is optional, the actual result. Fourth
element (meta) is called result metadata and is optional, a hash
that contains extra information.

Return value:  (any)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Perinci-Sub-XCompletionBundle-DBI>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Perinci-Sub-XCompletionBundle-DBI>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Perinci-Sub-XCompletionBundle-DBI>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

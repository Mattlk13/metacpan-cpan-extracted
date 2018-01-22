package App::lcpan::Cmd::inject;

our $DATE = '2018-01-15'; # DATE
our $VERSION = '1.020'; # VERSION

use 5.010;
use strict;
use warnings;

require App::lcpan;
use Proc::ChildError qw(explain_child_error);

our %SPEC;

$SPEC{'handle_cmd'} = {
    v => 1.1,
    summary => 'Inject one or more tarballs to the mirror',
    args => {
        %App::lcpan::common_args,
        author => {
            schema => ['str*'],
            req => 1,
            cmdline_aliases => {a=>{}},
            completion => \&_complete_cpanid,
        },
        files => {
            schema => ['array*', of=>'filename*', min_len=>1],
            'x.name.is_plural' => 1,
            req => 1,
            pos => 0,
            greedy => 1,
        },
    },
    deps => {
        prog => 'orepan.pl',
    },
};
sub handle_cmd {
    my %args = @_;

    my $state = App::lcpan::_init(\%args, 'rw');
    my $author = delete $args{author};
    my $files  = delete $args{files};
    my $dbh = $state->{dbh};

    for my $file (@$files) {
        system "orepan.pl", "--destination", $state->{cpan}, "--pause", $author,
            $file;
        return [500, "orepan.pl failed: ".explain_child_error()] if $?;
    }

    App::lcpan::update(
        %args,
        update_files => 0,
        update_index => 1,
    );
}

1;
# ABSTRACT: Inject one or more tarballs to the mirror

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::inject - Inject one or more tarballs to the mirror

=head1 VERSION

This document describes version 1.020 of App::lcpan::Cmd::inject (from Perl distribution App-lcpan), released on 2018-01-15.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [status, msg, result, meta]

Inject one or more tarballs to the mirror.

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<author>* => I<str>

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. /path/to/cpan.

Defaults to C<~/cpan>.

=item * B<files>* => I<array[filename]>

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

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

Please visit the project's homepage at L<https://metacpan.org/release/App-lcpan>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-lcpan>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-lcpan>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018, 2017, 2016, 2015 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

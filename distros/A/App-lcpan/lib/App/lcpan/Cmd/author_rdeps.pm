package App::lcpan::Cmd::author_rdeps;

our $DATE = '2020-08-13'; # DATE
our $VERSION = '1.062'; # VERSION

use 5.010;
use strict;
use warnings;

require App::lcpan;
use Hash::Subset 'hash_subset';

our %SPEC;

$SPEC{'handle_cmd'} = {
    v => 1.1,
    summary => "Find distributions that use one of author's modules",
    args => {
        %App::lcpan::common_args,
        %App::lcpan::author_args,
        %App::lcpan::rdeps_rel_args,
        %App::lcpan::rdeps_phase_args,
        user_authors => {
            'x.name.is_plural' => 1,
            'x.name.singular' => 'user_author',
            schema => ['array*', of=>'str*'],
            element_completion => \&App::lcpan::_complete_cpanid,
        },
        user_authors_arent => {
            'x.name.is_plural' => 1,
            'x.name.singular' => 'user_author_isnt',
            schema => ['array*', of=>'str*'],
            element_completion => \&App::lcpan::_complete_cpanid,
        },
        %App::lcpan::fctime_args,
        %App::lcpan::fmtime_args,
    },
};
sub handle_cmd {
    my %args = @_;

    my $author = $args{author};

    my $res = App::lcpan::modules(
        hash_subset(\%args, \%App::lcpan::common_args, \%App::lcpan::author_args),
    );
    return $res if $res->[0] != 200;

    my $mods = $res->[2];
    my %rdeps_args = %args;
    $rdeps_args{modules} = $mods;
    delete $rdeps_args{author};
    delete $rdeps_args{authors};
    delete $rdeps_args{authors_arent};
    $rdeps_args{authors} = delete $args{user_authors};
    $rdeps_args{authors_arent} = delete $args{user_authors_arent};
    $rdeps_args{phase} = delete $args{phase};
    $rdeps_args{rel} = delete $args{rel};
    $rdeps_args{added_since} = delete $args{added_since};
    $rdeps_args{updated_since} = delete $args{updated_since};
    $rdeps_args{added_or_updated_since} = delete $args{added_or_updated_since};
    $res = App::lcpan::rdeps(%rdeps_args);
    return $res if $res->[0] != 200;

    $res;
}

1;
# ABSTRACT: Find distributions that use one of author's modules

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::author_rdeps - Find distributions that use one of author's modules

=head1 VERSION

This document describes version 1.062 of App::lcpan::Cmd::author_rdeps (from Perl distribution App-lcpan), released on 2020-08-13.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [status, msg, payload, meta]

Find distributions that use one of author's modules.

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<added_since> => I<date>

Include only records that are added since a certain date.

=item * B<added_since_last_index_update> => I<true>

Include only records that are added since the last index update.

=item * B<added_since_last_n_index_updates> => I<posint>

Include only records that are added since the last N index updates.

=item * B<author>* => I<str>

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. E<sol>pathE<sol>toE<sol>cpan.

Defaults to C<~/cpan>.

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

If C<index_name> is a filename without any path, e.g. C<index.db> then index will
be located in the top-level of C<cpan>. If C<index_name> contains a path, e.g.
C<./index.db> or C</home/ujang/lcpan.db> then the index will be located solely
using the C<index_name>.

=item * B<phase> => I<str> (default: "ALL")

=item * B<rel> => I<str> (default: "ALL")

=item * B<updated_since> => I<date>

Include only records that are updated since certain date.

=item * B<updated_since_last_index_update> => I<true>

Include only records that are updated since the last index update.

=item * B<updated_since_last_n_index_updates> => I<posint>

Include only records that are updated since the last N index updates.

=item * B<use_bootstrap> => I<bool> (default: 1)

Whether to use bootstrap database from App-lcpan-Bootstrap.

If you are indexing your private CPAN-like repository, you want to turn this
off.

=item * B<user_authors> => I<array[str]>

=item * B<user_authors_arent> => I<array[str]>


=back

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (payload) is optional, the actual result. Fourth
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

This software is copyright (c) 2020, 2019, 2018, 2017, 2016, 2015 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

package App::lcpan::Cmd::mentions_for_script;

our $DATE = '2020-06-11'; # DATE
our $VERSION = '1.061'; # VERSION

use 5.010;
use strict;
use warnings;
use Log::ger;

require App::lcpan;
require App::lcpan::Cmd::mentions;

our %SPEC;

my $mentions_args = $App::lcpan::Cmd::mentions::SPEC{handle_cmd}{args};

$SPEC{'handle_cmd'} = {
    v => 1.1,
    summary => 'List POD mentions for script(s)',
    description => <<'_',

This subcommand is a shortcut for:

    % lcpan mentions --type script --mentioned-script SCRIPT

_
    args => {
        %App::lcpan::common_args,
        %App::lcpan::scripts_args,
        (map {$_ => $mentions_args->{$_}}
             grep {!/\A(type|mentioned_modules|mentioned_scripts)\z/}
             keys %$mentions_args),
    },
};
sub handle_cmd {
    my %args = @_;

    my %mentions_args = %args;

    delete $mentions_args{scripts};
    $mentions_args{mentioned_scripts} = $args{scripts};

    $mentions_args{type} = 'script';

    App::lcpan::Cmd::mentions::handle_cmd(%mentions_args);
}

1;
# ABSTRACT: List POD mentions for script(s)

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::mentions_for_script - List POD mentions for script(s)

=head1 VERSION

This document describes version 1.061 of App::lcpan::Cmd::mentions_for_script (from Perl distribution App-lcpan), released on 2020-06-11.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [status, msg, payload, meta]

List POD mentions for script(s).

This subcommand is a shortcut for:

 % lcpan mentions --type script --mentioned-script SCRIPT

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<added_or_updated_since> => I<date>

Include only records that are addedE<sol>updated since a certain date.

=item * B<added_or_updated_since_last_index_update> => I<true>

Include only records that are addedE<sol>updated since the last index update.

=item * B<added_or_updated_since_last_n_index_updates> => I<posint>

Include only records that are addedE<sol>updated since the last N index updates.

=item * B<added_since> => I<date>

Include only records that are added since a certain date.

=item * B<added_since_last_index_update> => I<true>

Include only records that are added since the last index update.

=item * B<added_since_last_n_index_updates> => I<posint>

Include only records that are added since the last N index updates.

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. E<sol>pathE<sol>toE<sol>cpan.

Defaults to C<~/cpan>.

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

If C<index_name> is a filename without any path, e.g. C<index.db> then index will
be located in the top-level of C<cpan>. If C<index_name> contains a path, e.g.
C<./index.db> or C</home/ujang/lcpan.db> then the index will be located solely
using the C<index_name>.

=item * B<mentioned_authors> => I<array[str]>

Filter by author(s) of moduleE<sol>script being mentioned.

=item * B<mentioner_authors> => I<array[str]>

Filter by author(s) of POD that does the mentioning.

=item * B<mentioner_authors_arent> => I<array[str]>

=item * B<mentioner_modules> => I<array[str]>

Filter by module(s) that do the mentioning.

=item * B<mentioner_scripts> => I<array[str]>

Filter by script(s) that do the mentioning.

=item * B<scripts>* => I<array[filename::unix]>

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

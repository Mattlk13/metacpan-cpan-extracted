## no critic: ControlStructures::ProhibitUnreachableCode

package App::lcpan::Cmd::whatsnew;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2020-08-13'; # DATE
our $DIST = 'App-lcpan'; # DIST
our $VERSION = '1.062'; # VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

require App::lcpan;
use Hash::Subset 'hash_subset';

our %SPEC;

$SPEC{'handle_cmd'} = {
    v => 1.1,
    summary => "Show what's added/updated recently",
    args => {
        %App::lcpan::common_args,
        %App::lcpan::fctime_or_mtime_args,
        my_author => {
            summary => 'My author ID',
            description => <<'_',

If specified, will show additional added/updated items for this author ID
("you"), e.g. what distributions recently added dependency to one of your
modules.

_
            schema => 'str*',
            cmdline_aliases => {a=>{}},
            completion => \&App::lcpan::_complete_cpanid,
        },
    },
};
sub handle_cmd {
    require Perinci::Result::Format::Lite;
    require Text::Table::Org; # just to let scan-prereqs know

    my %args = @_;
    my $my_author = $args{my_author};

    my $state = App::lcpan::_init(\%args, 'ro');
    my $dbh = $state->{dbh};

    $args{added_or_updated_since_last_index_update} = 1 if !(grep {exists $App::lcpan::fctime_or_mtime_args{$_}} keys %args);
    App::lcpan::_set_since(\%args, $dbh);

    my $time = delete($args{added_or_updated_since});
    my $ftime = scalar(gmtime $time) . " UTC";

    my $org = '';

    local $ENV{FORMAT_PRETTY_TABLE_BACKEND} = 'Text::Table::Org';

    #$org .= "#+INFOJS_OPT: view:info toc:nil\n";
    $org .= "WHAT'S NEW SINCE $ftime\n\n";

  NEW_MODULES: {
        my ($res, $fres);
        $res = App::lcpan::modules(added_since=>$time, detail=>1);
        unless ($res->[0] == 200) {
            $org .= "Can't list new modules: $res->[0] - $res->[1]\n\n";
            last;
        }
        my $num = @{ $res->[2] };
        $org .= "* New modules ($num)\n";
        $fres = Perinci::Result::Format::Lite::format(
            $res, 'text-pretty', 0, 0);
        $org .= $fres;
        $org .= "\n";
    }

  UPDATED_MODULES: {
        my ($res, $fres);
        $res = App::lcpan::modules(updated_since=>$time, detail=>1);
        unless ($res->[0] == 200) {
            $org .= "Can't list updated modules: $res->[0] - $res->[1]\n\n";
            last;
        }
        my $num = @{ $res->[2] };
        $org .= "* Updated modules ($num)\n";
        $fres = Perinci::Result::Format::Lite::format(
            $res, 'text-pretty', 0, 0);
        $org .= $fres;
        $org .= "\n";
    }

  NEW_AUTHORS: {
        my ($res, $fres);
        $res = App::lcpan::authors(added_since=>$time, detail=>1);
        unless ($res->[0] == 200) {
            $org .= "Can't list new authors: $res->[0] - $res->[1]\n\n";
            last;
        }
        my $num = @{ $res->[2] };
        $org .= "* New authors ($num)\n";
        $fres = Perinci::Result::Format::Lite::format(
            $res, 'text-pretty', 0, 0);
        $org .= $fres;
        $org .= "\n";
    }

  UPDATED_AUTHORS: {
        my ($res, $fres);
        $res = App::lcpan::authors(updated_since=>$time, detail=>1);
        unless ($res->[0] == 200) {
            $org .= "Can't list updated authors: $res->[0] - $res->[1]\n\n";
            last;
        }
        my $num = @{ $res->[2] };
        $org .= "* Updated authors ($num)\n";
        $fres = Perinci::Result::Format::Lite::format(
            $res, 'text-pretty', 0, 0);
        $org .= $fres;
        $org .= "\n";
    }

  NEW_REVERSE_DEPENDENCIES: {
        last unless defined $my_author;
        my ($res, $fres);
        require App::lcpan::Cmd::author_rdeps;
        $res = App::lcpan::Cmd::author_rdeps::handle_cmd(
            author=>$my_author, user_authors_arent=>[$my_author],
            added_since=>$time,
            phase => 'ALL',
            rel => 'ALL',
        );
        unless ($res->[0] == 200) {
            $org .= "Can't list new reverse dependencies for modules of $my_author: $res->[0] - $res->[1]\n\n";
            last;
        }
        my $num = @{ $res->[2] };
        $org .= "* Distributions of other authors recently depending on one of $my_author\'s modules ($num)\n";
        $fres = Perinci::Result::Format::Lite::format(
            $res, 'text-pretty', 0, 0);
        $org .= $fres;
        $org .= "\n";
    }

  UPDATED_REVERSE_DEPENDENCIES: {
        # skip for now, usually empty. because dep records are usually not
        # updated but recreated.
        last;

        last unless defined $my_author;
        my ($res, $fres);
        require App::lcpan::Cmd::author_rdeps;
        $res = App::lcpan::Cmd::author_rdeps::handle_cmd(
            author=>$my_author, user_authors_arent=>[$my_author], updated_since=>$time,
            phase => 'ALL',
            rel => 'ALL',
        );
        unless ($res->[0] == 200) {
            $org .= "Can't list updated reverse dependencies for modules of $my_author: $res->[0] - $res->[1]\n\n";
            last;
        }
        my $num = @{ $res->[2] };
        $org .= "* Distributions of other authors which updated dependencies to one of $my_author\'s modules ($num)\n";
        $fres = Perinci::Result::Format::Lite::format(
            $res, 'text-pretty', 0, 0);
        $org .= $fres;
        $org .= "\n";
    }

  NEW_MENTIONS: {
        last unless defined $my_author;
        my ($res, $fres);
        require App::lcpan::Cmd::mentions;
        $res = App::lcpan::Cmd::mentions::handle_cmd(
            mentioned_authors=>[$my_author], mentioner_authors_arent=>[$my_author], added_since=>$time,
        );
        unless ($res->[0] == 200) {
            $org .= "Can't list updated reverse dependencies for modules of $my_author: $res->[0] - $res->[1]\n\n";
            last;
        }
        my $num = @{ $res->[2] };
        $org .= "* New mentions to one of $my_author\'s modules ($num)\n";
        $fres = Perinci::Result::Format::Lite::format(
            $res, 'text-pretty', 0, 0);
        $org .= $fres;
        $org .= "\n";
    }

    [200, "OK", $org, {'content_type' => 'text/x-org'}];
}

1;
# ABSTRACT: Show what's added/updated recently

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::whatsnew - Show what's added/updated recently

=head1 VERSION

This document describes version 1.062 of App::lcpan::Cmd::whatsnew (from Perl distribution App-lcpan), released on 2020-08-13.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [status, msg, payload, meta]

Show what's addedE<sol>updated recently.

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<added_or_updated_since> => I<date>

Include only records that are addedE<sol>updated since a certain date.

=item * B<added_or_updated_since_last_index_update> => I<true>

Include only records that are addedE<sol>updated since the last index update.

=item * B<added_or_updated_since_last_n_index_updates> => I<posint>

Include only records that are addedE<sol>updated since the last N index updates.

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. E<sol>pathE<sol>toE<sol>cpan.

Defaults to C<~/cpan>.

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

If C<index_name> is a filename without any path, e.g. C<index.db> then index will
be located in the top-level of C<cpan>. If C<index_name> contains a path, e.g.
C<./index.db> or C</home/ujang/lcpan.db> then the index will be located solely
using the C<index_name>.

=item * B<my_author> => I<str>

My author ID.

If specified, will show additional added/updated items for this author ID
("you"), e.g. what distributions recently added dependency to one of your
modules.

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

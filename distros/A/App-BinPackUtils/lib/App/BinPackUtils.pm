package App::BinPackUtils;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2020-05-30'; # DATE
our $DIST = 'App-BinPackUtils'; # DIST
our $VERSION = '0.007'; # VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

use IPC::System::Options 'readpipe', -log=>1;

our %SPEC;

my %arg_bin_size = (
    bin_size => {
        schema => ['filesize*'],
        req => 1,
        cmdline_aliases => {s=>{}},
    },
);

my %argopt_bin_size = (
    bin_size => {
        schema => ['filesize*'],
        cmdline_aliases => {s=>{}},
    },
);

my %argopt_bin_max_items = (
    bin_max_items => {
        schema => ['posint*'],
        cmdline_aliases => {i=>{}},
    },
);

my %argopt_num_bins = (
    num_bins => {
        summary => 'Just return the number of bins required',
        schema => 'true*',
        cmdline_aliases => {n=>{}},
    },
);

my %argopt_num_dvds = (
    num_dvds => {
        summary => 'Just return the number of DVDs required',
        schema => 'true*',
        cmdline_aliases => {n=>{}},
    },
);

my %argopt_dvd_size = (
    dvd_size => {
        schema => ['filesize*'],
        default => 4470*1024*1024,
        cmdline_aliases => {s=>{}},
    },
);

my %arg0_files = (
    files => {
        schema => ['array*', of=>'filename*', min_len=>1],
        req => 1,
        pos => 0,
        greedy => 1,
    },
);

my %argopt_dereference_files = (
    dereference_files => {
        summary => 'Just like -D option in du, to derefence the filenames only',
        schema => 'bool*',
        cmdline_aliases => {D=>{}},
    },
);

my %argopt_move = (
    move => {
        summary => 'Actually move the files to the bins',
        schema => 'bool*',
    },
);

$SPEC{pack_bins} = {
    v => 1.1,
    summary => 'Pack items into bin, based on bin size',
    args => {
        %arg_bin_size,
        items => {
            schema => ['array*', of=>'str*'],
            summary => 'The items to be binned',
            description => <<'_',

Each item should be in this format: "label,size" (or an array with two elements,
the first one is the label and the second its size).

_
            req => 1,
            pos => 0,
            greedy => 1,
            cmdline_src => 'stdin_or_args',
        },
        %argopt_num_bins,
    },
    examples => [
        {
            argv => ["-s", 100, "A,10", "B,50", "C,30", "D,70", "E,40", "F,40", "G,25"],
        },
    ],
};
sub pack_bins {
    require Algorithm::BinPack;

    my %args = @_;

    my $bp = Algorithm::BinPack->new(binsize => $args{bin_size});
    for my $item (@{ $args{items} }) {
        if (ref $item eq 'ARRAY') {
            $bp->add_item(label => $item->[0], size => $item->[1]);
        } else {
            my @item = split /\s*,\s*/, $item;
            $bp->add_item(label => $item[0], size => $item[1]);
        }
    }
    my @bins = $bp->pack_bins;
    [200, "OK", $args{num_bins} ? scalar(@bins) : \@bins];
}

$SPEC{bin_files} = {
    v => 1.1,
    summary => 'Put files into bins of certain size (or number of items)',
    args => {
        %argopt_bin_size,
        %argopt_bin_max_items,
        bin_prefix => {
            schema => 'filename*',
            default => 'bin',
        },
        %arg0_files,
        %argopt_dereference_files,
        %argopt_move,
        %argopt_num_bins,
    },
    args_rels => {
        req_one => [qw/bin_size bin_max_items/],
    },
    deps => {
        prog => 'du',
    },
    examples => [
        {
            summary => 'Put at most 100MB in each bin, move the files',
            src => 'bin-files --bin-size 100MB --move *.jpg',
            src_plang => 'bash',
            test => 0,
            'x.doc.show_result' => 0,
        },
        {
            summary => 'Put at most 1000 files in each bin, move the files',
            src => 'bin-files --bin-max-items 1000 --move *.jpg',
            src_plang => 'bash',
            test => 0,
            'x.doc.show_result' => 0,
        },
    ],
};
sub bin_files {
    require String::ShellQuote;

    my %args = @_;
    my $bin_size = $args{bin_size};
    my $bin_max_items = $args{bin_max_items};
    my $bin_prefix = $args{bin_prefix} // "bin";

    my @items;
    for my $file (@{ $args{files} }) {
        return [404, "File '$file' does not exist"] unless -e $file;

        if (defined $bin_size) {
            my $cmd = "du ".($args{dereference_files} ? "-D " : "")."--apparent-size -sb ".
                String::ShellQuote::shell_quote($file);
            my $out = `$cmd`;
            my $size;
            if ($out =~ /\A(\d+)/) {
                $size = $1;
            } else {
                return [500, "Cannot find the size of '$file': $!"];
            }
            push @items, [$file, $size];
        } else {
            push @items, [$file, 1];
        }
    }

    my $res = pack_bins(bin_size => $bin_size // $bin_max_items, items => \@items);
    return $res unless $res->[0] == 200;

    # reformat as a single 2D table
    my @rows;
    my $bin_num = 0;
    my %bin_names;
    for my $bin (@{ $res->[2] }) {
        $bin_num++;
        for my $item (@{ $bin->{items} }) {
            my $bin_name = "$bin_prefix$bin_num";
            $bin_names{$bin_name}++;
            push @rows, {
                bin => $bin_name,
                file=>$item->{label},
                size=>$item->{size},
            };
        }
    }

    if ($args{move}) {
        # create all the directories for bins
        for my $bin_name (sort keys %bin_names) {
            return [412, "Directory $bin_name must not already exist"]
                if -d $bin_name;
            log_info "Creating directory $bin_name ...";
            mkdir $bin_name or return [500, "Can't create directory $bin_name: $!"];
        }
        # move files to bins
        for my $row (@rows) {
            log_info "Moving '$row->{file}' to $row->{bin} ...";
            rename($row->{file}, "$row->{bin}/$row->{file}") or do {
                log_warn "Can't move '$row->{file}' to $row->{bin}/: $!, skipped";
            };
        }
    }

    [200, "OK", $args{num_bins} ? scalar(keys %bin_names) : \@rows];
}

$SPEC{bin_files_into_dvds} = {
    v => 1.1,
    summary => 'Put files into DVD bins',
    args => {
        %arg0_files,
        %argopt_dereference_files,
        %argopt_move,
        %argopt_dvd_size,
        %argopt_num_dvds,
    },
};
sub bin_files_into_dvds {
    my %args = @_;

    bin_files(
        files      => $args{files},
        dereference_files => $args{dereference_files},
        move       => $args{move},
        bin_prefix => "dvd",
        bin_size   => $args{dvd_size} // 4493*1024*1024,
        num_bins   => $args{num_dvds},
    );
}

$SPEC{count_number_of_dvds_required} = {
    v => 1.1,
    summary => 'Count the number of DVDs required to contain the files',
    description => <<'_',

This:

    % count-number-of-dvds-requires *

is a shortcut for:

    % bin-files-into-dvds -n *

_
    args => {
        %arg0_files,
        %argopt_dereference_files,
        %argopt_move,
        %argopt_dvd_size,
    },
};
sub count_number_of_dvds_required {
    my %args = @_;

    bin_files_into_dvds(
        %args,
        num_dvds => 1,
    );
}

1;
# ABSTRACT: Collection of CLI utilities related to packing items into bins

__END__

=pod

=encoding UTF-8

=head1 NAME

App::BinPackUtils - Collection of CLI utilities related to packing items into bins

=head1 VERSION

This document describes version 0.007 of App::BinPackUtils (from Perl distribution App-BinPackUtils), released on 2020-05-30.

=head1 DESCRIPTION

This distribution provides the following command-line utilities:

=over

=item * L<bin-files>

=item * L<bin-files-into-dvds>

=item * L<count-number-of-dvds-required>

=item * L<pack-bins>

=back

Keywords: binpack, bin pack, packbin, pack bins, packing, binning, dvd planning,
files packing.

=head1 FUNCTIONS


=head2 bin_files

Usage:

 bin_files(%args) -> [status, msg, payload, meta]

Put files into bins of certain size (or number of items).

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<bin_max_items> => I<posint>

=item * B<bin_prefix> => I<filename> (default: "bin")

=item * B<bin_size> => I<filesize>

=item * B<dereference_files> => I<bool>

Just like -D option in du, to derefence the filenames only.

=item * B<files>* => I<array[filename]>

=item * B<move> => I<bool>

Actually move the files to the bins.

=item * B<num_bins> => I<true>

Just return the number of bins required.


=back

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (payload) is optional, the actual result. Fourth
element (meta) is called result metadata and is optional, a hash
that contains extra information.

Return value:  (any)



=head2 bin_files_into_dvds

Usage:

 bin_files_into_dvds(%args) -> [status, msg, payload, meta]

Put files into DVD bins.

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<dereference_files> => I<bool>

Just like -D option in du, to derefence the filenames only.

=item * B<dvd_size> => I<filesize> (default: 4687134720)

=item * B<files>* => I<array[filename]>

=item * B<move> => I<bool>

Actually move the files to the bins.

=item * B<num_dvds> => I<true>

Just return the number of DVDs required.


=back

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (payload) is optional, the actual result. Fourth
element (meta) is called result metadata and is optional, a hash
that contains extra information.

Return value:  (any)



=head2 count_number_of_dvds_required

Usage:

 count_number_of_dvds_required(%args) -> [status, msg, payload, meta]

Count the number of DVDs required to contain the files.

This:

 % count-number-of-dvds-requires *

is a shortcut for:

 % bin-files-into-dvds -n *

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<dereference_files> => I<bool>

Just like -D option in du, to derefence the filenames only.

=item * B<dvd_size> => I<filesize> (default: 4687134720)

=item * B<files>* => I<array[filename]>

=item * B<move> => I<bool>

Actually move the files to the bins.


=back

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (payload) is optional, the actual result. Fourth
element (meta) is called result metadata and is optional, a hash
that contains extra information.

Return value:  (any)



=head2 pack_bins

Usage:

 pack_bins(%args) -> [status, msg, payload, meta]

Pack items into bin, based on bin size.

Examples:

=over

=item * Example #1:

 pack_bins(
     items => ["A,10", "B,50", "C,30", "D,70", "E,40", "F,40", "G,25"],
   bin_size => 100
 );

Result:

 [
   {
     items => [{ label => "D", size => 70 }, { label => "C", size => 30 }],
     size  => 100,
   },
   {
     items => [
                { label => "B", size => 50 },
                { label => "E", size => 40 },
                { label => "A", size => 10 },
              ],
     size  => 100,
   },
   {
     items => [{ label => "F", size => 40 }, { label => "G", size => 25 }],
     size  => 65,
   },
 ]

=back

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<bin_size>* => I<filesize>

=item * B<items>* => I<array[str]>

The items to be binned.

Each item should be in this format: "label,size" (or an array with two elements,
the first one is the label and the second its size).

=item * B<num_bins> => I<true>

Just return the number of bins required.


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

Please visit the project's homepage at L<https://metacpan.org/release/App-BinPackUtils>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-BinPackUtils>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-BinPackUtils>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Algorithm::BinPack>

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020, 2019 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

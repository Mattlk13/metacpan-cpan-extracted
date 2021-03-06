package Acme::CPANModules::BloomFilters;

our $DATE = '2018-05-12'; # DATE
our $VERSION = '0.001'; # VERSION

our $LIST = {
    summary => "Bloom filter modules on CPAN",
    description => <<'_',

My default, go-to choice is L<Algorithm::BloomFilter>, unless there's a specific
feature I need from other implementations.

_
    entries => [
        {
            module => 'Bloom::Filter',
            description => <<'_',

Does not provide mehods to save/load to/from strings/files, although you can
just take a peek at the source code or the hash object and get the filter there.
Performance might not be stellar since it's pure-Perl.

_
            tags => ['category:implementation'],
        },
        {
            module => 'Bloom16',
            description => <<'_',

An Inline::C module. Barely documented. Also does not provide filter
saving/loading methods.

_
            tags => ['category:implementation'],
        },
        {
            module => 'Algorithm::BloomFilter',
            description => <<'_',

XS, made by SMUELLER. Can merge other bloom filters. Provides serialize and
deserialize methods.

_
            tags => ['category:implementation'],
        },
        {
            module => 'Bloom::Scalable',
            description => <<'_',

Pure-perl module. A little weird, IMO, e.g. with hardcoded filenames. The
distribution also provides <pm:Bloom::Simple>.

_
            tags => ['category:implementation'],
        },
        {
            module => 'Bloom::Simple',
            description => <<'_',

Pure-perl module. A little weird, IMO, e.g. with hardcoded filenames.
The distribution also provides <pm:Bloom::Simple>.

_
            tags => ['category:implementation'],
        },
        {
            module => 'Bloom::Faster',
            description => <<'_',

XS module. Serialize/deserialize directly to/from files, no string
(de)serialization provided.

_
        },
        {
            module => 'Text::Bloom',
            description => <<'_',

Pure-Perl module, part of Text-Document distribution. Uses <pm:Bit::Vector>.

_
        },
        {
            module => 'App::BloomUtils',
        },
        {
            module => 'Bencher::Scenarios::BloomFilters',
        },
    ],
};

1;
# ABSTRACT: Bloom filter modules on CPAN

__END__

=pod

=encoding UTF-8

=head1 NAME

Acme::CPANModules::BloomFilters - Bloom filter modules on CPAN

=head1 VERSION

This document describes version 0.001 of Acme::CPANModules::BloomFilters (from Perl distribution Acme-CPANModules-BloomFilters), released on 2018-05-12.

=head1 DESCRIPTION

Bloom filter modules on CPAN.

My default, go-to choice is L<Algorithm::BloomFilter>, unless there's a specific
feature I need from other implementations.

=head1 INCLUDED MODULES

=over

=item * L<Bloom::Filter>

Does not provide mehods to save/load to/from strings/files, although you can
just take a peek at the source code or the hash object and get the filter there.
Performance might not be stellar since it's pure-Perl.


=item * L<Bloom16>

An Inline::C module. Barely documented. Also does not provide filter
saving/loading methods.


=item * L<Algorithm::BloomFilter>

XS, made by SMUELLER. Can merge other bloom filters. Provides serialize and
deserialize methods.


=item * L<Bloom::Scalable>

Pure-perl module. A little weird, IMO, e.g. with hardcoded filenames. The
distribution also provides L<Bloom::Simple>.


=item * L<Bloom::Simple>

Pure-perl module. A little weird, IMO, e.g. with hardcoded filenames.
The distribution also provides L<Bloom::Simple>.


=item * L<Bloom::Faster>

XS module. Serialize/deserialize directly to/from files, no string
(de)serialization provided.


=item * L<Text::Bloom>

Pure-Perl module, part of Text-Document distribution. Uses L<Bit::Vector>.


=item * L<App::BloomUtils>

=item * L<Bencher::Scenarios::BloomFilters>

=back

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Acme-CPANModules-BloomFilters>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Acme-CPANModules-BloomFilters>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Acme-CPANModules-BloomFilters>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Acme::CPANModules> - about the Acme::CPANModules namespace

L<cpanmodules> - CLI tool to let you browse/view the lists

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

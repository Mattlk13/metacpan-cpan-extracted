package Finance::Robinhood::Market;
use 5.010;
use Carp;
our $VERSION = "0.19";
use Moo;
use strictures 2;
use namespace::clean;
use Finance::Robinhood::Market::Hours;
#
sub BUILDARGS {
    my $class = shift;
    return
          @_ > 1              ? {@_}
        : ref $_[0] eq 'HASH' ? %{+shift}
        :                       {mic => shift};
}
has $_ => (
    is => 'lazy',
    ,
    predicate => 1,
    builder   => sub {
        (caller(1))[3] =~ m[.+::(.+)$];
        shift->_get_raw->{$1};
    }
) for (qw[mic acronym city country name operating_mic timezone website]);
has $_ => (is => 'bare', lazy => 1, accessor => "_get_$_")
    for (qw[todays_hours]);
has $_ => (is => 'lazy', predicate => 1, reader => "_get_$_") for (qw[url]);
has $_ => (is => 'lazy', reader => "_get_$_") for (qw[raw]);

sub _build_url {
    shift->_get_raw()->{url};
}

sub _build_raw {
    my $s = shift;
    my $url;
    if ($s->has_url) {
        $url = $s->_get_url;
    }
    elsif ($s->has_mic) {
        $url = Finance::Robinhood::endpoint('markets') . $s->mic . '/';
    }
    else {
        return {}    # We done messed up!
    }
    my ($status, $result, $raw)
        = Finance::Robinhood::_send_request(undef, 'GET', $url);
    return $result;
}

sub todays_hours {
    my $now;
    if ($Time::Piece::VERSION) {    # Cleaner
        $now = scalar localtime;
    }
    else {
        require DateTime;           # Core
        $now = DateTime->now;
    }
    my $data = Finance::Robinhood::_send_request(undef, 'GET',
                              $_[0]->_get_url() . 'hours/' . $now->ymd . '/');
    return $data ? Finance::Robinhood::Market::Hours->new($data) : ();
}
1;

=encoding utf-8

=head1 NAME

Finance::Robinhood::Market - Information Related to a Specific Exchange

=head1 SYNOPSIS

    use Finance::Robinhood::Market;

    my $NYSE = Finance::Robinhood::Market->new('XNYS');

    my $MC = Finance::Robinhood::instrument('AAPL');
    my $market = $MC->market();
    print $market->acronym() . ' is based in ' . $market->city();

=head1 DESCRIPTION

This class represents a single financial market. Objects are usually
created by Finance::Robinhood. If you're looking for information about the
market where a particular security is traded, use
C<Finance::Robinhood::instrument($symbol)-E<gt>market()>. To gather a list
of all supported markets, use C<Finance::Robinhood-E<gt>markets()>.

=head1 METHODS

This class has several getters and a few methods as follows...

=head2 C<new( ... )>

Create a new object for the given market. Use the ISO 10383 Market Identifier
Code. For example...

    my $NASDAQ = Finance::Robinhood::Market->new('XNAS');

...would scrape the API and return an object related to the NASDAQ. Currently
supported MICs are:

    OTCM    Otc Markets
    XASE    NYSE Mkt Llc
    ARCX    NYSE Arca
    XNYS    New York Stock Exchange, Inc.
    XNAS    NASDAQ - All Markets
    BATS    BATS Exchange

=head2 C<acronym( )>

The common acronym used for this particular market or exchange.

=head2 C<city( )>

The city this particular market is based in.

=head2 C<country( )>

The country this particular market is based in.

=head2 C<mic( )>

Market Identifier Code (MIC) used to identify this exchange or market.

See ISO 10383.

=head2 C<name( )>

The common name of the market.

=head2 C<operating_mic( )>

Identifies the entity operating the exchange.

=head2 C<timezone( )>

The time zone this market operates in.

=head2 C<website( )>

Returns the URL for this market's website.

=head2 C<todays_hours( )>

Generates a L<Finance::Robinhood::Market::Hours> object for the current day's
operating hours for this particular market.

=head1 LEGAL

This is a simple wrapper around the API used in the official apps. The author
provides no investment, legal, or tax advice and is not responsible for any
damages incurred while using this software. Neither this software nor its
author are affiliated with Robinhood Financial LLC in any way.

For Robinhood's terms and disclosures, please see their website at http://robinhood.com/

=head1 LICENSE

Copyright (C) Sanko Robinson.

This library is free software; you can redistribute it and/or modify
it under the terms found in the Artistic License 2.

Other copyrights, terms, and conditions may apply to data transmitted through
this module. Please refer to the L<LEGAL> section.

=head1 AUTHOR

Sanko Robinson E<lt>sanko@cpan.orgE<gt>

=cut

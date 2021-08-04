package Bot::IRC::Convert;
# ABSTRACT: Bot::IRC convert units of amounts

use 5.014;
use exact -noutf8;

use Math::Units 'convert';

our $VERSION = '1.36'; # VERSION

sub init {
    my ($bot) = @_;

    $bot->hook(
        {
            command => 'PRIVMSG',
            text    => qr/^(?<amount>[\d,\.]+)\s+(?<in_unit>\S+)\s+(?:in|as|to|into)\s+(?<out_unit>\S+)/,
        },
        sub {
            my ( $bot, $in, $m ) = @_;

            ( my $amount = $m->{amount} ) =~ s/,//g;
            my $value;
            eval { $value = convert( $amount, $m->{in_unit}, $m->{out_unit} ) };

            $bot->reply("$m->{amount} $m->{in_unit} is $value $m->{out_unit}") if ($value);
        },
    );

    $bot->helps( convert => 'Convert units of value. Usage: <amount> <input unit> as <output unit>.' );
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bot::IRC::Convert - Bot::IRC convert units of amounts

=head1 VERSION

version 1.36

=head1 SYNOPSIS

    use Bot::IRC;

    Bot::IRC->new(
        connect => { server => 'irc.perl.org' },
        plugins => ['Convert'],
    )->run;

=head1 DESCRIPTION

This L<Bot::IRC> plugin allows the bot to convert various values of units.
Unit types must match, which is to say you can't convert length to volume.

=head2 SEE ALSO

L<Bot::IRC>

=for Pod::Coverage init

=head1 AUTHOR

Gryphon Shafer <gryphon@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2016-2021 by Gryphon Shafer.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

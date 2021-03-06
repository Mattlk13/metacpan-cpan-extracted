package GrowthForecast::Aggregator::DB;
use strict;
use warnings;
use utf8;
use Encode qw(encode_utf8);
use HTTP::Request::Common;

use Mouse;

has name => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has description => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has section => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

has query => (
    is => 'rw',
    isa => 'Str',
    required => 1,
);

has binds => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { +[ ] },
);

no Mouse;

sub run {
    my $self = shift;
    my %args = @_;

    my $dbh      = $args{dbh}      // die "Missing mandatory parameter: dbh";
    my $service  = $args{service}  // die "Missing mandatory parameter: service";
    my $endpoint = $args{endpoint} // die "Missing mandatory parameter: endpoint";
    my $ua       = $args{ua}       // die "Missing mandatory parameter: ua";

    $endpoint =~ s!/$!!;

    my $url = "$endpoint/$service/$self->{section}/$self->{name}";

    my $sth = $dbh->prepare($self->query);
    $sth->execute(@{$self->binds});
    my ($number) = $sth->fetchrow_array();
    my $req = POST $url, [
        number => $number,
        description => encode_utf8($self->description),
    ];
    my $res = $ua->request($req);
    return $res;
}

1;
__END__

=head1 NAME

GrwothForecast::Aggregator::DB - Aggregate from RDBMS

=head1 SYNOPSIS

    my $aggregator = GrowthForecast::Aggregator::DB->new(
        service => 'blog',
        section => 'entry',
        name    => 'count',
        query   => q{SELECT COUNT(*) FROM entry WHERE status=?},
        binds   => [1],
    );
    my $res = $aggregator->run();

=head1 DESCRIPTION

This aggregator aggregates data from RDBMS, and post it to GrowthForecast.

=head1 CONSTRUCTOR ARGUMENTS

=over 4

=item section: Str, required

Section name.

This module send request to "/api/$service/$section/$name"

=item name : Str, required

Name of the metrics.

This module send request to "/api/$service/$section/$name"

=item description: Str, required

Description of the query. The module post it as 'description' parameter.

=item query: Str, required

This is a SQL query, to execute.

=item binds: ArrayRef, optional

Bind parameters for the query.

=back

=head1 ARGUMENTS FOR 'run' METHOD

=over 4

=item dbh

Data source database handle.

=item service

Service name.

This module send request to "/api/$service/$section/$name"

=item endpoint

Endpoint URL, contains '/api'.

E.g. http://example.com/api/

=item ua

Instance of HTTP client. I tested on L<Furl>.

=back


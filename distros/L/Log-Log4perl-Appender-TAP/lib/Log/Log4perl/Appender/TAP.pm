package Log::Log4perl::Appender::TAP;

use strict;
use warnings;
use 5.008001;
use Test2::API qw( context );
our @ISA = qw( Log::Log4perl::Appender );

# ABSTRACT: Append to TAP output
our $VERSION = '0.04'; # VERSION


sub new
{
  my $proto = shift;
  my $class = ref $proto || $proto;
  my %args = @_;
  bless {
    method  => $args{method} || 'note',
  }, $class;
}

sub log
{
  my $self = shift;
  my %args = @_;
  my $method = $self->{method};
  my $ctx = context();
  $ctx->$method($args{message});
  $ctx->release;
  return;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Log::Log4perl::Appender::TAP - Append to TAP output

=head1 VERSION

version 0.04

=head1 SYNOPSIS

 use Test2::V0;
 use Log::Log4perl;
 
 LOG::Log4perl::init(\<<CONF);
 log4perl.rootLogger=ERROR, TAP
 log4perl.appender.TAP=Log::Log4perl::Appender::TAP
 log4perl.appender.TAP.method=diag
 log4perl.appender.TAP=layout=PatternLayout
 log4perl.appender.TAP=layout.ConversionPattern="[%rms] %m%n"
 CONF
 
 DEBUG "this message doesn't see the light of day";
 ERROR "This gets logged to TAP using diag";

=head1 DESCRIPTION

This very simple appender sends log output via L<Test2::API> to TAP
(or any other format supported by L<Test2::API>).  It also works with
L<Test::Builder> and L<Test::More> so long as you have L<Test2::API>
installed.  It only takes one special argument, the method, which can
be either C<diag> or C<note>.

=head1 AUTHOR

Graham Ollis <plicease@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

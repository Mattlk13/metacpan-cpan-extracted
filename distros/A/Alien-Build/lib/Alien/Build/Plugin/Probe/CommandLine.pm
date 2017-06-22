package Alien::Build::Plugin::Probe::CommandLine;

use strict;
use warnings;
use Alien::Build::Plugin;
use Carp ();
use Capture::Tiny qw( capture );

# ABSTRACT: Probe for tools or commands already available
our $VERSION = '0.45'; # VERSION


has '+command' => sub { Carp::croak "@{[ __PACKAGE__ ]} requires command property" };


has 'args'       => [];


has 'secondary' => 0;


has 'match'     => undef;


has 'version'   => undef;

sub init
{
  my($self, $meta) = @_;
  
  # in core as of 5.10, but still need it for 5.8
  # apparently.
  $meta->add_requires( 'configure' => 'IPC::Cmd' => 0 );
  
  my $check = sub {
    my($build) = @_;

    unless(IPC::Cmd::can_run($self->command))
    {
      die 'Command not found ' . $self->command;
    }

    if(defined $self->match || defined $self->version)
    {
      my($out,$err,$ret) = capture {
        system( $self->command, @{ $self->args } );
      };
      die 'Command did not return a true value' if $ret;
      die 'Command output did not match' if defined $self->match && $out !~ $self->match;
      if(defined $self->version)
      {
        if($out =~ $self->version)
        {
          $build->runtime_prop->{version} = $1;
        }
      }
    }

    $build->runtime_prop->{command} = $self->command;
    'system';
  };
  
  if($self->secondary)
  {
    $meta->around_hook(
      probe => sub {
        my $orig = shift;
        my $build = shift;
        my $type = $orig->($build, @_);
        return $type unless $type eq 'system';
        $check->($build);
      },
    );
  }
  else
  {
    $meta->register_hook(
      probe => $check,
    );
  }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Alien::Build::Plugin::Probe::CommandLine - Probe for tools or commands already available

=head1 VERSION

version 0.45

=head1 SYNOPSIS

 use alienfile;
 plugin 'Probe::CommandLine' => (
   command => 'gzip',
   args    => [ '--version' ],
   match   => qr/gzip/,
   version => qr/gzip ([0-9\.]+)/,
 );

=head1 DESCRIPTION

This plugin probes for the existence of the given command line program.

=head1 PROPERTIES

=head2 command

The name of the command.

=head2 args

The arguments to pass to the command.

=head2 secondary

If you are using another probe plugin (such as L<Alien::Build::Plugin::Probe::CBuilder> or 
L<Alien::Build::Plugin::PkgConfig::Negotiate>) to detect the existence of a library, but
also need a program to exist, then you should set secondary to a true value.  For example
when you need both:

 use alienfile;
 # requires both liblzma library and xz program
 plugin 'PkgConfig' => 'liblzma';
 plugin 'Probe::CommandLine => (
   command   => 'xz',
   secondary => 1,
 );

When you don't:

 use alienfile;
 plugin 'Probe::CommandLine' => (
   command   => 'gzip',
   secondary => 0, # default
 );

=head2 match

Regular expression for which the program output should match.

=head2 version

Regular expression to parse out the version from the program output.
The regular expression should store the version number in C<$1>.

=head1 SEE ALSO

L<Alien::Build>, L<alienfile>, L<Alien::Build::MM>, L<Alien>

=head1 AUTHOR

Author: Graham Ollis E<lt>plicease@cpan.orgE<gt>

Contributors:

Diab Jerius (DJERIUS)

Roy Storey

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

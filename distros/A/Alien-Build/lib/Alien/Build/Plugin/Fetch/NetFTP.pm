package Alien::Build::Plugin::Fetch::NetFTP;

use strict;
use warnings;
use Alien::Build::Plugin;
use Carp ();
use File::Temp ();
use Path::Tiny qw( path );

# ABSTRACT: Net::FTP plugin for fetching files
our $VERSION = '0.55'; # VERSION


has '+url' => sub { Carp::croak "url is a required property" };


has ssl => 0;

sub init
{
  my($self, $meta) = @_;

  $meta->add_requires('share' => 'Net::FTP' => 0 );
  $meta->add_requires('share' => 'URI' => 0 );
  $meta->register_hook( fetch => sub {
    my(undef, $url) = @_;
    $url ||= $self->url;
    
    $url = URI->new($url);
    
    my $ftp = eval {
      _ftp_connect($url);
    };
    die $@ unless defined $ftp;

    my $path = $url->path;

    unless($path =~ m!/$!)
    {
      my(@parts) = split '/', $path;
      my $filename = pop @parts;
      my $dir      = join '/', @parts;
      
      my $path = eval {
        $ftp->cwd($dir) or die;
        my $tdir = File::Temp::tempdir( CLEANUP => 1);
        my $path = path("$tdir/$filename")->stringify;
        
        unless($ftp->get($filename, $path)) # NAT problem? try to use passive mode
        {
          $ftp->quit;
          
          $ftp = eval {
            _ftp_connect($url, 1);
          };
          die $@ unless defined $ftp;
          
          $ftp->cwd($dir) or die;
          
          $ftp->get($filename, $path) or die;
        }
        
        $path;
      };
      
      if(defined $path)
      {
        return {
          type     => 'file',
          filename => $filename,
          path     => $path,
        };
      }
      
      $path .= "/";
    }
    
    $ftp->cwd($path) or die "unable to fetch $url as either a directory or file";
    
    my $list = $ftp->ls;
    if(!defined($list)) # NAT problem? try to use passive mode
    {
      $ftp->quit;
      
      $ftp = eval {
        _ftp_connect($url, 1);
      };
      die $@ unless defined $ftp;
      
      $ftp->cwd($path) or die "unable to fetch $url as either a directory or file";
      
      $list = $ftp->ls;
      
      die "cannot list directory $path on $url" unless defined $list;
    }
    
    die "no files found at $url" unless @$list;

    $path .= '/' unless $path =~ /\/$/;
    
    return {
      type => 'list',
      list => [
        map {
          my $filename = $_;
          my $furl = $url->clone;
          $furl->path($path . $filename);
          my %h = (
            filename => $filename,
            url      => $furl->as_string,
          );
          \%h;
        } sort @$list,
      ],
    };
    
  });

  $self;
}

sub _ftp_connect {
  my $url = shift;
  my $is_passive = shift || 0;
  
  my $ftp = Net::FTP->new(
    $url->host, Port =>$url->port, Passive =>$is_passive,
  ) or die "error fetching $url: $@";
  
  $ftp->login($url->user, $url->password)
    or die "error on login $url: @{[ $ftp->message ]}";
  
  $ftp->binary;
  
  $ftp;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Alien::Build::Plugin::Fetch::NetFTP - Net::FTP plugin for fetching files

=head1 VERSION

version 0.55

=head1 SYNOPSIS

 use alienfile;
 plugin 'Fetch::NetFTP' => (
   url => 'ftp://ftp.gnu.org/gnu/make',
 );

=head1 DESCRIPTION

Note: in most case you will want to use L<Alien::Build::Plugin::Download::Negotiate>
instead.  It picks the appropriate fetch plugin based on your platform and environment.
In some cases you may need to use this plugin directly instead.

This fetch plugin fetches files and directory listings via the C<ftp>, protocol using
L<Net::FTP>.

=head1 PROPERTIES

=head2 url

The initial URL to fetch.  This may be a directory or the final file.

=head2 ssl

This property is for compatibility with other fetch plugins, but is not used.

=head1 SEE ALSO

L<Alien::Build::Plugin::Download::Negotiate>, L<Alien::Build>, L<alienfile>, L<Alien::Build::MM>, L<Alien>

=head1 AUTHOR

Author: Graham Ollis E<lt>plicease@cpan.orgE<gt>

Contributors:

Diab Jerius (DJERIUS)

Roy Storey

Ilya Pavlov

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

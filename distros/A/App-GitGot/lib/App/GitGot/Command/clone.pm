package App::GitGot::Command::clone;
our $AUTHORITY = 'cpan:GENEHACK';
$App::GitGot::Command::clone::VERSION = '1.339';
# ABSTRACT: clone a remote repo and add it to your config
use 5.014;

use Cwd;
use Path::Tiny;
use IO::Prompt::Simple;
use Types::Standard -types;

use App::GitGot -command;
use App::GitGot::Repo::Git;

use Moo;
extends 'App::GitGot::Command';
use namespace::autoclean;

sub options {
  my( $class , $app ) = @_;
  return (
    [ 'defaults|D'  => 'use the default choices for all prompts' ] ,
    [ 'recursive|r' => 'clone submodules recursively' => { default => 0 } ],
  );
}

sub _use_io_page { 0 }

sub _execute {
  my ( $self, $opt, $args ) = @_;

  my ( $repo , $path ) = @$args;

  $repo // ( say STDERR 'ERROR: Need the URL to clone!' and exit(1) );

  my $cwd = getcwd
    or( say STDERR "ERROR: Couldn't determine path" and exit(1) );

  my $name = path( $repo )->basename;
  $name =~ s/.git$//;

  $path //= "$cwd/$name";
  $path = path( $path )->absolute;

  my $tags;

  unless ( $self->opt->defaults ) {
    $name = prompt( 'Name: ' , $name );
    while() {
        $path = prompt( 'Path: ' , $path );
        last if not path($path)->exists;
        say "can't clone into '$path': directory already exists";
    }
    $tags = prompt( 'Tags: ' , $tags );
  }

  my $new_entry = App::GitGot::Repo::Git->new({ entry => {
    repo => $repo,
    name => $name,
    type => 'git',
    path => $path,
  }});
  $new_entry->{tags} = $tags if $tags;

  say "Cloning into '$path'..." unless $self->quiet;
  $new_entry->clone(
    { recursive => $self->opt->recursive },
    $repo , $path
  );

  $self->add_repo( $new_entry );
  $self->write_config;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

App::GitGot::Command::clone - clone a remote repo and add it to your config

=head1 VERSION

version 1.339

=head1 SYNOPSIS

    # clone repository and add to got config
    $ got clone <git repo url>
    # prompts for name, path, tags, etc.

    # clone repository and add to got config
    # using defaults for all prompts
    $ got clone -D <git repo url>

    # recursively clone the submodules as well
    $ got clone -r <git repo url>

=head1 AUTHOR

John SJ Anderson <john@genehack.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020 by John SJ Anderson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

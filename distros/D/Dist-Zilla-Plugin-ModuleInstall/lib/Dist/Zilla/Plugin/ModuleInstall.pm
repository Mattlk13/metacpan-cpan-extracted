use 5.006;    # our
use strict;
use warnings;

package Dist::Zilla::Plugin::ModuleInstall;

our $VERSION = '1.001002';

# ABSTRACT: (DEPRECATED) Build Module::Install based Distributions with Dist::Zilla

our $AUTHORITY = 'cpan:KENTNL'; # AUTHORITY

use Moose qw( has with around );
use Config;
use Carp qw( carp croak );
use Dist::Zilla::Plugin::MakeMaker::Runner;
use Dist::Zilla::File::FromCode;

has 'make_path' => (
  isa     => 'Str',
  is      => 'ro',
  default => $Config{make} || 'make',
);

has '_runner' => (
  is      => 'ro',
  lazy    => 1,
  handles => [qw(build test)],
  default => sub {
    my ($self) = @_;
    Dist::Zilla::Plugin::MakeMaker::Runner->new(
      {
        zilla       => $self->zilla,
        plugin_name => $self->plugin_name . '::Runner',
        make_path   => $self->make_path,
      },
    );
  },
);

with 'Dist::Zilla::Role::BuildRunner';
with 'Dist::Zilla::Role::InstallTool';
with 'Dist::Zilla::Role::TextTemplate';

# no broken tempdir, keepalive_fail helper
use Dist::Zilla::Role::Tempdir 1.001000;
with 'Dist::Zilla::Role::Tempdir';

with 'Dist::Zilla::Role::PrereqSource';
with 'Dist::Zilla::Role::TestRunner';

around dump_config => sub {
  my ( $orig, $self, @args ) = @_;
  my $config = $self->$orig(@args);
  my $payload = $config->{ +__PACKAGE__ } = {};
  $payload->{make_path} = $self->make_path;

  ## no critic (RequireInterpolationOfMetachars)
  $payload->{ q[$] . __PACKAGE__ . q[::VERSION] } = $VERSION unless __PACKAGE__ eq ref $self;
  $payload->{q[$Module::Install::VERSION]} = $Module::Install::VERSION if $INC{'Module/Install.pm'};
  return $config;
};

__PACKAGE__->meta->make_immutable;
no Moose;

use Dist::Zilla::File::InMemory;

use namespace::autoclean;

require inc::Module::Install;

sub _doc_template {
  my ( $self, $args ) = @_;
  my $package = __PACKAGE__;
  my $version = ( __PACKAGE__->VERSION() || 'undefined ( self-build? )' );

  my $t = <<"EOF";
use strict;
use warnings;
use lib './'; # Required for -Ddefault_inc_excludes_dot
# Warning: This code was generated by ${package} Version ${version}
# As part of Dist::Zilla's build generation.
# Do not modify this file, instead, modify the dist.ini that configures its generation.
use inc::Module::Install {{ \$miver }};
{{ \$headings }}
{{ \$requires }}
{{ \$feet }}
WriteAll();
EOF
  return $self->fill_in_string( $t, $args );
}

sub _label_value_template {
  my ( $self, $args ) = @_;
  my $t = <<"EOF";
{{ \$label }} '{{ \$value }}';
EOF
  return $self->fill_in_string( $t, $args );
}

sub _label_string_template {
  my ( $self, $args ) = @_;
  my $t = <<"EOF";
{{ \$label }} "{{ quotemeta( \$string ) }}";
EOF
  return $self->fill_in_string( $t, $args );
}

sub _label_string_string_template {
  my ( $self, $args ) = @_;
  my $t = <<"EOF";
{{ \$label }}  "{{ quotemeta(\$stringa) }}" => "{{ quotemeta(\$stringb) }}";
EOF
  return $self->fill_in_string( $t, $args );
}

sub _generate_makefile_pl {
  my ($self) = @_;
  my ( @headings, @requires, @feet );

  push @headings, _label_value_template( $self, { label => 'name', value => $self->zilla->name } ),
    _label_string_template( $self, { label => 'abstract', string => $self->zilla->abstract } ),
    _label_string_template( $self, { label => 'author',   string => $self->zilla->authors->[0] } ),
    _label_string_template( $self, { label => 'version',  string => $self->zilla->version } ),
    _label_string_template( $self, { label => 'license',  string => $self->zilla->license->meta_yml_name } );

  my $prereqs = $self->zilla->prereqs;

  my $doreq = sub {
    my ( $key, $target ) = @_;
    push @requires, qq{\n# @$key => $target};
    my $hash = $prereqs->requirements_for( @{$key} )->as_string_hash;
    for ( sort keys %{$hash} ) {
      if ( 'perl' eq $_ ) {
        push @requires, _label_string_template( $self, { label => 'perl_version', string => $hash->{$_} } );
        next;
      }
      push @requires,
        $self->_label_string_string_template(
        {
          label   => $target,
          stringa => $_,
          stringb => $hash->{$_},
        },
        );
    }
  };

  $doreq->( [qw(configure requires)],   'configure_requires' );
  $doreq->( [qw(build     requires)],   'requires' );
  $doreq->( [qw(runtime   requires)],   'requires' );
  $doreq->( [qw(runtime   recommends)], 'recommends' );
  $doreq->( [qw(test      requires)],   'test_requires' );

  push @feet, qq{\n# :ExecFiles};
  my @found_files = @{ $self->zilla->find_files(':ExecFiles') };
  for my $execfile ( map { $_->name } @found_files ) {
    push @feet, _label_string_template( $self, $execfile );
  }
  my $content = _doc_template(
    $self,
    {
      miver    => "$Module::Install::VERSION",
      headings => join( qq{\n}, @headings ),
      requires => join( qq{\n}, @requires ),
      feet     => join( qq{\n}, @feet ),
    },
  );
  return $content;
}







sub register_prereqs {
  my ($self) = @_;
  $self->zilla->register_prereqs( { phase => 'configure' }, 'ExtUtils::MakeMaker' => 6.42 );
  $self->zilla->register_prereqs( { phase => 'build' },     'ExtUtils::MakeMaker' => 6.42 );
  return;
}








my $error_load   = 'Error running Makefile.PL for Module::Install. ';
my $no_keepalive = $error_load . 'Set MI_KEEPALIVE=1 if you want to retain the directory for analysis';
my $keepalive    = $error_load . 'Inspect the temporary directory to determine cause';

sub setup_installer {
  my ( $self, ) = @_;

  my $file = Dist::Zilla::File::FromCode->new( { name => 'Makefile.PL', code => sub { _generate_makefile_pl($self) }, } );

  $self->add_file($file);

  my $code = sub {
    my ($dir) = @_;
    system $^X, 'Makefile.PL' and do {

      croak($no_keepalive) unless $ENV{MI_KEEPALIVE};

      $dir->keepalive_fail($keepalive);
    };
  };

  my (@generated) = $self->capture_tempdir($code);

  for (@generated) {
    if ( $_->is_new ) {
      $self->log( 'ModuleInstall created: ' . $_->name );
      if ( $_->name =~ /\Ainc\/Module\/Install/msx ) {
        $self->log( 'ModuleInstall added  : ' . $_->name );
        $self->add_file( $_->file );
      }
    }
    if ( $_->is_modified ) {
      $self->log( 'ModuleInstall modified: ' . $_->name );
    }
  }
  return;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Plugin::ModuleInstall - (DEPRECATED) Build Module::Install based Distributions with Dist::Zilla

=head1 VERSION

version 1.001002

=head1 SYNOPSIS

dist.ini

    [ModuleInstall]

=head1 DESCRIPTION

This module will create a F<Makefile.PL> for installing the dist using L<< C<Module::Install>|Module::Install >>.

It is at present a very minimal feature set, but it works.

=head1 METHODS

=head2 register_prereqs

Tells Dist::Zilla about our needs to have EU::MM larger than 6.42

=head2 setup_installer

Generates the Makefile.PL, and runs it in a tmpdir, and then harvests the output and stores
it in the dist selectively.

=head1 DEPRECATED

This module is now officially deprecated.

It was never really recommended, or supported, and it always existed as a gap filler for people
who were migrating from Module::Install and had yet to understand certain design elements of C<Dist::Zilla>
made using Module::Install effectively redundant.

In short, it was an excuse, a foot-gun for the person who needed holes in their feet.

I will not actively prevent this module from doing anything it didn't use to do, but its use
should be considered officially discouraged.

=head1 AUTHOR

Kent Fredric <kentnl@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

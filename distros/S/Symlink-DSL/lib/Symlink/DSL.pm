package Symlink::DSL;
$Symlink::DSL::VERSION = '0.4.0';
use 5.014;
use strict;
use warnings;
use autodie;

use Cwd qw/ getcwd /;
use File::Basename qw/ dirname /;
use File::Path qw/ mkpath /;
use File::Spec ();

sub new
{
    my $class = shift;

    my $self = bless {}, $class;

    $self->_init(@_);

    return $self;
}

sub _init
{
    my ( $self, $args ) = @_;
    $self->{dir} = $args->{dir};
    $self->skip_re( $args->{skip_re} );
    $self->manifest_base( $args->{manifest_base}
            // "setup.symlinks.manifest.txt" );

    return;
}

sub manifest_base
{
    my $self = shift;

    if (@_)
    {
        my $val = shift;

        if ( $val !~ /\A[0-9A-Za-z][0-9A-Za-z\-_\.]*\z/ )
        {
            die "Invalid manifest_base basename - invalid chars.";
        }
        $self->{_manifest_base} = $val;
    }

    return $self->{_manifest_base};
}

sub manifest
{
    my $self = shift;

    return File::Spec->catfile( $self->dir, $self->manifest_base );
}

sub skip_re
{
    my $self = shift;

    if (@_)
    {
        $self->{skip_re} = shift;
    }

    return $self->{skip_re};
}

sub dir
{
    my $self = shift;

    if (@_)
    {
        $self->{dir} = shift;
    }

    return $self->{dir};
}

sub handle_line
{
    my ( $self, $args ) = @_;
    my $l = $args->{line};
    my ( $dest, $src );
    unless ( ( $dest, $src ) = $l =~ m#\Asymlink from ~/(\S+) to \./(\S+)\z# )
    {
        die "wrong line <$l> in @{[$self->manifest]} !";
    }
    return $self->process_single_record(
        {
            from => $dest,
            line => $l,
            to   => $src,
        }
    );
}

sub process_single_record
{
    my ( $self, $args ) = @_;

    my $dest = $args->{'from'};
    my $l    = $args->{'line'};
    my $src  = $args->{'to'};

    my $dir     = $self->dir;
    my $skip_re = $self->skip_re;

    foreach my $str ( $src, $dest )
    {
        if ( $str =~ /([^a-zA-Z\-_0-9\.\/])/ )
        {
            die
"unacceptable character $1 in line <$l> in @{[$self->manifest]} !";
        }
        if ( $str =~ m%((?:\.\.)|(?:/\./)|(?:/\.\z)|(?:\A-)|(?:/-))% )
        {
            die
"unacceptable sequence $1 in line <$l> in @{[$self->manifest]} !";
        }
    }

    my $pwd = getcwd();
    chdir($dir);
    my $conf_dir = getcwd();
    my $h        = $ENV{HOME};
    if ( $dest =~ m#/# )
    {
        mkpath( [ "$h/" . dirname($dest) ] );
    }
    my $dd = "$h/$dest";
    my $ss = "$conf_dir/$src";
    print "Linking $dd to $ss\n";
    if ( -e $dd )
    {
        if ( ( !defined $skip_re ) or ( $dd !~ /$skip_re/ ) )
        {
            if ( not -l $dd )
            {
                die "$dd is not a symlink!";
            }
            elsif ( readlink($dd) ne $ss )
            {
                die "$dd does not point to $ss !";
            }
            elsif ( $ENV{V} )
            {
                warn "Not replacing $dd";
            }
        }
    }
    else
    {
        symlink( $ss, $dd );
    }
    chdir $pwd;

    return;
}

sub manifest_exists
{
    my $self = shift;

    return ( -f $self->manifest );
}

sub process_manifest
{
    my $self = shift;

    die "Manifest does not exist" if !$self->manifest_exists;

    open my $fh, "<", $self->manifest;
    while ( my $l = <$fh> )
    {
        chomp $l;
        $self->handle_line( { line => $l } );
    }
    close $fh;
    return 1;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Symlink::DSL - a domain-specific language for setting up symbolic links.

=head1 VERSION

version 0.4.0

=head1 SYNOPSIS

    use Symlink::DSL;

    my $dir = "$ENV{HOME}/conf/trunk/shlomif-settings/home-bin-executables";
    my $skip_re = undef;
    my $processor = Symlink::DSL->new( { dir => $dir, skip_re => $skip_re, } );
    $processor->process_manifest;

And in C<< setup.symlinks.manifest.txt >>:

    symlink from ~/bin/80_chars_ruler to ./bin/80_chars_ruler
    symlink from ~/bin/SPECS-only-for-deps-co to ./bin/SPECS-only-for-deps-co
    symlink from ~/bin/backup-slash.bash to ./bin/backup-slash.bash
    symlink from ~/bin/commify to ./bin/commify
    symlink from ~/bin/desktop-finish-cue to ./bin/desktop-finish-cue
    symlink from ~/bin/git-com to ./bin/git-com
    symlink from ~/bin/git-mkdir to ./bin/git-mkdir
    symlink from ~/bin/git-s to ./bin/git-s
    symlink from ~/bin/mplayer-shuffle to ./bin/mplayer-shuffle
    symlink from ~/bin/sus to ./bin/sus
    symlink from ~/bin/tail-extract to ./bin/tail-extract

=head1 DESCRIPTION

Symlink::DSL implements a domain-specific language for setting up symbolic
links (e.g: to dot files and other resources). For example, one
can write:

    symlink from ~/bin/80_chars_ruler to ./bin/80_chars_ruler
    symlink from ~/bin/backup-slash.bash to ./bin/backup-slash.bash

=head1 METHODS

=head2 Symlink::DSL->new({dir => $path2dir, skip_re=> $regexp})

Returns a new object.

Accepts:

=over 4

=item * dir

The directory path which contains the manifest file.

=item * skip_re

A regular expression that will skip checking existing links.

=item * manifest_base

The basename of the manifest file. Defaults to C<< setup.symlinks.manifest.txt >> . (Added in 0.2.0).

=back

=head2 $obj->dir()

Returns the directory path.

=head2 $obj->handle_line({line => $line_string})

Handles a single line.

=head2 $obj->manifest_base()

Returns the basename of the manifest files. Can be set in new() .

(Added in 0.2.0 .)

=head2 $obj->manifest()

Returns the manifest path.

=head2 $obj->manifest_exists()

Returns whether the manifest exists.

=head2 $obj->process_manifest()

Processes all lines in the manifest file.

=head2 $obj->process_single_record({from=>$dest, line=>$l, to=>$src,})

Processes a single record / a single operation.

( Added in v0.4.0 . )

=head2 $obj->skip_re()

Returns the optional regex to skip dest paths.

=head1 SEE ALSO

L<GNU Stow|https://tomeaton.uk/blog/jekyll/update/2017/10/25/Managing-dotfiles-with-GNU-stow.html> which
seems more limited and is under the GPL.

L<Setup> .

L<Doit> .

=for :stopwords cpan testmatrix url bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

MetaCPAN

A modern, open-source CPAN search engine, useful to view POD in HTML format.

L<https://metacpan.org/release/Symlink-DSL>

=item *

RT: CPAN's Bug Tracker

The RT ( Request Tracker ) website is the default bug/issue tracking system for CPAN.

L<https://rt.cpan.org/Public/Dist/Display.html?Name=Symlink-DSL>

=item *

CPANTS

The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

L<http://cpants.cpanauthors.org/dist/Symlink-DSL>

=item *

CPAN Testers

The CPAN Testers is a network of smoke testers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/S/Symlink-DSL>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

L<http://matrix.cpantesters.org/?dist=Symlink-DSL>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=Symlink::DSL>

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests by email to C<bug-symlink-dsl at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/Public/Bug/Report.html?Queue=Symlink-DSL>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<https://github.com/shlomif/Symlink-DSL>

  git clone https://github.com/shlomif/Symlink-DSL.git

=head1 AUTHOR

Shlomi Fish <shlomif@cpan.org>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/shlomif/symlink-dsl/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2019 by Shlomi Fish.

This is free software, licensed under:

  The MIT (X11) License

=cut

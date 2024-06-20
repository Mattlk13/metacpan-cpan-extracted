package File::Slurper::Temp;

use strict;
use warnings;

use Carp 'croak', 'carp';
use Exporter qw(import);
use File::Slurper ();
use File::Temp ();

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2024-06-17'; # DATE
our $DIST = 'File-Slurper-Temp'; # DIST
our $VERSION = '0.009'; # VERSION

our @EXPORT_OK = qw(
                       write_text write_binary
                       write_text_to_tempfile write_binary_to_tempfile
                       modify_text modify_binary
               );

our $FILE_TEMP_DIR;
our $FILE_TEMP_PERMS;
our $FILE_TEMP_TEMPLATE = "XXXXXXXXXX";

sub _tempfile {
    my $target_filename = shift;

    my @tfargs;

    push @tfargs, $FILE_TEMP_TEMPLATE;

    my $dir = $FILE_TEMP_DIR;
    unless (defined $dir) {
        require File::Basename;
        $dir = File::Basename::dirname($target_filename);
    }
    push @tfargs, DIR => $dir;

    my $perms = $FILE_TEMP_PERMS;
    unless (defined $perms) {
        my @st = lstat($target_filename)
        ;#    or carp "Couldn't lstat($target_filename): $!";
        $perms = $st[2] if @st;
    }
    push @tfargs, PERMS => $perms if $perms;

    File::Temp::tempfile(@tfargs);
}

sub write_text {
    my $filename = shift;

    my ($tempfh, $tempname) = _tempfile($filename);
    File::Slurper::write_text($tempname, @_);
    rename $tempname, $filename
        or croak "Couldn't rename $tempname to $filename: $!";

    return;
}

sub write_binary {
    return write_text(@_[0,1], 'latin-1');
}

sub write_text_to_tempfile {
    my ($tempfh, $tempname) = File::Temp::tempfile();
    File::Slurper::write_text($tempname, @_);
    return $tempname;
}

sub write_binary_to_tempfile {
    return write_text_to_tempfile($_[0], 'latin-1');
}

# BEGIN copied from File::Slurper::Shortcuts, with some mods
sub modify_text {
    my ($filename, $code, $encoding, $crlf) = @_;

    local $_ = File::Slurper::read_text($filename, $encoding, $crlf);
    my $orig = $_;

    my $res = $code->($_);
    croak "replace_text(): Code does not return true" unless $res;

    return if $orig eq $_;

    write_text($filename, $_, $encoding, $crlf);
    $orig;
}

sub modify_binary {
    return modify_text(@_[0,1], 'latin-1');
}
# END copied from File::Slurper::Shortcuts, with some mods

1;
# ABSTRACT: File::Slurper + File::Temp

__END__

=pod

=encoding UTF-8

=head1 NAME

File::Slurper::Temp - File::Slurper + File::Temp

=head1 VERSION

This document describes version 0.009 of File::Slurper::Temp (from Perl distribution File-Slurper-Temp), released on 2024-06-17.

=head1 SYNOPSIS

Use like you would use L<File::Slurper>'s C<write_text> and C<write_binary>:

 use File::Slurper::Temp qw(write_text write_binary);
 write_text("/tmp/foo.txt", "some text");
 write_binary("/tmp/bar", $somedata);

Use C<write_text_to_tempfile> and C<write_binary_to_tempfile>:

 use File::Slurper::Temp qw(write_text_to_tempfile write_binary_to_tempfile);
 my $filename1 = write_text_to_tempfile("some text");
 my $filename2 = write_binary_to_tempfile($somedata);

This module also provides L</modify_text> and L</modify_binary>, like that
provided by L<File::Slurper::Shortcuts>:

 use File::Slurper::Temp qw(write_text_to_tempfile write_binary_to_tempfile);
 modify_text("/path/to/file.txt", sub { s/foo/bar/g });
 modify_binary("/path/to/file.txt", sub { s/foo/bar/g });

=head1 DESCRIPTION

This module is a simple combination of L<File::Slurper> and L<File::Temp>. It
provides its version of L</write_text> and L</write_binary>, as well as a couple
of functions of its own.

This module's version of C<write_text> and C<write_binary> write to temporary
file first using L<File::Temp>'s L<tempfile()|File::Temp/tempfile> before
renaming to the final destination path using Perl's L<rename()|perlfunc/rename>.
If the destination path is originally a symlink, it will be replaced with a
regular file by C<rename()>. This can avoid symlink attack.

In addition the above two functions, this module also provides
L</write_text_to_tempfile> and L</write_binary_to_tempfile>. You don't have to
specify destination path but just content to write, and the functions will
return the temporary filename created.

=head1 VARIABLES

=head2 $FILE_TEMP_DIR

=head2 $FILE_TEMP_PERMS

=head2 $FILE_TEMP_TEMPLATE

=head1 FUNCTIONS

=head2 write_text

Usage:

 write_text($filename, $content [ , $encoding, $crlf ])

Just like the original L<File::Slurper>'s version, except will write to
temporary file created by L<File::Temp>'s C<tempfile> first, then rename the
temporary file using Perl's C<rename()>. The function will croak if C<rename()>
fails.

By default, the temporary file is created in the same directory as C<$filename>,
using C<tempfile()>'s option C<< DIR => dirname($filename) >>. If you want to
set a specific temporary directory, set L</"$FILE_TEMP_DIR">. But
keep in mind that C<rename()> doesn't work cross-device.

By default, if the target file exists, the temporary file is also created with
the same permission as the target file. Otherwise, permission is default as per
File::Temp's default (0600). If you want to set a specific permission, set
L</"$FILE_TEMP_PERMS">. Permission setting is done by File::Temp::tempfile()
using its PERMS option.

By default, file ownership is not changed/set. If you run this script as root,
you might be creating files owned by root. There's no option yet to set this.

=head2 write_binary

Usage:

 write_binary($filename, $content)

=head2 write_text_to_tempfile

Usage:

 $tempname = write_text_to_tempfile($content [ , $encoding, $crlf ])

Temporary file is created with default option (C<File::Temp::tempfile()>).

=head2 write_binary_to_tempfile

Usage:

 $tempname = write_binary_to_tempfile($content)

=head2 modify_text

Like L<File::Slurper::Shortcuts>'s C<modify_text> except it uses our version of
L</write_text>.

See File::Slurper::Shortcuts for more details.

=head2 modify_binary

Like L<File::Slurper::Shortcuts>'s C<modify_binary> except it uses our version
of L</write_binary>.

See File::Slurper::Shortcuts for more details.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/File-Slurper-Temp>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-File-Slurper-Temp>.

=head1 SEE ALSO

L<File::Slurper>

L<File::Temp>

C<modify_text()> and C<modify_binary()> follows L<File::Slurper::Shortcuts>.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 CONTRIBUTOR

=for stopwords George Baugh

George Baugh <george@troglodyne.net>

=head1 CONTRIBUTING


To contribute, you can send patches by email/via RT, or send pull requests on
GitHub.

Most of the time, you don't need to build the distribution yourself. You can
simply modify the code, then test via:

 % prove -l

If you want to build the distribution (e.g. to try to install it locally on your
system), you can install L<Dist::Zilla>,
L<Dist::Zilla::PluginBundle::Author::PERLANCAR>,
L<Pod::Weaver::PluginBundle::Author::PERLANCAR>, and sometimes one or two other
Dist::Zilla- and/or Pod::Weaver plugins. Any additional steps required beyond
that are considered a bug and can be reported to me.

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2024, 2019, 2017 by perlancar <perlancar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=File-Slurper-Temp>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=cut

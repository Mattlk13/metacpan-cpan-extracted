package Firefox::Marionette::Profile;

use strict;
use warnings;
use English qw( -no_match_vars );
use File::Spec();
use FileHandle();
use Fcntl();
use Config::INI::Reader();

BEGIN {
    if ( $OSNAME eq 'MSWin32' ) {
        require Win32;
    }
}
our $VERSION = '0.57';

sub _ANY_PORT           { return 0 }
sub _GETPWUID_DIR_INDEX { return 7 }

sub _profile_ini_directory {
    my $profile_ini_directory;
    if ( $OSNAME eq 'darwin' ) {
        my $home_directory =
          ( getpwuid $EFFECTIVE_USER_ID )[ _GETPWUID_DIR_INDEX() ];
        defined $home_directory
          or Firefox::Marionette::Exception->throw(
            "Failed to execute getpwuid for $OSNAME:$EXTENDED_OS_ERROR");
        $profile_ini_directory = File::Spec->catdir( $home_directory, 'Library',
            'Application Support', 'Firefox' );
    }
    elsif ( $OSNAME eq 'MSWin32' ) {
        $profile_ini_directory =
          File::Spec->catdir( Win32::GetFolderPath( Win32::CSIDL_APPDATA() ),
            'Mozilla', 'Firefox' );
    }
    elsif ( $OSNAME eq 'cygwin' ) {
        $profile_ini_directory =
          File::Spec->catdir( $ENV{APPDATA}, 'Mozilla', 'Firefox' );
    }
    else {
        my $home_directory =
          ( getpwuid $EFFECTIVE_USER_ID )[ _GETPWUID_DIR_INDEX() ];
        defined $home_directory
          or Firefox::Marionette::Exception->throw(
            "Failed to execute getpwuid for $OSNAME:$EXTENDED_OS_ERROR");
        $profile_ini_directory =
          File::Spec->catdir( $home_directory, '.mozilla', 'firefox' );
    }
    return $profile_ini_directory;
}

sub _read_ini_file {
    my ( $class, $profile_ini_directory ) = @_;
    if ( -d $profile_ini_directory ) {
        my $profile_ini_path =
          File::Spec->catfile( $profile_ini_directory, 'profiles.ini' );
        if ( -f $profile_ini_path ) {
            my $config = Config::INI::Reader->read_file($profile_ini_path);
            return $config;
        }
    }
    return {};
}

sub names {
    my ($class)               = @_;
    my $profile_ini_directory = $class->_profile_ini_directory();
    my $config                = $class->_read_ini_file($profile_ini_directory);
    my @names;
    foreach my $key ( sort { $a cmp $b } keys %{$config} ) {
        if ( defined $config->{$key}->{Name} ) {
            push @names, $config->{$key}->{Name};
        }
    }
    return @names;
}

sub existing {
    my ( $class, $name ) = @_;
    my $profile_ini_directory = $class->_profile_ini_directory();
    my $config                = $class->_read_ini_file($profile_ini_directory);
    my $path;
    my $first_key;
    foreach my $key ( sort { $a cmp $b } keys %{$config} ) {
        if ( ( !defined $first_key ) && ( defined $config->{$key}->{Name} ) ) {
            $first_key = $key;
        }
        my $selected;
        if (   ( defined $name )
            && ( defined $config->{$key}->{Name} )
            && ( $name eq $config->{$key}->{Name} ) )
        {
            $selected = 1;
        }
        elsif ( ( !defined $name ) && ( $config->{$key}->{Default} ) ) {
            $selected = 1;
        }
        if ($selected) {
            if ( $config->{$key}->{IsRelative} ) {
                $path = File::Spec->catfile( $profile_ini_directory,
                    $config->{$key}->{Path}, 'prefs.js' );
            }
            else {
                $path =
                  File::Spec->catfile( $config->{$key}->{Path}, 'prefs.js' );
            }
        }
    }
    if ( ( !$path ) && ( defined $first_key ) ) {
        if ( $config->{$first_key}->{IsRelative} ) {
            $path = File::Spec->catfile( $profile_ini_directory,
                $config->{$first_key}->{Path}, 'prefs.js' );
        }
        else {
            $path =
              File::Spec->catfile( $config->{$first_key}->{Path}, 'prefs.js' );
        }
    }
    if ( ($path) && ( -f $path ) ) {
        return $class->parse($path);
    }
    else {
        return;
    }
}

sub new {
    my ($class) = @_;
    my $profile = bless { comments => q[], keys => {} }, $class;
    $profile->{_download_directory} = File::Temp->newdir(
        File::Spec->catdir(
            File::Spec->tmpdir(),
            'firefox_marionette_download_directory_XXXXXXXXXXX'
        )
      )
      or Firefox::Marionette::Exception->throw(
        "Failed to create temporary directory:$EXTENDED_OS_ERROR");
    $profile->set_value( 'browser.shell.checkDefaultBrowser',     'false', 0 );
    $profile->set_value( 'browser.reader.detectedFirstArticle',   'true',  0 );
    $profile->set_value( 'dom.disable_open_click_delay',          0,       0 );
    $profile->set_value( 'app.update.auto',                       'false', 0 );
    $profile->set_value( 'app.update.enabled',                    'false', 0 );
    $profile->set_value( 'network.http. request.max-start-delay', '0',     0 );
    $profile->set_value( 'browser.startup.homepage', 'about:blank', 1 );
    $profile->set_value( 'browser.startup.homepage_override.mstone',
        'ignore', 1 );
    $profile->set_value( 'startup.homepage_welcome_url', 'about:blank', 1 );
    $profile->set_value( 'startup.homepage_welcome_url.additional',
        'about:blank', 1 );
    $profile->set_value( 'xpinstall.signatures.require', 'false', 0 );
    $profile->set_value( 'toolkit.telemetry.reportingpolicy.firstRun',
        'false', 0 );
    $profile->set_value( 'browser.download.useDownloadDir', 'true', 0 );
    $profile->set_value( 'browser.download.downloadDir',
        $profile->{_download_directory}->dirname(), 1 );
    $profile->set_value( 'browser.download.dir',
        $profile->{_download_directory}->dirname(), 1 );
    $profile->set_value( 'browser.download.lastDir',
        $profile->{_download_directory}->dirname(), 1 );
    $profile->set_value( 'browser.download.defaultFolder',
        $profile->{_download_directory}->dirname(), 1 );
    $profile->set_value( 'browser.download.folderList', 2, 0 )
      ;    # the last folder specified for a download
    $profile->set_value( 'marionette.port', _ANY_PORT() );
    return $profile;
}

sub save {
    my ( $self, $path ) = @_;
    my $temp_path = File::Temp::mktemp( $path . '.XXXXXXXXXXX' );
    my $handle =
      FileHandle->new( $temp_path,
        Fcntl::O_WRONLY() | Fcntl::O_CREAT() | Fcntl::O_EXCL(),
        Fcntl::S_IRWXU() )
      or Firefox::Marionette::Exception->throw(
        "Failed to open '$temp_path' for writing:$EXTENDED_OS_ERROR");
    $handle->write( $self->_as_string() )
      or Firefox::Marionette::Exception->throw(
        "Failed to write to '$temp_path':$EXTENDED_OS_ERROR");
    $handle->close()
      or Firefox::Marionette::Exception->throw(
        "Failed to close '$temp_path':$EXTENDED_OS_ERROR");
    rename $temp_path, $path
      or Firefox::Marionette::Exception->throw(
        "Failed to rename '$temp_path' to '$path':$EXTENDED_OS_ERROR");
    return;
}

sub _as_string {
    my ($self) = @_;
    my $string = q[];
    foreach my $key ( sort { $a cmp $b } keys %{ $self->{keys} } ) {
        my $value = $self->{keys}->{$key}->{value};
        if (   ( defined $value ) && ( $value eq 'true' )
            || ( $value eq 'false' )
            || ( $value =~ /^\d+$/smx ) )
        {
            $string .= "user_pref(\"$key\", $value);\n";
        }
        else {
            $value =~ s/\\/\\\\/smxg;
            $value =~ s/"/\\"/smxg;
            $string .= "user_pref(\"$key\", \"$value\");\n";
        }
    }
    return $string;
}

sub set_value {
    my ( $self, $name, $value ) = @_;
    $self->{keys}->{$name} = { value => $value };
    return $self;
}

sub clear_value {
    my ( $self, $name ) = @_;
    return delete $self->{keys}->{$name};
}

sub get_value {
    my ( $self, $name ) = @_;
    return $self->{keys}->{$name}->{value};
}

sub parse {
    my ( $proto, $path ) = @_;
    my $self = ref $proto ? $proto : bless {}, $proto;
    $self->{comments} = q[];
    $self->{keys}     = {};
    my $handle = FileHandle->new( $path, Fcntl::O_RDONLY() )
      or Firefox::Marionette::Exception->throw(
        "Failed to open '$path' for reading:$EXTENDED_OS_ERROR");
    while ( my $line = <$handle> ) {
        chomp $line;
        if (
            ( ( scalar keys %{ $self->{keys} } ) == 0 )
            && (   ( $line !~ /\S/smx )
                || ( $line =~ /^[#]/smx )
                || ( $line =~ /^\/[*]/smx )
                || ( $line =~ /^\/\//smx )
                || ( $line =~ /^\s+[*]/smx ) )
          )
        {
            $self->{comments} .= $line;
        }
        elsif ( $line =~ /^user_pref[(]"([^"]+)",[ ](["]?)(.+)\2?[)];\s*$/smx )
        {
            my ( $name, $quoted, $value ) = ( $1, $2, $3 );
            $value =~ s/$quoted$//smx;
            $value =~ s/\\$quoted/$quoted/smxg;
            $self->{keys}->{$name} = { value => $value };
        }
        else {
            Firefox::Marionette::Exception->throw("Failed to parse '$line'");
        }
    }
    close $handle
      or Firefox::Marionette::Exception->throw(
        "Failed to close '$path':$EXTENDED_OS_ERROR");
    return $self;

}

1;    # Magic true value required at end of module
__END__

=head1 NAME

Firefox::Marionette::Profile - Represents a prefs.js Firefox Profile

=head1 VERSION

Version 0.57

=head1 SYNOPSIS

    use Firefox::Marionette();
    use v5.10;

    my $profile = Firefox::Marionette::Profile->new();

    $profile->set_value('browser.startup.homepage', 'https://duckduckgo.com');

    my $firefox = Firefox::Marionette->new(profile => $profile);
	
    $firefox->quit();
	
    foreach my $profile_name (Firefox::Marionette::Profile->names()) {
        # start firefox using a specific existing profile
        $firefox = Firefox::Marionette->new(profile_name => $profile_name);
        $firefox->quit();

        # OR start a new browser with a copy of a specific existing profile

        $profile = Firefox::Marionette::Profile->existing($profile_name);
        $firefox = Firefox::Marionette->new(profile => $profile);
        $firefox->quit();
    }

=head1 DESCRIPTION

This module handles the implementation of a C<prefs.js> Firefox Profile

=head1 SUBROUTINES/METHODS

=head2 new

returns a new L<profile|Firefox::Marionette::Profile>.

=head2 names

returns a list of existing profile names that this module can discover on the filesystem.

=head2 existing

accepts a profile name and returns a L<profile|Firefox::Marionette::Profile> object for that specified profile name.

=head2 parse

accepts a path as the parameter.  This path should be to a C<prefs.js> fileParses the file and returns it as a L<profile|Firefox::Marionette::Profile>.

=head2 save

accepts a path as the parameter.  Saves the current profile to this location.

=head2 get_value

accepts a key name (such as C<browser.startup.homepage>) and returns the value of the key from the profile.

=head2 set_value

accepts a key name (such as C<browser.startup.homepage>) and a value (such as C<https://duckduckgo.com>) and sets this value in the profile.  It returns itself to aid in chaining methods

=head2 clear_value

accepts a key name (such as C<browser.startup.homepage>) and removes the key from the profile.  It returns the old value of the key (if any).

=head1 DIAGNOSTICS

=over
 
=item C<< Failed to execute getpwuid for %s:%s >>
 
The module was unable to to execute L<perlfunc/getpwuid>.  This is probably a bug in this module's logic.  Please report as described in the BUGS AND LIMITATIONS section below.

=item C<< Failed to open '%s' for writing:%s >>
 
The module was unable to open the named file.  Maybe your disk is full or the file permissions need to be changed?

=item C<< Failed to write to '%s':%s >>
 
The module was unable to write to the named file.  Maybe your disk is full?

=item C<< Failed to close '%s':%s >>
 
The module was unable to close a handle to the named file.  Something is seriously wrong with your environment.

=item C<< Failed to rename '%s' to '%s':%s >>
 
The module was unable to rename the named file to the second file.  Something is seriously wrong with your environment.

=item C<< Failed to open '%s' for reading:%s >>
 
The module was unable to open the named file.  Maybe your disk is full or the file permissions need to be changed?

=item C<< Failed to parse line '%s' >>
 
The module was unable to parse the line for a Firefox prefs.js configuration.  This is probably a bug in this module's logic.  Please report as described in the BUGS AND LIMITATIONS section below.

=back

=head1 CONFIGURATION AND ENVIRONMENT

Firefox::Marionette::Profile requires no configuration files or environment variables.

=head1 DEPENDENCIES

Firefox::Marionette::Profile requires the following non-core Perl modules
 
=over
 
=item *
L<Config::INI::Reader|Config::INI::Reader>
 
=back

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-firefox-marionette@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 AUTHOR

David Dick  C<< <ddick@cpan.org> >>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2018, David Dick C<< <ddick@cpan.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic/perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

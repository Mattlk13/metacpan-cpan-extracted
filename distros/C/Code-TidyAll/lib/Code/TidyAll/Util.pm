package Code::TidyAll::Util;

use strict;
use warnings;

# These are loaded aned exported purely for backwards compat since some of Jon
# Swartz's plugins use these in their tests :(
use File::Basename qw(dirname);
use File::Path qw(mkpath);
use File::Slurp::Tiny qw(read_file write_file);

use File::Spec;
use Guard;
use Path::Tiny 0.098 qw(cwd path tempdir);
use Try::Tiny;

use Exporter qw(import);

our $VERSION = '0.59';

our @EXPORT_OK = qw(can_load pushd tempdir_simple dirname mkpath read_file write_file);

sub can_load {

    # Load $class_name if possible. Return 1 if successful, 0 if it could not be
    # found, and rethrow load error (other than not found).
    #
    my ($class_name) = @_;

    my $result;
    try {
        eval "require $class_name";    ## no critic
        die $@ if $@;
        $result = 1;
    }
    catch {
        if ( /Can\'t locate .* in \@INC/ && !/Compilation failed/ ) {
            $result = 0;
        }
        else {
            die $_;
        }
    };
    return $result;
}

sub tempdir_simple {
    my $template = shift || 'Code-TidyAll-XXXX';

    return tempdir(
        { realpath => 1 },
        TEMPLATE => $template,
        CLEANUP  => 1
    );
}

sub pushd {
    my ($dir) = @_;

    my $cwd = cwd();
    chdir($dir);
    return guard { chdir($cwd) };
}

1;

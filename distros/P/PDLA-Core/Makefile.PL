use strict;
use warnings;

eval { require Devel::CheckLib; Devel::CheckLib->import; };
use 5.010_000;
use ExtUtils::MakeMaker 6.56;  # for CONFIGURE_REQUIRES support
use Config;
use File::Spec;

$::PP_VERBOSE = $::PP_VERBOSE = 0; # =1 makes PP waffle a lot

# file globals(!)
my ($forcebuild);
my ($seen_pdlconf);
my $pdl_conf_file = ''; # apparently for users to change

# build-system globals
our ($usenan, $bvalflag, $bvalPerPdl);

sub checkbuggysetup {
    # detect buggy Perl setups
    if (!$forcebuild &&
	$Config{osname} eq 'solaris' &&
	($Config{cc} =~ /gcc/ || $Config{gccversion} ne '') &&
	$Config{usemymalloc} eq 'y'
	) {
	die <<'EOM';

FATAL BUG IN YOUR PERL SETUP DETECTED. BUILD TERMINATED.

On this platform the combination of gcc and the Perl malloc
are buggy. The optimizations lead to random coredumps
and make PDLA essentially unusable.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
WORKAROUND: YOU MUST RECOMPILE PERL WITH 'usemymalloc=n' !!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

You may override and force the build by including the
'FORCE' switch:

  perl Makefile.PL FORCE

However, you will most likely end up with an unusable
PDLA build unless *all* optimizations are disabled!
YOU HAVE BEEN WARNED!!

EOM
  }

    my($dot);
    for(@INC) {$dot += $_ eq '.'}
    $dot-- if($INC[-1] eq '.');
    if($dot) {
	$INC = join(":",@INC);
	warn << "EOM"

**********************************************************************
Your Perl \@INC path is:

$INC

That seems to include the directory '.' before the last entry in the
path.  Configurations like that might be broken, because they may
prevent strict division of hierarchy in the module name space.
In particular, adding a module Foo::Bar::Baz can cause trouble
if Baz exists in the top level elsewhere, and if you run from the
Foo/Bar directory.

This happens with the PDLA::Config and some other modules.  You may
not be able to build PDLA with this \@INC setup.

If you strike trouble, you may need to fix your \@INC.
**********************************************************************


EOM
unless $ENV{PDLA_INC_OK};
}

}

# The user specifies configuration options using the PDLA_CONFIG
# array in perldl.conf - or ~/.perldl.conf or via the PDLACONF command-line
# argument.
#
# We need to use this information during the 'perl Makefile.PL' process,
# and historically this has been done by directly accessing %PDLA_CONFIG
# (or %::PDLA_CONFIG) variable. However, there are times that this information
# is also needed during the actual build (ie 'make' cycle), at which point
# the variable is not available. However Basic/Core/Config.pm is available,
# but this uses the %PDLA::Config variable to access the data.
#
# So, we try to avoid this dichotomy by creating a %PDLA::Config during
# the 'perl Makefile.PL' stage and then making sure that PDLA_CONFIG
# is destroyed (so it can't be used by accident).
#
# Do we need to worry about Makefile.PL's hacking PDLA_CONFIG?
# Probably...
#
%PDLA::Config = ();

sub getpdl_config {
  my ($pdl_conf_file) = @_;

  # First read in distribution config file
  #
  our %PDLA_CONFIG;
  require './perldl.conf';

  # Add BAD_VAL tests if CPAN testers
  #
  if ($ENV{AUTOMATED_TESTING}) {
     # warn "Makefile.PL: Automated testing environment: enabling USE_POGL config option\n";
     # $PDLA_CONFIG{USE_POGL} = 1;
  }

  # Save standard values
  #
  my %PDLA_CONFIG_DIST = %PDLA_CONFIG;

  # Now read in the users config file if specified
  # and convert y/n to 1/0
  #
  if (-f $pdl_conf_file) {
    warn "\nINFORMATION: using file $pdl_conf_file to set configuration defaults\n\n";
    require $pdl_conf_file;
  }

  # Sanity checking of user supplied keys (look for ones not defined in dist)

  for(keys %PDLA_CONFIG) {
    if(!exists($PDLA_CONFIG_DIST{$_})) {
      die << "EOD";
Invalid key $_ found in user supplied $pdl_conf_file
  - this key appears to be no longer in use.
  Please review configuration options and check the comments in
  the file perldl.conf that came with this distribution
EOD
    }
  }

  # Merge in default options where not supplied in users file
  #
  for(keys %PDLA_CONFIG_DIST) {
    $PDLA_CONFIG{$_} = $PDLA_CONFIG_DIST{$_} unless exists $PDLA_CONFIG{$_};
  }

  # Set up the default TEMPDIR if it has not been set by the user
  #
  # set up the default directory we use for temporary files throughout
  # PDLA. These are mainly for files created during the build of PDLA itself,
  # but it can also invovle files created whilst building an external
  # module that uses PDLA (e.g. the trylink() function of PDLA::Dev needs
  # a temporary file) or when a module is actually being used (e.g.
  # PDLA::IO::Dumper may need a temporary file).
  #
  # We have no policy about what directory to use - the following is
  # an amalgam of the different choices that have been used within PDLA
  # up to (and including) v2.4.1
  #

  $PDLA_CONFIG{PDLA_BUILD_DIR} = File::Spec->rel2abs(File::Spec->curdir());

  $PDLA_CONFIG{TEMPDIR} = $^O =~ /MSWin32/i ? 'File::Spec->tmpdir()' : File::Spec->tmpdir()
    unless exists $PDLA_CONFIG{TEMPDIR} and defined $PDLA_CONFIG{TEMPDIR};

  # set up the default MALLOCDBG information (if not specified by the user)
  #
  if ( exists $PDLA_CONFIG{MALLOCDBG} and defined $PDLA_CONFIG{MALLOCDBG} ) {
      my $val = $PDLA_CONFIG{MALLOCDBG};
      my $rval = ref($val);
      die "ERROR: MALLOCDBG must be set to an associative array, not to a " .
	( $rval ? $rval : "SCALAR" ) unless $rval eq "HASH";
  } else {
      $PDLA_CONFIG{MALLOCDBG} = undef; # exists but undef
  }
  foreach my $item ( qw( libs include ) ) {
      $PDLA_CONFIG{MALLOCDBG}->{$item} = ""
	unless exists $PDLA_CONFIG{MALLOCDBG}->{$item};
  }

  # filter out incompatible options for the 'bad' code.
  # At present we can not have the experimental per-piddle
  # code turned on (the BADVAL_PER_PDLA option) and use
  # NaN's for floating-point bad values (the BADVAL_USENAN
  # option).
  #
  my $flag_bad     = $PDLA_CONFIG{WITH_BADVAL} || 0;
  my $flag_use_nan = $PDLA_CONFIG{BADVAL_USENAN} || 0;
  my $flag_per_pdl = $PDLA_CONFIG{BADVAL_PER_PDLA} || 0;
  if ( $flag_bad and $flag_use_nan and $flag_per_pdl ) {
      print "WARNING: Setting BADVAL_USENAN=0 as BADVAL_PER_PDLA option is set!\n\n";
      $PDLA_CONFIG{BADVAL_USENAN} = 0;
  }

  # create a PDLA::Config variable matching the PDLA_CONFIG structure
  # and convert yes/no answers to 1/0
  #
  for my $key ( keys %PDLA_CONFIG ) {
      my $val = $PDLA_CONFIG{$key};
      $val =~ s/^y.*/1/i if defined $val;
      $val =~ s/^n.*/0/i if defined $val;
      $PDLA::Config{$key} = $val;
  }

  # destroy PDLA_CONFIG/PDLA_CONFIG_DIST so that we can catch any accesses
  # to them in other Makefile.PL's
  #
  %PDLA_CONFIG = ();
}

sub make_Version_pm {
  # Get Version from Basic/PDLA.pm and generated Basic/Core/Version.pm from it
  require './Basic/PDLA.pm';
  # keep version info in $PDLA::Config
  $PDLA::Config{PDLA_BUILD_VERSION} = "$PDLA::VERSION";

  my $versionFile = 'Basic/Core/Version.pm';
  open my $fh, ">", $versionFile or
    die("Can't Open '$versionFile' for Writing!\n");
  print $fh <<"EOVF";
package PDLA::Version;
#  This File was autogenerated by MakeFile.PL from the version
#  number in PDLA.pm. It is used by PDLA::Lite and others as
#  a single, consistent place to get the current PDLA version.
our \$VERSION='$PDLA::VERSION';
\$VERSION = eval \$VERSION;
1;
EOVF
  close $fh;
}

sub make_Types_pm {
  # make sure we have Types.pm ready for prime time
  die "Types.pm.PL not found in Basic/Core"
    unless -f 'Basic/Core/Types.pm.PL';
  my $usebvals = $PDLA::Config{WITH_BADVAL} ? "BADVALS=1" : "";
  system( $Config{perlpath}, 'Basic/Core/Types.pm.PL', $usebvals);
  unless ( -f 'Basic/Core/Types.pm' ) {
     warn "system( $Config{perlpath}, 'Basic/Core/Types.pm.PL', $usebvals) was run...\n";
     die "error creating Basic/Core/Types.pm";
  }
}

# very simple formatter, assumes structures are *not* nested
# used by make_PDLA_Config_pm
sub myformat {
  my $entry = shift;
  if (ref $entry eq 'ARRAY') {
    my $list = join ',', (map {('"'.quotemeta($_).'"')} @$entry);
    return "[$list]";
  } elsif (ref $entry eq 'HASH') {
    my $list = join ",\n", (map {('"'.quotemeta($_).'" => "'.
			       quotemeta($entry->{$_}).'"')} keys %$entry);
    $list = "\n$list\n\t\t" unless $list =~ /^\s*$/;
    return "{$list}";
  } else {
     return join '', '"',quotemeta($PDLA::Config{$_}),'"';
  }
}

sub make_PDLA_Config_pm {
  print "Writing Basic/Core/Config.pm\n";

  my $versionFile = "Basic/Core/Config.pm";
  open my $fh, ">", $versionFile
    or die "Couldn't open $versionFile for writing";
  print $fh "
# AUTOMATICALLY GENERATED BY THE PDLA TOPLEVEL Makefile.PL.
# DO NOT HAND-EDIT - CHANGES WILL BE LOST UPON YOUR NEXT
#  'perl Makefile.PL'!!!
package PDLA;
use File::Spec;
\%PDLA::Config = (\n";
  for (sort keys %PDLA::Config) {
    $fh->print( "\t$_\t=>\t" );
    if(defined $PDLA::Config{$_}) {
      if($PDLA::Config{$_} eq 'File::Spec->tmpdir()') {$fh->print( $PDLA::Config{$_} )}
      else {$fh->print( myformat($PDLA::Config{$_}) )}
    } else {
      $fh->print( "undef" );
    }
    $fh->print(",\n");
  }
  $fh->print( ");\n1;" );
  $fh->close();
}

# test for critical modules
my @hasnt = ();
my @test = (
    ['Filter::Util::Call','Filter'],
    ['Filter::Simple','Filter::Simple'],
    ## ['Module::Compile','Module::Compile'], # don't do this, fails (why?)
    ['Text::Balanced','Text::Balanced'],
);
## $DB::single = 1; # uncomment to have debugger stop here
for my $mod (@test) {
    eval "use $mod->[0]";
    push @hasnt, $mod->[1] if $@;
}

# Scan ARGV for config file argument
@ARGV = map {
	if(/^PDLACONF=(.*)$/) {
		$seen_pdlconf=1;
		$pdl_conf_file = $1; ();
	} elsif (/^FORCE$/i) {
		$forcebuild=1;
		();
        } else {
		$_
	}
} @ARGV;

warn "WARNING: forcing build...\n" if $forcebuild;

checkbuggysetup(); # check for buggy Perl setups

unless ( $seen_pdlconf ) {
    my $defname = "$ENV{HOME}/.perldl.conf";
    $pdl_conf_file = $defname if -f $defname;
}

# needs to be called before any of the make_XX routines
getpdl_config($pdl_conf_file);

# Check environment for SKIP_KNOWN_PROBLEMS
if (!defined($PDLA::Config{SKIP_KNOWN_PROBLEMS}) and defined($ENV{SKIP_KNOWN_PROBLEMS})) {
   $PDLA::Config{SKIP_KNOWN_PROBLEMS} = $ENV{SKIP_KNOWN_PROBLEMS};
   warn "Makefile.PL: setting SKIP_KNOWN_PROBLEMS Config from environment value: $ENV{SKIP_KNOWN_PROBLEMS}";
}

make_Version_pm();

make_Types_pm();

# this will make PDLA::Core::Dev's functions available
# in Makefile.PL files in all subdirectories
# IMPORTANT: it has to be after make_Types_pm()
require "./Basic/Core/Dev.pm"; PDLA::Core::Dev->import();

# only perform one test if required modules are missing
# the test will print an informational message and fail
my %notestsifmodulesmissing = @hasnt ? # are any required modules missing ?
  (test => {TESTS => 't/requiredmods.t'}) : ();

my @podpms = map { $_.".pod", '$(INST_LIBDIR)/PDLA/' . $_ .".pod"}
  qw/Bugs/;

my @prereq = (
           'Carp'                => 0,         # Need to run
           'Config'              => 0,         # 
           'Convert::UU'         => 0,         # for PDLA::IO::Dumper
           'Data::Dumper'        => 2.121,     # for PDLA::IO::Dumper
           'English'             => 0,
           'Fcntl'               => 0,
           'File::Basename'      => 0,
           'File::Find'          => 0,
	   'File::Map'           => 0.57,      # test new mmap implementation
           'File::Path'          => 0,
	   'File::Spec'          => 0.6,
	   'File::Temp'          => 0,
	   'Filter::Util::Call'  => 0,         # for PDLA::NiceSlice
	   'Filter::Simple'      => 0.88,      # for new PDLA::NiceSlice
	   'Module::Compile'     => 0.23,      # for new PDLA::NiceSlice
	   'Pod::Parser'         => 0,         # version TBD for PDLA::Doc
	   'Pod::Select'         => 0,         # version TBD for PDLA::Doc
           'Scalar::Util'        => 0,
           'Storable'            => 1.03,      # for PDLA::IO::Storable
	   'Text::Balanced'      => 1.89,      # for PDLA::NiceSlice
	  );

my @exe_files = qw(perldla pdladoc);
push @exe_files, "pdla$Config{exe_ext}" if $^O !~ /MSWin/;
my @cleanup = ("pdla$Config{exe_ext}", qw(
    pdladoc.db pdladoc.pod perldla.pod Changes.new
));

##############################
# Hack to include fPIC on x86_64 systems -
# use similar mods to affect CCFLAGS on other systems as needed...

my $ccflags =  $Config{ccflags};
if($Config{archname}=~m/x86_64/) {
    $ccflags .= " -fPIC";
}

# create GENERATED subdir with *.pm files during 'make dist' (to make metacpan.org happy)
my $preop = '$(PERL) -I$(INST_ARCHLIB) -I$(INST_LIB) -MPDLA::Core::Dev -e pdlpp_mkgen $(DISTVNAME)';

my @optimize = (OPTIMIZE => $PDLA::Config{OPTIMIZE}) if $PDLA::Config{OPTIMIZE};

my %makefile_hash = (
	      'PREREQ_PM' => { @prereq },
              'LICENSE' => 'perl',
              'CONFIGURE_REQUIRES' => {
                'Devel::CheckLib' => 1.01,
                'Carp'            => 1.20,    # EU::MM seems to need this not to crash
                'ExtUtils::MakeMaker' => 6.56,
                'File::Path'          => 0,
                'ExtUtils::ParseXS'   => 3.01, # avoids 2.21, known broken
              },
              TEST_REQUIRES => {
                'CPAN::Meta' => '2.120900',
                'IPC::Cmd' => 0.72,
                'Test::Exception' => 0,
                'Test::Warn' => 0,  # for t/pptest.t
                'Test::Deep' => 0,
              },
              BUILD_REQUIRES => {
                'ExtUtils::MakeMaker' => 0,
                'File::Path'          => 0,
              },
              'MIN_PERL_VERSION' => '5.010',
	      'NAME' => 'PDLA::Core',
	      'VERSION_FROM' => 'Basic/Core/Version.pm',
	      'EXE_FILES' => \@exe_files,
	      'PM' => { @podpms }, #so that the script docs are picked up
              'META_MERGE' => {
                "meta-spec" => { version => 2 },
                resources => {
                  homepage => 'http://pdlporters.github.io',
                  bugtracker  => {web=>'https://github.com/PDLPorters/pdla-core/issues'},
                  repository  => {
                    url => 'git://github.com/PDLPorters/pdla-core',
                    type => 'git',
                    web => 'https://github.com/PDLPorters/pdla-core',
                  },
                  x_IRC => 'irc://irc.perl.org/#pdl',
                },
                no_index => { file => ['Doc/scantree.pl'] },
                prereqs => {
                  runtime => {
                    suggests => {
                      'Astro::FITS::Header' => 0,
                    },
                  },
                  test => {
                    suggests => {
                      'Inline' => 0.83, # fixed ILSM-finding
                      'Inline::C' => 0.62,
                    },
                  },
                },
              },
	      @optimize,
	      'CCFLAGS' => $ccflags,
	      'dist'     => { COMPRESS => 'gzip',
                              SUFFIX   => 'gz',
                              PREOP    => $preop },
	      'clean' => {
		'FILES' => join ' ', @cleanup, qw(
                  tbyte.tif tmp0 tmp0.hdr tushort.tif
                  MANIFEST.bak tmp1* tmpraw* t/tmpraw* t/tmp1*
                  _Inline/ .inlinepdlpp/ .inline-ct/ .inlinewith/ *.xfig
                ),
              },
	      'realclean' => {'FILES' => 'Basic/Core/Config.pm'},
              'AUTHOR' => 'PerlDL Developers (pdl-general@lists.sourceforge.net)',
              'ABSTRACT' => 'Perl Data Language',
              'BINARY_LOCATION' => 'PDLA.tar.gz',

	      %notestsifmodulesmissing,
    );

=begin comment

print "makefile hash is:\n";
for $k(sort keys %makefile_hash) {
    print "\t$k\t";
    $v = $makefile_hash{$k};
    unless(ref $v) {
	print $v,"\n";
    } elsif(ref $v eq 'HASH') {
	print "HASH:\n";
	for $vk(sort keys %$v) {
	    print "\t\t$vk\t$v->{$vk}\n";
	}
    } elsif(ref $v eq 'ARRAY') {
	print "ARRAY:\n";
	for $vv(@$v) {
	    print "\t\t$vv\n";
	}
    } else {print "$v\n";}

}

=end comment

=cut

WriteMakefile(%makefile_hash);

# do *after* WriteMakefile since some options
# are set by the recursively called Makefile.PLs
make_PDLA_Config_pm(); # write out config to PDLA::Config

# Extra build target to build the doc database
sub MY::postamble {
  my ($self) = @_;
  package MY;
  my  $text =
'
doctest ::
	$(NOECHO) $(ECHO) "doctest: Building PDLA documentation database in blib ..."
	$(NOECHO) $(PERLRUNINST) Doc$(DFSEP)scantree.pl
%HTML%	$(NOECHO) $(ECHO) "doctest: Building PDLA documentation web pages in blib ..."
%HTML%	$(NOECHO) $(PERLRUNINST) Doc$(DFSEP)mkhtmldoc.pl

doc_site_install ::
	$(NOECHO) $(ECHO) "doc_site_install: Building PDLA documentation database ..."
	$(NOECHO) $(PERLRUNINST) Doc$(DFSEP)scantree.pl "$(DESTDIR)$(INSTALLSITEARCH)"
%HTML%	$(NOECHO) $(ECHO) "doc_site_install: Building PDLA documentation web pages ..."
%HTML%	$(NOECHO) $(PERL) Doc$(DFSEP)mkhtmldoc.pl "$(DESTDIR)$(INSTALLSITEARCH)$(DFSEP)PDLA"

doc_vendor_install ::
	$(NOECHO) $(ECHO) "doc_vendor_install: Building PDLA documentation database ..."
	$(NOECHO) $(PERLRUNINST) Doc$(DFSEP)scantree.pl "$(DESTDIR)$(INSTALLVENDORARCH)"
%HTML%	$(NOECHO) $(ECHO) "doc_vendor_install: Building PDLA documentation web pages ..."
%HTML%	$(NOECHO) $(PERL) Doc$(DFSEP)mkhtmldoc.pl "$(DESTDIR)$(INSTALLVENDORARCH)$(DFSEP)PDLA"

doc_perl_install ::
	$(NOECHO) $(ECHO) "doc_perl_install: Building PDLA documentation database ..."
	$(NOECHO) $(PERLRUNINST) Doc$(DFSEP)scantree.pl "$(DESTDIR)$(INSTALLARCHLIB)"
%HTML%	$(NOECHO) $(ECHO) "doc_perl_install: Building PDLA documentation web pages ..."
%HTML%	$(NOECHO) $(PERL) Doc$(DFSEP)mkhtmldoc.pl "$(DESTDIR)$(INSTALLARCHLIB)$(DFSEP)PDLA"
';

  if(defined $PDLA::Config{HTML_DOCS} && !$PDLA::Config{HTML_DOCS}){
    $text=~ s/\%HTML\%[^\n]*\n//og; # Remove %HTML% lines
  } else {
    $text=~ s/\%HTML\%//og; # Remove just %HTML% markers
  }

# Here, `pdla.c` is used directly because some makes (e.g., on Solaris) do not
# support the `$<` variable in explicit rules
$text .= <<EOT if $^O !~ /MSWin/;
pdla$Config::Config{exe_ext} : pdla.c
	\$(CC) \$(CFLAGS) \$(LDFLAGS) \$(CPPFLAGS) pdla.c -o \$\@
EOT

$text .= << 'EOT' if $^O =~ /MSWin/;

DISTWIN32NAME=$(DISTVNAME)-win32

ppm : doctest ppd
	$(MV) blib$(DFSEP)lib$(DFSEP)PDLA$(DFSEP)HtmlDocs$(DFSEP)PDLA blib$(DFSEP)html$(DFSEP)lib$(DFSEP)PDLA
	$(COMPRESS) -dc win32$(DFSEP)pbmwin32.tar.gz | $(TAR) xf -
	$(MKPATH) $(DISTWIN32NAME)
	$(CP) win32$(DFSEP)Readme $(DISTWIN32NAME)
	$(CP) win32$(DFSEP)install.ppm .
	$(PERL) -pe "s|<\x{2f}IMPLEMENTATION>|<INSTALL EXEC=\"perl\">install.ppm<\x{2f}INSTALL><\x{2f}IMPLEMENTATION>|" PDLA.ppd > PDLA.ppd.new
	$(RM) PDLA.ppd
	$(MV) PDLA.ppd.new PDLA.ppd
	$(CP) PDLA.ppd $(DISTWIN32NAME)
	$(TAR) cf $(DISTWIN32NAME)$(DFSEP)PDLA.tar blib install.ppm
	cd $(DISTWIN32NAME)
	$(COMPRESS) PDLA.tar
	$(ZIP) $(DISTWIN32NAME).zip *
	$(MV) $(DISTWIN32NAME).zip ..
	cd ..
	$(RM_RF) $(DISTWIN32NAME)
EOT

$text .= "\n" . ::coretarget($self);
my $coretest = join ' ', map File::Spec->catfile('t', $_), qw(core.t ops.t);
$text .= <<EOF;

coretest : core
	prove -b $coretest
EOF

return $text

}

sub coretarget {
    my ($self) = @_;
    # remember the fundamental ones end up far to right as much deps on them
    # a "right" is either scalar (named target) or tuple of
    #     [ \@dir, \@targets, \@prereqs ]
    # @dir is dir parts for use by File::Spec
    # @targets is make targets within that dir
    # @prereqs are named targets - undef=[]
    # all a left's rights are made concurrently, no sequence - list ALL prereqs
    my @left2rights = (
        [
            basics => [
                [ [ qw(Basic) ], [ qw(pm_to_blib) ], ],
                [ [ qw(Basic Core) ], [ qw(pm_to_blib) ], ],
                [ [ qw(Basic Gen) ], [ qw(all) ], ],
            ]
        ],
        [
            core => [
                [ [ qw(Basic SourceFilter) ], [ qw(pm_to_blib) ], ],
                map { [
                    [ 'Basic', $_ ],
                    [ 'pm_to_blib', 'dynamic' ],
                    [ 'basics' ],
                # the modules in PDLA::LiteF, used in t/core.t
                ] } qw(Core Ops Primitive Ufunc Slices Bad Math MatrixOps),
            ]
        ],
    );
    join "\n", map flatten_parallel_target($self, $_), @left2rights;
}

sub format_chunk {
    my ($self, $left, $deps, $dir, $targets) = @_;
    my @m = join ' ', $left, ':', @{$deps||[]};
    my $fsdir = File::Spec->catdir(@$dir);
    push @m, "\t" . $self->oneliner(
        "die \$! unless chdir q($fsdir); exec q(\$(MAKE) @$targets)"
    );
    join '', map "$_\n", @m;
}

# output: list of make chunks with target, deps, recipes
sub flatten_parallel_target {
    my ($self, $left2rights) = @_;
    my ($left, $rights) = @$left2rights;
    my (@deps, @recipes, @otherchunks);
    for my $right (@$rights) {
        if (ref $right) {
            #     [ \@dir, \@targets, \@prereqs ]
            # @dir is dir parts for use by File::Spec
            # @targets is make targets within that dir
            # @prereqs are named targets - undef=[]
            my ($dir, $targets, $prereqs) = @$right;
            my $target_name = parallel_target_mangle($self, $dir, $targets);
            push @deps, $target_name;
            push @otherchunks, format_chunk(
                $self, $target_name, $prereqs, $dir, $targets
            );
        } else {
            push @deps, $right;
        }
    }
    (
        join(' : ', $left, join ' ', @deps) . "\n",
        @otherchunks,
    );
}

sub parallel_target_mangle {
    my ($self, $dir, $targets) = @_;
    my $target = join '_', @$dir, @$targets;
    $target =~ s#[/\\]#_#g; # avoid ambiguity with filenames
    $target;
}

# remove pdla.c from making EUMM think this dir has XS in it
sub MY::init_dirscan {
    package MY;
    my ($self) = @_;
    $self->SUPER::init_dirscan;
    $self->{C} = [];
    $self->{O_FILES} = [];
}

# warn if vital modules are missing
END {
    if (@hasnt) {
      print << 'EOP';

********************************************************
* IMPORTANT: Your installation will not work since it  *
* lacks critical modules.                              *
* ALL TESTS WILL FAIL UNLESS YOU IMMEDIATELY           *
* INSTALL THE FOLLOWING MODULES [available from CPAN]: *
*
EOP

    for (@hasnt) { print "*\t$_\n" }


    print << 'EOP';
*                                                      *
* Please install the missing module(s) and start the   *
* PDLA build process again (perl Makefile.PL; ....)     *
*                                                      *
********************************************************

EOP

  }

} # end of END block

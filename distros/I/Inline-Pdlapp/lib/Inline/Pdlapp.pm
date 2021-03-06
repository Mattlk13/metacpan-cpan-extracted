package Inline::Pdlapp;

use strict;
use warnings;

use Config;
use Data::Dumper;
use Carp;
use Cwd qw(cwd abs_path);
use PDLA::Core::Dev;

our $VERSION = '2.019107';
use base qw(Inline::C);

#==============================================================================
# Register this module as an Inline language support module
#==============================================================================
sub register {
    return {
	    language => 'Pdlapp',
	    aliases => ['pdlapp','PDLAPP'],
	    type => 'compiled',
	    suffix => $Config{dlext},
	   };
}

# handle BLESS, INTERNAL - pass everything else up to Inline::C
sub validate {
    my $o = shift;
    $o->{ILSM} ||= {};
    $o->{ILSM}{XS} ||= {};
    # Shouldn't use internal linking for Inline stuff, normally
    $o->{ILSM}{INTERNAL} = 0 unless defined $o->{ILSM}{INTERNAL};
    $o->{ILSM}{MAKEFILE} ||= {};
    if (not $o->UNTAINT) {
      my $w = abs_path(PDLA::Core::Dev::whereami_any());
      $o->{ILSM}{MAKEFILE}{INC} = qq{"-I$w/Core"};
    }
    $o->{ILSM}{AUTO_INCLUDE} ||= ' '; # not '' as Inline::C does ||=
    my @pass_along;
    while (@_) {
	my ($key, $value) = (shift, shift);
	if ($key eq 'INTERNAL' or
	    $key eq 'PACKAGE' or
	    $key eq 'BLESS'
	   ) {
	    $o->{ILSM}{$key} = $value;
	    next;
	}
	push @pass_along, $key, $value;
    }
    $o->SUPER::validate(@pass_along);
}

#==============================================================================
# Parse and compile C code
#==============================================================================
sub build {
    my $o = shift;
    # $o->parse; # no parsing in pdlapp
    $o->get_maps; # get the typemaps
    $o->write_PD;
    # $o->write_Inline_headers; # shouldn't need this one either
    $o->write_Makefile_PL;
    $o->compile;
}

#==============================================================================
# Return a small report about the C code..
#==============================================================================
sub info {
    my $o = shift;
    my $txt = <<END;
The following PP code was generated (caution, can be long)...

*** start PP file ****

END
    return $txt . $o->pd_generate . "\n*** end PP file ****\n";
}

#==============================================================================
# Write the PDLA::PP code into a PD file
#==============================================================================
sub write_PD {
    my $o = shift;
    my $modfname = $o->{API}{modfname};
    my $module = $o->{API}{module};
    $o->mkpath($o->{API}{build_dir});
    open my $fh, ">", "$o->{API}{build_dir}/$modfname.pd" or croak $!;
    print $fh $o->pd_generate;
    close $fh;
}

#==============================================================================
# Generate the PDLA::PP code (piece together a few snippets)
#==============================================================================
sub pd_generate {
    my $o = shift;
    return join "\n", ($o->pd_includes,
		       $o->pd_code,
		       $o->pd_boot,
		       $o->pd_bless,
		       $o->pd_done,
		      );
}

sub pd_includes {
    my $o = shift;
    return << "END";
pp_addhdr << 'EOH';
$o->{ILSM}{AUTO_INCLUDE}
EOH

END
}

sub pd_code {
    my $o = shift;
    return $o->{API}{code};
}

sub pd_boot {
    my $o = shift;
    if (defined $o->{ILSM}{XS}{BOOT} and
	$o->{ILSM}{XS}{BOOT}) {
	return <<END;
pp_add_boot << 'EOB';
$o->{ILSM}{XS}{BOOT}
EOB

END
    }
    return '';
}


sub pd_bless {
    my $o = shift;
    if (defined $o->{ILSM}{BLESS} and
	$o->{ILSM}{BLESS}) {
	return <<END;
pp_bless $o->{ILSM}{BLESS};
END
    }
    return '';
}


sub pd_done {
  return <<END;
pp_done();
END
}

sub get_maps {
    my $o = shift;
    $o->SUPER::get_maps;
    my $w = abs_path(PDLA::Core::Dev::whereami_any());
    push @{$o->{ILSM}{MAKEFILE}{TYPEMAPS}}, "$w/Core/typemap.pdl";
}

#==============================================================================
# Generate the Makefile.PL
#==============================================================================
sub write_Makefile_PL {
    my $o = shift;
    my ($modfname,$module,$pkg) = @{$o->{API}}{qw(modfname module pkg)};
    my $coredev_suffix = $o->{ILSM}{INTERNAL} ? '_int' : '';
    my @pack = [ "$modfname.pd", $modfname, $module ];
    my $stdargs_func = $o->{ILSM}{INTERNAL}
        ? \&pdlpp_stdargs_int : \&pdlpp_stdargs;
    my %hash = $stdargs_func->(@pack);
    delete $hash{VERSION_FROM};
    my %options = (
        %hash,
        VERSION => $o->{API}{version} || "0.00",
        %{$o->{ILSM}{MAKEFILE}},
        NAME => $o->{API}{module},
        INSTALLSITEARCH => $o->{API}{install_lib},
        INSTALLDIRS => 'site',
        INSTALLSITELIB => $o->{API}{install_lib},
        MAN3PODS => {},
        PM => {},
    );
    my @postamblepack = ("$modfname.pd", $modfname, $module);
    push @postamblepack, $o->{ILSM}{PACKAGE} if $o->{ILSM}{PACKAGE};
    local $Data::Dumper::Terse = 1;
    local $Data::Dumper::Indent = 1;
    open my $fh, ">", "$o->{API}{build_dir}/Makefile.PL" or croak;
    print $fh <<END;
use strict;
use warnings;
use ExtUtils::MakeMaker;
use PDLA::Core::Dev;
my \$pack = @{[ Data::Dumper::Dumper(\@postamblepack) ]};
WriteMakefile(%{ @{[ Data::Dumper::Dumper(\%options) ]} });
sub MY::postamble { pdlpp_postamble$coredev_suffix(\$pack); }
END
    close $fh;
}

#==============================================================================
# Run the build process.
#==============================================================================
sub compile {
    my $o = shift;
    # grep is because on Windows, Cwd::abs_path blows up on non-exist dir
    local $ENV{PERL5LIB} = join $Config{path_sep}, map abs_path($_), grep -e, @INC
        unless defined $ENV{PERL5LIB};
    $o->SUPER::compile;
}
sub fix_make { } # our Makefile.PL doesn't need this

1;

__END__

=head1 NAME

Inline::Pdlapp - Write PDLA Subroutines inline with PDLA::PP

=head1 DESCRIPTION

C<Inline::Pdlapp> is a module that allows you to write PDLA subroutines
in the PDLA::PP style. The big benefit compared to plain C<PDLA::PP> is
that you can write these definitions inline in any old perl script
(without the normal hassle of creating Makefiles, building, etc).
Since version 0.30 the Inline module supports multiple programming
languages and each language has its own support module. This document
describes how to use Inline with PDLA::PP (or rather, it will once
these docs are complete C<;)>.

For more information on Inline in general, see L<Inline>.

Some example scripts demonstrating C<Inline::Pdlapp> usage can be
found in the F<examples> directory.


C<Inline::Pdlapp> is a subclass of L<Inline::C>. Most Kudos goes to Brian I.

=head1 USAGE

You never actually use C<Inline::Pdlapp> directly. It is just a support module
for using C<Inline.pm> with C<PDLA::PP>. So the usage is always:

    use Inline Pdlapp => ...;

or

    bind Inline Pdlapp => ...;

=head1 EXAMPLES

Pending availability of full docs a few quick examples
that illustrate typical usage.

=head2 A simple example

   # example script inlpp.pl
   use PDLA; # must be called before (!) 'use Inline Pdlapp' calls

   use Inline Pdlapp; # the actual code is in the __Pdlapp__ block below

   $a = sequence 10;
   print $a->inc,"\n";
   print $a->inc->dummy(1,10)->tcumul,"\n";

   __DATA__

   __Pdlapp__

   pp_def('inc',
	  Pars => 'i();[o] o()',
	  Code => '$o() = $i() + 1;',
	 );

   pp_def('tcumul',
	  Pars => 'in(n);[o] mul()',
	  Code => '$mul() = 1;
		   loop(n) %{
		     $mul() *= $in();
		   %}',
   );
   # end example script

If you call this script it should generate output similar to this:

   prompt> perl inlpp.pl
   Inline running PDLA::PP version 2.2...
   [1 2 3 4 5 6 7 8 9 10]
   [3628800 3628800 3628800 3628800 3628800 3628800 3628800 3628800 3628800 3628800]

Usage of C<Inline::Pdlapp> in general is similar to C<Inline::C>.
In the absence of full docs for C<Inline::Pdlapp> you might want to compare
L<Inline::C>.

=head2 Code that uses external libraries, etc

The script below is somewhat more complicated in that it uses code
from an external library (here from Numerical Recipes). All the
relevant information regarding include files, libraries and boot
code is specified in a config call to C<Inline>. For more experienced
Perl hackers it might be helpful to know that the format is
similar to that used with L<ExtUtils::MakeMaker|ExtUtils::MakeMaker>. The
keywords are largely equivalent to those used with C<Inline::C>. Please
see below for further details on the usage of C<INC>,
C<LIBS>, C<AUTO_INCLUDE> and C<BOOT>.

   use PDLA; # this must be called before (!) 'use Inline Pdlapp' calls

   use Inline Pdlapp => Config =>
     INC => "-I$ENV{HOME}/include",
     LIBS => "-L$ENV{HOME}/lib -lnr -lm",
     # code to be included in the generated XS
     AUTO_INCLUDE => <<'EOINC',
   #include <math.h>
   #include "nr.h"    /* for poidev */
   #include "nrutil.h"  /* for err_handler */

   static void nr_barf(char *err_txt)
   {
     fprintf(stderr,"Now calling croak...\n");
     croak("NR runtime error: %s",err_txt);
   }
   EOINC
   # install our error handler when loading the Inline::Pdlapp code
   BOOT => 'set_nr_err_handler(nr_barf);';

   use Inline Pdlapp; # the actual code is in the __Pdlapp__ block below

   $a = zeroes(10) + 30;;
   print $a->poidev(5),"\n";

   __DATA__

   __Pdlapp__

   pp_def('poidev',
	   Pars => 'xm(); [o] pd()',
	   GenericTypes => [L,F,D],
	   OtherPars => 'long idum',
	   Code => '$pd() = poidev((float) $xm(), &$COMP(idum));',
   );

=head1 MAKING AN INSTALLABLE MODULE

It is possible, using L<Inline::Module>, to create an installable F<.pm>
file with inline PDLA code. L<PDLA::IO::HDF> is a working example. Here's
how. You make a Perl module as usual, with a package declaration in
the normal way. Then (assume your package is C<PDLA::IO::HDF::SD>):

  package PDLA::IO::HDF::SD;
  # ...
  use FindBin;
  use Alien::HDF4::Install::Files;
  use PDLA::IO::HDF::SD::Inline Pdlapp => 'DATA',
    package => __PACKAGE__, # if you have any pp_addxs - else don't bother
    %{ Alien::HDF4::Install::Files->Inline('C') }, # EUD returns empty if !"C"
    typemaps => "$FindBin::Bin/lib/PDLA/IO/HDF/typemap.hdf",
    ;
  # ...
  1;
  __DATA__
  __Pdlapp__
  pp_addhdr(<<'EOH');
  /* ... */
  EOH
  use FindBin;
  use lib "$FindBin::Bin/../../../../../../..";
  require 'buildfunc.noinst';
  # etc

Note that for any files that you need to access for build purposes (they
won't be touched during post-install runtime), L<FindBin> is useful,
albeit slightly complicated.

In the main F<.pm> body, L<FindBin> will find the build directory, as
illustrated above. However, in the "inline" parts, C<FindBin> will be
within the L<Inline::Module> build directory. At the time of writing,
this is under F<.inline> within the build directory, in a subdirectory
named after the package. The example shown above has seven F<..>: two
for F<.inline/build>, and five more for F<PDLA/IO/HDF/SD/Inline>.

The rest of the requirements are given in the L<Inline::Module>
documentation.

This technique avoids having to use L<PDLA::Core::Dev>, create a
F<Makefile.PL>, have one directory per F<.pd>, etc. It will even build
/ install faster, since unlike a build of an L<ExtUtils::MakeMaker>
distribution with multiple directories, it can be built in parallel. This
is because the EUMM build changes into each directory, and waits for each
one to complete. This technique can run concurrently without problems.

=head1 PDLAPP CONFIGURATION OPTIONS

For information on how to specify Inline configuration options, see
L<Inline>. This section describes each of the configuration options
available for Pdlapp. Most of the options correspond either to MakeMaker or
XS options of the same name. See L<ExtUtils::MakeMaker> and L<perlxs>.

=head2 AUTO_INCLUDE

Specifies extra statements to automatically included. They will be
added onto the defaults. A newline char will be automatically added.
Does essentially the same as a call to C<pp_addhdr>. For short
bits of code C<AUTO_INCLUDE> is probably syntactically nicer.

    use Inline Pdlapp => Config => AUTO_INCLUDE => '#include "yourheader.h"';

=head2 BLESS

Same as C<pp_bless> command. Specifies the package (i.e. class)
to which your new I<pp_def>ed methods will be added. Defaults
to C<PDLA> if omitted.

    use Inline Pdlapp => Config => BLESS => 'PDLA::Complex';

cf L</PACKAGE>, equivalent for L<PDLA::PP/pp_addxs>.

=head2 BOOT

Specifies C code to be executed in the XS BOOT section. Corresponds to
the XS parameter. Does the same as the C<pp_add_boot> command. Often used
to execute code only once at load time of the module, e.g. a library
initialization call.

=head2 CC

Specify which compiler to use.

=head2 CCFLAGS

Specify extra compiler flags.

=head2 INC

Specifies an include path to use. Corresponds to the MakeMaker parameter.

    use Inline Pdlapp => Config => INC => '-I/inc/path';

=head2 LD

Specify which linker to use.

=head2 LDDLFLAGS

Specify which linker flags to use.

NOTE: These flags will completely override the existing flags, instead
of just adding to them. So if you need to use those too, you must
respecify them here.

=head2 LIBS

Specifies external libraries that should be linked into your
code. Corresponds to the MakeMaker parameter.

    use Inline Pdlapp => Config => LIBS => '-lyourlib';

or

    use Inline Pdlapp => Config => LIBS => '-L/your/path -lyourlib';

=head2 MAKE

Specify the name of the 'make' utility to use.

=head2 MYEXTLIB

Specifies a user compiled object that should be linked in. Corresponds
to the MakeMaker parameter.

    use Inline Pdlapp => Config => MYEXTLIB => '/your/path/yourmodule.so';

=head2 OPTIMIZE

This controls the MakeMaker OPTIMIZE setting. By setting this value to
'-g', you can turn on debugging support for your Inline
extensions. This will allow you to be able to set breakpoints in your
C code using a debugger like gdb.

=head2 PACKAGE

Controls into which package the created XSUBs from L<PDLA::PP/pp_addxs>
go. E.g.:

    use Inline Pdlapp => 'DATA', => PACKAGE => 'Other::Place';

will put the created routines into C<Other::Place>, not the calling
package (which is the default). Note this differs from L</BLESS>, which
is where L<PDLA::PP/pp_def>s go.

=head2 TYPEMAPS

Specifies extra typemap files to use. Corresponds to the MakeMaker parameter.

    use Inline Pdlapp => Config => TYPEMAPS => '/your/path/typemap';

=head2 NOISY

Show the output of any compilations going on behind the scenes. Turns
on C<BUILD_NOISY> in L<Inline::C>.

=head1 BUGS

=head2 C<do>ing inline scripts

Beware that there is a problem when you use
the __DATA__ keyword style of Inline definition and
want to C<do> your script containing inlined code. For example

   # myscript.pl contains inlined code
   # in the __DATA__ section
   perl -e 'do "myscript.pl";'
 One or more DATA sections were not processed by Inline.

According to Brian Ingerson (of Inline fame) the workaround is
to include an C<Inline-E<gt>init> call in your script, e.g.

  use PDLA;
  use Inline Pdlapp;
  Inline->init;

  # perl code

  __DATA__
  __Pdlapp__

  # pp code

=head2 C<PDLA::NiceSlice> and C<Inline::Pdlapp>

There is currently an undesired interaction between
L<PDLA::NiceSlice|PDLA::NiceSlice> and C<Inline::Pdlapp>.
Since PP code generally contains expressions
of the type C<$var()> (to access piddles, etc)
L<PDLA::NiceSlice|PDLA::NiceSlice> recognizes those incorrectly as
slice expressions and does its substitutions. For the moment
(until hopefully the parser can deal with that) it is best to
explicitly switch L<PDLA::NiceSlice|PDLA::NiceSlice> off before
the section of inlined Pdlapp code. For example:

  use PDLA::NiceSlice;
  use Inline::Pdlapp;

  $a = sequence 10;
  $a(0:3)++;
  $a->inc;

  no PDLA::NiceSlice;

  __DATA__

  __C__

  ppdef (...); # your full pp definition here

=head1 ACKNOWLEDGEMENTS

Brian Ingerson for creating the Inline infrastructure.

=head1 AUTHOR

Christian Soeller <soellermail@excite.com>

=head1 SEE ALSO

=over

=item L<PDLA>

=item L<PDLA::PP>

=item L<Inline>

=item L<Inline::C>

=item L<Inline::Module>

=back

=head1 COPYRIGHT

Copyright (c) 2001. Christian Soeller. All rights reserved.

This program is free software; you can redistribute it and/or
modify it under the same terms as PDLA itself.

See http://pdl.perl.org

=cut

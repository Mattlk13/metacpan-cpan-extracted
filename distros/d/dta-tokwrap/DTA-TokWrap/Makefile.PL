##-*- Mode: CPerl -*-
use ExtUtils::MakeMaker;
use 5.010; ##-- in case old EU::MM doesn't grok MIN_PERL_VERSION

##-- workaround for irritating "/some/symlinked/file is encountered a second time at File/Find.pm line 79." errors
##   under ExtUtils::MakeMaker 7.1002 (see also RT bug #99018)
#*ExtUtils::MakeMaker::_check_files = sub {};
#*ExtUtils::MakeMaker::check_manifest = sub {};
do "../find.hack" if (-e "../find.hack");


##----------------------------------------------------------------------
## MAIN
##----------------------------------------------------------------------
WriteMakefile
  (
   NAME		=> 'DTA::TokWrap',
   AUTHOR       => 'Bryan Jurish <moocow@cpan.org>',
   ABSTRACT	=> 'Wrapper modules & scripts for DTA XML corpus tokenization',
   VERSION_FROM	=> 'TokWrap/Version.pm',
   LICENSE      => 'perl_5',
   MIN_PERL_VERSION => 5.010, ##-- v5.10.0

   PREREQ_PM    => {
		    'XML::Parser' => 0,
		    'XML::LibXML' => 0,
		    'XML::LibXSLT' => 0,
		    'Encode'=>0,
		    'Time::HiRes'=>1.9711,
		    'Getopt::Long'=>0,
		    'Pod::Usage'=>0,
		    'Env::Path' =>0.18,
		    'File::Basename'=>0,
		    'Cwd'=>0,
		    'Log::Log4perl'=>1.20,
		    'Algorithm::BinarySearch::Vec'=>0.05, ##-- only really required for for dtatw-get-ddc-attrs.perl
		    ##
		    'Test::More'=>0,
		    ##--
		    #'Tie::Cache'=>0,
		    #'File::Basename'=>0,
		    #'Getopt::Long'=>0,
		    #'Pod::Usage'=>0,
		    #'Storable'=>0,
		    ##--
		    #'Log::Log4perl' => 1.07,
		    #'Text::Unidecode' => 0.04,
		    #'RPC::XML' => 0.59,
		   },

   EXE_FILES   => [
		   'dta-tokwrap.perl',
		  ],
  );


##-----------------------------------------------------------------------
## Extensions
##-----------------------------------------------------------------------

##---------------------------------------------------------------
sub MY::constants {
  package MY;
  my $css = 'dtatw.css';
  my $inherited = shift->SUPER::constants(@_);
  $inherited .= (
		 ###-- constants: html css
		 "\n"
		 ."CSS ?= $css\n"
		);
  return $inherited;
}

##---------------------------------------------------------------
sub MY::depend {
  package MY;
  my $inherited = shift->SUPER::depend(@_);
  $inherited .= (
		 ###-- depends -> README.txt
		 "\n\n"
		 ."dist: README.txt\n"
		 ."\n"
		 ."create_distdir: README.txt\n"
		 #."distdir_am: README.txt\n"
		 ."\n"
		 ."distcheck: README.txt\n"
		 ."\n"
		 ."manicheck: README.txt\n"
		 ."\n"
		);
  return $inherited;
}

##---------------------------------------------------------------
sub MY::special_targets {
  package MY;
  my $inherited = shift->SUPER::special_targets(@_);
  $inherited .=
"
.SUFFIXES: .pm .pod .rpod .man .txt .html

.pm.html:
\tpod2html --css=\$(CSS) --infile=\$< --outfile=\$@

.pm.txt:
\tpod2text \$< \$@

.pod.html:
\tpod2html --css=\$(CSS) --infile=\$< --outfile=\$@

.pod.txt:
\tpod2text \$< \$@

.rpod.html:
\tpod2html --css=\$(CSS) --infile=\$< --outfile=\$@

.rpod.txt:
\tpod2text \$< \$@

";
  return $inherited;
}

##---------------------------------------------------------------
sub MY::manifypods {
  package MY;
  my $inherited = shift->SUPER::manifypods(@_);
  my $out = $inherited;

  my $new = $inherited;
  my $html_ns_sep = ".";
  $new =~ s/.*(?=^manifypods\b)//sm;
  $new =~ s/\n\n.*//s;
  my ($deps0,$rules0) = split(/(?<!\\)\n/, $new, 2);
  my ($deps,$rules);

  ##-----------------------
  ## html
  my $htmlvars ='

##--- pod -> HTML

.SUFFIXES: .html

INST_CSS ?= ../../$(CSS)
#POD2HTMLFLAGS ?= --css="$(INST_CSS)" --backlink="(Back to Top)" --podroot=blib --podpath=script --header
POD2HTMLFLAGS ?= --css="$(INST_CSS)" --podroot="$(CURDIR)/blib" --podpath="./lib:./script" --header
POD2HTML ?= pod2html $(POD2HTMLFLAGS)

INST_HTMLDIR ?= blib/html

HTML_EXT ?= html
HTML1EXT ?= $(HTML_EXT)
HTML3EXT ?= $(HTML_EXT)

##-- lifted from MakeMaker blibdir section
$(INST_HTMLDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_HTMLDIR)
	$(NOECHO) $(CHMOD) 755 $(INST_HTMLDIR)
	$(NOECHO) $(TOUCH) $(INST_HTMLDIR)$(DFSEP).exists

';
  ($deps,$rules) = ($deps0,$rules0);
  $deps =~ s/^manifypods\b/htmlifypods/;
  $deps .= "\\\n\t".'$(INST_HTMLDIR)$(DFSEP).exists';
  $rules =~ s/POD2MAN/POD2HTML/g;
  $rules =~ s/MAN(\d)EXT/HTML$1EXT/g;
  $rules =~ s/INST_MAN\dDIR/INST_HTMLDIR/g;
  $rules =~ s/^\s+\$\(NOECHO\).*?\n//smg;
  $rules =~ s/::/${html_ns_sep}/sg if ($html_ns_sep ne '::');
  $rules =~ s/\\\n/\n/sg;
  my $hackit = ("\\\n"
		."\t | ".'$(PERL) -p'." \\\n"
		."\t   ".'-e\'sub hackhref {($$href=shift)=~s{^/*}{}; $$href=~s{^(?:\./)?(?:script|lib)/}{}; $$href=~s{/}{'.$html_ns_sep.'}g; $$href;}\''." \\\n"
		."\t   ".'-e\'s/<a href="([^"]*)/\'\\\'\'<a href="\'\\\'\'.hackhref($$1)/eg;\''
               );
  #$hackit = ' | cat - ';
  $rules =~ s/\t\s+(\S+)\s+(\S+)/\t\$(POD2HTML) --infile=$1 ${hackit} \\\n\t > $2 || (rm -f $2 && false)/sg;
  $out .= $htmlvars.$deps."\n".$rules."\n\n";

  ##-----------------------
  ## text
  my $text_ns_sep = $html_ns_sep;
  my $textvars ='

##--- pod -> txt
.SUFFIXES: .txt

POD2TEXT ?= pod2text

INST_TEXTDIR ?= blib/txt
TEXT_EXT ?= txt
TEXT1EXT ?= $(TEXT_EXT)
TEXT3EXT ?= $(TEXT_EXT)

##-- lifted from MakeMaker blibdir section
$(INST_TEXTDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_TEXTDIR)
	$(NOECHO) $(CHMOD) 755 $(INST_TEXTDIR)
	$(NOECHO) $(TOUCH) $(INST_TEXTDIR)$(DFSEP).exists

';
  ($deps,$rules) = ($deps0,$rules0);
  $deps =~ s/^manifypods\b/textifypods/;
  $deps .= "\\\n\t".'$(INST_TEXTDIR)$(DFSEP).exists';
  $rules =~ s/POD2MAN/POD2TEXT/g;
  $rules =~ s/MAN(\d)EXT/TEXT$1EXT/g;
  $rules =~ s/INST_MAN\dDIR/INST_TEXTDIR/g;
  $rules =~ s/^\s+\$\(NOECHO\).*?\n//smg;
  $rules =~ s/::/${text_ns_sep}/sg if ($text_ns_sep ne '::');
  $rules =~ s/\\\n/\n/sg;
  $rules =~ s/\t\s+(\S+)\s+(\S+)/\t\$(POD2TEXT) $1 $2/sg;
  $rules .= "\n\ntxtifypods: textifypods\n\n";
  $out .= $textvars.$deps."\n".$rules."\n\n";

  ##-----------------------
  ## pod
  my $pod_ns_sep = $html_ns_sep;
  my $podvars ='

##--- pod+perl -> pod

.SUFFIXES: .pod

POD2POD ?= podselect -section ""

INST_PODDIR ?= blib/pod
POD_EXT ?= pod
POD1EXT ?= $(POD_EXT)
POD3EXT ?= $(POD_EXT)

##-- lifted from MakeMaker blibdir section
$(INST_PODDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_PODDIR)
	$(NOECHO) $(CHMOD) 755 $(INST_PODDIR)
	$(NOECHO) $(TOUCH) $(INST_PODDIR)$(DFSEP).exists

';
  ($deps,$rules) = ($deps0,$rules0);
  $deps =~ s/^manifypods\b/podifypods/;
  $deps .= "\\\n\t".'$(INST_PODDIR)$(DFSEP).exists';
  $rules =~ s/POD2MAN/POD2POD/g;
  $rules =~ s/MAN(\d)EXT/POD$1EXT/g;
  $rules =~ s/INST_MAN\dDIR/INST_PODDIR/g;
  $rules =~ s/^\s+\$\(NOECHO\).*?\n//smg;
  $rules =~ s/::/${pod_ns_sep}/sg if ($pod_ns_sep ne '::');
  $rules =~ s/\\\n/\n/sg;
  $rules =~ s/\t\s+(\S+)\s+(\S+)/\t\$(POD2POD) $1 > $2/sg;
  $out .= $podvars.$deps."\n".$rules."\n\n";

  ##-- return
  return $out;
}

##---------------------------------------------------------------
sub MY::distdir {
  package MY;
  my $inherited = shift->SUPER::distdir(@_);
  my $local =
'
##-- distdir_am: hacked create_distdir for superordinate automake
#DISTDIR_AM ?= $(DISTNAME).am
#distdir_am:
#	$(RM_RF) $(DISTDIR_AM)
#	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \\
#	  -e "manicopy(maniread(),\'$(DISTDIR_AM)\', \'$(DIST_CP)\');"

DISTDIR_AM ?= $(DISTNAME).am
distdir_am:
	$(MAKE) distdir
	-rm -rf $(DISTDIR_AM)
	mv $(DISTVNAME) $(DISTDIR_AM)


PMLIST_AM ?= ../doc/pm_list
pm_list: $(PMLIST_AM)
$(PMLIST_AM): $(TO_INST_PM)
	echo "$(TO_INST_PM)" | xargs -n 1 echo | grep -v "\.in$$" > $@
';
  return $inherited.$local;
}

##---------------------------------------------------------------
sub MY::postamble {
  package MY;
  my $inherited = shift->SUPER::postamble(@_);
  return $inherited;
}

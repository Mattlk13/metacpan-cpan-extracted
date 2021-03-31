# This file provides a class that parses the Code -member
# of the PDL::PP code.
#
# This is what makes the nice loops go around etc.
#

package PDL::PP::Code;
use Carp;
our @CARP_NOT;

use strict;

# check for bad value support
#
use PDL::Config;
my $bvalflag = $PDL::Config{WITH_BADVAL} || 0;
my $usenan   = $PDL::Config{BADVAL_USENAN} || 0;

sub get_pdls {my($this) = @_; return ($this->{ParNames},$this->{ParObjs});}

# Do the appropriate substitutions in the code.
sub new {
    my($type,$code,$badcode,$parnames,$parobjs,$indobjs,$generictypes,
       $extrageneric,$havethreading,$name,
       $dont_add_thrloop, $backcode ) = @_;

    die "Error: missing name argument to PDL::PP::Code->new call!\n"
      unless defined $name;

    # simple way of handling bad code check
    $badcode = undef unless $bvalflag;
    my $handlebad = defined($badcode);

    # last two arguments may not be supplied
    #
    # "backcode" is a flag to the PDL::PP::Threadloop class indicating thre threadloop
    #   is for writeback code (typically used for writeback of data from child to parent PDL

    $dont_add_thrloop = 0 unless defined $dont_add_thrloop;

    # C++ style comments
    #
    # This regexp isn't perfect because it doesn't cope with
    # literal string constants.
    #
    $code =~ s,//.*?\n,,g;

    if ($::PP_VERBOSE) {
	print "Processing code for $name\n";
	print "DONT_ADD_THRLOOP!\n" if $dont_add_thrloop;
	print "EXTRAGEN: {" .
	  join(" ",
	       map { "$_=>" . $$extrageneric{$_}} keys %$extrageneric)
	    . "}\n";
	print "ParNAMES: ",(join ',',@$parnames),"\n";
	print "GENTYPES: ", @$generictypes, "\n";
	print "HandleBad: $handlebad\n";
    }
    my $this = bless {
	IndObjs => $indobjs,
	ParNames => $parnames,
	ParObjs => $parobjs,
	Gencurtype => [], # stack to hold GenType in generic loops
	types => 0,  # for thisisloop method
	ftypes_vars => {},
	ftypes_type => undef,
        Generictypes => $generictypes,   # so that MacroAccess can check it
        Name => $name,
    }, $type;

    my $inccode = join '',map {$_->get_incregisters();} (sort values %{$this->{ParObjs}});

    # First, separate the code into an array of C fragments (strings),
    # variable references (strings starting with $) and
    # loops (array references, 1. item = variable.
    #
    my ( $threadloops, $coderef, $sizeprivs ) =
	$this->separate_code( "{$inccode\n$code\n}" );

    # Now, if there is no explicit threadlooping in the code,
    # enclose everything into it.
    if(!$threadloops && !$dont_add_thrloop && $havethreading) {
	print "Adding threadloop...\n" if $::PP_VERBOSE;
	my $nc = $coderef;
	if( !$backcode ){ # Normal readbackdata threadloop
		$coderef = PDL::PP::ThreadLoop->new();
	}
	else{  # writebackcode threadloop
		$coderef = PDL::PP::BackCodeThreadLoop->new();
	}
	push @{$coderef},$nc;
    }

    # repeat for the bad code, then stick good and bad into
    # a BadSwitch object which creates the necessary
    # 'if (bad) { badcode } else { goodcode }' code
    #
    # NOTE: amalgamate sizeprivs from good and bad code
    #
    if ( $handlebad ) {
	print "Processing 'bad' code...\n" if $::PP_VERBOSE;
	my ( $bad_threadloops, $bad_coderef, $bad_sizeprivs ) =
	    $this->separate_code( "{$inccode\n$badcode\n}" );

	if(!$bad_threadloops && !$dont_add_thrloop && $havethreading) {
	    print "Adding 'bad' threadloop...\n" if $::PP_VERBOSE;
	    my $nc = $bad_coderef;
	    if( !$backcode ){ # Normal readbackdata threadloop
		    $bad_coderef = PDL::PP::ThreadLoop->new();
	    }
	    else{  # writebackcode threadloop
		    $bad_coderef = PDL::PP::BackCodeThreadLoop->new();
	    }
	    push @{$bad_coderef},$nc;
	}

	my $good_coderef = $coderef;
	$coderef = PDL::PP::BadSwitch->new( $good_coderef, $bad_coderef );

	# amalgamate sizeprivs from Code/BadCode segments
	# (sizeprivs is a simple hash, with each element
	# containing a string - see PDL::PP::Loop)
	while ( my ( $bad_key, $bad_str ) = each %$bad_sizeprivs ) {
	    my $str = $$sizeprivs{$bad_key};
	    if ( defined $str ) {
		die "ERROR: sizeprivs problem in PP/PDLCode.pm (BadVal stuff)\n"
		    unless $str eq $bad_str;
	    }
	    $$sizeprivs{$bad_key} = $bad_str;  # copy over
	}

    } # if: $handlebad

    print "SIZEPRIVSX: ",(join ',',%$sizeprivs),"\n" if $::PP_VERBOSE;

    # Enclose it all in a genericloop.
    # XXX Make genericloop understand denied pointers;...
    my $nc = $coderef;
    $coderef = PDL::PP::GenericLoop->new($generictypes, undef,
	  [grep {!$extrageneric->{$_}} @$parnames],'$PRIV(__datatype)');
    push @{$coderef},$nc;

    # Do we have extra generic loops?
    # If we do, first reverse the hash:
    my %glh;
    for(keys %$extrageneric) {
	push @{$glh{$extrageneric->{$_}}},$_;
    }
    my $no = 0;
    for(keys %glh) {
	my $nc = $coderef;
	$coderef = PDL::PP::GenericLoop->new($generictypes,$no++,
					    $glh{$_},$_);
	push @$coderef,$nc;
    }

    # Then, in this form, put it together what we want the code to actually do.
    print "SIZEPRIVS: ",(join ',',%$sizeprivs),"\n" if $::PP_VERBOSE;
    $this->{Code} = "{".(join '',sort values %$sizeprivs).
       $coderef->get_str($this,[])
       ."}";
    $this->{Code};

} # new()

# This sub determines the index name for this index.
# For example, a(x,y) and x0 becomes [x,x0]
sub make_loopind { my($this,$ind) = @_;
	my $orig = $ind;
	while(!$this->{IndObjs}{$ind}) {
		if(!((chop $ind) =~ /[0-9]/)) {
			confess("Index not found for $_ ($ind)!\n");
		}
		}
	return [$ind,$orig];
}

# my ( $threadloops, $coderef, $sizeprivs ) = $this->separate_code( $code );
#
# separates the code into an array of C fragments (strings),
# variable references (strings starting with $) and
# loops (array references, 1. item = variable.
#
sub separate_code {
    my ( $this, $code ) = @_;
    # First check for standard code errors:
    catch_code_errors($code);
    my $coderef = PDL::PP::Block->new;
    my @stack = ($coderef);
    my $threadloops = 0;
    my $sizeprivs = {};
    local $_ = $code;
    while($_) {
	# Parse next statement
	# I'm not convinced that having the checks twice is a good thing,
	# since it makes it easy (for me at least) to forget to update one
	# of them
	s/^(.*?) # First, some noise is allowed. This may be bad.
	    ( \$(ISBAD|ISGOOD|SETBAD)\s*\(\s*\$?[a-zA-Z_]\w*\s*\([^)]*\)\s*\)   # $ISBAD($a(..)), ditto for ISGOOD and SETBAD
                |\$PP(ISBAD|ISGOOD|SETBAD)\s*\(\s*[a-zA-Z_]\w*\s*,\s*[^)]*\s*\)   # $PPISBAD(CHILD,[1]) etc
###                |\$STATE(IS|SET)(BAD|GOOD)\s*\(\s*[^)]*\s*\)      # $STATEISBAD(a) etc
                |\$PDLSTATE(IS|SET)(BAD|GOOD)\s*\(\s*[^)]*\s*\)   # $PDLSTATEISBAD(a) etc
	        |\$[a-zA-Z_]\w*\s*\([^)]*\)  # $a(...): access
		|\bloop\s*\([^)]+\)\s*%\{   # loop(..) %{
		|\btypes\s*\([^)]+\)\s*%\{  # types(..) %{
		|\bthreadloop\s*%\{         # threadloop %{
		|%}                        # %}
		|$)//xs
		    or confess("Invalid program $_");
	my $control = $2;
	# Store the user code.
	# Some day we shall parse everything.
	push @{$stack[-1]},$1;
	if ( $control =~ /^\$STATE/ ) { print "\nDBG: - got [$control]\n\n"; }
	# Then, our control.
	if($control) {
	    if($control =~ /^loop\s*\(([^)]+)\)\s*%\{/) {
		my $ob = PDL::PP::Loop->new([split ',',$1], $sizeprivs,$this);
		print "SIZEPRIVSXX: $sizeprivs,",(join ',',%$sizeprivs),"\n" if $::PP_VERBOSE;
		push @{$stack[-1]},$ob;
		push @stack,$ob;
	    } elsif($control =~ /^types\s*\(([^)]+)\)\s*%\{/) {
		my $ob = PDL::PP::Types->new($1,$this);
		$this->{types} = 1; # thisisloop method
		push @{$stack[-1]},$ob;
		push @stack,$ob;
	    } elsif($control =~ /^threadloop\s*%\{/) {
		my $ob = PDL::PP::ThreadLoop->new;
		push @{$stack[-1]},$ob;
		push @stack,$ob;
		$threadloops ++;
	    } elsif($control =~ /^\$PP(ISBAD|ISGOOD|SETBAD)\s*\(\s*([a-zA-Z_]\w*)\s*,\s*([^)]*)\s*\)/) {
		push @{$stack[-1]},PDL::PP::PPBadAccess->new($1,$2,$3,$this);
	    } elsif($control =~ /^\$(ISBAD|ISGOOD|SETBAD)VAR\s*\(\s*([^)]*)\s*,\s*([^)]*)\s*\)/) {
		push @{$stack[-1]},PDL::PP::BadVarAccess->new($1,$2,$3,$this);
	    } elsif($control =~ /^\$(ISBAD|ISGOOD|SETBAD)\s*\(\s*\$?([a-zA-Z_]\w*)\s*\(([^)]*)\)\s*\)/) {
		push @{$stack[-1]},PDL::PP::BadAccess->new($1,$2,$3,$this);
	    } elsif($control =~ /^\$PDLSTATE(IS|SET)(BAD|GOOD)\s*\(\s*([^)]*)\s*\)/) {
		push @{$stack[-1]},PDL::PP::PDLStateBadAccess->new($1,$2,$3,$this);
	    } elsif($control =~ /^\$[a-zA-Z_]\w*\s*\([^)]*\)/) {
		push @{$stack[-1]},PDL::PP::Access->new($control,$this);
	    } elsif($control =~ /^%}/) {
		pop @stack;
	    } else {
		confess("Invalid control: $control\n");
	    }
	} else {
	    print("No \$2!\n") if $::PP_VERBOSE;
	}
    } # while: $_
    ( $threadloops, $coderef, $sizeprivs );
} # sub: separate_code()

# This is essentially a collection of regexes that look for standard code
# errors and croaks with an explanation if they are found.
sub catch_code_errors {
    my $code_string = shift;
    # Look for constructs like
    #   loop %{
    # which is invalid - you need to specify the dimension over which it
    # should loop
    report_error('Expected dimension name after "loop" and before "%{"', $1)
	    if $code_string =~ /(.*\bloop\s*%\{)/s;
}

# Report an error as precisely as possible. If they have #line directives
# in the code string, use that in the reporting; otherwise, use standard
# Carp mechanisms
my $line_re = qr/#\s*line\s+(\d+)\s+"([^"]*)"/;
sub report_error {
    my ($message, $code) = @_;
    # Just croak if they didn't supply a #line directive:
    croak($message) if $code !~ $line_re;
    # Find the line at which the error occurred:
    my $line = 0;
    my $filename;
    LINE: foreach (split /\n/, $code) {
	    $line++;
	    if (/$line_re/) {
		    $line = $1;
		    $filename = $2;
	    }
    }
    die "$message at $filename line $line\n";
}

use PDL::Types ':All';
my @ppdefs = ppdefs();
sub thisisloop {
    my ($this, $name, @extra) = @_;
    !$this->{types} ? '' : join '',
	map "#undef THISIS${name}_$_->[0]\n#define THISIS${name}_$_->[0](a)$_->[1]\n",
	(map [$_, ''], @ppdefs), map [$_->ppsym, ' a'], @extra;
}

###########################
#
# used by BadAccess code to know when to use NaN support
# - the output depends on the value of the
#   BADVAL_USENAN option in perldl.conf
#   == 1 then we use NaN's
#      0             PDL.bvals.Float/Double
#
sub convert {
    my ( $this, $name, $lhs, $rhs, $opcode, $pobj ) = @_;
    my $ftype_override = exists $this->{ftypes_vars}{$name} ? $this->{ftypes_type} : undef;
    my $type = $ftype_override || $pobj->adjusted_type($this->{Gencurtype}[-1]);
    return ($lhs, $rhs) if !($usenan * $type->usenan);
    $opcode eq "SETBAD"
	? ($lhs, "PDL->bvals.".$type->shortctype) : ("finite($lhs)", "0");
}

#####################################################################
#
# Encapsulate the parsing code objects
#
# All objects have two methods:
# 	new - constructor
#	get_str - get the string to be put into the xsub.

###########################
#
# Encapsulate a block

package PDL::PP::Block;

sub new { my($type) = @_; bless [],$type; }

sub myoffs { 0 }
sub myprelude {}
sub myitem { "" }
sub mypostlude {}

sub get_str {
    my ($this,$parent,$context) = @_;
    my $str = $this->myprelude($parent,$context);
    $str .= $this->get_str_int($parent,$context);
    $str .= $this->mypostlude($parent,$context);
    return $str;
}

sub get_str_int {
    my ( $this, $parent, $context ) = @_;

    my $nth=0;
    my $str = "";
  MYLOOP: while(1) {
      my $it = $this->myitem($parent,$nth);
      last MYLOOP if $nth and !$it;
      $str .= $it;
      $str .= (join '',map {ref $_ ? $_->get_str($parent,$context) : $_}
	       @{$this}[$this->myoffs()..$#{$this}]);
      $nth++;
  }
    return $str;
} # get_str_int()

###########################
#
# Deal with bad code
# - ie create something like
#   if ( badflag ) { badcode } else { goodcode }
#
package PDL::PP::BadSwitch;
our @ISA = "PDL::PP::Block";

sub new {
    my($type,$good,$bad) = @_;
    return bless [$good,$bad], $type;
}

sub get_str {
    my ($this,$parent,$context) = @_;
    my $good = $this->[0];
    my $bad  = $this->[1];
    my $str = PDL::PP::pp_line_numbers(__LINE__, "if ( \$PRIV(bvalflag) ) { PDL_COMMENT(\"** do 'bad' Code **\")\n");
    $str .= "\n#define PDL_BAD_CODE\n";
    $str .= $bad->get_str($parent,$context);
    $str .= "\n#undef PDL_BAD_CODE\n";
    $str .= "} else { PDL_COMMENT(\"** else do 'good' Code **\")\n";
    $str .= $good->get_str($parent,$context);
    $str .= "}\n";
    return $str;
}

###########################
#
# Encapsulate a loop

package PDL::PP::Loop;
our @ISA = "PDL::PP::Block";

sub new { my($type,$args,$sizeprivs,$parent) = @_;
	my $this = bless [$args],$type;
	for(@{$this->[0]}) {
		print "SIZP $sizeprivs, $_\n" if $::PP_VERBOSE;
		my $i = $parent->make_loopind($_);
		$sizeprivs->{$i->[0]} =
		  "register PDL_Indx __$i->[0]_size = \$PRIV(__$i->[0]_size);\n";
		print "SP :",(join ',',%$sizeprivs),"\n" if $::PP_VERBOSE;
	}
	return $this;
}

sub myoffs { return 1; }
sub myprelude { my($this,$parent,$context) = @_;
	my $text = ""; my $i;
	push @$context, map {
		$i = $parent->make_loopind($_);
# Used to be $PRIV(.._size) but now we have it in a register.
		$text .= "{PDL_COMMENT(\"Open $_\") register PDL_Indx $_;
			for($_=0; $_<(__$i->[0]_size); $_++) {";
		$i;
	} @{$this->[0]};
	return PDL::PP::pp_line_numbers(__LINE__, $text);
}
sub mypostlude { my($this,$parent,$context) = @_;
	splice @$context, - ($#{$this->[0]}+1);
	return join '',map {"}} PDL_COMMENT(\"Close $_\")"} @{$this->[0]};
}

###########################
#
# Encapsulate a generic type loop
#
# we use the value of $parent->{types}
# to determine whether to define/undefine the THISISxxx macros
# (makes the xs code easier to read)
#
package PDL::PP::GenericLoop;
our @ISA = "PDL::PP::Block";

# make the typetable from info in PDL::Types
use PDL::Types ':All';
my @typetable = map [$_->ppsym, $_], types();
sub get_generictyperecs { my($types) = @_;
    my %wanted; @wanted{@$types} = ();
    [ map $_->[1], grep exists $wanted{$_->[0]}, @typetable ];
}

# Types: BSULFD
sub new {
    my ($type,$types,$name,$varnames,$whattype) = @_;
    my %vars; @vars{@$varnames} = ();
    bless [get_generictyperecs($types), $name, \%vars, $whattype], $type;
}

sub myoffs {4}

sub myprelude {
    my ($this,$parent,$context) = @_;
    push @{$parent->{Gencurtype}}, undef; # so that $GENERIC can get at it
    die "ERROR: need to rethink NaN support in GenericLoop\n"
	if defined $this->[1] and $parent->{ftypes_type};
    <<WARNING_EATER;
PDL_COMMENT("Start generic loop")
@{[$parent->thisisloop($this->[1])]}
	switch($this->[3]) { case -42: PDL_COMMENT("Warning eater") {(void)1;
WARNING_EATER
}

sub myitem {
    my ($this,$parent,$nth) = @_;
    my $item = $this->[0]->[$nth] || return "";
    $parent->{Gencurtype}[-1] = $item;
    @$parent{qw(ftypes_type ftypes_vars)} = ($item, $this->[2]) if defined $this->[1];
    PDL::PP::pp_line_numbers(__LINE__, join '',
	"\t} break; case @{[$item->sym]}: {\n",
	$parent->thisisloop($this->[1], $item),
	map $parent->{ParObjs}{$_}->get_xsdatapdecl($item),
	    sort keys %{$this->[2]});
}

sub mypostlude {
    my($this,$parent,$context) = @_;
    pop @{$parent->{Gencurtype}};  # and clean up the Gentype stack
    $parent->{ftypes_type} = undef if defined $this->[1];
    "\tbreak;}
	default:barf(\"PP INTERNAL ERROR! PLEASE MAKE A BUG REPORT\\n\");}\n";
}


package PDL::PP::SimpleThreadLoop;
use Carp;
our @ISA = "PDL::PP::Block";
our @CARP_NOT;

sub new { my($type) = @_; bless [],$type; }
sub myoffs { return 0; }
sub myprelude {my($this,$parent,$context) = @_;
 my $no;
 my ($ord,$pdls) = $parent->get_pdls();
PDL::PP::pp_line_numbers(__LINE__, '	PDL_COMMENT("THREADLOOPBEGIN")
 if(PDL->startthreadloop(&($PRIV(__pdlthread)),$PRIV(vtable)->readdata,
 	__privtrans))) return;
   do {
 '.(join '',map {"${_}_datap += \$PRIV(__pdlthread).offs[".(0+$no++)."];\n"}
 		@$ord).'
');
}

sub mypostlude {my($this,$parent,$context) = @_;
 my $no;
 my ($ord,$pdls) = $parent->get_pdls();
'	PDL_COMMENT("THREADLOOPEND")
 '.(join '',map {"${_}_datap -= \$PRIV(__pdlthread).offs[".(0+$no++)."];\n"}
 		@$ord).'
      } while(PDL->iterthreadloop(&$PRIV(__pdlthread),0));
 '
}

####
#
# This relies on PP.pm making sure that initthreadloop always sets
# up the two first dimensions even when they are not necessary.
#
package PDL::PP::ThreadLoop;
use Carp;
our @ISA = "PDL::PP::Block";
our @CARP_NOT;


sub new {
	my $type   = shift;
	bless [],$type;
}
sub myoffs { return 0; }
sub myprelude {
    my($this,$parent,$context, $backcode) = @_;

    #  Set appropriate function from the vtable to supply to threadthreadloop.
    #    Function name from the vtable is readdata for normal code
    #    function name for backcode is writebackdata
    my $funcName = "readdata";
    $funcName = "writebackdata" if( $backcode );

    my ($ord,$pdls) = $parent->get_pdls();

    my $str = '';
    my $loop_key = "emitted_startthreadloop_$funcName";
    my $macro_name = "PDL_STARTTHREADLOOP_$parent->{Name}_$funcName";
    if (!$parent->{$loop_key}) {
	$parent->{$loop_key} = 1;
	$str .= PDL::PP::pp_line_numbers(__LINE__, join " \\\n\t",
	  "#define $macro_name",
	  'if ( PDL->startthreadloop(&($PRIV(__pdlthread)),$PRIV(vtable)->'.$funcName.', __tr) ) return; \
	   do { register PDL_Indx __tind1=0,__tind2=0; \
		register PDL_Indx __tnpdls = $PRIV(__pdlthread).npdls; \
		register PDL_Indx __tdims1 = $PRIV(__pdlthread.dims[1]); \
		register PDL_Indx __tdims0 = $PRIV(__pdlthread.dims[0]); \
		register PDL_Indx *__offsp = PDL->get_threadoffsp(&$PRIV(__pdlthread));',
	  ( map { "register PDL_Indx __tinc0_${_} = \$PRIV(__pdlthread).incs[${_}];"} 0..$#{$ord}),
	  ( map { "register PDL_Indx __tinc1_${_} = \$PRIV(__pdlthread).incs[__tnpdls+$_];"} 0.. $#{$ord}),
	  ( map { $ord->[$_] ."_datap += __offsp[$_];"} 0..$#{$ord} ),
	  'for( __tind2 = 0 ; \
		__tind2 < __tdims1 ; \
		__tind2++',
		( map { "\t\t," . $ord->[$_] . "_datap += __tinc1_${_} - __tinc0_${_} * __tdims0"} 0..$#{$ord} ),
	     ')',
	  '{ \
	     for( __tind1 = 0 ; \
		  __tind1 < __tdims0 ; \
		  __tind1++',
		  ( map { "\t\t," . $ord->[$_] . "_datap += __tinc0_${_}"} 0..$#{$ord}),
	       ") {",
	  "PDL_COMMENT(\"This is the tightest threadloop. Make sure inside is optimal.\")\n\n",
	);
    }
    $str . $macro_name;
}

# Should possibly fold out thread.dims[0] and [1].
sub mypostlude {my($this,$parent,$context) = @_;
    my ($ord,$pdls) = $parent->get_pdls();
    my $loop_key = "emitted_endthreadloop";
    my $macro_name = "PDL_ENDTHREADLOOP_$parent->{Name}";
    my $str = '';
    if (!$parent->{$loop_key}) {
	$parent->{$loop_key} = 1;
	$str .= PDL::PP::pp_line_numbers(__LINE__, join " \\\n\t",
	    "\n#define $macro_name",
	    '}',
	    '}',
	    ( map { $ord->[$_] . "_datap -= __tinc1_${_} * __tdims1 + __offsp[${_}];"} 0..$#{$ord} ),
	    '} while(PDL->iterthreadloop(&$PRIV(__pdlthread),2));'."\n",
	    );
    }
    $str . $macro_name;
}

# Simple subclass of ThreadLoop to implement writeback code
#
#
package PDL::PP::BackCodeThreadLoop;
use Carp;
our @ISA = "PDL::PP::ThreadLoop";
our @CARP_NOT;

sub myprelude {
    my($this,$parent,$context, $backcode) = @_;

    # Set backcode flag if not defined. This will make the parent
    #   myprelude emit proper writeback code
    $backcode = 1 unless defined($backcode);

    $this->SUPER::myprelude($parent, $context, $backcode);
}


###########################
#
# Encapsulate a types() switch
#
package PDL::PP::Types;
use Carp;
use PDL::Types ':All';
our @ISA = "PDL::PP::Block";
our @CARP_NOT;
my $types = join '', ppdefs; # BSUL....

sub new {
    my($type,$ts,$parent) = @_;
    $ts =~ /[$types]+/ or confess "Invalid type access with '$ts'!";
    bless [$ts],$type; }
sub myoffs { return 1; }
sub myprelude {
    my($this,$parent,$context) = @_;
    return "\n#if ". (join '||',map {"(THISIS_$_(1)+0)"} split '',$this->[0])."\n";
}

sub mypostlude {my($this,$parent,$context) = @_;
	"\n#endif\n"
}


###########################
#
# Encapsulate an access

package PDL::PP::Access;
use Carp;
our @CARP_NOT;

sub new { my($type,$str,$parent) = @_;
    $str =~ /^\$([a-zA-Z_]\w*)\s*\(([^)]*)\)/ or
	    confess ("Access wrong: '$str'\n");
    my($pdl,$inds) = ($1,$2);
    if($pdl =~ /^T/) {PDL::PP::MacroAccess->new($pdl,$inds,
			   $parent->{Generictypes},$parent->{Name});}
    elsif($pdl =~ /^P$/) {PDL::PP::PointerAccess->new($pdl,$inds);}
    elsif($pdl =~ /^PP$/) {PDL::PP::PhysPointerAccess->new($pdl,$inds);}
    elsif($pdl =~ /^SIZE$/) {PDL::PP::SizeAccess->new($pdl,$inds);}
    elsif($pdl =~ /^RESIZE$/) {PDL::PP::ReSizeAccess->new($pdl,$inds);}
    elsif($pdl =~ /^GENERIC$/) {PDL::PP::GentypeAccess->new($pdl,$inds);}
    elsif($pdl =~ /^PDL$/) {PDL::PP::PdlAccess->new($pdl,$inds);}
    elsif(!defined $parent->{ParObjs}{$pdl}) {PDL::PP::OtherAccess->new($pdl,$inds);}
    else {
	bless [$pdl,$inds],$type;
    }
}

sub get_str { my($this,$parent,$context) = @_;
    $parent->{ParObjs}{$this->[0]}->do_access($this->[1],$context)
	if defined($parent->{ParObjs}{$this->[0]});
}

###########################
#
# Just some other substituted thing.

package PDL::PP::OtherAccess;
sub new { my($type,$pdl,$inds) = @_; bless [$pdl,$inds],$type; }
sub get_str {my($this) = @_;return "\$$this->[0]($this->[1])"}

###########################
#
# Encapsulate a check on whether a value is good or bad
# handles both checking (good/bad) and setting (bad)
#
# Integer types (BSUL) + floating point when no NaN (FD)
#   $ISBAD($a(n))  -> $a(n) == a_badval
#   $ISGOOD($a())     $a()  != a_badval
#   $SETBAD($a())     $a()   = a_badval
#
# floating point with NaN
#   $ISBAD($a(n))  -> finite($a(n)) == 0
#   $ISGOOD($a())     finite($a())  != 0
#   $SETBAD($a())     $a()           = PDL->bvals.Float (or .Double)
#
# I've also got it so that the $ on the pdl name is not
# necessary - so $ISBAD(a(n)) is also accepted, so as to reduce the
# amount of line noise. This is actually done by the regexp
# in the separate_code() sub at the end of the file.
#
# note:
#   we also expand out $a(n) etc as well here
#
# To do:
#   need to allow use of F,D without NaN
#

package PDL::PP::BadAccess;
use Carp;
our @CARP_NOT;

sub new {
    my ( $type, $opcode, $name, $inds, $parent ) = @_;

    # trying to avoid auto creation of hash elements
    my $check = $parent->{ParObjs};
    die "\nIt looks like you have tried a \$${opcode}() macro on an\n" .
	"  unknown piddle <$name($inds)>\n"
	unless exists($check->{$name}) and defined($check->{$name});

    return bless [$opcode, $name, $inds], $type;
}

our %ops = ( ISBAD => '==', ISGOOD => '!=', SETBAD => '=' );

sub get_str {
    my($this,$parent,$context) = @_;

    my $opcode = $this->[0];
    my $name   = $this->[1];
    my $inds   = $this->[2];

    print "PDL::PP::BadAccess sent [$opcode] [$name] [$inds]\n" if $::PP_VERBOSE;

    my $op = $ops{$opcode};
    die "ERROR: unknown check <$opcode> sent to PDL::PP::BadAccess\n"
	unless defined $op;

    my $obj = $parent->{ParObjs}{$name};
    die "ERROR: something screwy in PDL::PP::BadAccess (PP/PDLCode.pm)\n"
	unless defined( $obj );

    my ( $lhs, $rhs ) = $parent->convert(
	$name, $obj->do_access($inds,$context), "${name}_badval", $opcode, $obj
    );

    print "DBG:  [$lhs $op $rhs]\n" if $::PP_VERBOSE;
    return "$lhs $op $rhs";
}


###########################
#
# Encapsulate a check on whether a value is good or bad
# handles both checking (good/bad) and setting (bad)
#
# Integer types (BSUL) + floating point when no NaN (FD)
#   $ISBADVAR(foo,a)  -> foo == a_badval
#   $ISGOODVAR(foo,a)    foo != a_badval
#   $SETBADVAR(foo,a)    foo  = a_badval
#
# floating point with NaN
#   $ISBADVAR(foo,a)  -> finite(foo) == 0
#   $ISGOODVAR(foo,a)    finite(foo) != 0
#   $SETBADVAR(foo,a)    foo          = PDL->bvals.Float (or .Double)
#

package PDL::PP::BadVarAccess;
use Carp;
our @CARP_NOT;

sub new {
    my ( $type, $opcode, $var_name, $name, $parent ) = @_;

    # trying to avoid auto creation of hash elements
    my $check = $parent->{ParObjs};
    die "\nIt looks like you have tried a \$${opcode}() macro on an\n" .
	"  unknown piddle <$name>\n"
	unless exists($check->{$name}) and defined($check->{$name});

    bless [$opcode, $var_name, $name], $type;
}

our %ops = ( ISBAD => '==', ISGOOD => '!=', SETBAD => '=' );

sub get_str {
    my($this,$parent,$context) = @_;

    my $opcode   = $this->[0];
    my $var_name = $this->[1];
    my $name = $this->[2];

    print "PDL::PP::BadVarAccess sent [$opcode] [$var_name] [$name]\n" if $::PP_VERBOSE;

    my $op = $ops{$opcode};
    die "ERROR: unknown check <$opcode> sent to PDL::PP::BadVarAccess\n"
	unless defined $op;

    my $obj = $parent->{ParObjs}{$name};
    die "ERROR: something screwy in PDL::PP::BadVarAccess (PP/PDLCode.pm)\n"
	unless defined( $obj );

    my ( $lhs, $rhs ) = $parent->convert(
	$name, $var_name, "${name}_badval", $opcode, $obj
    );

    print "DBG:  [$lhs $op $rhs]\n" if $::PP_VERBOSE;
    return "$lhs $op $rhs";
}


###########################
#
# Encapsulate a check on whether a value is good or bad using PP
# handles both checking (good/bad) and setting (bad)

# this is only an initial attempt - it will, almost certainly,
# need more work as more code is converted to handle bad values
#
# currently it can only handle cases like
#  $PPISBAD(PARENT,[i])  -> PARENT_physdatap[i] == PARENT_badval
#  etc
#
# if we use NaN's, then
#  $PPISBAD(PARENT,[i])   -> finite(PARENT_physdatap[i]) == 0
#  $PPISGOOD(PARENT,[i])  -> finite(PARENT_physdatap[i]) != 0
#  $PPSETBAD(PARENT,[i])  -> PARENT_physdatap[i]          = PDL->bvals.Float (or .Double)
#

package PDL::PP::PPBadAccess;
use Carp;
our @CARP_NOT;

sub new {
    my ( $type, $opcode, $name, $inds, $parent ) = @_;

    $opcode =~ s/^PP//;
    bless [$opcode, $name, $inds], $type;
}

# PP is stripped in new()
our %ops = ( ISBAD => '==', ISGOOD => '!=', SETBAD => '=' );

sub get_str {
    my($this,$parent,$context) = @_;

    my $opcode = $this->[0];
    my $name   = $this->[1];
    my $inds   = $this->[2];

    print "PDL::PP::PPBadAccess sent [$opcode] [$name] [$inds]\n" if $::PP_VERBOSE;

    my $op = $ops{$opcode};
    die "\nERROR: unknown check <$opcode> sent to PDL::PP::PPBadAccess\n"
	unless defined $op;

    my $obj = $parent->{ParObjs}{$name};
    die "\nERROR: ParObjs does not seem to exist for <$name> = problem in PDL::PP::PPBadAccess\n"
	unless defined $obj;

    my ( $lhs, $rhs ) = $parent->convert(
	$name, $obj->do_physpointeraccess() . "$inds", "${name}_badval", $opcode, $obj
    );

    print "DBG:  [$lhs $op $rhs]\n" if $::PP_VERBOSE;
    return "$lhs $op $rhs";
}


###########################
#
# Encapsulate a check on whether the state flag of a piddle
# is set/change this state
#
# $PDLSTATEISBAD(a)    ->  ($PDL(a)->state & PDL_BADVAL) > 0
# $PDLSTATEISGOOD(a)   ->  ($PDL(a)->state & PDL_BADVAL) == 0
#
# $PDLSTATESETBAD(a)   ->  ($PDL(a)->state |= PDL_BADVAL)
# $PDLSTATESETGOOD(a)  ->  ($PDL(a)->state &= ~PDL_BADVAL)
#

package PDL::PP::PDLStateBadAccess;
use Carp;
our @CARP_NOT;

sub new {
    my ( $type, $op, $val, $name, $parent ) = @_;

    # $op  is one of: IS SET
    # $val is one of: GOOD BAD

    # trying to avoid auto creation of hash elements
    my $check = $parent->{ParObjs};
    die "\nIt looks like you have tried a \$PDLSTATE${op}${val}() macro on an\n" .
	"  unknown piddle <$name>\n"
	unless exists($check->{$name}) and defined($check->{$name});

    bless [$op, $val, $name], $type;
}

our %ops  = (
	     IS  => { GOOD => '== 0', BAD => '> 0' },
	     SET => { GOOD => '&= ~', BAD => '|= ' },
	     );

sub get_str {
    my($this,$parent,$context) = @_;

    my $op   = $this->[0];
    my $val  = $this->[1];
    my $name = $this->[2];

    print "PDL::PP::PDLStateBadAccess sent [$op] [$val] [$name]\n" if $::PP_VERBOSE;

    my $opcode = $ops{$op}{$val};
    my $type = $op . $val;
    die "ERROR: unknown check <$type> sent to PDL::PP::PDLStateBadAccess\n"
	unless defined $opcode;

    my $obj = $parent->{ParObjs}{$name};
    die "\nERROR: ParObjs does not seem to exist for <$name> = problem in PDL::PP::PDLStateBadAccess\n"
	unless defined $obj;

    my $state = $obj->do_pdlaccess() . "->state";

    my $str;
    if ( $op eq 'IS' ) {
	$str = "($state & PDL_BADVAL) $opcode";
    } elsif ( $op eq 'SET' ) {
	$str = "$state ${opcode}PDL_BADVAL";
    }

    print "DBG:  [$str]\n" if $::PP_VERBOSE;
    return $str;
}


###########################
#
# Encapsulate a Pointeraccess

package PDL::PP::PointerAccess;
use Carp;
our @CARP_NOT;

sub new { my($type,$pdl,$inds) = @_; bless [$inds],$type; }

sub get_str {my($this,$parent,$context) = @_;
	croak ("can't access undefined pdl ".$this->[0])
	  unless defined($parent->{ParObjs}{$this->[0]});
#	$parent->{ParObjs}{$this->[0]}->{FlagPaccess} = 1;
	$parent->{ParObjs}{$this->[0]}->{FlagPhys} = 1;
	$parent->{ParObjs}{$this->[0]}->do_pointeraccess();
}


###########################
#
# Encapsulate a PhysPointeraccess

package PDL::PP::PhysPointerAccess;
use Carp;
our @CARP_NOT;

sub new { my($type,$pdl,$inds) = @_; bless [$inds],$type; }

sub get_str {my($this,$parent,$context) = @_;
	$parent->{ParObjs}{$this->[0]}->do_physpointeraccess()
	 if defined($parent->{ParObjs}{$this->[0]});
}

###########################
#
# Encapsulate a PDLaccess

package PDL::PP::PdlAccess;
use Carp;
our @CARP_NOT;

sub new { my($type,$pdl,$inds) = @_; bless [$inds],$type; }

sub get_str {my($this,$parent,$context) = @_;
	croak ("can't access undefined pdl ".$this->[0])
	  unless defined($parent->{ParObjs}{$this->[0]});
	$parent->{ParObjs}{$this->[0]}->do_pdlaccess();
}

###########################
#
# Encapsulate a macroaccess

package PDL::PP::MacroAccess;
use Carp;
use PDL::Types ':All';
my $types = join '',ppdefs;
our @CARP_NOT;

sub new {
    my ($type, $pdl, $inds, $gentypes, $name) = @_;
    $pdl =~ /^\s*T([A-Z]+)\s*$/
      or confess("Macroaccess wrong in $name (allowed types $types): was '$pdl'\n");
    my @ilst = split '', $1;
    my @lst = split ',', $inds, -1;
    confess "Macroaccess: different nos of args $pdl $inds\n" if @lst != @ilst;
    my %type2value; @type2value{@ilst} = @lst;
    warn "$name has no Macro for generic type $_ (has $pdl)\n"
	for grep !exists $type2value{$_}, @$gentypes;
    my %gts; @gts{@$gentypes} = ();
    warn "Macro for unsupported generic type identifier $_\n"
	for grep !exists $gts{$_}, @ilst;
    bless [\%type2value, $name], $type;
}

sub get_str {
    my ($this, $parent, $context) = @_;
    my ($type2value, $name) = @{$this};
    confess "generic type access outside a generic loop in $name"
      unless defined $parent->{Gencurtype}[-1];
    $type2value->{$parent->{Gencurtype}[-1]->ppsym};
}


###########################
#
# Encapsulate a SizeAccess

package PDL::PP::SizeAccess;
use Carp;
our @CARP_NOT;

sub new { my($type,$pdl,$inds) = @_; bless [$inds],$type; }

sub get_str {my($this,$parent,$context) = @_;
	croak "can't get SIZE of undefined dimension $this->[0]"
	  unless defined($parent->{IndObjs}{$this->[0]});
	$parent->{IndObjs}{$this->[0]}->get_size();
}

###########################
#
# Encapsulate a ReSizeAccess

package PDL::PP::ReSizeAccess;
use Carp;
our @CARP_NOT;

sub new { my($type,$pdl,$inds) = @_; bless [$inds],$type; }

sub get_str {my($this,$parent,$context) = @_;
	$this->[0] =~ /^([^,]+),([^,]+)$/ or
		croak "Can't interpret resize str $this->[0]";
	croak "can't RESIZE undefined dimension $1"
	  unless defined($parent->{IndObjs}{$1});

	my $s = $parent->{IndObjs}{$1}->get_size();

# XXX NOTE: All piddles must be output piddles, there must not be
# a loop over this var (at all!) etc. Should check for these,
# this is why not yet documented.
# FURTHER NOTE: RESIZE DOESN'T COPY DATA PROPERLY!

	my($ord,$pdls) = $parent->get_pdls();
	my @p;

	for(@$ord) {
		push @p, $_
			if $pdls->{$_}->has_dim($1);
	}
	print "RESIZEACC: $1 $2, (",(join ',',@p),")\n";
	warn "RESIZE USED: DO YOU KNOW WHAT YOU ARE DOING???\n";

	return "$s = $2; ".(join '',map {$pdls->{$_}->do_resize($1,$2)} @p);
}


###########################
#
# Encapsulate a GentypeAccess

package PDL::PP::GentypeAccess;
use Carp;
our @CARP_NOT;

sub new { my($type,$pdl,$inds) = @_; bless [$inds],$type; }

sub get_str {my($this,$parent,$context) = @_;
  croak "generic type access outside a generic loop"
    unless defined(my $type = $parent->{Gencurtype}[-1]);
  return $type->ctype if !$this->[0];
  my $pobj = $parent->{ParObjs}{$this->[0]} // croak "not a defined parname";
  $pobj->adjusted_type($type)->ctype;
}

########################
#
# Type coercion
#
# Now, if TYPES:F given and double arguments, will coerce.

package PDL::PP::TypeConv;

sub print_xscoerce { my($this) = @_;
	$this->printxs("\t__priv->datatype=PDL_B;\n");
# First, go through all the types, selecting the most general.
	for(@{$this->{PdlOrder}}) {
		$this->printxs($this->{Pdls}{$_}->get_xsdatatypetest());
	}
# See which types we are allowed to use.
	$this->printxs("\tif(0) {}\n");
	for(@{$this->get_generictypes()}) {
		$this->printxs("\telse if(__priv->datatype <= $_->[2]) __priv->datatype = $_->[2];\n");
	}
	$this->{Types} =~ /F/ and (
		$this->printxs("\telse if(__priv->datatype == PDL_D) {__priv->datatype = PDL_F; PDL_COMMENT(\"Cast double to float\")}\n"));
	$this->printxs(qq[\telse {croak("Too high type \%d given!\\n",__priv->datatype);}]);
# Then, coerce everything to this type.
	for(@{$this->{PdlOrder}}) {
		$this->printxs($this->{Pdls}{$_}->get_xscoerce());
	}
}
# XXX Should use PDL::Core::Dev;

# return true
1;

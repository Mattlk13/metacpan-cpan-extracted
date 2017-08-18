#!/usr/bin/perl

package App::Music::ChordPro::Songbook;

use strict;
use warnings;

use App::Music::ChordPro::Chords;

use Encode qw(decode encode);
use Carp;

sub new {
    my ($pkg) = @_;
    bless { songs => [ App::Music::ChordPro::Song->new ] }, $pkg;
}

# Parser context.
my $def_context = "";
my $in_context = $def_context;
my $grid_arg;
my $grid_cells;

# Local transposition.
my $xpose;

# Chord type for this song, used to detect mixing types.
my $chordtype;

# Used chords, in order of appearance.
my @used_chords;

# Keep track of unknown chords, to avoid dup warnings.
my %warned_chords;

my $re_meta;

my $diag;			# for diagnostics

sub parsefile {
    my ( $self, $filename, $options ) = @_;

    my $fh;
    if ( ref($filename) ) {
	my $data = encode("UTF-8", $$filename);
	$filename = "__STRING__";
	open($fh, '<', \$data)
	  or croak("$filename: $!\n");
    }
    else {
	open($fh, '<', $filename)
	  or croak("$filename: $!\n");
    }

    push( @{ $self->{songs} }, App::Music::ChordPro::Song->new )
      if exists($self->{songs}->[-1]->{body});
    $self->{songs}->[-1]->{structure} = "linear";
    $xpose = 0;
    $grid_arg = '1+4x4+1';
    $in_context = $def_context;
    @used_chords = ();
    %warned_chords = ();
    App::Music::ChordPro::Chords::reset_song_chords();
    $diag->{format} = $options->{diagformat}
      || $::config->{diagnostics}->{format};
    $diag->{file} = $filename;

    # Build regex for the known metadata items.
    if ( $::config->{metadata}->{keys} ) {
	$re_meta = '^(' .
	  join( '|', map { quotemeta } @{$::config->{metadata}->{keys}} )
	    . ')$';
	$re_meta = qr/$re_meta/;
    }
    else {
	undef $re_meta;
    }

    while ( <$fh> ) {
	s/[\r\n]+$//;
	$diag->{line} = $.;

	my $line;
	if ( $options->{encoding} ) {
	    $line = decode( $options->{encoding}, $_, 1 );
	}
	else {
	    eval { $line = decode( "UTF-8", $_, 1 ) };
	    $line = decode( "iso-8859-1", $_ ) if $@;
	}
	$diag->{orig} = $_ = $line;

	if ( /^#/ ) {
	    # Collect pre-title stuff separately.
	    if ( exists $self->{songs}->[-1]->{title} ) {
		$self->add( type => "ignore", text => $line );
	    }
	    else {
		push( @{ $self->{songs}->[-1]->{preamble} }, $line );
	    }
	    next;
	}

	# For practical reasons: a prime should always be an apostroph.
	s/'/\x{2019}/g;

	# For now, directives should go on their own lines.
	if ( /^\s*\{(.*)\}\s*$/ ) {
	    $options->{_legacy}
	      ? $self->global_directive( $1, 1 )
	      : $self->directive($1);
	    next;
	}

	if ( $in_context eq "tab" ) {
	    $self->add( type => "tabline", text => $_ );
	    next;
	}

	if ( $in_context eq "grid" ) {
	    $self->add( type => "gridline", $self->decompose_grid($_) );
	    next;
	}

	if ( /\S/ ) {
	    $self->add( type => "songline", $self->decompose($_) );
	}
	elsif ( exists $self->{songs}->[-1]->{title} ) {
	    $self->add( type => "empty" );
	}
	else {
	    # Collect pre-title stuff separately.
	    push( @{ $self->{songs}->[-1]->{preamble} }, $line );
	}
    }
    do_warn("Unterminated context in song: $in_context")
      if $in_context;

    my $diagrams;
    if ( exists($self->{songs}->[-1]->{settings}->{diagrams} ) ) {
	$diagrams = $self->{songs}->[-1]->{settings}->{diagrams};
	$diagrams &&= $::config->{diagrams}->{show} || "all";
    }
    else {
	$diagrams = $::config->{diagrams}->{show};
    }

    if ( $diagrams =~ /^(user|all)$/
	 && defined($chordtype)
	 && $chordtype =~ /^[RN]$/ ) {
	$diag->{orig} = "(End of Song)";
	do_warn("Chord diagrams suppressed for Nasville/Roman chords");
	$diagrams = "none";
    }

    if ( $diagrams =~ /^(user|all)$/ ) {
	my %h;
	@used_chords = map { $h{$_}++ ? () : $_ } @used_chords;

	if ( $diagrams eq "user" ) {
	    @used_chords =
	    grep { safe_chord_info($_)->{origin} == 1 } @used_chords;
	}

	if ( $::config->{diagrams}->{sorted} ) {
	    @used_chords =
	      sort App::Music::ChordPro::Chords::chordcompare @used_chords;
	}

	$self->add( type   => "diagrams",
		    origin => "song",
		    show   => $diagrams,
		    chords => [ @used_chords ] );
    }

    # Global transposition.
    if ( $options->{transpose} ) {
	$self->{songs}->[-1]->transpose( $options->{transpose} );
    }

    # $self->{songs}->[-1]->structurize;

    return 1;
}

sub add {
    my $self = shift;
    push( @{$self->{songs}->[-1]->{body}},
	  { context => $in_context,
	    @_ } );
}

sub chord {
    my ( $self, $c ) = @_;
    return $c unless length($c);
    my $parens = $c =~ s/^\((.*)\)$/$1/;

    my $info = App::Music::ChordPro::Chords::identify($c);
    if ( $info->{system} ) {
	if ( defined $chordtype ) {
	    if ( $chordtype ne $info->{system} ) {
		$chordtype = $info->{system};
		do_warn("Mixed chord systems detected in song");
	    }
	}
	else {
	    $chordtype = $info->{system};
	}
    }
    elsif ( $info->{warning} && ! $warned_chords{$c}++ ) {
	do_warn("Mysterious chord: $c")
	  unless $c =~ /^n\.?c\.?$/i;
    }
    elsif ( $info->{error} && ! $warned_chords{$c}++ ) {
	do_warn("Unrecognizable chord: $c")
	  unless $c =~ /^n\.?c\.?$/i;
    }

    # Local transpose, if requested.
    if ( $xpose ) {
	$_ = App::Music::ChordPro::Chords::transpose( $c, $xpose )
	  and
	    $c = $_;
    }

    push( @used_chords, $c );

    return $parens ? "($c)" : $c;
}

sub safe_chord_info {
    my ( $chord ) = @_;
    my $info = App::Music::ChordPro::Chords::chord_info($chord);
    $info->{origin} //= 1;
    return $info;
}

sub cxpose {
    my ( $self, $t ) = @_;
    $t =~ s/\[(.+?)\]/$self->chord($1)/ge;
    return $t;
}

sub decompose {
    my ($self, $line) = @_;
    $line =~ s/\s+$//;
    my @a = split(/(\[.*?\])/, $line, -1);

    die(msg("Illegal line")."\n") unless @a; #### TODO

    if ( @a == 1 ) {
	return ( phrases => [ $line ] );
    }

    shift(@a) if $a[0] eq "";
    unshift(@a, '[]') if $a[0] !~ /^\[/;


    my @phrases;
    my @chords;
    while ( @a ) {
	my $t = shift(@a);
	$t =~ s/^\[(.*)\]$/$1/;
	push(@chords, $self->chord($t));
	push(@phrases, shift(@a));
    }

    return ( phrases => \@phrases, chords  => \@chords );
}

sub cdecompose {
    my ( $self, $line ) = @_;
    my %res = $self->decompose($line);
    return ( text => $line ) unless $res{chords};
    return %res;
}

sub decompose_grid {
    my ($self, $line) = @_;
    $line =~ s/^\s+//;
    $line =~ s/\s+$//;
    return ( tokens => [] ) if $line eq "";

    my $orig;
    my %res;
    if ( $line !~ /\|/ ) {
	$res{margin} = { $self->cdecompose($line), orig => $line };
	$line = "";
    }
    else {
	if ( $line =~ /(.*\|\S*)\s([^\|]*)$/ ) {
	    $line = $1;
	    $res{comment} = { $self->cdecompose($2), orig => $2 };
	    do_warn( "No margin cell for trailing comment" )
	      unless $grid_cells->[2];
	}
	if ( $line =~ /^([^|]+?)\s*(\|.*)/ ) {
	    $line = $2;
	    $res{margin} = { $self->cdecompose($1), orig => $1 };
	    do_warn( "No cell for margin text" )
	      unless $grid_cells->[1];
	}
    }

    my @tokens = split( ' ', $line );
    my $nbt;			# non-bar tokens
    foreach ( @tokens ) {
	if ( $_ eq "|:" || $_ eq "{" ) {
	    $_ = { symbol => $_, class => "bar" };
	}
	elsif ( $_ eq ":|" || $_ eq "}" ) {
	    $_ = { symbol => $_, class => "bar" };
	}
	elsif ( $_ eq ":|:" || $_ eq "}{" ) {
	    $_ = { symbol => $_, class => "bar" };
	}
	elsif ( $_ eq "|" ) {
	    $_ = { symbol => $_, class => "bar" };
	}
	elsif ( $_ eq "||" ) {
	    $_ = { symbol => $_, class => "bar" };
	}
	elsif ( $_ eq "|." ) {
	    $_ = { symbol => $_, class => "bar" };
	}
	elsif ( $_ eq "%" ) {
	    $_ = { symbol => $_, class => "repeat1" };
	}
	elsif ( $_ eq '%%' ) {
	    $_ = { symbol => $_, class => "repeat2" };
	}
	elsif ( $_ eq "." ) {
	    $_ = { symbol => $_, class => "space" };
	    $nbt++;
	}
	else {
	    $_ = { chord => $self->chord($_), class => "chord" };
	    $nbt++;
	}
    }
    if ( $nbt > $grid_cells->[0] ) {
	do_warn( "Too few cells for grid content" );
    }
    return ( tokens => \@tokens, %res );
}

sub dir_split {
    my ( $d ) = @_;
    $d =~ s/^[: ]+//;
    $d =~ s/\s+$//;
    my $dir = lc($d);
    my $arg = "";
    if ( $d =~ /^(.*?)[: ]\s*(.*)/ ) {
	( $dir, $arg ) = ( lc($1), $2 );
    }
    $dir =~ s/[: ]+$//;
    ( $dir, $arg );
}

sub directive {
    my ($self, $d) = @_;
    my ( $dir, $arg ) = dir_split($d);

    # Context flags.

    if    ( $dir eq "soc" ) { $dir = "start_of_chorus" }
    elsif ( $dir eq "sot" ) { $dir = "start_of_tab"    }
    elsif ( $dir eq "eoc" ) { $dir = "end_of_chorus"   }
    elsif ( $dir eq "eot" ) { $dir = "end_of_tab"      }

    if ( $dir =~ /^start_of_(\w+)$/ ) {
	do_warn("Already in " . ucfirst($in_context) . " context\n")
	  if $in_context;
	$in_context = $1;
	$arg = $grid_arg if $in_context eq "grid" && $arg eq "";
	if ( $in_context eq "grid" && $arg &&
	     $arg =~ m/^
		       (?: (\d+) \+)?
		       (\d+) (?: x (\d+) )?
		       (?:\+ (\d+) )?
		       $/x ) {
	    do_warn("Invalid grid params: $arg (must be non-zero)"), return
	      unless $2;
	    $self->add( type => "set",
			name => "gridparams",
			value => [ $2, $3, $1, $4 ] );
	    $grid_arg = $arg;
	    $grid_cells = [ $2 * ( $3//1 ), ($1//0), ($4//0) ];
	}
	else {
	    do_warn("Garbage in start_of_$1: $arg (ignored)\n")
	      if $arg;
	}
	return;
    }
    if ( $dir =~ /^end_of_(\w+)$/ ) {
	do_warn("Not in " . ucfirst($1) . " context\n")
	  unless $in_context eq $1;
	$in_context = $def_context;
	return;
    }
    if ( $dir =~ /^chorus$/i ) {
	if ( $in_context ) {
	    do_warn("{chorus} encountered while in $in_context context -- ignored\n");
	    return;
	}
	$self->add( type => "rechorus" );
	return;
    }

    # Song settings.

    my $cur = $self->{songs}->[-1];

    # Breaks.

    if ( $dir =~ /^(?:colb|column_break)$/i ) {
	$self->add( type => "colb" );
	return;
    }

    if ( $dir =~ /^(?:new_page|np|new_physical_page|npp)$/i ) {
	$self->add( type => "newpage" );
	return;
    }

    if ( $dir =~ /^(?:new_song|ns)$/i ) {
	return unless $self->{songs}->[-1]->{body};
	push(@{$self->{songs}}, App::Music::ChordPro::Song->new );
	return;
    }

    # Comments. Strictly speaking they do not belong here.

    if ( $dir =~ /^(?:comment|c|highlight)$/ ) {
	$self->add( type => "comment", $self->cdecompose($arg),
		    orig => $arg );
	return;
    }

    if ( $dir =~ /^(?:comment_italic|ci)$/ ) {
	$self->add( type => "comment_italic", $self->cdecompose($arg),
		    orig => $arg );
	return;
    }

    if ( $dir =~ /^(?:comment_box|cb)$/ ) {
	$self->add( type => "comment_box", $self->cdecompose($arg),
		    orig => $arg );
	return;
    }

    # Images.
    if ( $dir eq "image" ) {
	use Text::ParseWords qw(shellwords);
	my @args = shellwords($arg);
	my $uri;
	my %opts;
	foreach ( @args ) {
	    if ( /^(width|height|border|center)=(\d+)$/i ) {
		$opts{lc($1)} = $2;
	    }
	    elsif ( /^(scale)=(\d(?:\.\d+)?)$/i ) {
		$opts{lc($1)} = $2;
	    }
	    elsif ( /^(center|border)$/i ) {
		$opts{lc($_)} = 1;
	    }
	    elsif ( /^(src|uri)=(.+)$/i ) {
		$uri = $2;
	    }
	    elsif ( /^(title)=(.*)$/i ) {
		$opts{title} = $1;
	    }
	    elsif ( /^(.+)=(.*)$/i ) {
		do_warn( "Unknown image attribute: $1\n" );
		next;
	    }
	    else {
		$uri = $_;
	    }
	}
	unless ( $uri ) {
	    do_warn( "Missing image source\n" );
	    return;
	}
	$self->add( type => "image",
		    uri  => $uri,
		    opts => \%opts );
	return;
    }

    if ( $dir =~ /^(?:title|t)$/ ) {
	$cur->{title} = $arg;
	push( @{ $self->{songs}->[-1]->{meta}->{title} }, $arg );
	return;
    }

    if ( $dir =~ /^(?:subtitle|st)$/ ) {
	push(@{$cur->{subtitle}}, $arg);
	push( @{ $self->{songs}->[-1]->{meta}->{subtitle} }, $arg );
	return;
    }

    # Metadata extensions (legacy). Should use meta instead.
    # Only accept the list from config.
    if ( $re_meta && $dir =~ $re_meta ) {
	if ( $xpose && $1 eq "key" ) {
	    $arg = App::Music::ChordPro::Chords::transpose( $arg, $xpose );
	}
	push( @{ $self->{songs}->[-1]->{meta}->{$1} }, $arg );
	return;
    }

    # More metadata.
    if ( $dir =~ /^(meta)$/ ) {
	if ( $arg =~ /([^ :]+)[ :]+(.*)/ ) {
	    my $key = lc $1;
	    my $val = $2;
	    if ( $xpose && $key eq "key" ) {
		$val = App::Music::ChordPro::Chords::transpose( $val, $xpose );
	    }
	    if ( $re_meta && $key =~ $re_meta ) {
		# Known.
		push( @{ $self->{songs}->[-1]->{meta}->{$key} }, $val );
	    }
	    elsif ( $::config->{metadata}->{strict} ) {
		# Unknown, and strict.
		do_warn("Unknown metadata item: $key");
	    }
	    else {
		# Allow.
		push( @{ $self->{songs}->[-1]->{meta}->{$key} }, $val );
	    }
	}
	else {
	    do_warn("Incomplete meta directive: $d\n");
	}
	return;
    }

    return if $self->global_directive( $d, 0 );

    # Warn about unknowns, unless they are x_... form.
    do_warn("Unknown directive: $d\n") unless $d =~ /^x_/;
    return;
}

sub global_directive {
    my ($self, $d, $legacy ) = @_;
    my ( $dir, $arg ) = dir_split($d);

    my $cur = $self->{songs}->[-1];

    # Song / Global settings.

    if ( $dir eq "titles"
	 && $arg =~ /^(left|right|center|centre)$/i ) {
	$cur->{settings}->{titles} =
	  lc($1) eq "centre" ? "center" : lc($1);
	return 1;
    }

    if ( $dir eq "columns"
	 && $arg =~ /^(\d+)$/ ) {
	$cur->{settings}->{columns} = $arg;
	return 1;
    }

    if ( $dir eq "pagetype" || $dir eq "pagesize" ) {
	$cur->{settings}->{papersize} = $arg;
	return 1;
    }

    if ( $dir =~ /^(?:grid|g)$/ ) {
	$cur->{settings}->{diagrams} = 1;
	return 1;
    }
    if ( $dir =~ /^(?:no_grid|ng)$/ ) {
	$cur->{settings}->{diagrams} = 0;
	return 1;
    }

    # Private hack: transpose at parse time.
    # Usefulness is a bit limited since it doesn't apply to {chorus}.
    if ( $d =~ /^\+transpose[: ]+([-+]?\d+)\s*$/ ) {
	return if $legacy;
	$xpose = $1;
	return 1;
    }
    if ( $dir =~ /^\+transpose\s*$/ ) {
	return if $legacy;
	$xpose = 0;
	return 1;
    }

    # More private hacks.
    if ( $d =~ /^([-+])([-\w.]+)$/i ) {
	return if $legacy;
	$self->add( type => "set",
		    name => $2,
		    value => $1 eq "+" ? 1 : 0,
		  );
	return 1;
    }

    if ( $dir =~ /^\+([-\w.]+)$/ ) {
	return if $legacy;
	$self->add( type => "set",
		    name => $1,
		    value => $arg,
		  );
	return 1;
    }

    # Formatting.
    if ( $dir =~ /^(text|chord|tab|grid|diagrams|title|footer|toc)(font|size|colou?r)$/ ) {
	my $item = $1;
	my $prop = $2;
	my $value = $arg;
	return if $legacy
	  && ! ( $item =~ /^(text|chord|tab)$/ && $prop =~ /^(font|size)$/ );

	$prop = "color" if $prop eq "colour";

	if ( $value eq "" ) {
	    $self->add( type => "control",
			name => "$item-$prop",
			value => undef );
	    return 1;
	}

	if ( $prop eq "size" ) {
	    unless ( $value =~ /^\d+(?:\.\d+)?\%?$/ ) {
		do_warn("Illegal value \"$value\" for $item$prop\n");
		return 1;
	    }
	}
	if ( $prop =~ /^colou?r$/  ) {
	    my $v;
	    unless ( $v = get_color($value) ) {
		do_warn("Illegal value \"$value\" for $item$prop\n");
		return 1;
	    }
	    $value = $v;
	}
	$self->add( type => "control",
		    name => "$item-$prop",
		    value => $prop eq 'font' ? $value : lc($value) );
	return 1;
    }

    # define A: base-fret N frets N N N N N N fingers N N N N N N
    # define: A base-fret N frets N N N N N N fingers N N N N N N
    # optional: base-fret N (defaults to 1)
    # optional: N N N N N N (for unknown chords)
    # optional: fingers N N N N N N

    if ( $dir =~ /^define|chord$/ ) {
	my $show = $dir eq "chord";
	return if $legacy && $show;

	# Split the arguments and keep a copy for error messages.
	my @a = split( /[: ]+/, $arg );
	my @orig = @a;

	# Result structure.
	my $res = { name => shift(@a) };

	my $strings = App::Music::ChordPro::Chords::strings;
	my $fail = 0;

	while ( @a ) {
	    my $a = shift(@a);

	    # base-fret N
	    if ( $a eq "base-fret" ) {
		if ( $a[0] =~ /^\d+$/ ) {
		    $res->{base} = shift(@a);
		}
		else {
		    do_warn("Invalid base-fret value: $a[0]\n");
		    $fail++;
		    last;
		}
	    }

	    # frets N N ... N
	    elsif ( $a eq "frets" ) {
		my @f;
		while ( @a && $a[0] =~ /^[0-9---xXN]$/ ) {
		    push( @f, shift(@a) );
		}
		if ( @f == $strings ) {
		    $res->{frets} = [ map { $_ =~ /^\d+/ ? $_ : -1 } @f ];
		}
		else {
		    do_warn("Incorrect number of fret positions (" .
			    scalar(@f) . ", should be $strings)\n");
		    $fail++;
		    last;
		}
	    }

	    # fingers N N ... N
	    elsif ( $a eq "fingers" ) {
		my @f;
		# It is tempting to limit the fingers to 1..5 ...
		while ( @a && $a[0] =~ /^[0-9---xXN]$/ ) {
		    push( @f, shift(@a) );
		}
		if ( @f == $strings ) {
		    $res->{fingers} = [ map { $_ =~ /^\d+/ ? $_ : -1 } @f ];
		}
		else {
		    do_warn("Incorrect number of finger settings (" .
			    scalar(@f) . ", should be $strings)\n");
		    $fail++;
		    last;
		}
	    }

	    # Wrong...
	    else {
		# Insert a marker to show how far we got.
		splice( @orig, @orig-@a, 0, "<<<" );
		splice( @orig, @orig-@a-2, 0, ">>>" );
		do_warn("Invalid chord definition: @orig\n");
		$fail++;
		last;
	    }
	}
	return 1 if $fail;

	if ( ( $res->{fingers} || $res->{base} ) && ! $res->{frets} ) {
	    do_warn("Missing fret positions: $res->{name}\n");
	    return 1;
	}

	if ( $res->{frets} || $res->{base} || $res->{fingers} ) {
	    $res->{base} ||= 1;
	    push( @{$cur->{define}}, $res );
	    if ( $res->{frets} ) {
		my $res =
		  App::Music::ChordPro::Chords::add_song_chord
		      ( $res->{name}, $res->{base}, $res->{frets}, $res->{fingers} );
		if ( $res ) {
		    do_warn("Invalid chord: ", $res->{name}, ": ", $res, "\n");
		    return 1;
		}
	    }
	    else {
		App::Music::ChordPro::Chords::add_unknown_chord( $res->{name} );
	    }
	}
	else {
	    unless ( App::Music::ChordPro::Chords::chord_info($res->{name}) ) {
		do_warn("Unknown chord: $res->{name}\n");
		return 1;
	    }
	}

	if ( $show) {
	    # Combine consecutive entries.
	    if ( $self->{songs}->[-1]->{body}->[-1]->{type} eq "diagrams" ) {
		push( @{ $self->{songs}->[-1]->{body}->[-1]->{chords} },
		      $res->{name} );
	    }
	    else {
		$self->add( type => "diagrams",
			    show => "user",
			    origin => "chord",
			    chords => [ $res->{name} ] );
	    }
	}
	return 1;
    }

    return;
}

sub transpose {
    my ( $self, $xpose ) = @_;
    return unless $xpose;

    foreach my $song ( @{ $self->{songs} } ) {
	$song->transpose($xpose);
    }
}

sub structurize {
    my ( $self ) = @_;

    foreach my $song ( @{ $self->{songs} } ) {
	$song->structurize;
    }
}

sub get_color {
    $_[0];
}

sub msg {
    my $m = join("", @_);
    $m =~ s/\n+$//;
    my $t = $diag->{format};
    $t =~ s/\%f/$diag->{file}/g;
    $t =~ s/\%n/$diag->{line}/g;
    $t =~ s/\%l/$diag->{orig}/g;
    $t =~ s/\%m/$m/g;
    $t =~ s/\\n/\n/g;
    $t =~ s/\\t/\t/g;
    $t;
}

sub do_warn {
    warn(msg(@_)."\n");
}

################################################################

package App::Music::ChordPro::Song;

sub new {
    my ( $pkg, %init ) = @_;
    bless { structure => "linear", settings => {}, %init }, $pkg;
}

sub transpose {
    my ( $self, $xpose ) = @_;
    return unless $xpose;

    # Transpose meta data (key).
    if ( exists $self->{meta}->{key} ) {
	foreach ( @{ $self->{meta}->{key} } ) {
	    $_ = $self->xpchord( $_, $xpose );
	}
    }

    # Transpose body contents.
    foreach my $item ( @{ $self->{body} } ) {
	if ( $item->{type} eq "songline" ) {
	    foreach ( @{ $item->{chords} } ) {
		$_ = $self->xpchord( $_, $xpose );
	    }
	    next;
	}
	if ( $item->{type} =~ /^comment/ ) {
	    next unless $item->{chords};
	    foreach ( @{ $item->{chords} } ) {
		$_ = $self->xpchord( $_, $xpose );
	    }
	    next;
	}
	if ( $item->{type} eq "gridline" ) {
	    foreach ( @{ $item->{tokens} } ) {
		next unless $_->{class} eq "chord";
		$_->{chord} = $self->xpchord( $_->{chord}, $xpose );
	    }
	    if ( $item->{margin} && exists $item->{margin}->{chords} ) {
		foreach ( @{ $item->{margin}->{chords} } ) {
		    $_ = $self->xpchord( $_, $xpose );
		}
	    }
	    if ( $item->{comment} && exists $item->{comment}->{chords} ) {
		foreach ( @{ $item->{comment}->{chords} } ) {
		    $_ = $self->xpchord( $_, $xpose );
		}
	    }
	    next;
	}
	if ( $item->{type} eq "diagrams" ) {
	    foreach ( @{ $item->{chords} } ) {
		$_ = $self->xpchord( $_, $xpose );
	    }
	    next;
	}
    }
}

sub xpchord {
    my ( $self, $c, $xpose ) = @_;
    return $c unless length($c) && $xpose;
    my $parens = $c =~ s/^\((.*)\)$/$1/;
    my $xc = App::Music::ChordPro::Chords::transpose( $c, $xpose );
    $xc ||= $c;
    return $parens ? "($xc)" : $xc;
}

sub structurize {
    my ( $self ) = @_;

    return if $self->{structure} eq "structured";

    my @body;
    my $context = $def_context;

    foreach my $item ( @{ $self->{body} } ) {
	if ( $item->{type} eq "empty" && $item->{context} eq $def_context ) {
	    $context = $def_context;
	    next;
	}
	if ( $context ne $item->{context} ) {
	    push( @body, { type => $context = $item->{context}, body => [] } );
	}
	if ( $context ) {
	    push( @{ $body[-1]->{body} }, $item );
	}
	else {
	    push( @body, $item );
	}
    }
    $self->{body} = [ @body ];
    $self->{structure} = "structured";
}

1;

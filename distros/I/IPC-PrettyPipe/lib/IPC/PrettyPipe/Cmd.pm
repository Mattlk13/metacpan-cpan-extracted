package IPC::PrettyPipe::Cmd;

# ABSTRACT: A command in an B<IPC::PrettyPipe> pipeline

use Carp;

use List::Util qw[ sum pairs ];
use Scalar::Util qw[ blessed ];

use Try::Tiny;

use Safe::Isa;

use IPC::PrettyPipe::Arg;
use IPC::PrettyPipe::Stream;

use Types::Standard -all;
use Type::Params qw[ validate ];

use IPC::PrettyPipe::Types -all;
use IPC::PrettyPipe::Queue;
use IPC::PrettyPipe::Arg::Format;

use String::ShellQuote 'shell_quote';

use Moo;

our $VERSION = '0.13';

with 'IPC::PrettyPipe::Queue::Element';

use namespace::clean;

use overload 'fallback' => 1;






















use overload '|' => sub {
    my $swap = pop;
    my $pipe = IPC::PrettyPipe->new;
    $pipe->add( $_ ) for ( $swap ? reverse( @_ ) : @_ );
    $pipe;
};

# need access to has method which will get removed at the end of the
# compilation of this module
BEGIN {
    IPC::PrettyPipe::Arg::Format->shadow_attrs( fmt => sub { 'arg' . shift } );
}






























has cmd => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

# delay building args until all attributes have been specified
has _init_args => (
    is        => 'ro',
    init_arg  => 'args',
    coerce    => AutoArrayRef->coercion,
    isa       => ArrayRef,
    predicate => 1,
    clearer   => 1,
);






































has args => (
    is       => 'ro',
    default  => sub { IPC::PrettyPipe::Queue->new },
    init_arg => undef,
);










has streams => (
    is       => 'ro',
    default  => sub { IPC::PrettyPipe::Queue->new },
    init_arg => undef,
);






































has argfmt => (
    is      => 'ro',
    lazy    => 1,
    handles => IPC::PrettyPipe::Arg::Format->shadowed_attrs,
    default => sub { IPC::PrettyPipe::Arg::Format->new_from_attrs( shift ) },
);





sub BUILDARGS {

    my $class = shift;

    my $args
      = @_ == 1
      ? (
        'HASH' eq ref( $_[0] )
        ? $_[0]
        : 'ARRAY' eq ref( $_[0] )
          && @{ $_[0] } == 2 ? { cmd => $_[0][0], args => $_[0][1] }
        : { cmd => $_[0] } )
      : {@_};

    ## no critic (ProhibitAccessOfPrivateData)
    delete @{$args}{ grep { !defined $args->{$_} } keys %$args };

    return $args;
}


sub BUILD {


    my $self = shift;

    if ( $self->_has_init_args ) {

        $self->ffadd( @{ $self->_init_args } );
        $self->_clear_init_args;
    }

    return;
}










sub quoted_cmd { shell_quote( $_[0]->cmd ) }



















































sub add {

    my $self = shift;

    unshift @_, 'arg' if @_ == 1;

    ## no critic (ProhibitAccessOfPrivateData)

    my $argfmt = $self->argfmt->clone;

    my $argfmt_attrs = IPC::PrettyPipe::Arg::Format->shadowed_attrs;

    my ( $attr ) = validate(
        \@_,
        slurpy Dict [
            arg    => Str | Arg | ArrayRef | HashRef,
            value  => Optional [Str],
            argfmt => Optional [ InstanceOf ['IPC::PrettyPipe::Arg::Format'] ],
            ( map { $_ => Optional [Str] } keys %{$argfmt_attrs} ),
        ] );

    my $arg = $attr->{arg};
    my $ref = ref $arg;

    croak( "cannot specify a value if arg is a hash, array, or Arg object\n" )
      if $ref && exists $attr->{value};

    $argfmt->copy_from( $attr->{argfmt} ) if defined $attr->{argfmt};
    $argfmt->copy_from( IPC::PrettyPipe::Arg::Format->new_from_hash( $attr ) );

    if ( 'HASH' eq $ref ) {

        while ( my ( $name, $value ) = each %$arg ) {

            $self->args->push(
                IPC::PrettyPipe::Arg->new(
                    name  => $name,
                    value => $value,
                    fmt   => $argfmt->clone
                ) );

        }
    }

    elsif ( 'ARRAY' eq $ref ) {

        croak( "missing value for argument ", $arg->[-1] )
          if @$arg % 2;

        foreach ( pairs @$arg ) {

            my ( $name, $value ) = @$_;

            $self->args->push(
                IPC::PrettyPipe::Arg->new(
                    name  => $name,
                    value => $value,
                    fmt   => $argfmt->clone
                ) );

        }
    }

    elsif ( $arg->$_isa( 'IPC::PrettyPipe::Arg' ) ) {

        $self->args->push( $arg );

    }

    # everything else
    else {

        $self->args->push(
            IPC::PrettyPipe::Arg->new(
                name => $attr->{arg},
                exists $attr->{value} ? ( value => $attr->value ) : (),
                fmt => $argfmt->clone
            ) );
    }

    return;
}


















































sub ffadd {

    my $self = shift;
    my @args = @_;

    my $argfmt = $self->argfmt->clone;

    for ( my $idx = 0 ; $idx < @args ; $idx++ ) {

        my $t = $args[$idx];

        if ( $t->$_isa( 'IPC::PrettyPipe::Arg::Format' ) ) {

            $t->copy_into( $argfmt );

        }

        elsif ( $t->$_isa( 'IPC::PrettyPipe::Arg' ) ) {

            $self->add( arg => $t );


        }

        elsif ( ref( $t ) =~ /^(ARRAY|HASH)$/ ) {

            $self->add( arg => $t, argfmt => $argfmt->clone );

        }

        elsif ( $t->$_isa( 'IPC::PrettyPipe::Stream' ) ) {

            $self->stream( $t );

        }

        else {

            try {

                my $stream = IPC::PrettyPipe::Stream->new(
                    spec   => $t,
                    strict => 0,
                );

                if ( $stream->requires_file ) {

                    croak( "arg[$idx]: stream operator $t requires a file\n" )
                      if ++$idx == @args;

                    $stream->file( $args[$idx] );
                }

                $self->stream( $stream );
            }
            catch {

                die $_ if /requires a file/;

                $self->add( arg => $t, argfmt => $argfmt->clone );
            };

        }
    }

    return;
}















sub stream {

    my $self = shift;

    my $spec = shift;

    if ( $spec->$_isa( 'IPC::PrettyPipe::Stream' ) ) {

        croak( "too many arguments\n" )
          if @_;

        $self->streams->push( $spec );

    }

    elsif ( !ref $spec ) {

        $self->streams->push(
            IPC::PrettyPipe::Stream->new(
                spec => $spec,
                +@_ ? ( file => @_ ) : () ) );
    }

    else {

        croak( "illegal stream specification\n" );

    }


    return;
}











sub valmatch {
    my $self    = shift;
    my $pattern = shift;

    # find number of matches;
    return sum 0, map { $_->valmatch( $pattern ) } @{ $self->args->elements };
}



























sub valsubst {
    my $self = shift;

    my @args = ( shift, shift, @_ > 1 ? {@_} : @_ );


    ## no critic (ProhibitAccessOfPrivateData)

    my ( $pattern, $value, $args ) = validate(
        \@args,
        RegexpRef,
        Str,
        Optional [
            Dict [
                lastvalue  => Optional [Str],
                firstvalue => Optional [Str] ]
        ],
    );

    my $nmatch = $self->valmatch( $pattern );

    if ( $nmatch == 1 ) {

        $args->{lastvalue}  //= $args->{firstvalue} // $value;
        $args->{firstvalue} //= $args->{lastvalue};

    }
    else {
        $args->{lastvalue}  ||= $value;
        $args->{firstvalue} ||= $value;
    }

    my $match = 0;
    foreach ( @{ $self->args->elements } ) {

        $match++
          if $_->valsubst( $pattern,
              $match == 0 ? $args->{firstvalue}
            : $match == ( $nmatch - 1 ) ? $args->{lastvalue}
            :                             $value );
    }

    return $match;
}


1;

#
# This file is part of IPC-PrettyPipe
#
# This software is Copyright (c) 2018 by Smithsonian Astrophysical Observatory.
#
# This is free software, licensed under:
#
#   The GNU General Public License, Version 3, June 2007
#

__END__

=pod

=for :stopwords Diab Jerius Smithsonian Astrophysical Observatory Bourne argfmt argpfx
argsep cmd ffadd valmatch valsubst

=head1 NAME

IPC::PrettyPipe::Cmd - A command in an B<IPC::PrettyPipe> pipeline

=head1 VERSION

version 0.13

=head1 SYNOPSIS

  use IPC::PrettyPipe::Cmd;

  # named arguments
  $cmd = IPC::PrettyPipe::Cmd->new( cmd  => $cmd,
                                    args => $args,
                                    %attrs
                                  );

  # concise constructor interface
  $cmd = IPC::PrettyPipe::Cmd->new( $cmd );
  $cmd = IPC::PrettyPipe::Cmd->new( [ $cmd, $args ] );

  #####
  # different argument prefix for different arguments
  $cmd = IPC::PrettyPipe::Cmd->new( 'ls' );
  $cmd->argpfx( '-' ); # prefix applied to subsequent arguments
  $cmd->add( 'f' );    # -f
  $cmd->add( 'r' );    # -r

  # "long" arguments, random order
  $cmd->add( { width => 80, sort => 'time' },
               argpfx => '--', argsep => '=' );

  # "long" arguments, specified order
  $cmd->add( [ width => 80, sort => 'time' ],
               argpfx => '--', argsep => '=' );

  # attach a stream to the command
  $cmd->stream( $spec, $file );

  # be a little more free form in adding arguments
  $cmd->ffadd( '-l', [-f => 3, -b => 9 ], '>', 'stdout' );

  # perform value substution on a command's arguments' values
  $cmd->valsubst( %stuff );

=head1 DESCRIPTION

B<IPC::PrettyPipe::Cmd> objects are containers for the individual
commands in a pipeline created by L<IPC::PrettyPipe>.  A command
may have one or more arguments, some of which are options consisting
of a name and an optional value.

Options traditionally have a prefix (e.g. C<--> for "long" options,
C<-> for short options).  B<IPC::PrettyPipe::Cmd> makes no distinction
between option and non-option arguments.  The latter are simply
specified as arguments with a blank prefix.

=head1 ATTRIBUTES

=head2 cmd

The program to execute.  Required.

=head2 args

I<Optional>. Arguments for the program.  C<args> may be

=over

=item *

A scalar, e.g. a single argument;

=item *

An L<IPC::PrettyPipe::Arg> object;

=item *

A hashref with pairs of names and values. The arguments will be
supplied to the command in a random order.

=item *

An array reference containing more complex argument specifications.
Its elements are processed with the L</ffadd> method.

=back

=head2 argpfx

=head2 argsep

I<Optional>.  The default prefix and separation attributes for
command arguments.  See L<IPC::PrettyPipe::Arg> for more
details.  These override any specified via the L</argfmt> object.

=head2 argfmt

I<Optional>. An L<IPC::PrettyPipe::Arg::Format> object which will be used to
specify the default prefix and separation attributes for arguments to
commands.  May be overridden by L</argpfx> and L</argsep>.

=head1 METHODS

=head2 new

  # constructor with named arguments
  $cmd = IPC::PrettyPipe::Cmd->new( cmd => $cmd, %attributes );

  # concise constructor interface
  $cmd = IPC::PrettyPipe::Cmd->new( $cmd );
  $cmd = IPC::PrettyPipe::Cmd->new( [ $cmd, $args ] );

Construct a B<IPC::PrettyPipe::Cmd> object encapsulating C<$cmd>.
C<$cmd> must be specified.  See L</ATTRIBUTES> for a description
of the available attributes.

=head2 cmd

  $name = $cmd->cmd

Return the name of the program to execute.

=head2 args

  $args = $cmd->args;

Return a L<IPC::PrettyPipe::Queue> object containing the
L<IPC::PrettyPipe::Arg> objects associated with the command.

=head2 B<streams>

  $streams = $cmd->streams

Return a L<IPC::PrettyPipe::Queue> object containing the
L<IPC::PrettyPipe::Stream> objects associated with the command.

=head2 argpfx

=head2 argsep

=head2 argfmt

  $obj->argpfx( $new_pfx );
  $obj->argsep( $new_sep );
  $obj->argfmt( $format_obj );

Retrieve (when called with no arguments) or modify (when called with
an argument) the similarly named object attributes.  See
L<IPC::PrettyPipe::Arg> for more information.  Changing them
affects new, not existing, arguments

C<$format_obj> is an L<IPC::PrettyPipe::Arg::Format> object;

=head2 quoted_cmd

  $name = $cmd->quoted_cmd;

Return the name of the command, appropriately quoted for passing as a
single word to a Bourne compatible shell.

=head2 add

  $cmd->add( $args );
  $cmd->add( arg => $args, %options );

Add one or more arguments to the command.  If a single parameter is
passed, it is assumed to be the C<arg> parameter.

This is useful if some arguments should be conditionally given, e.g.

        $cmd = IPC::PrettyPipe::Cmd->new( 'ls' );
        $cmd->add( '-l' ) if $want_long_listing;

The available options are:

=over

=item C<arg>

The argument or arguments to add.  It may take one of the following
values:

=over

=item *

an L<IPC::PrettyPipe::Arg> object;

=item *

A scalar, e.g. a single argument;

=item *

An arrayref with pairs of names and values.  The arguments will be supplied to the
command in the order they appear.

=item *

A hashref with pairs of names and values. The arguments will be supplied to the
command in a random order.

=back

=back

=head2 ffadd

  $cmd->ffadd( @arguments );

A more relaxed means of adding argument specifications. C<@arguments>
may contain any of the following items:

=over

=item *

an L<IPC::PrettyPipe::Arg> object

=item *

A scalar, representing an argument without a value.

=item *

An arrayref with pairs of names and values.  The arguments will be supplied to the
command in the order they appear.

=item *

A hashref with pairs of names and values. The arguments will be supplied to the
command in a random order.

=item *

An L<IPC::PrettyPipe::Arg::Format> object, specifying the prefix
and separator attributes for successive arguments.

=item *

An L<IPC::PrettyPipe::Stream> object

=item *

A string which matches a stream specification
(L<IPC::PrettyPipe::Stream::Utils/Stream Specification>), which will cause
a new I/O stream to be attached to the command.  If the specification
requires an additional parameter, the next value in C<@arguments> will be
used for that parameter.

=back

=head2 B<stream>

  $cmd->stream( $stream_obj );
  $cmd->stream( $spec );
  $cmd->stream( $spec, $file );

Add an I/O stream to the command.  It may be passed either a stream
specification (L<IPC::PrettyPipe::Stream::Utils/Stream Specification>)
or an L<IPC::PrettyPipe::Stream> object.

See L<IPC::PrettyPipe::Stream> for more information.

=head2 valmatch

  $n = $cmd->valmatch( $pattern );

Returns the number of arguments whose value matches the passed
regular expression.

=head2 valsubst

  $cmd->valsubst( $pattern, $value, %options );

Replace the values of arguments whose names match the Perl regular
expression I<$pattern> with I<$value>. The following options are
available:

=over

=item C<firstvalue>

If true, the first occurence of a match will be replaced with
this.

=item C<lastvalue>

If true, the last occurence of a match will be replaced with
this.  In the case where there is only one match and both
C<firstvalue> and C<lastvalue> are specified, C<lastvalue> takes
precedence.

=back

=head1 OPERATORS

=head2 |

The C<|> operator is equivalent to creating a new pipe and adding
the operands of the C<|> operator, e.g.

  $cmd | $obj

is the same as

  do {
    my $tpipe = IPC::PrettyPipe->new;
    $tpipe->add( $cmd );
    $tpipe->add( $obj );
    $tpipe
  };

where C<$obj> may be either an L<IPC::PrettyPipe> or L<IPC::PrettyPipe::Cmd> object.

=for Pod::Coverage BUILDARGS BUILD

=head1 SUPPORT

=head2 Bugs

Please report any bugs or feature requests to bug-ipc-prettypipe@rt.cpan.org  or through the web interface at: https://rt.cpan.org/Public/Dist/Display.html?Name=IPC-PrettyPipe

=head2 Source

Source is available at

  https://gitlab.com/djerius/ipc-prettypipe

and may be cloned from

  https://gitlab.com/djerius/ipc-prettypipe.git

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<IPC::PrettyPipe|IPC::PrettyPipe>

=back

=head1 AUTHOR

Diab Jerius <djerius@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Smithsonian Astrophysical Observatory.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut

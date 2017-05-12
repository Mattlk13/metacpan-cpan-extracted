#========================================================================
#
# Badger::Data::Facets
#
# DESCRIPTION
#   Factory for Badger::Data::Facets validation objects.
#
# AUTHOR
#   Andy Wardley   <abw@wardley.org>
#
#========================================================================

package Badger::Data::Facets;

use Badger::Factory::Class
    version   => 0.01,
    debug     => 0,
    item      => 'facet',
    path      => 'Badger::Data::Facet BadgerX::Data::Facet',
    constants => 'HASH DOT';


our $PREFIXES = {
    text    => 'text',
    number  => 'number',
    list    => 'list',
};


sub type_args {
    my $self = shift;
    my $type = shift;       # my $save = $type;   # tmp debug
    my $name = $type;
    my $base;

    # See if we recognise the initial XXX_ prefix as a short-cut.  
    # If so then the part afterwords is the name we're interested in, 
    # e.g. text_max_length becomes 'text.max_length' which the factory
    # module will map to '<path>::Text::MaxLength' for loading, while 
    # 'max_length' is the name that we'll use as a default argument name.
    
    if ($type =~ s/^([^\W_]+)(\.|_)(.*)/$3/) {
        if ($2 eq DOT) {
            $type = $1.DOT.$type;
            $name = $3;
        }
        elsif ($base = $PREFIXES->{ $1 }) {
            $type = $base.DOT.$type;
            $name = $3;
        }
        else {
            $type = $1.$2.$type;
        }
    }

    my $args = @_ && ref $_[0] eq HASH ? shift : { $name => shift };

#    $self->debug("save:$save / type:$type / base:$base / name:$name");

    return ($type, $args);
}


1;

__END__

=head1 NAME

Badger::Data::Facets - factory module for data validation facets.

=head1 DESCRIPTION

This module implements a subclass of L<Badger::Factory> for loading and
instantiating data validation facets.

=head1 METHODS

The following methods are defined in addition to those inherited from the 
L<Badger::Factory> and L<Badger::Base> base classes.

=head2 type_args($type, @args)

This performs some custom handling of the arguments used to create data
facets. 

=head1 AUTHOR

Andy Wardley L<http://wardley.org/>

=head1 COPYRIGHT

Copyright (C) 2008-2012 Andy Wardley.  All Rights Reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<Badger::Factory>,
L<Badger::Base>.

=cut

# Local Variables:
# mode: perl
# perl-indent-level: 4
# indent-tabs-mode: nil
# End:
#
# vim: expandtab shiftwidth=4:


#
# This file is part of HTML-FormFu-ExtJS
#
# This software is Copyright (c) 2011 by Moritz Onken.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#
package HTML::FormFu::ExtJS::Element::Reset;
BEGIN {
  $HTML::FormFu::ExtJS::Element::Reset::VERSION = '0.090';
}

use base "HTML::FormFu::ExtJS::Element::Button"; 

use strict;
use warnings;
use utf8;

sub render {
	my $class = shift;
	my $self = shift;
	my $super = $class->SUPER::render($self);
	return { %{$super}, text => scalar $self->value, type => "reset" };
	
	
}

1;


__END__
=pod

=head1 NAME

HTML::FormFu::ExtJS::Element::Reset

=head1 VERSION

version 0.090

=head1 DESCRIPTION

=head1 NAME

HTML::FormFu::ExtJS::Element::Reset - Reset button

=head1 SEE ALSO

L<HTML::FormFu::Element::Reset>

=head1 COPYRIGHT & LICENSE

Copyright 2008 Moritz Onken, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

=head1 AUTHOR

Moritz Onken <onken@netcubed.de>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Moritz Onken.

This is free software, licensed under:

  The (three-clause) BSD License

=cut


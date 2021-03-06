## -*- Mode: CPerl -*-

## File: DTA::TokWrap::Processor::tokenize.pm
## Author: Bryan Jurish <moocow@cpan.org>
## Description: DTA tokenizer wrappers: tokenizer: abstract base class

package DTA::TokWrap::Processor::tokenize;

use DTA::TokWrap::Version;  ##-- imports $VERSION, $RCDIR
use DTA::TokWrap::Base;
use DTA::TokWrap::Utils qw(:progs :slurp :time);
use DTA::TokWrap::Processor;

use Encode qw(encode decode);
use Carp;
use strict;

##==============================================================================
## Constants
##==============================================================================
our @ISA = qw(DTA::TokWrap::Processor);

#our $DEFAULT_SUBCLASS = 'tomasotath'; ##-- default subclass
our $DEFAULT_SUBCLASS = 'auto'; ##-- default subclass
#our $DEFAULT_SUBCLASS = 'auto';
#our $DEFAULT_SUBCLASS = 'http';
#our $DEFAULT_SUBCLASS = 'tomasotath';
#our $DEFAULT_SUBCLASS = 'waste';
#our $DEFAULT_SUBCLASS = 'scanner';
#our $DEFAULT_SUBCLASS = 'dummy';

##==============================================================================
## Constructors etc.
##==============================================================================

## $tz = CLASS_OR_OBJ->new(%args)
## %defaults = CLASS->defaults()
##  + static class-dependent defaults
##  + nothing here
sub new {
  my ($that,%args) = @_;
  my $class = $args{class};
  $class = $DEFAULT_SUBCLASS if (!$class && (ref($that)||$that) eq __PACKAGE__);
  if ($class) {
    $that = __PACKAGE__ . "::$class";
    delete($args{class});
    return $class->new(%args);
  }
  return $that->SUPER::new(%args);
}

## %defaults = CLASS_OR_OBJ->defaults()
##  + called by constructor
##  + inherited dummy method
#sub defaults { qw() }

## $tz = $tz->init()
##  + inherited dummy method
#sub init { $_[0] }

##==============================================================================
## Methods
##==============================================================================

## $doc_or_undef = $CLASS_OR_OBJECT->tokenize($doc)
## + $doc is a DTA::TokWrap::Document object
## + %$doc keys:
##    txtfile => $txtfile,    ##-- (input) serialized text file
##    tokdata0 => $tokdata,   ##-- (output) tokenizer output data (string)
##    tokenize0_stamp  => $f, ##-- (output) timestamp of operation end
##    tokdata0_stamp => $f,   ##-- (output) timestamp of operation end
## + may implicitly call $doc->mkbx() and/or $doc->saveTxtFile()
sub tokenize {
  my ($tz,$doc) = @_;
  $doc->setLogContext();
  $tz->logconfess("tokenize(): abstract method called");
}


##==============================================================================
## Utilities
##==============================================================================

## $ntoks = $tz->nTokens(\$tokdata)
##  + get number of tokens in \$tokdata (regex hack)
sub nTokens {
  #my ($tz,$tokdatar) = @_;
  return scalar( @{[ ${$_[1]} =~ /^(?!%%).+$/mg ]} );
}

1; ##-- be happy

__END__

##========================================================================
## POD DOCUMENTATION, auto-generated by podextract.perl, edited

##========================================================================
## NAME
=pod

=head1 NAME

DTA::TokWrap::Processor::tokenize - DTA tokenizer wrappers: tokenizer: default (NYI)

=cut

##========================================================================
## SYNOPSIS
=pod

=head1 SYNOPSIS

 use DTA::TokWrap::Processor::tokenize;
 
 $tz = DTA::TokWrap::Processor::tokenize->new(%args);
 $doc_or_undef = $tz->tokenize($doc);

=cut

##========================================================================
## DESCRIPTION
=pod

=head1 DESCRIPTION

This class is really just an abstract API specification.
Actual tokenizer classes are e.g.
L<DTA::TokWrap::Processor::tomasotath|DTA::TokWrap::Processor::tomasotath>
and
L<DTA::TokWrap::Processor::dummy|DTA::TokWrap::Processor::dummy>.

DTA::TokWrap::Processor::tokenize provides an object-oriented
L<DTA::TokWrap::Processor|DTA::TokWrap::Processor> wrapper
for the tokenization of serialized text files
for L<DTA::TokWrap::Document|DTA::TokWrap::Document> objects.

Most users should use the high-level
L<DTA::TokWrap|DTA::TokWrap> wrapper class
instead of using this module directly.

=cut

##----------------------------------------------------------------
## DESCRIPTION: DTA::TokWrap::Processor::tokenize: Constants
=pod

=head2 Constants

=over 4

=item @ISA

DTA::TokWrap::Processor::tokenize
inherits from
L<DTA::TokWrap::Processor|DTA::TokWrap::Processor>.

=item $DEFAULT_SUBCLASS

Default tokenizer subclass to use for DTA::TokWrap::Processor::tokenize-E<gt>new().
Default value = 'tomasotath'.

=back

=cut

##----------------------------------------------------------------
## DESCRIPTION: DTA::TokWrap::Processor::tokenize: Constructors etc.
=pod

=head2 Constructors etc.

=over 4

=item new

 $tz = $CLASS_OR_OBJ->new(%args);

%args, %$tz: none here; see subclass documentation.

=item defaults

 %defaults = CLASS->defaults();

Static class-dependent defaults: none here; see subclass documentation.

=back

=cut

##----------------------------------------------------------------
## DESCRIPTION: DTA::TokWrap::Processor::tokenize: Methods
=pod

=head2 Methods

=over 4

=item tokenize

 $doc_or_undef = $CLASS_OR_OBJECT->tokenize($doc);

Performs actual tokenization of the
serialized text from the
L<DTA::TokWrap::Document|DTA::TokWrap::Document> object $doc.

Relevant %$doc keys:

 txtfile => $txtfile,  ##-- (input) serialized text file (uses $doc->{bxdata} if $doc->{txtfile} is not defined)
 bxdata  => \@bxdata,  ##-- (input) block data, used to generate $doc->{txtfile} if not present
 tokdata0 => $tokdata0,  ##-- (output) tokenizer output data (string)
 ##
 tokenize0_stamp0 => $f, ##-- (output) timestamp of operation begin
 tokenize0_stamp  => $f, ##-- (output) timestamp of operation end
 tokdata0_stamp => $f,   ##-- (output) timestamp of operation end

may implicitly call $doc-E<gt>mkbx() and/or $doc-E<gt>saveTxtFile()
(but shouldn't).

=back

=cut

##========================================================================
## END POD DOCUMENTATION, auto-generated by podextract.perl

##======================================================================
## See Also
##======================================================================

=pod

=head1 SEE ALSO

L<DTA::TokWrap::Intro(3pm)|DTA::TokWrap::Intro>,
L<dta-tokwrap.perl(1)|dta-tokwrap.perl>,
...

=cut

##======================================================================
## See Also
##======================================================================

=pod

=head1 SEE ALSO

L<DTA::TokWrap::Intro(3pm)|DTA::TokWrap::Intro>,
L<dta-tokwrap.perl(1)|dta-tokwrap.perl>,
...

=cut

##======================================================================
## Footer
##======================================================================

=pod

=head1 AUTHOR

Bryan Jurish E<lt>moocow@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009-2018 by Bryan Jurish

This package is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.

=cut



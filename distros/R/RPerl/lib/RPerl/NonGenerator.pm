# [[[ HEADER ]]]
package RPerl::NonGenerator;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ INCLUDES ]]]
use RPerl::Grammar;
#use RPerl::Parser;
#eval 'require RPerl::Parser;';
eval {require RPerl::Parser;};
if ($EVAL_ERROR and ($EVAL_ERROR =~ /attempt to reload/i)){
    delete $INC{'RPerl::Parser'};
    require RPerl::Parser;
}
elsif ($EVAL_ERROR ne q{}) { die $EVAL_ERROR; }

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    RPerl::diag('in NonGenerator->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n");
#    RPerl::diag('in NonGenerator->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n");
    croak 'ERROR ECOGENG00, GENERATOR: Attempt to generate output source code from non-generating class ' . ::class($self) . ', croaking';
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    croak 'ERROR ECOGENG00, GENERATOR: Attempt to generate output source code from non-generating class ' . ::class($self) . ', croaking';
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    croak 'ERROR ECOGENG00, GENERATOR: Attempt to generate output source code from non-generating class ' . ::class($self) . ', croaking';
};


1;  # end of class

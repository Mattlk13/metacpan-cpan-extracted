package Lingua::Align::LinkSearch::NTonly;

use 5.005;
use strict;

use vars qw(@ISA);
@ISA = qw(Lingua::Align::LinkSearch::GreedyWellFormed);

use Lingua::Align::LinkSearch;


sub new{
    my $class=shift;
    my %attr=@_;

    my $self={};
    bless $self,$class;

    foreach (keys %attr){
	$self->{$_}=$attr{$_};
    }

    my $BaseSearch = $attr{-link_search} || 'NTonly_greedy_weakly_wellformed';
    $BaseSearch =~s/\_?[Nn][tT]only\_?//;
    $attr{-link_search} = $BaseSearch;
    $self->{BASESEARCH} = new Lingua::Align::LinkSearch(%attr);

    # for tree manipulation
    $self->{TREES} = new Lingua::Align::Corpus::Treebank();

    return $self;
}


sub search{
    my $self=shift;
    my ($linksST,$scores,$min_score,
	$src,$trg,
	$stree,$ttree,$linksTS)=@_;

    if (ref($linksTS) ne 'HASH'){$linksTS={};}

    my @NTscores;
    my (@NTsrc,@NTtrg);

    foreach my $n (0..$#{$scores}){
	next if ($$scores[$n] < $min_score);
	if ($self->{TREES}->is_nonterminal($stree,$$src[$n])){
	    if ($self->{TREES}->is_nonterminal($ttree,$$trg[$n])){
		push(@NTscores,$$scores[$n]);
		push(@NTsrc,$$src[$n]);
		push(@NTtrg,$$trg[$n]);
		next;
	    }
	}
    }


    $self->{BASESEARCH}->search($linksST,\@NTscores,$min_score,
				\@NTsrc,\@NTtrg,
				$stree,$ttree,$linksTS);

    return 1;

}


1;
__END__

=head1 NAME

Lingua::Align::LinkSearch::NTonly - Align non-terminal nodes only (greedily)

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 SEE ALSO


=head1 AUTHOR

Joerg Tiedemann

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Joerg Tiedemann

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut

package autoclass_039::trio::t10;
use base qw(Class::AutoClass);
 
use vars qw(@AUTO_ATTRIBUTES @OTHER_ATTRIBUTES @CLASS_ATTRIBUTES %SYNONYMS %DEFAULTS);
@AUTO_ATTRIBUTES=qw(auto_t10 dflt_t10);
@OTHER_ATTRIBUTES=qw(other_t10);
@CLASS_ATTRIBUTES=qw(class_t10);
%DEFAULTS=(dflt_t10=>'t10');
%SYNONYMS=(syn_t10=>'auto_t10');
Class::AutoClass::declare;

our @attr_groups=qw(auto other class syn dflt);
sub _init_self {
  my($self,$class,$args)=@_;
  my($base)=$class=~/::(\w+)$/;
  push(@{$self->{init_self_history}},$base);
  my @base_attrs=@{$args->attrs};
  my @attrs;
  for my $group (@attr_groups) {
    push(@attrs,map {$group.'_'.$_} @base_attrs);
  }
  push(@{$self->{init_self_state}},[$self->get(@attrs)]);
}
sub other_t10 {
  my $self=shift;
  @_? $self->{other_t10}=$_[0]: $self->{other_t10};
}
1;

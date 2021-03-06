package Babble::Grammar;

use PPR::X;
use Mu;
use strictures 2;

lazy base_grammar_regexp => sub { $PPR::X::GRAMMAR };

lazy base_rule_names => sub {
  my $g = $_[0]->base_grammar_regexp;
  +{ map +($_ => 1), $g =~ /\(\?<PerlStd(\w+)>/g };
};

lazy rules => sub {
  +{ map +($_ => [ undef ]), keys %{ $_[0]->base_rule_names } }
};

lazy grammar_regexp => sub {
  my ($self) = @_;
  my @parts;
  foreach my $name (sort keys %{$self->rules}) {
    my @layers = @{$self->rules->{$name}};
    foreach my $idx (0..$#layers) {
      next unless defined(my $rule = $layers[$idx]);
      my $layer_name = $self->_rule_name($name, $idx);
      my $define = '(?<'.$layer_name.'>'.$rule.')';
      $define = '(?<Perl'.$name.'>'.$define.')' if $idx == $#layers;
      unshift @parts, $define;
    }
  }
  my $base_re = $self->base_grammar_regexp;
  return $base_re unless @parts;
  my $define_block = join "\n", '(?(DEFINE)', '', @parts, '', ')';
  use re 'eval';
  # For reasons I don't understand, this stringify is required (RT #126285)
  my $final_re = "${define_block} ${base_re}";
  return qr{$final_re}x;
};

sub _rule_name {
  my ($self, $name, $index) = @_;
  return 'PerlStd'.$name unless $index;
  return 'PerlWrapper'.$name.'_'.sprintf("%03i", $index);
}

sub add_rule {
  my ($self, $name, $rule) = @_;
  die "Rule ${name} already exists" if exists $self->rules->{$name};
  $self->rules->{$name} = [ $rule ];
  return $self;
}

sub replace_rule {
  my ($self, $name, $rule) = @_;
  die "Rule ${name} does not exist" unless exists $self->rules->{$name};
  $self->rules->{$name} = [ $rule ];
  return $self;
}

sub extend_rule {
  my ($self, $name, $cb) = @_;
  die "Rule ${name} does not exist" unless my $r = $self->rules->{$name};
  my $inner_name = $self->_rule_name($name, $#{$r});
  $self->rules->{$name} = [ @$r, $cb->('(?&'.$inner_name.')') ];
  return $self;
}

sub augment_rule {
  my ($self, $name, $extra) = @_;
  $self->extend_rule($name, sub { join '|', $extra, $_[0] });
  return $self;
}

sub clone {
  my ($self) = @_;
  return ref($self)->new(
    base_grammar_regexp => $self->base_grammar_regexp,
    rules => { %{$self->rules} },
  );
}

sub match {
  my ($self, $as, $text) = @_;
  require Babble::Match;
  Babble::Match->new(
    top_rule => $as,
    text => $text,
    grammar => $self
  );
}

1;

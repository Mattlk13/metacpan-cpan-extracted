package Karas::Dumper;
use strict;
use warnings;
use utf8;

use DBIx::Inspector;
use String::CamelCase ();
use Data::Dumper ();

sub new {
    my $class = shift;
    bless {}, $class;
}

sub dump {
    my $class = shift;
    my %args = @_ == 1 ? %{$_[0]} : @_;
    my $dbh = $args{dbh} // Carp::croak "Missing mandatory parameter: dbh";
    my $namespace = $args{namespace} // Carp::croak "Missing mandatory parameter: namespace";
    my $name_map = $args{name_map} || +{};
    my $inspector = DBIx::Inspector->new(dbh => $dbh);
    my @lines = (
        'use warnings;',
        'use strict;',
        '',
        "package ${namespace}::Schema;",
        '# This file is automatically generated by ' . __PACKAGE__ . '. Do not edit directly.',
        ''
    );
    my %class_map;
    for my $table ($inspector->tables) {
        my $klass = sprintf("%s::Row::%s", $namespace, $name_map->{$table->name} || String::CamelCase::camelize($table->name));
        $class_map{$table->name} = $klass;
        push @lines, (
            sprintf("package $klass;"),
            sprintf('# This file is automatically generated by ' . __PACKAGE__ . '. Do not edit directly.'),
            sprintf("use parent qw(Karas::Row);"),
            sprintf("__PACKAGE__->mk_column_accessors(qw(%s));", join(' ', map { $_->name } $table->columns)),
            sprintf("sub table_name { '%s' }", $table->name),
            sprintf("sub primary_key { qw(%s) }", join(' ', map { $_->name } $table->primary_key())),
            sprintf("sub column_names { qw(%s) }", join(' ', map { $_->name } $table->columns())),
            '',
        );
    }
    push @lines, (
        sprintf("sub ${namespace}::Schema::table_name2class { %s }", do {
            local $Data::Dumper::Terse    = 1;
            local $Data::Dumper::Indent   = 1;
            local $Data::Dumper::SortKeys = 1;
            Data::Dumper::Dumper(\%class_map)
        })
    );
    push @lines, "1;";
    return join("\n", @lines);
}

1;


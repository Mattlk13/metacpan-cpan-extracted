package Perinci::Sub::Gen::AccessTable;

use 5.010001;
use strict;
use warnings;
use Log::ger;

use Exporter 'import';
use Function::Fallback::CoreOrPP qw(clone);
use List::Util qw(shuffle);
use Locale::Set qw(:locale_h setlocale);
use Locale::TextDomain::UTF8 'Perinci-Sub-Gen-AccessTable';
use Perinci::Object::Metadata;
use Perinci::Sub::Gen;
use Perinci::Sub::Util qw(err);
#use String::Trim::More qw(trim_blank_lines);

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2024-05-14'; # DATE
our $DIST = 'Perinci-Sub-Gen-AccessTable'; # DIST
our $VERSION = '0.594'; # VERSION

our @EXPORT_OK = qw(gen_read_table_func);

our %SPEC;

sub __parse_schema {
    require Data::Sah::Normalize;
    Data::Sah::Normalize::normalize_schema($_[0]);
}

sub __is_aoa {
    my $data = shift;
    ref($data) eq 'ARRAY' && (!@$data || ref($data->[0]) eq 'ARRAY');
}

sub __is_aoh {
    my $data = shift;
    ref($data) eq 'ARRAY' && (!@$data || ref($data->[0]) eq 'HASH');
}

sub __is_filter_arg {
    my ($arg, $func_meta) = @_;
    my $args = $func_meta->{args};
    return 0 unless $args && $args->{$arg};
    my $tags = $args->{$arg}{tags};
    return 0 unless $tags;
    for my $tag (@$tags) {
        next unless ref($tag) eq 'HASH';
        return 1 if $tag->{name} =~ /^category:filtering/;
    }
    0;
}

sub _add_arg {
    my %args = @_;

    my $arg_name  = $args{name};
    my $fname     = $args{name}; $fname =~ s/\..+//;
    my $func_meta = $args{func_meta};
    my $langs     = $args{langs};

    die "BUG: Duplicate arg $arg_name" if $func_meta->{args}{$arg_name};

    my $tag = {name=>"category:$args{cat_name}"};
    my $schema = ref($args{type}) eq 'ARRAY' ? $args{type} :
        [$args{type} => {}];
    $schema->[1] //= {};
    $schema->[1]{default} = $args{default} if defined($args{default});
    my $arg_spec = {
        schema => $schema,
        tags => [$tag],
    };

    if ($args{aliases}) {
        $arg_spec->{cmdline_aliases} = $args{aliases};
    }

    if (defined $args{pos}) {
        $arg_spec->{pos} = $args{pos};
    }

    if (defined $args{slurpy}) {
        $arg_spec->{slurpy} = $args{slurpy};
    }

    if ($args{extra_props}) {
        for (keys %{ $args{extra_props} }) {
            $arg_spec->{$_} = $args{extra_props}{$_};
        }
    }

    # translation args
    my %xargs = (field => $fname);

    my $orig_locale = setlocale(LC_ALL);

    for my $prop (qw/summary description/) {
        next unless defined $args{$prop};
        #$args{$prop} = trim_blank_lines($args{$prop});
        for my $lang (@$langs) {
            setlocale(LC_ALL, $lang) or warn "Can't setlocale $lang";
            my $isdeflang = $lang eq 'en_US';
            my $k = $prop . ($isdeflang ? '' : ".alt.lang.$lang");
            $arg_spec->{$k} = __x($args{$prop}, %xargs);
        }
    }

    for my $lang (@$langs) {
        for my $prop (qw/summary/) {
            setlocale(LC_ALL, $lang) or warn "Can't setlocale $lang";
            my $isdeflang = $lang eq 'en_US';
            my $k = $prop . ($isdeflang ? '' : ".alt.lang.$lang");
            $tag->{$k} = __x($args{cat_text}, %xargs);
        }
    }

    setlocale(LC_ALL, $orig_locale);
    $func_meta->{args}{$arg_name} = $arg_spec;
}

sub _gen_meta {
    require Data::Sah::Resolve;

    my ($table_def, $opts) = @_;
    my $langs = $opts->{langs};

    my $fields = $table_def->{fields};

    # add general arguments

    my $func_meta = {
        v => 1.1,
        summary => $opts->{summary} // $table_def->{summary} // "REPLACE ME",
        description => $opts->{description} // "REPLACE ME",
        args => {},
        result => {
            table => {
                def => $table_def,
            },
        },
        'x.dynamic_generator_modules' => [__PACKAGE__],
    };

    my $func_args = $func_meta->{args};

    _add_arg(
        func_meta   => $func_meta,
        langs       => $langs,
        name        => 'with_field_names',
        type        => 'bool',
        default     => $opts->{default_with_field_names},
        aliases     => $opts->{with_field_names_aliases},
        cat_name    => 'field-selection',
        cat_text    => N__('field selection'),
        summary     => N__('Return field names in each record (as hash/'.
                               'associative array)'),
        description => N__(<<'_',

When enabled, function will return each record as hash/associative array
(field name => value pairs). Otherwise, function will return each record
as list/array (field value, field value, ...).

_
    ));
    _add_arg(
        func_meta   => $func_meta,
        langs       => $langs,
        name        => 'detail',
        type        => 'bool',
        default     => $opts->{default_detail} // 0,
        aliases     => $opts->{detail_aliases},
        cat_name    => 'field-selection',
        cat_text    => N__('field selection'),
        summary     => N__('Return array of full records instead of '.
                               'just ID fields'),
        description => N__(<<'_',

By default, only the key (ID) field is returned per result entry.

_
    ));
    _add_arg(
        func_meta   => $func_meta,
        langs       => $langs,
        name        => 'fields',
        type        => ['array*' => {of=>['str*', {in=>[keys %{$table_def->{fields}}]}]}],
        default     => $opts->{default_fields},
        aliases     => $opts->{fields_aliases},
        cat_name    => 'field-selection',
        cat_text    => N__('field selection'),
        summary     => N__('Select fields to return'),
        extra_props => {
            'x.name.is_plural' => 1,
        },
    ) if $opts->{enable_field_selection};
    _add_arg(
        func_meta   => $func_meta,
        langs       => $langs,
        name        => 'exclude_fields',
        type        => ['array*' => {of=>['str*', {in=>[keys %{$table_def->{fields}}]}]}],
        default     => $opts->{default_exclude_fields},
        aliases     => $opts->{exclude_fields_aliases},
        cat_name    => 'field-selection',
        cat_text    => N__('field selection'),
        summary     => N__('Select fields to return'),
        extra_props => {
            'x.name.is_plural' => 1,
            'x.name.singular' => 'exclude_field',
        },
    ) if $opts->{enable_field_selection};
    _add_arg(
        func_meta   => $func_meta,
        langs       => $langs,
        name        => 'sort',
        type        => ['array*', {of=>['str*', {in=>[
            map {($_, "-$_")} grep {$fields->{$_}{sortable}} sort keys %$fields,
        ]}]}],
        default     => $opts->{default_sort},
        aliases     => $opts->{sort_aliases},
        cat_name    => 'ordering',
        cat_text    => N__('ordering'),
        summary     => N__('Order records according to certain field(s)'),
        description => N__(<<'_',

A list of field names separated by comma. Each field can be prefixed with '-' to
specify descending order instead of the default ascending.

_
    )) if $opts->{enable_ordering};
    _add_arg(
        func_meta   => $func_meta,
        langs       => $langs,
        name        => 'random',
        type        => 'bool',
        default     => $opts->{default_random} // 0,
        aliases     => $opts->{random_aliases},
        cat_name    => 'ordering',
        cat_text    => N__('ordering'),
        summary     => N__('Return records in random order'),
    ) if $opts->{enable_ordering} && $opts->{enable_random_ordering};
    _add_arg(
        func_meta   => $func_meta,
        langs       => $langs,
        name        => 'result_limit',
        type        => 'int',
        default     => $opts->{default_result_limit},
        aliases     => $opts->{result_limit_aliases},
        cat_name    => 'paging',
        cat_text    => N__('paging'),
        summary     => N__('Only return a certain number of records'),
    ) if $opts->{enable_paging};
    _add_arg(
        func_meta   => $func_meta,
        langs       => $langs,
        name        => 'result_start',
        aliases     => $opts->{result_start_aliases},
        type        => 'int',
        default     => 1,
        cat_name    => 'paging',
        cat_text    => N__('paging'),
        summary     => N__("Only return starting from the n'th record"),
    ) if $opts->{enable_paging};
    _add_arg(
        func_meta   => $func_meta,
        langs       => $langs,
        name        => 'queries',
        aliases     => $opts->{queries_aliases},
        type        => ['array*', of=>'str*'],
        cat_name    => 'filtering',
        cat_text    => N__('filtering'),
        summary     => N__("Search"),
        pos         => 0,
        slurpy      => 1,
        extra_props => {
            'x.name.is_plural' => 1,
            'x.name.singular' => 'query',
        },
        description => N__(<<'_',

This will search all searchable fields with one or more specified queries. Each
query can be in the form of `-FOO` (dash prefix notation) to require that the
fields do not contain specified string, or `/FOO/` to use regular expression.
All queries must match if the `query_boolean` option is set to `and`; only one
query should match if the `query_boolean` option is set to `or`.

_
                       )
    ) if $opts->{enable_filtering} && $opts->{enable_search};
    _add_arg(
        func_meta   => $func_meta,
        langs       => $langs,
        name        => 'query_boolean',
        aliases     => $opts->{query_boolean_aliases},
        type        => ['str*', {in=>['and','or']}],
        default     => $opts->{default_query_boolean} // 'and',
        cat_name    => 'filtering',
        cat_text    => N__('filtering'),
        summary     => N__("Whether records must match all search queries ('and') or just one ('or')"),
        description => N__(<<'_',

If set to `and`, all queries must match; if set to `or`, only one query should
match. See the `queries` option for more details on searching.

_
                       )
    ) if $opts->{enable_filtering} && $opts->{enable_search};

    # add filter arguments for each table field

    for my $fname (keys %{$table_def->{fields}}) {
        my $fspec   = $table_def->{fields}{$fname};
        my $fschema = $fspec->{schema};
        my $frschema = Data::Sah::Resolve::resolve_schema($fschema);
        my $ftype   = $frschema->{type};

        next unless $opts->{enable_filtering};
        next if defined($fspec->{filterable}) && !$fspec->{filterable};

        unless ($fspec->{include_by_default} // 1) {
            _add_arg(
                func_meta   => $func_meta,
                langs       => $langs,
                name        => "with.$fname",
                type        => "bool",
                default     => 0,
                cat_name    => "field-selection",
                cat_text    => N__('field selection'),
                summary     => N__("Show field '{field}'"),
            );
        }
        _add_arg(
            func_meta   => $func_meta,
            langs       => $langs,
            name        => "$fname.is",
            type        => "$ftype*",
            default     => $opts->{"default_$fname.is"},
            cat_name    => "filtering-for-$fname",
            cat_text    => N__("filtering for {field}"),
            summary     => N__("Only return records where the '{field}' field ".
                                   "equals specified value"),
        );
        unless ($func_args->{$fname}) {
            $func_args->{$fname} =
                clone($func_args->{"$fname.is"});
        }
        _add_arg(
            func_meta   => $func_meta,
            langs       => $langs,
            name        => "$fname.isnt",
            type        => "$ftype*",
            default     => $opts->{"default_$fname.isnt"},
            cat_name    => "filtering-for-$fname",
            cat_text    => N__("filtering for {field}"),
            summary     => N__("Only return records where the '{field}' field ".
                                   "does not equal specified value"),
        );

        # TODO .in & .not_in should be applicable to arrays too
        unless (grep { $_ eq $ftype } (qw/array bool/)) {
            _add_arg(
                func_meta   => $func_meta,
                langs       => $langs,
                name        => "$fname.in",
                type        => ['array*' => {of => "$ftype*"}],
                cat_name    => "filtering-for-$fname",
                cat_text    => N__("filtering for {field}"),
                summary     => N__("Only return records where the '{field}' field ".
                                       "is in the specified values"),
            );
            _add_arg(
                func_meta   => $func_meta,
                langs       => $langs,
                name        => "$fname.not_in",
                type        => ['array*' => {of => "$ftype*"}],
                cat_name    => "filtering-for-$fname",
                cat_text    => N__("filtering for {field}"),
                summary     => N__("Only return records where the '{field}' field ".
                                       "is not in the specified values"),
            );
        }
        if ($ftype eq 'array') {
            _add_arg(
                func_meta   => $func_meta,
                langs       => $langs,
                name        => "$fname.has",
                type        => [array => {of=>'str*'}],
                default     => $opts->{"default_$fname.has"},
                cat_name    => "filtering-for-$fname",
                cat_text    => N__("filtering for {field}"),
                summary     => N__("Only return records where the '{field}' field ".
                                       "is an array/list which contains specified value"),
            );
            _add_arg(
                func_meta   => $func_meta,
                langs       => $langs,
                name        => "$fname.lacks",
                type        => [array => {of=>'str*'}],
                default     => $opts->{"default_$fname.lacks"},
                cat_name    => "filtering-for-$fname",
                cat_text    => N__("filtering for {field}"),
                summary     => N__("Only return records where the '{field}' field ".
                                       "is an array/list which does not contain specified value"),
            );
        }
        if ($ftype =~ /^(?:int|float|str|date)$/) { # XXX all Comparable types
            _add_arg(
                func_meta   => $func_meta,
                langs       => $langs,
                name        => "$fname.min",
                type        => $ftype,
                default     => $opts->{"default_$fname.min"},
                cat_name    => "filtering-for-$fname",
                cat_text    => N__("filtering for {field}"),
                summary     => N__("Only return records where the '{field}' field ".
                    "is greater than or equal to specified value"),
            );
            _add_arg(
                func_meta   => $func_meta,
                langs       => $langs,
                name        => "$fname.max",
                type        => $ftype,
                default     => $opts->{"default_$fname.max"},
                cat_name    => "filtering-for-$fname",
                cat_text    => N__("filtering for {field}"),
                summary     => N__("Only return records where the '{field}' field ".
                                       "is less than or equal to specified value"),
            );
            _add_arg(
                func_meta   => $func_meta,
                langs       => $langs,
                name        => "$fname.xmin",
                type        => $ftype,
                default     => $opts->{"default_$fname.xmin"},
                cat_name    => "filtering-for-$fname",
                cat_text    => N__("filtering for {field}"),
                summary     => N__("Only return records where the '{field}' field ".
                                       "is greater than specified value"),
            );
            _add_arg(
                func_meta   => $func_meta,
                langs       => $langs,
                name        => "$fname.xmax",
                type        => $ftype,
                default     => $opts->{"default_$fname.xmax"},
                cat_name    => "filtering-for-$fname",
                cat_text    => N__("filtering for {field}"),
                summary     => N__("Only return records where the '{field}' field ".
                                       "is less than specified value"),
            );
        }
        if ($ftype eq 'str') {
            _add_arg(
                func_meta   => $func_meta,
                langs       => $langs,
                name        => "$fname.contains",
                type        => $ftype,
                default     => $opts->{"default_$fname.contains"},
                cat_name    => "filtering-for-$fname",
                cat_text    => N__("filtering for {field}"),
                summary     => N__("Only return records where the '{field}' field ".
                                       "contains specified text"),
            );
            _add_arg(
                func_meta   => $func_meta,
                langs       => $langs,
                name        => "$fname.not_contains",
                type        => $ftype,
                default     => $opts->{"default_$fname.not_contains"},
                cat_name    => "filtering-for-$fname",
                cat_text    => N__("filtering for {field}"),
                summary     => N__("Only return records where the '{field}' field ".
                                       "does not contain specified text"),
            );
            if ($fspec->{filterable_regex}) {
                _add_arg(
                    func_meta   => $func_meta,
                    langs       => $langs,
                    name        => "$fname.matches",
                    type        => $ftype,
                    default     => $opts->{"default_$fname.matches"},
                    cat_name    => "filtering-for-$fname",
                    cat_text    => N__("filtering for {field}"),
                    summary     => N__("Only return records where the '{field}' field ".
                                           "matches specified regular expression pattern"),
                );
                _add_arg(
                    func_meta   => $func_meta,
                    langs       => $langs,
                    name        => "$fname.not_matches",
                    type        => $ftype,
                    default     => $opts->{"default_$fname.not_matches"},
                    cat_name    => "filtering-for-$fname",
                    cat_text    => N__("filtering for {field}"),
                    summary     => N__("Only return records where the '{field}' field " .
                                           "does not match specified regular expression"),
                );
            }
        }
    } # for each fspec

    # custom filters
    if ($opts->{enable_filtering}) {
        my $cff = $opts->{custom_filters} // {};
        while (my ($cfn, $cf) = each %$cff) {
            $func_args->{$cfn} and return [
                400, "Custom filter '$cfn' clashes with another argument"];
            $func_args->{$cfn} = $cf->{meta};
        }
    }

    # extra arguments
    my $ea = $opts->{extra_args} // {};
    $func_args->{$_} = $ea->{$_} for keys %$ea;

    # extra metadata properties
    my $extra_props = $opts->{extra_props} // {};
    $func_meta->{$_} = $extra_props->{$_} for keys %$extra_props;

    [200, "OK", $func_meta];
}

sub __parse_query {
    require Data::Sah::Resolve;

    my ($table_def, $opts, $func_meta, $args) = @_;
    my $query = {args=>$args};

    my $fspecs = $table_def->{fields};
    # reminder: index property is for older spec, will be removed someday
    my @fields = sort {($fspecs->{$a}{pos}//$fspecs->{$a}{index}) <=>
                           ($fspecs->{$b}{pos}//$fspecs->{$b}{index})}
        keys %$fspecs;

    my @requested_fields;
  SELECT_FIELDS:
    {
        if ($args->{detail} || $args->{exclude_fields}) {
            @requested_fields = grep {
                ($fspecs->{$_}{include_by_default} // 1) ||
                    $args->{"with.$_"}
                } @fields;
            if ($args->{exclude_fields}) {
                my @filtered_fields;
                for my $field (@requested_fields) {
                    next if grep { $field eq $_ } @{ $args->{exclude_fields} };
                    push @filtered_fields, $field;
                }
                @requested_fields = @filtered_fields;
            }
            $args->{with_field_names} //= $args->{detail} ? 1:0;
        } elsif ($args->{fields}) {
            @requested_fields = @{ $args->{fields} };
            $args->{with_field_names} //= 0;
        } else {
            @requested_fields = ($table_def->{pk});
            $args->{with_field_names} //= 0;
        }
    } # SELECT_FIELDS

    for my $f (@requested_fields) {
        return err(400, "Unknown field $f") unless grep { $_ eq $f } @fields;
    }
    $query->{requested_fields} = \@requested_fields;

    my @filter_fields;
    my @filters; # ([field, field-type, operator, operand...])
    my %frschemas;

    for my $f (@fields) {
        $frschemas{$f} = Data::Sah::Resolve::resolve_schema($fspecs->{$f}{schema});
    }

    my $cic = $opts->{case_insensitive_comparison};

    for my $f (grep {$frschemas{$_}{type} eq 'bool'} @fields) {
        my $fspec = $fspecs->{$f};
        my $ftype = $frschemas{$f}{type};
        my $exists;
        if (defined $args->{"$f.is"}) {
            $exists++;
            push @filters, [$f, $ftype, "truth", $args->{"$f.is"}, $cic];
        } elsif (defined $args->{"$f.isnt"}) {
            $exists++;
            push @filters, [$f, $ftype, "truth", !$args->{"$f.isnt"}, $ftype, $cic];
        } elsif (defined($args->{$f}) && __is_filter_arg($f, $func_meta)) {
            $exists++;
            push @filters, [$f, $ftype, "truth", $args->{$f}, $ftype, $cic];
        }
        push @filter_fields, $f if $exists && !(grep { $_ eq $f } @filter_fields);
    }

    for my $f (grep {$frschemas{$_}{type} eq 'array'} @fields) {
        my $fspec = $fspecs->{$f};
        my $ftype = $frschemas{$f}{type};
        my $exists;
        if (defined $args->{"$f.has"}) {
            $exists++;
            push @filters, [$f, $ftype, "~~", $args->{"$f.has"}, $ftype, $cic];
        }
        if (defined $args->{"$f.lacks"}) {
            $exists++;
            push @filters, [$f, $ftype, "!~~", $args->{"$f.lacks"}, $ftype, $cic];
        }
        push @filter_fields, $f if $exists && !(grep { $_ eq $f } @filter_fields);
    }

    for my $f (grep { $frschemas{$_}{type} ne 'array' && $frschemas{$_}{type} ne 'bool' } @fields) {
        my $fspec = $fspecs->{$f};
        my $ftype = $frschemas{$f}{type};
        my $exists;
        if (defined $args->{"$f.in"}) {
            $exists++;
            push @filters, [$f, $ftype, "in", $args->{"$f.in"}, $cic];
        }
        if (defined $args->{"$f.not_in"}) {
            $exists++;
            push @filters, [$f, $ftype, "not_in", $args->{"$f.not_in"}, $cic];
        }
    }

    for my $f (grep {$frschemas{$_}{type} =~ /^(int|float|str|date)$/}
                   @fields) { # XXX all Comparable
        my $fspec = $fspecs->{$f};
        my $ftype = $frschemas{$f}{type};
        my $exists;
        if (defined $args->{"$f.is"}) {
            $exists++;
            push @filters,
                [$f, $ftype, "==", $args->{"$f.is"}, $cic];
        } elsif (defined($args->{$f}) && __is_filter_arg($f,  $func_meta)) {
            $exists++;
            push @filters, [$f, $ftype, "==", $args->{$f}, $cic];
        }
        if (defined $args->{"$f.isnt"}) {
            $exists++;
            push @filters,
                [$f, $ftype, "!=", $args->{"$f.isnt"}, $cic];
        } elsif (defined($args->{$f}) && __is_filter_arg($f,  $func_meta)) {
            $exists++;
            push @filters, [$f, $ftype, "==", $args->{$f}, $cic];
        }
        if (defined $args->{"$f.min"}) {
            $exists++;
            push @filters, [$f, $ftype, '>=', $args->{"$f.min"}, $cic];
        }
        if (defined $args->{"$f.max"}) {
            $exists++;
            push @filters, [$f, $ftype, '<=', $args->{"$f.max"}, $cic];
        }
        if (defined $args->{"$f.xmin"}) {
            $exists++;
            push @filters, [$f, $ftype, '>', $args->{"$f.xmin"}, $cic];
        }
        if (defined $args->{"$f.xmax"}) {
            $exists++;
            push @filters, [$f, $ftype, '<', $args->{"$f.xmax"}, $cic];
        }
        push @filter_fields, $f if $exists && !(grep { $_ eq $f } @filter_fields);
    }

    for my $f (grep {$frschemas{$_}{type} =~ /^str$/} @fields) {
        my $fspec = $fspecs->{$f};
        my $ftype = $frschemas{$f}{type};
        my $exists;
        if (defined $args->{"$f.contains"}) {
            $exists++;
            push @filters, [$f, $ftype, 'pos', $args->{"$f.contains"}, $cic];
        }
        if (defined $args->{"$f.not_contains"}) {
            $exists++;
            push @filters, [$f, $ftype, '!pos', $args->{"$f.not_contains"}, $cic];
        }
        if (defined $args->{"$f.matches"}) {
            $exists++;
            push @filters, [$f, $ftype, '=~', $args->{"$f.matches"}, $cic];
        }
        if (defined $args->{"$f.not_matches"}) {
            $exists++;
            push @filters, [$f, $ftype, '!~', $args->{"$f.not_matches"}, $cic];
        }
        push @filter_fields, $f if $exists && !(grep { $_ eq $f } @filter_fields);
    }
    $query->{filters}       = \@filters;
    $query->{filter_fields} = \@filter_fields;

    my $cff = $opts->{custom_filters} // {};
    while (my ($cfn, $cf) = each %$cff) {
        next unless defined $args->{$cfn};
        push @filters, [$cf->{fields}, undef, 'call', [$cf->{code}, $args->{$cfn}], $cic];
        for my $f (@{$cf->{fields} // []}) {
            push @filter_fields, $f if !(grep { $_ eq $f } @filter_fields);
        }
    }

    my $search_re;
    my $search_opts = {ci => $opts->{case_insensitive_search}};
    my @searchable_fields = grep {
        !defined($fspecs->{$_}{searchable}) || $fspecs->{$_}{searchable}
        } @fields;
    my $q  = $args->{query}; # old, still supported
    my $qq = $args->{queries};
    my @qq = defined $qq && @$qq ? @$qq : defined $q ? ($q) : ();
    if (@qq) {
        require String::Query::To::Regexp;
        $search_re = String::Query::To::Regexp::query2re(
            {
                word => $opts->{word_search},
                bool => $args->{query_boolean} // $opts->{default_query_boolean} // 'and',
                ci   => $opts->{case_insensitive_search},
                re   => 1,
            },
            @qq);
    }
    $query->{queries} = @qq ? \@qq : undef;
    $query->{search_opts} = $args->{search_opts};
    unless ($opts->{custom_search}) {
        $query->{search_fields} = \@searchable_fields;
        $query->{search_str_fields} = [grep {
            $frschemas{$_}{type} =~ /^(str)$/
        } @searchable_fields];
        $query->{search_array_fields} = [grep {
            $frschemas{$_}{type} =~ /^(array)$/
        } @searchable_fields];
        $query->{search_re} = $search_re;
    }

    my @sort_fields;
    my @sorts;
    if (defined $args->{sort}) {
        for my $f (@{ $args->{sort} }) {
            my $desc = $f =~ s/^-//;
            return err(400, "Unknown field in sort: $f")
                unless grep { $_ eq $f } @fields;
            my $fspec = $fspecs->{$f};
            my $ftype = $frschemas{$f}{type};
            return err(400, "Field $f is not sortable")
                unless !defined($fspec->{sortable}) || $fspec->{sortable};
            my $op = $ftype =~ /^(int|float)$/ ? '<=>' : 'cmp';
            #print "ftype=$ftype, op=$op\n";
            push @sorts, [$f, $op, $desc ? -1:1];
            push @sort_fields, $f;
        }
    }
    $query->{random}      = $args->{random};
    $query->{sorts}       = \@sorts;
    $query->{sort_fields} = \@sort_fields;

    my @mentioned_fields =
        keys %{{ map {$_=>1} @requested_fields,
                     @filter_fields, @sort_fields }};
    $query->{mentioned_fields} = \@mentioned_fields;

    $query->{result_limit} = $args->{result_limit};
    $query->{result_start} = $args->{result_start} // 1;

    log_trace("parsed query: %s", $query);
    [200, "OK", $query];
}

sub _gen_func {
    my ($table_def, $opts, $table_data, $func_meta) = @_;

    my $fspecs = $table_def->{fields};
    my $func_args = $func_meta->{args};
    my $func = sub {
        my %args = @_;
        my $hooks = $opts->{hooks};
        my %hookargs = %args;
        $hookargs{_func_args} = \%args;

        # XXX schema
        while (my ($ak, $av) = each %$func_args) {
            if (ref($av->{schema}) && ref($av->{schema}[1]) &&
                    defined($av->{schema}[1]{default})) {
                $args{$ak} //= $av->{schema}[1]{default};
            }
            # array-ize "string,with,comma"
            if ($ak =~ /\A(exclude_fields|fields)\z/ && defined($args{$ak})) {
                $args{$ak} = [split /\s*[,;]\s*/, $args{$ak}]
                    unless ref($args{$ak}) eq 'ARRAY';
            }
        }

        for my $hookname ('before_parse_query') {
            last unless $hooks->{$hookname};
            local $hookargs{_stage} = $hookname;
            my $hres = $hooks->{$hookname}->(%hookargs);
            return $hres if ref($hres);
        }
        my $query;
      PARSE_QUERY: {
            my $res = __parse_query($table_def, $opts, $func_meta, \%args);
            $hookargs{_parse_res} = $res;
            for my $hookname ('after_parse_query') {
                last unless $hooks->{$hookname};
                local $hookargs{_stage} = $hookname;
                my $hres = $hooks->{$hookname}->(%hookargs);
                return $hres if ref($hres);
            }
            return $res unless $res->[0] == 200;
            $query = $res->[2];
        } # PARSE_QUERY

        # retrieve data
        my $data;
        my $metadata = {};
        $hookargs{_query} = $query;

        for my $hookname ('before_fetch_data') {
            last unless $hooks->{$hookname};
            $hookargs{_stage} = $hookname;
            my $hres = $hooks->{$hookname}->(%hookargs);
            return $hres if ref($hres);
        }
        if (ref($table_data) =~ /\ATableData::/) {
            $data = [];
            while ($table_data->has_next_item) {
                push @$data, $table_data->get_next_item;
            }
        } elsif (__is_aoa($table_data) || __is_aoh($table_data)) {
            $data = $table_data;
        } elsif (ref($table_data) eq 'CODE') {
            my $res;
            return err(500, "BUG: Table data function died: $@")
                unless eval { $res = $table_data->($query) };
            return err(500, "BUG: Result returned from table data function ".
                           "is not a hash") unless ref($res) eq 'HASH';
            $data = $res->{data};
            return err(500, "BUG: 'data' key from table data function ".
                           "is not an AoA/AoH")
                unless __is_aoa($data) || __is_aoh($data);
            for (qw/filtered sorted paged fields_selected/) {
                $metadata->{$_} = $res->{$_};
            }
        } else {
            # this should be impossible, already checked earlier
            die "BUG: 'data' from table data function is not an array";
        }
        $hookargs{_data} = $data;

        for my $hookname ('after_fetch_data') {
            last unless $hooks->{$hookname};
            $hookargs{_stage} = $hookname;
            my $hres = $hooks->{$hookname}->(%hookargs);
            return $hres if ref($hres);
        }

        # this will be the final result.
        my @r;

        no warnings; # silence undef warnings when comparing record values

        log_trace("(read_table_func) Filtering ...");
        my $qq = $query->{queries};
        my $search_re = $query->{search_re};

        if (grep { $_->[1] eq 'date' } @{ $query->{filters} }) {
            require Data::Sah::Util::Type::Date;
            Data::Sah::Util::Type::Date->import('coerce_date');
        }

        local $Data::Sah::Util::Type::Date::DATE_MODULE = 'Time::Moment'
            if %Data::Sah::Util::Type::Date::;

      REC:
        for my $r0 (@$data) {
            my $r_h;
            if (ref($r0) eq 'ARRAY') {
                # currently, internally we always use hashref for records and
                # convert to array/scalar later when returning final data.
                $r_h = {};
                for my $f (keys %$fspecs) {
                    # reminder: index property is for older spec, will be
                    # removed someday
                    $r_h->{$f} = $r0->[$fspecs->{$f}{pos}//$fspecs->{$f}{index}];
                }
            } elsif (ref($r0) eq 'HASH') {
                $r_h = { %$r0 };
            } else {
                return err(500, "BUG: Invalid record, not a hash/array");
            }

            goto SKIP_FILTER if $metadata->{filtered};

            for my $filter (@{$query->{filters}}) {
                my ($f, $ftype, $op, $opn, $cic) = @$filter;
                my $stringy = $ftype eq 'str' || $ftype eq 'cistr';
                $cic = 1 if $ftype eq 'cistr';
                if ($op eq 'truth') {
                    next REC if $r_h->{$f} xor $opn;
                } elsif ($op eq '~~') {
                    if ($stringy) {
                        if ($cic) {
                            my @vals = map {lc} @{$r_h->{$f}};
                            for my $o (@$opn) {
                                my $lc_o = lc $o;
                                next REC unless grep { $_ eq $lc_o } @vals;
                            }
                        } else {
                            for my $o (@$opn) {
                                next REC unless grep { $_ eq $o } @{$r_h->{$f}};
                            }
                        }
                    } else {
                        for my $o (@$opn) {
                            next REC unless grep { $_ eq $o } @{$r_h->{$f}};
                        }
                    }
                } elsif ($op eq '!~~') {
                    if ($stringy) {
                        if ($cic) {
                            my @vals = map {lc} @{$r_h->{$f}};
                            for my $o (@$opn) {
                                my $lc_o = lc $o;
                                next REC if grep { $_ eq $lc_o } @vals;
                            }
                        } else {
                            for my $o (@$opn) {
                                next REC if grep { $_ eq $o } @{$r_h->{$f}};
                            }
                        }
                    } else {
                        for my $o (@$opn) {
                            next REC if grep { $_ eq $o } @{$r_h->{$f}};
                        }
                    }
                } elsif ($op eq 'in') {
                    if ($stringy) {
                        if ($cic) {
                            my @vals = map {lc} @$opn;
                            my $lc = lc($r_h->{$f});
                            next REC unless grep { $_ eq $lc } @vals;
                            #next REC unless $lc ~~ @vals;
                        } else {
                            next REC unless grep { $_ eq $r_h->{$f} } @$opn;
                            #next REC unless $r_h->{$f} ~~ @$opn;
                        }
                    } else {
                        next REC unless grep { $_ == $r_h->{$f} } @$opn;
                    }
                } elsif ($op eq 'not_in') {
                    if ($stringy) {
                        if ($cic) {
                            my @vals = map {lc} @$opn;
                            my $lc = lc($r_h->{$f});
                            next REC if grep { $_ eq $lc } @vals;
                            #next REC if $lc ~~ @vals;
                        } else {
                            next REC if grep { $_ eq $r_h->{$f} } @$opn;
                            #next REC if $r_h->{$f} ~~ @$opn;
                        }
                    } else {
                        next REC if grep { $_ == $r_h->{$f} } @$opn;
                    }
                } elsif ($op eq '==' && $stringy && $cic) {
                    next REC unless lc $r_h->{$f} eq lc $opn;
                } elsif ($op eq '==' && $stringy) {
                    next REC unless $r_h->{$f} eq $opn;
                } elsif ($op eq '==' && $ftype eq 'date') {
                    my $dopn = coerce_date($opn);
                    my $d = coerce_date($r_h->{$f});
                    next REC unless $dopn && $d;
                    next REC unless $d->compare($dopn) == 0;
                } elsif ($op eq '==') {
                    next REC unless $r_h->{$f} == $opn;

                } elsif ($op eq '!=' && $stringy && $cic) {
                    next REC unless lc $r_h->{$f} ne lc $opn;
                } elsif ($op eq '!=' && $stringy) {
                    next REC unless $r_h->{$f} ne $opn;
                } elsif ($op eq '!=' && $ftype eq 'date') {
                    my $dopn = coerce_date($opn);
                    my $d = coerce_date($r_h->{$f});
                    next REC unless $dopn && $d;
                    next REC unless $d->compare($dopn) != 0;
                } elsif ($op eq '!=') {
                    next REC unless $r_h->{$f} != $opn;

                } elsif ($op eq '>=' && $stringy && $cic) {
                    next REC unless lc $r_h->{$f} ge lc $opn;
                } elsif ($op eq '>=' && $stringy) {
                    next REC unless $r_h->{$f} ge $opn;
                } elsif ($op eq '>=' && $ftype eq 'date') {
                    my $dopn = coerce_date($opn);
                    my $d = coerce_date($r_h->{$f});
                    next REC unless $dopn && $d;
                    next REC unless $d->compare($dopn) >= 0;
                } elsif ($op eq '>=') {
                    next REC unless $r_h->{$f} >= $opn;

                } elsif ($op eq '>'  && $stringy && $cic) {
                    next REC unless lc $r_h->{$f} gt lc $opn;
                } elsif ($op eq '>'  && $stringy) {
                    next REC unless $r_h->{$f} gt $opn;
                } elsif ($op eq '>'  && $ftype eq 'date') {
                    my $dopn = coerce_date($opn);
                    my $d = coerce_date($r_h->{$f});
                    next REC unless $dopn && $d;
                    next REC unless $d->compare($dopn) >  0;
                } elsif ($op eq '>' ) {
                    next REC unless $r_h->{$f} >  $opn;

                } elsif ($op eq '<=' && $stringy && $cic) {
                    next REC unless lc $r_h->{$f} le lc $opn;
                } elsif ($op eq '<=' && $stringy) {
                    next REC unless $r_h->{$f} le $opn;
                } elsif ($op eq '<=' && $ftype eq 'date') {
                    my $dopn = coerce_date($opn);
                    my $d = coerce_date($r_h->{$f});
                    next REC unless $dopn && $d;
                    next REC unless $d->compare($dopn) <= 0;
                } elsif ($op eq '<=') {
                    next REC unless $r_h->{$f} <= $opn;

                } elsif ($op eq '<'  && $stringy) {
                    next REC unless lc $r_h->{$f} lt lc $opn;
                } elsif ($op eq '<'  && $stringy) {
                    next REC unless $r_h->{$f} lt $opn;
                } elsif ($op eq '<'  && $ftype eq 'date') {
                    my $dopn = coerce_date($opn);
                    my $d = coerce_date($r_h->{$f});
                    next REC unless $dopn && $d;
                    next REC unless $d->compare($dopn) <  0;
                } elsif ($op eq '<' ) {
                    next REC unless $r_h->{$f} <  $opn;

                # XXX case-insensitive regex matching
                } elsif ($op eq '=~') {
                    next REC unless $r_h->{$f} =~ $opn;

                # XXX case-insensitive regex negative matching
                } elsif ($op eq '!~') {
                    next REC unless $r_h->{$f} !~ $opn;

                } elsif ($op eq 'pos' && $cic) {
                    next REC unless index(lc $r_h->{$f}, lc $opn) >= 0;
                } elsif ($op eq 'pos') {
                    next REC unless index($r_h->{$f}, $opn) >= 0;

                } elsif ($op eq '!pos' && $cic) {
                    next REC if index(lc $r_h->{$f}, lc $opn) >= 0;
                } elsif ($op eq '!pos') {
                    next REC if index($r_h->{$f}, $opn) >= 0;

                } elsif ($op eq 'call') {
                    next REC unless $opn->[0]->($r_h, $opn->[1]);

                } else {
                    die "BUG: Unknown op $op";
                }
            }

            if (defined $qq) {
                if ($opts->{custom_search}) {
                    next REC unless $opts->{custom_search}->(
                        $r_h, $qq, $query->{search_opts});
                } else {
                    my $match;
                    for my $f (@{$query->{search_str_fields}}) {
                        if ($r_h->{$f} =~ $search_re) {
                            $match++; last;
                        }
                    }
                  ARY_FIELD:
                    for my $f (@{$query->{search_array_fields}}) {
                        for my $el (@{$r_h->{$f}}) {
                            if ($el =~ $search_re) {
                                $match++; last ARY_FIELD;
                            }
                        }
                    }
                    next REC unless $match;
                }
            }

          SKIP_FILTER:

            push @r, $r_h;
        }

        log_trace("(read_table_func) Ordering ...");
        if ($metadata->{sorted}) {
            # do nothing
        } elsif ($query->{random}) {
            @r = shuffle @r;
        } elsif (@{$query->{sorts}}) {
            @r = sort {
                for my $s (@{$query->{sorts}}) {
                    my ($f, $op, $desc) = @$s;
                    my $x;
                    if ($op eq 'cmp') {
                        $x = $a->{$f} cmp $b->{$f};
                    } else {
                        $x = $a->{$f} <=> $b->{$f};
                    }
                    #print "$a->{$f} $op $b->{$f} = $x (desc=$desc)\n";
                    return $x*$desc if $x != 0;

                }
                0;
            } @r;
        }

        use warnings;

        # perform paging
        log_trace("(read_table_func) Paging ...");
        unless ($metadata->{paged}) {
            if ($query->{result_start} > 1) {
                splice @r, 0, $query->{result_start}-1;
            }
            if (defined $query->{result_limit}) {
                splice @r, $query->{result_limit};
            }
        }

        # select fields
        log_trace("(read_table_func) Selecting fields ...");
        my $pk = $table_def->{pk};
        goto SKIP_SELECT_FIELDS if $metadata->{fields_selected};
      REC2:
        for my $r (@r) {
            if (!$args{detail} && !$args{fields} && !$args{exclude_fields}) {
                $r = $r->{$pk};
                next REC2;
            }
            if ($args{with_field_names}) {
                my @f = keys %$fspecs;
                for my $f (@f) {
                    delete $r->{$f}
                        unless grep { $_ eq $f } @{$query->{requested_fields}};
                }
            } else {
                $r = [map {$r->{$_}} @{$query->{requested_fields}}];
            }
        }
      SKIP_SELECT_FIELDS:

        my $resmeta = {};
        my $res = [200, "OK", \@r, $resmeta];

        $resmeta->{'table.fields'} = $query->{requested_fields};
        $hookargs{_func_res} = $res;

        for my $hookname ('before_return') {
            last unless $hooks->{$hookname};
            $hookargs{_stage} = $hookname;
            my $hres = $hooks->{$hookname}->(%hookargs);
            return $hres if ref($hres);
        }

        $res;
    }; # func;

    [200, "OK", $func];
}

$SPEC{gen_read_table_func} = {
    v => 1.1,
    summary => 'Generate function (and its metadata) to read table data',
    description => <<'_',

The generated function acts like a simple single table SQL SELECT query,
featuring filtering, ordering, and paging, but using arguments as the 'query
language'. The generated function is suitable for exposing a table data from an
API function.

The resulting function returns an array of results/records and accepts these
arguments.

* *with_field_names* => BOOL (default 1)

  If set to 1, function will return records of field values along with field
  names (hashref), e.g. {id=>'ID', country=>'Indonesia', capital=>'Jakarta'}. If
  set to 0, then function will return record containing field values without
  field names (arrayref) instead, e.g.: ['ID', 'Indonesia', 'Jakarta'].

* *detail* => BOOL (default 0)

  This is a field selection option. If set to 0, function will return PK field
  only. If this argument is set to 1, then all fields will be returned (see also
  *fields* to instruct function to return some fields only).

* *fields* => ARRAY

  This is a field selection option. If you only want certain fields, specify
  them here (see also *detail*).

* *result_limit* => INT (default undef)

* *result_start* => INT (default 1)

  The *result_limit* and *result_start* arguments are paging options, they work
  like LIMIT clause in SQL, except that index starts at 1 and not 0. For
  example, to return the first 20 records in the result, set *result_limit* to
  20 . To return the next 20 records, set *result_limit* to 20 and
  *result_start* to 21.

* *random* => BOOL (default 0)

  The random argument is an ordering option. If set to true, order of records
  returned will be shuffled first. This happened before paging.

* *sort* => array of str

  The sort argument is an ordering option, containing names of field. A `-`
  prefix before the field name signifies descending instead of ascending order.
  Multiple fields are allowed for secondary sort fields.

* *q* => ARRAY[STR]

  A filtering option. By default, all fields except those specified with
  searchable=0 will be searched using simple case-insensitive string search.
  There are a few options to customize this, using these gen arguments:
  *word_search*, *case_insensitive_search*, *custom_search*,
  *default_query_boolean*.

* *query_boolean* => STR

  Either `and` or `or`. Default can be set with gen argument
  *default_query_boolean*. With `and`, all the words in *q* argument must match.
  With `or`, only one of the words in *q* argument must match.

* Filter arguments

  They will be generated for each field, except when field has 'filterable'
  clause set to false.

  Undef values will not match any filter, just like NULL in SQL.

  * *FIELD.is* and *FIELD.isnt* arguments for each field. Only records with
     field equalling (or not equalling) value exactly ('==' or 'eq') will be
     included. If doesn't clash with other function arguments, *FIELD* will also
     be added as an alias for *FIELD.is*.

  * *FIELD.has* and *FIELD.lacks* array arguments for each set field. Only
    records with field having or lacking certain value will be included.

  * *FIELD.min* and *FIELD.max* for each int/float/str field. Only records with
    field greater/equal than, or less/equal than a certain value will be
    included.

  * *FIELD.contains* and *FIELD.not_contains* for each str field. Only records
    with field containing (or not containing) certain value (substring) will be
    included.

  * *FIELD.matches* and *FIELD.not_matches* for each str field. Only records
    with field matching (or not matching) certain value (regex) (or will be
    included. Function will return 400 if regex is invalid. These arguments will
    not be generated if 'filterable_regex' clause in field specification is set
    to 0.

_
    args => {
        %Perinci::Sub::Gen::common_args,
        table_data => {
            req => 1,
            schema => ['any*' => of => ['array*', 'code*', 'obj*']],
            summary => 'Data',
            description => <<'_',

Table data is either an AoH/AoA, or a <pm:TableData> object, or a coderef.

Passing a subroutine lets you fetch data dynamically and from arbitrary source
(e.g. DBI table or other external sources). The subroutine will be called with
these arguments ('$query') and is expected to return a hashref like this {data
=> DATA, paged=>BOOL, filtered=>BOOL, sorted=>BOOL, fields_selected=>BOOL}. DATA
is AoA or AoH. If paged is set to 1, data is assumed to be already paged and
won't be paged again; likewise for filtered, sorted, and fields selected. These
are useful for example with DBI result, where requested data is already
filtered/sorted (including randomized)/field selected/paged via appropriate SQL
query. This way, the generated function will not attempt to duplicate the
efforts.

'$query' is a hashref which contains information about the query, e.g. 'args'
(the original arguments passed to the generated function, e.g. {random=>1,
result_limit=>1, field1_match=>'f.+'}), 'mentioned_fields' which lists fields
that are mentioned in either filtering arguments or fields or ordering,
'requested_fields' (fields mentioned in list of fields to be returned),
'sort_fields' (fields mentioned in sort arguments), 'filter_fields' (fields
mentioned in filter arguments).

_
        },
        table_def => {
            schema => 'hash*',
            summary => 'Table definition',
            description => <<'_',

Required, unless `table_data` argument is a <pm:TableData> object, in which case
table definition will be retrieved from the object if not supplied.

See <pm:TableDef> for more details.

A hashref with these required keys: 'fields', 'pk'. 'fields' is a hashref of
field specification with field name as keys, while 'pk' specifies which field is
to be designated as the primary key. Currently only single-field PK is allowed.

Field specification. A hashref with these required keys: 'schema' (a Sah
schema), 'index' (an integer starting from 0 that specifies position of field in
the record, required with AoA data) and these optional clauses: 'sortable' (a
boolean stating whether field can be sorted, default is true), 'filterable' (a
boolean stating whether field can be mentioned in filter options, default is
true).

_
        },
        langs => {
            schema => [array => {of=>'str*', default=>['en_US']}],
            summary => 'Choose language for function metadata',
            description => <<'_',

This function can generate metadata containing text from one or more languages.
For example if you set 'langs' to ['en_US', 'id_ID'] then the generated function
metadata might look something like this:

    {
        v => 1.1,
        args => {
            random => {
                summary => 'Random order of results', # English
                "summary.alt.lang.id_ID" => "Acak urutan hasil", # Indonesian
                ...
            },
            ...
        },
        ...
    }

_
        },
        default_detail => {
            schema => 'bool',
            summary => "Supply default 'detail' value for function arg spec",
        },
        default_fields => {
            schema => 'str',
            summary => "Supply default 'fields' value for function arg spec",
        },
        default_exclude_fields => {
            schema => 'str',
            summary => "Supply default 'exclude_fields' value for function arg spec",
        },
        default_with_field_names => {
            schema => 'bool',
            summary => "Supply default 'with_field_names' ".
                "value in generated function's metadata",
        },
        default_sort => {
            schema => ['array*', of=>'str*'],
            summary => "Supply default 'sort' ".
                "value in generated function's metadata",
        },
        default_random => {
            schema => 'bool',
            summary => "Supply default 'random' ".
                "value in generated function's metadata",
        },
        default_result_limit => {
            schema => 'int',
            summary => "Supply default 'result_limit' ".
                "value in generated function's metadata",
        },
        enable_filtering => {
            schema => ['bool' => {
                default => 1,
            }],
            summary => "Decide whether generated function will support ".
                "filtering (the FIELD, FIELD.is, FIELD.min, etc arguments)",
        },
        enable_search => {
            schema => ['bool' => {
                default => 1,
            }],
            summary => "Decide whether generated function will support ".
                "searching (argument q)",
            description => <<'_',

Filtering must also be enabled (`enable_filtering`).

_
        },
        word_search => {
            schema => ['bool' => {
                default => 0,
            }],
            summary => "Decide whether generated function will perform ".
                "word searching instead of string searching",
            description => <<'_',

For example, if search term is 'pine' and field value is 'green pineapple',
search will match if word_search=false, but won't match under word_search.

This will not have effect under 'custom_search'.

_
        },
        default_arg_values => {
            schema => 'hash',
            summary => "Specify defaults for generated function's arguments",
            description => <<'_',

Can be used to supply default filters, e.g.

    # limit years for credit card expiration date
    { "year.min" => $curyear, "year.max" => $curyear+10, }

_
        },
        default_query_boolean => {
            schema => ['str', {in=>['and', 'or']}],
            default => 'and',
            summary => "Specify default for --query-boolean option",
        },
        case_insensitive_search => {
            schema => ['bool' => {
                default => 1,
            }],
            summary => 'Decide whether generated function will perform '.
                'case-insensitive search',
        },
        case_insensitive_comparison => {
            schema => ['bool' => {
                default => 1,
            }],
            summary => 'Decide whether generated function will perform '.
                'case-insensitive comparison (e.g. for FIELD.is)',
        },
        custom_search => {
            schema => 'code',
            summary => 'Supply custom searching for generated function',
            description => <<'_',

Code will be supplied ($r, $q, $opts) where $r is the record (hashref), $q is
the search term (from the function argument 'q'), and $opts is {ci=>0|1}. Code
should return true if record matches search term.

_
        },
        enable_ordering => {
            schema => ['bool' => {
                default => 1,
            }],
            summary => "Decide whether generated function will support ".
                "ordering (the `sort` & `random` arguments)",
        },
        enable_random_ordering => {
            schema => ['bool' => {
                default => 1,
            }],
            summary => "Decide whether generated function will support ".
                "random ordering (the `random` argument)",
            description => <<'_',

Ordering must also be enabled (`enable_ordering`).

_
        },
        enable_paging => {
            schema => ['bool' => {
                default => 1,
            }],
            summary => "Decide whether generated function will support ".
                "paging (the `result_limit` & `result_start` arguments)",
        },
        enable_field_selection => {
            schema => ['bool' => {
                default => 1,
            }],
            summary => "Decide whether generated function will support ".
                "field selection (the `fields` argument)",
        },
        extra_args => {
            schema => ['hash*'],
            summary => 'Extra arguments for the generated function',
        },
        extra_props => {
            schema => ['hash*'],
            summary => 'Extra metadata properties for the generated function metadata',
        },
        custom_filters => {
            schema => [hash => {of=>['hash*' => {keys=>{
                'code'=>'code*', 'meta'=>'hash*'}}]}],
            summary => 'Supply custom filters',
            description => <<'_',

A hash of filter name and definitions. Filter name will be used as generated
function's argument and must not clash with other arguments. Filter definition
is a hash containing these keys: *meta* (hash, argument metadata), *code*,
*fields* (array, list of table fields related to this field).

Code will be called for each record to be filtered and will be supplied ($r, $v,
$opts) where $v is the filter value (from the function argument) and $r the
hashref record value. $opts is currently empty. Code should return true if
record satisfies the filter.

_
        },
        hooks => {
            schema      => [hash => {of=>'code*'}],
            summary     => 'Supply hooks',
            description => <<'_',

You can instruct the generated function to execute codes in various stages by
using hooks. Currently available hooks are (in execution order):

- before_parse_query
- after_parse_query
- before_fetch_data
- after_fetch_data
- before_return

Hooks will be passed the function arguments as well as one or more additional
ones.

- All hooks will get `_stage` (name of stage) and `_func_args` (function
  arguments, but as hash reference so you can modify it).
- `after_parse_query` and later hooks will also get `_parse_res` (parse
  enveloped result)
- `before_fetch_data` and later will also get `_query` (parsed query, which is
  just the payload a.k.a. third element of `_parse_res`).
- `after_fetch_data` and later will also get `_data`.
- `before_return` will also get `_func_res` (the enveloped response to be
  returned to user).

Hook should return nothing or a false value on success. It can abort execution
of the generated function if it returns an envelope response (an array). In that
case, the function will return with this return value.

_
        },

        result_limit_aliases => {
            schema => 'hash*',
        },
        result_start_aliases => {
            schema => 'hash*',
        },
        with_field_names_aliases => {
            schema => 'hash*',
        },
        detail_aliases => {
            schema => 'hash*',
        },
        fields_aliases => {
            schema => 'hash*',
        },
        exclude_fields_aliases => {
            schema => 'hash*',
        },
        sort_aliases => {
            schema => 'hash*',
        },
        random_aliases => {
            schema => 'hash*',
        },
        queries_aliases => {
            schema => 'hash*',
        },

    }, # args
    result => {
        summary => 'A hash containing generated function, metadata',
        schema => 'hash*',
        description => <<'_',
_
    },
};
sub gen_read_table_func {
    my %args = @_;

    # XXX schema
    my ($uqname, $package);
    my $fqname = $args{name};
    return [400, "Please specify name"] unless $fqname;
    my @caller = caller();
    if ($fqname =~ /(.+)::(.+)/) {
        $package = $1;
        $uqname  = $2;
    } else {
        $package = $args{package} // $caller[0];
        $uqname  = $fqname;
        $fqname  = "$package\::$uqname";
    }
    my $table_data = $args{table_data}
        or return [400, "Please specify table_data"];
    __is_aoa($table_data) or __is_aoh($table_data) or
        ref($table_data) =~ /\ATableData::/ or
        ref($table_data) eq 'CODE'
            or return [400, "Invalid table_data: must be AoA/AoH/TableData obj/function"];
    my $table_def = $args{table_def} //
        $args{"table_"."spec"}; # old name, deprecated
    if (!$table_def && ref($table_data) =~ /\ATableData::/) {
        if ($table_data->can("get_table_def")) {
            $table_def = $table_data->get_table_def;
        } else {
            $table_def = {fields => {}};
            my @fields = $table_data->get_column_names;
            for my $i (0 .. $#fields) {
                $table_def->{fields}{ $fields[$i] } = {
                    pos => $i,
                    schema => "str*",
                    sortable => 1,
                },
            };
            # assume the first field as pk
            $table_def->{pk} = $fields[0];
        }
    }
    $table_def or return [400, "Please specify table_def"];
    ref($table_def) eq 'HASH'
        or return [400, "Invalid table_def: must be a hash"];
    $table_def->{fields} or
        return [400, "Invalid table_def: fields not specified"];
    ref($table_def->{fields}) eq 'HASH' or
        return [400, "Invalid table_def: fields must be hash"];
    $table_def->{pk} or
        return [400, "Invalid table_def: pk not specified"];
    !ref($table_def->{pk}) or
        return [400, "Sorry, I currently do not support multi-field pk"];
    exists($table_def->{fields}{ $table_def->{pk} }) or
        return [400, "Invalid table_def: pk not in fields"];

    # duplicate and make each field's schema normalized
    $table_def = clone($table_def);
    for my $fspec (values %{$table_def->{fields}}) {
        $fspec->{schema} //= 'any';
        $fspec->{schema} = __parse_schema($fspec->{schema});
    }
    #  make each custom filter's schema normalized
    my $cff = $args{custom_filters} // {};
    while (my ($cfn, $cf) = each %$cff) {
        $cf->{meta} //= {};
        $cf->{meta}{schema} //= 'any';
        $cf->{meta}{schema} = __parse_schema($cf->{meta}{schema});
    }

    my $dav = $args{default_arg_values} // {};
    my $opts = {
        summary                    => $args{summary},
        description                => $args{description},
        langs                      => $args{langs} // ['en_US'],

        default_detail             => $args{default_detail},
        detail_aliases             => $args{detail_cmdline_aliases} // {l=>{}},

        default_with_field_names   => $args{default_with_field_names},
        with_field_names_aliases   => $args{with_field_names_aliases},

        default_fields             => $args{default_fields},
        fields_aliases             => $args{fields_aliases},

        default_sort               => $args{default_sort},
        sort_aliases               => $args{sort_aliases},

        default_random             => $args{default_random},
        random_aliases             => $args{random_aliases},

        default_result_limit       => $args{default_result_limit},
        result_limit_aliases       => $args{result_limit_aliases},

        result_start_aliases       => $args{result_start_aliases},

        query_aliases              => $args{query_aliases} // {q=>{}}, # old, still supported
        queries_aliases            => $args{queries_aliases} // {q=>{}},

        default_query_boolean      => $args{default_query_boolean} // 'and',
        query_boolean_aliases      => $args{query_boolean_aliases} // {and=>{is_flag=>1, summary=>"Shortcut for --query-boolean=and", code=>sub{$_[0]{query_boolean}='and'}}, or=>{is_flag=>1, summary=>"Shortcut for --query-boolean=or", code=>sub{$_[0]{query_boolean}='or'}}},

        enable_filtering           => $args{enable_filtering} // 1,
        enable_search              => $args{enable_search} // 1,
        custom_search              => $args{custom_search},
        word_search                => $args{word_search},
        case_insensitive_search    => $args{case_insensitive_search} // 1,
        case_insensitive_comparison=> $args{case_insensitive_comparison},
        enable_ordering            => $args{enable_ordering} // 1,
        enable_random_ordering     => ($args{enable_random_ordering} //
                                           $args{enable_ordering} // 1),
        enable_paging              => $args{enable_paging} // 1,
        enable_field_selection     => $args{enable_field_selection} // 1,
        (map { ("default_$_" => $dav->{$_}) } keys %$dav),
        custom_filters             => $cff,
        extra_args                 => $args{extra_args},
        extra_props                => $args{extra_props},
        hooks                      => $args{hooks} // {},
    };

    my $res;
    $res = _gen_meta($table_def, $opts);
    return err(500, "Can't generate meta", $res) unless $res->[0] == 200;
    my $func_meta = $res->[2];

    $res = _gen_func($table_def, $opts, $table_data, $func_meta);
    return err(500, "Can't generate func", $res) unless $res->[0] == 200;
    my $func = $res->[2];

    if ($args{install} // 1) {
        no strict 'refs'; ## no critic: TestingAndDebugging::ProhibitNoStrict
        no warnings;
        log_trace("Installing function as %s ...", $fqname);
        *{ $fqname } = $func;
        ${$package . "::SPEC"}{$uqname} = $func_meta;
    }

    [200, "OK", {meta=>$func_meta, code=>$func}];
}

1;
# ABSTRACT: Generate function (and its metadata) to read table data

__END__

=pod

=encoding UTF-8

=head1 NAME

Perinci::Sub::Gen::AccessTable - Generate function (and its metadata) to read table data

=head1 VERSION

This document describes version 0.594 of Perinci::Sub::Gen::AccessTable (from Perl distribution Perinci-Sub-Gen-AccessTable), released on 2024-05-14.

=head1 SYNOPSIS

In list_countries.pl:

 #!perl
 use strict;
 use warnings;
 use Perinci::CmdLine;
 use Perinci::Sub::Gen::AccessTable qw(gen_read_table_func);

 our %SPEC;

 my $countries = [
     ['cn', 'China', 'Cina', [qw/panda/]],
     ['id', 'Indonesia', 'Indonesia', [qw/bali tropical/]],
     ['sg', 'Singapore', 'Singapura', [qw/tropical/]],
     ['us', 'United States of America', 'Amerika Serikat', [qw//]],
 ];

 my $res = gen_read_table_func(
     name        => 'list_countries',
     summary     => 'func summary',     # opt
     description => 'func description', # opt
     table_data  => $countries,
     table_def   => {
         summary => 'List of countries',
         fields => {
             id => {
                 schema => 'str*',
                 summary => 'ISO 2-letter code for the country',
                 pos => 0,
                 sortable => 1,
             },
             eng_name => {
                 schema => 'str*',
                 summary => 'English name',
                 pos => 1,
                 sortable => 1,
             },
             ind_name => {
                 schema => 'str*',
                 summary => 'Indonesian name',
                 pos => 2,
                 sortable => 1,
             },
             tags => {
                 schema => 'array*',
                 summary => 'Keywords/tags',
                 pos => 3,
                 sortable => 0,
             },
         },
         pk => 'id',
     },
 );
 die "Can't generate function: $res->[0] - $res->[1]" unless $res->[0] == 200;

 Perinci::CmdLine->new(url=>'/main/list_countries')->run;

Now you can do:

 # list all countries, by default only PK field is shown
 $ list_countries.pl --format=text-simple
 cn
 id
 sg
 us

 # show as json, randomize order
 $ list_countries.pl --format=json --random
 ["id","us","sg","cn"]

 # only list countries which are tagged as 'tropical', sort by ind_name field in
 # descending order, show all fields (--detail)
 $ list_countries.pl --detail --sort -ind_name --tags-has '[tropical]'
 .---------------------------------------------.
 | eng_name  | id | ind_name  | tags           |
 +-----------+----+-----------+----------------+
 | Singapore | sg | Singapura | tropical       |
 | Indonesia | id | Indonesia | bali, tropical |
 '-----------+----+-----------+----------------'

 # show only certain fields, limit number of records, return in YAML format
 $ list_countries.pl --fields '[id, eng_name]' --result-limit 2 --format=yaml
 - 200
 - OK
 -
   - id: cn
     eng_name: China
   - id: id
     eng_name: Indonesia

=head1 DESCRIPTION

This module is useful when you want to expose a table data (an array of
hashrefs, an array of arrays, or external data like a SQL table) as an API
function. This module will generate a function (along with its L<Rinci>
metadata) that accepts arguments for specifying fields, filtering, sorting, and
paging. The resulting function can then be run via command-line using
L<Perinci::CmdLine> (as demonstrated in Synopsis), or served via HTTP using
L<Perinci::Access::HTTP::Server>, or consumed normally by Perl programs.

=head1 FUNCTIONS


=head2 gen_read_table_func

Usage:

 gen_read_table_func(%args) -> [$status_code, $reason, $payload, \%result_meta]

Generate function (and its metadata) to read table data.

The generated function acts like a simple single table SQL SELECT query,
featuring filtering, ordering, and paging, but using arguments as the 'query
language'. The generated function is suitable for exposing a table data from an
API function.

The resulting function returns an array of results/records and accepts these
arguments.

=over

=item * I<with_field_names> => BOOL (default 1)

If set to 1, function will return records of field values along with field
names (hashref), e.g. {id=>'ID', country=>'Indonesia', capital=>'Jakarta'}. If
set to 0, then function will return record containing field values without
field names (arrayref) instead, e.g.: ['ID', 'Indonesia', 'Jakarta'].

=item * I<detail> => BOOL (default 0)

This is a field selection option. If set to 0, function will return PK field
only. If this argument is set to 1, then all fields will be returned (see also
I<fields> to instruct function to return some fields only).

=item * I<fields> => ARRAY

This is a field selection option. If you only want certain fields, specify
them here (see also I<detail>).

=item * I<result_limit> => INT (default undef)

=item * I<result_start> => INT (default 1)

The I<result_limit> and I<result_start> arguments are paging options, they work
like LIMIT clause in SQL, except that index starts at 1 and not 0. For
example, to return the first 20 records in the result, set I<result_limit> to
20 . To return the next 20 records, set I<result_limit> to 20 and
I<result_start> to 21.

=item * I<random> => BOOL (default 0)

The random argument is an ordering option. If set to true, order of records
returned will be shuffled first. This happened before paging.

=item * I<sort> => array of str

The sort argument is an ordering option, containing names of field. A C<->
prefix before the field name signifies descending instead of ascending order.
Multiple fields are allowed for secondary sort fields.

=item * I<q> => ARRAY[STR]

A filtering option. By default, all fields except those specified with
searchable=0 will be searched using simple case-insensitive string search.
There are a few options to customize this, using these gen arguments:
I<word_search>, I<case_insensitive_search>, I<custom_search>,
I<default_query_boolean>.

=item * I<query_boolean> => STR

Either C<and> or C<or>. Default can be set with gen argument
I<default_query_boolean>. With C<and>, all the words in I<q> argument must match.
With C<or>, only one of the words in I<q> argument must match.

=item * Filter arguments

They will be generated for each field, except when field has 'filterable'
clause set to false.

Undef values will not match any filter, just like NULL in SQL.

=over

=item * I<FIELD.is> and I<FIELD.isnt> arguments for each field. Only records with
field equalling (or not equalling) value exactly ('==' or 'eq') will be
included. If doesn't clash with other function arguments, I<FIELD> will also
be added as an alias for I<FIELD.is>.

=item * I<FIELD.has> and I<FIELD.lacks> array arguments for each set field. Only
records with field having or lacking certain value will be included.

=item * I<FIELD.min> and I<FIELD.max> for each int/float/str field. Only records with
field greater/equal than, or less/equal than a certain value will be
included.

=item * I<FIELD.contains> and I<FIELD.not_contains> for each str field. Only records
with field containing (or not containing) certain value (substring) will be
included.

=item * I<FIELD.matches> and I<FIELD.not_matches> for each str field. Only records
with field matching (or not matching) certain value (regex) (or will be
included. Function will return 400 if regex is invalid. These arguments will
not be generated if 'filterable_regex' clause in field specification is set
to 0.

=back

=back

This function is not exported by default, but exportable.

Arguments ('*' denotes required arguments):

=over 4

=item * B<case_insensitive_comparison> => I<bool> (default: 1)

Decide whether generated function will perform case-insensitive comparison (e.g. for FIELD.is).

=item * B<case_insensitive_search> => I<bool> (default: 1)

Decide whether generated function will perform case-insensitive search.

=item * B<custom_filters> => I<hash>

Supply custom filters.

A hash of filter name and definitions. Filter name will be used as generated
function's argument and must not clash with other arguments. Filter definition
is a hash containing these keys: I<meta> (hash, argument metadata), I<code>,
I<fields> (array, list of table fields related to this field).

Code will be called for each record to be filtered and will be supplied ($r, $v,
$opts) where $v is the filter value (from the function argument) and $r the
hashref record value. $opts is currently empty. Code should return true if
record satisfies the filter.

=item * B<custom_search> => I<code>

Supply custom searching for generated function.

Code will be supplied ($r, $q, $opts) where $r is the record (hashref), $q is
the search term (from the function argument 'q'), and $opts is {ci=>0|1}. Code
should return true if record matches search term.

=item * B<default_arg_values> => I<hash>

Specify defaults for generated function's arguments.

Can be used to supply default filters, e.g.

 # limit years for credit card expiration date
 { "year.min" => $curyear, "year.max" => $curyear+10, }

=item * B<default_detail> => I<bool>

Supply default 'detail' value for function arg spec.

=item * B<default_exclude_fields> => I<str>

Supply default 'exclude_fields' value for function arg spec.

=item * B<default_fields> => I<str>

Supply default 'fields' value for function arg spec.

=item * B<default_query_boolean> => I<str> (default: "and")

Specify default for --query-boolean option.

=item * B<default_random> => I<bool>

Supply default 'random' value in generated function's metadata.

=item * B<default_result_limit> => I<int>

Supply default 'result_limit' value in generated function's metadata.

=item * B<default_sort> => I<array[str]>

Supply default 'sort' value in generated function's metadata.

=item * B<default_with_field_names> => I<bool>

Supply default 'with_field_names' value in generated function's metadata.

=item * B<description> => I<str>

Generated function's description.

=item * B<detail_aliases> => I<hash>

(No description)

=item * B<enable_field_selection> => I<bool> (default: 1)

Decide whether generated function will support field selection (the `fields` argument).

=item * B<enable_filtering> => I<bool> (default: 1)

Decide whether generated function will support filtering (the FIELD, FIELD.is, FIELD.min, etc arguments).

=item * B<enable_ordering> => I<bool> (default: 1)

Decide whether generated function will support ordering (the `sort` & `random` arguments).

=item * B<enable_paging> => I<bool> (default: 1)

Decide whether generated function will support paging (the `result_limit` & `result_start` arguments).

=item * B<enable_random_ordering> => I<bool> (default: 1)

Decide whether generated function will support random ordering (the `random` argument).

Ordering must also be enabled (C<enable_ordering>).

=item * B<enable_search> => I<bool> (default: 1)

Decide whether generated function will support searching (argument q).

Filtering must also be enabled (C<enable_filtering>).

=item * B<exclude_fields_aliases> => I<hash>

(No description)

=item * B<extra_args> => I<hash>

Extra arguments for the generated function.

=item * B<extra_props> => I<hash>

Extra metadata properties for the generated function metadata.

=item * B<fields_aliases> => I<hash>

(No description)

=item * B<hooks> => I<hash>

Supply hooks.

You can instruct the generated function to execute codes in various stages by
using hooks. Currently available hooks are (in execution order):

=over

=item * before_parse_query

=item * after_parse_query

=item * before_fetch_data

=item * after_fetch_data

=item * before_return

=back

Hooks will be passed the function arguments as well as one or more additional
ones.

=over

=item * All hooks will get C<_stage> (name of stage) and C<_func_args> (function
arguments, but as hash reference so you can modify it).

=item * C<after_parse_query> and later hooks will also get C<_parse_res> (parse
enveloped result)

=item * C<before_fetch_data> and later will also get C<_query> (parsed query, which is
just the payload a.k.a. third element of C<_parse_res>).

=item * C<after_fetch_data> and later will also get C<_data>.

=item * C<before_return> will also get C<_func_res> (the enveloped response to be
returned to user).

=back

Hook should return nothing or a false value on success. It can abort execution
of the generated function if it returns an envelope response (an array). In that
case, the function will return with this return value.

=item * B<install> => I<bool> (default: 1)

Whether to install generated function (and metadata).

By default, generated function will be installed to the specified (or caller's)
package, as well as its generated metadata into %SPEC. Set this argument to
false to skip installing.

=item * B<langs> => I<array[str]> (default: ["en_US"])

Choose language for function metadata.

This function can generate metadata containing text from one or more languages.
For example if you set 'langs' to ['en_US', 'id_ID'] then the generated function
metadata might look something like this:

 {
     v => 1.1,
     args => {
         random => {
             summary => 'Random order of results', # English
             "summary.alt.lang.id_ID" => "Acak urutan hasil", # Indonesian
             ...
         },
         ...
     },
     ...
 }

=item * B<name> => I<str>

Generated function's name, e.g. `myfunc`.

=item * B<package> => I<str>

Generated function's package, e.g. `My::Package`.

This is needed mostly for installing the function. You usually don't need to
supply this if you set C<install> to false.

If not specified, caller's package will be used by default.

=item * B<queries_aliases> => I<hash>

(No description)

=item * B<random_aliases> => I<hash>

(No description)

=item * B<result_limit_aliases> => I<hash>

(No description)

=item * B<result_start_aliases> => I<hash>

(No description)

=item * B<sort_aliases> => I<hash>

(No description)

=item * B<summary> => I<str>

Generated function's summary.

=item * B<table_data>* => I<array|code|obj>

Data.

Table data is either an AoH/AoA, or a L<TableData> object, or a coderef.

Passing a subroutine lets you fetch data dynamically and from arbitrary source
(e.g. DBI table or other external sources). The subroutine will be called with
these arguments ('$query') and is expected to return a hashref like this {data
=> DATA, paged=>BOOL, filtered=>BOOL, sorted=>BOOL, fields_selected=>BOOL}. DATA
is AoA or AoH. If paged is set to 1, data is assumed to be already paged and
won't be paged again; likewise for filtered, sorted, and fields selected. These
are useful for example with DBI result, where requested data is already
filtered/sorted (including randomized)/field selected/paged via appropriate SQL
query. This way, the generated function will not attempt to duplicate the
efforts.

'$query' is a hashref which contains information about the query, e.g. 'args'
(the original arguments passed to the generated function, e.g. {random=>1,
result_limit=>1, field1_match=>'f.+'}), 'mentioned_fields' which lists fields
that are mentioned in either filtering arguments or fields or ordering,
'requested_fields' (fields mentioned in list of fields to be returned),
'sort_fields' (fields mentioned in sort arguments), 'filter_fields' (fields
mentioned in filter arguments).

=item * B<table_def> => I<hash>

Table definition.

Required, unless C<table_data> argument is a L<TableData> object, in which case
table definition will be retrieved from the object if not supplied.

See L<TableDef> for more details.

A hashref with these required keys: 'fields', 'pk'. 'fields' is a hashref of
field specification with field name as keys, while 'pk' specifies which field is
to be designated as the primary key. Currently only single-field PK is allowed.

Field specification. A hashref with these required keys: 'schema' (a Sah
schema), 'index' (an integer starting from 0 that specifies position of field in
the record, required with AoA data) and these optional clauses: 'sortable' (a
boolean stating whether field can be sorted, default is true), 'filterable' (a
boolean stating whether field can be mentioned in filter options, default is
true).

=item * B<with_field_names_aliases> => I<hash>

(No description)

=item * B<word_search> => I<bool> (default: 0)

Decide whether generated function will perform word searching instead of string searching.

For example, if search term is 'pine' and field value is 'green pineapple',
search will match if word_search=false, but won't match under word_search.

This will not have effect under 'custom_search'.


=back

Returns an enveloped result (an array).

First element ($status_code) is an integer containing HTTP-like status code
(200 means OK, 4xx caller error, 5xx function error). Second element
($reason) is a string containing error message, or something like "OK" if status is
200. Third element ($payload) is the actual result, but usually not present when enveloped result is an error response ($status_code is not 2xx). Fourth
element (%result_meta) is called result metadata and is optional, a hash
that contains extra information, much like how HTTP response headers provide additional metadata.

Return value: A hash containing generated function, metadata (hash)

=head1 FAQ

=head2 I want my function to accept additional arguments.

You can use the C<extra_args> argument:

 gen_read_table_func(
     name => 'myfunc',
     extra_args => {
         foo => {schema=>'int*'},
         bar => {summary => 'Yet another arg for myfunc', schema=>'str*'},
     },
 );

As for the implementation, you can specify hooks to do things with the extra
arguments.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Perinci-Sub-Gen-AccessTable>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Perinci-Sub-Gen-AccessTable>.

=head1 SEE ALSO

L<Perinci::Sub::Gen::AccessTable::Simple> for a simpler variant.

L<Rinci>

L<Perinci::CmdLine>

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 CONTRIBUTOR

=for stopwords Steven Haryanto

Steven Haryanto <stevenharyanto@gmail.com>

=head1 CONTRIBUTING


To contribute, you can send patches by email/via RT, or send pull requests on
GitHub.

Most of the time, you don't need to build the distribution yourself. You can
simply modify the code, then test via:

 % prove -l

If you want to build the distribution (e.g. to try to install it locally on your
system), you can install L<Dist::Zilla>,
L<Dist::Zilla::PluginBundle::Author::PERLANCAR>,
L<Pod::Weaver::PluginBundle::Author::PERLANCAR>, and sometimes one or two other
Dist::Zilla- and/or Pod::Weaver plugins. Any additional steps required beyond
that are considered a bug and can be reported to me.

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2024, 2023, 2022, 2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013, 2012, 2011 by perlancar <perlancar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Perinci-Sub-Gen-AccessTable>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 CAVEATS

It is often not a good idea to expose your database schema directly as API.

=cut

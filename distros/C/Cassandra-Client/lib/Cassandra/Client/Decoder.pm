package Cassandra::Client::Decoder;
use 5.010;
use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK= qw/make_decoder/;

use Cassandra::Client::Protocol qw/:constants unpack_long BIGINT_SUPPORTED/;
use vars qw/@ROW/;
use Math::BigInt;
use POSIX qw/floor/;

my $bigint_dec= BIGINT_SUPPORTED ? 'q>' : \&d_bigint_slow;

my %type_lookup= (
    TYPE_CUSTOM     ,=> [ \&d_passthru ],
    TYPE_ASCII      ,=> [ \&d_passthru ],
    TYPE_BIGINT     ,=> [ $bigint_dec  ],
    TYPE_BLOB       ,=> [ \&d_passthru ],
    TYPE_BOOLEAN    ,=> [ \&d_bool     ],
    TYPE_COUNTER    ,=> [ $bigint_dec  ],
    TYPE_DECIMAL    ,=> [ \&d_decimal  ],
    TYPE_DOUBLE     ,=> [ 'd>'         ],
    TYPE_FLOAT      ,=> [ 'f>'         ],
    TYPE_INT        ,=> [ 'l>'         ],
    TYPE_TEXT       ,=> [ \&d_string   ],
    TYPE_VARINT     ,=> [ \&d_varint   ],
    TYPE_TIMESTAMP  ,=> [ $bigint_dec  ],
    TYPE_UUID       ,=> [ \&d_uuid     ],
    TYPE_VARCHAR    ,=> [ \&d_string   ],
    TYPE_TIMEUUID   ,=> [ \&d_uuid     ],
    TYPE_INET       ,=> [ \&d_inet     ],
    TYPE_LIST       ,=> [ \&d_list     ],
    TYPE_MAP        ,=> [ \&d_map      ],
    TYPE_SET        ,=> [ \&d_set      ],
    TYPE_TINYINT    ,=> [ 'c'          ],
    TYPE_SMALLINT   ,=> [ 's>'         ],
    TYPE_TIME       ,=> [ \&d_time     ],
    TYPE_DATE       ,=> [ \&d_date     ],
);

sub make_decoder {
    my ($metadata)= @_;
    return undef unless $metadata->{columns};

    my $column_count= 0+@{$metadata->{columns}};

    my $decoder= <<EOC;

    my \$false= !1;
    my \$true= !\$false;
    sub {
        my (\@output, \$byte_count, \$tmp_val);
        my \$row_count= unpack('l>', substr(\$_[0], 0, 4, ''));
        \$#output= \$row_count-1;
        for (0..(\$row_count-1)) {
            \$output[\$_]= [(undef)x$column_count];
            local *ROW= \$output[\$_];
@{[ map { my $col= $_; my $column= $metadata->{columns}[$col]; <<EOP } 0..($column_count-1)

            # Field $col, $column->[0].$column->[1].$column->[2]
            \$byte_count= unpack('l>', substr(\$_[0], 0, 4, ''));
            if (\$byte_count >= 0) {
                \$tmp_val= substr(\$_[0], 0, \$byte_count, '');
                @{[ make_value_decoder($column->[3], 4, '$tmp_val', "\$ROW[$_]", '$byte_count') ]}
            } # default: else { \$row[$col]= undef; }

EOP
]}
        }

        return \\\@output;
    }

EOC

    return ( eval($decoder) or die $@ );
}

sub make_value_decoder {
    my ($type, $indent, $tmp_val, $dest, $input_length)= @_;

    my $val_decoder= "# Decoder for type $type->[0]\n";
    my $lookedup= $type_lookup{$type->[0]};

    if (!$lookedup) {
        warn 'Type '.$type->[0].' not implemented, returning undef';
    } elsif (!ref $lookedup->[0]) { # decode pack format
        $val_decoder .= "$dest= unpack('$lookedup->[0]', $tmp_val);\n";
    } elsif (ref $lookedup->[0] eq 'CODE') {
        $val_decoder .= $lookedup->[0]->($type, $tmp_val, $dest, $input_length);
    }

    # Indent it for readability
    $val_decoder= "\n".(join "\n", map { ("    " x $indent).$_ } split /\n/, $val_decoder)."\n";

    return $val_decoder;
}

sub d_string {
    my ($type, $tmp_val, $dest, $input_length)= @_;

    return "$dest= $tmp_val;
utf8::decode $dest;";
}

sub d_map {
    my ($type, $tmp_val, $dest, $input_length)= @_;

    my $val_decoder= <<EOC;
{
    my \$map_entries= unpack('l>', substr($tmp_val, 0, 4, ''));
    my (\$map_byte_count, \$map_bytes, \%map);
    for (1..\$map_entries) {
        my (\$key, \$value);
        \$map_byte_count= unpack('l>', substr($tmp_val, 0, 4, ''));
        if (\$map_byte_count >= 0) {
            \$map_bytes= substr($tmp_val, 0, \$map_byte_count, '');
            @{[ make_value_decoder($type->[1], 3, '$map_bytes', '$key', '$map_byte_count') ]}
        }
        \$map_byte_count= unpack('l>', substr($tmp_val, 0, 4, ''));
        if (\$map_byte_count >= 0) {
            \$map_bytes= substr($tmp_val, 0, \$map_byte_count, '');
            @{[ make_value_decoder($type->[2], 3, '$map_bytes', '$value', '$map_byte_count') ]}
        }
        \$map{\$key}= \$value;
    }
    $dest= \\\%map;
}
EOC
}

sub d_set {
    my ($type, $tmp_val, $dest, $input_length)= @_;

    my $val_decoder= <<EOC;
{
    my \$set_entries= unpack('l>', substr($tmp_val, 0, 4, ''));
    my (\$set_byte_count, \$set_bytes, \@set);
    for (1..\$set_entries) {
        my \$item;
        \$set_byte_count= unpack('l>', substr($tmp_val, 0, 4, ''));
        if (\$set_byte_count >= 0) {
            \$set_bytes= substr($tmp_val, 0, \$set_byte_count, '');
            @{[ make_value_decoder($type->[1], 3, '$set_bytes', '$item', '$set_byte_count') ]}
        }
        push \@set, \$item;
    }
    $dest= \\\@set;
}
EOC
}

sub d_list {
    my ($type, $tmp_val, $dest, $input_length)= @_;

    my $val_decoder= <<EOC;
{
    my \$list_entries= unpack('l>', substr($tmp_val, 0, 4, ''));
    my (\$list_byte_count, \$list_bytes, \@list);
    \$#list= \$list_entries - 1;
    for my \$list_i (0..(\$list_entries-1)) {
        \$list_byte_count= unpack('l>', substr($tmp_val, 0, 4, ''));
        if (\$list_byte_count >= 0) {
            \$list_bytes= substr($tmp_val, 0, \$list_byte_count, '');
            @{[ make_value_decoder($type->[1], 3, '$list_bytes', '$list[$list_i]', '$list_byte_count') ]}
        }
    }
    $dest= \\\@list;
}
EOC
}

sub d_passthru {
    my ($type, $tmp_val, $dest, $input_length)= @_;
    return "$dest= $tmp_val;";
}

sub d_uuid {
    my ($type, $tmp_val, $dest, $input_length)= @_;
    return "$dest= unpack('H[32]', $tmp_val); $dest =~ ".'s/\A(\w{8})(\w{4})(\w{4})(\w{4})(\w{12})\z/$1-$2-$3-$4-$5/'.";";
}

sub d_inet {
    my ($type, $tmp_val, $dest, $input_length)= @_;
    return <<EOC;
if ($input_length == 4) {
    $dest= join('.', unpack('CCCC', $tmp_val));
} else {
    $dest= join(':', unpack('(H4)[8]', $tmp_val));
    # Simplify the V6 address
    $dest =~ s/\\b0+(\\d+)\\b/\$1/g;
    $dest =~ s/\\b0(:0)+\\b/:/;
    $dest =~ s/:::/::/;
}
EOC
}

sub d_bool {
    my ($type, $tmp_val, $dest, $input_length)= @_;
    return <<EOC;
$dest= unpack('c', $tmp_val) ? \$true : \$false;
EOC
}

sub d_bigint_slow {
    my ($type, $tmp_val, $dest, $input_length)= @_;
    return <<EOC;
$dest= unpack_long($tmp_val);
EOC
}

sub d_varint {
    my ($type, $tmp_val, $dest, $input_length)= @_;
    my $supported_size= BIGINT_SUPPORTED ? 8 : 4;
    my $supported_bits= $supported_size * 8;
    return <<EOC;
if ($input_length > $supported_size) {
    my \$negative= ord(substr($tmp_val, 0, 1)) & 0x80;
    $tmp_val= ~($tmp_val) if \$negative;

    my \$hex= unpack('H*', $tmp_val);
    my \$number= Math::BigInt->new("0x\$hex");

    if (\$negative) {
        \$number += 1;
        \$number *= -1;
    }

    $dest= \$number->bstr;

} elsif ($input_length == 1) {
    $dest= unpack('c', $tmp_val);
} elsif ($input_length == 2) {
    $dest= unpack('s>', $tmp_val);
} elsif ($input_length == 4) {
    $dest= unpack('l>', $tmp_val);
} elsif ($input_length == 0) {
    $dest= 0;
} else {
    my \$pad= ((substr($tmp_val, 0, 1) & "\\x80") eq "\\x80") ? "\\xff" : "\\0";
    if ($input_length == 3) {
        $dest= unpack('l>', \$pad.$tmp_val);
    } else {
        $dest= unpack('q>', substr(\$pad.\$pad\.\$pad.$tmp_val, -8));
    }
}
EOC
}

sub d_decimal {
    my ($type, $tmp_val, $dest, $input_length)= @_;
    my $varint_dec= d_varint($type, $tmp_val, '$unscaled', "($input_length-4)");
    return <<EOC;
my \$scale= unpack('l>', substr($tmp_val, 0, 4, ''));
\$scale *= -1;
my \$unscaled;
VARINT: {
$varint_dec
}
$dest= \$unscaled . (\$scale > 0 ? "e+\$scale" : \$scale < 0 ? "e\$scale" : "");
EOC
}

sub d_time {
    my ($type, $tmp_val, $dest, $input_length)= @_;
    return <<EOC;
{
    my \$ns= BIGINT_SUPPORTED ? unpack('q>', $tmp_val) : unpack_long($tmp_val);
    my \$seconds= substr(\$ns, 0, -9, '') || 0;
    my \$hours= int(\$seconds / 3600);
    \$seconds -= \$hours * 3600;
    my \$minutes= int(\$seconds / 60);
    \$seconds -= \$minutes * 60;
    $dest= sprintf("%.1d:%.2d:%.2d.%s", \$hours, \$minutes, \$seconds, substr("\${ns}000000000", 0, 9));
    $dest =~ s/0+\\z//;
    $dest =~ s/[.]\\z//;
}
EOC
}

sub d_date {
    my ($type, $tmp_val, $dest, $input_length)= @_;
    return <<EOC;
{
    my \$days_total= unpack('L>', $tmp_val) - (1<<31);
    my \$J= \$days_total + 2440588;

    my \$f= \$J + 1401 + floor((floor((4 * \$J + 274277) / 146097) * 3) / 4) - 38;
    my \$e= 4 * \$f + 3;
    my \$g= floor((\$e % 1461) / 4);
    my \$h= 5 * \$g + 2;
    my \$D= (floor((\$h % 153) / 5) + 1);
    my \$M= ((floor(\$h / 153) + 2) % 12) + 1;
    my \$Y= floor(\$e / 1461) - 4716 + floor((12 + 2 - \$M) / 12);

    $dest= sprintf("%d-%.2d-%.2d", \$Y, \$M, \$D);
}
EOC
}

1;

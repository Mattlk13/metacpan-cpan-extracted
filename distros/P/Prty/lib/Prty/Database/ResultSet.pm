package Prty::Database::ResultSet;
use base qw/Prty::Hash/;

use strict;
use warnings;
use v5.10.0;

our $VERSION = 1.128;

use Prty::Object;
use Time::HiRes ();
use Prty::Option;
use Prty::FileHandle;
use Prty::ColumnFormat;
use Prty::Duration;

# -----------------------------------------------------------------------------

=encoding utf8

=head1 NAME

Prty::Database::ResultSet - Liste von Datensätzen (abstrakt)

=head1 BASE CLASS

L<Prty::Hash>

=head1 DESCRIPTION

Ein Objekt der Klasse repräsentiert eine Liste von gleichartigen
Datensätzen.

=head1 METHODS

=head2 Konstruktor

=head3 new() - Instantiiere Tabellen-Objekt

=head4 Synopsis

    $tab = $class->new($rowClass,\@titles);
    $tab = $class->new($rowClass,\@titles,\@rows,@keyVal);
    
    $newTab = $tab->new;
    $newTab = $tab->new(\@rows);

=head4 Description

Instantiiere ein Tabellen-Objekt und liefere eine Referenz auf dieses
Objekt zurück.

Die Arrays @titles und @rows werden von der Methode I<nicht> kopiert.

Als Objektmethode gerufen, wird ein neues Tabellen-Objekt mit
$rowClass und $titles aus dem existierenden Tabellenobjekt
initialisiert. Diese Methode ist nützlich, wenn ein
Tabellen-Objekt mit einer Teilmenge des ursprünglichen
Tabellen-Objektes gebildet werden soll.

=cut

# -----------------------------------------------------------------------------

sub new {
    my ($class,$self) = Prty::Object->this(shift);

    if ($self) {
        my $rows = shift || [];

        $self = $class->SUPER::new(
            rowClass=>$self->rowClass,
            titles=>scalar $self->titles,
            rows=>$rows,
            stmt=>'',
            hits=>0,
            startTime=>scalar(Time::HiRes::gettimeofday),
            execTime=>0,
            fetchTime=>0,
            formatA=>undef, # wird von $self->formats() gesetzt
        );
    }
    else {
        my $rowClass = shift;
        my $titles = shift;
        my $rows = shift || [];
        # @_: @keyVal

        $self = $class->SUPER::new(
            rowClass=>$rowClass,
            titles=>$titles,
            rows=>$rows,
            stmt=>'',
            hits=>0,
            startTime=>scalar(Time::HiRes::gettimeofday),
            execTime=>0,
            fetchTime=>0,
            formatA=>undef, # wird von $self->formats() gesetzt
        );
    }

    $self->set(@_);

    return $self;
}

# -----------------------------------------------------------------------------

=head2 Accessors

=head3 rowClass() - Liefere Namen der Datensatz-Klasse

=head4 Synopsis

    $rowClass = $tab->rowClass;

=cut

# -----------------------------------------------------------------------------

sub rowClass {
    return shift->{'rowClass'};
}

# -----------------------------------------------------------------------------

=head3 rows() - Liefere/Setze die Liste der Datensätze

=head4 Synopsis

    $rowA|@rows = $tab->rows;
    $rowA|@rows = $tab->rows(\@rows);

=head4 Description

Liefere die Liste der Datensätze der Tabelle. Im Skalarkontext liefere
eine Referenz auf die Liste.

Ist Parameter \@rows angegeben, wird die Datensatz-Liste auf diese
Liste gesetzt.

=cut

# -----------------------------------------------------------------------------

sub rows {
    my $self = shift;
    # @_: \@rows

    if (@_) {
        $self->{'rows'} = shift;
    }

    my $rows = $self->{'rows'};
    return wantarray? @$rows: $rows;
}

# -----------------------------------------------------------------------------

=head3 stmt() - Liefere Statement

=head4 Synopsis

    $stmt = $tab->stmt;

=head4 Description

Liefere das SQL-Statement, mit welchem die Datensätze der Tabelle
selektiert wurden.

=cut

# -----------------------------------------------------------------------------

sub stmt {
    return shift->{'stmt'};
}

# -----------------------------------------------------------------------------

=head3 stmtBody() - Liefere Rumpf für ein Subselect

=head4 Synopsis

    $stmt = $tab->stmtBody(@opt);

=head4 Description

Liefere den Rumpf des (Select-)Statement. Der Rumpf ist das ürsprüngliche
Statement ohne Select- und Order-By-Klausel.

=head4 Example

Ursprüngliches Select:

    SELECT
        per_vorname
        , per_nachname
    FROM
        person
    WHERE
        per_nachname = 'Schulz'
    ORDER BY
        per_vorname

Resultierendes Select:

    FROM
        person
    WHERE
        per_nachname = 'Schulz'

=cut

# -----------------------------------------------------------------------------

sub stmtBody {
    my $self = shift;
    # @_: @opt

    my $stmt = $self->stmt;
    $stmt =~ s|^.*?(?=FROM)||si;     # entferne Select-Klausel
    $stmt =~ s|\s+ORDER\s+BY.*$||si; # entferne Order-By-Klausel

    return $stmt;
}

# -----------------------------------------------------------------------------

=head3 titles() - Liefere Liste der Kolumnentitel

=head4 Synopsis

    $titleA|@titles = $tab->titles;

=head4 Description

Liefere die Liste der Kolumnentitel der Tabelle. Im Skalarkontext liefere
eine Referenz auf die Liste.

=cut

# -----------------------------------------------------------------------------

sub titles {
    my $self = shift;
    my $arr = $self->{'titles'};
    return wantarray? @$arr: $arr;
}

# -----------------------------------------------------------------------------

=head2 Tests

=head3 isRaw() - Prüfe, ob Raw-Tabelle

=head4 Synopsis

    $bool = $this->isRaw;

=cut

# -----------------------------------------------------------------------------

sub isRaw {
    return shift->{'rowClass'}->isRaw;
}

# -----------------------------------------------------------------------------

=head2 Search

=head3 lookup() - Suche Datensatz

=head4 Synopsis

    $row = $tab->lookup(@opt,$key=>$val);

=head4 Options

=over 4

=item -sloppy => $bool (Default: 0)

Wenn der gesuchte Datensatz nicht existiert, löse keine Exception aus,
sondern liefere undef.

=back

=head4 Description

Durchsuche die Tabelle nach dem ersten Datensatz, dessen
Attribut $key den Wert $val besitzt und liefere diesen zurück.
Erfüllt kein Datensatz das Kriterium, wird eine Exception ausgelöst.

=cut

# -----------------------------------------------------------------------------

sub lookup {
    my $self = shift;
    # @_: @opt,$key=>$val

    # Optionen

    my $sloppy = 0;

    if (substr($_[0],0,1) eq '-') {
        Prty::Option->extract(\@_,
            -sloppy=>\$sloppy,
        );
    }

    # Operation ausführen

    my $key = shift;
    my $val = shift;

    my $row = $self->lookupSub($key,$val);
    if ($row or $sloppy) {
        return $row;
    }

    # Exception

    $self->throw(
        q~TAB-00001: Datensatz nicht gefunden~,
        Key=>$key,
        Value=>$val,
    );
}

# -----------------------------------------------------------------------------

=head3 select() - Suche Datensätze

=head4 Synopsis

    @rows|$tab = $tab->select($testSub);

=head4 Description

Durchsuche die Tabelle nach den Datensätzen, die Test-Methode
$testSub erfüllen und liefere die Liste dieser Datensätze zurück.
Im Skalarkontext liefere ein neues Tabellen-Objekt.

=head4 Example

Schränke Produkt-Tabelle auf Produkte mit einem Preis > 100 ein:

    my $sub = sub {
        my $row = shift;
        return $row->preis > 100? 1: 0;
    };
    $tab = $tab->select($sub);

=cut

# -----------------------------------------------------------------------------

sub select {
    my ($self,$testSub) = @_;

    my @arr;
    for my $row (@{$self->rows}) {
        if ($testSub->($row)) {
            CORE::push @arr,$row;
        }
    }

    if (wantarray) {
        return @arr;
    }

    return ref($self)->new(
        $self->rowClass,
        scalar($self->titles),
        \@arr,
    );
}

# -----------------------------------------------------------------------------

=head2 File I/O

=head3 loadFromFile() - Lade Tabelle aus Datei

=head4 Synopsis

    $tab = $class->loadFromFile($file,@opt);

=head4 Options

=over 4

=item -colSep => $char (Default: '|')

Kolumnen-Trennzeichen.

=item -rowClass => $rowClass (Default: 'Prty::Database::Row::Object')

Name der Datensatzklasse, auf die die Datensätze geblesst werden.
Die Datensatzklasse entscheidet auch über die Tabellenklasse.

=item -rowStatus => '0'|'U'|'I'|'D' (Default: 'I')

Setze den initialen Datensatz-Status.

=back

=head4 Description

Lade Datensätze aus Datei $file in eine Datensatz-Tabelle und
liefere eine Referenz auf dieses Objekt zurück.

B<Dateiformat>

Die erste Zeile enthält die Kolumentitel, alle weiteren Zeilen die
Datensätze. Die Kolumen werden per | getrennt.

=head4 Example

    per_id|per_vorname|per_nachname
    1|Rudi|Ratlos
    2|Kai|Nelust
    3|Elli|Pirelli
    4|Susi|Sorglos

=cut

# -----------------------------------------------------------------------------

sub loadFromFile {
    my $class = shift;
    my $file = shift;

    # Optionen

    my $colSep = '|';
    my $rowClass = $class->defaultRowClass;
    my $rowStatus = undef;

    Prty::Option->extract(\@_,
        -colSep=>\$colSep,
        -rowClass=>\$rowClass,
        -rowStatus=>\$rowStatus,
    );
    $colSep = qr/\Q$colSep/;

    # Operation ausführen

    my (@titles,@rows);
    my $fh = Prty::FileHandle->new('<',$file);
    while (<$fh>) {
        chomp;
        if ($. == 1) {
            @titles = split /$colSep/;
        }
        else {
            my @arr = split /$colSep/;
            my $row = $rowClass->new(\@titles,\@arr);
            if (defined $rowStatus) {
                $row->rowStatus($rowStatus);
            }
            CORE::push @rows,$row;
        }
    }
    $fh->close;

    return $rowClass->tableClass->new($rowClass,\@titles,\@rows);
}

# -----------------------------------------------------------------------------

=head3 saveToFile() - Sichere Tabelle in Datei

=head4 Synopsis

    $tab->saveToFile($file);

=head4 Description

Sichere die Datensätze der Tabelle in Datei $file.
Die Methode liefert keinen Wert zurück.

=cut

# -----------------------------------------------------------------------------

sub saveToFile {
    my $self = shift;
    my $file = shift;

    my $fh = Prty::FileHandle->new('>',$file);
    print $fh join('|',$self->titles),"\n";
    for my $row (@{$self->{'rows'}}) {
        print $fh join('|',@{$row->asArray}),"\n";
    }
    $fh->close;

    return;
}

# -----------------------------------------------------------------------------

=head2 Miscellaneous

=head3 elapsed() - Dauer seit Beginn der SQL_Ausführung

=head4 Synopsis

    $duration = $tab->elapsed;

=cut

# -----------------------------------------------------------------------------

sub elapsed {
    my $self = shift;
    return Time::HiRes::gettimeofday-$self->startTime;
}

# -----------------------------------------------------------------------------

=head3 formats() - Liefere Kolumnenformate

=head4 Synopsis

    $fmtA | @fmts = $tab->formats;
    $fmtA | @fmts = $tab->formats($force);

=head4 Description

Analysiere den Tabelleninhalt und liefere eine Liste von
Kolumnenformat-Objekten zurück. Diese können zur tabellarischen
Formatierung der Kolumnenwerte herangezogen werden.

Die Analyse wird nur einmal durchgeführt und die resultierende
Liste im Tabellenobjekt gespeichert. Ist der Parameter $force
angegeben und "wahr", wird eine Neuberechnung forciert.

=cut

# -----------------------------------------------------------------------------

sub formats {
    my ($self,$force) = @_;

    if (!$self->{'formatA'} || $force) {
        my $rowA = $self->{'rows'};
        my $titles = $self->{'titles'};
    
        my $isRaw = $self->isRaw;
    
        my @fmt;
        for (my $i = 0; $i < @$titles; $i++) {
            my $type = 'd';
            my $length = 0;
            my $before = 0; # max. Anzahl Zeichen vor den Nachkommastellen
            my $scale = 0;  # max. Anzahl Nachkommastellen
            my $null = 0;
            my $mask = 0;
    
            my $title = $titles->[$i];
            foreach my $row (@$rowA) {
                my $val = $isRaw? $row->[$i]: $row->$title;
    
                # Anzahl Nullwerte
    
                if ($val eq '') {
                    $null++; # Nullwerte zählen
                    next;
                }
    
                # Typ ermitteln
    
                my $msk = 0;
                if ($type eq 't') {
                    $msk = $val =~ tr/\n\r\t\0\\//;
                }
                elsif ($type eq 's') {
                    if ($val =~ tr/\n\r//) {
                        $type = 't';
                        redo;
                    }
                    $msk = $val =~ tr/\n\r\t\0\\//;
                }
                elsif ($type eq 'd' && $val !~ /^-?\d+$/) {
                    $type = 'f';
                    redo;
                }
                elsif ($type eq 'f' && $val !~ /^-?(\d*\.\d+$|\d+)$/) {
                    $type = 's';
                    $before = $scale = 0;
                    redo;
                }
    
                # Maximallänge ermitteln
    
                my $len = length $val;
                if ($len > $length) {
                    $length = $len;
                }
    
                # Nachkommastellen ermitteln
    
                if ($type eq 'f') {
                    # Ziffer vorm Dezimalpunkt kann fehlen (Oracle)
                    $val =~ /^-?(\d*)(\.(\d+))?$/ or die;
    
                    # Anzahl Nachkommastellen
    
                    my $n = defined($3)? length($3): 0;
                    $scale = $n if $n > $scale;
    
                    # Anzahl Zeichen vor den Nachkommastellen
                    # (einschl. Punkt und Vorzeichen)
                    # Korrektur für Oracle-Zahlen zw. 1 und -1
    
                    my $m = length($val)-$n;
                    $m++ if $1 eq ''; # .N oder -.N (Oracle-Fix)
                    $before = $m if $m > $before;
                }
    
                # Maximalanzahl der zu maskierenden Zeichen
                
                if ($msk > $mask) {
                    $mask = $msk;
                }
            }
    
            if ($length == 0) {
                $type = 's';
            }
    
            # Die max. Feldlänge ist im Falle von Fließkommazahlen
            # die Summe aus der max. Anzahl an Nachkommastellen plus
            # der maximalen Anzahl an Zeichen davor.
    
            if ($type eq 'f') {
                $length = $before+$scale;
            }
    
            push @fmt,Prty::ColumnFormat->new($type,$length,$scale,
                $null,$mask);
        }
        $self->{'formatA'} = \@fmt;
    }

    my $fmtA = $self->{'formatA'};
    return wantarray? @$fmtA: $fmtA;
}

# -----------------------------------------------------------------------------

=head3 align() - Liefere die Ausrichtung der Kolumnen

=head4 Synopsis

    @aligns | $alignA = $tab->align;

=head4 Description

Aktuell werden die Angaben 'left' und 'right' für die Ausrichtung
von HTML-Tabellenzellen geliefert.

=cut

# -----------------------------------------------------------------------------

sub align {
    my $self = shift;

    my @align;
    for my $fmt (@{$self->formats}) {
        push @align,$fmt->htmlAlign;
    }

    return wantarray? @align: \@align;
}

# -----------------------------------------------------------------------------

=head3 width() - Liefere die Breite der Tabelle

=head4 Synopsis

    $n = $tab->width;

=cut

# -----------------------------------------------------------------------------

sub width {
    return scalar @{$_[0]->{'titles'}};
}

# -----------------------------------------------------------------------------

=head3 count() - Liefere Anzahl der Datensätze

=head4 Synopsis

    $n = $tab->count;

=cut

# -----------------------------------------------------------------------------

sub count {
    return scalar @{$_[0]->{'rows'}};
}

# -----------------------------------------------------------------------------

=head3 pop() - Entferne Datensatz am Ende

=head4 Synopsis

    $tab->pop;

=cut

# -----------------------------------------------------------------------------

sub pop {
    my ($self,$row) = @_;
    CORE::pop @{$self->{'rows'}};
    return;
}

# -----------------------------------------------------------------------------

=head3 push() - Füge Datensatz am Ende hinzu

=head4 Synopsis

    $tab->push($row);

=cut

# -----------------------------------------------------------------------------

sub push {
    my ($self,$row) = @_;
    CORE::push @{$self->{'rows'}},$row;
    return;
}

# -----------------------------------------------------------------------------

=head3 defaultRowClass() - Liefere Namen der Default-Rowklasse

=head4 Synopsis

    $rowClass = $class->defaultRowClass;

=head4 Description

Liefere den Namen der Default-Rowklasse: 'Prty::Database::Row::Object'

Auf die Default-Rowklasse werden Datensätze instantiiert, für die
bei der Instantiierung einer Table-Klasse keine Row-Klasse
explizit angegeben wurde.

=head4 Details

Als Default-Rowklasse wird für die Prty::Database::ResultSet-
Klassenhierarchie 'Prty::Database::Row::Object' definiert.

Die Methode wird in der Subklasse Prty::Database::ResultSet::Array
überschrieben. Für diesen Zweig ist die Default-Rowklasse
'Prty::Database::Row::Array'.

=cut

# -----------------------------------------------------------------------------

sub defaultRowClass {
    return 'Prty::Database::Row::Object';
}

# -----------------------------------------------------------------------------

=head3 asString() - String-Repräsentation der Tabelle

=head4 Synopsis

    $str = $tab->asString;
    $str = $tab->asString($colSep);
    $str = $tab->asString($colSep,$rowSep);

=head4 Description

Liefere eine String-Repräsentation der Tabelle mit $colSep
als Datensatz-Trenner (Default: "\t") und $rowSep als
Kolumnentrenner (Default: "\n").

=cut

# -----------------------------------------------------------------------------

sub asString {
    my $self = shift;
    my $colSep = shift || "\t";
    my $rowSep = shift || "\n";

    my $str = '';
    for my $row (@{$self->rows}) {
        $str .= $row->asString($colSep).$rowSep;
    }

    return $str;
}

# -----------------------------------------------------------------------------

=head3 asTable() - Tabellen-Repräsentation der Tabellendaten

=head4 Synopsis

    $str = $tab->asTable(@opt);

=head4 Options

=over 4

=item -info => $n (Default: 3)

Umfang an Information, die über die Daten hinaus ausgegeben wird:

=over 4

=item Z<>0

Nur Daten.

=item Z<>1

Numerierung der Kolumnen, Anzahl Zeilen, Ausführungszeit.

=item Z<>2

Inforationsumfang 1 plus Liste der Kolumnennamen.

=item Z<>3

Inforationsumfang 2 plus SQL-Statement.

=back

=item -msg => $msg

Füge $msg zur Statistik-Zeile hinzu.

=back

=head4 Description

Liefere eine einfache Tabellen-Repräsentation der Tabellendaten.

=head4 Example

Beispiel-Ausgabe:

    SELECT
        *
    FROM
        did.mandant
    WHERE
        ROWNUM <= 10+1
    ORDER BY
        1
    
    1 id
    2 id_person
    3 bezeichnung
    4 id_verknuepfungsgruppe
    
    1   2          3                         4
    | 0 | 14485923 | unbekannter Mandant     | 0 |
    | 1 | 14485924 | Otto                    | 0 |
    | 2 |  7834646 | Otto  - TZ (HB)         | 0 |
    | 3 | 14485928 | Schwab Versand GmbH     | 0 |
    | 4 |  5423454 | Schwab - TZ (HB)        | 0 |
    | 5 | 14913536 | Hanseatic Bank          | 0 |
    | 6 | 14485937 | 3-Pagen Versand         | 0 |
    | 7 |  8371420 | Fegro Markt G. M. B. H. | 0 |
    | 8 | 14485941 | Heinrich Heine Versand  | 0 |
    | 9 | 14485942 | Hermes T. Kundendienst  | 0 |
    
    0.093s, 10 rows - *MORE ROWS EXIST*

=cut

# -----------------------------------------------------------------------------

sub asTable {
    my $self = shift;
    # @_: @opt

    # Optionen

    my $msg = '';
    my $info = 3;

    if (@_) {
        Prty::Option->extract(\@_,
            -msg=>\$msg,
            -info=>\$info,
        );
        if ($msg) {
            $msg = $info? " - $msg": $msg;
        }
    }

    my $str = '';

    # Statement

    if ($info >= 3) {
        $str .= $self->stmt;
        $str .= "\n\n";
    }
    if ($info >= 2) {
        # Kolumnenbezeichnungen

        my @titles = $self->titles;
        my $l = length scalar @titles;
        for (my $i = 0; $i < @titles; $i++) {
            $str .= sprintf "%*d %s\n",$l,$i+1,$titles[$i];
        }
    }

    if ($self->count) {
        my @fmt = $self->formats;

        if ($info) {
            # Kolumnenzeile

            $str .= "\n";
            for (my $i = 0; $i < @fmt; $i++) {
                my $numWidth = length $i+1;
                my $width = $fmt[$i]->width+3;
                $str .= sprintf '%d%s',$i+1,(' ' x ($width-$numWidth));
            }
            $str .= "\n";
        }

        # Tabelle

        for my $row ($self->rows) {
            my @arr = $row->asArray;
            $str .= '| ';
            for (my $i = 0; $i < @arr; $i++) {
                if ($i) {
                    $str .= ' | ';
                }
                $str .= $fmt[$i]->asFixedWidthString($arr[$i]);
            }
            $str .= " |\n";
        }
    }

    if ($info) {
        # Statistik

        my $duration = $self->execTime + $self->fetchTime;
        $str .= sprintf "\n%s, %s rows",
            Prty::Duration->new($duration)->asShortString(-precision=>3),
            $self->count;
    }
    if ($msg) {
        $str .= $msg;
    }
    if ($info || $msg) {
        $str .= "\n";
    }

    return $str;
}

# -----------------------------------------------------------------------------

=head3 diffReport() - Report über Differenzen

=head4 Synopsis

    $str = $tab->diffReport;

=cut

# -----------------------------------------------------------------------------

sub diffReport {
    my $self = shift;

    my $titles = $self->titles;
    my $keyTitle = $titles->[0];

    my $str = '';
    my $count = 0;
    for (my $i = 1; $i < @$titles; $i += 2) {
        my $title1 = $titles->[$i];
        my $title2 = $titles->[$i+1];

        my @diff;
        for my $row ($self->rows) {
            my $val1 = $row->$title1;
            my $val2 = $row->$title2;

            if ($val1 ne $val2) {
                my $key = $row->$keyTitle;
                $val1 = '(null)' if $val1 eq '';
                $val2 = '(null)' if $val2 eq '';
                CORE::push @diff,[$key,$val1,$val2];
                $count++;
            }
        }
        if (@diff) {
            my @type = (1) x 3;
            my @len = (0) x 3;
            for my $diff (@diff) {
                for (my $i = 0; $i < 3; $i++) {
                    my $val = $diff->[$i];
                    if ($val ne '(null)' && $val =~ /[a-zA-Z]/) {
                        $type[$i] = -1;
                    }
                    my $l = length $val;
                    if ($l > $len[$i]) {
                        $len[$i] = $l;
                    }
                }
            }
            for (my $i = 0; $i < 3; $i++) {
                $len[$i] *= $type[$i];
            }

            my $title = "$keyTitle | $title1 | $title2";
            if ($str) {
                $str .= "\n";
            }
            $str .= "$title\n".('-' x length($title))."\n";
            for my $diff (@diff) {
                $str .= sprintf "%*s | %*s | %*s\n",$len[0],$diff->[0],
                    $len[1],$diff->[1],$len[2],$diff->[2];
            }
        }
    }
    
    return wantarray? ($str,$count): $str;
}

# -----------------------------------------------------------------------------

=head1 VERSION

1.128

=head1 AUTHOR

Frank Seitz, L<http://fseitz.de/>

=head1 COPYRIGHT

Copyright (C) 2019 Frank Seitz

=head1 LICENSE

This code is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

# -----------------------------------------------------------------------------

1;

# eof

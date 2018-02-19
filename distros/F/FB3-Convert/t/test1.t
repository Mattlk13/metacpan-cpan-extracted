#!/usr/local/bin/perl

use 5.006;
use strict;
use warnings;
use FB3::Convert;
use XML::Diff;
use File::Basename;
use Data::Dumper;
use utf8;
use Encode;
use XML::LibXML;
use Test::More;
use File::Temp qw/tempdir/;

plan tests => 1;

diag( "Testing result of body.xml, Perl $], $^X" );

my $Diff = XML::Diff->new();

my $DIR = dirname(__FILE__).'/examples';
opendir(my $DH, $DIR) || die "Can't opendir $DIR: $!";
my @Epubs = grep { $_ =~ /.+\.epub$/ && -f $DIR."/".$_ } readdir($DH);
closedir $DH;

foreach my $EpubFile (sort{Num($a)<=>Num($b)} @Epubs ) {

  $EpubFile =~ m/^(.+)\.epub$/;
  my $FName = $1;

  my $OldXml = $DIR.'/'.$FName.'.xml';

  diag("Testing ".$DIR.'/'.$EpubFile.' and compare with '.$OldXml);
  die("file $OldXml not found") unless -f $OldXml;

  my $Obj = new FB3::Convert(
    'source' => $DIR.'/'.$EpubFile,
    'destination_dir' => tempdir(CLEANUP=>1),
    'verbose' => 0,
  );

  $Obj->Reap();
  my $FB3Path =  $Obj->FB3Create();
  my $ValidErr = $Obj->Validate();
  if ($ValidErr) {
    diag($ValidErr);
    $Obj->Cleanup();
    exit;
  }

  my $NewXml = $FB3Path.'/fb3/body.xml';

  _Diff($Obj,$OldXml,$NewXml);

  $Obj->Cleanup();

}

ok(1,'Test ok');
exit;

sub Num {
  my $Fname=shift;
  $Fname =~ /(\d+)\.epub/;
  $Fname=$1;
  return $Fname;
}

sub _Diff {
  my $X = shift;
  my $OldFile = shift;
  my $NewFile = shift;

  open my $fho, '<', $OldFile or die $!;
  my $OldXml;
  map {$OldXml .= $_} <$fho>;
  close $fho;
  $OldXml = Encode::decode_utf8(Encode::encode_utf8($OldXml));
  $OldXml =~ s#xmlns="http://www.fictionbook.org/FictionBook3/body"##g;

  open my $fhn, '<', $NewFile or die $!;
  my $NewXml;
  map {$NewXml .= $_} <$fhn>;
  $NewXml = Encode::decode_utf8(Encode::encode_utf8($NewXml));
  close $fhn;
  $NewXml =~ s#xmlns="http://www.fictionbook.org/FictionBook3/body"##g;

  my $Diffgram = $Diff->compare(-old => $OldXml, -new => $NewXml);
  $Diffgram =~ s#(<xvcs:diffgram)#$1 xmlns:xlink="http://www.w3.org/1999/xlink"#g;
  my $XMLDoc = XML::LibXML->load_xml(string=>$Diffgram) || die "Can't parse! ".$!;
 
  my $Root = $XMLDoc->getDocumentElement;

  my $Err;
  foreach my $Event ( $Root->getChildnodes ) {
    my $EventName = $Event->nodeName();

    my $EventNodeName;
    my $ContainerName;
    if ($EventNodeName = $Event->getAttribute('first-child-of')) {
      $ContainerName = 'first-child-of';
    } elsif ($EventNodeName = $Event->getAttribute('follows')){
      $ContainerName = 'follows';
    }

    my $DiffError;
    foreach my $NodeDiff ($Event->getChildnodes) {
      my $DiffName = $NodeDiff->nodeName();

      if ( $DiffName =~ /^xvcs:.+$/ ) {

        if ($DiffName eq 'xvcs:attr-update') {

          next if ($NodeDiff->getAttribute('name') =~ /^(src|id|xlink:href)$/i); #it's OK event

          $DiffError .= $DiffName."\n";
          $DiffError .= "  name: ".$NodeDiff->getAttribute('name')."\n";
          $DiffError .= "  old: ".$NodeDiff->getAttribute('old-value')."\n";
          $DiffError .= "  new: ".$NodeDiff->getAttribute('new-value');
          next;

        }

        if ($DiffName eq 'xvcs:attr-delete' || $DiffName eq 'xvcs:attr-insert') {
          $DiffError .= $DiffName."\n";
          $DiffError .= "  name: ".$NodeDiff->getAttribute('name')."\n";
          $DiffError .= "  value: ".$NodeDiff->getAttribute('value');
          next;
        }

        $DiffError .= $DiffName; #all other errors

      } else {
        $DiffError .= $X->InNode($Event);
      }

    }

    if ($DiffError) {
      $Err .= "Critical diff!\n";
      $Err .= " event: ".xtrim($EventName)."\n";
      $Err .= " ".$ContainerName.": ".$EventNodeName."\n";
      $Err .= " content: ".$DiffError."\n\n";
    }

  }

  if ($Err) {
    diag($Err);
    $X->Cleanup();
    exit;
  }

  return 1;
}

sub xtrim {
  my $str = shift;
  $str =~ s/.+:([a-z0-9\-_]+)$/$1/i;
  return $str;
}


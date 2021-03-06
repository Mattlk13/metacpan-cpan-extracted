use 5.008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    "NAME"    => "Bio::Prospect",
    "VERSION" => "1.04",
    "PMLIBDIRS" => [ "Bio/Prospect" ],
    "PREREQ_PM" => {
      'Bio::Annotation::Collection' => '0', 'Bio::Tools::IUPAC' => '0',
      'IO::Scalar' => '2.104 ', 'Bio::SeqUtils' => '0',
      'Bio::Location::Simple' => '0', 'Bio::SeqI' => '0',
      'URI' => '1.27', 'Bio::PrimarySeqI' => '0',
      'Bio::Root::IO' => '0', 'Bio::Symbol::ProteinAlphabet' => '0',
      'Bio::FeatureHolderI' => '0', 'Bio::SimpleAlign' => '0',
      'Bio::Annotation::SimpleValue' => '0', 'Bio::Align::AlignI' => '0',
      'Bio::Symbol::Symbol' => '0', 'Bio::IdentifiableI' => '0',
      'Bio::Location::WidestCoordPolicy' => '0', 'Bio::Symbol::Alphabet' => '0',
      'Bio::LocatableSeq' => '0', 'Bio::LocationI' => '0',
      'Bio::Root::RootI' => '1', 'Bio::Structure::Entry' => '0',
      'Bio::Location::Fuzzy' => '0', 'Bio::Annotation::TypeManager' => '0',
      'Bio::AlignIO' => '0', 'Data::Dumper' => '2.121',
      'Bio::AnnotationCollectionI' => '0', 'Bio::Tools::CodonTable' => '0',
      'Bio::Structure::Model' => '0', 'Bio::Symbol::SymbolI' => '0',
      'Bio::AnnotatableI' => '0', 'IO::WrapTie' => '2.102 ',
      'Bio::Seq' => '1.1', 'Carp::Assert' => '0.17',
      'Bio::Structure::StructureI' => '0', 'Bio::DescribableI' => '0',
      'Bio::Symbol::AlphabetI' => '0', 'Bio::PrimarySeq' => '0',
      'SOAP::Lite' => '0.55', 'IO::String' => '1.02',
      'Bio::Location::Atomic' => '0', 'Error' => '0.15',
      'Bio::Root::Root' => '1', 'Bio::RangeI' => '0',
      'Bio::Location::FuzzyLocationI' => '0', 'Bio::Location::CoordinatePolicyI' => '0',
      'Bio::Structure::IO' => '0', 'Bio::Root::Exception' => '0',
      'Bio::Structure::Chain' => '0', 'XML::Simple' => '2.09',
      'URI::Escape' => '3.21', 'Bio::AnnotationI' => '0'
      },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
          ( AUTHOR     => "David S. Cavanaugh <cavs@gene.com> and Reece K. Hart <rkh@gene.com>") : ()),
);

my($PROSPECT_PATH,$PDB_PATH,$MVIEW_APP);
print "Searching environment for PROSPECT_PATH...\n";
if ( defined $ENV{'PROSPECT_PATH'} && -d $ENV{'PROSPECT_PATH'} ) {
  $PROSPECT_PATH = $ENV{'PROSPECT_PATH'};
  print "\tfound \$PROSPECT_PATH=$ENV{'PROSPECT_PATH'}; assigning \$Bio::Prospect::Init::PROSPECT_PATH = $ENV{'PROSPECT_PATH'}\n";
} else {
  print STDERR "\tWARNING: unable to find PROSPECT_PATH environment variable\n" .
    "\tYou will need to define \$Bio::Prospect::Init::PROSPECT_PATH manually\n";
}

print "Searching environment for PDB_PATH...\n";
if ( defined $ENV{'PDB_PATH'} && -d $ENV{'PDB_PATH'} ) {
  $PDB_PATH = $ENV{'PDB_PATH'};
  print "\tfound \$PDB_PATH=$ENV{'PDB_PATH'}; assigning \$Bio::Prospect::Init::PDB_PATH = $ENV{'PDB_PATH'}\n";
} else {
  print STDERR "\tWARNING: unable to find PDB_PATH environment variable\n" .
    "\tYou will need to define \$Bio::Prospect::Init::PDB_PATH manually\n";
}

print "Searching environment for mview ...\n";
chomp($MVIEW_APP = `which mview 2>/dev/null`);
if ( defined $MVIEW_APP && -x $MVIEW_APP ) {
  print "\tfound $MVIEW_APP; assigning \$Bio::Prospect::Init::MVIEW_APP = $MVIEW_APP\n";
} else {
  print STDERR "\tWARNING: unable to find mview in the path.\n" .
    "\tYou will need to define \$Bio::Prospect::Init::MVIEW_APP manually\n";
}


my $init_fn = 'Bio/Prospect/Init.pm';
open( IN, "<$init_fn" )      or die( "can't open $init_fn for reading\n" );
open( OUT, ">$init_fn.tmp" ) or die( "can't open $init_fn.tmp for writing\n" );
while(<IN>){
  if      ( m/^\$Bio::Prospect::Init::PROSPECT_PATH/ && defined $PROSPECT_PATH ){
    print OUT "\$Bio::Prospect::Init::PROSPECT_PATH = '$PROSPECT_PATH';\n";
  } elsif ( m/^\$Bio::Prospect::Init::PDB_PATH/ && defined $PDB_PATH ){
    print OUT "\$Bio::Prospect::Init::PDB_PATH = '$PDB_PATH';\n";
  } elsif ( m/^\$Bio::Prospect::Init::MVIEW_APP/ && defined $MVIEW_APP ){
    print OUT "\$Bio::Prospect::Init::MVIEW_APP = '$MVIEW_APP';\n";
  } else {
    print OUT;
  }
}
system( "mv -f $init_fn.tmp $init_fn" );

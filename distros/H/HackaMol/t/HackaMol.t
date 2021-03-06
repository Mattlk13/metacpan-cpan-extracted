#!/usr/bin/env perl

use strict;
use warnings;
use Test::Moose;
use Test::More;
use Test::Fatal qw(dies_ok);
use Test::Warn;
use Math::Vector::Real;
use Math::Vector::Real::Random;
use Math::Trig;
use HackaMol;

{    # test HackaMol class attributes and methods
    my @attributes = qw(name);
    my @methods    = qw(
      build_bonds build_angles build_dihedrals
      group_by_atom_attr group_by_atom_attrs read_file_mol read_file_push_coords_mol
      read_file_atoms read_pdb_atoms read_xyz_atoms pdbid_mol
    );

    my @roles = qw(
                  HackaMol::Roles::MolReadRole 
                  HackaMol::Roles::NameRole
                  HackaMol::Roles::PathRole 
                  HackaMol::Roles::ExeRole);

    map has_attribute_ok( 'HackaMol', $_ ), @attributes;
    map can_ok( 'HackaMol', $_ ), @methods;
    map does_ok( 'HackaMol', $_ ), @roles;
}

{    #with use HackaMol, HackaMol::Atom, HackaMol::Molecule .. accessible
    my $merc = HackaMol::Atom->new(
        name    => "Mercury",
        Z       => 80,
        charges => [0],
        coords  => [ V( 0, 0, 0 ) ]
    );
    my $mercg = HackaMol::AtomGroup->new( name => "MercG", atoms => [$merc] );
    my $mercm = HackaMol::Molecule->new(
        name  => "MercM",
        atoms => [ $mercg->all_atoms ]
    );

    ok( defined $merc,                      'HackaMol::Atom->new' );
    ok( $merc->isa('HackaMol::Atom'),       'isa HackaMol::Atom' );
    ok( $merc->symbol eq 'Hg',              'symbol Hg' );
    ok( $merc->name eq 'Mercury',           'name is as set' );
    ok( defined $mercg,                     'HackaMol::AtomGroup->new' );
    ok( $mercg->isa('HackaMol::AtomGroup'), 'isa HackaMol::AtomGroup' );
    ok( defined $mercm,                     'HackaMol::Molecule->new' );
    ok( $mercm->isa('HackaMol::Molecule'),  'isa HackaMol::Molecule' );
}

{    #taken from AtomGroup Test... seems redundant
    my $radius = 16;
    my $natoms = int( 0.0334 * ( $radius**3 ) * 4 * pi / 3 );

    my @atoms =
      map { HackaMol::Atom->new( Z => 8, charges => [0], coords => [$_] ) }
      map { Math::Vector::Real->random_in_sphere( 3, $radius ) } 1 .. $natoms;

    my $group =
      HackaMol::AtomGroup->new( name => 'biggroup', atoms => [@atoms] );
    my $mol = HackaMol::Molecule->new(
        name       => 'bg_mol',
        groups     => [$group]
    );

    is( $group->count_atoms, $natoms, "group atom count: $natoms" );
    is( $mol->count_atoms,   $natoms, "mol atom count: $natoms" );
    is( $group->count_unique_atoms, 1, 'group unique atoms in sphere is 1' );
    is( $mol->count_unique_atoms,   1, "mol unique atoms in sphere is 1" );
    is( $group->bin_atoms_name, "O$natoms",
        "group sphere atoms named O$natoms" );
    is( $mol->bin_atoms_name, "O$natoms", "mol sphere atoms named O$natoms" );
    cmp_ok( 2 - abs( $group->COM ),
        '>', 0, 'group center of mass within 2 angstrom of 0,0,0' );
    cmp_ok( abs( $mol->COM - $group->COM ),
        '<', 1E-10, 'mol com same as group com' );
    cmp_ok( abs( $group->COZ - $group->COM ), '<', 1E-7, 'COM ~ COZ' );
    cmp_ok( $group->total_charge, '==', 0, 'group total charges 0' );
    cmp_ok( $mol->total_charge,   '==', 0, 'mol total charges 0' );
    cmp_ok( abs( $group->dipole_moment ),
        '<', 1E-7, 'group dipole moment is zero, no charges' );
    cmp_ok( abs( $mol->dipole_moment ),
        '<', 1E-7, 'mol dipole moment is zero, no charges' );
    my $exp_Rg = sqrt( $radius * $radius * 3 / 5 );
    cmp_ok( abs( $exp_Rg - $group->Rg ),
        '<', 0.75, 'group numerical Rg within 0.75 Angs of theoretical' );
    cmp_ok( abs( $mol->Rg - $group->Rg ), '<', 1E-7, 'group and Mol Rg same' );
}

#test HackaMol class building methods

my $hack = HackaMol->new( name => "hackitup" );
is( $hack->name, "hackitup", "HackaMol name attr" );

{    #reading pdb/xyz into molecule or atoms
    my @atoms1 = $hack->read_file_atoms("t/lib/1L2Y_mod123.pdb");
    my $mol1 =
      HackaMol::Molecule->new( name => 'trp-cage', atoms => [@atoms1] );
    is( $mol1->count_atoms, 304, "read atoms in from pdb" );

    unlink("t/lib/1L2Y.xyz");
    my $fh = $mol1->print_xyz("t/lib/1L2Y.xyz");
    $fh->close;

    my $mol2 = $hack->read_file_mol("t/lib/1L2Y.xyz");

    is ($mol1->string_xyz(''), $mol2->string_xyz,'xyzs are same after reading');
    #is( $mol2->count_atoms, 304, "read atoms in from xyz" );

    my @Z1 = map { $_->Z } $mol1->all_atoms;
    my @Z2 = map { $_->Z } $mol2->all_atoms;

    is_deeply( \@Z1, \@Z2, "xyz and pdb give same atoms" );
}

{    # read from strings!
my $benzene =
'  C        0.00000        1.40272        0.00000
  H        0.00000        2.49029        0.00000
  C       -1.21479        0.70136        0.00000
  H       -2.15666        1.24515        0.00000
  C       -1.21479       -0.70136        0.00000
  H       -2.15666       -1.24515        0.00000
  C        0.00000       -1.40272        0.00000
  H        0.00000       -2.49029        0.00000
  C        1.21479       -0.70136        0.00000
  H        2.15666       -1.24515        0.00000
  C        1.21479        0.70136        0.00000
  H        2.15666        1.24515        0.00000
'; 

my $benz = $hack->read_string_mol($benzene,'xyz');
is($benz->count_atoms, 12, '12 atoms read in using a string!' );

my $viral_3j3q_cif =
'
_loop
_atom_site.group_PDB 
_atom_site.id 
_atom_site.type_symbol 
_atom_site.label_atom_id 
_atom_site.label_alt_id 
_atom_site.label_comp_id 
_atom_site.label_asym_id 
_atom_site.label_entity_id 
_atom_site.label_seq_id 
_atom_site.pdbx_PDB_ins_code 
_atom_site.Cartn_x 
_atom_site.Cartn_y 
_atom_site.Cartn_z 
_atom_site.occupancy 
_atom_site.B_iso_or_equiv 
_atom_site.pdbx_formal_charge 
_atom_site.auth_seq_id 
_atom_site.auth_comp_id 
_atom_site.auth_asym_id 
_atom_site.auth_atom_id 
_atom_site.pdbx_PDB_model_num 
ATOM 5385    N N   . VAL C   1 230 ? 324.140 958.751  380.503 1.0 0.00 ? 230 VAL ga N   1
ATOM 5386    C CA  . VAL C   1 230 ? 325.000 959.272  379.469 1.0 0.00 ? 230 VAL ga CA  1
ATOM 5387    C C   . VAL C   1 230 ? 324.380 959.228  378.117 1.0 0.00 ? 230 VAL ga C   1
ATOM 5388    O O   . VAL C   1 230 ? 323.760 958.294  377.715 1.0 0.00 ? 230 VAL ga O   1
ATOM 5389    C CB  . VAL C   1 230 ? 326.490 958.762  379.611 1.0 0.00 ? 230 VAL ga CB  1
ATOM 5390    C CG1 . VAL C   1 230 ? 327.030 959.293  380.927 1.0 0.00 ? 230 VAL ga CG1 1
ATOM 5391    C CG2 . VAL C   1 230 ? 326.490 957.239  379.477 1.0 0.00 ? 230 VAL ga CG2 1
ATOM 5392    N N   . LEU C   1 231 ? 324.620 960.407  377.457 1.0 0.00 ? 231 LEU ga N   1
ATOM 5393    C CA  . LEU C   1 231 ? 324.220 960.708  376.094 1.0 0.00 ? 231 LEU ga CA  1
ATOM 5394    C C   . LEU C   1 231 ? 325.400 960.443  375.037 1.0 0.00 ? 231 LEU ga C   1
ATOM 5395    O O   . LEU C   1 231 ? 325.420 959.347  374.423 1.0 0.00 ? 231 LEU ga O   1
ATOM 5396    C CB  . LEU C   1 231 ? 323.590 962.118  376.020 1.0 0.00 ? 231 LEU ga CB  1
ATOM 5397    C CG  . LEU C   1 231 ? 322.820 962.406  374.688 1.0 0.00 ? 231 LEU ga CG  1
ATOM 5398    C CD1 . LEU C   1 231 ? 321.840 961.262  374.231 1.0 0.00 ? 231 LEU ga CD1 1
ATOM 5399    C CD2 . LEU C   1 231 ? 322.070 963.693  375.125 1.0 0.00 ? 231 LEU ga CD2 1
ATOM 5400    O OXT . LEU C   1 231 ? 326.370 961.240  374.918 1.0 0.00 ? 231 LEU ga OXT 1
ATOM 5401    N N   . PRO D   1 1   ? 279.970 945.618  347.788 1.0 0.00 ? 1   PRO gb N   1
ATOM 5402    C CA  . PRO D   1 1   ? 279.630 946.879  348.520 1.0 0.00 ? 1   PRO gb CA  1
ATOM 5403    C C   . PRO D   1 1   ? 279.080 947.872  347.570 1.0 0.00 ? 1   PRO gb C   1
ATOM 5404    O O   . PRO D   1 1   ? 279.240 947.647  346.388 1.0 0.00 ? 1   PRO gb O   1
ATOM 5405    C CB  . PRO D   1 1   ? 280.940 947.248  349.276 1.0 0.00 ? 1   PRO gb CB  1
ATOM 5406    C CG  . PRO D   1 1   ? 282.030 946.520  348.432 1.0 0.00 ? 1   PRO gb CG  1
ATOM 5407    C CD  . PRO D   1 1   ? 281.400 945.145  348.003 1.0 0.00 ? 1   PRO gb CD  1
ATOM 5408    N N   . ILE D   1 2   ? 278.460 948.915  348.086 1.0 0.00 ? 2   ILE gb N   1
ATOM 5409    C CA  . ILE D   1 2   ? 277.980 949.997  347.340 1.0 0.00 ? 2   ILE gb CA  1
ATOM 5410    C C   . ILE D   1 2   ? 278.720 951.208  347.794 1.0 0.00 ? 2   ILE gb C   1
ATOM 5411    O O   . ILE D   1 2   ? 278.970 951.417  348.964 1.0 0.00 ? 2   ILE gb O   1
ATOM 5412    C CB  . ILE D   1 2   ? 276.490 950.161  347.487 1.0 0.00 ? 2   ILE gb CB  1
ATOM 5413    C CG1 . ILE D   1 2   ? 275.710 948.961  347.008 1.0 0.00 ? 2   ILE gb CG1 1
ATOM 5414    C CG2 . ILE D   1 2   ? 276.010 951.525  346.925 1.0 0.00 ? 2   ILE gb CG2 1
ATOM 5415    C CD1 . ILE D   1 2   ? 275.950 948.634  345.500 1.0 0.00 ? 2   ILE gb CD1 1
ATOM 5385    N N   . VAL C   1 230 ? 324.140 958.751  380.503 1.0 0.00 ? 230 VAL ga N   2
ATOM 5386    C CA  . VAL C   1 230 ? 325.000 959.272  379.469 1.0 0.00 ? 230 VAL ga CA  2
ATOM 5387    C C   . VAL C   1 230 ? 324.380 959.228  378.117 1.0 0.00 ? 230 VAL ga C   2
ATOM 5388    O O   . VAL C   1 230 ? 323.760 958.294  377.715 1.0 0.00 ? 230 VAL ga O   2
ATOM 5389    C CB  . VAL C   1 230 ? 326.490 958.762  379.611 1.0 0.00 ? 230 VAL ga CB  2
ATOM 5390    C CG1 . VAL C   1 230 ? 327.030 959.293  380.927 1.0 0.00 ? 230 VAL ga CG1 2
ATOM 5391    C CG2 . VAL C   1 230 ? 326.490 957.239  379.477 1.0 0.00 ? 230 VAL ga CG2 2
ATOM 5392    N N   . LEU C   1 231 ? 324.620 960.407  377.457 1.0 0.00 ? 231 LEU ga N   2
ATOM 5393    C CA  . LEU C   1 231 ? 324.220 960.708  376.094 1.0 0.00 ? 231 LEU ga CA  2
ATOM 5394    C C   . LEU C   1 231 ? 325.400 960.443  375.037 1.0 0.00 ? 231 LEU ga C   2
ATOM 5395    O O   . LEU C   1 231 ? 325.420 959.347  374.423 1.0 0.00 ? 231 LEU ga O   2
ATOM 5396    C CB  . LEU C   1 231 ? 323.590 962.118  376.020 1.0 0.00 ? 231 LEU ga CB  2
ATOM 5397    C CG  . LEU C   1 231 ? 322.820 962.406  374.688 1.0 0.00 ? 231 LEU ga CG  2
ATOM 5398    C CD1 . LEU C   1 231 ? 321.840 961.262  374.231 1.0 0.00 ? 231 LEU ga CD1 2
ATOM 5399    C CD2 . LEU C   1 231 ? 322.070 963.693  375.125 1.0 0.00 ? 231 LEU ga CD2 2
ATOM 5400    O OXT . LEU C   1 231 ? 326.370 961.240  374.918 1.0 0.00 ? 231 LEU ga OXT 2
ATOM 5401    N N   . PRO D   1 1   ? 279.970 945.618  347.788 1.0 0.00 ? 1   PRO gb N   2
ATOM 5402    C CA  . PRO D   1 1   ? 279.630 946.879  348.520 1.0 0.00 ? 1   PRO gb CA  2
ATOM 5403    C C   . PRO D   1 1   ? 279.080 947.872  347.570 1.0 0.00 ? 1   PRO gb C   2
ATOM 5404    O O   . PRO D   1 1   ? 279.240 947.647  346.388 1.0 0.00 ? 1   PRO gb O   2
ATOM 5405    C CB  . PRO D   1 1   ? 280.940 947.248  349.276 1.0 0.00 ? 1   PRO gb CB  2
ATOM 5406    C CG  . PRO D   1 1   ? 282.030 946.520  348.432 1.0 0.00 ? 1   PRO gb CG  2
ATOM 5407    C CD  . PRO D   1 1   ? 281.400 945.145  348.003 1.0 0.00 ? 1   PRO gb CD  2
ATOM 5408    N N   . ILE D   1 2   ? 278.460 948.915  348.086 1.0 0.00 ? 2   ILE gb N   2
ATOM 5409    C CA  . ILE D   1 2   ? 277.980 949.997  347.340 1.0 0.00 ? 2   ILE gb CA  2
ATOM 5410    C C   . ILE D   1 2   ? 278.720 951.208  347.794 1.0 0.00 ? 2   ILE gb C   2
ATOM 5411    O O   . ILE D   1 2   ? 278.970 951.417  348.964 1.0 0.00 ? 2   ILE gb O   2
ATOM 5412    C CB  . ILE D   1 2   ? 276.490 950.161  347.487 1.0 0.00 ? 2   ILE gb CB  2
ATOM 5413    C CG1 . ILE D   1 2   ? 275.710 948.961  347.008 1.0 0.00 ? 2   ILE gb CG1 2
ATOM 5414    C CG2 . ILE D   1 2   ? 276.010 951.525  346.925 1.0 0.00 ? 2   ILE gb CG2 2
ATOM 5415    C CD1 . ILE D   1 2   ? 275.950 948.634  345.500 1.0 0.00 ? 2   ILE gb CD1 2';

print "DMRok\n";
my $viral_chunk = $hack->read_string_mol($viral_3j3q_cif,'cif');
is($viral_chunk->count_atoms, 31, '12 atoms read in viral_chunk a string!' );
is($viral_chunk->get_atoms(30)->entity_id, 1, 'entity_id');
is($viral_chunk->get_atoms(30)->auth_asym_id, 'gb', 'entity_id');

}

{    # croaking and carping
    dies_ok { $hack->pdbid_mol() }
    "Croak on passing pdbid, e.g. 2cba";

    dies_ok { $hack->read_file_atoms("bah.mol") }
    "Croak on unsupported file type";

    dies_ok { $hack->read_file_atoms("t/lib/bad1.xyz") }
    "xyz Croak change symbol";
    dies_ok { $hack->read_file_atoms("t/lib/bad2.xyz") } "xyz Croak change Z";
    dies_ok { $hack->read_file_atoms("t/lib/bad3.xyz") }
    "xyz Croak change number of atoms";

    warning_is { $hack->read_file_atoms("t/lib/bad1.pdb") }
    "BAD t->1 PDB Atom 0 serial 1 resname ASN has changed",
      "carp warning for bad model in pdb file";

    warning_is { $hack->read_file_atoms("t/lib/bad2.pdb") }
    "BAD t->1 PDB Atom 1 serial 2 resname ASN has changed",
      "carp warning for bad model in pdb file";

}

{    # read xyz filed with different but same representations
    my @wats1 = $hack->read_file_atoms("t/lib/byZ.xyz");
    my @wats2 = $hack->read_file_atoms("t/lib/byZSym.xyz");

    my @Zw1 = map { $_->Z } @wats1;
    my @Zw2 = map { $_->Z } @wats2;

    is_deeply( \@Zw1, \@Zw2, "different Z/Symbol formatted xyz give same" );
}

my $mol1 = $hack->read_file_mol("t/lib/1L2Y_mod123.pdb");
is( $mol1->tmax, 2, "index of last coords for each atom" );

my $mol_lys = HackaMol->new(readline_func => sub{ return "PDB_SKIP" unless /LYS/})->read_file_mol("t/lib/1L2Y_mod123.pdb");
ok ($mol_lys->count_atoms, "readline_func for LYS read still has atoms");
is ($mol_lys->select_group("resname LYS")->count_atoms, $mol_lys->count_atoms, "only lysines are parsed");

#{
#  my $mol = $hack->read_file_mol("t/lib/shit.zmat");
#  $mol->print_xyz;
#  exit;
#}

# t/lib/head_model_atom.pdb 
{
    my $mol = $hack->read_pdbfile_mol("t/lib/head_model_atom.pdb");
    is($mol->info ,"SOME HEADER information\nSOME MORE HEADER information\n", "header extracted");
    is($mol->get_model_id(0),2, 'first model id is 2');
    is($mol->get_model_id(1),4, 'second model id is 2');
}

#read_file push_coords tests
{
  
  my $mol = $hack->read_file_mol("t/lib/Hg.2-18w.xyz");

  dies_ok { $hack->read_file_push_coords_mol( "t/lib/Zn.2-18w.xyz", $mol ) }
    "read_file_push_coords_mol> dies ok if atoms are different";

  dies_ok {
    $hack->read_file_push_coords_mol("bah.xyz")
  }
  "read_file_push_coords_mol> dies ok if no molecule object passed";

  $hack->read_file_push_coords_mol( "t/lib/Hg.2-18w.xyz", $mol );
  $hack->read_file_push_coords_mol( "t/lib/Hg.2-18w.xyz", $mol );
  is( $mol1->tmax, 2,
    "read_file_push_coords_mol> index of last coords for each atom after append" );

  dies_ok { $hack->read_file_push_coords_mol( "t/lib/1L2Y_mod123.pdb", $mol ) }
    "read_file_push_coords_mol> dies ok if number of atoms are different";

}

#test group generation
my @gresids = $hack->group_by_atom_attr( 'resid',  $mol1->all_atoms );
my @gsymbls = $hack->group_by_atom_attr( 'symbol', $mol1->all_atoms );
my @gnames  = $hack->group_by_atom_attr( 'name',   $mol1->all_atoms );
$mol1->push_groups(@gresids);
is( $mol1->count_groups, 20, "group_by_atom_resid" );
$mol1->clear_groups;
is( $mol1->count_groups, 0, "clear->groups" );
$mol1->push_groups(@gsymbls);
is( $mol1->count_groups, 4, "group_by_atom_symbol" );
$mol1->clear_groups;
$mol1->push_groups(@gnames);
is( $mol1->count_groups, 74, "group_by_atom_name" );

#test group generation for multiple attrs
my @aas = $hack->group_by_atom_attrs( ['resname', 'resid'],  $mol1->all_atoms );
is( scalar(@aas), 20, "group_by_atom_attrs resname, resid -> 20 groups" );

#my $i = 0;
#print $i++, " ", $_->get_atoms(0)->resname . " ". $_->get_atoms(0)->resid . "\n" foreach @aas; exit;

my @bb = grep { $_->name eq 'N' or $_->name eq 'CA' or $_->name eq 'C' }
  $mol1->all_atoms;

my @bonds     = $hack->build_bonds(@bb);
my @angles    = $hack->build_angles(@bb);
my @dihedrals = $hack->build_dihedrals(@bb);

is( scalar(@bonds),       scalar(@bb) - 1,    "number of bonds generated" );
is( scalar(@angles),      scalar(@bb) - 2,    "number of angles generated" );
is( scalar(@dihedrals),   scalar(@bb) - 3,    "number of dihedrals generated" );
is( $dihedrals[0]->name,  'N1_CA1_C1_N2',     "dihedral name1" );
is( $angles[0]->name,     'N1_CA1_C1',        "angle name1" );
is( $bonds[0]->name,      'N1_CA1',           "bond name1" );
is( $bonds[1]->name,      'CA1_C1',           "bond name2" );
is( $bonds[2]->name,      'C1_N2',            "bond name3" );
is( $angles[1]->name,     'CA1_C1_N2',        "second angle name" );
is( $dihedrals[-1]->name, 'C19_N20_CA20_C20', "last dihedral name" );
is( $bonds[-1]->name,     'CA20_C20',         "last bond name1" );
is( $angles[-1]->name,    'N20_CA20_C20',     "last angle name1" );

dies_ok { $hack->build_dihedrals( @bb[ 0 .. 2 ] ) } "build_dihedrals croak";
dies_ok { $hack->build_bonds( $bb[0] ) } "build_bonds croak";
dies_ok { $hack->build_angles( @bb[ 0, 1 ] ) } "build_angles croak";

{
    $_->clear_name foreach @bb;
    my @bonds     = $hack->build_bonds(@bb);
    my @angles    = $hack->build_angles(@bb);
    my @dihedrals = $hack->build_dihedrals(@bb);

    is( $dihedrals[0]->name, 'D1_D1_D1_D2', "dihedral noname default" );
    is( $angles[0]->name,    'A1_A1_A1',    "angle noname default" );
    is( $bonds[0]->name,     'B1_B1',       "bond noname default" );
}

{
    $_->name("foo") foreach @bb;
    $_->resid foreach @bb;
    my @bonds     = $hack->build_bonds(@bb);
    my @angles    = $hack->build_angles(@bb);
    my @dihedrals = $hack->build_dihedrals(@bb);

    is( $dihedrals[0]->name, 'foo1_foo1_foo1_foo2',
        "dihedral name foo resid default" );
    is( $angles[0]->name, 'foo1_foo1_foo1', "angle name foo resid default" );
    is( $bonds[0]->name,  'foo1_foo1',      "bond name foo resid default" );

}

{    #find_disulfide_bonds
    my $mol = $hack->read_file_mol("t/lib/1V0Z_A.pdb");
    my @ss  = $hack->find_disulfide_bonds( $mol->all_atoms );
    is( scalar(@ss), 9, "found 9  disulfides in 1V0Z" );
    my @ss_atoms = map { $_->all_atoms } @ss;
    is( scalar(@ss_atoms), 18, "9  disulfides have 18 atoms" );
    is( ( grep { $_->symbol eq "S" } @ss_atoms ), 18, "18 Sulfur atoms" );
    my $bc = 0;
    $bc += $_->bond_count foreach @ss_atoms;
    is( $bc, 0, "0 bonds for 9 disulfides with no molecule" );
    my $mol2 = HackaMol::Molecule->new(
        name  => "1voz.ss",
        atoms => [@ss_atoms],
        bonds => [@ss]
    );

    $bc += $_->bond_count foreach @ss_atoms;
    is( $bc, 18, "18 bonds for 9  disulfides (1/atom) in molecule" );


    my @ss_2 = $hack->mol_disulfide_bonds($mol,0.15);
    is_deeply([@ss],[@ss_2],'mol_disulfide gives same as find_disulfide');

    # checks out by viz xyz and pdb overlay
    # $mol2->print_xyz;
}

{    # guess element from name make them dirty if don't exist in lookup
    my @atoms;
    warning_is { @atoms = $hack->read_file_atoms("t/lib/1L2Y_noelem.pdb") }
    "MolReadRole> found 2 dirty atoms. Check symbols and lookup names PeriodicTable.pm: DIRTY: index 34 name HXYY element H     -5.592      8.445     -1.281; DIRTY: index 35 name HXXX element H      0.000      0.000      0.000;",
      "warning for dirty atoms";

    # no warning...
    is( $hack->hush_read, 0, 'hush_read off' );
    $hack->hush_read(1);
    is( $hack->hush_read, 1, 'hush_read on' );

    my @watoms = $hack->read_file_atoms("t/lib/1L2Y_noelem.pdb");

    my @lsymbols = map { $_->symbol } @atoms;

    my @dirty = grep { $_->is_dirty } @atoms;
    is( scalar(@dirty), 2, "2 dirty atoms" );
    my @esymbols = qw(N C C O C C O N H H H H H H H H N C C O C C
      C C H H H H H H H H H H H H);
    is_deeply( \@lsymbols, \@esymbols, "symbols set from names" );

}

{    # pdbqt reading tests
    my @atoms;
    my $hack = HackaMol->new;
    warning_is { @atoms = $hack->read_file_atoms("t/lib/test.pdbqt") }
    "MolReadRole> found 27 dirty atoms. Check symbols and lookup names",
      "warning for dirty atoms";
    my $mol = HackaMol::Molecule->new( name => "drugs", atoms => [@atoms] );
    is( $mol->tmax, 8, "9 models in  test.pdbqt" )
}

{ # superpose tests... 
  my $g1 = HackaMol::AtomGroup->new(atoms => [
      HackaMol::Atom->new(Z => 80, coords => [V(1,1,1)]),
      HackaMol::Atom->new(Z => 80, coords => [V(2,1,1)]),
      HackaMol::Atom->new(Z => 80, coords => [V(1,2,1)]),
      HackaMol::Atom->new(Z => 80, coords => [V(1,1,2)]),
      HackaMol::Atom->new(Z => 80, coords => [V( 0,1,1)]),
      HackaMol::Atom->new(Z => 80, coords => [V(1, 0,1)]),
      HackaMol::Atom->new(Z => 80, coords => [V(1,1, 0)]),
  ]);

  my $g2 = HackaMol::AtomGroup->new(atoms => [
      HackaMol::Atom->new(Z => 80, coords => [V(0,0,0)]),
      HackaMol::Atom->new(Z => 80, coords => [V(1,0,0)]),
      HackaMol::Atom->new(Z => 80, coords => [V(0,1,0)]),
      HackaMol::Atom->new(Z => 80, coords => [V(0,0,1)]),
      HackaMol::Atom->new(Z => 80, coords => [V(-1,0,0)]),
      HackaMol::Atom->new(Z => 80, coords => [V(0,-1,0)]),
      HackaMol::Atom->new(Z => 80, coords => [V(0,0,-1)]),
  ]);

  # superpose has been checked against VMD, but more tests are needed

  my $hack = HackaMol->new;
  my ($rot,$trans,$rmsd) = $hack->superpose_rt($g1,$g2);
  cmp_ok( abs( $rmsd ), '<', 1E-8, 'simple rmsd test' );
  is_deeply( $trans, V(1,1,1), 'translation' );
  #print Dumper $rmsd,$rot,$trans;


}

done_testing();


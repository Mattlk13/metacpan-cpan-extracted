#define PERL_constant_NOTFOUND	1
#define PERL_constant_NOTDEF	2
#define PERL_constant_ISIV	3
#define PERL_constant_ISNO	4
#define PERL_constant_ISNV	5
#define PERL_constant_ISPV	6
#define PERL_constant_ISPVN	7
#define PERL_constant_ISSV	8
#define PERL_constant_ISUNDEF	9
#define PERL_constant_ISUV	10
#define PERL_constant_ISYES	11

#ifndef NVTYPE
typedef double NV; /* 5.6 and later define NVTYPE, and typedef NV to it.  */
#endif
#ifndef aTHX_
#define aTHX_ /* 5.6 or later define this for threading support.  */
#endif
#ifndef pTHX_
#define pTHX_ /* 5.6 or later define this for threading support.  */
#endif

static int
constant (pTHX_ const char *name, STRLEN len, IV *iv_return) {
  /* Initially switch on the length of the name.  */
  /* When generated this function returned values for the list of names given
     in this section of perl code.  Rather than manually editing these functions
     to add or remove constants, which would result in this comment and section
     of code becoming inaccurate, we recommend that you edit this section of
     code, and use it to regenerate a new set of constant functions which you
     then use to replace the originals.

     Regenerate these constant functions by feeding this entire source file to
     perl -x

#!/usr/bin/perl -w
use ExtUtils::Constant qw (constant_types C_constant XS_constant);

my $types = {map {($_, 1)} qw(IV)};
my @names = (qw(GTK_TYPE_OSX_APPLICATION
	       GTK_TYPE_OSX_APPLICATION_ATTENTION_TYPE),
            {name=>"CRITICAL_REQUEST", type=>"IV", macro=>"1"},
            {name=>"INFO_REQUEST", type=>"IV", macro=>"1"});

print constant_types(), "\n"; # macro defs
foreach (C_constant ("Gtk2::OSXApplication", 'constant', 'IV', $types, undef, 3, @names) ) {
    print $_, "\n"; # C constant subs
}
print "\n#### XS Section:\n";
print XS_constant ("Gtk2::OSXApplication", $types);
__END__
   */

  switch (len) {
  case 12:
    if (memEQ(name, "INFO_REQUEST", 12)) {
      *iv_return = INFO_REQUEST;
      return PERL_constant_ISIV;
    }
    break;
  case 16:
    if (memEQ(name, "CRITICAL_REQUEST", 16)) {
      *iv_return = CRITICAL_REQUEST;
      return PERL_constant_ISIV;
    }
    break;
  case 24:
    if (memEQ(name, "GTK_TYPE_OSX_APPLICATION", 24)) {
#ifdef GTK_TYPE_OSX_APPLICATION
      *iv_return = GTK_TYPE_OSX_APPLICATION;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 39:
    if (memEQ(name, "GTK_TYPE_OSX_APPLICATION_ATTENTION_TYPE", 39)) {
#ifdef GTK_TYPE_OSX_APPLICATION_ATTENTION_TYPE
      *iv_return = GTK_TYPE_OSX_APPLICATION_ATTENTION_TYPE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}


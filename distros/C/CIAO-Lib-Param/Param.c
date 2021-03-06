/*
 * This file was generated automatically by ExtUtils::ParseXS version 2.15 from the
 * contents of Param.xs. Do not edit this file, edit Param.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST! 
 *
 */

#line 1 "Param.xs"
/* --8<--8<--8<--8<--
 *
 * Copyright (C) 2006 Smithsonian Astrophysical Observatory
 *
 * This file is part of CIAO-Lib-Param
 *
 * CIAO-Lib-Param is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * CIAO-Lib-Param is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the 
 *       Free Software Foundation, Inc. 
 *       51 Franklin Street, Fifth Floor
 *       Boston, MA  02110-1301, USA
 *
 * -->8-->8-->8-->8-- */

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* Global Data */

#define MY_CXT_KEY "CIAO::Lib::Param::_guts" XS_VERSION

typedef struct {
  int parerr;
  int level;
  char* errmsg;
} my_cxt_t;

START_MY_CXT



#include "ppport.h"

#ifdef FLAT_INCLUDES
#include <parameter.h>
#else
#include <cxcparam/parameter.h>
#endif

/* yes, this is gross, but it beats including pfile.h */
extern int parerr;

/* no choice here; these aren't prototyped anywhere from pfile.c */
typedef void (*vector)();
vector paramerract( void (*newact)() );

/* this is definitely overkill, as this could (and was) handled
   transparently by the XS typemap code. At one point it
   was thought that per-object data was required and the code
   was converted to use this structure as the basis for the
   object, rather than simply blessing the pointer to the paramfile
   structure 
*/
typedef struct PFile
{
  paramfile *pf;
} PFile;

/* needed for typemap magic */
typedef PFile*  CIAO_Lib_ParamPtr;
typedef pmatchlist CIAO_Lib_Param_MatchPtr;

/* use Perl to get temporary space in interface routines; it'll
   get garbage collected automatically */
static void *
get_mortalspace( int nbytes )
{
  SV  *mortal = sv_2mortal( NEWSV(0, nbytes ) );
  char *ptr = SvPVX( mortal );

  /* set the extra NULL byte that Perl gives us to NULL
     to allow easy string overflow checking */
  ptr[nbytes] = '\0';

  return ptr;
}


static SV*
carp_shortmess( char* message )
{
  SV* sv_message = newSVpv( message, 0 );
  SV* short_message;
  int count;

  dSP;
  ENTER ;
  SAVETMPS ;
    
  PUSHMARK(SP);
  XPUSHs( sv_message );
  PUTBACK;

  /* make sure there's something to work with */
  count = call_pv( "Carp::shortmess", G_SCALAR );
    
  SPAGAIN ;

  if ( 1 != count )
    croak( "internal error passing message to Carp::shortmess" );

  short_message = newSVsv( POPs );

  PUTBACK ;
  FREETMPS ;
  LEAVE ;

  return short_message;
}


/* propagate the cxcparam error value up to Perl.
   this is used to cause a croak at the Perl level (see Param.pm for
*/
static void
croak_on_parerr( void )
{
  dMY_CXT;

  SV *sv;

  /* use parerr if specified; else use MY_CXT.parerr.  The latter is
     available if c_paramerr was called. some cxcparam routines
     don't call c_paramerr.  for those that don't, all errors are fatal
  */

  if ( parerr )
  {
    MY_CXT.parerr = parerr;
    MY_CXT.level = 1;
  }

  /* only non-zero levels are fatal */
  if ( MY_CXT.parerr && MY_CXT.level)
  {
    SV* sv_error;
    HV* hash = newHV();
    char *errstr = paramerrstr();
    char *error = MY_CXT.errmsg ? MY_CXT.errmsg : errstr;


    /* construct exception object prior to throwing exception */

    hv_store( hash, "errno" , 5, newSViv(MY_CXT.parerr), 0 );
    hv_store( hash, "error" , 5, carp_shortmess(error), 0 );
    hv_store( hash, "errstr", 6, newSVpv(errstr, 0), 0 );
    hv_store( hash, "errmsg", 6, MY_CXT.errmsg ? newSVpv(MY_CXT.errmsg, 0) : &PL_sv_undef, 0 );

    /* reset internal parameter error */
    parerr = MY_CXT.parerr = 0;
    Safefree( MY_CXT.errmsg );
    MY_CXT.errmsg = NULL;
    
    /* setup exception object and throw it*/
    {
      SV* errsv = get_sv("@", TRUE);
      sv_setsv( errsv, sv_bless( newRV_noinc((SV*) hash),
				 gv_stashpv("CIAO::Lib::Param::Error", 1 ) ) );
    }
    croak( Nullch );

  }
  
  /* here if level == 0 */
  if ( MY_CXT.parerr )
  {
    parerr = MY_CXT.parerr = 0;
    Safefree( MY_CXT.errmsg );
    MY_CXT.errmsg = NULL;
    MY_CXT.level = 0;
  }

}

/* The replacement error message handling routine for cxcparam.
   This is put in place in the BOOT: section
   Note that both paramerrstr() and c_paramerr reset parerr,
   so we need to keep a local copy.
*/
static void
perl_paramerr( int level, char *message, char *name )
{
  dMY_CXT;
  SV* sv;
  char *errstr;
  int len;

  /* save parerr before call to paramerrstr(), as that will
     reset it */
  MY_CXT.parerr = parerr;
  errstr = paramerrstr();

  len = strlen(errstr) + strlen(message) + strlen(name) + 5;

  if ( MY_CXT.errmsg )
    Renew( MY_CXT.errmsg, len, char );
  else
    New( 0, MY_CXT.errmsg, len, char );

  MY_CXT.level = level;
  sprintf( MY_CXT.errmsg, "%s: %s: %s", message, errstr, name );

  /* a level of 0 is non-fatal.  however, it should be passed up to
     the caller to handle, and that's not yet implemented. currently
     cxcparam only issues a level 0 message prior to prompting for 
     a replacement value of a parameter, and since that always
     goes out to the terminal, we output level 0 messages to
     stderr and reset parerr so that they are not treated
     as errors in croak_on_parerr */

  if ( 0 == level )
  {
    fprintf( stderr, "%s\n", MY_CXT.errmsg );
    MY_CXT.parerr = parerr = 0;
  }

}


#ifndef PERL_UNUSED_VAR
#  define PERL_UNUSED_VAR(var) if (0) var = var
#endif

#line 245 "Param.c"

XS(XS_CIAO__Lib__Param__Match_DESTROY); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__Param__Match_DESTROY)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::Param::Match::DESTROY(mlist)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_Param_MatchPtr	mlist;

	if (sv_derived_from(ST(0), "CIAO::Lib::Param::MatchPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		mlist = (CIAO_Lib_Param_MatchPtr) tmp;
	}
	else
		croak("mlist is not of type CIAO::Lib::Param::MatchPtr");
#line 237 "Param.xs"
	pmatchclose(mlist);
#line 265 "Param.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_CIAO__Lib__Param__MatchPtr_length); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__Param__MatchPtr_length)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::Param::MatchPtr::length(mlist)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_Param_MatchPtr	mlist;
	int	RETVAL;
	dXSTARG;

	if (sv_derived_from(ST(0), "CIAO::Lib::Param::MatchPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		mlist = (CIAO_Lib_Param_MatchPtr) tmp;
	}
	else
		croak("mlist is not of type CIAO::Lib::Param::MatchPtr");

	RETVAL = pmatchlength(mlist);
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__Param__MatchPtr_next); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__Param__MatchPtr_next)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::Param::MatchPtr::next(mlist)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_Param_MatchPtr	mlist;
	char *	RETVAL;

	if (sv_derived_from(ST(0), "CIAO::Lib::Param::MatchPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		mlist = (CIAO_Lib_Param_MatchPtr) tmp;
	}
	else
		croak("mlist is not of type CIAO::Lib::Param::MatchPtr");

	RETVAL = pmatchnext(mlist);
	ST(0) = sv_newmortal();
	if (RETVAL != NULL) sv_setpv((SV *)ST(0), RETVAL);
	else              sv_setsv((SV *)ST(0), &PL_sv_undef);
    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__Param__MatchPtr_rewind); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__Param__MatchPtr_rewind)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::Param::MatchPtr::rewind(mlist)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_Param_MatchPtr	mlist;

	if (sv_derived_from(ST(0), "CIAO::Lib::Param::MatchPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		mlist = (CIAO_Lib_Param_MatchPtr) tmp;
	}
	else
		croak("mlist is not of type CIAO::Lib::Param::MatchPtr");

	pmatchrewind(mlist);
    }
    XSRETURN_EMPTY;
}


XS(XS_CIAO__Lib__Param_open); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__Param_open)
{
    dXSARGS;
    if (items < 2)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::Param::open(filename, mode, ...)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	char *	filename = SvOK(ST(0)) ? (char *)SvPV_nolen(ST(0)) : (char *)NULL;
	const char *	mode = (const char *)SvPV_nolen(ST(1));
#line 272 "Param.xs"
	int argc = 0;
  	char **argv = NULL;
#line 360 "Param.c"
	CIAO_Lib_ParamPtr	RETVAL;
#line 275 "Param.xs"
        argc = items - 2;
	if ( argc )
	{
	  int i;
	  argv = get_mortalspace( argc * sizeof(*argv) );
	  for ( i = 2 ; i < items ; i++ )
	  {
	    argv[i-2] = SvOK(ST(i)) ? (char*)SvPV_nolen(ST(i)) : (char*)NULL;
	  }
	}
	RETVAL = New( 0, RETVAL, 1, PFile );
	RETVAL->pf = paramopen(filename, argv, argc, mode);
	if ( NULL == RETVAL->pf )
	{
	  Safefree(RETVAL);
	  RETVAL = NULL;
	  croak_on_parerr();
	}
#line 381 "Param.c"
	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "CIAO::Lib::ParamPtr", (void*)RETVAL);

    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__Param_pfind); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__Param_pfind)
{
    dXSARGS;
    if (items != 4)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::Param::pfind(name, mode, extn, path)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	char *	name = SvOK(ST(0)) ? (char *)SvPV_nolen(ST(0)) : (char *)NULL;
	char *	mode = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	char *	extn = SvOK(ST(2)) ? (char *)SvPV_nolen(ST(2)) : (char *)NULL;
	char *	path = SvOK(ST(3)) ? (char *)SvPV_nolen(ST(3)) : (char *)NULL;
	char *	RETVAL;
#line 303 "Param.xs"
	RETVAL = paramfind( name, mode, extn, path );
  	croak_on_parerr();	
#line 406 "Param.c"
	ST(0) = sv_newmortal();
	if (RETVAL != NULL) sv_setpv((SV *)ST(0), RETVAL);
	else              sv_setsv((SV *)ST(0), &PL_sv_undef);
    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__ParamPtr_DESTROY); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_DESTROY)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::DESTROY(pfile)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 314 "Param.xs"
	if ( pfile->pf )
	  paramclose(pfile->pf);
	Safefree(pfile);
  	croak_on_parerr();	
#line 436 "Param.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_CIAO__Lib__ParamPtr_info); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_info)
{
    dXSARGS;
    if (items != 2)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::info(pfile, name)");
    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	name = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
#line 324 "Param.xs"
	char *	mode = get_mortalspace( SZ_PFLINE );
	char *	type = get_mortalspace( SZ_PFLINE );
	char *	value = get_mortalspace( SZ_PFLINE );
	char *	min = get_mortalspace( SZ_PFLINE );
	char *	max = get_mortalspace( SZ_PFLINE );
	char *	prompt = get_mortalspace( SZ_PFLINE );
	int result;
#line 462 "Param.c"

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 332 "Param.xs"
	if ( ParamInfo( pfile->pf, name, mode, type, 
			    value, min, max, prompt ) )
	{
	  EXTEND(SP, 6);
	  PUSHs(sv_2mortal(newSVpv(mode, 0)));
	  PUSHs(sv_2mortal(newSVpv(type, 0)));
	  PUSHs(sv_2mortal(newSVpv(value, 0)));
	  PUSHs(sv_2mortal(newSVpv(min, 0)));
	  PUSHs(sv_2mortal(newSVpv(max, 0)));
	  PUSHs(sv_2mortal(newSVpv(prompt, 0)));
	}
	else
	{
	  croak( "parameter %s doesn't exist", name );
	}
  	croak_on_parerr();	
#line 487 "Param.c"
	PUTBACK;
	return;
    }
}


XS(XS_CIAO__Lib__ParamPtr_match); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_match)
{
    dXSARGS;
    if (items != 2)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::match(pfile, ptemplate)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	ptemplate = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	CIAO_Lib_Param_MatchPtr	RETVAL;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 355 "Param.xs"
	RETVAL = pmatchopen( pfile->pf, ptemplate );
  	croak_on_parerr();	
#line 515 "Param.c"
	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "CIAO::Lib::Param::MatchPtr", (void*)RETVAL);

    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__ParamPtr_getpath); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_getpath)
{
    dXSARGS;
    if (items != 1)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::getpath(pfile)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	RETVAL;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 369 "Param.xs"
	paramgetpath( pfile->pf );
#line 543 "Param.c"
#line 371 "Param.xs"
	if (RETVAL) Safefree(RETVAL);
	croak_on_parerr();
#line 547 "Param.c"
    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__ParamPtr_access); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_access)
{
    dXSARGS;
    if (items != 2)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::access(pfile, pname)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	int	RETVAL;
	dXSTARG;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 382 "Param.xs"
	paccess( pfile->pf, pname );
#line 574 "Param.c"
#line 384 "Param.xs"
  	croak_on_parerr();	
#line 577 "Param.c"
    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__ParamPtr_getb); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_getb)
{
    dXSARGS;
    if (items != 2)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::getb(pfile, pname)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	SV *	RETVAL;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 391 "Param.xs"
  	ST(0) = sv_newmortal();
	sv_setsv( ST(0), pgetb( pfile->pf, pname ) ? &PL_sv_yes : &PL_sv_no );
  	croak_on_parerr();	
#line 605 "Param.c"
    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__ParamPtr_gets); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_gets)
{
    dXSARGS;
    if (items != 2)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::gets(pfile, pname)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	short	RETVAL;
	dXSTARG;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 400 "Param.xs"
	RETVAL = pgets( pfile->pf, pname );
  	croak_on_parerr();	
#line 633 "Param.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__ParamPtr_geti); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_geti)
{
    dXSARGS;
    if (items != 2)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::geti(pfile, pname)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	int	RETVAL;
	dXSTARG;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 410 "Param.xs"
	RETVAL = pgeti( pfile->pf, pname );
  	croak_on_parerr();	
#line 662 "Param.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__ParamPtr_getf); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_getf)
{
    dXSARGS;
    if (items != 2)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::getf(pfile, pname)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	float	RETVAL;
	dXSTARG;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 420 "Param.xs"
	RETVAL = pgetf( pfile->pf, pname );
  	croak_on_parerr();	
#line 691 "Param.c"
	XSprePUSH; PUSHn((double)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__ParamPtr_getd); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_getd)
{
    dXSARGS;
    if (items != 2)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::getd(pfile, pname)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	double	RETVAL;
	dXSTARG;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 430 "Param.xs"
	RETVAL = pgetd( pfile->pf, pname );
  	croak_on_parerr();	
#line 720 "Param.c"
	XSprePUSH; PUSHn((double)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__ParamPtr_get); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_get)
{
    dXSARGS;
    if (items != 2)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::get(pfile, pname)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
#line 440 "Param.xs"
	char type[SZ_PFLINE];
#line 739 "Param.c"
	SV *	RETVAL;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 442 "Param.xs"
  	ST(0) = sv_newmortal();
	if ( ParamInfo( pfile->pf, pname, NULL, type, NULL, NULL, NULL, NULL ))
	{
	  if ( 0 == strcmp( "b", type ) )
	  {
	    sv_setsv( ST(0), 
		      pgetb( pfile->pf, pname ) ? &PL_sv_yes : &PL_sv_no );
	  }
	  else
	  {
	    char *str;
	    size_t buflen = 0;
	    size_t len = 0;
	    while( len == buflen )
	    {	    
	      buflen += SZ_PFLINE;
	      str = get_mortalspace( buflen );
	      pgetstr( pfile->pf, pname, str, buflen );
	      len = strlen( str );
	    }
	    sv_setpv(ST(0), str);
	  }
	}
	else
	  XSRETURN_UNDEF;
#line 774 "Param.c"
#line 468 "Param.xs"
  	croak_on_parerr();	
#line 777 "Param.c"
    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__ParamPtr_getstr); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_getstr)
{
    dXSARGS;
    if (items != 2)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::getstr(pfile, pname)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
#line 476 "Param.xs"
	char* str;
	size_t buflen = 0;
	size_t len = 0;
#line 797 "Param.c"
	char *	RETVAL;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 480 "Param.xs"
	RETVAL = NULL;
	while( len == buflen )
	{	    
	   buflen += SZ_PFLINE;
	   str = get_mortalspace( buflen );
	   pgetstr( pfile->pf, pname, str, buflen );
	   len = strlen( str );
	 }
        RETVAL = str;
  	croak_on_parerr();	
#line 817 "Param.c"
	ST(0) = sv_newmortal();
	if (RETVAL != NULL) sv_setpv((SV *)ST(0), RETVAL);
	else              sv_setsv((SV *)ST(0), &PL_sv_undef);
    }
    XSRETURN(1);
}


XS(XS_CIAO__Lib__ParamPtr_putb); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_putb)
{
    dXSARGS;
    dXSI32;
    if (items != 3)
       Perl_croak(aTHX_ "Usage: %s(pfile, pname, value)", GvNAME(CvGV(cv)));
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	int	value = (int)SvIV(ST(2));

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 501 "Param.xs"
	pputb( pfile->pf, pname, value );
  	croak_on_parerr();	
#line 848 "Param.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_CIAO__Lib__ParamPtr_putd); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_putd)
{
    dXSARGS;
    dXSI32;
    if (items != 3)
       Perl_croak(aTHX_ "Usage: %s(pfile, pname, value)", GvNAME(CvGV(cv)));
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	double	value = (double)SvNV(ST(2));

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 513 "Param.xs"
	pputd( pfile->pf, pname, value );
  	croak_on_parerr();	
#line 876 "Param.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_CIAO__Lib__ParamPtr_puti); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_puti)
{
    dXSARGS;
    dXSI32;
    if (items != 3)
       Perl_croak(aTHX_ "Usage: %s(pfile, pname, value)", GvNAME(CvGV(cv)));
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	int	value = (int)SvIV(ST(2));

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 524 "Param.xs"
	pputi( pfile->pf, pname, value );
  	croak_on_parerr();	
#line 904 "Param.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_CIAO__Lib__ParamPtr_puts); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_puts)
{
    dXSARGS;
    dXSI32;
    if (items != 3)
       Perl_croak(aTHX_ "Usage: %s(pfile, pname, value)", GvNAME(CvGV(cv)));
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	short	value = (short)SvIV(ST(2));

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 535 "Param.xs"
	pputs( pfile->pf, pname, value );
  	croak_on_parerr();	
#line 932 "Param.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_CIAO__Lib__ParamPtr_putstr); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_putstr)
{
    dXSARGS;
    dXSI32;
    if (items != 3)
       Perl_croak(aTHX_ "Usage: %s(pfile, pname, value)", GvNAME(CvGV(cv)));
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	char *	value = SvOK(ST(2)) ? (char *)SvPV_nolen(ST(2)) : (char *)NULL;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 546 "Param.xs"
	pputstr( pfile->pf, pname, value );
  	croak_on_parerr();	
#line 960 "Param.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_CIAO__Lib__ParamPtr_ut); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_ut)
{
    dXSARGS;
    dXSI32;
    if (items != 3)
       Perl_croak(aTHX_ "Usage: %s(pfile, pname, value)", GvNAME(CvGV(cv)));
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	pname = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	SV*	value = ST(2);
#line 557 "Param.xs"
	char type[SZ_PFLINE];
#line 980 "Param.c"

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 559 "Param.xs"
        /* if the parameter exists and is a boolean,
	   translate from numerics to string if it looks like a
	   number, else let pset handle it
	*/
	if ( ParamInfo( pfile->pf, pname, NULL, type, NULL, NULL, NULL, NULL ) &&
	     0 == strcmp( "b", type ) &&
	     ( looks_like_number( value ) ||
	       0 == sv_len(value )
	       ) 
	   )
	{
	  pputb(pfile->pf, pname, SvTRUE(value) );
	}
	else
	{
	  pputstr(pfile->pf, pname, SvOK(value) ? (char*)SvPV_nolen(value) : (char*)NULL );
	}
#line 1006 "Param.c"
#line 577 "Param.xs"
  	croak_on_parerr();	
#line 1009 "Param.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_CIAO__Lib__ParamPtr_evaluateIndir); /* prototype to pass -Wmissing-prototypes */
XS(XS_CIAO__Lib__ParamPtr_evaluateIndir)
{
    dXSARGS;
    if (items != 3)
	Perl_croak(aTHX_ "Usage: CIAO::Lib::ParamPtr::evaluateIndir(pfile, name, val)");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	CIAO_Lib_ParamPtr	pfile;
	char *	name = SvOK(ST(1)) ? (char *)SvPV_nolen(ST(1)) : (char *)NULL;
	char *	val = SvOK(ST(2)) ? (char *)SvPV_nolen(ST(2)) : (char *)NULL;
	char *	RETVAL;

	if (sv_derived_from(ST(0), "CIAO::Lib::ParamPtr")) {
		IV tmp = SvIV((SV*)SvRV(ST(0)));
		pfile = (CIAO_Lib_ParamPtr) tmp;
	}
	else
		croak("pfile is not of type CIAO::Lib::ParamPtr");
#line 586 "Param.xs"
	RETVAL = evaluateIndir(pfile->pf, name, val);
#line 1036 "Param.c"
#line 588 "Param.xs"
  	if ( RETVAL ) Safefree( RETVAL );
  	croak_on_parerr();	
#line 1040 "Param.c"
    }
    XSRETURN(1);
}

#ifdef __cplusplus
extern "C"
#endif
XS(boot_CIAO__Lib__Param); /* prototype to pass -Wmissing-prototypes */
XS(boot_CIAO__Lib__Param)
{
    dXSARGS;
    char* file = __FILE__;

    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(items); /* -W */
    XS_VERSION_BOOTCHECK ;

    {
        CV * cv ;

        newXS("CIAO::Lib::Param::Match::DESTROY", XS_CIAO__Lib__Param__Match_DESTROY, file);
        newXS("CIAO::Lib::Param::MatchPtr::length", XS_CIAO__Lib__Param__MatchPtr_length, file);
        newXS("CIAO::Lib::Param::MatchPtr::next", XS_CIAO__Lib__Param__MatchPtr_next, file);
        newXS("CIAO::Lib::Param::MatchPtr::rewind", XS_CIAO__Lib__Param__MatchPtr_rewind, file);
        newXS("CIAO::Lib::Param::open", XS_CIAO__Lib__Param_open, file);
        newXS("CIAO::Lib::Param::pfind", XS_CIAO__Lib__Param_pfind, file);
        newXS("CIAO::Lib::ParamPtr::DESTROY", XS_CIAO__Lib__ParamPtr_DESTROY, file);
        newXS("CIAO::Lib::ParamPtr::info", XS_CIAO__Lib__ParamPtr_info, file);
        newXS("CIAO::Lib::ParamPtr::match", XS_CIAO__Lib__ParamPtr_match, file);
        newXS("CIAO::Lib::ParamPtr::getpath", XS_CIAO__Lib__ParamPtr_getpath, file);
        newXS("CIAO::Lib::ParamPtr::access", XS_CIAO__Lib__ParamPtr_access, file);
        newXS("CIAO::Lib::ParamPtr::getb", XS_CIAO__Lib__ParamPtr_getb, file);
        newXS("CIAO::Lib::ParamPtr::gets", XS_CIAO__Lib__ParamPtr_gets, file);
        newXS("CIAO::Lib::ParamPtr::geti", XS_CIAO__Lib__ParamPtr_geti, file);
        newXS("CIAO::Lib::ParamPtr::getf", XS_CIAO__Lib__ParamPtr_getf, file);
        newXS("CIAO::Lib::ParamPtr::getd", XS_CIAO__Lib__ParamPtr_getd, file);
        newXS("CIAO::Lib::ParamPtr::get", XS_CIAO__Lib__ParamPtr_get, file);
        newXS("CIAO::Lib::ParamPtr::getstr", XS_CIAO__Lib__ParamPtr_getstr, file);
        cv = newXS("CIAO::Lib::ParamPtr::putb", XS_CIAO__Lib__ParamPtr_putb, file);
        XSANY.any_i32 = 0 ;
        cv = newXS("CIAO::Lib::ParamPtr::setb", XS_CIAO__Lib__ParamPtr_putb, file);
        XSANY.any_i32 = 1 ;
        cv = newXS("CIAO::Lib::ParamPtr::putd", XS_CIAO__Lib__ParamPtr_putd, file);
        XSANY.any_i32 = 0 ;
        cv = newXS("CIAO::Lib::ParamPtr::setd", XS_CIAO__Lib__ParamPtr_putd, file);
        XSANY.any_i32 = 1 ;
        cv = newXS("CIAO::Lib::ParamPtr::seti", XS_CIAO__Lib__ParamPtr_puti, file);
        XSANY.any_i32 = 1 ;
        cv = newXS("CIAO::Lib::ParamPtr::puti", XS_CIAO__Lib__ParamPtr_puti, file);
        XSANY.any_i32 = 0 ;
        cv = newXS("CIAO::Lib::ParamPtr::puts", XS_CIAO__Lib__ParamPtr_puts, file);
        XSANY.any_i32 = 0 ;
        cv = newXS("CIAO::Lib::ParamPtr::sets", XS_CIAO__Lib__ParamPtr_puts, file);
        XSANY.any_i32 = 1 ;
        cv = newXS("CIAO::Lib::ParamPtr::putstr", XS_CIAO__Lib__ParamPtr_putstr, file);
        XSANY.any_i32 = 0 ;
        cv = newXS("CIAO::Lib::ParamPtr::setstr", XS_CIAO__Lib__ParamPtr_putstr, file);
        XSANY.any_i32 = 1 ;
        cv = newXS("CIAO::Lib::ParamPtr::set", XS_CIAO__Lib__ParamPtr_ut, file);
        XSANY.any_i32 = 1 ;
        cv = newXS("CIAO::Lib::ParamPtr::ut", XS_CIAO__Lib__ParamPtr_ut, file);
        XSANY.any_i32 = 0 ;
        newXS("CIAO::Lib::ParamPtr::evaluateIndir", XS_CIAO__Lib__ParamPtr_evaluateIndir, file);
    }

    /* Initialisation Section */

#line 258 "Param.xs"
{
  	MY_CXT_INIT;
	MY_CXT.parerr = 0;
	MY_CXT.level  = 0;
	MY_CXT.errmsg = NULL;
	set_paramerror(0);	/* Don't exit on error */
	paramerract((vector) perl_paramerr);
}

#line 1118 "Param.c"

    /* End of Initialisation Section */

    XSRETURN_YES;
}


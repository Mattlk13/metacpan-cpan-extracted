#ifndef WIN32
#include <unistd.h>
#include <fcntl.h>
#endif

#include "EXTERN.h"   /* std perl include */
#include "perl.h"     /* std perl include */
#include "XSUB.h"     /* XSUB include */

#if defined(CONTEXT)
#undef CONTEXT
#endif

#include "pdl.h"      /* Data structure declarations */
#define PDL_IN_CORE /* access funcs directly not through PDL-> */
#include "pdlcore.h"  /* Core declarations */
#include "pdlperl.h"

/* Return a integer or numeric scalar as appropriate */

#define setflag(reg,flagval,val) (val?(reg |= flagval):(reg &= ~flagval))

Core PDL; /* Struct holding pointers to shared C routines */

int pdl_debugging=0;
int pdl_autopthread_targ   = 0; /* No auto-pthreading unless set using the set_autopthread_targ */
int pdl_autopthread_actual = 0;
PDL_Indx pdl_autopthread_dim = -1;
int pdl_autopthread_size   = 1;

#define CHECKP(p)    if ((p) == NULL) croak("Out of memory")

static SV* pdl_unpackint ( PDL_Indx *dims, int ndims ) {

   AV*  array;
   int i;

   array = newAV();

   for(i=0; i<ndims; i++) /* if ndims == 0, nothing stored -> ok */
         av_store( array, i, newSViv( (IV)dims[i] ) );

   return (SV*) array;
}

MODULE = PDL::Core     PACKAGE = PDL

# Destroy a PDL - note if a hash do nothing, the $$x{PDL} component
# will be destroyed anyway on a separate call

void
DESTROY(sv)
  SV *	sv;
  PREINIT:
    pdl *self;
  CODE:
    if (  !(  (SvROK(sv) && SvTYPE(SvRV(sv)) == SVt_PVHV) )  ) {
       self = pdl_SvPDLV(sv);
       PDLDEBUG_f(printf("DESTROYING %p\n",(void*)self);)
       if (self != NULL)
          pdl_destroy(self);
    }

# Return the transformation object or an undef otherwise.

SV *
get_trans(self)
	pdl *self;
	CODE:
	ST(0) = sv_newmortal();
	if(self->trans_parent)  {
		sv_setref_pv(ST(0), "PDL::Trans", (void*)(self->trans_parent));
	} else {
               ST(0) = &PL_sv_undef;
	}

INCLUDE_COMMAND: $^X -e "require q{./Dev.pm}; PDL::Core::Dev::generate_core_flags()"

void
set_inplace(self,val)
  pdl *self;
  int val;
  CODE:
    setflag(self->state,PDL_INPLACE,val);

IV
address(self)
  pdl *self;
  CODE:
    RETVAL = PTR2IV(self);
  OUTPUT:
    RETVAL

int
set_donttouchdata(it)
      pdl *it
      CODE:
            it->state |= PDL_DONTTOUCHDATA | PDL_ALLOCATED;
            RETVAL = 1;
      OUTPUT:
            RETVAL

# Free the datasv if possible
void
freedata(it)
      pdl *it
      CODE:
	if(it->datasv) {
		SvREFCNT_dec(it->datasv);
		it->datasv=0;
		it->data=0;
	} else if(it->data) {
		die("Trying to free data of pdl with data != 0 and datasv==0");
	}

int
set_data_by_offset(it,orig,offset)
      pdl *it
      pdl *orig
      STRLEN offset
      CODE:
              it->data = ((char *) orig->data) + offset;
	      it->datasv = orig->sv;
              (void)SvREFCNT_inc(it->datasv);
              it->state |= PDL_DONTTOUCHDATA | PDL_ALLOCATED;
              RETVAL = 1;
      OUTPUT:
              RETVAL

PDL_Indx
nelem(x)
	pdl *x
	CODE:
		pdl_make_physdims(x);
		RETVAL = x->nvals;
	OUTPUT:
		RETVAL


# Call my howbig function

int
howbig_c(datatype)
   int	datatype
   CODE:
     RETVAL = pdl_howbig(datatype);
   OUTPUT:
     RETVAL


int
set_autopthread_targ(i)
	int i;
	CODE:
	RETVAL = i;
	pdl_autopthread_targ = i;
	OUTPUT:
	RETVAL

int
get_autopthread_targ()
	CODE:
	RETVAL = pdl_autopthread_targ;
	OUTPUT:
	RETVAL


int
set_autopthread_size(i)
	int i;
	CODE:
	RETVAL = i;
	pdl_autopthread_size = i;
	OUTPUT:
	RETVAL

int
get_autopthread_size()
	CODE:
	RETVAL = pdl_autopthread_size;
	OUTPUT:
	RETVAL

int
get_autopthread_actual()
	CODE:
	RETVAL = pdl_autopthread_actual;
	OUTPUT:
	RETVAL

int
get_autopthread_dim()
	CODE:
	RETVAL = pdl_autopthread_dim;
	OUTPUT:
	RETVAL

void
_ci(...)
 PPCODE:
  PDL_XS_SCALAR(PDL_CD, PDL_CDouble, 0 + 1I)

void
_nan(...)
 PPCODE:
  PDL_XS_SCALAR(PDL_D, PDL_Double, (PDL_Double)NAN)

void
_inf(...)
 PPCODE:
  PDL_XS_SCALAR(PDL_D, PDL_Double, INFINITY)

MODULE = PDL::Core     PACKAGE = PDL::Core

IV
seed()
  CODE:
    RETVAL = pdl_pdl_seed();
  OUTPUT:
    RETVAL

int
online_cpus()
  CODE:
    RETVAL = pdl_online_cpus();
  OUTPUT:
    RETVAL

unsigned int
is_scalar_SvPOK(arg)
	SV* arg;
	CODE:
	RETVAL = SvPOK(arg);
	OUTPUT:
	RETVAL


int
set_debugging(i)
	int i;
	CODE:
	RETVAL = pdl_debugging;
	pdl_debugging = i;
	OUTPUT:
	RETVAL


SV *
sclr_c(it)
   pdl* it
   PREINIT:
	PDL_Anyval result = { -1, 0 };
   CODE:
        /* get the first element of an ndarray and return as
         * Perl scalar (autodetect suitable type IV or NV)
         */
        result = pdl_at0(it);
        ANYVAL_TO_SV(RETVAL, result);

    OUTPUT:
        RETVAL


SV *
at_bad_c(x,position)
   pdl*	x
   SV *	position
   PREINIT:
    PDL_Indx * pos;
    PDL_Indx npos;
    PDL_Indx ipos;
    int badflag;
    PDL_Anyval result = { -1, 0 };
   CODE:
    pdl_make_physvaffine( x );

    pos = pdl_packdims( position, &npos);

    if (pos == NULL || npos < x->ndims)
       croak("Invalid position");

    /*  allow additional trailing indices
     *  which must be all zero, i.e. a
     *  [3,1,5] ndarray is treated as an [3,1,5,1,1,1,....]
     *  infinite dim ndarray
     */
    for (ipos=x->ndims; ipos<npos; ipos++)
      if (pos[ipos] != 0)
         croak("Invalid position");

    result=pdl_at(PDL_REPRP(x), x->datatype, pos, x->dims,
        (PDL_VAFFOK(x) ? x->vafftrans->incs : x->dimincs), PDL_REPROFFS(x),
	x->ndims);
   badflag = (x->state & PDL_BADVAL) > 0;
   if (badflag && ANYVAL_ISBAD(result, x, pdl_get_badvalue(x->datatype)))
     RETVAL = newSVpvn( "BAD", 3 );
   else
     ANYVAL_TO_SV(RETVAL, result);

    OUTPUT:
     RETVAL


# returns the string 'BAD' if an element is bad
#

SV *
listref_c(x)
   pdl *x
  PREINIT:
   PDL_Indx * incs;
   PDL_Indx offs;
   void *data;
   int ind;
   int lind;
   int stop = 0;
   AV *av;
   SV *sv;
   PDL_Anyval pdl_val =    { -1, 0 };
   PDL_Anyval pdl_badval = { -1, 0 };
  CODE:
    /*
    # note:
    #  the badvalue is stored in a PDL_Anyval, but that's what pdl_at()
    #  returns
    */

   int badflag = (x->state & PDL_BADVAL) > 0;
   if (badflag) {
      pdl_badval = pdl_get_pdl_badvalue( x );
   }

   pdl_make_physvaffine( x );
   data = PDL_REPRP(x);
   incs = (PDL_VAFFOK(x) ? x->vafftrans->incs : x->dimincs);
   offs = PDL_REPROFFS(x);
   av = newAV();
   av_extend(av,x->nvals);
   lind=0;
   PDL_Indx inds[x->ndims];
   for(ind=0; ind < x->ndims; ind++) inds[ind] = 0;
   while(!stop) {
      pdl_val = pdl_at( data, x->datatype, inds, x->dims, incs, offs, x->ndims );
      if (badflag && ANYVAL_ISBAD(pdl_val, x, pdl_badval)) {
	 sv = newSVpvn( "BAD", 3 );
      } else {
	 ANYVAL_TO_SV(sv, pdl_val);
      }
      av_store( av, lind, sv );

      lind++;
      stop = 1;
      for(ind = 0; ind < x->ndims; ind++) {
	 if(++(inds[ind]) >= x->dims[ind]) {
       	    inds[ind] = 0;
         } else {
       	    stop = 0; break;
         }
      }
   }
   RETVAL = newRV_noinc((SV *)av);
  OUTPUT:
   RETVAL

void
set_c(x,position,value)
    pdl*	x
    SV*	position
    PDL_Anyval	value
   PREINIT:
    PDL_Indx * pos;
    PDL_Indx npos;
    PDL_Indx ipos;
   CODE:
    pdl_make_physvaffine( x );

    pos = pdl_packdims( position, &npos);
    if (pos == NULL || npos < x->ndims)
       croak("Invalid position");

    /*  allow additional trailing indices
     *  which must be all zero, i.e. a
     *  [3,1,5] ndarray is treated as an [3,1,5,1,1,1,....]
     *  infinite dim ndarray
     */
    for (ipos=x->ndims; ipos<npos; ipos++)
      if (pos[ipos] != 0)
         croak("Invalid position");

    pdl_children_changesoon( x , PDL_PARENTDATACHANGED );
    pdl_set(PDL_REPRP(x), x->datatype, pos, x->dims,
        (PDL_VAFFOK(x) ? x->vafftrans->incs : x->dimincs), PDL_REPROFFS(x),
	x->ndims,value);
    if (PDL_VAFFOK(x))
       pdl_vaffinechanged(x, PDL_PARENTDATACHANGED);
    else
       pdl_changed( x , PDL_PARENTDATACHANGED , 0 );

BOOT:
{
#if NVSIZE > 8
   fprintf(stderr, "Your perl NV has more precision than PDL_Double.  There will be loss of floating point precision!\n");
#endif

   /* Initialize structure of pointers to core C routines */

   PDL.Version     = PDL_CORE_VERSION;
#define X(sym, rettype, args) PDL.sym = pdl_ ## sym;
   PDL_CORE_LIST(X)
#undef X
#define X(symbol, ctype, ppsym, shortctype, defbval) \
  PDL.bvals.shortctype = defbval;
   PDL_GENERICLIST(X)
#undef X
   /*
      "Publish" pointer to this structure in perl variable for use
       by other modules
   */
   sv_setiv(get_sv("PDL::SHARE",TRUE|GV_ADDMULTI), PTR2IV(&PDL));
}

# make ndarray belonging to 'class' and of type 'type'
# from avref 'array_ref' which is checked for being
# rectangular first

SV*
pdl_avref(array_ref, class, type)
     SV* array_ref
     char* class
     int type
  PREINIT:
     AV *dims, *av;
     int i, depth;
     int datalevel = -1;
     SV* psv;
     pdl* p;
  CODE:
     /* make an ndarray from a Perl array ref */

     if (!SvROK(array_ref))
       croak("pdl_avref: not a reference");


     if (SvTYPE(SvRV(array_ref)) != SVt_PVAV)
       croak("pdl_avref: not an array reference");

     // Expand the array ref to a list, and allocate a Perl list to hold the dimlist
     av = (AV *) SvRV(array_ref);
     dims = (AV *) sv_2mortal( (SV *) newAV());

     av_store(dims,0,newSViv((IV) av_len(av)+1));

     /* even if we contain nothing depth is one */
     depth = 1 + av_ndcheck(av,dims,0,&datalevel);

     /* printf("will make type %s\n",class); */
     /*
	at this stage start making an ndarray and populate it with
	values from the array (which has already been checked in av_check)
     */
     if (strcmp(class,"PDL") == 0) {
        p = pdl_from_array(av,dims,type,NULL); /* populate with data */
        ST(0) = sv_newmortal();
        pdl_SetSV_PDL(ST(0),p);
     } else {
       /* call class->initialize method */
       PUSHMARK(SP);
       XPUSHs(sv_2mortal(newSVpv(class, 0)));
       PUTBACK;
       perl_call_method("initialize", G_SCALAR);
       SPAGAIN;
       psv = POPs;
       PUTBACK;
       p = pdl_SvPDLV(psv); /* and get ndarray from returned object */
       ST(0) = psv;
       pdl_from_array(av,dims,type,p); /* populate ;) */
     }

MODULE = PDL::Core     PACKAGE = PDL::Core     PREFIX = pdl_

int
pdl_pthreads_enabled()

MODULE = PDL::Core	PACKAGE = PDL	PREFIX = pdl_

int
isnull(self)
	pdl *self;
	CODE:
		RETVAL= !!(self->state & PDL_NOMYDIMS);
	OUTPUT:
		RETVAL

pdl *
make_physical(self)
	pdl *self;
	CODE:
		pdl_make_physical(self);
		RETVAL = self;
	OUTPUT:
		RETVAL

pdl *
make_physvaffine(self)
	pdl *self;
	CODE:
		pdl_make_physvaffine(self);
		RETVAL = self;
	OUTPUT:
		RETVAL


pdl *
make_physdims(self)
	pdl *self;
	CODE:
		pdl_make_physdims(self);
		RETVAL = self;
	OUTPUT:
		RETVAL

void
pdl_set_datatype(a,datatype)
   pdl *a
   int datatype

pdl *
pdl_sever(src)
	pdl *src;

void
pdl_dump(x)
  pdl *x;

void
pdl_add_threading_magic(it,nthdim,nthreads)
	pdl *it
	int nthdim
	int nthreads

void
pdl_remove_threading_magic(it)
	pdl *it
	CODE:
		pdl_add_threading_magic(it,-1,-1);

MODULE = PDL::Core	PACKAGE = PDL

SV *
initialize(class)
	SV *class
        PREINIT:
	HV *bless_stash;
        PPCODE:
        if (SvROK(class)) { /* a reference to a class */
	  bless_stash = SvSTASH(SvRV(class));
        } else {            /* a class name */
          bless_stash = gv_stashsv(class, 0);
        }
        ST(0) = sv_newmortal();
        pdl_SetSV_PDL(ST(0),pdl_null());   /* set a null PDL to this SV * */
        ST(0) = sv_bless(ST(0), bless_stash); /* bless appropriately  */
	XSRETURN(1);

SV *
get_dataref(self)
	pdl *self
	CODE:
	if(self->state & PDL_DONTTOUCHDATA) {
		croak("Trying to get dataref to magical (mmaped?) pdl");
	}
	pdl_make_physical(self); /* XXX IS THIS MEMLEAK WITHOUT MORTAL? */
	RETVAL = (newRV(self->datasv));
	OUTPUT:
	RETVAL

int
get_datatype(self)
	pdl *self
	CODE:
	RETVAL = self->datatype;
	OUTPUT:
	RETVAL

int
upd_data(self)
	pdl *self
      PREINIT:
       STRLEN n_a;
	CODE:
	if(self->state & PDL_DONTTOUCHDATA) {
		croak("Trying to touch dataref of magical (mmaped?) pdl");
	}
       self->data = SvPV((SV*)self->datasv,n_a);
	XSRETURN(0);

void
set_dataflow_f(self,value)
	pdl *self;
	int value;
	CODE:
	if(value)
		self->state |= PDL_DATAFLOW_F;
	else
		self->state &= ~PDL_DATAFLOW_F;

void
set_dataflow_b(self,value)
	pdl *self;
	int value;
	CODE:
	if(value)
		self->state |= PDL_DATAFLOW_B;
	else
		self->state &= ~PDL_DATAFLOW_B;

int
getndims(x)
	pdl *x
	ALIAS:
	     PDL::ndims = 1
	CODE:
		pdl_make_physdims(x);
		RETVAL = x->ndims;
	OUTPUT:
		RETVAL

void
dims_c(x)
	pdl *x
	PREINIT:
		PDL_Indx i;
		U8 gimme = GIMME_V;
	PPCODE:
		pdl_make_physdims(x);
		if (gimme == G_ARRAY) {
			EXTEND(sp, x->ndims);
			for(i=0; i<x->ndims; i++) mPUSHi(x->dims[i]);
		}
		else if (gimme == G_SCALAR) {
			mXPUSHu(x->ndims);
		}

PDL_Indx
getdim(x,y)
	pdl *x
	int y
	ALIAS:
	     PDL::dim = 1
	CODE:
		pdl_make_physdims(x);
		if (y < 0) y = x->ndims + y;
		if (y < 0) croak("negative dim index too large");
		if (y < x->ndims)
                   RETVAL = x->dims[y];
                else
		   RETVAL = 1; /* return size 1 for all other dims */
	OUTPUT:
		RETVAL

int
getnthreadids(x)
	pdl *x
	CODE:
		pdl_make_physdims(x);
		RETVAL = x->nthreadids;
	OUTPUT:
		RETVAL

void
threadids_c(x)
	pdl *x
	PREINIT:
		PDL_Indx i;
		U8 gimme = GIMME_V;
	PPCODE:
		pdl_make_physdims(x);
		if (gimme == G_ARRAY) {
			EXTEND(sp, x->nthreadids);
			for(i=0; i<x->nthreadids; i++) mPUSHi(x->threadids[i]);
		}
		else if (gimme == G_SCALAR) {
			mXPUSHu(x->nthreadids);
		}

int
getthreadid(x,y)
	pdl *x
	int y
	CODE:
		RETVAL = x->threadids[y];
	OUTPUT:
		RETVAL

void
setdims(x,dims_arg)
	pdl *x
      SV * dims_arg
      PREINIT:
	 PDL_Indx * dims;
	 PDL_Indx ndims;
       int i;
	CODE:
		dims = pdl_packdims(dims_arg,&ndims);
		pdl_setdims(x,dims,ndims);

void
dowhenidle()
	CODE:
		pdl_run_delayed_magic();
		XSRETURN(0);

void
bind(p,c)
	pdl *p
	SV *c
	PROTOTYPE: $&
	CODE:
		pdl_add_svmagic(p,c);
		XSRETURN(0);

void
sethdr(p,h)
	pdl *p
	SV *h
      PREINIT:
	HV* hash;
	CODE:
		if(p->hdrsv == NULL) {
		      p->hdrsv =  &PL_sv_undef; /*(void*) newSViv(0);*/
		}

		/* Throw an error if we're not either undef or hash */
                if ( (h != &PL_sv_undef && h != NULL) &&
		     ( !SvROK(h) || SvTYPE(SvRV(h)) != SVt_PVHV )
		   )
		      croak("Not a HASH reference");

		/* Clear the old header */
		SvREFCNT_dec(p->hdrsv);

		/* Put the new header (or undef) in place */
		if(h == &PL_sv_undef || h == NULL)
		   p->hdrsv = NULL;
		else
		   p->hdrsv = (void*) newRV( (SV*) SvRV(h) );

SV *
hdr(p)
	pdl *p
	CODE:
		pdl_make_physdims(p);

                /* Make sure that in the undef case we return not */
                /* undef but an empty hash ref. */

                if((p->hdrsv==NULL) || (p->hdrsv == &PL_sv_undef)) {
	            p->hdrsv = (void*) newRV_noinc( (SV*)newHV() );
                }

		RETVAL = newRV( (SV*) SvRV((SV*)p->hdrsv) );

	OUTPUT:
	 RETVAL

SV *
gethdr(p)
	pdl *p
	CODE:
		pdl_make_physdims(p);

                if((p->hdrsv==NULL) || (p->hdrsv == &PL_sv_undef)) {
	            RETVAL = &PL_sv_undef;
                } else {
		    RETVAL = newRV( (SV*) SvRV((SV*)p->hdrsv) );
                }

	OUTPUT:
	 RETVAL

void
threadover_n(...)
   PREINIT:
   int npdls;
   SV *sv;
   CODE:
    npdls = items - 1;
    if(npdls <= 0)
    	croak("Usage: threadover_n(pdl[,pdl...],sub)");
    int i,sd;
    pdl *pdls[npdls];
    PDL_Indx realdims[npdls];
    pdl_thread pdl_thr;
    SV *code = ST(items-1);
    for(i=0; i<npdls; i++) {
	pdls[i] = pdl_SvPDLV(ST(i));
	/* XXXXXXXX Bad */
	pdl_make_physical(pdls[i]);
	realdims[i] = 0;
    }
    PDL_THR_CLRMAGIC(&pdl_thr);
    pdl_initthreadstruct(0,pdls,realdims,realdims,npdls,NULL,&pdl_thr,NULL,NULL,NULL, 1);
    pdl_startthreadloop(&pdl_thr,NULL,NULL);
    sd = pdl_thr.ndims;
    do {
    	dSP;
	PUSHMARK(sp);
	EXTEND(sp,items);
	PUSHs(sv_2mortal(newSViv((sd-1))));
	for(i=0; i<npdls; i++) {
		PDL_Anyval pdl_val = { -1, 0 };
		pdl_val = pdl_get_offs(pdls[i],pdl_thr.offs[i]);
		ANYVAL_TO_SV(sv, pdl_val);
		PUSHs(sv_2mortal(sv));
	}
    	PUTBACK;
	perl_call_sv(code,G_DISCARD);
    } while( (sd = pdl_iterthreadloop(&pdl_thr,0)) );
    pdl_freethreadloop(&pdl_thr);

void
threadover(...)
   PREINIT:
    int npdls;
    int targs;
    int nothers = -1;
   CODE:
    targs = items - 4;
    if (items > 0) nothers = SvIV(ST(0));
    if(targs <= 0 || nothers < 0 || nothers >= targs)
	croak("Usage: threadover(nothers,pdl[,pdl...][,otherpars..],realdims,creating,sub)");
    npdls = targs-nothers;
    int i,dtype=0;
    PDL_Indx j,nc=npdls,nd1,nd2;
    SV* rdimslist = ST(items-3);
    SV* cdimslist = ST(items-2);
    SV *code = ST(items-1);
    pdl_thread pdl_thr;
    pdl *pdls[npdls], *child[npdls];
    SV *csv[npdls], *dims[npdls], *incs[npdls], *others[nothers];
    PDL_Indx *creating = pdl_packdims(cdimslist,&nd2);
    PDL_Indx *realdims = pdl_packdims(rdimslist,&nd1);
    if (nd1 != npdls) croak("threadover: need one realdim flag per pdl!");
    if (nd2 != npdls) croak("threadover: need one creating flag per pdl!");
    for(i=0; i<npdls; i++) {
	pdls[i] = pdl_SvPDLV(ST(i+1));
	if (creating[i])
	  nc += realdims[i];
	else {
	  pdl_make_physical(pdls[i]); /* is this what we want?XXX */
	  dtype = PDLMAX(dtype,pdls[i]->datatype);
	}
    }
    for (i=npdls+1; i<=targs; i++)
	others[i-npdls-1] = ST(i);
    if (nd2 < nc)
	croak("Not enough dimension info to create pdls");
    PDLDEBUG_f(for (i=0;i<npdls;i++) { printf("pdl %d ",i); pdl_dump(pdls[i]); });
    PDL_THR_CLRMAGIC(&pdl_thr);
    pdl_initthreadstruct(0,pdls,realdims,creating,npdls,
			NULL,&pdl_thr,NULL,NULL,NULL, 1);
    for(i=0, nc=npdls; i<npdls; i++)  /* create as necessary */
      if (creating[i]) {
	PDL_Indx *cp = creating+nc;
	pdls[i]->datatype = dtype;
	pdl_thread_create_parameter(&pdl_thr,i,cp,0);
	nc += realdims[i];
	pdl_make_physical(pdls[i]);
	PDLDEBUG_f(pdl_dump(pdls[i]));
	/* And make it nonnull, now that we've created it */
	pdls[i]->state &= (~PDL_NOMYDIMS);
      }
    pdl_startthreadloop(&pdl_thr,NULL,NULL);
    for(i=0; i<npdls; i++) { /* will the SV*'s be properly freed? */
	dims[i] = newRV(pdl_unpackint(pdls[i]->dims,realdims[i]));
	incs[i] = newRV(pdl_unpackint(PDL_VAFFOK(pdls[i]) ?
	pdls[i]->vafftrans->incs: pdls[i]->dimincs,realdims[i]));
	/* need to make sure we get the vaffine (grand)parent */
	if (PDL_VAFFOK(pdls[i]))
	   pdls[i] = pdls[i]->vafftrans->from;
	child[i]=pdl_null();
	/*  instead of pdls[i] its vaffine parent !!!XXX */
	PDL.affine_new(pdls[i],child[i],pdl_thr.offs[i],dims[i],
					incs[i]);
	pdl_make_physical(child[i]); /* make sure we can get at
					the vafftrans          */
	csv[i] = sv_newmortal();
	pdl_SetSV_PDL(csv[i], child[i]); /* pdl* into SV* */
    }
    do {  /* the actual threadloop */
	pdl_trans *traff;
    	dSP;
	PUSHMARK(sp);
	EXTEND(sp,npdls);
	for(i=0; i<npdls; i++) {
	   /* just twiddle the offset - quick and dirty */
	   /* we must twiddle both !! */
	   traff = child[i]->trans_parent;
	   traff->offs = pdl_thr.offs[i];
	   child[i]->vafftrans->offs = pdl_thr.offs[i];
	   child[i]->state |= PDL_PARENTDATACHANGED;
	   PUSHs(csv[i]);
	}
	for (i=0; i<nothers; i++)
	  PUSHs(others[i]);   /* pass the OtherArgs onto the stack */
    	PUTBACK;
	perl_call_sv(code,G_DISCARD);
    } while (pdl_iterthreadloop(&pdl_thr,0));
    pdl_freethreadloop(&pdl_thr);

#include "pdl.h"      /* Data structure declarations */
#include "pdlcore.h"  /* Core declarations */

#define XCODE(code, datatype, generic, generic_ppsym, shortctype, defbval) \
    generic *ap = (generic *) a->data; \
    generic *pp = (generic *) a->vafftrans->from->data; \
    pp += a->vafftrans->offs; \
    for(i=0; i<a->nvals; i++) { \
        code; \
        for(j=0; j<a->ndims; j++) { \
            pp += a->vafftrans->incs[j]; \
            if((j < a->ndims - 1 && \
                (i+1) % a->dimincs[j+1]) || \
               j == a->ndims - 1) \
                break; \
            pp -= a->vafftrans->incs[j] * \
                a->dims[j]; \
        } \
        ap ++; \
    }

#define VAFF_IO(name, X) \
void pdl_ ## name(pdl *a) { \
	PDL_Indx i; \
	int j; \
	int intype = a->datatype; \
	if(!PDL_VAFFOK(a)) { \
		die("pdl_" #name " without vaffine"); \
	} \
	PDL_ENSURE_ALLOCATED(a); \
    PDL_GENERICSWITCH(intype, X); \
}

#define X(...) XCODE(*ap = *pp, __VA_ARGS__)
VAFF_IO(readdata_vaffine, X)
#undef X
#define X(...) XCODE(*pp = *ap, __VA_ARGS__)
VAFF_IO(writebackdata_vaffine, X)
#undef X
#undef XCODE

/* Various conversion utilities for pdl data types */

/* Change the type of all the data in a pdl struct, either changing the
   original perl structure or making a temporary copy  */

/* 
 * it seems this does not have to be aware of bad values
 * (at least in the current scheme)
 */

void pdl_converttype( pdl* a, int targtype ) {
    int intype;
    void* b;     /* Scratch data ptr */
    SV*   bar;
    HV*   hash;
    STRLEN   nbytes;
    int   diffsize;
    PDL_Indx   i;
    PDLDEBUG_f(printf("pdl_converttype %p, %d, %d\n", (void*)a, a->datatype,
	targtype);)

    intype = a->datatype;
    if (intype == targtype)
       return;

    diffsize = pdl_howbig(targtype) != pdl_howbig(a->datatype);

    nbytes = a->nvals * pdl_howbig(targtype); /* Size of converted data */

    if(a->state & PDL_DONTTOUCHDATA) {
      croak("Trying to convert of magical (mmaped?) pdl");
    }
    if (diffsize) {
       b = a->data;                      /* pointer to old data */
       a->data     = pdl_smalloc(nbytes); /* Space for changed data */
    }
    else{
       b = a->data; /* In place */
    }

    /* Do the conversion as nested switch statements */
#define X_OUTER(datatype_out, generic_out, generic_ppsym_out, shortctype_out, defbval_out) \
    generic_out *bb = (generic_out *) b; \
    i = a->nvals; \
    PDL_GENERICSWITCH2(targtype, X_INNER);
#define X_INNER(datatype_in, generic_in, generic_ppsym_in, shortctype_in, defbval_in) \
    generic_in *aa = (generic_in *) a->data; \
    aa += i-1; bb += i-1; \
    while (i--) \
      *aa-- = (generic_in) *bb--;
    PDL_GENERICSWITCH(intype, X_OUTER);
#undef X_INNER
#undef X_OUTER

    /* Store new data */
    if (diffsize) {
      STRLEN n_a;
       bar = a->datasv;
       sv_setpvn( bar, (char*) a->data, nbytes );
       a->data = (void*) SvPV(bar, n_a);
    }

    a->datatype = targtype;
}

#ifndef ULIB__PORT_H
#define ULIB__PORT_H

#ifdef cBOOL
#undef cBOOL
#endif
#define cBOOL(cbool) ((bool) (cbool))

#ifdef EXPECT
#undef EXPECT
#ifdef HAS_BUILTIN_EXPECT
#  define EXPECT(expr,val)                  __builtin_expect(expr,val)
#else
#  define EXPECT(expr,val)                  (expr)
#endif
#endif

#ifdef LIKELY
#undef LIKELY
#define LIKELY(cond)                        EXPECT(cBOOL(cond),TRUE)
#endif

#ifdef UNLIKELY
#undef UNLIKELY
#define UNLIKELY(cond)                      EXPECT(cBOOL(cond),FALSE)
#endif

#ifdef PERL_MALLOC_WRAP

# ifdef _MEM_WRAP_NEEDS_RUNTIME_CHECK
# undef _MEM_WRAP_NEEDS_RUNTIME_CHECK
# endif
# define _MEM_WRAP_NEEDS_RUNTIME_CHECK(n,t) \
    (sizeof(MEM_SIZE) < sizeof(n) || sizeof(t) > ((MEM_SIZE)1 << 8*(sizeof(MEM_SIZE) - sizeof(n))))

# ifdef _MEM_WRAP_WILL_WRAP
# undef _MEM_WRAP_WILL_WRAP
# endif
# define _MEM_WRAP_WILL_WRAP(n,t) \
    ((_MEM_WRAP_NEEDS_RUNTIME_CHECK(n,t) ? (MEM_SIZE)(n) : MEM_SIZE_MAX/sizeof(t)) > MEM_SIZE_MAX/sizeof(t))

# ifdef MEM_WRAP_CHECK
# undef MEM_WRAP_CHECK
# endif
# define MEM_WRAP_CHECK(n,t) \
    (void)(UNLIKELY(_MEM_WRAP_WILL_WRAP(n,t)) && (Perl_croak_nocontext("panic: memory wrap"),0))

#endif /* PERL_MALLOC_WRAP */


#ifndef MUTEX_LOCK
#  define MUTEX_LOCK(m)           NOOP
#endif

#ifndef MUTEX_UNLOCK
#  define MUTEX_UNLOCK(m)         NOOP
#endif

#ifndef MUTEX_INIT
#  define MUTEX_INIT(m)           NOOP
#endif

#ifndef MUTEX_DESTROY
#  define MUTEX_DESTROY(m)        NOOP
#endif

#ifndef SVf_THINKFIRST
#define SVf_THINKFIRST  (SVf_READONLY|SVf_PROTECT|SVf_ROK|SVf_FAKE \
                        |SVs_RMG|SVf_IsCOW)
#endif

#ifndef SvTHINKFIRST
#define SvTHINKFIRST(sv)  (SvFLAGS(sv) & SVf_THINKFIRST
#endif

#ifndef SV_CHECK_THINKFIRST_COW_DROP
#define SV_CHECK_THINKFIRST_COW_DROP(sv) \
    if (SvTHINKFIRST(sv)) \
        sv_force_normal_flags(sv, SV_COW_DROP_PV)
#endif

#ifndef CVf_AUTOLOAD
#define CvAUTOLOAD_off(cv) NOOP
#endif

#ifndef ibcmp
#define ibcmp Perl_my_ibcmp
I32 Perl_my_ibcmp(pTHX_ const char *s1, const char *s2, register I32 len) {
  register U8 *a = (U8 *)s1;
  register U8 *b = (U8 *)s2;
  while (len--) {
    if (*a != *b && *a != PL_fold[*b])
    return 1;
    a++,b++;
  }
  return 0;
}
#endif

#ifndef NOT_REACHED
#define NOT_REACHED
#endif

#ifndef croak_caller
#define croak_caller  my_croak_caller
#endif

#ifndef PERL_VERSION
# undef SUBVERSION /* OS/390 */
# include <patchlevel.h>
# ifndef SUBVERSION
#   define SUBVERSION 0
# endif
# if !defined(PATCHLEVEL)))
#   include <could_not_find_Perl_patchlevel.h>
# endif
# define PERL_REVISION    5
# define PERL_VERSION     PATCHLEVEL
# define PERL_SUBVERSION  SUBVERSION
#endif

#ifndef PERL_VERSION_DECIMAL
# define PERL_VERSION_DECIMAL(r,v,s) (r*1000000 + v*1000 + s)
#endif
#ifndef PERL_DECIMAL_VERSION
# define PERL_DECIMAL_VERSION \
    PERL_VERSION_DECIMAL(PERL_REVISION,PERL_VERSION,PERL_SUBVERSION)
#endif

#ifndef PERL_VERSION_LT
# define PERL_VERSION_LT(r,v,s) \
    (PERL_DECIMAL_VERSION < PERL_VERSION_DECIMAL(r,v,s))
#endif

#ifndef PERL_VERSION_EQ
# define PERL_VERSION_EQ(r,v,s) \
    (PERL_DECIMAL_VERSION == PERL_VERSION_DECIMAL(r,v,s))
#endif

#ifdef SvPVbyte
# if PERL_VERSION_EQ(5,6,1)
    /* SvPVbyte does not work in perl-5.6.1, borrowed version for 5.7.3 */
#   undef SvPVbyte
#   define SvPVbyte(sv, lp) \
      ((SvFLAGS(sv) & (SVf_POK|SVf_UTF8)) == (SVf_POK) \
      ? ((lp = SvCUR(sv)), SvPVX(sv)) : my_sv_2pvbyte(aTHX_ sv, &lp))

      static char *
      my_sv_2pvbyte(pTHX_ register SV *sv, STRLEN *lp) {
        sv_utf8_downgrade(sv,0);
        return SvPV(sv,*lp);
      }
# endif
#else
# define SvPVbyte SvPV
#endif

#endif
/* ex:set ts=2 sw=2 itab=spaces: */

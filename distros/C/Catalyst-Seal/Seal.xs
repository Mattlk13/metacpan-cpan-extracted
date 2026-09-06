#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "include/cs_slot.h"

/* G_LIST is the 5.36 spelling of G_ARRAY. Unguarded it breaks the build on
 * everything older. */
#ifndef G_LIST
#  define G_LIST G_ARRAY
#endif

/* GvCV_set arrived in 5.13. Before that the slot was assigned directly. */
#ifndef GvCV_set
#  define GvCV_set(gv, cv) (GvCV(gv) = (cv))
#endif

/* Catalyst::ClassData's accessor calls Moose::Util::find_meta on every read,
 * to answer a question that stops changing at setup_finalize. This replaces it
 * with a constant, and falls back to the original for anything the constant
 * cannot answer: a write, or an invocant that is not the class we resolved
 * the value for. */

/* Put a coderef into a glob's CODE slot, leaving every other slot alone.
 *
 * Only the CODE slot, because ClassData keeps the value itself in the same
 * glob's SCALAR slot and the write that triggered this is about to go there.
 *
 * Not sv_setsv on the glob: that is a glob assignment, and a glob assignment
 * over an existing subroutine warns "Subroutine %s redefined" against the
 * warning bits of whoever happened to call the accessor. They did not ask for
 * this and cannot silence it. */
static void
cs_set_cv(pTHX_ SV *fq, CV *code)
{
    GV *gv = gv_fetchsv(fq, GV_ADD, SVt_PVCV);
    CV *old;

    if (!gv)
        return;

    old = GvCV(gv);
    GvCV_set(gv, (CV *) SvREFCNT_inc((SV *) code));
    GvCVGEN(gv) = 0;
    if (old)
        SvREFCNT_dec((SV *) old);
}

static void
cs_unseal(pTHX_ cs_slot *slot)
{
    CV *orig;

    if (slot->unsealed)
        return;
    slot->unsealed = 1;

    orig = (CV *) SvRV(slot->orig);
    cs_set_cv(aTHX_ slot->fq, orig);
    if (slot->fq_alias)
        cs_set_cv(aTHX_ slot->fq_alias, orig);

    /* Our own CV is running right now. The slot holds a reference to it, so
     * dropping it out of the globs above cannot free it under us. */
    mro_method_changed_in(slot->stash);
}

/* Call the shadowed accessor with the arguments we were given and leave its
 * results where the caller expects ours. Returns the number of values.
 *
 * The slow path only: a write, or a subclass created after sealing. Copying
 * both ways costs nothing there and keeps the stack handling obvious. */
static I32
cs_delegate(pTHX_ SV *code, I32 items, I32 ax)
{
    dSP;
    I32 count, i;
    I32 gimme = GIMME_V;
    SV **argv;
    SV **out;

    Newx(argv, items ? items : 1, SV *);
    for (i = 0; i < items; i++)
        argv[i] = ST(i);

    ENTER;
    SAVETMPS;

    PUSHMARK(SP);
    EXTEND(SP, items);
    for (i = 0; i < items; i++)
        PUSHs(argv[i]);
    PUTBACK;

    count = call_sv(code, gimme);

    SPAGAIN;
    Newx(out, count ? count : 1, SV *);
    for (i = count - 1; i >= 0; i--)
        out[i] = newSVsv(POPs);
    PUTBACK;

    FREETMPS;
    LEAVE;

    /* Back to our own frame. Rewind to just below our arguments and put the
     * results there instead. */
    SPAGAIN;
    SP = PL_stack_base + ax - 1;
    EXTEND(SP, count);
    PUTBACK;

    for (i = 0; i < count; i++)
        ST(i) = sv_2mortal(out[i]);

    Safefree(argv);
    Safefree(out);
    return count;
}

static void
cs_const_accessor(pTHX_ CV *cv)
{
    dXSARGS;
    cs_slot *slot = (cs_slot *) CvXSUBANY(cv).any_ptr;
    SV *inv;
    int mine = 0;

    if (!slot)
        croak("Catalyst::Seal: sealed accessor with no slot");

    if (items < 1)
        croak("Usage: %s($class)", SvPV_nolen(slot->name));

    /* Is this the class the value was resolved for? A subclass created after
     * sealing inherits this XSUB but not the answer, so it goes the long way
     * round rather than being told the parent's value. */
    inv = ST(0);
    if (SvROK(inv)) {
        SV *rv = SvRV(inv);
        if (SvOBJECT(rv) && SvSTASH(rv) == slot->stash)
            mine = 1;
    }
    else if (SvOK(inv)) {
        STRLEN il, pl;
        const char *ip = SvPV_const(inv, il);
        const char *pp = SvPV_const(slot->pkg, pl);
        if (il == pl && memEQ(ip, pp, il))
            mine = 1;
    }

    if (mine && items == 1 && !slot->unsealed) {
        /* The stock accessor ends in a bare "return;" when it finds nothing
         * defined, anywhere in the ISA. That is an empty list in list context,
         * not a one element list holding undef, and a class data value that
         * was explicitly set to undef is indistinguishable from one that was
         * never set: both take that branch. */
        if (!SvOK(slot->value)) {
            if (GIMME_V == G_LIST)
                XSRETURN_EMPTY;
            XSRETURN_UNDEF;
        }
        ST(0) = slot->value;
        XSRETURN(1);
    }

    /* A write puts the original accessor back for good: from here on the value
     * can change and a constant would be a lie.
     *
     * Only a write to the class we resolved for. A subclass writing through
     * the inherited XSUB is storing into its own glob and says nothing about
     * ours, so unsealing there would give up the constant for every class in
     * the tree the first time any one of them is written to. */
    if (mine && items > 1)
        cs_unseal(aTHX_ slot);

    XSRETURN(cs_delegate(aTHX_ slot->orig, items, ax));
}

/* A slot name, hashed once at seal time. */
static void
cs_key_init(pTHX_ cs_key *k, SV *name)
{
    STRLEN len;
    const char *p = SvPV_const(name, len);
    k->key = newSVsv(name);
    PERL_HASH(k->hash, p, len);
}

/* The entry for a slot, or NULL when the slot is not there. Absence and undef
 * are different questions here: Moose's predicate asks the first, so the
 * entry rather than the value is what the callers below test. */
static HE *
cs_slot_he(pTHX_ HV *hv, cs_key *k)
{
    return hv_fetch_ent(hv, k->key, 0, k->hash);
}

/* Is this invocant a blessed hash we can read a slot out of? */
#define CS_IS_HASH_OBJECT(sv) \
    (SvROK(sv) && SvOBJECT(SvRV(sv)) && SvTYPE(SvRV(sv)) == SVt_PVHV)

/* A sealed attribute reader.
 *
 * Moose's inlined reader is already cheap, about 88ns against this XSUB's 44,
 * so the only thing worth doing here is the fetch and nothing else. Everything
 * that is not "an instance of exactly this class, reading" goes to the reader
 * we shadowed: a class method call, a write, an instance of a subclass.
 *
 * A lazy attribute whose slot is not there yet also delegates, which is how
 * this avoids reimplementing Moose's builders entirely. The stock reader
 * builds and stores it, and every call after that takes the fast path.
 *
 * A WRITE is answered here only for an attribute the Perl side has checked is
 * a plain one: no type constraint, no coercion, no trigger, no weak reference,
 * no initializer. What Moose's inlined writer does for such an attribute is
 * store a copy and return it, and so does this. Everything else still
 * delegates, which is what keeps a predicate honest for a lazy attribute
 * nothing has written. */
static void
cs_attr_reader(pTHX_ CV *cv)
{
    dXSARGS;
    cs_reader *r = (cs_reader *) CvXSUBANY(cv).any_ptr;
    SV *inv, *rv;
    HE *he;

    if (!r)
        croak("Catalyst::Seal: sealed reader with no slot");

    if (items != 1 && !(items == 2 && r->rw))
        goto slow;

    inv = ST(0);
    if (!SvROK(inv))
        goto slow;

    rv = SvRV(inv);
    /* A blessed object is a hash reference, so SvTYPE alone would accept an
     * object of any class built on any other type. SvOBJECT is the question
     * actually being asked. */
    if (!SvOBJECT(rv) || SvTYPE(rv) != SVt_PVHV)
        goto slow;
    if (SvSTASH(rv) != r->stash)
        goto slow;

    if (items == 2) {
        /* $_[0]{slot} = $_[1] - a copy, because that is what an assignment
         * into a hash is, and returning the stored element, because that is
         * what the assignment evaluates to. */
        SV *nv = newSVsv(ST(1));
        he = hv_store_ent((HV *) rv, r->key, nv, r->hash);
        if (!he) {
            SvREFCNT_dec(nv);
            goto slow;
        }
        ST(0) = HeVAL(he);
        XSRETURN(1);
    }

    he = hv_fetch_ent((HV *) rv, r->key, 0, r->hash);
    if (he) {
        ST(0) = HeVAL(he);
        XSRETURN(1);
    }
    if (!r->lazy)
        XSRETURN_UNDEF;

slow:
    XSRETURN(cs_delegate(aTHX_ r->orig, items, ax));
}

/* Catalyst::depth: scalar @{ shift->stack || [] }.
 *
 * An empty or absent slot is 0 rather than a delegation, because that is the
 * answer the stock body's `|| []` gives. Anything that is not an array
 * reference is not a stack this understands, and goes the long way. */
static void
cs_slot_count(pTHX_ CV *cv)
{
    dXSARGS;
    cs_count *r = (cs_count *) CvXSUBANY(cv).any_ptr;
    SV *inv, *rv, *val;
    HE *he;

    if (!r)
        croak("Catalyst::Seal: sealed count with no slot");

    if (items != 1)
        goto slow;

    inv = ST(0);
    if (!CS_IS_HASH_OBJECT(inv))
        goto slow;

    rv = SvRV(inv);
    if (SvSTASH(rv) != r->stash)
        goto slow;

    he = cs_slot_he(aTHX_ (HV *) rv, &r->slot);
    if (!he || !SvOK(HeVAL(he)))
        XSRETURN_IV(0);

    val = HeVAL(he);
    if (!SvROK(val) || SvTYPE(SvRV(val)) != SVt_PVAV)
        goto slow;

    XSRETURN_IV(av_len((AV *) SvRV(val)) + 1);

slow:
    XSRETURN(cs_delegate(aTHX_ r->orig, items, ax));
}

/* Call $code with the arguments this XSUB was given, minus the invocant, and
 * leave its results where ours belong. The arguments are already contiguous on
 * the stack, so this passes them where they lie rather than copying: the mark
 * goes on the invocant's own slot, which is the one immediately below them.
 *
 * The results then land one slot too high - call_sv leaves them at mark + 1 -
 * so they are moved down by one. That is a pointer move of however many values
 * were returned, against a copy of every argument and every result, which is
 * what cs_delegate does for the paths where clarity is worth more than speed. */
static I32
cs_call_shifted(pTHX_ SV *code, I32 items, I32 ax)
{
    dSP;
    I32 count;
    I32 gimme = GIMME_V;

    SP = PL_stack_base + ax + items - 1;
    PUSHMARK(PL_stack_base + ax);
    PUTBACK;

    count = call_sv(code, gimme);

    SPAGAIN;
    if (count)
        Move(PL_stack_base + ax + 1, PL_stack_base + ax, count, SV *);
    SP = PL_stack_base + ax + count - 1;
    PUTBACK;

    return count;
}

/* Catalyst::Action::execute: $self->code->(@_) */
static void
cs_action_execute(pTHX_ CV *cv)
{
    dXSARGS;
    cs_action *a = (cs_action *) CvXSUBANY(cv).any_ptr;
    HE *he;
    SV *code;

    if (!a)
        croak("Catalyst::Seal: sealed action method with no slot");

    if (items < 1 || !CS_IS_HASH_OBJECT(ST(0)))
        goto slow;

    he = cs_slot_he(aTHX_ (HV *) SvRV(ST(0)), &a->code);
    if (!he)
        goto slow;

    code = HeVAL(he);
    if (!SvROK(code) || SvTYPE(SvRV(code)) != SVt_PVCV)
        goto slow;

    XSRETURN(cs_call_shifted(aTHX_ code, items, ax));

slow:
    XSRETURN(cs_delegate(aTHX_ a->orig, items, ax));
}

/* Catalyst::Action::dispatch:
 *
 *     $self->has_instance ? $c->execute($self->instance, $self)
 *                         : $c->execute($self->class,    $self)
 *
 * has_instance is Moose's predicate, which asks whether the slot is there and
 * not whether its value is defined, so this asks the same. */
static void
cs_action_dispatch(pTHX_ CV *cv)
{
    dXSARGS;
    cs_action *a = (cs_action *) CvXSUBANY(cv).any_ptr;
    HE *he;
    SV *target;
    I32 count;
    I32 gimme = GIMME_V;

    if (!a)
        croak("Catalyst::Seal: sealed action method with no slot");

    if (items != 2 || !CS_IS_HASH_OBJECT(ST(0)))
        goto slow;

    he = cs_slot_he(aTHX_ (HV *) SvRV(ST(0)), &a->instance);
    if (!he) {
        he = cs_slot_he(aTHX_ (HV *) SvRV(ST(0)), &a->klass);
        if (!he)
            goto slow;
    }
    target = HeVAL(he);

    /* $c->execute($target, $self). A method call, not the resolved body: a
     * plugin's execute is found the same way the stock code would find it,
     * and the interpreter's method cache makes the lookup a hash hit. */
    PUSHMARK(SP);
    EXTEND(SP, 3);
    PUSHs(ST(1));
    PUSHs(target);
    PUSHs(ST(0));
    PUTBACK;

    count = call_method(SvPV_nolen(a->method), gimme);

    SPAGAIN;
    if (count)
        Move(SP - count + 1, PL_stack_base + ax, count, SV *);
    SP = PL_stack_base + ax + count - 1;
    PUTBACK;
    XSRETURN(count);

slow:
    XSRETURN(cs_delegate(aTHX_ a->orig, items, ax));
}

/* ---- parameters ----------------------------------------------------------
 *
 * A query string reaches an application through a percent-decode and a UTF-8
 * decode, run separately over every name and every value, each through a
 * closure and an eval. Four pairs cost about ten microseconds that way, which
 * is more than the rest of the request's parsing put together.
 *
 * Both halves are here. Nothing about them is clever: what makes them worth
 * having is that they are one pass over the bytes with no Perl frame in it.
 */

/* Percent-decode in place of Catalyst::Engine::unescape_uri:
 *
 *     s/(?:%([0-9A-Fa-f]{2})|\+)/defined $1 ? chr(hex($1)) : ' '/eg
 *
 * A '%' that does not begin two hex digits is not an escape and stays as it
 * is, which is what that regex does and not what a stricter decoder would. */
static int cs_hexval(unsigned char c)
{
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
    return -1;
}

static void
cs_unescape(pTHX_ const char *s, STRLEN len, SV *out)
{
    STRLEN i;
    char *d;

    SvUPGRADE(out, SVt_PV);
    SvGROW(out, len + 1);
    d = SvPVX(out);

    for (i = 0; i < len; i++) {
        unsigned char c = (unsigned char) s[i];
        if (c == '+') {
            *d++ = ' ';
        }
        else if (c == '%' && i + 2 < len) {
            int hi = cs_hexval((unsigned char) s[i + 1]);
            int lo = cs_hexval((unsigned char) s[i + 2]);
            if (hi >= 0 && lo >= 0) {
                *d++ = (char) ((hi << 4) | lo);
                i += 2;
            }
            else {
                *d++ = (char) c;
            }
        }
        else {
            *d++ = (char) c;
        }
    }

    SvCUR_set(out, (STRLEN)(d - SvPVX(out)));
    *SvEND(out) = '\0';
    SvPOK_only(out);
    SvUTF8_off(out);
}

/* Strict UTF-8, as Encode's "UTF-8" means it and not as perl's own "utf8"
 * does. No overlong form, no surrogate, nothing above U+10FFFF, nothing
 * truncated - and no noncharacter either, which is the one that is easy to
 * miss: Encode refuses all sixty-six of U+FDD0..U+FDEF and U+xFFFE/U+xFFFF,
 * measured against Encode 3.21 rather than read off a specification.
 *
 * Anything this refuses goes back to Encode, which refuses it in the words
 * Catalyst's error handling expects, so the cost of being wrong in this
 * direction is a slow path and the cost of being wrong in the other is a
 * request that should have been refused and was not. */
static int
cs_utf8_strict_ok(const unsigned char *s, STRLEN len)
{
    STRLEN i = 0;

    while (i < len) {
        unsigned char c = s[i];
        STRLEN need, k;
        unsigned char lo2, hi2;
        UV cp;

        if (c < 0x80) { i++; continue; }

        if (c >= 0xC2 && c <= 0xDF)      { need = 1; lo2 = 0x80; hi2 = 0xBF; }
        else if (c == 0xE0)              { need = 2; lo2 = 0xA0; hi2 = 0xBF; }
        else if (c >= 0xE1 && c <= 0xEC) { need = 2; lo2 = 0x80; hi2 = 0xBF; }
        else if (c == 0xED)              { need = 2; lo2 = 0x80; hi2 = 0x9F; }
        else if (c >= 0xEE && c <= 0xEF) { need = 2; lo2 = 0x80; hi2 = 0xBF; }
        else if (c == 0xF0)              { need = 3; lo2 = 0x90; hi2 = 0xBF; }
        else if (c >= 0xF1 && c <= 0xF3) { need = 3; lo2 = 0x80; hi2 = 0xBF; }
        else if (c == 0xF4)              { need = 3; lo2 = 0x80; hi2 = 0x8F; }
        else return 0;

        if (i + need >= len) return 0;          /* truncated */
        if (s[i + 1] < lo2 || s[i + 1] > hi2) return 0;
        for (k = 2; k <= need; k++)
            if (s[i + k] < 0x80 || s[i + k] > 0xBF) return 0;

        cp = (UV)(c & (0x3F >> need));   /* 5, 4 then 3 payload bits */
        for (k = 1; k <= need; k++)
            cp = (cp << 6) | (UV)(s[i + k] & 0x3F);

        if ((cp & 0xFFFE) == 0xFFFE) return 0;          /* U+xFFFE, U+xFFFF */
        if (cp >= 0xFDD0 && cp <= 0xFDEF) return 0;     /* the other sixty-two */

        i += need + 1;
    }

    return 1;
}

/* The bytes are already the UTF-8 form of the characters they stand for, so
 * a valid string is decoded by saying so. Encode returns a string flagged
 * UTF-8 whatever it held - ASCII and empty included - and so does this. */
static int
cs_utf8_decode(pTHX_ SV *sv)
{
    STRLEN len;
    const char *p = SvPV_const(sv, len);
    if (!cs_utf8_strict_ok((const unsigned char *) p, len))
        return 0;
    SvUTF8_on(sv);
    return 1;
}

/* A sealed constructor.
 *
 * What Moose's inlined constructor does for a class whose attributes are all
 * plain is: work out the parameters, bless a hash, fill it from the parameters
 * and the defaults, and run the BUILD methods. Every decision in the middle of
 * that - which key an attribute reads, whether it has a default and what kind,
 * whether anything has to be checked - was settled when the class was made
 * immutable, and is in the template this walks.
 *
 * Anything the template could not settle takes the stock constructor, entire.
 * There is no half-built instance to hand over: the escape happens before the
 * first BUILD runs, and the hash built up to that point is simply dropped. */
static void
cs_constructor(pTHX_ CV *cv)
{
    dXSARGS;
    cs_ctor *c = (cs_ctor *) CvXSUBANY(cv).any_ptr;
    HV *params = NULL;
    SV *params_rv = NULL;
    HV *self;
    SV *rv;
    int i;

    if (!c)
        croak("Catalyst::Seal: sealed constructor with no template");

    /* A subclass created after the seal inherits this XSUB but not the
     * template that was resolved for its parent. */
    if (items < 1 || SvROK(ST(0)))
        goto slow;
    {
        STRLEN il, cl;
        const char *ip = SvPV_const(ST(0), il);
        const char *cp = SvPV_const(c->class, cl);
        if (il != cl || memNE(ip, cp, il))
            goto slow;
    }

    if (c->buildargs) {
        /* A class with its own BUILDARGS: call it exactly as the stock
         * constructor would, with the arguments as they arrived.
         *
         * What it returns is almost certainly mortal, and this frame's
         * FREETMPS is about to run, so a reference is taken on the hash
         * itself and wrapped in an RV that belongs to the frame BELOW - the
         * one whose temporaries live as long as this XSUB does. */
        dSP;
        I32 count;
        HV *got = NULL;

        ENTER;
        SAVETMPS;
        PUSHMARK(SP);
        EXTEND(SP, items);
        for (i = 0; i < items; i++)
            PUSHs(ST(i));
        PUTBACK;
        count = call_sv(c->buildargs, G_SCALAR);
        SPAGAIN;
        if (count) {
            SV *res = POPs;
            if (SvROK(res) && SvTYPE(SvRV(res)) == SVt_PVHV
                && !SvOBJECT(SvRV(res)))
                got = (HV *) SvREFCNT_inc(SvRV(res));
        }
        PUTBACK;
        FREETMPS;
        LEAVE;

        if (!got)
            goto slow;
        params    = got;
        params_rv = sv_2mortal(newRV_noinc((SV *) got));
    }
    else if (items == 2 && SvROK(ST(1))
             && SvTYPE(SvRV(ST(1))) == SVt_PVHV && !SvOBJECT(SvRV(ST(1)))) {
        /* Moose's own BUILDARGS hands a single hash reference straight
         * through, so the hash BUILD sees is the caller's own. */
        params_rv = ST(1);
        params    = (HV *) SvRV(params_rv);
    }
    else if (!((items - 1) % 2)) {
        params = newHV();
        params_rv = sv_2mortal(newRV_noinc((SV *) params));
        for (i = 1; i < items; i += 2)
            (void) hv_store_ent(params, ST(i), newSVsv(ST(i + 1)), 0);
    }
    else {
        goto slow;    /* an odd number of arguments: Moose says what to do */
    }

    /* Moose lets a caller hand in the instance to build into. Rare, and not
     * something a template can describe. */
    if (hv_exists(params, "__INSTANCE__", 12))
        goto slow;

    self = newHV();
    hv_ksplit(self, c->nattrs);
    rv = sv_2mortal(newRV_noinc((SV *) self));
    (void) sv_bless(rv, c->stash);

    for (i = 0; i < c->nattrs; i++) {
        cs_ctor_attr *a = &c->attrs[i];
        HE *given = NULL;
        SV *stored = NULL;

        if (a->init_arg)
            given = hv_fetch_ent(params, a->init_arg, 0, a->init_hash);

        if (given) {
            if (a->flags & CS_A_GUARDED)
                goto slow;
            if (a->flags & CS_A_TYPED) {
                /* The constraint's own check, so what passes here is exactly
                 * what passes there. A value that fails takes the long way,
                 * where Moose raises the error it would have raised anyway -
                 * this has no business writing that message. */
                dSP;
                I32 count;
                int good;
                ENTER;
                SAVETMPS;
                PUSHMARK(SP);
                XPUSHs(HeVAL(given));
                PUTBACK;
                count = call_sv(a->check, G_SCALAR);
                SPAGAIN;
                good = count ? SvTRUE(TOPs) : 0;
                if (count) (void) POPs;
                PUTBACK;
                FREETMPS;
                LEAVE;
                if (!good)
                    goto slow;
            }
            stored = newSVsv(HeVAL(given));
        }
        else {
            switch (a->kind) {
            case CS_D_CONST:
                stored = newSVsv(a->dflt);
                break;
            case CS_D_HASH:
                stored = newRV_noinc((SV *) newHV());
                break;
            case CS_D_ARRAY:
                stored = newRV_noinc((SV *) newAV());
                break;
            case CS_D_CODE: {
                dSP;
                I32 count;
                ENTER;
                SAVETMPS;
                PUSHMARK(SP);
                XPUSHs(rv);
                PUTBACK;
                count = call_sv(a->dflt, G_SCALAR);
                SPAGAIN;
                stored = count ? newSVsv(POPs) : newSV(0);
                PUTBACK;
                FREETMPS;
                LEAVE;
                break;
            }
            default:
                /* No default. Required without one is Moose's error to
                 * raise, and it raises it better than a template could. */
                if (a->flags & CS_A_REQUIRED)
                    goto slow;
                continue;
            }
        }

        if (!hv_store_ent(self, a->slot.key, stored, a->slot.hash)) {
            SvREFCNT_dec(stored);
            goto slow;
        }
        if ((a->flags & CS_A_WEAK) && SvROK(stored))
            sv_rvweaken(stored);
    }

    if (c->nbuilds) {
        AV *builds = (AV *) SvRV(c->builds);
        for (i = 0; i < c->nbuilds; i++) {
            SV **b = av_fetch(builds, i, 0);
            dSP;
            if (!b)
                continue;
            ENTER;
            SAVETMPS;
            PUSHMARK(SP);
            EXTEND(SP, 2);
            PUSHs(rv);
            PUSHs(params_rv);
            PUTBACK;
            call_sv(*b, G_VOID | G_DISCARD);
            SPAGAIN;
            PUTBACK;
            FREETMPS;
            LEAVE;
        }
    }

    c->fast++;
    ST(0) = rv;
    XSRETURN(1);

slow:
    c->slow++;
    XSRETURN(cs_delegate(aTHX_ c->orig, items, ax));
}

MODULE = Catalyst::Seal        PACKAGE = Catalyst::Seal

PROTOTYPES: DISABLE

void
_install_const(pkg, name, value, orig, alias = NULL)
    SV *pkg
    SV *name
    SV *value
    SV *orig
    SV *alias
  PREINIT:
    cs_slot *slot;
    CV *cv;
    HV *stash;
    STRLEN plen, nlen;
    const char *pstr, *nstr;
    SV *fq, *fq_alias;
  PPCODE:
    if (!SvROK(orig) || SvTYPE(SvRV(orig)) != SVt_PVCV)
        croak("Catalyst::Seal::_install_const: orig must be a code reference");

    pstr = SvPV_const(pkg, plen);
    nstr = SvPV_const(name, nlen);

    stash = gv_stashpvn(pstr, plen, GV_ADD);
    if (!stash)
        croak("Catalyst::Seal::_install_const: no stash for %" SVf, SVfARG(pkg));

    fq = newSVpvn(pstr, plen);
    sv_catpvs(fq, "::");
    sv_catpvn(fq, nstr, nlen);

    /* mk_classdata's second name for the same accessor. Optional, because not
     * everything sealed here is a class data pair: sealing "config" under the
     * convention would install a _config_accessor that never existed. */
    if (alias && SvOK(alias)) {
        STRLEN alen;
        const char *astr = SvPV_const(alias, alen);
        fq_alias = newSVpvn(pstr, plen);
        sv_catpvs(fq_alias, "::");
        sv_catpvn(fq_alias, astr, alen);
    }
    else if (!alias) {
        fq_alias = newSVpvn(pstr, plen);
        sv_catpvs(fq_alias, "::_");
        sv_catpvn(fq_alias, nstr, nlen);
        sv_catpvs(fq_alias, "_accessor");
    }
    else {
        fq_alias = NULL;
    }

    Newxz(slot, 1, cs_slot);
    slot->value    = newSVsv(value);
    slot->orig     = newSVsv(orig);
    slot->pkg      = newSVsv(pkg);
    slot->name     = newSVsv(name);
    slot->fq       = fq;
    slot->fq_alias = fq_alias;
    slot->stash    = (HV *) SvREFCNT_inc((SV *) stash);
    slot->unsealed = 0;

    /* newXS installs into the named glob and warns about redefinition against
     * the caller's warning bits, so the Perl side does this inside a
     * "no warnings 'redefine'". */
    cv = newXS(SvPV_nolen(fq), cs_const_accessor, __FILE__);
    CvXSUBANY(cv).any_ptr = slot;
    slot->cv = (CV *) SvREFCNT_inc((SV *) cv);

    if (fq_alias) {
        cv = newXS(SvPV_nolen(fq_alias), cs_const_accessor, __FILE__);
        CvXSUBANY(cv).any_ptr = slot;
        slot->cv_alias = (CV *) SvREFCNT_inc((SV *) cv);
    }

    mro_method_changed_in(stash);
    XSRETURN_YES;

# The header build, as one pass over the environment.
#
# `field` is the memo the Perl side keeps: an environment key maps to 0 for a
# key that is not a header, to an array of [ spelling, standard case ] for one
# whose spelling has been learned, or to 1 for one that has to go the long way.
# A key that is not in the memo at all has never been seen.
#
# Everything this cannot place - an unlearned key, a value that is not a plain
# string, a key marked for the long way - is pushed onto `todo` and handed back
# for Perl to finish. After the first request of each shape that list is empty.
void
_build_headers(env, field, headers, std)
    HV *env
    HV *field
    HV *headers
    HV *std
  PREINIT:
    HE *he;
    AV *todo;
  PPCODE:
    todo = newAV();

    hv_iterinit(env);
    while ((he = hv_iternext(env))) {
        SV *key = hv_iterkeysv(he);
        SV *known = NULL;
        HE *fe;
        AV *pair;
        SV **spell, **case_;
        SV *value;

        fe = hv_fetch_ent(field, key, 0, 0);
        if (!fe) {                       /* never seen: Perl learns it */
            av_push(todo, newSVsv(key));
            continue;
        }
        known = HeVAL(fe);

        if (!SvOK(known) || !SvTRUE(known))
            continue;                    /* not a header at all */

        if (!SvROK(known) || SvTYPE(SvRV(known)) != SVt_PVAV) {
            av_push(todo, newSVsv(key)); /* marked for the long way */
            continue;
        }

        value = HeVAL(he);
        if (!SvOK(value) || SvROK(value)) {
            /* An undefined value is a delete rather than a store, and a
             * reference is not a string. Both are HTTP::Headers' business. */
            av_push(todo, newSVsv(key));
            continue;
        }

        pair  = (AV *) SvRV(known);
        spell = av_fetch(pair, 0, 0);
        if (!spell) {
            av_push(todo, newSVsv(key));
            continue;
        }
        (void) hv_store_ent(headers, *spell, newSVsv(value), 0);

        case_ = av_fetch(pair, 1, 0);
        if (case_ && SvOK(*case_))
            (void) hv_store_ent(std, *spell, newSVsv(*case_), 0);
    }

    PUSHs(sv_2mortal(newRV_noinc((SV *) todo)));

# One value, percent-decoded and then UTF-8 decoded. Returns undef where the
# bytes are not strict UTF-8, which is the caller's signal to let Encode have
# them: refusing is Encode's job and Catalyst has a handler for it.
void
_decode_param(value, unescape = 1, decode = 1)
    SV *value
    int unescape
    int decode
  PREINIT:
    SV *out;
    STRLEN len;
    const char *p;
  PPCODE:
    if (!SvOK(value))
        XSRETURN_UNDEF;

    out = sv_newmortal();
    if (unescape) {
        p = SvPV_const(value, len);
        cs_unescape(aTHX_ p, len, out);
    }
    else {
        sv_setsv(out, value);
        SvUTF8_off(out);
    }

    if (decode && !cs_utf8_decode(aTHX_ out))
        XSRETURN_EMPTY;         /* not ours to answer */

    ST(0) = out;
    XSRETURN(1);

# A query string, split and decoded in one pass, as the hash Catalyst puts in
# query_parameters when it is not using Hash::MultiValue: one value for a name
# that appeared once, an array reference for a name that appeared more than
# once, in the order they arrived.
#
# Returns an empty list if any part of it is not strict UTF-8, so the whole
# query goes back to the stock parser rather than being half decoded here.
void
_parse_query(qs, decode = 1)
    SV *qs
    int decode
  PREINIT:
    STRLEN len, i;
    const char *s;
    HV *out;
    SV *keywords = NULL;
    int first = 1;
  PPCODE:
    if (!SvOK(qs))
        XSRETURN_EMPTY;
    s = SvPV_const(qs, len);

    out = newHV();
    sv_2mortal((SV *) out);

    i = 0;
    while (i < len && (s[i] == '&' || s[i] == ';')) i++;   /* s/\A[&;]+// */

    while (i < len) {
        STRLEN start = i, eq = 0;
        int have_eq = 0;
        SV *name, *value = NULL;
        HE *he;

        while (i < len && s[i] != '&' && s[i] != ';') {
            if (!have_eq && s[i] == '=') { eq = i; have_eq = 1; }
            i++;
        }

        name = sv_newmortal();
        cs_unescape(aTHX_ s + start, (have_eq ? eq : i) - start, name);
        if (decode && !cs_utf8_decode(aTHX_ name))
            XSRETURN_EMPTY;

        if (have_eq) {
            value = sv_newmortal();
            cs_unescape(aTHX_ s + eq + 1, i - eq - 1, value);
            if (decode && !cs_utf8_decode(aTHX_ value))
                XSRETURN_EMPTY;
        }

        /* An isindex query: the first pair with no '=' is the keywords, and
         * the stock parser records it while still adding it as a parameter. */
        if (first && !have_eq)
            keywords = name;
        first = 0;

        he = hv_fetch_ent(out, name, 0, 0);
        if (!he) {
            (void) hv_store_ent(out, name,
                                value ? newSVsv(value) : newSV(0), 0);
        }
        else {
            SV *seen = HeVAL(he);
            if (SvROK(seen) && SvTYPE(SvRV(seen)) == SVt_PVAV) {
                av_push((AV *) SvRV(seen), value ? newSVsv(value) : newSV(0));
            }
            else {
                AV *av = newAV();
                av_push(av, newSVsv(seen));
                av_push(av, value ? newSVsv(value) : newSV(0));
                (void) hv_store_ent(out, name, newRV_noinc((SV *) av), 0);
            }
        }

        while (i < len && (s[i] == '&' || s[i] == ';')) i++;   /* split /[&;]+/ */
    }

    EXTEND(SP, 2);
    PUSHs(sv_2mortal(newRV_inc((SV *) out)));
    PUSHs(keywords ? keywords : &PL_sv_undef);

# How many constructions a sealed constructor answered itself, and how many it
# handed on. For the test suite: an XSUB that is installed and never taken is
# indistinguishable from one that works, until something counts.
void
_ctor_counts(code)
    SV *code
  PREINIT:
    CV *cv;
    cs_ctor *c;
  PPCODE:
    if (!SvROK(code) || SvTYPE(SvRV(code)) != SVt_PVCV)
        XSRETURN_EMPTY;
    cv = (CV *) SvRV(code);
    if (!CvISXSUB(cv) || CvXSUB(cv) != cs_constructor)
        XSRETURN_EMPTY;
    c = (cs_ctor *) CvXSUBANY(cv).any_ptr;
    if (!c)
        XSRETURN_EMPTY;
    EXTEND(SP, 2);
    PUSHs(sv_2mortal(newSVuv(c->fast)));
    PUSHs(sv_2mortal(newSVuv(c->slow)));

# Whether a given sealed accessor has been unsealed by a write. For the test
# suite, and for CATALYST_SEAL_DEBUG reporting.
void
_is_sealed(code)
    SV *code
  PREINIT:
    CV *cv;
    cs_slot *slot;
  PPCODE:
    if (!SvROK(code) || SvTYPE(SvRV(code)) != SVt_PVCV)
        XSRETURN_UNDEF;
    cv = (CV *) SvRV(code);
    if (CvISXSUB(cv) && CvXSUB(cv) == cs_const_accessor) {
        slot = (cs_slot *) CvXSUBANY(cv).any_ptr;
        if (slot && !slot->unsealed)
            XSRETURN_YES;
        XSRETURN_NO;
    }
    if (CvISXSUB(cv) && (CvXSUB(cv) == cs_attr_reader
                         || CvXSUB(cv) == cs_slot_count
                         || CvXSUB(cv) == cs_constructor
                         || CvXSUB(cv) == cs_action_execute
                         || CvXSUB(cv) == cs_action_dispatch))
        XSRETURN_YES;
    XSRETURN_UNDEF;

void
_install_reader(pkg, name, key, orig, lazy, rw = 0)
    SV *pkg
    SV *name
    SV *key
    SV *orig
    int lazy
    int rw
  PREINIT:
    cs_reader *r;
    CV *cv;
    HV *stash;
    STRLEN plen, nlen, klen;
    const char *pstr, *nstr, *kstr;
    U32 hash;
    SV *fq;
  PPCODE:
    if (!SvROK(orig) || SvTYPE(SvRV(orig)) != SVt_PVCV)
        croak("Catalyst::Seal::_install_reader: orig must be a code reference");

    pstr = SvPV_const(pkg, plen);
    nstr = SvPV_const(name, nlen);
    kstr = SvPV_const(key, klen);

    stash = gv_stashpvn(pstr, plen, GV_ADD);
    if (!stash)
        croak("Catalyst::Seal::_install_reader: no stash for %" SVf, SVfARG(pkg));

    fq = newSVpvn(pstr, plen);
    sv_catpvs(fq, "::");
    sv_catpvn(fq, nstr, nlen);

    PERL_HASH(hash, kstr, klen);

    Newxz(r, 1, cs_reader);
    r->key   = newSVsv(key);
    r->hash  = hash;
    r->orig  = newSVsv(orig);
    r->fq    = fq;
    r->stash = (HV *) SvREFCNT_inc((SV *) stash);
    r->lazy  = lazy ? 1 : 0;
    r->rw    = rw ? 1 : 0;

    cv = newXS(SvPV_nolen(fq), cs_attr_reader, __FILE__);
    CvXSUBANY(cv).any_ptr = r;
    r->cv = (CV *) SvREFCNT_inc((SV *) cv);

    mro_method_changed_in(stash);
    XSRETURN_YES;

# The length of an array in a slot: Catalyst::depth and nothing else so far.
void
_install_count(pkg, name, key, orig)
    SV *pkg
    SV *name
    SV *key
    SV *orig
  PREINIT:
    cs_count *r;
    CV *cv;
    HV *stash;
    STRLEN plen, nlen;
    const char *pstr, *nstr;
    SV *fq;
  PPCODE:
    if (!SvROK(orig) || SvTYPE(SvRV(orig)) != SVt_PVCV)
        croak("Catalyst::Seal::_install_count: orig must be a code reference");

    pstr = SvPV_const(pkg, plen);
    nstr = SvPV_const(name, nlen);

    stash = gv_stashpvn(pstr, plen, GV_ADD);
    if (!stash)
        croak("Catalyst::Seal::_install_count: no stash for %" SVf, SVfARG(pkg));

    fq = newSVpvn(pstr, plen);
    sv_catpvs(fq, "::");
    sv_catpvn(fq, nstr, nlen);

    Newxz(r, 1, cs_count);
    cs_key_init(aTHX_ &r->slot, key);
    r->orig  = newSVsv(orig);
    r->stash = (HV *) SvREFCNT_inc((SV *) stash);

    cv = newXS(SvPV_nolen(fq), cs_slot_count, __FILE__);
    CvXSUBANY(cv).any_ptr = r;
    r->cv = (CV *) SvREFCNT_inc((SV *) cv);
    SvREFCNT_dec(fq);

    mro_method_changed_in(stash);
    XSRETURN_YES;

# A sealed constructor. `attrs` is an array of
#
#     [ init_arg | undef, slot, kind, default, flags ]
#
# in the order the stock constructor fills them, and `builds` an array of the
# BUILD bodies in the order BUILDALL would call them. `buildargs` is the
# class's own BUILDARGS, or undef where Moose's is in force.
void
_install_ctor(pkg, name, orig, buildargs, attrs, builds)
    SV *pkg
    SV *name
    SV *orig
    SV *buildargs
    SV *attrs
    SV *builds
  PREINIT:
    cs_ctor *c;
    CV *cv;
    HV *stash;
    AV *av;
    STRLEN plen, nlen;
    const char *pstr, *nstr;
    SV *fq;
    int i;
  PPCODE:
    if (!SvROK(orig) || SvTYPE(SvRV(orig)) != SVt_PVCV)
        croak("Catalyst::Seal::_install_ctor: orig must be a code reference");
    if (!SvROK(attrs) || SvTYPE(SvRV(attrs)) != SVt_PVAV)
        croak("Catalyst::Seal::_install_ctor: attrs must be an array reference");
    if (!SvROK(builds) || SvTYPE(SvRV(builds)) != SVt_PVAV)
        croak("Catalyst::Seal::_install_ctor: builds must be an array reference");

    pstr = SvPV_const(pkg, plen);
    nstr = SvPV_const(name, nlen);

    stash = gv_stashpvn(pstr, plen, GV_ADD);
    if (!stash)
        croak("Catalyst::Seal::_install_ctor: no stash for %" SVf, SVfARG(pkg));

    fq = newSVpvn(pstr, plen);
    sv_catpvs(fq, "::");
    sv_catpvn(fq, nstr, nlen);

    Newxz(c, 1, cs_ctor);
    c->stash     = (HV *) SvREFCNT_inc((SV *) stash);
    c->class     = newSVsv(pkg);
    c->orig      = newSVsv(orig);
    c->buildargs = (buildargs && SvOK(buildargs)) ? newSVsv(buildargs) : NULL;
    c->builds    = newSVsv(builds);
    c->nbuilds   = (int) av_len((AV *) SvRV(builds)) + 1;

    av = (AV *) SvRV(attrs);
    c->nattrs = (int) av_len(av) + 1;
    if (c->nattrs)
        Newxz(c->attrs, c->nattrs, cs_ctor_attr);

    for (i = 0; i < c->nattrs; i++) {
        SV **row = av_fetch(av, i, 0);
        AV *r;
        SV **f;
        cs_ctor_attr *a = &c->attrs[i];

        if (!row || !SvROK(*row) || SvTYPE(SvRV(*row)) != SVt_PVAV)
            croak("Catalyst::Seal::_install_ctor: attribute %d is not an array", i);
        r = (AV *) SvRV(*row);

        f = av_fetch(r, 0, 0);
        if (f && SvOK(*f)) {
            STRLEN kl;
            const char *kp;
            a->init_arg = newSVsv(*f);
            kp = SvPV_const(a->init_arg, kl);
            PERL_HASH(a->init_hash, kp, kl);
        }

        f = av_fetch(r, 1, 0);
        if (!f || !SvOK(*f))
            croak("Catalyst::Seal::_install_ctor: attribute %d has no slot", i);
        cs_key_init(aTHX_ &a->slot, *f);

        f = av_fetch(r, 2, 0);
        a->kind = f ? (int) SvIV(*f) : CS_D_NONE;

        f = av_fetch(r, 3, 0);
        a->dflt = (f && SvOK(*f)) ? newSVsv(*f) : NULL;
        if ((a->kind == CS_D_CONST || a->kind == CS_D_CODE) && !a->dflt)
            a->dflt = newSV(0);

        f = av_fetch(r, 4, 0);
        a->flags = f ? (int) SvIV(*f) : 0;

        f = av_fetch(r, 5, 0);
        if (f && SvOK(*f))
            a->check = newSVsv(*f);
        if ((a->flags & CS_A_TYPED) && !a->check)
            croak("Catalyst::Seal::_install_ctor: attribute %d is typed with no check", i);
    }

    cv = newXS(SvPV_nolen(fq), cs_constructor, __FILE__);
    CvXSUBANY(cv).any_ptr = c;
    c->cv = (CV *) SvREFCNT_inc((SV *) cv);
    SvREFCNT_dec(fq);

    mro_method_changed_in(stash);
    XSRETURN_YES;

# Catalyst::Action::execute and ::dispatch. `kind` is "execute" or "dispatch";
# the slot names come from the metaclass rather than from a literal here.
void
_install_action(pkg, name, kind, code_slot, instance_slot, class_slot, orig)
    SV *pkg
    SV *name
    SV *kind
    SV *code_slot
    SV *instance_slot
    SV *class_slot
    SV *orig
  PREINIT:
    cs_action *a;
    CV *cv;
    HV *stash;
    STRLEN plen, nlen;
    const char *pstr, *nstr, *kstr;
    SV *fq;
    int is_dispatch;
  PPCODE:
    if (!SvROK(orig) || SvTYPE(SvRV(orig)) != SVt_PVCV)
        croak("Catalyst::Seal::_install_action: orig must be a code reference");

    kstr = SvPV_nolen(kind);
    if (strEQ(kstr, "dispatch"))     is_dispatch = 1;
    else if (strEQ(kstr, "execute")) is_dispatch = 0;
    else croak("Catalyst::Seal::_install_action: unknown kind '%s'", kstr);

    pstr = SvPV_const(pkg, plen);
    nstr = SvPV_const(name, nlen);

    stash = gv_stashpvn(pstr, plen, GV_ADD);
    if (!stash)
        croak("Catalyst::Seal::_install_action: no stash for %" SVf, SVfARG(pkg));

    fq = newSVpvn(pstr, plen);
    sv_catpvs(fq, "::");
    sv_catpvn(fq, nstr, nlen);

    Newxz(a, 1, cs_action);
    cs_key_init(aTHX_ &a->code,     code_slot);
    cs_key_init(aTHX_ &a->instance, instance_slot);
    cs_key_init(aTHX_ &a->klass,    class_slot);
    a->method = newSVpvs("execute");
    a->orig   = newSVsv(orig);

    cv = newXS(SvPV_nolen(fq),
               is_dispatch ? cs_action_dispatch : cs_action_execute, __FILE__);
    CvXSUBANY(cv).any_ptr = a;
    a->cv = (CV *) SvREFCNT_inc((SV *) cv);
    SvREFCNT_dec(fq);

    mro_method_changed_in(stash);
    XSRETURN_YES;

#ifndef CS_SLOT_H
#define CS_SLOT_H 1

/* One sealed class data attribute.
 *
 * mk_classdata installs two methods per attribute, "$name" and
 * "_${name}_accessor", sharing one closure. Both are replaced by an XSUB, and
 * both XSUBs share one cs_slot, so a write through either one unseals both.
 * Two independent slots would leave the other returning the stale constant.
 *
 * Nothing here is freed. A slot lives for the life of the interpreter and
 * their number is bounded by the application's class data, which is fixed at
 * setup: seventy-two on a bare application. */

typedef struct {
    SV *value;      /* owned: the resolved value, undef included          */
    SV *orig;       /* owned: coderef of the accessor we shadowed         */
    SV *pkg;        /* owned: the sealed class name                       */
    SV *name;       /* owned: the attribute name, for messages            */
    SV *fq;         /* owned: "Pkg::name"                                 */
    SV *fq_alias;   /* owned: "Pkg::_name_accessor"                       */
    HV *stash;      /* owned: the sealed class's stash                    */
    CV *cv;         /* owned: our XSUB, kept alive across an unseal       */
    CV *cv_alias;   /* owned: likewise                                    */
    int unsealed;   /* set once a write has put the original back         */
} cs_slot;

/* A hash slot, named once and hashed once. */

typedef struct {
    SV *key;        /* owned: the slot name                               */
    U32 hash;       /* precomputed hash of key                            */
} cs_key;

/* One sealed attribute reader.
 *
 * Not a constant: the value is per instance. What is fixed at setup is the
 * shape, which slot the value lives in and which class the reader belongs to,
 * and that is all this needs to skip Moose's generated reader. */

typedef struct {
    SV *key;        /* owned: the hash slot name                          */
    U32 hash;       /* precomputed hash of key                            */
    SV *orig;       /* owned: coderef of the reader we shadowed           */
    SV *fq;         /* owned: "Pkg::name"                                 */
    HV *stash;      /* owned: the sealed class's stash                    */
    CV *cv;         /* owned: our XSUB                                    */
    int lazy;       /* a miss delegates instead of returning undef        */
    int rw;         /* a one-argument write stores, instead of delegating */
} cs_reader;

/* Catalyst::depth, which is the length of an array in a slot.
 *
 * Its own kind rather than a reader returning the array, because the stock
 * method is `scalar @{ shift->stack || [] }` and the count is what the nine
 * callers a request want. */

typedef struct {
    cs_key slot;
    SV *orig;       /* owned: coderef of the method we shadowed           */
    HV *stash;      /* owned: the sealed class's stash                    */
    CV *cv;         /* owned: our XSUB                                    */
} cs_count;

/* Catalyst::Action::execute and ::dispatch.
 *
 * Both exist only to reach something in a slot: the code reference for one,
 * the instance or the class for the other. Nine of each a request, and five
 * accessor frames between them, for two calls that are a hash fetch.
 *
 * There is deliberately no stash check on these two. Every action class in an
 * application is a Catalyst::Action subclass, and a subclass that did not
 * override the method is exactly who should reach this. An invocant with no
 * such slot delegates, so a wrong caller gets the stock error rather than a
 * wrong answer. */

/* One attribute, as a constructor has to think about it.
 *
 * Moose's inlined constructor asks a long list of questions of every attribute
 * on every construction, all of which were answered when the class was made
 * immutable. This is those answers.
 *
 * `guarded` is the escape hatch and the reason this is safe: an attribute the
 * XS path cannot honour in full - a type to check, a trigger to fire, a
 * coercion to run - is marked, and a construction that passes a value for one
 * goes to the stock constructor entire. What is left here is a store. */

#define CS_D_NONE   0   /* no default: the slot stays absent              */
#define CS_D_CONST  1   /* a value, copied in                             */
#define CS_D_HASH   2   /* default => sub { {} }: a fresh empty hash      */
#define CS_D_ARRAY  3   /* default => sub { [] }: a fresh empty array     */
#define CS_D_CODE   4   /* anything else: call it with the instance       */

#define CS_A_GUARDED  1 /* a passed value must take the long way          */
#define CS_A_REQUIRED 2 /* ... and so must its absence                    */
#define CS_A_WEAK     4 /* weaken the reference once stored               */
#define CS_A_TYPED    8 /* a passed value is checked first, and only a
                         * value that fails takes the long way            */

typedef struct {
    SV *init_arg;     /* owned: the constructor key, or NULL for none     */
    U32 init_hash;
    cs_key slot;
    int kind;
    SV *dflt;         /* owned: the constant or the code reference        */
    SV *check;        /* owned: the type constraint's own check           */
    int flags;
} cs_ctor_attr;

typedef struct {
    HV *stash;        /* owned: the class being constructed               */
    SV *class;        /* owned: its name, for the invocant check          */
    SV *orig;         /* owned: the constructor we shadowed               */
    SV *buildargs;    /* owned: a non-standard BUILDARGS, or NULL         */
    cs_ctor_attr *attrs;
    int nattrs;
    SV *builds;       /* owned: an array of BUILD bodies, in call order   */
    int nbuilds;
    CV *cv;           /* owned: our XSUB                                  */
    UV fast;          /* constructions answered here ...                  */
    UV slow;          /* ... and handed to the stock constructor          */
} cs_ctor;

typedef struct {
    cs_key code;      /* execute:  the action's body                      */
    cs_key instance;  /* dispatch: the controller instance, if any        */
    cs_key klass;     /* dispatch: ... and its class name if not          */
    SV *method;       /* owned: "execute", for the call on the context    */
    SV *orig;         /* owned: coderef of the method we shadowed         */
    CV *cv;           /* owned: our XSUB                                  */
} cs_action;

#endif

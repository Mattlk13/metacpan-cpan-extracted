#ifndef PFEED_REG_H
#define PFEED_REG_H

/* The boot-time devices `register` needs in C: reading options without letting
 * a typo through, and installing a keyword and a to_app callback through the
 * registrar's ordinary Perl surface.
 *
 * There is no other way in. Punk installs pk_abi.h and nothing else, and
 * pk_abi.h is an observer table with no install_kw, no route and no app_hv - so
 * every registration here is a method dispatch. Punk::Plugin::Queue and
 * Punk::Plugin::OpenTelemetry register from outside the distribution the same
 * way.
 *
 * Must be included after pfeed_clos.h.
 */

#define PFEED_WHO "Punk::Plugin::Feed"

/* ---- reading options ------------------------------------------------------ */

/* A comma-joined list of names, for a diagnostic that says what the caller
 * could have meant. Mortal. */
static SV *pfeed_name_list(pTHX_ const char *const *names)
{
    SV *out = sv_2mortal(newSVpvs(""));
    int i;
    for (i = 0; names[i]; i++) {
        if (i) sv_catpvs(out, ", ");
        sv_catpv(out, names[i]);
    }
    return out;
}

/* Every key of `opts` must be in `known`, or the option was misspelled - and a
 * misspelled option is a setting that silently did not apply. `subtitle` for
 * `description` would leave a feed with no description at all, and the first
 * report of it would come from a reader, not from the application. */
static void pfeed_check_opts(pTHX_ const char *noun, HV *opts,
                             const char *const *known)
{
    HE *he;
    if (!opts) return;
    hv_iterinit(opts);
    while ((he = hv_iternext(opts))) {
        STRLEN kl;
        const char *k = HePV(he, kl);
        int i, ok = 0;
        for (i = 0; known[i]; i++)
            if (strlen(known[i]) == kl && memEQ(known[i], k, kl)) { ok = 1; break; }
        if (!ok)
            croak("%s: unknown %s '%.*s' (known: %s)", PFEED_WHO, noun,
                  (int)kl, k, SvPV_nolen(pfeed_name_list(aTHX_ known)));
    }
}

/* ---- installing ----------------------------------------------------------- */

/* A keyword, owned by this plugin so a second install from the same owner is
 * the no-op Punk makes it - which is what lets `import` and `register` both
 * ask and only the first do anything. */
static void pfeed_keyword(pTHX_ SV *app, const char *name, XSUBADDR_t body,
                          AV *cap)
{
    SV *argv[3];
    argv[0] = sv_2mortal(newSVpv(name, 0));
    argv[1] = sv_2mortal(pfeed_closure(aTHX_ body, cap));
    argv[2] = sv_2mortal(newSVpvs(PFEED_WHO));
    SvREFCNT_dec(pfeed_call(aTHX_ app, "install_kw", argv, 3));
}

/* A GET route.
 *
 * `sitemap => 0` matters: Punk::Plugin::Sitemap lists every GET route with no
 * capture and no guard, and /feed.xml is one. A feed URL in a sitemap is a
 * crawler fetching XML it will not index, on a schedule, for as long as the
 * site exists.
 */
static void pfeed_route(pTHX_ SV *app, SV *path, XSUBADDR_t body, AV *cap)
{
    SV *argv[5];
    HV *o = newHV();
    (void)hv_stores(o, "sitemap", newSViv(0));
    argv[0] = sv_2mortal(newSVpvs("GET"));
    argv[1] = path;
    argv[2] = sv_2mortal(pfeed_closure(aTHX_ body, cap));
    argv[3] = &PL_sv_undef;
    argv[4] = sv_2mortal(newRV_noinc((SV *)o));
    SvREFCNT_dec(pfeed_call(aTHX_ app, "route", argv, 5));
}

static void pfeed_helper(pTHX_ SV *app, const char *name, XSUBADDR_t body,
                         AV *cap)
{
    SV *argv[2];
    argv[0] = sv_2mortal(newSVpv(name, 0));
    argv[1] = sv_2mortal(pfeed_closure(aTHX_ body, cap));
    SvREFCNT_dec(pfeed_call(aTHX_ app, "helper", argv, 2));
}

/* The to_app seam. on_compile runs once, in registration order, after every
 * keyword has recorded and before anything is compiled - which is the only
 * moment at which `host` has certainly been declared and the sections
 * certainly exist.
 *
 * No fallback for an older Punk: on_compile is 0.30 and this needs 0.43. The
 * `can` guard is kept anyway so the failure is a croak naming the version
 * rather than a method-not-found from inside a closure. */
static void pfeed_at_compile(pTHX_ SV *app, XSUBADDR_t body, AV *cap)
{
    SV *argv[2];
    if (!pfeed_can(aTHX_ app, "on_compile")) {
        SvREFCNT_dec((SV *)cap);
        croak("%s needs Punk 0.30 or newer for on_compile", PFEED_WHO);
    }
    argv[0] = sv_2mortal(pfeed_closure(aTHX_ body, cap));
    argv[1] = sv_2mortal(newSVpvs(PFEED_WHO));
    SvREFCNT_dec(pfeed_call(aTHX_ app, "on_compile", argv, 2));
}

#endif /* PFEED_REG_H */

MODULE = Punk::Feed    PACKAGE = Punk::Plugin::Feed

# The plugin object. Punk::Plugin's own new, so a plugin that carries no state
# costs one hash and nothing else.

SV *
new(class)
        SV *class
    CODE:
    {
        HV *self = newHV();
        const char *pkg = "Punk::Plugin::Feed";
        STRLEN pkgl = sizeof("Punk::Plugin::Feed") - 1;
        if (SvOK(class) && !SvROK(class)) pkg = SvPV(class, pkgl);
        RETVAL = sv_bless(newRV_noinc((SV *)self),
                          gv_stashpvn(pkg, (I32)pkgl, GV_ADD));
    }
    OUTPUT:
        RETVAL

# Installs the `feed` keyword at COMPILE time, which is the only moment that
# makes the bareword form parse:
#
#     feed news => sub { ... };
#
# `plugin 'Feed'` runs at RUNTIME of the package body, long after the statement
# above has been compiled, so a keyword installed only there is one perl has
# already refused to parse. Punk::Plugin::Queue and ::OpenTelemetry split it the
# same way and for the same reason.
#
# Silent in a package that is not a Punk application: `use Punk::Plugin::Feed`
# from a script has nothing to install onto and no reason to complain.

void
import(class, ...)
        SV *class
    CODE:
    {
        const char *pkg = CopSTASHPV(PL_curcop);
        SV *pkgsv, *appsv;
        PERL_UNUSED_VAR(class);
        PERL_UNUSED_VAR(items);
        if (!pkg) XSRETURN_EMPTY;
        pkgsv = sv_2mortal(newSVpv(pkg, 0));
        if (!pfeed_can(aTHX_ pkgsv, "punk_app")) XSRETURN_EMPTY;
        appsv = sv_2mortal(pfeed_call(aTHX_ pkgsv, "punk_app", NULL, 0));
        if (appsv && SvROK(appsv)) pfeed_install_kw(aTHX_ appsv);
        XSRETURN_EMPTY;
    }

# register($app, \%opts)

void
register(self, app, opts = &PL_sv_undef)
        SV *self
        SV *app
        SV *opts
    CODE:
    {
        HV *h = pfeed_app_hv(aTHX_ app);
        PERL_UNUSED_VAR(self);
        if (!h) croak("%s: register needs the Punk::App", PFEED_WHO);

        (void)hv_stores(h, "feed_opts",
                        newRV_noinc((SV *)pfeed_opts(aTHX_ app, opts)));

        /* again, for `plugin 'Feed'` without the `use`: the parenthesised
         * form of the keyword resolves at runtime and this is what it finds */
        pfeed_install_kw(aTHX_ app);

        {
            AV *cap = newAV();
            av_push(cap, newSVsv(app));
            pfeed_at_compile(aTHX_ app, pfeed_compile_cb, cap);
        }
        XSRETURN_EMPTY;
    }

# ---- private, for the tests -------------------------------------------------
#
# The document primitives, reachable so they can be tested for what they are
# rather than only through a rendered feed. An escaper is the one piece of this
# distribution where a single wrong byte invalidates everything downstream of
# it, and testing it through a whole document would report that as a mismatched
# feed rather than as a mis-escaped character.

SV *
_xml_escape(str)
        SV *str
    CODE:
    {
        RETVAL = newSVpvs("");
        pfeed_xml_sv(aTHX_ RETVAL, str);
    }
    OUTPUT:
        RETVAL

SV *
_pct_encode(str)
        SV *str
    CODE:
    {
        STRLEN l = 0;
        const char *p = SvOK(str) ? SvPV_const(str, l) : "";
        RETVAL = newSVpvs("");
        pfeed_pct_cat(aTHX_ RETVAL, p, l);
    }
    OUTPUT:
        RETVAL

SV *
_url(base, path)
        SV *base
        SV *path
    CODE:
    {
        RETVAL = newSVpvs("");
        pfeed_url_sv(aTHX_ RETVAL, base, path);
    }
    OUTPUT:
        RETVAL

SV *
_rfc3339(epoch)
        IV epoch
    CODE:
    {
        RETVAL = newSVpvs("");
        pfeed_rfc3339(aTHX_ RETVAL, epoch);
    }
    OUTPUT:
        RETVAL

SV *
_rfc822(epoch)
        IV epoch
    CODE:
    {
        RETVAL = newSVpvs("");
        pfeed_rfc822(aTHX_ RETVAL, epoch);
    }
    OUTPUT:
        RETVAL

# The parser, returning undef when the value is not a date - which is the
# distinction the record builder needs and epoch 0 would hide.

SV *
_epoch(value)
        SV *value
    CODE:
    {
        IV out = 0;
        RETVAL = pfeed_epoch_of(aTHX_ value, &out) ? newSViv(out) : newSV(0);
    }
    OUTPUT:
        RETVAL

# ---- private, reading back what boot recorded -------------------------------
#
# These mirror the accessors xs/sitemap.xs keeps for the same purpose.

SV *
_doc(app, name = &PL_sv_undef, fmt = "atom")
        SV *app
        SV *name
        const char *fmt
    CODE:
    {
        HV *h = pfeed_app_hv(aTHX_ app);
        SV *st = h ? pfeed_hget(aTHX_ h, "feed_docs") : NULL;
        SV *key = pfeed_doc_key(aTHX_ SvOK(name) ? name
                                     : sv_2mortal(newSVpvs("")), fmt);
        HE *he = pfeed_is_hash(st)
               ? hv_fetch_ent((HV *)SvRV(st), key, 0, 0) : NULL;
        RETVAL = he ? newSVsv(HeVAL(he)) : newSV(0);
    }
    OUTPUT:
        RETVAL

SV *
_etag(app, name = &PL_sv_undef, fmt = "atom")
        SV *app
        SV *name
        const char *fmt
    CODE:
    {
        HV *h = pfeed_app_hv(aTHX_ app);
        SV *st = h ? pfeed_hget(aTHX_ h, "feed_etags") : NULL;
        SV *key = pfeed_doc_key(aTHX_ SvOK(name) ? name
                                     : sv_2mortal(newSVpvs("")), fmt);
        HE *he = pfeed_is_hash(st)
               ? hv_fetch_ent((HV *)SvRV(st), key, 0, 0) : NULL;
        RETVAL = he ? newSVsv(HeVAL(he)) : newSV(0);
    }
    OUTPUT:
        RETVAL

SV *
_stamp(app, name = &PL_sv_undef)
        SV *app
        SV *name
    CODE:
    {
        HV *h = pfeed_app_hv(aTHX_ app);
        SV *st = h ? pfeed_hget(aTHX_ h, "feed_stamp") : NULL;
        SV *key = SvOK(name) ? name : sv_2mortal(newSVpvs(""));
        HE *he = pfeed_is_hash(st)
               ? hv_fetch_ent((HV *)SvRV(st), key, 0, 0) : NULL;
        RETVAL = he ? newSVsv(HeVAL(he)) : newSV(0);
    }
    OUTPUT:
        RETVAL

SV *
_base(app)
        SV *app
    CODE:
    {
        HV *h = pfeed_app_hv(aTHX_ app);
        SV *b = h ? pfeed_hget(aTHX_ h, "feed_base") : NULL;
        RETVAL = b ? newSVsv(b) : newSV(0);
    }
    OUTPUT:
        RETVAL

# The declared feed names, in declaration order.

SV *
_feeds(app)
        SV *app
    CODE:
    {
        HV *h = pfeed_app_hv(aTHX_ app);
        AV *out = newAV();
        if (h) {
            SV *l = pfeed_hget(aTHX_ h, "feed_list");
            if (pfeed_is_array(l)) {
                AV *list = (AV *)SvRV(l);
                SSize_t i, n = av_len(list) + 1;
                for (i = 0; i < n; i++) {
                    SV **e = av_fetch(list, i, 0);
                    if (e && *e && pfeed_is_array(*e))
                        av_push(out, newSVsv(*av_fetch((AV *)SvRV(*e), 0, 0)));
                }
            }
        }
        RETVAL = newRV_noinc((SV *)out);
    }
    OUTPUT:
        RETVAL

# One feed's records, back as hashrefs so a test can read them.

SV *
_entries(app, name = &PL_sv_undef)
        SV *app
        SV *name
    CODE:
    {
        HV *h = pfeed_app_hv(aTHX_ app);
        AV *out = newAV();
        SV *key = (SvOK(name)) ? name : sv_2mortal(newSVpvs(""));
        SV *st = h ? pfeed_hget(aTHX_ h, "feed_entries") : NULL;
        if (pfeed_is_hash(st)) {
            HE *he = hv_fetch_ent((HV *)SvRV(st), key, 0, 0);
            SV *v = he ? HeVAL(he) : NULL;
            if (pfeed_is_array(v)) {
                AV *recs = (AV *)SvRV(v);
                SSize_t i, n = av_len(recs) + 1;
                static const char *const names[PFE_MAX] = {
                    "loc", "title", "updated", "id", "published",
                    "summary", "content", "author", "category", "enclosure"
                };
                for (i = 0; i < n; i++) {
                    SV **e = av_fetch(recs, i, 0);
                    AV *rec;
                    HV *row;
                    int s;
                    if (!(e && *e && pfeed_is_array(*e))) continue;
                    rec = (AV *)SvRV(*e);
                    row = newHV();
                    for (s = 0; s < PFE_MAX; s++) {
                        SV **f = av_fetch(rec, s, 0);
                        if (f && *f && SvOK(*f))
                            (void)hv_store(row, names[s],
                                           (I32)strlen(names[s]),
                                           newSVsv(*f), 0);
                    }
                    av_push(out, newRV_noinc((SV *)row));
                }
            }
        }
        RETVAL = newRV_noinc((SV *)out);
    }
    OUTPUT:
        RETVAL

#ifndef PFEED_ENTRY_H
#define PFEED_ENTRY_H

/* Entries: what a section returned, checked and turned into records.
 *
 * A section is application code returning data that goes straight into a
 * structured document, so every field is checked on the way in.
 *
 * Must be included after pfeed_clos.h and pfeed_date.h.
 */

/* A record is an AV with fixed slots rather than a hash: it is written once
 * per build and read once per render, and a hash would pay for lookups nobody
 * makes. The two dates are epoch IVs, normalised here. */
enum { PFE_LOC = 0, PFE_TITLE, PFE_UPDATED, PFE_ID, PFE_PUBLISHED,
       PFE_SUMMARY, PFE_CONTENT, PFE_AUTHOR, PFE_CATEGORY, PFE_ENCLOSURE,
       PFE_MAX };

/* A section walking a table that grew is how this becomes an out-of-memory at
 * boot rather than a large feed. `limit` is the application's control and this
 * is the ceiling it cannot raise. */
#define PFEED_MAX_ENTRIES 5000

/* Is this a location this application may publish?
 *
 * Rooted, concrete, same-origin, and free of anything that would break out of
 * the element it lands in:
 *
 *   - it must start with '/', because the base supplies the origin;
 *   - it must NOT start with '//', which is protocol-relative and names
 *     another host - `//evil.example/x` in a feed is somebody else's pages
 *     published under your name, to subscribers who go on fetching it;
 *   - it must hold no ':' or '*', which means a section returned the route
 *     PATTERN by mistake and a literal `:id` would go in the document;
 *   - no control bytes and no backslash.
 *
 * Punk's $c->safe_path encodes the same rules for redirects and
 * Punk::Plugin::Sitemap's pks_loc_ok for sitemap URLs; the reasoning is
 * identical, and this is that function.
 */
static int pfeed_loc_ok(const char *p, STRLEN l)
{
    STRLEN i;
    if (!p || !l || p[0] != '/') return 0;
    if (l > 1 && p[1] == '/')    return 0;
    if (memchr(p, ':', l) || memchr(p, '*', l)) return 0;
    for (i = 0; i < l; i++) {
        unsigned char c = (unsigned char)p[i];
        if (c < 0x20 || c == 0x7F || c == '\\') return 0;
    }
    return 1;
}

/* A non-empty string field, copied, or NULL. */
static SV *pfeed_str(pTHX_ HV *h, const char *k)
{
    SV *v = pfeed_hget(aTHX_ h, k);
    if (!(v && SvOK(v))) return NULL;
    if (!SvCUR(v) && !SvROK(v)) {
        STRLEN l;
        (void)SvPV_const(v, l);
        if (!l) return NULL;
    }
    return newSVsv(v);
}

/* `category` is one string or an arrayref of them; either way an AV, or NULL
 * when there is nothing to say. */
static AV *pfeed_categories(pTHX_ HV *h)
{
    SV *v = pfeed_hget(aTHX_ h, "category");
    AV *out;
    if (!(v && SvOK(v))) return NULL;
    out = newAV();
    if (pfeed_is_array(v)) {
        AV *in = (AV *)SvRV(v);
        SSize_t i, n = av_len(in) + 1;
        for (i = 0; i < n; i++) {
            SV **e = av_fetch(in, i, 0);
            if (e && *e && SvOK(*e)) av_push(out, newSVsv(*e));
        }
    }
    else av_push(out, newSVsv(v));
    if (av_len(out) < 0) { SvREFCNT_dec((SV *)out); return NULL; }
    return out;
}

/* `enclosure` is { url => ..., type => ..., length => ... }. A url is the only
 * part either format can do anything with, so an enclosure without one is
 * dropped rather than emitted half-formed. */
static HV *pfeed_enclosure(pTHX_ SV *name, HV *h)
{
    SV *v = pfeed_hget(aTHX_ h, "enclosure");
    HV *in, *out;
    SV *url;
    if (!(v && SvOK(v))) return NULL;
    if (!pfeed_is_hash(v)) {
        warn("%s: feed '%" SVf "' returned an enclosure that is not a hashref; "
             "it is dropped", PFEED_WHO, SVfARG(name));
        return NULL;
    }
    in = (HV *)SvRV(v);
    url = pfeed_str(aTHX_ in, "url");
    if (!url) {
        warn("%s: feed '%" SVf "' returned an enclosure with no url; it is "
             "dropped", PFEED_WHO, SVfARG(name));
        return NULL;
    }
    out = newHV();
    (void)hv_stores(out, "url", url);
    { SV *t = pfeed_str(aTHX_ in, "type");   if (t) (void)hv_stores(out, "type", t); }
    { SV *n = pfeed_hget(aTHX_ in, "length");
      if (n && SvOK(n)) (void)hv_stores(out, "length", newSViv(SvIV(n))); }
    return out;
}

/* One returned element as a record, or NULL with a warning saying which feed
 * and which value.
 *
 * loc, title and updated are all required, and an entry missing any of them is
 * DROPPED. Atom makes all three mandatory and a reader rejects the whole
 * document over one bad element, so one unusable row must not be able to empty
 * the feed. Defaulting `updated` to the build time is the tempting repair and
 * it is worse: it tells every subscriber that every item changed on every
 * deploy.
 *
 * Fields this does not know about are ignored rather than refused - a section
 * mapping straight over database rows is the ordinary way to write one, and
 * the row carries columns a feed has no use for.
 */
static AV *pfeed_record(pTHX_ SV *name, SV *item, SV *base)
{
    HV *h;
    AV *rec;
    SV *loc, *title;
    IV updated, published;
    const char *lp;
    STRLEN ll;

    if (!pfeed_is_hash(item)) {
        warn("%s: feed '%" SVf "' returned an entry that is not a hashref; it "
             "is dropped", PFEED_WHO, SVfARG(name));
        return NULL;
    }
    h = (HV *)SvRV(item);

    loc = pfeed_str(aTHX_ h, "loc");
    if (!loc) {
        warn("%s: feed '%" SVf "' returned an entry with no loc; it is dropped",
             PFEED_WHO, SVfARG(name));
        return NULL;
    }

    /* An absolute URL on our own base is accepted, because an application that
     * already did the joining should not have to undo it. Anything else
     * absolute names another host. */
    if (base && SvOK(base) && SvCUR(base)) {
        STRLEN bl;
        const char *bp = SvPV_const(base, bl);
        const char *cp = SvPV_const(loc, ll);
        if (ll >= bl && memEQ(cp, bp, bl)) {
            SV *rel = newSVpvn(cp + bl, ll - bl);
            if (!SvCUR(rel)) sv_catpvs(rel, "/");
            SvREFCNT_dec(loc);
            loc = rel;
        }
    }

    lp = SvPV_const(loc, ll);
    if (!pfeed_loc_ok(lp, ll)) {
        warn("%s: feed '%" SVf "' returned a loc that is not a rooted, "
             "same-origin path and is dropped: '%" SVf "'",
             PFEED_WHO, SVfARG(name), SVfARG(loc));
        SvREFCNT_dec(loc);
        return NULL;
    }

    title = pfeed_str(aTHX_ h, "title");
    if (!title) {
        warn("%s: feed '%" SVf "' returned '%" SVf "' with no title; it is "
             "dropped", PFEED_WHO, SVfARG(name), SVfARG(loc));
        SvREFCNT_dec(loc);
        return NULL;
    }

    if (!pfeed_epoch_of(aTHX_ pfeed_hget(aTHX_ h, "updated"), &updated)) {
        warn("%s: feed '%" SVf "' returned '%" SVf "' with no usable updated "
             "date; it is dropped", PFEED_WHO, SVfARG(name), SVfARG(loc));
        SvREFCNT_dec(loc);
        SvREFCNT_dec(title);
        return NULL;
    }

    rec = newAV();
    av_extend(rec, PFE_MAX - 1);
    (void)av_store(rec, PFE_LOC, loc);
    (void)av_store(rec, PFE_TITLE, title);
    (void)av_store(rec, PFE_UPDATED, newSViv(updated));

    { SV *v = pfeed_str(aTHX_ h, "id");      if (v) (void)av_store(rec, PFE_ID, v); }
    { SV *v = pfeed_str(aTHX_ h, "summary"); if (v) (void)av_store(rec, PFE_SUMMARY, v); }
    { SV *v = pfeed_str(aTHX_ h, "content"); if (v) (void)av_store(rec, PFE_CONTENT, v); }
    { SV *v = pfeed_str(aTHX_ h, "author");  if (v) (void)av_store(rec, PFE_AUTHOR, v); }

    /* An unparseable `published` is dropped and the entry still goes in: a
     * missing publication date costs a reader nothing, and losing the item
     * would. */
    if (pfeed_epoch_of(aTHX_ pfeed_hget(aTHX_ h, "published"), &published))
        (void)av_store(rec, PFE_PUBLISHED, newSViv(published));

    { AV *c = pfeed_categories(aTHX_ h);
      if (c) (void)av_store(rec, PFE_CATEGORY, newRV_noinc((SV *)c)); }
    { HV *e = pfeed_enclosure(aTHX_ name, h);
      if (e) (void)av_store(rec, PFE_ENCLOSURE, newRV_noinc((SV *)e)); }

    return rec;
}

/* Newest first, and `loc` ascending when two entries share a date.
 *
 * The tiebreak is not tidiness. A database returning rows in its own order
 * would otherwise make every rebuild a different file, and a reader comparing
 * bytes would report changes that did not happen. */
static I32 pfeed_rec_cmp(pTHX_ SV * const a, SV * const b)
{
    AV *ra = (AV *)SvRV(a), *rb = (AV *)SvRV(b);
    SV **ua = av_fetch(ra, PFE_UPDATED, 0), **ub = av_fetch(rb, PFE_UPDATED, 0);
    IV va = (ua && *ua) ? SvIV(*ua) : 0;
    IV vb = (ub && *ub) ? SvIV(*ub) : 0;
    if (va != vb) return (va < vb) ? 1 : -1;     /* descending */
    return sv_cmp(*av_fetch(ra, PFE_LOC, 0), *av_fetch(rb, PFE_LOC, 0));
}

/* Run one section and collect its records, sorted and truncated.
 *
 * G_EVAL, because a section reads a database and a section that died must not
 * take the request with it. A failed section warns and contributes nothing,
 * which degrades the feed rather than the site.
 */
static AV *pfeed_section(pTHX_ SV *name, SV *code, SV *base, IV limit,
                         int *died)
{
    AV *out = newAV();
    AV *got;
    SSize_t i, n;
    int failed = 0;

    *died = 0;
    got = (AV *)sv_2mortal((SV *)pfeed_call_list(aTHX_ code, NULL, 0, &failed));
    if (failed) {
        warn("%s: feed '%" SVf "' died and contributes nothing: %" SVf,
             PFEED_WHO, SVfARG(name), SVfARG(ERRSV));
        *died = 1;
        return out;
    }

    n = av_len(got) + 1;
    for (i = 0; i < n; i++) {
        SV **e = av_fetch(got, i, 0);
        AV *rec;
        if (!(e && *e)) continue;
        if (av_len(out) + 1 >= PFEED_MAX_ENTRIES) {
            warn("%s: feed '%" SVf "' returned more than %d entries and is "
                 "truncated there", PFEED_WHO, SVfARG(name),
                 (int)PFEED_MAX_ENTRIES);
            break;
        }
        rec = pfeed_record(aTHX_ name, *e, base);
        if (rec) av_push(out, newRV_noinc((SV *)rec));
    }

    n = av_len(out) + 1;
    /* AvARRAY is NULL for an empty AV and sortsv asserts on it before it looks
     * at the count, so the guard is not just an optimisation. */
    if (n > 1) sortsv(AvARRAY(out), (STRLEN)n, pfeed_rec_cmp);
    if (limit > 0 && n > limit) av_fill(out, (SSize_t)limit - 1);

    return out;
}

#endif /* PFEED_ENTRY_H */

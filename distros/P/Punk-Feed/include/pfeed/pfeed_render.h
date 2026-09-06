#ifndef PFEED_RENDER_H
#define PFEED_RENDER_H

/* The two serialisers, over one record list.
 *
 * Both take the origin as an argument rather than reading feed_base, because
 * an application with a host allowlist renders the same entries against
 * whichever origin asked (phase 5) and only the URLs differ.
 *
 * Every value goes through pfeed_xml_cat and every URL through pfeed_url_cat,
 * without exception - including values the application "obviously" controls,
 * because the exception is where the ampersand gets in.
 *
 * Must be included after pfeed_xml.h, pfeed_date.h and pfeed_entry.h.
 */

#ifndef XS_VERSION
#define XS_VERSION "0"
#endif

#define PFEED_ATOM_NS  "http://www.w3.org/2005/Atom"
#define PFEED_HOMEPAGE "https://metacpan.org/pod/Punk::Feed"

/* An option a feed may restate for itself: its own value, else the plugin's,
 * else NULL. Borrowed. */
static SV *pfeed_opt_of(pTHX_ HV *opts, SV *over, const char *k)
{
    if (pfeed_is_hash(over)) {
        HV *o = (HV *)SvRV(over);
        SV *v = pfeed_hget(aTHX_ o, k);
        if (!v && strEQ(k, "description")) v = pfeed_hget(aTHX_ o, "subtitle");
        if (v) return v;
    }
    return pfeed_hget(aTHX_ opts, k);
}

/* The path this feed is served at: /feed.xml, or /feed/news.rss. */
static SV *pfeed_self_path(pTHX_ HV *opts, SV *name, const char *ext)
{
    SV *p = sv_2mortal(newSVsv(pfeed_hget(aTHX_ opts, "path")));
    if (name && SvOK(name) && SvCUR(name)) {
        sv_catpvs(p, "/");
        sv_catsv(p, name);
    }
    sv_catpvs(p, ".");
    sv_catpv(p, ext);
    return p;
}

/* The newest entry's date, which is what both formats' feed-level timestamp
 * has to be.
 *
 * NOT the build time. A rebuild that found nothing new must produce the same
 * bytes as the one before it, or every reader records a change on every TTL
 * and the feed looks like it churns.
 *
 * An empty feed has no entry to take a date from and falls back to the build
 * time. The asymmetry is deliberate: there is no better answer, and an empty
 * feed is a state an application is in for a few minutes at launch rather than
 * one it lives in. Entries are sorted newest first, so this is the first one.
 */
static IV pfeed_newest(pTHX_ AV *recs, IV fallback)
{
    SV **e = (recs && av_len(recs) >= 0) ? av_fetch(recs, 0, 0) : NULL;
    SV **u;
    if (!(e && *e && pfeed_is_array(*e))) return fallback;
    u = av_fetch((AV *)SvRV(*e), PFE_UPDATED, 0);
    return (u && *u) ? SvIV(*u) : fallback;
}

/* One record slot, or NULL. Borrowed. */
static SV *pfeed_rec(pTHX_ AV *rec, int slot)
{
    SV **e = av_fetch(rec, slot, 0);
    PERL_UNUSED_CONTEXT;
    return (e && *e && SvOK(*e)) ? *e : NULL;
}

/* <tag>escaped text</tag>, with indentation, skipped entirely when absent. */
static void pfeed_tag(pTHX_ SV *out, const char *ind, const char *tag, SV *val)
{
    if (!(val && SvOK(val))) return;
    sv_catpv(out, ind);
    sv_catpvs(out, "<"); sv_catpv(out, tag); sv_catpvs(out, ">");
    pfeed_xml_sv(aTHX_ out, val);
    sv_catpvs(out, "</"); sv_catpv(out, tag); sv_catpvs(out, ">\n");
}

/* ---- Atom 1.0 ------------------------------------------------------------- */

static void pfeed_atom_entry(pTHX_ SV *out, AV *rec, SV *base, SV *feed_author)
{
    SV *loc  = pfeed_rec(aTHX_ rec, PFE_LOC);
    SV *id   = pfeed_rec(aTHX_ rec, PFE_ID);
    SV *auth = pfeed_rec(aTHX_ rec, PFE_AUTHOR);
    SV *v;

    sv_catpvs(out, "  <entry>\n");

    /* <id> defaults to the absolute URL, which is right for most sites and
     * needs no configuration. What it costs is in the POD: a post whose URL
     * changes is a post every subscriber sees twice, and `id` is the escape
     * hatch for a site that renames things. */
    sv_catpvs(out, "    <id>");
    if (id) pfeed_xml_sv(aTHX_ out, id);
    else    pfeed_url_sv(aTHX_ out, base, loc);
    sv_catpvs(out, "</id>\n");

    pfeed_tag(aTHX_ out, "    ", "title", pfeed_rec(aTHX_ rec, PFE_TITLE));

    v = pfeed_rec(aTHX_ rec, PFE_UPDATED);
    sv_catpvs(out, "    <updated>");
    pfeed_rfc3339(aTHX_ out, v ? SvIV(v) : 0);
    sv_catpvs(out, "</updated>\n");

    if ((v = pfeed_rec(aTHX_ rec, PFE_PUBLISHED))) {
        sv_catpvs(out, "    <published>");
        pfeed_rfc3339(aTHX_ out, SvIV(v));
        sv_catpvs(out, "</published>\n");
    }

    sv_catpvs(out, "    <link rel=\"alternate\" type=\"text/html\" href=\"");
    pfeed_url_sv(aTHX_ out, base, loc);
    sv_catpvs(out, "\"/>\n");

    /* an entry author overrides the feed's, and the feed's is repeated when
     * the entry has none - Atom wants an author reachable for every entry */
    v = auth ? auth : feed_author;
    if (v) {
        sv_catpvs(out, "    <author><name>");
        pfeed_xml_sv(aTHX_ out, v);
        sv_catpvs(out, "</name></author>\n");
    }

    if ((v = pfeed_rec(aTHX_ rec, PFE_SUMMARY))) {
        sv_catpvs(out, "    <summary type=\"text\">");
        pfeed_xml_sv(aTHX_ out, v);
        sv_catpvs(out, "</summary>\n");
    }

    /* type="html" with the markup escaped, not type="xhtml": xhtml would
     * require the content to be well-formed XML, and one unbalanced <br> in an
     * application's post would invalidate the whole feed. */
    if ((v = pfeed_rec(aTHX_ rec, PFE_CONTENT))) {
        sv_catpvs(out, "    <content type=\"html\">");
        pfeed_xml_sv(aTHX_ out, v);
        sv_catpvs(out, "</content>\n");
    }

    if ((v = pfeed_rec(aTHX_ rec, PFE_CATEGORY)) && pfeed_is_array(v)) {
        AV *cs = (AV *)SvRV(v);
        SSize_t i, n = av_len(cs) + 1;
        for (i = 0; i < n; i++) {
            sv_catpvs(out, "    <category term=\"");
            pfeed_xml_sv(aTHX_ out, *av_fetch(cs, i, 0));
            sv_catpvs(out, "\"/>\n");
        }
    }

    if ((v = pfeed_rec(aTHX_ rec, PFE_ENCLOSURE)) && pfeed_is_hash(v)) {
        HV *en = (HV *)SvRV(v);
        SV *t = pfeed_hget(aTHX_ en, "type");
        SV *n = pfeed_hget(aTHX_ en, "length");
        sv_catpvs(out, "    <link rel=\"enclosure\"");
        if (t) { sv_catpvs(out, " type=\""); pfeed_xml_sv(aTHX_ out, t);
                 sv_catpvs(out, "\""); }
        if (n) { sv_catpvs(out, " length=\""); pfeed_xml_sv(aTHX_ out, n);
                 sv_catpvs(out, "\""); }
        sv_catpvs(out, " href=\"");
        pfeed_xml_sv(aTHX_ out, pfeed_hget(aTHX_ en, "url"));
        sv_catpvs(out, "\"/>\n");
    }

    sv_catpvs(out, "  </entry>\n");
}

static SV *pfeed_render_atom(pTHX_ HV *opts, SV *over, SV *name, AV *recs,
                             SV *base, IV built_at)
{
    SV *out = newSVpvs("");
    SV *self = pfeed_self_path(aTHX_ opts, name, "xml");
    SV *id     = pfeed_opt_of(aTHX_ opts, over, "id");
    SV *author = pfeed_opt_of(aTHX_ opts, over, "author");
    SV *desc   = pfeed_opt_of(aTHX_ opts, over, "description");
    SV *rights = pfeed_opt_of(aTHX_ opts, over, "copyright");
    SSize_t i, n = recs ? av_len(recs) + 1 : 0;

    SvGROW(out, 1024 + (STRLEN)n * 512);

    sv_catpvs(out, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
    sv_catpvs(out, "<feed xmlns=\"" PFEED_ATOM_NS "\">\n");

    sv_catpvs(out, "  <id>");
    if (id) pfeed_xml_sv(aTHX_ out, id);
    else    pfeed_url_sv(aTHX_ out, base, self);
    sv_catpvs(out, "</id>\n");

    pfeed_tag(aTHX_ out, "  ", "title", pfeed_opt_of(aTHX_ opts, over, "title"));

    sv_catpvs(out, "  <updated>");
    pfeed_rfc3339(aTHX_ out, pfeed_newest(aTHX_ recs, built_at));
    sv_catpvs(out, "</updated>\n");

    sv_catpvs(out, "  <link rel=\"self\" type=\"application/atom+xml\" href=\"");
    pfeed_url_sv(aTHX_ out, base, self);
    sv_catpvs(out, "\"/>\n");

    sv_catpvs(out, "  <link rel=\"alternate\" type=\"text/html\" href=\"");
    pfeed_url_sv(aTHX_ out, base, pfeed_opt_of(aTHX_ opts, over, "link"));
    sv_catpvs(out, "\"/>\n");

    if (author) {
        sv_catpvs(out, "  <author><name>");
        pfeed_xml_sv(aTHX_ out, author);
        sv_catpvs(out, "</name></author>\n");
    }
    pfeed_tag(aTHX_ out, "  ", "subtitle", desc);
    pfeed_tag(aTHX_ out, "  ", "rights", rights);

    sv_catpvs(out, "  <generator uri=\"" PFEED_HOMEPAGE "\" version=\""
                   XS_VERSION "\">Punk::Feed</generator>\n");

    for (i = 0; i < n; i++) {
        SV **e = av_fetch(recs, i, 0);
        if (e && *e && pfeed_is_array(*e))
            pfeed_atom_entry(aTHX_ out, (AV *)SvRV(*e), base, author);
    }

    sv_catpvs(out, "</feed>\n");
    return out;
}

/* ---- RSS 2.0 -------------------------------------------------------------- */

static void pfeed_rss_item(pTHX_ SV *out, AV *rec, SV *base)
{
    SV *loc = pfeed_rec(aTHX_ rec, PFE_LOC);
    SV *id  = pfeed_rec(aTHX_ rec, PFE_ID);
    SV *v;

    sv_catpvs(out, "    <item>\n");
    pfeed_tag(aTHX_ out, "      ", "title", pfeed_rec(aTHX_ rec, PFE_TITLE));

    sv_catpvs(out, "      <link>");
    pfeed_url_sv(aTHX_ out, base, loc);
    sv_catpvs(out, "</link>\n");

    /* isPermaLink says whether a reader may fetch the guid. It is the item's
     * URL by default and therefore fetchable; a supplied id is a tag: URI or
     * similar and is not. */
    sv_catpvs(out, "      <guid isPermaLink=\"");
    sv_catpv(out, id ? "false" : "true");
    sv_catpvs(out, "\">");
    if (id) pfeed_xml_sv(aTHX_ out, id);
    else    pfeed_url_sv(aTHX_ out, base, loc);
    sv_catpvs(out, "</guid>\n");

    /* RSS has one date element and no way to express both, so publication
     * wins where there is one. */
    v = pfeed_rec(aTHX_ rec, PFE_PUBLISHED);
    if (!v) v = pfeed_rec(aTHX_ rec, PFE_UPDATED);
    sv_catpvs(out, "      <pubDate>");
    pfeed_rfc822(aTHX_ out, v ? SvIV(v) : 0);
    sv_catpvs(out, "</pubDate>\n");

    /* RSS core has no content element - content:encoded is a module this
     * version does not implement - so a summary is preferred and content
     * stands in when there is none. */
    v = pfeed_rec(aTHX_ rec, PFE_SUMMARY);
    if (!v) v = pfeed_rec(aTHX_ rec, PFE_CONTENT);
    pfeed_tag(aTHX_ out, "      ", "description", v);

    /* RSS specifies <author> as an email address. Emitting a name there is
     * near-universal practice and every reader accepts it; emitting the
     * user's email would publish it. */
    pfeed_tag(aTHX_ out, "      ", "author", pfeed_rec(aTHX_ rec, PFE_AUTHOR));

    if ((v = pfeed_rec(aTHX_ rec, PFE_CATEGORY)) && pfeed_is_array(v)) {
        AV *cs = (AV *)SvRV(v);
        SSize_t i, n = av_len(cs) + 1;
        for (i = 0; i < n; i++)
            pfeed_tag(aTHX_ out, "      ", "category", *av_fetch(cs, i, 0));
    }

    if ((v = pfeed_rec(aTHX_ rec, PFE_ENCLOSURE)) && pfeed_is_hash(v)) {
        HV *en = (HV *)SvRV(v);
        SV *t = pfeed_hget(aTHX_ en, "type");
        SV *n = pfeed_hget(aTHX_ en, "length");
        sv_catpvs(out, "      <enclosure url=\"");
        pfeed_xml_sv(aTHX_ out, pfeed_hget(aTHX_ en, "url"));
        sv_catpvs(out, "\"");
        if (t) { sv_catpvs(out, " type=\""); pfeed_xml_sv(aTHX_ out, t);
                 sv_catpvs(out, "\""); }
        if (n) { sv_catpvs(out, " length=\""); pfeed_xml_sv(aTHX_ out, n);
                 sv_catpvs(out, "\""); }
        sv_catpvs(out, "/>\n");
    }

    sv_catpvs(out, "    </item>\n");
}

static SV *pfeed_render_rss(pTHX_ HV *opts, SV *over, SV *name, AV *recs,
                            SV *base, IV built_at)
{
    SV *out  = newSVpvs("");
    SV *self = pfeed_self_path(aTHX_ opts, name, "rss");
    SV *title = pfeed_opt_of(aTHX_ opts, over, "title");
    SV *desc  = pfeed_opt_of(aTHX_ opts, over, "description");
    SSize_t i, n = recs ? av_len(recs) + 1 : 0;

    SvGROW(out, 1024 + (STRLEN)n * 512);

    sv_catpvs(out, "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
    sv_catpvs(out, "<rss version=\"2.0\" xmlns:atom=\"" PFEED_ATOM_NS "\">\n");
    sv_catpvs(out, "  <channel>\n");

    pfeed_tag(aTHX_ out, "    ", "title", title);

    sv_catpvs(out, "    <link>");
    pfeed_url_sv(aTHX_ out, base, pfeed_opt_of(aTHX_ opts, over, "link"));
    sv_catpvs(out, "</link>\n");

    /* <description> is required on the channel, so it falls back to the title
     * rather than being left out - an invalid channel is worse than a
     * repetition. */
    pfeed_tag(aTHX_ out, "    ", "description", desc ? desc : title);

    pfeed_tag(aTHX_ out, "    ", "language",
              pfeed_opt_of(aTHX_ opts, over, "language"));
    pfeed_tag(aTHX_ out, "    ", "copyright",
              pfeed_opt_of(aTHX_ opts, over, "copyright"));

    /* the newest item's date, NOT now - the element's name invites `now` and
     * that is what makes every rebuild look like a change */
    sv_catpvs(out, "    <lastBuildDate>");
    pfeed_rfc822(aTHX_ out, pfeed_newest(aTHX_ recs, built_at));
    sv_catpvs(out, "</lastBuildDate>\n");

    sv_catpvs(out, "    <generator>Punk::Feed " XS_VERSION "</generator>\n");

    sv_catpvs(out, "    <atom:link rel=\"self\" type=\"application/rss+xml\""
                   " href=\"");
    pfeed_url_sv(aTHX_ out, base, self);
    sv_catpvs(out, "\"/>\n");

    for (i = 0; i < n; i++) {
        SV **e = av_fetch(recs, i, 0);
        if (e && *e && pfeed_is_array(*e))
            pfeed_rss_item(aTHX_ out, (AV *)SvRV(*e), base);
    }

    sv_catpvs(out, "  </channel>\n");
    sv_catpvs(out, "</rss>\n");
    return out;
}

/* ---- the validator -------------------------------------------------------
 *
 * An ETag over the rendered bytes. This is a validator and not a digest -
 * nothing authenticates it - so FNV-1a over the document plus its length is
 * enough, and it stays in 32-bit arithmetic so a 32-bit IV perl computes the
 * same tag as a 64-bit one. Two feeds that differ must differ here; that is
 * the whole requirement.
 */
static U32 pfeed_fnv32(const char *p, STRLEN l)
{
    U32 h = 2166136261UL;
    STRLEN i;
    for (i = 0; i < l; i++) {
        h ^= (U32)(unsigned char)p[i];
        h *= 16777619UL;
    }
    return h;
}

static SV *pfeed_etag(pTHX_ SV *doc)
{
    STRLEN l;
    const char *p = SvPV_const(doc, l);
    char buf[48];
    my_snprintf(buf, sizeof(buf), "\"%lx-%08lx\"",
                (unsigned long)l, (unsigned long)pfeed_fnv32(p, l));
    return newSVpv(buf, 0);
}

#endif /* PFEED_RENDER_H */

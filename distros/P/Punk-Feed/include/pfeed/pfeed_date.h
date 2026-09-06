#ifndef PFEED_DATE_H
#define PFEED_DATE_H

/* Dates, in and out.
 *
 * An application's rows carry whatever its database hands back - an epoch from
 * one column type, an ISO-8601 string from another, a bare date from a third -
 * and both feed formats want something else again. So a date is normalised to
 * an epoch IV at the point the record is built, once, and the two formatters
 * render from that.
 *
 * Sorting is the reason it cannot wait until render time: entries are ordered
 * newest first, and comparing strings of mixed formats orders them wrongly and
 * silently.
 *
 * Everything here is UTC. An offset in the input is honoured and folded away;
 * nothing reads the process timezone, because a feed's dates must not change
 * when the server moves.
 */

/* Days since 1970-01-01 for a proleptic Gregorian y-m-d. Howard Hinnant's
 * days_from_civil: integer arithmetic only, so it is exact either side of the
 * epoch and needs no libc.
 *
 * timegm() is not portable and mktime() is local time, which would put every
 * timestamp out by the server's offset - the bug that only shows up when the
 * box is not on UTC. */
static IV pfeed_days_from_civil(IV y, IV m, IV d)
{
    IV era, yoe, doy, doe;
    y -= (m <= 2);
    era = (y >= 0 ? y : y - 399) / 400;
    yoe = y - era * 400;                              /* [0, 399] */
    doy = (153 * (m + (m > 2 ? -3 : 9)) + 2) / 5 + d - 1;
    doe = yoe * 365 + yoe / 4 - yoe / 100 + doy;      /* [0, 146096] */
    return era * 146097 + doe - 719468;
}

static int pfeed_digits(const char *p, STRLEN n)
{
    STRLEN i;
    for (i = 0; i < n; i++) if (!isDIGIT(p[i])) return 0;
    return 1;
}

static IV pfeed_num(const char *p, STRLEN n)
{
    IV v = 0;
    STRLEN i;
    for (i = 0; i < n; i++) v = v * 10 + (p[i] - '0');
    return v;
}

/* Normalise one date to an epoch. Returns 1 and fills *out, or returns 0 and
 * leaves it alone.
 *
 * The result is reported separately from the value because epoch 0 is a real
 * date. A function returning 0 for "no" would drop every entry stamped
 * 1970-01-01, which is exactly what a column defaulting to zero holds.
 *
 * Accepted, in this order:
 *   an integer                      taken as an epoch
 *   YYYY-MM-DD                      midnight UTC
 *   YYYY-MM-DDThh:mm:ss             with an optional .fraction, and an
 *                                   optional Z or +hh:mm / -hh:mm offset
 * A space in place of the T is accepted too, because that is what most
 * databases return.
 */
static int pfeed_epoch_of(pTHX_ SV *sv, IV *out)
{
    const char *p;
    STRLEN l, i;
    IV y, mo, d, hh = 0, mi = 0, ss = 0, off = 0;

    if (!(sv && SvOK(sv))) return 0;

    /* An IV or NV that has never been a string is an epoch. Asked before
     * SvPV, which would make it one. */
    if (!SvPOK(sv) && (SvIOK(sv) || SvNOK(sv))) { *out = SvIV(sv); return 1; }

    p = SvPV_const(sv, l);
    if (!l) return 0;

    {   /* a string of digits, with an optional sign, is also an epoch */
        STRLEN s = (p[0] == '-' || p[0] == '+') ? 1 : 0;
        if (l > s && pfeed_digits(p + s, l - s)) {
            IV v = pfeed_num(p + s, l - s);
            *out = (p[0] == '-') ? -v : v;
            return 1;
        }
    }

    if (l < 10) return 0;
    if (!(pfeed_digits(p, 4) && p[4] == '-' && pfeed_digits(p + 5, 2)
          && p[7] == '-' && pfeed_digits(p + 8, 2))) return 0;
    y  = pfeed_num(p, 4);
    mo = pfeed_num(p + 5, 2);
    d  = pfeed_num(p + 8, 2);
    if (mo < 1 || mo > 12 || d < 1 || d > 31) return 0;

    if (l > 10) {
        if (!(p[10] == 'T' || p[10] == 't' || p[10] == ' ')) return 0;
        if (l < 19) return 0;
        if (!(pfeed_digits(p + 11, 2) && p[13] == ':' && pfeed_digits(p + 14, 2)
              && p[16] == ':' && pfeed_digits(p + 17, 2))) return 0;
        hh = pfeed_num(p + 11, 2);
        mi = pfeed_num(p + 14, 2);
        ss = pfeed_num(p + 17, 2);
        /* 60 is a leap second; it belongs to the minute it ends */
        if (hh > 23 || mi > 59 || ss > 60) return 0;
        if (ss == 60) ss = 59;

        i = 19;
        if (i < l && p[i] == '.') {           /* a fraction we do not keep */
            STRLEN s = ++i;
            while (i < l && isDIGIT(p[i])) i++;
            if (i == s) return 0;
        }
        if (i < l) {
            if (p[i] == 'Z' || p[i] == 'z') { i++; }
            else if (p[i] == '+' || p[i] == '-') {
                int neg = (p[i] == '-');
                STRLEN rest = l - (i + 1);
                IV oh, om;
                if (rest == 5 && pfeed_digits(p + i + 1, 2) && p[i + 3] == ':'
                    && pfeed_digits(p + i + 4, 2)) {
                    oh = pfeed_num(p + i + 1, 2);
                    om = pfeed_num(p + i + 4, 2);
                }
                else if (rest == 4 && pfeed_digits(p + i + 1, 4)) {
                    oh = pfeed_num(p + i + 1, 2);
                    om = pfeed_num(p + i + 3, 2);
                }
                else return 0;
                if (oh > 23 || om > 59) return 0;
                /* the offset is what the local clock is AHEAD of UTC, so it
                 * comes back off to get there */
                off = (neg ? -1 : 1) * (oh * 3600 + om * 60);
                i = l;
            }
            else return 0;
            if (i != l) return 0;
        }
    }

    *out = pfeed_days_from_civil(y, mo, d) * (IV)86400
         + hh * 3600 + mi * 60 + ss - off;
    return 1;
}

/* ---- dates, on the way out ------------------------------------------------
 *
 * Atom takes RFC 3339 and RSS takes RFC 822, and neither goes through libc.
 *
 * NOT gmtime: on a 32-bit time_t it cannot represent a post dated past 2038 or
 * before 1901, and this arithmetic is exact either side of both. The inverse
 * of pfeed_days_from_civil is already half of it.
 *
 * NOT strftime, for RFC 822 above all: the month and day names are fixed in
 * English by the specification, and strftime gives them in the process locale.
 * A server whose locale is Turkish would emit "Cum, 05 Eyl", which is a date
 * no reader parses - and it would do it only on that server.
 */

/* The inverse of pfeed_days_from_civil. */
static void pfeed_civil_from_days(IV z, IV *y, IV *m, IV *d)
{
    IV era, doe, yoe, doy, mp;
    z += 719468;
    era = (z >= 0 ? z : z - 146096) / 146097;
    doe = z - era * 146097;                                   /* [0, 146096] */
    yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365;   /* [0, 399] */
    doy = doe - (365 * yoe + yoe / 4 - yoe / 100);             /* [0, 365] */
    mp  = (5 * doy + 2) / 153;                                /* [0, 11]  */
    *d  = doy - (153 * mp + 2) / 5 + 1;                       /* [1, 31]  */
    *m  = mp + (mp < 10 ? 3 : -9);                            /* [1, 12]  */
    *y  = yoe + era * 400 + (*m <= 2);
}

/* Split an epoch into a civil date, a time, and a weekday.
 *
 * The division is floored rather than truncated, which C's / is not for
 * negative operands: -1 / 86400 is 0 and the day before the epoch would come
 * out as the day after it. */
static void pfeed_break(IV epoch, IV *y, IV *mo, IV *d,
                        IV *hh, IV *mi, IV *ss, IV *wd)
{
    IV days = epoch / 86400;
    IV secs = epoch % 86400;
    if (secs < 0) { secs += 86400; days -= 1; }
    pfeed_civil_from_days(days, y, mo, d);
    *hh = secs / 3600;
    *mi = (secs / 60) % 60;
    *ss = secs % 60;
    /* 1970-01-01 was a Thursday, so day 0 is weekday 4 counting from Sunday */
    *wd = (days + 4) % 7;
    if (*wd < 0) *wd += 7;
}

/* 2026-09-05T14:03:00Z - Atom's <updated> and <published>. Always Z: the
 * instant is the same either way and a reader comparing two feeds should not
 * have to normalise offsets first. */
static void pfeed_rfc3339(pTHX_ SV *out, IV epoch)
{
    IV y, mo, d, hh, mi, ss, wd;
    char buf[64];
    pfeed_break(epoch, &y, &mo, &d, &hh, &mi, &ss, &wd);
    my_snprintf(buf, sizeof(buf),
                "%04" IVdf "-%02" IVdf "-%02" IVdf
                "T%02" IVdf ":%02" IVdf ":%02" IVdf "Z",
                y, mo, d, hh, mi, ss);
    sv_catpv(out, buf);
}

/* The names both RFC 822 and the HTTP date fix in English. One table, because
 * two would be two things to keep in step. */
static const char *const PFEED_DOW[7] =
    { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" };
static const char *const PFEED_MON[12] =
    { "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };

/* Fri, 05 Sep 2026 14:03:00 +0000 - RSS's <pubDate> and <lastBuildDate>. */
static void pfeed_rfc822(pTHX_ SV *out, IV epoch)
{
    IV y, mo, d, hh, mi, ss, wd;
    char buf[64];
    pfeed_break(epoch, &y, &mo, &d, &hh, &mi, &ss, &wd);
    my_snprintf(buf, sizeof(buf),
                "%s, %02" IVdf " %s %04" IVdf
                " %02" IVdf ":%02" IVdf ":%02" IVdf " +0000",
                PFEED_DOW[wd], d, PFEED_MON[mo - 1], y, hh, mi, ss);
    sv_catpv(out, buf);
}

/* ---- HTTP dates ----------------------------------------------------------
 *
 * Sun, 06 Nov 1994 08:49:37 GMT - the IMF-fixdate of RFC 9110, which is what
 * Last-Modified sends and If-Modified-Since carries back. Same shape as RFC
 * 822 but with "GMT" where RSS wants "+0000", and no, they are not
 * interchangeable: a reader parsing an HTTP date strictly will reject
 * "+0000".
 */

static void pfeed_http_date(pTHX_ SV *out, IV epoch)
{
    IV y, mo, d, hh, mi, ss, wd;
    char buf[64];
    pfeed_break(epoch, &y, &mo, &d, &hh, &mi, &ss, &wd);
    my_snprintf(buf, sizeof(buf),
                "%s, %02" IVdf " %s %04" IVdf
                " %02" IVdf ":%02" IVdf ":%02" IVdf " GMT",
                PFEED_DOW[wd], d, PFEED_MON[mo - 1], y, hh, mi, ss);
    sv_catpv(out, buf);
}

/* Parse an If-Modified-Since. Returns 1 and fills *out, or 0.
 *
 * Only IMF-fixdate is accepted. The two obsolete formats RFC 9110 still lists
 * - RFC 850 and asctime - are not worth the parser: nothing has sent them in
 * twenty years, and the cost of not understanding one is a 200 where a 304
 * would have done, which is correct behaviour and merely less efficient.
 * Guessing wrong about a date, by contrast, serves a 304 for a document the
 * client does not have.
 */
static int pfeed_parse_http_date(pTHX_ SV *sv, IV *out)
{
    const char *p;
    STRLEN l;
    IV d, y, hh, mi, ss;
    int m;

    if (!(sv && SvOK(sv))) return 0;
    p = SvPV_const(sv, l);
    /* "Ddd, DD Mmm YYYY HH:MM:SS GMT" is 29 characters */
    if (l < 29) return 0;
    if (p[3] != ',' || p[4] != ' ') return 0;
    if (!(pfeed_digits(p + 5, 2) && p[7] == ' ')) return 0;
    if (!(p[11] == ' ' && pfeed_digits(p + 12, 4) && p[16] == ' ')) return 0;
    if (!(pfeed_digits(p + 17, 2) && p[19] == ':' && pfeed_digits(p + 20, 2)
          && p[22] == ':' && pfeed_digits(p + 23, 2))) return 0;

    for (m = 0; m < 12; m++)
        if (memEQ(p + 8, PFEED_MON[m], 3)) break;
    if (m == 12) return 0;

    d  = pfeed_num(p + 5, 2);
    y  = pfeed_num(p + 12, 4);
    hh = pfeed_num(p + 17, 2);
    mi = pfeed_num(p + 20, 2);
    ss = pfeed_num(p + 23, 2);
    if (d < 1 || d > 31 || hh > 23 || mi > 59 || ss > 60) return 0;
    if (ss == 60) ss = 59;

    /* The day name is not checked against the date. A client that disagrees
     * with itself about the weekday still named an instant, and refusing it
     * would turn a harmless inconsistency into a full re-send. */
    *out = pfeed_days_from_civil(y, m + 1, d) * (IV)86400
         + hh * 3600 + mi * 60 + ss;
    return 1;
}

#endif /* PFEED_DATE_H */

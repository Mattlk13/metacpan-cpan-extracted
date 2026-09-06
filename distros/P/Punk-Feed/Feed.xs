/*
 * Feed.xs - root XS file
 *
 * Thin wrapper: the perl headers and the shims the 5.10 floor costs, then the
 * C implementation headers from include/pfeed/ in dependency order, then the
 * per-module XS fragments from xs/ via INCLUDE: (the Punk / Chandra layout).
 *
 * This distribution reaches Punk through its ordinary Perl surface. Punk
 * installs pk_abi.h and nothing else; everything under Punk/include/punk/ is
 * static and private, so there is no Sitemap C to call and the registrar is
 * reached by method dispatch. See include/pfeed/pfeed_reg.h.
 */

#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <time.h>

/* The implementation headers, in dependency order. Each states its contract at
 * the top and names what must precede it. */

#include "pfeed/pfeed_compat.h"  /* what the 5.10 floor costs; must be first */
#include "pfeed/pfeed_clos.h"    /* closures, calls into Perl, predicates    */
#include "pfeed/pfeed_reg.h"     /* options, install_kw, on_compile          */
#include "pfeed/pfeed_xml.h"     /* escape, percent-encode, URL join         */
#include "pfeed/pfeed_date.h"    /* dates in and out (needs nothing)         */
#include "pfeed/pfeed_entry.h"   /* records: normalise, validate, sort, cap  */
#include "pfeed/pfeed_render.h"  /* the two serialisers and the ETag         */
#include "pfeed/pfeed_boot.h"    /* options, origin, the keyword, the build  */

/* Still to land: the serve bodies, which go beside pfeed_boot.h's build (05) */

MODULE = Punk::Feed    PACKAGE = Punk::Plugin::Feed

PROTOTYPES: DISABLE

BOOT:
    /* nothing to resolve: this distribution reaches Punk through its
     * ordinary Perl surface, not through a C ABI table. */
    ;

INCLUDE: xs/feed.xs

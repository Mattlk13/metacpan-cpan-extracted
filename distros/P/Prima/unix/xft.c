/*********************************/
/*                               */
/*  Xft - client-side X11 fonts  */
/*                               */
/*********************************/


/*

USAGE
-----
To use specific Xft fonts, set Prima font names in your X resource
database in fontconfig formats - for example, Palatino-12. Consult
'man fontconfig' for the syntax, but be aware that Prima uses only
size, weight, and name fields.

IMPLEMENTATION NOTES
--------------------

This implementations doesn't work with non-scalable Xft fonts,
since their rasterization capabilities are currently ( June 2003) very limited -
no scaling and no rotation. Plus, the selection of the non-scalable fonts is
a one big something, and I believe that one in apc_font.c is enough.

The following Xft/fontconfig problems, if fixed in th next versions, need to be
taken into the consideration:
- no font/glyph data - internal leading, underscore size/position,
	no strikeout size/position, average width.
- no raster operations
- no glyph reference point shift
- no client-side access to glyph bitmaps
- no on-the-fly antialiasing toggle
- no text background painting ( only rectangles )
- no text strikeout / underline drawing routines
- produces xlib failures for large polygons - answered to be a Xrender bug;
	the X error handler catches this now.

TO DO
-----
- The full set of raster operations - not supported by xft ( stupid )
- apc_show_message - probably never will be implemented though
- Investigate if ICONV can be replaced by native perl's ENCODE interface
- Under some circumstances Xft decides to put antialiasing aside, for
	example, on the paletted displays. Check, if some heuristics that would
	govern whether Xft is to be used there, are needed.

*/

#include "unix/guts.h"

#ifdef USE_XFT

#ifdef HAVE_ICONV_H
#include <iconv.h>
#endif

/* fontconfig version < 2.2.0 */
#ifndef FC_WEIGHT_NORMAL
#define FC_WEIGHT_NORMAL 80
#endif
#ifndef FC_WEIGHT_THIN
#define FC_WEIGHT_THIN 0
#endif
#ifndef FC_WIDTH
#define FC_WIDTH "width"
#endif

static int xft_debug_indent = 0;
#define XFTdebug if (pguts->debug & DEBUG_FONTS) xft_debug

typedef struct {
	char      *name;
	FcCharSet *fcs;
	int        glyphs;
	Bool       enabled;
	uint32_t   map[128];   /* maps characters 128-255 into unicode */
} CharSetInfo;

static CharSetInfo std_charsets[] = {
	{ "iso8859-1",  NULL, 0, 1 }
#ifdef HAVE_ICONV_H
	,
	{ "iso8859-2",  NULL, 0, 0 },
	{ "iso8859-3",  NULL, 0, 0 },
	{ "iso8859-4",  NULL, 0, 0 },
	{ "iso8859-5",  NULL, 0, 0 },
	{ "iso8859-7",  NULL, 0, 0 },
	{ "iso8859-8",  NULL, 0, 0 },
	{ "iso8859-9",  NULL, 0, 0 },
	{ "iso8859-10", NULL, 0, 0 },
	{ "iso8859-13", NULL, 0, 0 },
	{ "iso8859-14", NULL, 0, 0 },
	{ "iso8859-15", NULL, 0, 0 },
	{ "koi8-r",     NULL, 0, 0 }  /* this is special - change the constant
					KOI8_INDEX as well when updating
					the table */
/* You are welcome to add more 8-bit charsets here - just keep in mind
	that each encoding requires iconv() to load a file */
#endif
};

static CharSetInfo fontspecific_charset = { "fontspecific", NULL, 0, 1 };
static CharSetInfo utf8_charset         = { "iso10646-1",   NULL, 0, 1 };

#define KOI8_INDEX 12
#define MAX_CHARSET (sizeof(std_charsets)/sizeof(CharSetInfo))
#define STD_CHARSETS MAX_CHARSET
#define EXTRA_CHARSETS 1
#define ALL_CHARSETS (STD_CHARSETS+EXTRA_CHARSETS)
#define MAX_GLYPH_SIZE (guts.limits.request_length / 256)

static PHash encodings    = NULL;
static PHash mono_fonts   = NULL; /* family->mono font mapping */
static PHash prop_fonts   = NULL; /* family->proportional font mapping */
static PHash mismatch     = NULL; /* fonts not present in xft base */
static PHash myfont_cache = NULL; /* fonts loaded temporarily */
static char  fontspecific[] = "fontspecific";
static char  utf8_encoding[] = "iso10646-1";
static CharSetInfo * locale = NULL;

#ifdef NEED_X11_EXTENSIONS_XRENDER_H
/* piece of Xrender guts */
typedef struct _XExtDisplayInfo {
	struct _XExtDisplayInfo *next;
	Display *display;
	XExtCodes *codes;
	XPointer data;
} XExtDisplayInfo;

extern XExtDisplayInfo *
XRenderFindDisplay (Display *dpy);
#endif

static void
xft_debug( const char *format, ...)
{
	int i;
	va_list args;
	va_start( args, format);
	fprintf( stderr, "xft: ");
	for ( i = 0; i < xft_debug_indent * 3; i++) fprintf( stderr, " ");
	vfprintf( stderr, format, args);
	fprintf( stderr, "\n");
	va_end( args);
}

void
prima_xft_init(void)
{
	int i;
	FcCharSet * fcs_ascii;
#ifdef HAVE_ICONV_H
	iconv_t ii;
	unsigned char in[128], *iptr;
	char ucs4[12];
	size_t ibl, obl;
	uint32_t *optr;
	int j;
#endif

#ifdef NEED_X11_EXTENSIONS_XRENDER_H
	{ /* snatch error code from xrender guts */
		XExtDisplayInfo *info = XRenderFindDisplay( DISP);
		if ( info && info-> codes)
			guts. xft_xrender_major_opcode = info-> codes-> major_opcode;
	}
#endif

	if ( !apc_fetch_resource( "Prima", "", "UseXFT", "usexft",
				nilHandle, frUnix_int, &guts. use_xft))
		guts. use_xft = 1;
	if ( guts. use_xft) {
		if ( !XftInit(0)) guts. use_xft = 0;
	}
	/* After this point guts.use_xft must never be altered */
	if ( !guts. use_xft) return;
	XFTdebug("XFT ok");

	fcs_ascii = FcCharSetCreate();
	for ( i = 32; i < 127; i++)  FcCharSetAddChar( fcs_ascii, i);


	std_charsets[0]. fcs = FcCharSetUnion( fcs_ascii, fcs_ascii);
	for ( i = 161; i < 255; i++) FcCharSetAddChar( std_charsets[0]. fcs, i);
	for ( i = 128; i < 255; i++) std_charsets[0]. map[i - 128] = i;
	std_charsets[0]. glyphs = ( 127 - 32) + ( 255 - 161);

#ifdef HAVE_ICONV_H
	sprintf( ucs4, "UCS-4%cE", (guts.machine_byte_order == LSBFirst) ? 'L' : 'B');
	for ( i = 1; i < STD_CHARSETS; i++) {
		memset( std_charsets[i]. map, 0, sizeof(std_charsets[i]. map));

		ii = iconv_open(ucs4, std_charsets[i]. name);
		if ( ii == (iconv_t)(-1)) continue;

		std_charsets[i]. fcs = FcCharSetUnion( fcs_ascii, fcs_ascii);
		for ( j = 0; j < 128; j++) in[j] = j + 128;
		iptr = in;
		optr = std_charsets[i]. map;
		ibl = 128;
		obl = 128 * sizeof( uint32_t);
		while ( 1 ) {
			int ret = iconv( ii, ( char **) &iptr, &ibl, ( char **) &optr, &obl);
			if ( ret < 0 && errno == EILSEQ) {
				iptr++;
				optr++;
				ibl--;
				obl -= sizeof(uint32_t);
				continue;
			}
			break;
		}
		iconv_close(ii);

		optr = std_charsets[i]. map - 128;
		std_charsets[i]. glyphs = 127 - 32;
		for ( j = (( i == KOI8_INDEX) ? 191 : 161); j < 256; j++)
			/* koi8 hack - 161-190 are pseudo-graphic symbols, not really characters,
				so don't use them for font matching by a charset */
			if ( optr[j]) {
				FcCharSetAddChar( std_charsets[i]. fcs, optr[j]);
				std_charsets[i]. glyphs++;
			}
		if ( std_charsets[i]. glyphs > 127 - 32)
			std_charsets[i]. enabled = true;
	}
#endif

	mismatch     = hash_create();
	mono_fonts   = hash_create();
	prop_fonts   = hash_create();
	encodings    = hash_create();
	myfont_cache = hash_create();
	for ( i = 0; i < STD_CHARSETS; i++) {
		int length = 0;
		char upcase[256], *dest = upcase, *src = std_charsets[i].name;
		if ( !std_charsets[i]. enabled) continue;
		while ( *src) {
			*dest++ = toupper(*src++);
			length++;
		}
		hash_store( encodings, upcase, length, (void*) (std_charsets + i));
		hash_store( encodings, std_charsets[i]. name, length, (void*) (std_charsets + i));
	}

	fontspecific_charset. fcs = FcCharSetCreate();
	for ( i = 128; i < 256; i++) fontspecific_charset. map[i - 128] = i;
	hash_store( encodings, fontspecific, strlen(fontspecific), (void*) &fontspecific_charset);

	utf8_charset. fcs = FcCharSetCreate();
	for ( i = 128; i < 256; i++) utf8_charset. map[i - 128] = i;
	hash_store( encodings, utf8_encoding, strlen(utf8_encoding), (void*) &utf8_charset);

	locale = hash_fetch( encodings, guts. locale, strlen( guts.locale));
	if ( !locale) locale = std_charsets;
	FcCharSetDestroy( fcs_ascii);
}

static Bool
remove_myfonts( void * f, int keyLen, void * key, void * dummy)
{
	unlink((char*) key);
	return false;
}

void
prima_xft_done(void)
{
	int i;
	if ( !guts. use_xft) return;
	for ( i = 0; i < STD_CHARSETS; i++)
		if ( std_charsets[i]. fcs)
			FcCharSetDestroy( std_charsets[i]. fcs);
	FcCharSetDestroy( fontspecific_charset. fcs);
	FcCharSetDestroy( utf8_charset. fcs);
	hash_destroy( encodings, false);
	hash_destroy( mismatch, false);
	hash_destroy( prop_fonts, true);
	hash_destroy( mono_fonts, true);

	hash_first_that( myfont_cache, (void*)remove_myfonts, NULL, NULL, NULL);
	hash_destroy( myfont_cache, false);
	myfont_cache = NULL;

}

static unsigned short
utf8_flag_strncpy( char * dst, const char * src, unsigned int maxlen, unsigned short is_utf8_flag)
{
	int is_utf8 = 0;
	while ( maxlen-- && *src) {
		if ( *((unsigned char*)src) > 0x7f)
			is_utf8 = 1;
		*(dst++) = *(src++);
	}
	*dst = 0;
	return is_utf8 ? is_utf8_flag : 0;
}

static void
fcpattern2fontnames( FcPattern * pattern, Font * font)
{
	FcChar8 * s;

	if ( FcPatternGetString( pattern, FC_FAMILY, 0, &s) == FcResultMatch)
		font-> utf8_flags |= utf8_flag_strncpy( font-> name, (char*)s, 255, FONT_UTF8_NAME);
	if ( FcPatternGetString( pattern, FC_FOUNDRY, 0, &s) == FcResultMatch)
		font-> utf8_flags |= utf8_flag_strncpy( font-> family, (char*)s, 255, FONT_UTF8_FAMILY);

	/* fake family */
	if (
		( strcmp(font->family, "") == 0) ||
		( strcmp(font->family, "unknown") == 0)
	) {
		char * name   = font->name;
		char * family = font->family;
		while (*name && *name != ' ') {
			*family++ = (*name < 127 ) ? tolower(*name) : *name;
			name++;
		}
		*family = 0;
	}
}

static void
fcpattern2font( FcPattern * pattern, PFont font)
{
	int i, j;
	double d = 1.0;
	FcCharSet *c = NULL;

	/* FcPatternPrint( pattern); */
	fcpattern2fontnames(pattern, font);

	font-> style = 0;
	font-> undef. style = 0;
	if ( FcPatternGetInteger( pattern, FC_SLANT, 0, &i) == FcResultMatch)
		if ( i == FC_SLANT_ITALIC || i == FC_SLANT_OBLIQUE)
			font-> style |= fsItalic;
	if ( FcPatternGetInteger( pattern, FC_WEIGHT, 0, &i) == FcResultMatch) {
		if ( i <= FC_WEIGHT_LIGHT)
			font-> style |= fsThin;
		else if ( i >= FC_WEIGHT_BOLD)
			font-> style |= fsBold;
	}

	font-> xDeviceRes = guts. resolution. x;
	font-> yDeviceRes = guts. resolution. y;
	if ( FcPatternGetDouble( pattern, FC_DPI, 0, &d) == FcResultMatch)
		font-> yDeviceRes = d + 0.5;
	if ( FcPatternGetDouble( pattern, FC_ASPECT, 0, &d) == FcResultMatch)
		font-> xDeviceRes = font-> yDeviceRes * d;

	if ( FcPatternGetInteger( pattern, FC_SPACING, 0, &i) == FcResultMatch) {
		font-> pitch = (( i == FC_PROPORTIONAL) ? fpVariable : fpFixed);
		font-> undef. pitch = 0;
	}

	if ( FcPatternGetDouble( pattern, FC_PIXEL_SIZE, 0, &d) == FcResultMatch) {
		font->height = d + 0.5;
		font-> undef. height = 0;
		XFTdebug("height factor read:%d (%g)", font-> height, d);
	}

	font-> width = 100; /* warning, FC_WIDTH does not reflect FC_MATRIX scale changes */
	if ( FcPatternGetDouble( pattern, FC_WIDTH, 0, &d) == FcResultMatch) {
		font->width = d + 0.5;
		XFTdebug("width factor read:%d (%g)", font-> width, d);
	}
	font-> width = ( font-> width * font-> height) / 100.0 + .5;
	font->undef. width = 0;

	if ( FcPatternGetDouble( pattern, FC_SIZE, 0, &d) == FcResultMatch) {
		font->size = d + 0.5;
		font->undef. size = 0;
		XFTdebug("size factor read:%d (%g)", font-> size, d);
	} else if (!font-> undef.height && font->yDeviceRes != 0) {
		font-> size = font-> height * 72.27 / font-> yDeviceRes + .5;
		font-> undef. size = 0;
		XFTdebug("size calculated:%d", font-> size);
	} else {
		XFTdebug("size unknown");
	}

	FcPatternGetBool( pattern, FC_SCALABLE, 0, &font-> vector);

	font-> firstChar = 32; font-> lastChar = 255;
	font-> breakChar = 32; font-> defaultChar = 32;
	if (( FcPatternGetCharSet( pattern, FC_CHARSET, 0, &c) == FcResultMatch) && c) {
		FcChar32 ucs4, next, map[FC_CHARSET_MAP_SIZE];
		if (( ucs4 = FcCharSetFirstPage( c, map, &next)) != FC_CHARSET_DONE) {
			for (i = 0; i < FC_CHARSET_MAP_SIZE; i++)
				if ( map[i] ) {
					for (j = 0; j < 32; j++)
						if (map[i] & (1 << j)) {
							FcChar32 u = ucs4 + i * 32 + j;
							font-> firstChar = u;
							if ( font-> breakChar   < u) font-> breakChar   = u;
							if ( font-> defaultChar < u) font-> defaultChar = u;
							goto STOP_1;
						}
				}
STOP_1:;
			while ( next != FC_CHARSET_DONE)
				ucs4 = FcCharSetNextPage (c, map, &next);
			for (i = FC_CHARSET_MAP_SIZE - 1; i >= 0; i--)
				if ( map[i] ) {
					for (j = 31; j >= 0; j--)
						if (map[i] & (1 << j)) {
							FcChar32 u = ucs4 + i * 32 + j;
							font-> lastChar = u;
							if ( font-> breakChar   > u) font-> breakChar   = u;
							if ( font-> defaultChar > u) font-> defaultChar = u;
							goto STOP_2;
						}
				}
STOP_2:;
		}
	}

	/* XXX other details? */
	font-> descent = font-> height / 4;
	font-> ascent  = font-> height - font-> descent;
	font-> maximalWidth = font-> width;
	font-> internalLeading = 0;
	font-> externalLeading = 0;
}

#define ROUND_DIRECTION 1000.0
#define IS_ZERO(a)  ((int)(a*ROUND_DIRECTION)==0)
#define ROUGHLY(a) (((int)(a*ROUND_DIRECTION))/ROUND_DIRECTION)

static void
xft_build_font_key( PFontKey key, PFont f, Bool bySize)
{
	bzero( key, sizeof( FontKey));
	key-> height = bySize ? -f-> size : f-> height;
	key-> width = f-> width;
	key-> style = f-> style & ~(fsUnderlined|fsOutline|fsStruckOut) & fsMask;
	key-> pitch = f-> pitch & fpMask;
	key-> direction = ROUGHLY(f-> direction);
	strcpy( key-> name, f-> name);
}

static XftFont *
try_size( Handle self, Font f, double size)
{
	XftFont * xft = NULL;
	bzero( &f.undef, sizeof(f.undef));
	f. undef. height = f. undef. width = 1;
	f. size = size + 0.5;
	f. direction = 0.0;
	xft_debug_indent++;
	prima_xft_font_pick( self, &f, &f, &size, &xft);
	xft_debug_indent--;
	return xft;
}

/* find a most similar monospace/proportional font by name and family */
static char *
find_good_font_by_family( Font * f, int fc_spacing )
{
	static Bool initialized = 0;

	if ( !initialized ) {
		/* iterate over all monospace and proportional font, build family->name (i.e best default match) hash */
		int i;
		FcFontSet * s;
		FcPattern   *pat, **ppat;
		FcObjectSet *os;

		initialized = 1;

		pat = FcPatternCreate();
		FcPatternAddBool( pat, FC_SCALABLE, 1);
		os = FcObjectSetBuild( FC_FAMILY, FC_CHARSET, FC_ASPECT,
			FC_SLANT, FC_WEIGHT, FC_SIZE, FC_PIXEL_SIZE, FC_SPACING,
			FC_FOUNDRY, FC_SCALABLE, FC_DPI,
			(void*) 0);
		s = FcFontList( 0, pat, os);
		FcObjectSetDestroy( os);
		FcPatternDestroy( pat);
		if ( !s) return NULL;

		ppat = s-> fonts;
		for ( i = 0; i < s->nfont; i++, ppat++) {
			Font f;
			int spacing = FC_PROPORTIONAL, slant, len, weight;
			FcBool scalable;
			PHash font_hash;

			/* only regular fonts */
			if (
				( FcPatternGetInteger( *ppat, FC_SLANT, 0, &slant) != FcResultMatch) ||
				( slant == FC_SLANT_ITALIC || slant == FC_SLANT_OBLIQUE)
			)
				continue;
			if (
				( FcPatternGetInteger( *ppat, FC_WEIGHT, 0, &weight) != FcResultMatch) ||
				( weight <= FC_WEIGHT_LIGHT || weight >= FC_WEIGHT_BOLD)
			)
				continue;
			if (
				( FcPatternGetBool( *ppat, FC_SCALABLE, 0, &scalable) != FcResultMatch) ||
				( scalable == 0 )
			)
				continue;

			fcpattern2fontnames( *ppat, &f);
			len = strlen(f.family);

			/* sort fonts by family and spacing */
			font_hash = (
				( FcPatternGetInteger( *ppat, FC_SPACING, 0, &spacing) == FcResultMatch) &&
				( spacing == FC_MONO )
			) ?
				mono_fonts : prop_fonts;
			if ( hash_fetch( font_hash, f.family, len))
				continue;

			hash_store( font_hash, f.family, len, duplicate_string(f.name));
		}
		FcFontSetDestroy(s);
	}
	/* initialized ok */

	/* try to find same family and same 1st word in font name */
	{
		char *c, *w, word1[255], word2[255];
		PHash font_hash = (fc_spacing == FC_MONO) ? mono_fonts : prop_fonts;
		c = hash_fetch( font_hash, f->family, strlen(f->family));
		if ( !c ) return NULL;
		if ( strcmp( c, f->name) == 0) return NULL; /* same font */

		strcpy( word1, c);
		strcpy( word2, f->name);
		if (( w = strchr( word1, ' '))) *w = 0;
		if (( w = strchr( word2, ' '))) *w = 0;
		if ( strcmp( word1, word2 ) != 0 ) return NULL;
		return c;
	}
}

static void
xft_store_font(Font * k, Font * v, Bool by_size, XftFont * xft, XftFont * xft_base)
{
	FontKey key;
	PCachedFont kf;
	xft_build_font_key( &key, k, by_size);
	if ( !hash_fetch( guts. font_hash, &key, sizeof(FontKey))) {
		if (( kf = malloc( sizeof( CachedFont)))) {
			bzero( kf, sizeof( CachedFont));
			memcpy( &kf-> font, v, sizeof( Font));
			kf-> font. style &= ~(fsUnderlined|fsOutline|fsStruckOut) & fsMask;
			kf-> xft      = xft;
			kf-> xft_base = xft_base;
			hash_store( guts. font_hash, &key, sizeof( FontKey), kf);
			XFTdebug("store %x(%x):%dx%d.%s.%s.%s^%g", xft, xft_base, key.height, key.width, _F_DEBUG_STYLE(key.style), _F_DEBUG_PITCH(key.pitch), key.name, ROUGHLY(key.direction));
		}
	}
}

static int force_xft_monospace_emulation = 0;
static int try_xft_monospace_emulation_by_name = 0;

/* Bug #128146: libXft might use another shared libfontconfig library, as
 * observed on a badly configured macos, and thus FcPattern* returned by it
 * can crash everything */
static FcPattern *
my_XftFontMatch(Display        *dpy,
              int               screen,
              _Xconst FcPattern *pattern,
              FcResult          *result)
{
    FcPattern   *new;
    FcPattern   *match;
    new = FcPatternDuplicate (pattern);
    if (!new)
        return NULL;
    FcConfigSubstitute (NULL, new, FcMatchPattern);
    XftDefaultSubstitute (dpy, screen, new);
    match = FcFontMatch (NULL, new, result);
    FcPatternDestroy (new);
    return match;
}

Bool
prima_xft_font_pick( Handle self, Font * source, Font * dest, double * size, XftFont ** xft_result)
{
	FcPattern *request, *match;
	FcResult res = FcResultNoMatch;
	Font requested_font, loaded_font;
	Bool by_size;
	CharSetInfo * csi;
	XftFont * xf;
	FontKey key;
	PCachedFont kf, kf_base = NULL;
	int i, base_width = 1, exact_pixel_size = 0, cache_results = 1;
	double pixel_size;

	if ( !guts. use_xft) return false;

	requested_font = *dest;
	by_size = Drawable_font_add( self, source, &requested_font);
	pixel_size = requested_font. height;

	if ( guts. xft_disable_large_fonts > 0) {
		/* xft is unable to deal with large polygon requests.
			we must cut the large fonts here, before Xlib croaks */
		if (
			( by_size && ( requested_font. size >= MAX_GLYPH_SIZE)) ||
			(!by_size && ( requested_font. height >= MAX_GLYPH_SIZE / 72.27 * guts. resolution. y))
		)
			return false;
	}

	/* we don't want to cache fractional sizes because these can lead to incoherent results
		depending on whether we match a particular height by size or by height */
	if ( by_size && size && *size * 100 != requested_font.size * 100 ) {
		cache_results = 0;
		XFTdebug("not caching results because size %g is fractional", *size);
	}

	/* see if the font is not present in xft - the hashed negative matches
			are stored with width=0, as the width alterations are derived */
	xft_build_font_key( &key, &requested_font, by_size);
	XFTdebug("want %dx%d.%s.%s.%s/%s^%g", key.height, key. width, _F_DEBUG_STYLE(key.style), _F_DEBUG_PITCH(key.pitch), key.name, requested_font.encoding, ROUGHLY(requested_font.direction));

	key. width = 0;
	if ( hash_fetch( mismatch, &key, sizeof( FontKey))) {
		XFTdebug("refuse");
		return false;
	}
	key. width = requested_font. width;

	/* convert encoding */
	csi = ( CharSetInfo*) hash_fetch( encodings, requested_font. encoding, strlen( requested_font. encoding));
	if ( !csi) {
		/* xft has no such encoding, pass it back */
		if ( prima_core_font_encoding( requested_font. encoding) || !guts. xft_priority)
			return false;
		csi = locale;
	}

	/* see if cached font exists */
	if (( kf = hash_fetch( guts. font_hash, &key, sizeof( FontKey)))) {
		*dest = kf-> font;
		strcpy( dest-> encoding, csi-> name);
		if ( requested_font. style & fsStruckOut) dest-> style |= fsStruckOut;
		if ( requested_font. style & fsUnderlined) dest-> style |= fsUnderlined;
		if ( xft_result ) *xft_result = kf-> xft;
		return true;
	}
	/* see if the non-xscaled font exists */
	if ( key. width != 0) {
		key. width = 0;
		if ( !( kf = hash_fetch( guts. font_hash, &key, sizeof( FontKey)))) {
			Font s = *source, d = *dest;
			s. width = d. width = 0;
			XFTdebug("try nonscaled font");
			xft_debug_indent++;
			prima_xft_font_pick( self, &s, &d, size, NULL);
			xft_debug_indent--;
		}
		if ( kf || ( kf = hash_fetch( guts. font_hash, &key, sizeof( FontKey)))) {
			base_width = kf-> font. width;
			if ( FcPatternGetDouble( kf-> xft-> pattern, FC_PIXEL_SIZE, 0, &pixel_size) == FcResultMatch) {
				exact_pixel_size = 1;
				XFTdebug("existing base font %x %dx0 suggests exact_pixel_size %g base_width %d", kf->xft, key.height, pixel_size, base_width);
			}
		} else { /* if fails, cancel x scaling and see if it failed due to banning */
			if ( hash_fetch( mismatch, &key, sizeof( FontKey))) return false;
			requested_font. width = 0;
		}
	}
	/* see if the non-rotated font exists */
	if ( !IS_ZERO(key. direction)) {
		key. direction = 0.0;
		key. width = requested_font. width;
		if ( !( kf_base = hash_fetch( guts. font_hash, &key, sizeof( FontKey)))) {
			Font s = *source, d = *dest;
			s. direction = d. direction = 0.0;
			XFTdebug("try nonrotated font");
			xft_debug_indent++;
			prima_xft_font_pick( self, &s, &d, size, NULL);
			xft_debug_indent--;
			/* if fails, cancel rotation and see if the base font is banned  */
			if ( !( kf_base = hash_fetch( guts. font_hash, &key, sizeof( FontKey))))
				requested_font. direction = 0.0;
		}
		if ( !IS_ZERO(requested_font. direction)) {
			/* as requested_font. height != FC_PIXEL_SIZE, read the correct request
				from the non-rotated font */
			if ( FcPatternGetDouble( kf_base-> xft-> pattern, FC_PIXEL_SIZE, 0, &pixel_size) == FcResultMatch) {
				XFTdebug("existing base font %x %dx%d dir=0 suggests exact_pixel_size %g", kf_base->xft, key.height, key.width, pixel_size);
				exact_pixel_size = 1;
			}
		}
	}

	/* create FcPattern request */
	if ( !( request = FcPatternCreate())) return false;
	if ( strcmp( requested_font. name, "Default") != 0)
		FcPatternAddString( request, FC_FAMILY, ( FcChar8*) requested_font. name);
	if ( by_size) {
		if ( size) {
			FcPatternAddDouble( request, FC_SIZE, *size);
			XFTdebug("FC_SIZE = %.1f", *size);
		} else {
			FcPatternAddDouble( request, FC_SIZE, requested_font. size);
			XFTdebug("FC_SIZE = %d", requested_font. size);
		}
	} else {
		FcPatternAddDouble( request, FC_PIXEL_SIZE, pixel_size);
		XFTdebug("FC_PIXEL_SIZE = %g", pixel_size);
	}
	FcPatternAddInteger( request, FC_SPACING,
		(requested_font. pitch == fpFixed && force_xft_monospace_emulation) ? FC_MONO : FC_PROPORTIONAL);

	FcPatternAddInteger( request, FC_SLANT, ( requested_font. style & fsItalic) ? FC_SLANT_ITALIC : FC_SLANT_ROMAN);
	FcPatternAddInteger( request, FC_WEIGHT,
				( requested_font. style & fsBold) ? FC_WEIGHT_BOLD :
				( requested_font. style & fsThin) ? FC_WEIGHT_THIN : FC_WEIGHT_NORMAL);
	FcPatternAddBool( request, FC_SCALABLE, 1);
	if ( !IS_ZERO(requested_font. direction) || requested_font. width != 0) {
		FcMatrix mat;
		FcMatrixInit(&mat);
		if ( requested_font. width != 0) {
			FcMatrixScale( &mat, ( double) requested_font. width / base_width, 1);
			XFTdebug("FcMatrixScale %g", ( double) requested_font. width / base_width);
		}
		if ( !IS_ZERO(requested_font. direction))
			FcMatrixRotate( &mat, cos(requested_font.direction * 3.14159265358 / 180.0), sin(requested_font.direction * 3.14159265358 / 180.0));
		FcPatternAddMatrix( request, FC_MATRIX, &mat);
	}

	if ( guts. xft_no_antialias)
		FcPatternAddBool( request, FC_ANTIALIAS, 0);

	/* match best font - must return something useful; the match is statically allocated */
	match = my_XftFontMatch( DISP, SCREEN, request, &res);
	if ( !match) {
		XFTdebug("XftFontMatch error");
		FcPatternDestroy( request);
		return false;
	}
	/* if (pguts->debug & DEBUG_FONTS) { FcPatternPrint(match); } */
	FcPatternDestroy( request);

	/* xft does a rather bad job with synthesizing a monospaced
	font out of a proportional one ... try to find one ourself,
	or bail out if it is the case
	*/
	if ( requested_font.pitch == fpFixed && !force_xft_monospace_emulation) {
		int spacing = -1;

		if (
			( FcPatternGetInteger( match, FC_SPACING, 0, &spacing) == FcResultMatch) &&
			( spacing != FC_MONO )
		) {
			Font font_with_family;
			char * monospace_font;
			font_with_family = requested_font;
			fcpattern2fontnames(match, &font_with_family);
			FcPatternDestroy( match);

			if (!try_xft_monospace_emulation_by_name && ( monospace_font = find_good_font_by_family(&font_with_family, FC_MONO))) {
				/* try a good mono font, again */
				Bool ret;
				Font s = *source;
				strcpy(s.name, monospace_font);
				XFTdebug("try fixed pitch");
				try_xft_monospace_emulation_by_name++;
				ret = prima_xft_font_pick( self, &s, dest, size, xft_result);
				try_xft_monospace_emulation_by_name--;
				return ret;
			} else {
				Bool ret;
				XFTdebug("force ugly monospace");
				force_xft_monospace_emulation++;
				ret = prima_xft_font_pick( self, source, dest, size, xft_result);
				force_xft_monospace_emulation--;
				return ret;
			}
		}
	} else if ( requested_font.pitch == fpVariable ) {
		/*
			xft picks a monospaced font when a proportional one is requested if the name points at it.
			Not that this is wrong, but in Prima terms pitch is heavier than name (this concept was borrowed from win32).
			So try to pick a variable font of the same family, if there is one. Same algorithm as with fixed fonts,
			but not as strict - if we can't find a proportional font within same family, so be it then
		*/
		int spacing = -1;

		if (
			( FcPatternGetInteger( match, FC_SPACING, 0, &spacing) == FcResultMatch) &&
			( spacing == FC_MONO ) /* for our purpose all what is not FC_MONO is good enough to be fpVariable */
		) {
			Font font_with_family;
			char * proportional_font;
			font_with_family = requested_font;
			fcpattern2fontnames(match, &font_with_family);

			if (( proportional_font = find_good_font_by_family(&font_with_family, FC_PROPORTIONAL))) {
				/* try a good variable font, again */
				Font s = *source;
				strcpy(s.name, proportional_font);
				XFTdebug("try variable pitch");
				FcPatternDestroy( match);
				return prima_xft_font_pick( self, &s, dest, size, xft_result);
			} else {
				XFTdebug("variable pitch is not found within family %s", font_with_family.family);
			}
		}

	}

	/* Manually check if font contains wanted encoding - matching by FcCharSet
		can't set threshold on how many glyphs can be omitted */
	if ( !(
		(strcmp( requested_font. encoding, fontspecific) != 0) ||
		(strcmp( requested_font. encoding, utf8_encoding) != 0)
	)) {
		FcCharSet *c = NULL;
		FcPatternGetCharSet( match, FC_CHARSET, 0, &c);
		if ( c && (FcCharSetCount(c) == 0)) {
			XFTdebug("charset mismatch (%s)", requested_font. encoding);
			FcPatternDestroy( match);
			return false;
		}
	}

	/* Check if the matched font is scalable -- see comments in the beginning
		of the file about non-scalable fonts in Xft */
	{
		FcBool scalable;
		if (( FcPatternGetBool( match, FC_SCALABLE, 0, &scalable) == FcResultMatch) && !scalable) {
			xft_build_font_key( &key, &requested_font, by_size);
			key. width = 0;
			hash_store( mismatch, &key, sizeof( FontKey), (void*)1);
			XFTdebug("refuse bitmapped font");
			FcPatternDestroy( match);
			return false;
		}
	}

	/* XXX copy font details - very important these are correct !!! */
	/* strangely enough, if the match is used after XftFontOpenPattern, it is
		destroyed */
	loaded_font = requested_font;
	if ( !kf_base) {
		Bool underlined = loaded_font. style & fsUnderlined;
		Bool strike_out  = loaded_font. style & fsStruckOut;
		fcpattern2font( match, &loaded_font);
		if ( requested_font. width > 0) loaded_font. width = requested_font. width;
		if ( underlined) loaded_font. style |= fsUnderlined;
		if ( strike_out) loaded_font. style |= fsStruckOut;
	}


	/* check name match */
	{
		FcChar8 * s = NULL;
		FcPatternGetString( match, FC_FAMILY, 0, &s);
		if ( !s || strcmp(( const char*) s, requested_font. name) != 0) {
			int i, n = guts. n_fonts;
			PFontInfo info = guts. font_info;

			if ( !guts. xft_priority) {
				XFTdebug("name mismatch");
			NAME_MISMATCH:
				xft_build_font_key( &key, &requested_font, by_size);
				key. width = 0;
				hash_store( mismatch, &key, sizeof( FontKey), (void*)1);
				FcPatternDestroy( match);
				return false;
			}

			/* check if core has cached face name */
			if ( prima_find_known_font( &requested_font, false, by_size)) {
				XFTdebug("pass to cached core");
				goto NAME_MISMATCH;
			}

			/* check if core has non-cached face name */
			for ( i = 0; i < n; i++) {
				if (
					info[i]. flags. disabled ||
					!info[i].flags.name ||
					(strcmp( info[i].font.name, requested_font.name) != 0)
				) continue;
				XFTdebug("pass to core");
				goto NAME_MISMATCH;
			}
		}
	}

	/* load the font */
	xf = XftFontOpenPattern( DISP, match);
	if ( !xf) {
		xft_build_font_key( &key, &requested_font, by_size);
		key. width = 0;
		hash_store( mismatch, &key, sizeof( FontKey), (void*)1);
		XFTdebug("XftFontOpenPattern error");
		FcPatternDestroy( match);
		return false;
	}
	XFTdebug("load font %x", xf);

	if ( kf_base) {
		/* A bit hacky, since the rotated font may be substituted by Xft.
		We skip the non-scalable fonts earlier to assure this doesn't happen,
		but anyway it's not 100% */
		Bool underlined = loaded_font. style & fsUnderlined;
		Bool strike_out  = loaded_font. style & fsStruckOut;
		loaded_font = kf_base-> font;
		loaded_font. direction = requested_font. direction;
		strcpy( loaded_font. encoding, csi-> name);
		if ( underlined) loaded_font. style |= fsUnderlined;
		if ( strike_out) loaded_font. style |= fsStruckOut;
	} else {
		loaded_font. internalLeading = xf-> height - loaded_font. size * guts. resolution. y / 72.27 + 0.5;
		if ( !by_size && !exact_pixel_size) {
			/* Try to locate the corresponding size and
			the correct height - FC_PIXEL_SIZE is not correct most probably
			multiply size by 10 to address pixel-wise heights correctly.
			*/
			HeightGuessStack hgs;
			int h, sz, last_sz = -1;
			XftFont * guessed_font = NULL;

			sz = 10.0 * (float) loaded_font. size * (float) loaded_font. height / (float) xf->height;
			XFTdebug("need to figure the corresponding size - try %g first...", ( double) sz / 10.0);
			guessed_font = try_size( self, loaded_font, ( double) sz / 10.0);

			if ( guessed_font) {
				h = guessed_font-> height;
				XFTdebug("got height = %d", h);
				if ( h != requested_font. height) {
					XFTdebug("not good enough, try approximation from size %g", ( double) sz / 10.0);
					prima_init_try_height( &hgs, requested_font. height, sz);
					while ( 1) {
						last_sz = sz;
						sz = prima_try_height( &hgs, h);
						if ( sz < 0) break;
						guessed_font = try_size( self, loaded_font, ( double) sz / 10.0);
						if ( !guessed_font) break;
						h = guessed_font-> height;
						XFTdebug("size %.1f got us %d pixels", ( float) sz / 10.0, h);
						if ( h == 0 || h == requested_font. height) break;
					}
				}
				if ( sz < 0) sz = last_sz;
				if ( sz > 0) {
					loaded_font. size = (double) sz / 10.0 + 0.5;
					XFTdebug("found size: %.1f (%d)", ( float) sz / 10.0, loaded_font. size);
				}
			} else {
				XFTdebug("found nothing");
			}

			if ( guessed_font && requested_font. height != xf-> height) {
				xf = guessed_font;
				loaded_font. height = xf-> height;
				XFTdebug("redirect to font %x", xf);
			}
			XFTdebug("guessed size %d", loaded_font.size);
		} else {
			loaded_font. height = xf-> height;
			XFTdebug("set height: %d", loaded_font.height);
		}

		loaded_font. maximalWidth = xf-> max_advance_width;
		/* calculate average font width */
		if ( loaded_font. pitch != fpFixed) {
			FcChar32 c;
			XftFont *x = kf_base ? kf_base-> xft : xf;
			int num = 0, sum = 0;
			for ( c = 63; c < 126; c+=4) {
				FT_UInt ft_index;
				XGlyphInfo glyph;
				if ( !( ft_index = XftCharIndex( DISP, x, c))) continue;
				XftGlyphExtents( DISP, x, &ft_index, 1, &glyph);
				sum += glyph. xOff;
				num++;
			}
			loaded_font. width = ( num > 10) ? ((float) sum / num + 0.5) : loaded_font. maximalWidth;
		} else
			loaded_font. width = loaded_font. maximalWidth;
	}

	{
		XftFont * base = kf_base ? kf_base-> xft : xf;
		loaded_font. descent = base-> descent;
		loaded_font. ascent  = base-> ascent;
	}

	if ( cache_results ) {
		/* create hash entry for subsequent loads of same font */
		xft_store_font(&requested_font, &loaded_font, by_size, xf, kf_base ? kf_base-> xft : xf);
		/* and with the matched by height and size */
		for ( i = 0; i < 2; i++)
			xft_store_font(&loaded_font, &loaded_font, i, xf, kf_base ? kf_base-> xft : xf);
	}

	*dest = loaded_font;
	if ( xft_result ) *xft_result = xf;
	return true;
}

Bool
prima_xft_set_font( Handle self, PFont font)
{
	DEFXX;
	CharSetInfo * csi;
	PCachedFont kf = prima_xft_get_cache( font);
	if ( !kf) return false;
	XX-> font = kf;
	if ( !( csi = hash_fetch( encodings, font-> encoding, strlen( font-> encoding))))
		csi = locale;
	XX-> xft_map8 = csi-> map;
	if ( IS_ZERO(PDrawable( self)-> font. direction)) {
		XX-> xft_font_sin = 0.0;
		XX-> xft_font_cos = 1.0;
	} else {
		XX-> xft_font_sin = sin( font-> direction / 57.29577951);
		XX-> xft_font_cos = cos( font-> direction / 57.29577951);
	}
	return true;
}

PCachedFont
prima_xft_get_cache( PFont font)
{
	FontKey key;
	PCachedFont kf;
	xft_build_font_key( &key, font, false);
	kf = ( PCachedFont) hash_fetch( guts. font_hash, &key, sizeof( FontKey));
	if ( !kf || !kf-> xft) return NULL;
	return kf;
}

/*
	performs 3 types of queries:
	defined(facename) - list of fonts with facename and encoding, if defined encoding
	defined(encoding) - list of fonts with encoding
	!defined(encoding) && !defined(facename) - list of all fonts with all available encodings.

	since apc_fonts does the same and calls xft_fonts, array is the list of fonts
	filled already, so xft_fonts reallocates the list when needed.

	XXX - find proper font metrics, but where??
*/
PFont
prima_xft_fonts( PFont array, const char *facename, const char * encoding, int *retCount)
{
	FcFontSet * s;
	FcPattern   *pat, **ppat;
	FcObjectSet *os;
	PFont newarray, f;
	PHash names = NULL;
	CharSetInfo * csi = NULL;
	int i;

	if ( encoding) {
		if ( !( csi = ( CharSetInfo*) hash_fetch( encodings, encoding, strlen( encoding))))
			return array;
	}

	pat = FcPatternCreate();
	if ( facename) FcPatternAddString( pat, FC_FAMILY, ( FcChar8*) facename);
	FcPatternAddBool( pat, FC_SCALABLE, 1);
	os = FcObjectSetBuild( FC_FAMILY, FC_CHARSET, FC_ASPECT,
		FC_SLANT, FC_WEIGHT, FC_SIZE, FC_PIXEL_SIZE, FC_SPACING,
		FC_FOUNDRY, FC_SCALABLE, FC_DPI,
		(void*) 0);
	s = FcFontList( 0, pat, os);
	FcObjectSetDestroy( os);
	FcPatternDestroy( pat);
	if ( !s) return array;

	/* make dynamic */
	if (( *retCount + s->nfont == 0) || !( newarray = realloc( array, sizeof(Font) * (*retCount + s-> nfont * ALL_CHARSETS)))) {
		FcFontSetDestroy(s);
		return array;
	}
	ppat = s-> fonts;
	f = newarray + *retCount;
	bzero( f, sizeof( Font) * s-> nfont * ALL_CHARSETS);

	names = hash_create();

	for ( i = 0; i < s->nfont; i++, ppat++) {
		FcCharSet *c = NULL;
		fcpattern2font( *ppat, f);
		FcPatternGetCharSet( *ppat, FC_CHARSET, 0, &c);
		if ( c && FcCharSetCount(c) == 0) continue;
		if ( encoding) {
			/* case 1 - encoding is set, filter only given encoding */

			if ( c && ((signed) FcCharSetIntersectCount( csi-> fcs, c) >= csi-> glyphs - 1)) {
				if ( !facename) {
					/* and, if no facename set, each facename is reported only once */
					if ( hash_fetch( names, f-> name, strlen( f-> name))) continue;
					hash_store( names, f-> name, strlen( f-> name), ( void*)1);
				}
				strncpy( f-> encoding, encoding, 255);
				f++;
			}
		} else if ( facename) {
			/* case 2 - facename only is set, report each facename with every encoding */
			int j;
			Font * tmpl = f;
			for ( j = 0; j < STD_CHARSETS; j++) {
				if ( !std_charsets[j]. enabled) continue;
				if ( FcCharSetIntersectCount( c, std_charsets[j]. fcs) >= std_charsets[j]. glyphs - 1) {
					*f = *tmpl;
					strncpy( f-> encoding, std_charsets[j]. name, 255);
					f++;
				}
			}
			/* if no encodings found, assume fontspecific, otherwise always provide iso10646 */
			strcpy( f-> encoding, (f == tmpl) ? fontspecific : utf8_encoding);
			f++;
		} else if ( !facename && !encoding) {
			/* case 3 - report unique facenames and store list of encodings
				into the hack array */
			if ( hash_fetch( names, f-> name, strlen( f-> name)) == (void*)1) continue;
			hash_store( names, f-> name, strlen( f-> name), (void*)1);
			if ( c) {
				int j, found = 0;
				char ** enc = (char**) f-> encoding;
				unsigned char * shift = (unsigned char*)enc + sizeof(char *) - 1;
				for ( j = 0; j < STD_CHARSETS; j++) {
					if ( !std_charsets[j]. enabled) continue;
					if ( *shift + 2 >= 256 / sizeof(char*)) break;
					if ( FcCharSetIntersectCount( c, std_charsets[j]. fcs) >= std_charsets[j]. glyphs - 1) {
						char buf[ 512];
						int len = snprintf( buf, 511, "%s-charset-%s", f-> name, std_charsets[j]. name);
						if ( hash_fetch( names, buf, len) == (void*)2) continue;
						hash_store( names, buf, len, (void*)2);
						*(enc + ++(*shift)) = std_charsets[j]. name;
						found = 1;
					}
				}
				*(enc + ++(*shift)) = found ? utf8_encoding : fontspecific;
			}
			f++;
		}
	}

	*retCount = f - newarray;

	hash_destroy( names, false);

	FcFontSetDestroy(s);
	return newarray;
}

void
prima_xft_font_encodings( PHash hash)
{
	int i;
	for ( i = 0; i < STD_CHARSETS; i++) {
		if ( !std_charsets[i]. enabled) continue;
		hash_store( hash, std_charsets[i]. name, strlen(std_charsets[i]. name), (void*) (std_charsets + i));
	}
	hash_store( hash, utf8_encoding, strlen(utf8_encoding), (void*) &utf8_charset);
}

static FcChar32 *
xft_text2ucs4( const unsigned char * text, int len, Bool utf8, uint32_t * map8)
{
	FcChar32 *ret, *r;
	if ( utf8) {
		STRLEN charlen, bytelen = strlen(( const char *) text);
		(void)bytelen;

		if ( len < 0) len = prima_utf8_length(( char*) text);
		if ( !( r = ret = malloc( len * sizeof( FcChar32)))) return NULL;
		while ( len--) {
			*(r++) =
#if PERL_PATCHLEVEL >= 16
			utf8_to_uvchr_buf(( U8*) text, ( U8*) + bytelen, &charlen)
#else
			utf8_to_uvchr(( U8*) text, &charlen)
#endif
			;
			text += charlen;
			if ( charlen == 0 ) break;
		}
	} else {
		int i;
		if ( len < 0) len = strlen(( char*) text);
		if ( !( ret = malloc( len * sizeof( FcChar32)))) return NULL;
		for ( i = 0; i < len; i++)
			ret[i] = ( text[i] < 128) ? text[i] : map8[ text[i] - 128];
	}
	return ret;
}

int
prima_xft_get_text_width( PCachedFont self, const char * text, int len, Bool addOverhang,
								Bool utf8, uint32_t * map8, Point * overhangs)
{
	int i, ret = 0, bytelen, div;
	XftFont * font = self-> xft_base;

	if ( overhangs) overhangs-> x = overhangs-> y = 0;
	if ( utf8 ) bytelen = strlen(text);

	/* x11 has problems with text_out strings that are wider than
	64K pixel - it wraps the coordinates and produces mess. This hack is
	although ugly, but is better that X11 default behaviour, and
	at least can be excused by the fact that all GP spaces have
	their geometrical limits. */
	div = 65535L / (self-> font. maximalWidth ? self-> font. maximalWidth : 1);
	if ( div <= 0) div = 1;
	if ( len > div) len = div;

	for ( i = 0; i < len; i++) {
		FcChar32 c;
		FT_UInt ft_index;
		XGlyphInfo glyph;
		if ( utf8) {
			STRLEN charlen;
			c = ( FcChar32)
#if PERL_PATCHLEVEL >= 16
			utf8_to_uvchr_buf(( U8*) text, (U8*) text + bytelen, &charlen)
#else
			utf8_to_uvchr(( U8*) text, &charlen)
#endif
			;
			text += charlen;
			if ( charlen == 0 ) break;
		} else if ( ((Byte*)text)[i] > 127) {
			c = map8[ ((Byte*)text)[i] - 128];
		} else
			c = text[i];
		ft_index = XftCharIndex( DISP, font, c);
		XftGlyphExtents( DISP, font, &ft_index, 1, &glyph);
		ret += glyph. xOff;
		if ( addOverhang || overhangs) {
			if ( i == 0) {
				if ( glyph. x > 0) {
					if ( addOverhang) ret += glyph. x;
					if ( overhangs)   overhangs-> x = glyph. x;
				}
			}
			if ( i == len - 1) {
				int c = glyph. xOff - glyph. width + glyph. x;
				if ( c < 0) {
					if ( addOverhang) ret -= c;
					if ( overhangs)   overhangs-> y = -c;
				}
			}
		}
	}
	return ret;
}

Point *
prima_xft_get_text_box( Handle self, const char * text, int len, Bool utf8)
{
	DEFXX;
	Point ovx;
	int width;
	Point * pt = ( Point *) malloc( sizeof( Point) * 5);
	if ( !pt) return NULL;

	width = prima_xft_get_text_width( XX-> font, text, len,
		false, utf8, X(self)-> xft_map8, &ovx);

	pt[0].y = pt[2]. y = XX-> font-> font. ascent - 1;
	pt[1].y = pt[3]. y = - XX-> font-> font. descent;
	pt[4].y = 0;
	pt[4].x = width;
	pt[3].x = pt[2]. x = width + ovx. y;
	pt[0].x = pt[1]. x = - ovx. x;

	if ( !XX-> flags. paint_base_line) {
		int i;
		for ( i = 0; i < 4; i++) pt[i]. y += XX-> font-> font. descent;
	}

	if ( !IS_ZERO(PDrawable( self)-> font. direction)) {
		int i;
		double s = sin( PDrawable( self)-> font. direction / 57.29577951);
		double c = cos( PDrawable( self)-> font. direction / 57.29577951);
		for ( i = 0; i < 5; i++) {
			double x = pt[i]. x * c - pt[i]. y * s;
			double y = pt[i]. x * s + pt[i]. y * c;
			pt[i]. x = x + (( x > 0) ? 0.5 : -0.5);
			pt[i]. y = y + (( y > 0) ? 0.5 : -0.5);
		}
	}

	return pt;
}

static XftFont *
create_no_aa_font( XftFont * font)
{
	FcPattern * request;
	if (!( request = FcPatternDuplicate( font-> pattern))) return NULL;
	FcPatternDel( request, FC_ANTIALIAS);
	FcPatternAddBool( request, FC_ANTIALIAS, 0);
	return XftFontOpenPattern( DISP, request);
}

#define SORT(a,b)       { int swp; if ((a) > (b)) { swp=(a); (a)=(b); (b)=swp; }}
#define REVERT(a)       (XX-> size. y - (a) - 1)
#define SHIFT(a,b)      { (a) += XX-> gtransform. x + XX-> btransform. x; \
									(b) += XX-> gtransform. y + XX-> btransform. y; }
#define RANGE(a)        { if ((a) < -16383) (a) = -16383; else if ((a) > 16383) a = 16383; }
#define RANGE2(a,b)     RANGE(a) RANGE(b)
#define RANGE4(a,b,c,d) RANGE(a) RANGE(b) RANGE(c) RANGE(d)

/* emulate win32 clearing off alpha bits on any Gdi operation */

#define EMULATE_ALPHA_CLEARING 0

static void
XftDrawGlyph_layered( PDrawableSysData selfxx, _Xconst XftColor *color, int x, int y, _Xconst FT_UInt glyph)
{
	XftColor black;
	XGlyphInfo extents;

	XftGlyphExtents( DISP, XX-> font-> xft, &glyph, 1, &extents);

	if (
		!XX-> xft_shadow_pixmap ||
		extents. width  > XX-> xft_shadow_extentions.x ||
		extents. height > XX-> xft_shadow_extentions.y
	) {
		int w, h;
		if ( XX-> xft_shadow_pixmap ) {
			XFreePixmap( DISP, XX-> xft_shadow_pixmap);
			XftDrawDestroy( XX-> xft_shadow_drawable);
			XX-> xft_shadow_pixmap   = 0;
			XX-> xft_shadow_drawable = NULL;
		}
		w = extents. width * 4;
		h = extents. height * 4;
		if ( w < 32 ) w = 32;
		if ( h < 32 ) h = 32;
		XX-> xft_shadow_extentions. x = w;
		XX-> xft_shadow_extentions. y = h;
		XX-> xft_shadow_pixmap   = XCreatePixmap( DISP, guts.root, w, h, 1);
		XX-> xft_shadow_drawable = XftDrawCreateBitmap( DISP, XX-> xft_shadow_pixmap );
	}

	if ( !XX-> xft_shadow_gc ) {
		XGCValues gcv;
		gcv. foreground = 1;
		XX-> xft_shadow_gc = XCreateGC( DISP, XX-> xft_shadow_pixmap, GCForeground, &gcv);
	}

	XFillRectangle( DISP, XX-> xft_shadow_pixmap, XX-> xft_shadow_gc,
		0, 0, XX-> xft_shadow_extentions.x, XX-> xft_shadow_extentions.y);

	black.color.red   =
	black.color.green =
	black.color.blue  =
	black.pixel       = 0x1;
	black.color.alpha = 0x0;
	XftDrawGlyphs( XX-> xft_shadow_drawable, &black, XX->font->xft, extents.x, extents.y, &glyph, 1);
	XftDrawGlyphs( XX-> xft_drawable, color, XX->font->xft, x, y, &glyph, 1);

	XCopyPlane( DISP, XX-> xft_shadow_pixmap, XX-> gdrawable, XX-> gc, 0, 0, extents.width, extents.height,
		x - extents.x, y - extents.y, 1);
}

/* When plotting rotated fonts, xft does not account for the accumulated
	roundoff error, and thus the text line is shown at different angle
	than requested. We track this and align the reference point when it
	deviates from the ideal line */
static void
my_XftDrawString32( PDrawableSysData selfxx,
		_Xconst XftColor *color, int x, int y,
		_Xconst FcChar32 *string, int len)
{

	XGCValues old_gcv, gcv;
	int i, ox, oy, shift;
	if ( IS_ZERO(XX-> font-> font. direction) && !XX-> flags. layered ) {
		XftDrawString32( XX-> xft_drawable, color, XX-> font-> xft, x, y, string, len);
		return;
	}
	ox = x;
	oy = y;
	shift = 0;
	if ( XX-> flags. layered && EMULATE_ALPHA_CLEARING) {
		FT_UInt ft_index;
		/* prepare xrender */
		XftDrawGlyphs( XX-> xft_drawable, color, XX->font->xft, x, y, &ft_index, 0);

		XGetGCValues( DISP, XX-> gc, GCFunction|GCBackground|GCForeground|GCPlaneMask, &old_gcv);
		gcv. foreground = 0xffffffff;
		gcv. background = 0x00000000;
		gcv. function   = GXand;
		gcv. plane_mask = guts. argb_bits. alpha_mask;
		XChangeGC( DISP, XX-> gc, GCFunction|GCBackground|GCForeground|GCPlaneMask, &gcv);
	}

	for ( i = 0; i < len; i++) {
		int cx, cy;
		FT_UInt ft_index;
		XGlyphInfo glyph;
		ft_index = XftCharIndex( DISP, XX-> font-> xft, string[i]);
		XftGlyphExtents( DISP, XX-> font-> xft_base, &ft_index, 1, &glyph);
		shift += glyph. xOff;
		cx = ox + (int)(shift * XX-> xft_font_cos + 0.5);
		cy = oy - (int)(shift * XX-> xft_font_sin + 0.5);
		if ( XX-> flags. layered && EMULATE_ALPHA_CLEARING)
			XftDrawGlyph_layered( XX, color, x, y, ft_index);
		else
			XftDrawGlyphs( XX-> xft_drawable, color, XX->font->xft, x, y, &ft_index, 1);
		x = cx;
		y = cy;
	}

	if ( XX-> flags. layered && EMULATE_ALPHA_CLEARING)
		XChangeGC( DISP, XX-> gc, GCFunction|GCBackground|GCForeground|GCPlaneMask, &old_gcv);
}

Bool
prima_xft_text_out( Handle self, const char * text, int x, int y, int len, Bool utf8)
{
	DEFXX;
	FcChar32 *ucs4;
	XftColor xftcolor;
	XftFont *font = XX-> font-> xft;
	int rop = XX-> paint_rop, div;
	Point baseline;

	if ( len == 0) return true;

	/* x11 has problems with text_out strings that are wider than
	64K pixel - it wraps the coordinates and produces mess. This hack is
	although ugly, but is better that X11 default behaviour, and
	at least can be excused by the fact that all GP spaces have
	their geometrical limits. */
	div = 65535L / (PDrawable(self)-> font. maximalWidth ? PDrawable(self)-> font. maximalWidth : 1);
	if ( div <= 0) div = 1;
	if ( len > div) len = div;

	/* filter out unsupported rops */
	switch ( rop) {
	case ropBlackness:
		xftcolor.color.red   =
		xftcolor.color.green =
		xftcolor.color.blue  =
		xftcolor.pixel       = 0;
		rop = ropCopyPut;
		break;
	case ropWhiteness:
		xftcolor.color.red   =
		xftcolor.color.green =
		xftcolor.color.blue  = 0xffff;
		xftcolor.pixel       = 0xffffffff;
		rop = ropCopyPut;
		break;
	case ropXorPut:
	case ropOrPut:
	case ropNotSrcAnd:
	case ropNotSrcXor:
	case ropNotSrcOr:
	case ropAndPut:
		xftcolor.color.red   = COLOR_R16(XX->fore.color);
		xftcolor.color.green = COLOR_G16(XX->fore.color);
		xftcolor.color.blue  = COLOR_B16(XX->fore.color);
		xftcolor.pixel       = XX-> fore. primary;
		break;
	case ropNotPut:
		xftcolor.color.red   = COLOR_R16(~XX->fore.color);
		xftcolor.color.green = COLOR_G16(~XX->fore.color);
		xftcolor.color.blue  = COLOR_B16(~XX->fore.color);
		xftcolor.pixel       = ~XX-> fore. primary;
		rop = ropCopyPut;
		break;
	default:
		xftcolor.color.red   = COLOR_R16(XX->fore.color);
		xftcolor.color.green = COLOR_G16(XX->fore.color);
		xftcolor.color.blue  = COLOR_B16(XX->fore.color);
		xftcolor.pixel       = XX-> fore. primary;
		rop = ropCopyPut;
	}

	if ( XX-> flags. layered) {
		xftcolor.color.alpha = 0xffff;
	} else if ( XX-> type. bitmap) {
		xftcolor.color.alpha =
			((xftcolor.color.red/3 + xftcolor.color.green/3 + xftcolor.color.blue/3) > (0xff00 / 2)) ?
				0xffff : 0;
		/* force-remove antialiasing, xft doesn't have a better API for this */
		if ( !guts. xft_no_antialias && !XX-> font-> xft_no_aa) {
			FcBool aa;
			if (
				( FcPatternGetBool( font-> pattern, FC_ANTIALIAS, 0, &aa) == FcResultMatch)
				&& aa
				) {
				XftFont * f = create_no_aa_font( font);
				if ( f)
					font = XX-> font-> xft_no_aa = f;
			}
		}
	} else {
		xftcolor.color.alpha = 0xffff;
	}
	/* paint background if opaque */
	if ( XX-> flags. paint_opaque) {
		int i;
		Point * p = prima_xft_get_text_box( self, text, len, utf8);
		FillPattern fp;
		memcpy( &fp, apc_gp_get_fill_pattern( self), sizeof( FillPattern));
		XSetForeground( DISP, XX-> gc, XX-> back. primary);
		XX-> flags. brush_back = 0;
		XX-> flags. brush_fore = 1;
		XX-> fore. balance = 0;
		XSetFunction( DISP, XX-> gc, GXcopy);
		apc_gp_set_fill_pattern( self, fillPatterns[fpSolid]);
		for ( i = 0; i < 4; i++) {
			p[i].x += x;
			p[i].y += y;
		}
		i = p[2].x; p[2].x = p[3].x; p[3].x = i;
		i = p[2].y; p[2].y = p[3].y; p[3].y = i;

		apc_gp_fill_poly( self, 4, p);
		apc_gp_set_rop( self, XX-> paint_rop);
		apc_gp_set_color( self, XX-> fore. color);
		apc_gp_set_fill_pattern( self, fp);
		free( p);
	}
	SHIFT( x, y);
	RANGE2(x,y);

	/* xft doesn't allow shifting glyph reference point - need to adjust manually */
	baseline. x = - PDrawable(self)-> font. descent * XX-> xft_font_sin;
	baseline. y = - PDrawable(self)-> font. descent * ( 1 - XX-> xft_font_cos )
					+ XX-> font-> font. descent;
	if ( !XX-> flags. paint_base_line) {
		x += baseline. x;
		y += baseline. y;
	}

	/* allocate xftdraw surface */
	if ( !XX-> xft_drawable) {
		if ( XX-> type. bitmap)
			XX-> xft_drawable = XftDrawCreateBitmap( DISP, XX-> gdrawable );
		else
			XX-> xft_drawable = XftDrawCreate( DISP, XX-> gdrawable, XX->visual->visual, XX->colormap);
		XftDrawSetSubwindowMode( XX-> xft_drawable,
			XX-> flags.clip_by_children ? ClipByChildren : IncludeInferiors);
		XCHECKPOINT;
	}
	if ( !XX-> flags. xft_clip) {
		XftDrawSetClip( XX-> xft_drawable, XX-> current_region);
		XX-> flags. xft_clip = 1;
	}

	/* convert text string to unicode */
	if ( !( ucs4 = xft_text2ucs4(( unsigned char*) text, len, utf8, X( self)-> xft_map8)))
		return false;

	if ( rop != ropCopyPut) {
	/* emulate rops by blitting the text */
		XGCValues gcv;
		GC gc;
		int dx  = prima_xft_get_text_width( XX-> font, text, len,
			true, utf8, X(self)-> xft_map8, NULL);
		int dy  = XX-> font-> font. height;
		int i, width, height;
		Rect rc;
		Point p[4], offset;
		Pixmap canvas;

		bzero( &rc, sizeof(rc));
		offset. x = offset. y = 0;
		p[0].x = p[2].x = 0;
		p[0].y = p[1].y = 0;
		p[1].x = p[3].x = dx;
		p[2].y = p[3].y = dy;
		rc. left = rc. right = rc. top = rc. bottom = 0;
		for ( i = 1; i < 4; i++) {
			int x = p[i].x * XX-> xft_font_cos - p[i].y * XX-> xft_font_sin + 0.5;
			int y = p[i].x * XX-> xft_font_sin + p[i].y * XX-> xft_font_cos + 0.5;
			if ( rc. left    > x) rc. left   = x;
			if ( rc. right   < x) rc. right  = x;
			if ( rc. bottom  > y) rc. bottom = y;
			if ( rc. top     < y) rc. top    = y;
		}
		width  = rc. right  - rc. left   + 1;
		height = rc. top    - rc. bottom + 1;

		canvas = XCreatePixmap( DISP, guts. root, width, height, XX-> type. bitmap ? 1 : guts. depth);
		if ( !canvas) goto COPY_PUT;
		dx = -rc. left;
		dy = -rc. bottom;
		gc = XCreateGC( DISP, canvas, 0, &gcv);
		switch ( rop) {
		case ropAndPut:
		case ropNotSrcXor:
		case ropNotSrcOr:
			XSetForeground( DISP, gc, 0xffffffff);
			break;
		default:
			XSetForeground( DISP, gc, 0x0);
			break;
		}
		XFillRectangle( DISP, canvas, gc, 0, 0, width, height);
		XftDrawChange( XX-> xft_drawable, canvas);
		if ( XX-> flags. xft_clip)
			XftDrawSetClip( XX-> xft_drawable, 0);
		my_XftDrawString32( XX, &xftcolor, dx + baseline.x, height - dy - baseline. y, ucs4, len);
		XftDrawChange( XX-> xft_drawable, XX-> gdrawable);
		if ( XX-> flags. xft_clip)
			XftDrawSetClip( XX-> xft_drawable, XX-> current_region);
		XCHECKPOINT;
		x -= baseline.x;
		y -= baseline.y;
		XCopyArea( DISP, canvas, XX-> gdrawable, XX-> gc, 0, 0, width, height, x - dx, REVERT( y - dy + height));
		XFreeGC( DISP, gc);
		XFreePixmap( DISP, canvas);
	} else {
	COPY_PUT:
		my_XftDrawString32( XX, &xftcolor, x, REVERT( y) + 1, ucs4, len);
	}
	free( ucs4);
	/*
		If you're guided here by something like

			X Error: BadLength (poly request too large or internal Xlib length error),

		then you probably need to know that your X server is out of date.
		The error is caused by a Xrender bug, and you have the following options:
		- update your X server
		- set guts.xft_disable_large_fonts to 1, which would explicitly tell Prima not to wait
		for Xlib to bark on large polygons
		- set guts.xft_disable_large_fonts to 1 and decrease MAX_GLYPH_SIZE, if the former
		option is not enough
	*/
	XCHECKPOINT;


	/* emulate over- and understriking */
	if ( PDrawable( self)-> font. style & (fsUnderlined|fsStruckOut)) {
		Point ovx;
		int lw = apc_gp_get_line_width( self);
		int tw = prima_xft_get_text_width( XX-> font, text, len, false, utf8,
						X(self)-> xft_map8, &ovx) - 1;
		int d  = - PDrawable(self)-> font. descent;
		int ay, x1, y1, x2, y2;
		double c = XX-> xft_font_cos, s = XX-> xft_font_sin;

		XSetFillStyle( DISP, XX-> gc, FillSolid);
		if ( !XX-> flags. brush_fore) {
			XSetForeground( DISP, XX-> gc, XX-> fore. primary);
			XX-> flags. brush_fore = 1;
		}

		if ( lw != 1)
			apc_gp_set_line_width( self, 1);

		if ( PDrawable( self)-> font. style & fsUnderlined) {
			ay = d;
			x1 = x - ovx.x * c - ay * s + 0.5;
			y1 = y - ovx.x * s + ay * c + 0.5;
			tw += ovx.y;
			x2 = x + tw * c - ay * s + 0.5;
			y2 = y + tw * s + ay * c + 0.5;
			XDrawLine( DISP, XX-> gdrawable, XX-> gc, x1, REVERT( y1), x2, REVERT( y2));
		}

		if ( PDrawable( self)-> font. style & fsStruckOut) {
			ay = (XX-> font-> font.ascent - XX-> font-> font.internalLeading)/2;
			x1 = x - ovx.x * c - ay * s + 0.5;
			y1 = y - ovx.x * s + ay * c + 0.5;
			tw += ovx.y;
			x2 = x + tw * c - ay * s + 0.5;
			y2 = y + tw * s + ay * c + 0.5;
			XDrawLine( DISP, XX-> gdrawable, XX-> gc, x1, REVERT( y1), x2, REVERT( y2));
		}

		if ( lw != 1)
			apc_gp_set_line_width( self, lw);
	}
	XFLUSH;

	return true;
}

static Bool
xft_add_item( unsigned long ** list, int * count, int * size, FcChar32 chr,
				Bool decrease_count_if_failed)
{
	if ( *count >= *size) {
		unsigned long * newlist = realloc( *list, sizeof( unsigned long) * ( *size *= 2));
		if ( !newlist) {
			if ( decrease_count_if_failed) (*count)--;
			return false;
		}
		*list = newlist;
	}
	(*list)[(*count)++] = ( unsigned long ) chr;
	return true;
}

unsigned long *
prima_xft_get_font_ranges( Handle self, int * count)
{
	FcChar32 ucs4, last = 0, haslast = 0;
	FcChar32 map[FC_CHARSET_MAP_SIZE];
	FcChar32 next;
	FcCharSet *c = X(self)-> font-> xft-> charset;
	int size = 16;
	unsigned long * ret;

#define ADD(ch,flag) if(!xft_add_item(&ret,count,&size,ch,flag)) return ret

	*count = 0;
	if ( !c) return false;
	if ( !( ret = malloc( sizeof( unsigned long) * size))) return NULL;

	if ( FcCharSetCount(c) == 0) {
		/* better than nothing */
		ADD( 32, true);
		ADD( 128, false);
		return ret;
	}

	for (ucs4 = FcCharSetFirstPage (c, map, &next);
		ucs4 != FC_CHARSET_DONE;
		ucs4 = FcCharSetNextPage (c, map, &next))
	{
		int i, j;
		for (i = 0; i < FC_CHARSET_MAP_SIZE; i++)
			if (map[i]) {
					for (j = 0; j < 32; j++)
						if (map[i] & (1 << j)) {
							FcChar32 u = ucs4 + i * 32 + j;
							if ( haslast) {
								if ( last != u - 1) {
									ADD( last,true);
									ADD( u,false);
								}
							} else {
								ADD( u,false);
								haslast = 1;
							}
							last = u;
						}
			}
	}
	if ( haslast) ADD( last,true);

	return ret;
}

PFontABC
prima_xft_get_font_abc( Handle self, int firstChar, int lastChar, Bool unicode)
{
	PFontABC abc;
	int i, len = lastChar - firstChar + 1;
	XftFont *font = X(self)-> font-> xft_base;

	if ( !( abc = malloc( sizeof( FontABC) * len)))
		return NULL;

	for ( i = 0; i < len; i++) {
		FcChar32 c = i + firstChar;
		FT_UInt ft_index;
		XGlyphInfo glyph;
		if ( !unicode && c > 128) {
			c = X(self)-> xft_map8[ c - 128];
		}
		ft_index = XftCharIndex( DISP, font, c);
		XftGlyphExtents( DISP, font, &ft_index, 1, &glyph);
		abc[i]. a = -glyph. x;
		abc[i]. b = glyph. width;
		abc[i]. c = glyph. xOff - glyph. width + glyph. x;
	}

	return abc;
}

PFontABC
prima_xft_get_font_def( Handle self, int firstChar, int lastChar, Bool unicode)
{
	PFontABC abc;
	int i, len = lastChar - firstChar + 1;
	XftFont *font = X(self)-> font-> xft_base;

	if ( !( abc = malloc( sizeof( FontABC) * len)))
		return NULL;

	for ( i = 0; i < len; i++) {
		FcChar32 c = i + firstChar;
		FT_UInt ft_index;
		XGlyphInfo glyph;
		if ( !unicode && c > 128) {
			c = X(self)-> xft_map8[ c - 128];
		}
		ft_index = XftCharIndex( DISP, font, c);
		XftGlyphExtents( DISP, font, &ft_index, 1, &glyph);
		abc[i]. a = X(self)-> font-> font. descent - glyph. height + glyph. y; /* XXX yOff ? */
		abc[i]. b = glyph. height;
		abc[i]. c = X(self)-> font-> font. ascent - glyph. y;
	}

	return abc;
}

uint32_t *
prima_xft_map8( const char * encoding)
{
	CharSetInfo * csi;
	if ( !( csi = hash_fetch( encodings, encoding, strlen( encoding))))
		csi = locale;
	return csi-> map;
}

Bool
prima_xft_parse( char * ppFontNameSize, Font * font)
{
	FcPattern * p = FcNameParse(( FcChar8*) ppFontNameSize);
	FcCharSet * c = NULL;
	Font f, def = guts. default_font;

	bzero( &f, sizeof( Font));
	f. undef. height = f. undef. width = f. undef. size = 1;
	fcpattern2font( p, &f);
	f. undef. width = 1;
	FcPatternGetCharSet( p, FC_CHARSET, 0, &c);
	if ( c && (FcCharSetCount(c) > 0)) {
		int i;
		for ( i = 0; i < STD_CHARSETS; i++) {
			if ( !std_charsets[i]. enabled) continue;
			if ( FcCharSetIntersectCount( std_charsets[i]. fcs, c) >= std_charsets[i]. glyphs - 1) {
				strcpy( f. encoding, std_charsets[i]. name);
				break;
			}
		}
	}
	FcPatternDestroy( p);
	if ( !prima_xft_font_pick( nilHandle, &f, &def, NULL, NULL)) return false;
	*font = def;
	XFTdebug( "parsed ok: %d.%s", def.size, def.name);
	return true;
}

void
prima_xft_update_region( Handle self)
{
	DEFXX;
	if ( XX-> xft_drawable) {
		XftDrawSetClip( XX-> xft_drawable, XX-> current_region);
		XX-> flags. xft_clip = 1;
	}
}

int
prima_xft_load_font( char* filename)
{
	int count = 0;
	struct stat s;
	FcPattern * font;
	FcConfig * config;
	FcFontSet *fonts;

	/* -f $filename or die */
	if (stat( filename, &s) < 0) {
		warn("%s", strerror(errno));
		return 0;
	}

#define FAIL(msg) { warn(msg); return 0; }

	if (( s.st_mode & S_IFDIR) != 0)
		FAIL("Must not be a directory")
	if ( !( font = FcFreeTypeQuery ((const FcChar8*)filename, 0, NULL, &count)))
		FAIL("Format not recognized")
	FcPatternDestroy (font);

	if ( count == 0 )
		FAIL("No fonts found in file")
	if ( !(config = FcConfigGetCurrent()))
		FAIL("FcConfigGetCurrent error")
	if ( !( fonts = FcConfigGetFonts(config, FcSetSystem)))
		FAIL("FcConfigGetFonts(FcSetSystem) error")
	if ( !( FcFileScan(fonts, NULL, NULL, NULL, (const FcChar8*)filename, FcFalse)))
		FAIL("FcFileScan error")

	return count;
}

void
prima_xft_gp_destroy( Handle self )
{
	DEFXX;
	if ( XX-> xft_drawable) {
		XftDrawDestroy( XX-> xft_drawable);
		XX-> xft_drawable = NULL;
	}
	if ( XX-> xft_shadow_drawable) {
		XftDrawDestroy( XX-> xft_shadow_drawable);
		XX-> xft_shadow_drawable = NULL;
	}
	if ( XX-> xft_shadow_pixmap) {
		XFreePixmap( DISP, XX-> xft_shadow_pixmap);
		XX-> xft_shadow_pixmap = 0;
	}
	if ( XX-> xft_shadow_gc) {
		XFreeGC( DISP, XX-> xft_shadow_gc);
		XX-> xft_shadow_gc = 0;
	}
}

#else
#error Required: Xft version 2.1.0 or higher; fontconfig version 2.0.1 or higher. To compile without Xft, re-run 'perl Makefile.PL WITH_XFT=0'
#endif /* USE_XFT */

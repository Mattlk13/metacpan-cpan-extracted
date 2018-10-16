#include "win32\win32guts.h"
#ifndef _APRICOT_H_
#include "apricot.h"
#endif
#include "img_conv.h"
#include "guts.h"
#include "Window.h"
#include "Icon.h"
#include "Printer.h"
#include "DeviceBitmap.h"

#ifdef __cplusplus
extern "C" {
#endif


#define  sys (( PDrawableData)(( PComponent) self)-> sysData)->
#define  dsys( view) (( PDrawableData)(( PComponent) view)-> sysData)->
#define var (( PWidget) self)->
#define HANDLE sys handle
#define DHANDLE(x) dsys(x) handle

static int
image_guess_bitmap_type( Handle self )
{
	if ( is_apt( aptIcon ) && PIcon(self)-> maskType == imbpp8 )
		return BM_LAYERED;
	else if ( PImage( self)-> type == imBW)
		return BM_BITMAP;
	else
		return BM_PIXMAP;
}


BITMAPINFO *
image_fill_bitmap_info( Handle self, XBITMAPINFO * bi, int bm_type)
{
	int    i;
	PImage image = ( PImage) self;
	int    colors, depth;
	
	if ( bm_type == BM_AUTO )
		bm_type = image_guess_bitmap_type( self );

	switch (bm_type) {
	case BM_BITMAP:
		depth   = 1;
		colors  = 2;
		break;
	case BM_PIXMAP:
		depth   = image-> type & imBPP;
		colors  = (1 << depth) & 0x1ff;
		break;
	case BM_LAYERED:
		colors  = 0;
		depth   = 32;
		break;
	default:
		warn("panic: bad use of image_fill_bitmap_info(%d)", bm_type);
		return NULL;
	}

	if ( image-> type & ( imSignedInt | imRealNumber | imComplexNumber | imTrigComplexNumber)) {
		warn("panic: image_fill_bitmap_info called on incompatible image");
		return NULL;
	}

	if ( colors > image-> palSize) colors = image-> palSize;
	memset( bi, 0, sizeof( BITMAPINFOHEADER) + colors * sizeof( RGBQUAD));
	bi-> bmiHeader. biSize          = sizeof( BITMAPINFOHEADER);
	bi-> bmiHeader. biWidth         = image-> w;
	bi-> bmiHeader. biHeight        = image-> h;
	bi-> bmiHeader. biPlanes        = 1;
	bi-> bmiHeader. biBitCount      = depth;
	bi-> bmiHeader. biCompression   = BI_RGB;
	bi-> bmiHeader. biClrUsed       = colors;
	bi-> bmiHeader. biClrImportant  = colors;

	for ( i = 0; i < colors; i++) {
		bi-> bmiColors[ i]. rgbRed    = image-> palette[ i]. r;
		bi-> bmiColors[ i]. rgbGreen  = image-> palette[ i]. g;
		bi-> bmiColors[ i]. rgbBlue   = image-> palette[ i]. b;
	}

	return ( BITMAPINFO *) bi;
}

HPALETTE
image_create_palette( Handle self)
{
	PDrawable i    = ( PDrawable) self;
	int j, nColors = i-> palSize;
	XLOGPALETTE lp;
	HPALETTE r;
	RGBColor  dest[ 256];
	PRGBColor logp = i-> palette;

	lp. palVersion = 0x300;
	lp. palNumEntries = nColors;

	if ( nColors == 0) return NULL;
	if ( is_apt(aptImage) && PImage(self)->type == imRGB) return NULL;

	if ( !sys p256) {
		if ( nColors > 256) {
			sys p256 = ( PXLOGPALETTE) malloc( sizeof( XLOGPALETTE));
			cm_squeeze_palette( i-> palette, nColors, dest, 256);
			nColors = lp. palNumEntries = 256;
			logp = dest;
		}

		for ( j = 0; j < nColors; j++) {
			lp. palPalEntry[ j]. peRed    = logp[ j]. r;
			lp. palPalEntry[ j]. peGreen  = logp[ j]. g;
			lp. palPalEntry[ j]. peBlue   = logp[ j]. b;
			lp. palPalEntry[ j]. peFlags  = 0;
		}

		if ( sys p256)
			memcpy( sys p256, &lp, sizeof( XLOGPALETTE));
		if ( !( r = CreatePalette(( LOGPALETTE*) &lp))) apiErrRet;
	} else {
		if ( !( r = CreatePalette(( LOGPALETTE*) sys p256))) apiErrRet;
	}
	return r;
}

HBITMAP
image_create_bitmap( Handle self, HPALETTE pal, XBITMAPINFO * bitmapinfo, int bm_type)
{
	HBITMAP bm;
	XBITMAPINFO xbi;
	BITMAPINFO * bi;
	HPALETTE old = nil, xpal = pal;
	HDC dc;
	PIcon i = (PIcon) self;
	
	if ( bm_type == BM_AUTO )
		bm_type = image_guess_bitmap_type( self );

	if ( bitmapinfo == NULL)
		bitmapinfo = &xbi;
	bi  = image_fill_bitmap_info( self, bitmapinfo, bm_type);
	if ( !bi)
		return NULL;

	dc = GetDC(NULL);

	if ( bi-> bmiHeader. biClrUsed > 0)
		bi-> bmiHeader. biClrUsed = bi-> bmiHeader. biClrImportant = i-> palSize;

	if ( xpal == nil)
		xpal = image_create_palette( self);

	if ( xpal) {
		old = SelectPalette( dc, xpal, 1);
		RealizePalette( dc);
	}

	switch (bm_type) {
	case BM_BITMAP:
		if ( i-> type != imBW ) 
			warn("panic: image_create_bitmap(BM_BITMAP) called on not a imBW image");
		bm = CreateBitmap( bi-> bmiHeader. biWidth, bi-> bmiHeader. biHeight, 1, 1, NULL);
		if (bm)
			SetDIBits( dc, bm, 0, bi-> bmiHeader. biHeight, i-> data, bi, DIB_RGB_COLORS);
		break;
	case BM_PIXMAP:
		bm = CreateCompatibleBitmap( dc, i->w, i->h);
		if (bm)
			SetDIBits( dc, bm, 0, bi-> bmiHeader. biHeight, i-> data, bi, DIB_RGB_COLORS);
		break;
	default:
		warn("panic: bad use of image_create_bitmap(%d)", bm_type);
		return NULL;
	}

	if ( !bm)
		apiErr;

	if ( old) {
		SelectPalette( dc, old, 1);
		RealizePalette( dc);
	}

	if ( xpal != pal)
		DeleteObject( xpal);

	ReleaseDC( NULL, dc);

	return bm;
}

static HBITMAP
image_create_argb_bitmap( Handle self, uint32_t ** argb_bits_ptr )
{
	HBITMAP bm;
	XBITMAPINFO xbi;
	BITMAPINFO * bi;
	HDC dc, compat_dc;
	PIcon i = (PIcon) self;
	uint32_t * argb_bits;
	Byte * rgb_bits, *a_bits, *mask;
	int y, maskLineSize, free_mask;

	if ( !is_apt(aptIcon) || i-> type != imRGB ) {
		warn("panic: image_create_argb_bitmap called on a non-imRGB icon");
		return NULL;
	}

	if ( argb_bits_ptr == NULL )
		argb_bits_ptr = &argb_bits;

	bm = NULL;
	
	bi  = image_fill_bitmap_info( self, &xbi, BM_LAYERED);
	if ( !bi)
		return NULL;

	if ( i-> maskType != imbpp8 ) {
		free_mask    = true; 
		maskLineSize = LINE_SIZE(i->w, imbpp8);
		mask         = i->self->convert_mask( self, imbpp8 );
		if ( !mask ) 
			return NULL;
	} else {
		free_mask    = false;
		mask         = i-> mask;
		maskLineSize = i-> maskLine;
	}

	dc = GetDC(NULL);
	compat_dc = CreateCompatibleDC(dc);

	bi-> bmiHeader. biBitCount = 32;
	bi-> bmiHeader. biSizeImage = bi->bmiHeader.biWidth * bi->bmiHeader. biHeight * 4;
	bm = CreateDIBSection(compat_dc, bi, DIB_RGB_COLORS, 
			(LPVOID*) argb_bits_ptr, NULL, 0x0);
	if (!bm) {
		apiErr;
		goto EXIT;
	}
	for ( 
		y = 0, 
			rgb_bits  = i->data,
			a_bits    = mask,
			argb_bits = *argb_bits_ptr;
		y < i->h;
		y++,
			rgb_bits  += i-> lineSize,
			a_bits    += maskLineSize,
			argb_bits += i-> w
	) {
		register Byte *rgb_ptr = rgb_bits, *a_ptr = a_bits, *argb_ptr = (Byte*) argb_bits;
		register int x = i->w;
		for ( ; x > 0; x--) {
			*argb_ptr++ = *rgb_ptr++;
			*argb_ptr++ = *rgb_ptr++;
			*argb_ptr++ = *rgb_ptr++;
			*argb_ptr++ = *a_ptr++;
		}
	}

EXIT:
	if ( free_mask ) free(mask);
	DeleteDC( compat_dc);
	ReleaseDC( NULL, dc);
	return bm;
}

static XBITMAPINFO a1_info_header = {
	{ sizeof( BITMAPINFOHEADER), 0, 0, 1, 1, BI_RGB, 0, 0, 0, 2, 2},
	{ {0,0,0,0}, {255,255,255,0}}
};

static XBITMAPINFO a8_info_header = {
	{ sizeof( BITMAPINFOHEADER), 0, 0, 1, 8, BI_RGB, 0, 0, 0, 256, 256},
	{ {255,255,255,0}, {0,0,0,0}}
};

static int a_info_headers_initialized = false;

static XBITMAPINFO * 
image_alpha_bitmap_header( int type )
{
	if ( !a_info_headers_initialized ) {
		a_info_headers_initialized = true;
		memset( a8_info_header. bmiColors + 1, 0, 255 * sizeof(RGBQUAD));
	}
	return (( type == imbpp1 ) ? &a1_info_header : &a8_info_header);
}

/* convert from funky types */
static Handle
image_convert_for_gdi( Handle image )
{
	Handle dup;
	PImage img = (PImage) image;

	if ( !( img-> type & ( imSignedInt | imRealNumber | imComplexNumber | imTrigComplexNumber)))
		return nilHandle;

	dup = CImage(image)->dup(image);
	img = (PImage) dup;
	img->self->resample(
		dup,
		img-> self->stats( dup, false, isRangeLo, 0),
		img-> self->stats( dup, false, isRangeHi, 0),
		0, 255
	);
	img->self->set_type( dup, imByte );
	return dup;
}

/* create a copy with given type, unless it is of this type alredy */
static Handle
image_convert_to_type( Handle image, int type, Bool inplace )
{
	Handle dup;

	if (((PImage)image)->type == type)
		return nilHandle;

	dup = inplace ? image : CImage(image)->dup(image);
	CImage(dup)->set_type(dup, type);

	return dup;   
}

#define image_convert_for_bitmap(image,inplace) image_convert_to_type(image,imBW,inplace)
#define image_convert_for_rgb(image,inplace)    image_convert_to_type(image,imRGB,inplace)

static Handle
image_convert_rgb_for_screen( Handle image, Bool inplace )
{
	int bpp;
	PImage img = (PImage) image;

	if ( img-> type != imRGB)
		return nilHandle;

	/* use Prima downsampling methods from RGB to 8,4,1 */
	bpp = guts. displayBMInfo. bmiHeader. biBitCount *
			guts. displayBMInfo. bmiHeader. biPlanes;
	if ( bpp == 0 || bpp > 8)
		return nilHandle;
	if ( bpp < 4) bpp = 1;
	else if ( bpp < 8) bpp = 4;
	return image_convert_to_type( image, bpp, inplace );
}

static Handle
image_convert_rgb_for_paletted( Handle image, Handle screen, Bool inplace )
{
	int bpp;
	PImage img = (PImage) image;

	if ( img-> type != imRGB)
		return nilHandle;

	if ( dsys( screen) bpp == 0) {
		if ( !dsys(screen) ps)
			return image_convert_for_bitmap( image, inplace );
		dsys( screen) bpp = GetDeviceCaps( dsys(screen) ps, BITSPIXEL);
	}

	if ( dsys( screen) bpp > 8)
		return nilHandle;

	bpp = dsys( screen) bpp;
	if ( bpp < 4) bpp = 1;
	else if ( bpp < 8) bpp = 4;
	return image_convert_to_type( image, bpp, inplace );
}

static void
image_fill_bitmap_cache( Handle self, int bm_type, Handle optimize_for_surface)
{
	Handle copy;

	if ( bm_type == BM_AUTO )
		bm_type = image_guess_bitmap_type( self );

	if ( bm_type == sys s. image. cache. cacheType )
		return;

	/* free old stuff */
	image_destroy_cache( self ); 
	sys s. image. cache. cacheType = BM_NONE;

	/* create new image, if any */
	copy = image_convert_for_gdi( self );
	if ( copy == nilHandle ) 
		copy = self;

	switch (bm_type) {
	case BM_BITMAP:
		copy = image_convert_for_bitmap( copy, copy != self);
		break;
	case BM_PIXMAP:
		if (((PImage)copy)-> type == imRGB) {
			if (!optimize_for_surface)
				copy = image_convert_rgb_for_screen( copy, copy != self );
			else if ( dsys(optimize_for_surface) options. aptPrinter ) {
				/* do nothing, let printer driver do the downsampling */
			} else if ( ! dsys(optimize_for_surface)options.aptCompatiblePS && dsys(optimize_for_surface)ps)
				copy = image_convert_rgb_for_paletted( copy, optimize_for_surface, copy != self );
			else
				copy = image_convert_rgb_for_screen( copy, copy != self );
		}
		break;
	case BM_LAYERED:
		copy = image_convert_for_rgb( copy, copy != self);
		break;
	default:
		warn("panic: bad use of image_fill_bitmap_cache(%d)", bm_type);
		if ( copy != self )
		Object_destroy(copy);
		return;
	}
	if ( copy == nilHandle ) 
		copy = self;

	/* try to create HBITMAP */
	switch (bm_type) {
	case BM_LAYERED:
		sys bm = image_create_argb_bitmap( copy, &sys s. image. argbBits );
		if ( !sys bm) {
			warn("panic: couldn't create argb bitmap");
			if ( copy != self )
				Object_destroy(copy);
			return;
		}
		break;
	default:
		sys pal = image_create_palette( copy);
		sys bm  = image_create_bitmap( copy, sys pal, &sys s. image. cache. rawHeader, bm_type );
		if ( sys bm ) {
			hash_store( imageMan, &self, sizeof(self), (void*)self);
		} else {
			PImage i = (PImage) copy;
			sys s. image. cache. rawBits = i->data;
			if ( copy != self ) {
				i-> data = malloc(1); /* dirty, dirty hack */
				sys s. image. cache. freeBits = true;
			}
		}
	}
	if ( copy != self )
		Object_destroy(copy);

	sys s. image. cache. cacheType = bm_type;
}

static void
argb_query_bits( Handle self)
{
	PIcon i = (PIcon) self;
	uint32_t * argb_bits;
	Byte * rgb_bits, *a_bits;
	int y;

	if ( i-> type != imRGB || i-> maskType != imbpp8)
		i-> self-> create_empty_icon( self, i-> w, i-> h, imRGB, imbpp8);

	for ( 
		y = 0, 
			rgb_bits = i->data,
			a_bits   = i->mask,
			argb_bits = sys s. image. argbBits;
		y < i->h;
		y++,
			rgb_bits  += i-> lineSize,
			a_bits    += i-> maskLine,
			argb_bits += i-> w
	) {
		register Byte *rgb_ptr = rgb_bits, *a_ptr = a_bits, *argb_ptr = (Byte*) argb_bits;
		register int x = i->w;
		for ( ; x > 0; x--) {
			*rgb_ptr++ = *argb_ptr++;
			*rgb_ptr++ = *argb_ptr++;
			*rgb_ptr++ = *argb_ptr++;
			*a_ptr++   = *argb_ptr++;
		}
	}
}

void
image_destroy_cache( Handle self)
{
	if ( sys bm) {
		if ( !DeleteObject( sys bm)) apiErr;
		hash_delete( imageMan, &self, sizeof( self), false);
		sys bm = NULL;
		sys s. image. cache. bitmap = NULL;
	}
	if ( sys pal) {
		if ( !DeleteObject( sys pal)) apiErr;
		sys pal = NULL;
	}
	if ( sys s. image. imgCachedRegion) {
		if ( !DeleteObject( sys s. image. imgCachedRegion)) apiErr;
		sys s. image. imgCachedRegion = NULL;
	}
	if ( sys s. image. cache. freeBits)
		free( sys s. image. cache. rawBits);
	sys s. image. cache. rawBits = NULL;
	sys s. image. cache. freeBits = false;
	sys s. image. argbBits = NULL;
	sys s. image. cache. cacheType = BM_NONE;
}

void
image_query_bits( Handle self, Bool forceNewImage)
{
	PImage i = ( PImage) self;
	XBITMAPINFO xbi;
	BITMAPINFO * bi;
	int  newBits;
	HDC  ops = nil;
	BITMAP bitmap;

	if ( forceNewImage) {
		ops = sys ps;
		if ( !ops) {
			if ( !( sys ps = dc_alloc())) return;
		}
	}

	if ( !GetObject( sys bm, sizeof( BITMAP), ( LPSTR) &bitmap)) {
		apiErr;
		return;
		// if GetObject fails to get even BITMAP, there will be no good in farther run for sure.
	}

	if (( bitmap. bmPlanes == 1) && (
			( bitmap. bmBitsPixel == 1) ||
			( bitmap. bmBitsPixel == 4) ||
			( bitmap. bmBitsPixel == 8) ||
			( bitmap. bmBitsPixel == 24)
		))
		newBits = bitmap. bmBitsPixel;
	else {
		newBits = ( bitmap. bmBitsPixel <= 4) ? 4 :
					(( bitmap. bmBitsPixel <= 8) ? 8 : 24);
	}


	if ( forceNewImage) {
		i-> self-> create_empty( self, bitmap. bmWidth, bitmap. bmHeight, newBits);
	} else {
		if (( newBits != ( i-> type & imBPP)) || (( i-> type & ~imBPP) != 0))
			i-> self-> create_empty( self, i-> w, i-> h, newBits);
	}

	bi = image_fill_bitmap_info( self, &xbi, BM_PIXMAP);

	if ( !GetDIBits( sys ps, sys bm, 0, i-> h, i-> data, bi, DIB_RGB_COLORS)) apiErr;
	if (( i-> type & imBPP) < 24) {
		int j, nColors = 1 << ( i-> type & imBPP);
		for ( j = 0; j < nColors; j++) {
			i-> palette[ j]. r = xbi. bmiColors[ j]. rgbRed;
			i-> palette[ j]. g = xbi. bmiColors[ j]. rgbGreen;
			i-> palette[ j]. b = xbi. bmiColors[ j]. rgbBlue;
		}
	}

	if ( forceNewImage) {
		if ( !ops) {
			dc_free();
		}
		sys ps = ops;
	}
}

static Handle ctx_rop2R4[] = {
ropCopyPut      ,  SRCCOPY          ,
ropXorPut       ,  SRCINVERT        ,
ropAndPut       ,  SRCAND           ,
ropOrPut        ,  SRCPAINT         ,
ropNotPut       ,  NOTSRCCOPY       ,
ropNotDestAnd   ,  SRCERASE         ,
ropNotDestOr    ,  0x00DD0228       ,
ropNotSrcAnd    ,  0x00220326       ,
ropNotSrcOr     ,  MERGEPAINT       ,
ropNotXor       ,  0x00990066       ,
ropNotAnd       ,  0x007700E6       ,
ropNotOr        ,  NOTSRCERASE      ,
ropNoOper       ,  0x00AA0029       ,
ropBlackness    ,  BLACKNESS        ,
ropWhiteness    ,  WHITENESS        ,
ropInvert       ,  DSTINVERT        ,
endCtx
};

static Handle
image_from_dc( Handle image )
{
	Handle img      = ( Handle) create_object("Prima::Image", "");
	HDC adc         = dsys( image) ps;
	HBITMAP abitmap = dsys( image) bm;
	dsys( img) ps   = dsys( image) ps;
	dsys( img) bm   = dsys( image) bm;
	image_query_bits( img, true);
	dsys( img) ps   = adc;
	dsys( img) bm   = abitmap;
	return img;
}

static int
rop_reduce(COLORREF fore, COLORREF back, int rop)
{
/*
Special case with current foreground and background colors, see also
L<pod/Prima/Drawable.pod | Monochrome bitmaps>.

Raster ops can be identified by a fingerprint.  For example, Or's is 14
and Noop's is 10:

	0 | 0 =    0                      0 | 0 =    0
	0 | 1 =   1                       0 | 1 =   1
	1 | 0 =  1                        1 | 0 =  0
	1 | 1 = 1                         1 | 1 = 1
		---                               ---
		1110 = 14                         1010 = 10

when this special case uses not actual 0s and 1s, but bit values of
foreground and background color instead, the resulting operation can
still be expressed in rops, but these needs to be adjusted. Let's
consider a case where both colors are 0, and rop = OrPut:

	0 | 0 =    0
	0 | 1 =   1
	0 | 0 =  0
	0 | 1 = 1
		---
		1010 = 10

this means that in these conditions, Or (as well as Xor and AndInverted) becomes Noop.

*/

	fore &= 0xffffff;
	back &= 0xffffff;
	if ( fore == 0 && back == 0 ) {
		switch( rop) {
			case ropAndPut:           
			case ropNotDestAnd:    
			case ropBlackness:         
			case ropCopyPut:          rop = ropBlackness;      break;
			case ropNotXor:         
			case ropInvert:        
			case ropNotOr:           
			case ropNotDestOr:        rop = ropInvert;         break;
			case ropNotSrcAnd:   
			case ropNoOper:          
			case ropOrPut:            
			case ropXorPut:           rop = ropNoOper;         break;
			case ropNotAnd:          
			case ropNotPut:  
			case ropNotSrcOr:    
			case ropWhiteness:        rop = ropWhiteness;      break;
		}
	} else if ( fore != 0 && back == 0 ) {
		switch( rop) {
			case ropAndPut:           rop = ropNotSrcAnd;      break;
			case ropNotSrcAnd:        rop = ropAndPut;         break;
			case ropNotDestAnd:       rop = ropNotOr;          break;
			case ropBlackness:        rop = ropBlackness;      break;
			case ropCopyPut:          rop = ropNotPut;         break;
			case ropNotPut:           rop = ropCopyPut;        break;
			case ropNotXor:           rop = ropXorPut;         break;
			case ropInvert:           rop = ropInvert;         break;
			case ropNotAnd:           rop = ropNotDestOr;      break;
			case ropNoOper:           rop = ropNoOper;         break;
			case ropNotOr:            rop = ropNotDestAnd;     break;
			case ropOrPut:            rop = ropNotSrcOr;       break;
			case ropNotSrcOr:         rop = ropOrPut;          break;
			case ropNotDestOr:        rop = ropNotAnd;         break;
			case ropWhiteness:        rop = ropWhiteness;      break;
			case ropXorPut:           rop = ropNotXor;         break;
		}
	} else if ( fore != 0 && back != 0 ) {
		switch( rop) {
			case ropAndPut:           
			case ropNotSrcOr:    
			case ropNotXor:         
			case ropNoOper:           rop = ropNoOper;         break;
			case ropNotSrcAnd:  
			case ropBlackness:        
			case ropNotPut: 
			case ropNotOr:            rop = ropBlackness;      break;
			case ropInvert:      
			case ropNotAnd:        
			case ropNotDestAnd:  
			case ropXorPut:           rop = ropInvert;         break;
			case ropOrPut:         
			case ropNotDestOr:  
			case ropWhiteness:        
			case ropCopyPut:          rop = ropWhiteness;      break;
		}
	}
	return rop;
}

typedef struct {
	HDC src;
	int src_x;
	int src_y;
	int src_w;
	int src_h;
	int dst_x;
	int dst_y;
	int dst_w;
	int dst_h;
	int rop;
} PutImageRequest;

typedef Bool PutImageFunc( Handle self, Handle image, PutImageRequest * req);

#define SRC_BITMAP          0
#define SRC_PIXMAP          1
#define SRC_LAYERED         2
#define SRC_IMAGE           3
#define SRC_A8              4
#define SRC_ARGB            5
#define SRC_MAX             5
#define SRC_NUM            SRC_MAX+1 

static Bool
img_put_stretch_blt( HDC dst, HDC src, PutImageRequest * req)
{
	Bool ok = true;
	int rop = ctx_remap_def( req->rop, ctx_rop2R4, true, SRCCOPY);
	if ( !StretchBlt(
		dst, req-> dst_x, req-> dst_y, req-> dst_w, req-> dst_h,
		src, req-> src_x, req-> src_y, req-> src_w, req-> src_h,
		rop)) {
		apiErr;
		ok = false;
	}
	return ok;
}

static Bool
img_put_stretch_blt_viewport( HDC dst, HDC src, PutImageRequest * req)
{
	Bool ok;
	POINT tr = {0, 0};
	SetViewportOrgEx( src, 0, 0, &tr);
	ok = img_put_stretch_blt( dst, src, req);
	SetViewportOrgEx( src, tr.x, tr.y, NULL);
	return ok;
}

static Bool
img_put_stretch_bits( HDC dst, Handle self, PutImageRequest * req)
{
	int rop;

	if ( !sys s. image. cache. rawBits )
		return false;

	rop = ctx_remap_def( req->rop, ctx_rop2R4, true, SRCCOPY);
	if ( StretchDIBits( dst,
			req-> dst_x, req-> dst_y, req-> dst_w, req-> dst_h,
			req-> src_x, req-> src_y, req-> src_w, req-> src_h,
			sys s. image. cache. rawBits, (BITMAPINFO*) & sys s. image. cache. rawHeader,
			DIB_RGB_COLORS, rop) == GDI_ERROR) {
		apiErr;
		return false;
	}

	return true;
}

static Bool
img_put_and_mask( HDC dst, Handle image, PutImageRequest * req)
{
	XBITMAPINFO * bi = image_alpha_bitmap_header(PIcon(image)->maskType);

	bi-> bmiHeader. biWidth  = ((PImage)image)-> w;
	bi-> bmiHeader. biHeight = ((PImage)image)-> h;
	
	if ( StretchDIBits( dst,
			req-> dst_x, req-> dst_y, req-> dst_w, req-> dst_h,
			req-> src_x, req-> src_y, req-> src_w, req-> src_h,
			PIcon(image)->mask, (BITMAPINFO*) bi, DIB_RGB_COLORS, SRCAND
		) == GDI_ERROR) {
		apiErr;
		return false;
	}
	return true;
}

static Bool
img_put_image_on_bitmap_or_pixmap( Handle self, Handle image, PutImageRequest * req, int bm_type)
{
	Bool ok;
	HDC src;
	HPALETTE pal_src, pal_src_save, pal_dst_save;
	HBITMAP bm_src_save;
	COLORREF oFore = 0, oBack = 0;
	PImage i = (PImage) image;

	image_fill_bitmap_cache( image, bm_type, self );
	if ( dsys( image) bm == NULL ) /* we're low on memory, reverting to StretchDIBits */
		return img_put_stretch_bits( sys ps, image, req);

	/* create and prepare DC */
	src = CreateCompatibleDC( sys ps);

	if (( pal_src = dsys( image) pal) != NULL)
		pal_src_save = SelectPalette( src, pal_src, 0);
	else
		pal_src_save = NULL;

	bm_src_save = SelectObject( src, dsys( image) bm);
	if ( pal_src) {
		pal_dst_save = SelectPalette( sys ps, pal_src, 1);
		RealizePalette( sys ps);
	} else
		pal_dst_save = NULL;

	if ((bm_type == BM_PIXMAP) && (( i->type & imBPP) == 1)) {
		oFore  = GetTextColor( sys ps);
		oBack  = GetBkColor( sys ps);
		SetTextColor( sys ps, 0x00000000);
		SetBkColor  ( sys ps, 0x00FFFFFF);
	}

	/* draw */
	ok = img_put_stretch_blt( sys ps, src, req );

	/* clean up */
	if ((bm_type == BM_PIXMAP) && (( i->type & imBPP) == 1)) {
		SetTextColor( sys ps, oFore);
		SetBkColor( sys ps, oBack);
	}

	if ( pal_src) {
		if ( pal_src_save) SelectPalette( src, pal_src_save, 1);
	}
	if ( pal_dst_save) {
		if ( is_apt(aptCompatiblePS))
			SelectPalette( sys ps, pal_dst_save, 1);
		else {
			DeleteObject( pal_dst_save );
			dsys( image) pal = image_create_palette( image);
		}
	}
	if ( bm_src_save) SelectObject( src, bm_src_save);
	DeleteDC( src);

	return ok;
}

static Bool
img_put_alpha_blend( HDC dst, HDC src, PutImageRequest * req)
{
	Bool ok;
	BLENDFUNCTION bf;
	bf.BlendOp             = AC_SRC_OVER;
	bf.BlendFlags          = 0;
	bf.SourceConstantAlpha = 0xff;
	bf.AlphaFormat         = AC_SRC_ALPHA;
	ok = AlphaBlend(
		dst, req-> dst_x, req-> dst_y, req-> dst_w, req-> dst_h,
		src, req-> src_x, req-> src_y, req-> src_w, req-> src_h,
		bf);

	if (!ok) apiErr;
	return ok;
}

/* on bitmap */
static Bool
img_put_bitmap_on_bitmap( Handle self, Handle image, PutImageRequest * req)
{
	STYLUS_USE_TEXT( sys ps);
	STYLUS_USE_BRUSH( sys ps);
	if ( dsys( image) options. aptDeviceBitmap )
		req-> rop = rop_reduce(GetTextColor( sys ps), GetBkColor( sys ps), req-> rop);
	return img_put_stretch_blt_viewport( sys ps, dsys(image)ps, req);
}

static Bool
img_put_pixmap_on_bitmap( Handle self, Handle image, PutImageRequest * req)
{
	return img_put_stretch_blt_viewport( sys ps, dsys(image)ps, req);
}

static Bool
img_put_image_on_bitmap( Handle self, Handle image, PutImageRequest * req)
{
	return img_put_image_on_bitmap_or_pixmap( self, image, req, BM_BITMAP);
}

static Bool
img_put_argb_on_bitmap( Handle self, Handle image, PutImageRequest * req)
{
	if ( !img_put_and_mask( sys ps, image, req))
		return false;
	req-> rop = (req->rop == ropSrcCopy) ? ropCopyPut : ropOrPut;
	return img_put_image_on_bitmap( self, image, req );
}

static Bool
img_put_layered_on_bitmap( Handle self, Handle image, PutImageRequest * req)
{
	Bool ok;
	Handle icon;
	PIcon i;
	uint32_t * argb_bits;
	Byte * rgb_bits, *a_bits;
	int y;
	
	icon = (Handle) create_object("Prima::Icon", "");
	i = (PIcon) icon;

	CIcon(icon)-> create_empty_icon( icon, req->src_w, req->src_h, imRGB, imbpp8);
	for ( 
		y = 0, 
			rgb_bits = i->data,
			a_bits   = i->mask,
			argb_bits = dsys(image) s. image. argbBits + req->src_y * i-> w + req-> src_x;
		y < req-> src_h;
		y++,
			rgb_bits  += i-> lineSize,
			a_bits    += i-> maskLine,
			argb_bits += i-> w
	) {
		register Byte *rgb_ptr = rgb_bits, *a_ptr = a_bits, *argb_ptr = (Byte*) argb_bits;
		register int x = req-> src_w;
		for ( ; x > 0; x--) {
			*rgb_ptr++ = *argb_ptr++;
			*rgb_ptr++ = *argb_ptr++;
			*rgb_ptr++ = *argb_ptr++;
			*a_ptr++   = *argb_ptr++;
		}
	}
	ok = img_put_argb_on_bitmap( self, icon, req);
	Object_destroy( icon );
	return ok;
}

/* on pixmap */
static Bool
img_put_monodc_on_pixmap( HDC dst, HDC src, PutImageRequest * req)
{
	Bool ok;
	COLORREF oFore  = GetTextColor( dst);
	COLORREF oBack  = GetBkColor( dst);
	SetTextColor( dst, 0x00000000);
	SetBkColor  ( dst, 0x00FFFFFF);
	ok = img_put_stretch_blt_viewport( dst, src, req);
	SetTextColor( dst, oFore);
	SetBkColor  ( dst, oBack);
	return ok;
}

static Bool
img_put_bitmap_on_pixmap( Handle self, Handle image, PutImageRequest * req)
{
	if ( dsys( image) options. aptDeviceBitmap ) {
		STYLUS_USE_TEXT( sys ps);
		STYLUS_USE_BRUSH( sys ps);
		return img_put_stretch_blt_viewport( sys ps, dsys(image)ps, req);
	} else 
		return img_put_monodc_on_pixmap( sys ps, dsys(image)ps, req);
}

static Bool
img_put_image_on_pixmap( Handle self, Handle image, PutImageRequest * req)
{
	return img_put_image_on_bitmap_or_pixmap( self, image, req, BM_PIXMAP);
}

static Bool
img_put_pixmap_on_pixmap( Handle self, Handle image, PutImageRequest * req)
{
	if ( dsys( image ) options. aptImage && (( PImage(image)-> type & imBPP ) == 1))
		return img_put_monodc_on_pixmap( sys ps, dsys(image)ps, req);
	else if ( !dsys(image) options. aptCompatiblePS) {
		Bool ok;
		Handle img = image_from_dc(image);
		ok = img_put_image_on_pixmap(self, img, req);
		Object_destroy( img);
		return ok;
	} else
		return img_put_stretch_blt_viewport( sys ps, dsys(image)ps, req);
}

static Bool
img_put_argb_on_pixmap( Handle self, Handle image, PutImageRequest * req)
{
	Bool ok;
	HDC src;
	HBITMAP old;

	if ( req-> rop == ropSrcCopy ) {
		req-> rop = ropCopyPut;
		return img_put_image_on_pixmap( self, image, req);
	}

	image_fill_bitmap_cache( image, BM_LAYERED, self );
	if ( dsys(image) bm == NULL)
		return false;

	src = CreateCompatibleDC(sys ps);
	old = SelectObject(src, dsys (image) bm);
	ok = img_put_alpha_blend( sys ps, src, req);
	SelectObject(src, old);
	DeleteDC(src);

	return ok;
}

static Bool
img_put_layered_on_pixmap( Handle self, Handle image, PutImageRequest * req)
{
	if ( req-> rop == ropSrcCopy ) {
		req-> rop = ropCopyPut;
		return img_put_pixmap_on_pixmap( self, image, req);
	} else
		return img_put_alpha_blend( sys ps, dsys(image)ps, req);
}

/* layered */
static void
img_draw_black_rect( Handle self, PutImageRequest * req)
{
	HGDIOBJ  oldp = SelectObject( sys ps, hPenHollow);
	HGDIOBJ  oldh = SelectObject( sys ps, CreateSolidBrush( RGB(0,0,0 )));
	if ( !SetROP2( sys ps, R2_COPYPEN)) apiErr;
	if ( !Rectangle( sys ps, req-> dst_x, req-> dst_y, req-> dst_x + req-> dst_w + 1, req-> dst_y + req-> dst_h + 1)) apiErr;
	if ( !SetROP2( sys ps, sys currentROP)) apiErr;
	SelectObject( sys ps, oldp);
	DeleteObject( SelectObject( sys ps, oldh));
}

static Bool
img_put_argb_on_layered( Handle self, Handle image, PutImageRequest * req)
{
	Bool ok;
	HDC src;
	HBITMAP old;

	image_fill_bitmap_cache( image, BM_LAYERED, self );
	if ( dsys(image) bm == NULL)
		return false;

	src = CreateCompatibleDC(sys ps);
	old = SelectObject(src, dsys (image) bm);
	if ( req-> rop == ropSrcCopy ) {
		req-> rop = ropCopyPut;
		img_draw_black_rect( self, req );
		ok = img_put_stretch_blt_viewport( sys ps, src, req);
	} else
		ok = img_put_alpha_blend( sys ps, src, req);
	SelectObject(src, old);
	DeleteDC(src);

	return ok;
}

static Bool
img_put_a8_on_layered( Handle self, Handle image, PutImageRequest * req)
{
	Bool ok;
	HDC dc, buf_dc;
	HBITMAP buf_bm, old_bm;
	PImage i;
	unsigned int dst_lw, src_lw, y;
	Byte *src, *dst;

	i = (PImage) image;
	if ( i-> type != imByte || i-> w != req-> dst_w || i-> h != req-> dst_h ) {
		Handle dup = CImage( image )->dup(image);
		if ( i-> type != imByte )
			CImage( dup )->set_type(dup, imByte);
		if (i-> w != req-> dst_w || i-> h != req-> dst_h )
			CImage( dup )->stretch(dup, req->dst_w, req-> dst_h);
		ok = img_put_a8_on_layered( self, dup, req);
		Object_destroy(dup);
		return ok;
	}
	
	dc     = GetDC(NULL);
	buf_dc = CreateCompatibleDC(dc);
	if ( !(buf_bm = image_create_argb_dib_section(dc, req-> dst_w, req-> dst_h, (uint32_t**) &dst))) {
		DeleteDC(buf_dc);
		ReleaseDC(NULL, dc);
		return false;
	}

	old_bm = SelectObject(buf_dc, buf_bm);

	BitBlt( buf_dc, 0, 0, req-> dst_w, req-> dst_h, sys ps, req-> dst_x, req-> dst_y, SRCCOPY);

	src    = i-> data;
	dst_lw = req-> dst_w * 4;
	src_lw = i-> lineSize;
	for ( y = 0; y < i-> h; y++, src += src_lw, dst += dst_lw ) {
		register Byte *ss = src, *dd = dst + 3;
		register unsigned int w = i-> w;
		while (w--) {
			*dd = *ss++;
			dd += 4;
		}
	}

	BitBlt( sys ps, req-> dst_x, req-> dst_y, req-> dst_w, req-> dst_h, buf_dc, 0, 0, SRCCOPY);
	
	SelectObject(buf_dc, old_bm);
	DeleteDC(buf_dc);
	DeleteObject(buf_bm);
	ReleaseDC(NULL, dc);
	return true;
}

static Bool
img_put_layered_on_layered( Handle self, Handle image, PutImageRequest * req)
{
	if ( req-> rop == ropSrcCopy ) {
		req-> rop = ropCopyPut;
		img_draw_black_rect( self, req );
		return img_put_stretch_blt_viewport( sys ps, dsys(image)ps, req);
	} else
		return img_put_alpha_blend( sys ps, dsys(image)ps, req);
}

PutImageFunc (*img_put_on_bitmap[SRC_NUM]) = {
	img_put_bitmap_on_bitmap,
	img_put_pixmap_on_bitmap,
	img_put_layered_on_bitmap,
	img_put_image_on_bitmap,
	img_put_image_on_bitmap,
	img_put_argb_on_bitmap,
};

PutImageFunc (*img_put_on_pixmap[SRC_NUM]) = {
	img_put_bitmap_on_pixmap,
	img_put_pixmap_on_pixmap,
	img_put_layered_on_pixmap,
	img_put_image_on_pixmap,
	img_put_image_on_pixmap,
	img_put_argb_on_pixmap,
};

PutImageFunc (*img_put_on_layered[SRC_NUM]) = {
	img_put_bitmap_on_pixmap,
	img_put_pixmap_on_pixmap,
	img_put_layered_on_layered,
	img_put_image_on_pixmap,
	img_put_a8_on_layered,
	img_put_argb_on_layered,
};

Bool
apc_gp_stretch_image( Handle self, Handle image, int x, int y, int xFrom, int yFrom, int xDestLen, int yDestLen, int xLen, int yLen, int rop)
{
	PIcon img = (PIcon) image;
	PutImageRequest req;
	PutImageFunc ** dst = NULL;
	int src = -1;
	Bool and_mask = false;

	objCheck false;
	dobjCheck(image) false;

	if ( xLen <= 0 || yLen <= 0) return false;

	memset( &req, 0, sizeof(req));
	req. src_x = xFrom;
	req. src_y = img->h - yFrom - yLen;
	req. src_w = xLen;
	req. src_h = yLen;
	req. dst_x = x;
	req. dst_y = sys lastSize. y - y - yDestLen;
	req. dst_w = xDestLen;
	req. dst_h = yDestLen;
	req. rop   = rop;

	if ( dsys( image) options. aptDeviceBitmap ) {
		PDeviceBitmap p = (PDeviceBitmap) image;
		switch (p->type) {
		case dbtBitmap:  src = SRC_BITMAP;  break;
		case dbtPixmap:  src = SRC_PIXMAP;  break;
		case dbtLayered: src = SRC_LAYERED; break;
		}
	} else if ( dsys( image) options. aptIcon ) {
		Bool src_mono = img-> type == imBW;
		if ( img-> maskType == imbpp1 || guts. displayBMInfo. bmiHeader. biBitCount <= 8) {
			if ( img-> options. optInDraw )
				src = src_mono ? SRC_BITMAP : SRC_PIXMAP;
			else
				src = SRC_IMAGE;
			and_mask = true;
		} else if ( img-> maskType == imbpp8 ) {
			if ( img-> options. optInDraw ) {
				src = SRC_LAYERED;
			} else
				src = SRC_ARGB;
		}
	} else if ( dsys( image) options. aptImage ) {
		Bool src_mono = img-> type == imBW;
		if ( img-> options. optInDraw )
			src = src_mono ? SRC_BITMAP : SRC_PIXMAP;
		else
			src = SRC_IMAGE;
	}
	if ( src < 0 ) {
		warn("cannot guess image type");
		return false;
	}

	if (( is_apt(aptDeviceBitmap) && ((PDeviceBitmap)self)->type == dbtBitmap) ||
		( is_apt(aptImage)        && ((PImage)self)-> type == imBW ))
		dst = img_put_on_bitmap;
	else if ( is_apt(aptLayered))
		dst = img_put_on_layered;
	else if (( is_apt(aptDeviceBitmap) && ((PDeviceBitmap)self)->type == dbtPixmap) ||
		(is_apt(aptImage)        && ((PImage)self)-> type != imBW ))
		dst = img_put_on_pixmap;
	else if ( apc_widget_get_layered_request(self) && apc_widget_surface_is_layered(self))
		dst = img_put_on_layered;
	else
		dst = img_put_on_pixmap;
	
	if (
		dst == img_put_on_layered &&
		src == SRC_IMAGE &&
		!dsys( image) options. aptIcon &&
		(((PImage)image)->type & imGrayScale) &&
		rop == ropAlphaCopy ) {
		src = SRC_A8;
		rop = ropCopyPut;
	}

	if ( rop > ropNoOper ) return false;
	
	if ( dst[src] == NULL ) {
		warn("not implemented");
		return false;
	}

	if ( and_mask ) {
		if ( !img_put_and_mask(sys ps, image, &req))
			return false;
		req. rop = ropXorPut;
	}

	return (*dst[src])(self, image, &req);
}


Bool
apc_image_create( Handle self)
{
	objCheck false;
	apt_set( aptImage);
	if ( kind_of( self, CIcon )) apt_set( aptIcon );
	image_destroy_cache( self);
	sys lastSize. x = var w;
	sys lastSize. y = var h;
	return true;
}

Bool
apc_image_destroy( Handle self)
{
	objCheck false;
	image_destroy_cache( self);
	return true;
}

Bool
apc_image_begin_paint( Handle self)
{
	apcErrClear;
	objCheck false;
	image_fill_bitmap_cache( self, BM_AUTO, nilHandle);
	if ( sys bm == NULL ) {
		image_destroy_cache( self );
		return false;
	}
	if ( !( sys ps = CreateCompatibleDC( 0))) apiErrRet;
	sys stockBM = SelectObject( sys ps, sys bm);
	hwnd_enter_paint( self);

	apt_clear( aptLayered );
	if ( is_apt( aptIcon ) && PIcon(self)-> maskType == imbpp8 ) {
		sys bpp = 32;
		apt_set( aptLayered );
	}
	else if ( PImage( self)-> type == imBW)
		sys bpp = 1;
	if ( sys pal) {
		SelectPalette( sys ps, sys pal, 0);
		RealizePalette( sys ps);
	}
	return true;
}

Bool
apc_image_begin_paint_info( Handle self)
{
	apcErrClear;
	objCheck false;
	if ( !( sys ps = CreateCompatibleDC( 0))) apiErrRet;
	if ( !sys pal) sys pal = image_create_palette( self);
	if ( sys pal) SelectPalette( sys ps, sys pal, 0);
	hwnd_enter_paint( self);
	if ( PImage( self)-> type == imBW)
		sys bpp = 1;
	else if ( is_apt( aptIcon ) && PIcon(self)-> maskType == imbpp8 ) {
		sys bpp = 32;
		apt_set( aptLayered );
	}
	return true;
}

Bool
apc_image_end_paint( Handle self)
{
	apcErrClear;
	objCheck false;

	if ( is_apt( aptLayered))
		argb_query_bits( self);
	else
		image_query_bits( self, false);
	hwnd_leave_paint( self);
	if ( sys stockBM)
		SelectObject( sys ps, sys stockBM);
	DeleteDC( sys ps);
	sys stockBM = nil;
	sys ps = nil;
	return apcError == errOk;
}

Bool
apc_image_end_paint_info( Handle self)
{
	objCheck false;
	apcErrClear;
	hwnd_leave_paint( self);
	DeleteDC( sys ps);
	sys ps = nil;
	return apcError == errOk;
}


Bool
apc_image_update_change( Handle self)
{
	objCheck false;
	image_destroy_cache( self);
	sys lastSize. x = var w;
	sys lastSize. y = var h;
	return true;
}

HBITMAP
image_create_argb_dib_section( HDC dc, int w, int h, uint32_t ** ptr)
{
	HBITMAP bm;
	BITMAPINFO bmi;
	uint32_t * dummy;
	
	if ( !ptr ) ptr = &dummy;
	
	ZeroMemory(&bmi, sizeof(BITMAPINFO));
	bmi.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
	bmi.bmiHeader.biWidth       = w;
	bmi.bmiHeader.biHeight      = h;
	bmi.bmiHeader.biPlanes      = 1;
	bmi.bmiHeader.biBitCount    = 32;
	bmi.bmiHeader.biCompression = BI_RGB;
	bmi.bmiHeader.biSizeImage   = w * h * 4;
	if ( !( bm = CreateDIBSection(dc, &bmi, DIB_RGB_COLORS, (LPVOID*)ptr, NULL, 0x0))) {
		apiErr;
		return NULL;
	}
	return bm;
}   

Bool
apc_dbm_create( Handle self, int type)
{
	HDC dc;
	Bool palc = 0;

	objCheck false;
	apcErrClear;
	apt_set( aptBitmap);
	apt_set( aptDeviceBitmap);
	apt_set( aptCompatiblePS);

	if ( !( sys ps = CreateCompatibleDC( 0))) apiErrRet;
	sys lastSize. x = var w;
	sys lastSize. y = var h;

	if ( type == dbtLayered && guts. displayBMInfo. bmiHeader. biBitCount <= 8)
		type = dbtPixmap;

	switch ( type ) {
	case dbtBitmap:
		dc = NULL;
		sys bm = CreateBitmap( var w, var h, 1, 1, nil);
		break;
	case dbtPixmap:
		if (!( dc = dc_alloc())) {
			DeleteDC( sys ps);
			return false;
		}
		if (( sys pal = palette_create( self))) {
			sys stockPalette = SelectPalette( sys ps, sys pal, 1);
			RealizePalette( sys ps);
			palc = 1;
		}
		sys bm = CreateCompatibleBitmap( dc, var w, var h);
		if ( guts. displayBMInfo. bmiHeader. biBitCount == 8)
			apt_clear( aptCompatiblePS);
		break;
	case dbtLayered:
		apt_set( aptLayered );
		if (!( dc = dc_alloc())) {
			DeleteDC( sys ps);
			return false;
		}
		sys bm = image_create_argb_dib_section( dc, var w, var h, &sys s. image. argbBits);
		break;
	default:
		DeleteDC( sys ps);
		return false;
	}

	if ( !sys bm) {
		apiErr;
		if ( dc) dc_free();
		if ( palc) {
			SelectPalette( sys ps, sys stockPalette, 1);
			DeleteObject( sys stockPalette);
			sys stockPalette = nil;
		}
		DeleteDC( sys ps);
		return false;
	}
	if ( dc) dc_free();

	sys stockBM = SelectObject( sys ps, sys bm);

	hwnd_enter_paint( self);
	switch ( type ) {
	case dbtBitmap:
		sys bpp = 1;
		break;
	case dbtLayered:
		sys bpp = 32;
		break;
	}

	hash_store( imageMan, &self, sizeof( self), (void*)self);
	return true;
}

void
dbm_recreate( Handle self)
{
	HBITMAP bm, stock;
	HDC dc, dca;
	HPALETTE p = nil;
	Event ev = {cmSysHandle};

	if ((( PDeviceBitmap) self)-> type != dbtPixmap ) return;

	if ( !( dc = CreateCompatibleDC( 0))) {
		apiErr;
		return;
	}
	if (!( dca = dc_alloc())) {
		DeleteDC( dc);
		return;
	}

	if ( sys pal) {
		p = SelectPalette( dc, sys pal, 1);
		RealizePalette( dc);
	}

	if ( !( bm = CreateCompatibleBitmap( dca, var w, var h))) {
		DeleteDC( dc);
		dc_free();
		apiErr;
		return;
	}
	stock = SelectObject( dc, bm);

	BitBlt( dc, 0, 0, var w, var h, sys ps, 0, 0, SRCCOPY);

	if ( sys pal) {
		SelectPalette( sys ps, sys stockPalette, 1);
		sys stockPalette = p;
	} else
		sys stockPalette = GetCurrentObject( dc, OBJ_PAL);

	if ( sys stockBM)
		SelectObject( sys ps, sys stockBM);
	DeleteObject( sys bm);
	DeleteDC( sys ps);

	sys ps = dc;
	sys bm = bm;
	sys stockBM = stock;
	dc_free();

	ev. gen. source = self;
	var self-> message( self, &ev);
}

Bool
apc_dbm_destroy( Handle self)
{
	apcErrClear;
	hash_delete( imageMan, &self, sizeof( self), false);
	objCheck false;

	hwnd_leave_paint( self);

	if ( sys pal)
		DeleteObject( sys pal);
	if ( sys stockBM)
	SelectObject( sys ps, sys stockBM);
	DeleteObject( sys bm);
	DeleteDC( sys ps);
	sys pal = nil;
	sys stockBM = nil;
	sys ps = nil;
	sys bm = nil;
	return true;
}

HICON
image_make_icon_handle( Handle img, Point size, Point * hotSpot)
{
	PIcon i = ( PIcon) img;
	HICON    r;
	ICONINFO ii;
	int    bpp = i-> type & imBPP;
	Bool  noSZ   = i-> w != size. x || i-> h != size. y;
	Bool  noBPP  = bpp != 1 && bpp != 4 && bpp != 8 && bpp != 24;
	HDC dc;
	Byte * mask;
	XBITMAPINFO bi;
	Bool notAnIcon = !dsys( img ) options. aptIcon;

	ii. fIcon = hotSpot ? false : true;
	ii. xHotspot = hotSpot ? hotSpot-> x : 0;
	ii. yHotspot = hotSpot ? hotSpot-> y : 0;

	if ( noSZ || noBPP) {
		i = ( PIcon)( i-> self-> dup( img));

		if ( noSZ)
			i-> self-> set_size(( Handle) i, size);
		if ( noBPP)
			i-> self-> set_type(( Handle) i,
				( bpp < 4) ? 1 :
				(( bpp < 8) ? 4 :
				(( bpp < 24) ? 8 : 24))
		);
	}

	if (!( dc = dc_alloc())) {
		if (( Handle) i != img) Object_destroy(( Handle) i);
		return NULL;
	}
	image_fill_bitmap_info(( Handle)i, &bi, BM_PIXMAP);
	if ( bi. bmiHeader. biClrUsed > 0)
		bi. bmiHeader. biClrUsed = bi. bmiHeader. biClrImportant = i-> palSize;

	if ( !( ii. hbmColor = CreateDIBitmap( dc, &bi. bmiHeader, CBM_INIT,
		i-> data, ( BITMAPINFO*) &bi, DIB_RGB_COLORS))) apiErr;
	bi. bmiHeader. biBitCount = bi. bmiHeader. biPlanes = 1;
	bi. bmiColors[ 0]. rgbRed = bi. bmiColors[ 0]. rgbGreen = bi. bmiColors[ 0]. rgbBlue = 0;
	bi. bmiColors[ 1]. rgbRed = bi. bmiColors[ 1]. rgbGreen = bi. bmiColors[ 1]. rgbBlue = 255;

	if ( notAnIcon )
		mask = NULL;
	else if ( i-> maskType == imbpp1)
		mask = i-> mask;
	else 
		mask = i-> self-> convert_mask((Handle)i, imbpp1);
	if ( !( ii. hbmMask  = CreateDIBitmap( dc, &bi. bmiHeader, CBM_INIT,
		mask, ( BITMAPINFO*) &bi, DIB_RGB_COLORS))) apiErr;

	if ( !notAnIcon && i-> maskType == imbpp8)
		free(mask);
	
	dc_free();

	if ( !( r = CreateIconIndirect( &ii))) apiErr;

	DeleteObject( ii. hbmColor);
	DeleteObject( ii. hbmMask);
	if (( Handle) i != img) Object_destroy(( Handle) i);
	return r;
}

ApiHandle
apc_image_get_handle( Handle self)
{
	objCheck 0;
	return ( ApiHandle) sys ps;
}

ApiHandle
apc_dbm_get_handle( Handle self)
{
	objCheck 0;
	return ( ApiHandle) sys ps;
}

ApiHandle
apc_prn_get_handle( Handle self)
{
	objCheck 0;
	return ( ApiHandle) sys ps;
}


Bool
apc_prn_create( Handle self) {
	objCheck false;
	apt_set(aptPrinter); 
	return true;
}

static void ppi_create( LPPRINTER_INFO_2 dest, LPPRINTER_INFO_2 source)
{
#define SZCPY(field) dest-> field = duplicate_string( source-> field)
	memcpy( dest, source, sizeof( PRINTER_INFO_2));
	SZCPY( pPrinterName);
	SZCPY( pServerName);
	SZCPY( pShareName);
	SZCPY( pPortName);
	SZCPY( pDriverName);
	SZCPY( pComment);
	SZCPY( pLocation);
	SZCPY( pSepFile);
	SZCPY( pPrintProcessor);
	SZCPY( pDatatype);
	SZCPY( pParameters);
	if ( source-> pDevMode)
	{
		int sz = source-> pDevMode-> dmSize + source-> pDevMode-> dmDriverExtra;
		dest-> pDevMode = ( LPDEVMODE) malloc( sz);
		if ( dest-> pDevMode) memcpy( dest-> pDevMode, source-> pDevMode, sz);
	}
}


static void ppi_destroy( LPPRINTER_INFO_2 ppi)
{
	if ( !ppi) return;
	free( ppi-> pPrinterName);
	free( ppi-> pServerName);
	free( ppi-> pShareName);
	free( ppi-> pPortName);
	free( ppi-> pDriverName);
	free( ppi-> pComment);
	free( ppi-> pLocation);
	free( ppi-> pSepFile);
	free( ppi-> pPrintProcessor);
	free( ppi-> pDatatype);
	free( ppi-> pParameters);
	free( ppi-> pDevMode);
	memset( ppi, 0, sizeof( PRINTER_INFO_2));
}


Bool
apc_prn_destroy( Handle self)
{
	ppi_destroy( &sys s. prn. ppi);
	return true;
}


static int
prn_query( Handle self, const char * printer, LPPRINTER_INFO_2 info)
{
	DWORD returned, needed;
	LPPRINTER_INFO_2 ppi, useThis = nil;
	int i;
	Bool useDefault = ( printer == nil || strlen( printer) == 0);
	char * device;

	EnumPrinters( PRINTER_ENUM_FAVORITE | PRINTER_ENUM_LOCAL, nil,
			2, nil, 0, &needed, &returned);

	ppi = ( LPPRINTER_INFO_2) malloc( needed + 4);
	if ( !ppi) return 0;

	if ( !EnumPrinters( PRINTER_ENUM_FAVORITE | PRINTER_ENUM_LOCAL, nil,
			2, ( LPBYTE) ppi, needed, &needed, &returned)) {
		apiErr;
		free( ppi);
		return 0;
	}

	if ( returned == 0) {
		apcErr( errNoPrinters);
		free( ppi);
		return 0;
	}

	device = apc_prn_get_default( self);

	for ( i = 0; i < returned; i++)
	{
		if ( useDefault && device && ( strcmp( device, ppi[ i]. pPrinterName) == 0))
		{
			useThis = &ppi[ i];
			break;
		}
		if ( !useDefault && ( strcmp( printer, ppi[ i]. pPrinterName) == 0))
		{
			useThis = &ppi[ i];
			break;
		}
	}
	if ( useDefault && useThis == nil) useThis = ppi;
	if ( useThis) ppi_create( info, useThis);
	if ( !useThis) apcErr( errInvPrinter);
	free( ppi);
	return useThis ? 1 : -2;
}


PrinterInfo*
apc_prn_enumerate( Handle self, int * count)
{
	DWORD returned, needed;
	LPPRINTER_INFO_2 ppi;
	PPrinterInfo list;
	char *printer;
	int i;

	*count = 0;
	objCheck nil;

	EnumPrinters( PRINTER_ENUM_FAVORITE | PRINTER_ENUM_LOCAL, nil, 2,
			nil, 0, &needed, &returned);

	ppi = ( LPPRINTER_INFO_2) malloc( needed + 4);
	if ( !ppi) return nil;

	if ( !EnumPrinters( PRINTER_ENUM_FAVORITE | PRINTER_ENUM_LOCAL, nil, 2,
			( LPBYTE) ppi, needed, &needed, &returned)) {
		apiErr;
		free( ppi);
		return nil;
	}

	if ( returned == 0) {
		apcErr( errNoPrinters);
		free( ppi);
		return nil;
	}

	printer = apc_prn_get_default( self);

	list = ( PPrinterInfo) malloc( returned * sizeof( PrinterInfo));
	if ( !list) {
		free( ppi);
		return nil;
	}

	for ( i = 0; i < returned; i++)
	{
		strncpy( list[ i]. name,   ppi[ i]. pPrinterName, 255);   list[ i]. name[ 255]   = 0;
		strncpy( list[ i]. device, ppi[ i]. pPortName, 255);      list[ i]. device[ 255] = 0;
		list[ i]. defaultPrinter = (( printer != nil) && ( strcmp( printer, list[ i]. name) == 0));
	}
	*count = returned;
	free( ppi);
	return list;
}

static HDC prn_info_dc( Handle self)
{
	LPPRINTER_INFO_2 ppi = &sys s. prn. ppi;
	HDC ret = CreateIC( ppi-> pDriverName, ppi-> pPrinterName, ppi-> pPortName, ppi-> pDevMode);
	if ( !ret) apiErr;
	return ret;
}

Bool
apc_prn_select( Handle self, const char* printer)
{
	int rc;
	PRINTER_INFO_2 ppi;
	HDC dc;

	objCheck false;

	rc = prn_query( self, printer, &ppi);
	if ( rc > 0)
	{
		ppi_destroy( &sys s. prn. ppi);
		memcpy( &sys s. prn. ppi, &ppi, sizeof( ppi));
	} else
		return false;

	if ( !( dc = prn_info_dc( self))) return false;
	sys res.      x = ( float) GetDeviceCaps( dc, LOGPIXELSX);
	sys res.      y = ( float) GetDeviceCaps( dc, LOGPIXELSY);
	sys lastSize. x = GetDeviceCaps( dc, HORZRES);
	sys lastSize. y = GetDeviceCaps( dc, VERTRES);
	if ( !DeleteDC( dc)) apiErr;
	return true;
}

char *
apc_prn_get_selected( Handle self)
{
	objCheck "";
	return sys s. prn. ppi. pPrinterName;
}

Point
apc_prn_get_size( Handle self)
{
	Point p = {0,0};
	objCheck p;
	return sys lastSize;
}

Point
apc_prn_get_resolution( Handle self)
{
	Point p = {0,0};
	objCheck p;
	return sys res;
}

char *
apc_prn_get_default( Handle self)
{
	objCheck "";

	GetProfileString("windows", "device", ",,,", sys s. prn. defPrnBuf, 255);
	if (( sys s. prn. device = strtok( sys s. prn. defPrnBuf, (const char *) ","))
				&& ( sys s. prn. driver = strtok((char *) NULL,
					(const char *) ", "))
				&& ( sys s. prn. port = strtok ((char *) NULL,
					(const char *) ", "))) {

	} else
		sys s. prn. device = sys s. prn. driver = sys s. prn. port = nil;

	return sys s. prn. device;
}

Bool
apc_prn_setup( Handle self)
{
	void * lph;
	LONG sz, ret;
	DEVMODE * dm;
	HWND who = GetActiveWindow();
	HDC dc;

	objCheck false;
	if ( !OpenPrinter( sys s. prn. ppi. pPrinterName, &lph, nil))
		apiErrRet;
	sz = DocumentProperties( nil, lph, sys s. prn. ppi. pPrinterName, nil, nil, 0);
	if ( sz <= 0) {
		apiErr;
		ClosePrinter( lph);
		return false;
	}
	dm  = ( DEVMODE * ) malloc( sz);
	if ( !dm) {
		ClosePrinter( lph);
		return false;
	}

	sys s. prn. ppi. pDevMode-> dmFields = -1;
	ret = DocumentProperties( hwnd_to_view( who) ? who : nil, lph, sys s. prn. ppi. pPrinterName,
		dm, sys s. prn. ppi. pDevMode, DM_IN_BUFFER|DM_IN_PROMPT|DM_OUT_BUFFER);
	ClosePrinter( lph);
	if ( ret != IDOK) {
		free( dm);
		return false;
	}
	free( sys s. prn. ppi. pDevMode);
	sys s. prn. ppi. pDevMode = dm;

	if ( !( dc = prn_info_dc( self))) return false;
	sys res.      x = ( float) GetDeviceCaps( dc, LOGPIXELSX);
	sys res.      y = ( float) GetDeviceCaps( dc, LOGPIXELSY);
	sys lastSize. x = GetDeviceCaps( dc, HORZRES);
	sys lastSize. y = GetDeviceCaps( dc, VERTRES);
	if ( !DeleteDC( dc)) apiErr;

	return true;
}

typedef struct _PrnKey
{
	long  value;
	char * name;
} PrnKey;

static PrnKey ctx_options[] = {
	{ DM_ORIENTATION     , "Orientation" },
	{ DM_PAPERSIZE       , "PaperSize" },
	{ DM_PAPERLENGTH     , "PaperLength" },
	{ DM_PAPERWIDTH      , "PaperWidth" },
	{ DM_SCALE           , "Scale" },
	{ DM_COPIES          , "Copies" },
	{ DM_DEFAULTSOURCE   , "DefaultSource" },
	{ DM_PRINTQUALITY    , "PrintQuality" },
	{ DM_COLOR           , "Color" },
	{ DM_DUPLEX          , "Duplex" },
	{ DM_YRESOLUTION     , "YResolution" },
	{ DM_TTOPTION        , "TTOption" },
	{ DM_COLLATE         , "Collate" },
	{ DM_FORMNAME        , "FormName" }
};

static PrnKey ctx_orientation[] = {
	{ DMORIENT_PORTRAIT   ,"Portrait" },
	{ DMORIENT_LANDSCAPE  ,"Landscape" }
};

static PrnKey ctx_papersize[] = {
	{ DMPAPER_LETTER             , "Letter" },
	{ DMPAPER_LETTERSMALL        , "LetterSmall" },
	{ DMPAPER_TABLOID            , "Tabloid" },
	{ DMPAPER_LEDGER             , "Ledger" },
	{ DMPAPER_LEGAL              , "Legal" },
	{ DMPAPER_STATEMENT          , "Statement" },
	{ DMPAPER_EXECUTIVE          , "Executive" },
	{ DMPAPER_A3                 , "A3" },
	{ DMPAPER_A4                 , "A4" },
	{ DMPAPER_A4SMALL            , "A4Small" },
	{ DMPAPER_A5                 , "A5" },
	{ DMPAPER_B4                 , "B4" },
	{ DMPAPER_B5                 , "B5" },
	{ DMPAPER_FOLIO              , "Folio" },
	{ DMPAPER_QUARTO             , "Quarto" },
	{ DMPAPER_10X14              , "10X14" },
	{ DMPAPER_11X17              , "11X17" },
	{ DMPAPER_NOTE               , "Note" },
	{ DMPAPER_ENV_9              , "ENV_9" },
	{ DMPAPER_ENV_10             , "ENV_10" },
	{ DMPAPER_ENV_11             , "ENV_11" },
	{ DMPAPER_ENV_12             , "ENV_12" },
	{ DMPAPER_ENV_14             , "ENV_14" },
	{ DMPAPER_CSHEET             , "CSheet" },
	{ DMPAPER_DSHEET             , "DSheet" },
	{ DMPAPER_ESHEET             , "ESheet" },
	{ DMPAPER_ENV_DL             , "ENV_DL" },
	{ DMPAPER_ENV_C5             , "ENV_C5" },
	{ DMPAPER_ENV_C3             , "ENV_C3" },
	{ DMPAPER_ENV_C4             , "ENV_C4" },
	{ DMPAPER_ENV_C6             , "ENV_C6" },
	{ DMPAPER_ENV_C65            , "ENV_C65" },
	{ DMPAPER_ENV_B4             , "ENV_B4" },
	{ DMPAPER_ENV_B5             , "ENV_B5" },
	{ DMPAPER_ENV_B6             , "ENV_B6" },
	{ DMPAPER_ENV_ITALY          , "ENV_Italy" },
	{ DMPAPER_ENV_MONARCH        , "ENV_Monarch" },
	{ DMPAPER_ENV_PERSONAL       , "ENV_Personal" },
	{ DMPAPER_FANFOLD_US         , "Fanfold_US" },
	{ DMPAPER_FANFOLD_STD_GERMAN , "Fanfold_Std_German" },
	{ DMPAPER_FANFOLD_LGL_GERMAN , "Fanfold_Lgl_German" }
#if(WINVER >= 0x0400)
	,
	{ DMPAPER_ISO_B4             , "ISO_B4" },
	{ DMPAPER_JAPANESE_POSTCARD  , "Japanese_Postcard" },
	{ DMPAPER_9X11               , "9X11" },
	{ DMPAPER_10X11              , "10X11" },
	{ DMPAPER_15X11              , "15X11" },
	{ DMPAPER_ENV_INVITE         , "ENV_Invite" },
	{ DMPAPER_RESERVED_48        , "RESERVED_48" },
	{ DMPAPER_RESERVED_49        , "RESERVED_49" },
	{ DMPAPER_LETTER_EXTRA       , "Letter_Extra" },
	{ DMPAPER_LEGAL_EXTRA        , "Legal_Extra" },
	{ DMPAPER_TABLOID_EXTRA      , "Tabloid_Extra" },
	{ DMPAPER_A4_EXTRA           , "A4_Extra" },
	{ DMPAPER_LETTER_TRANSVERSE  , "Letter_Transverse" },
	{ DMPAPER_A4_TRANSVERSE      , "A4_Transverse" },
	{ DMPAPER_LETTER_EXTRA_TRANSVERSE, "Per_Letter_Extra_Transverse" },
	{ DMPAPER_A_PLUS             , "A_Plus" },
	{ DMPAPER_B_PLUS             , "B_Plus" },
	{ DMPAPER_LETTER_PLUS        , "Letter_Plus" },
	{ DMPAPER_A4_PLUS            , "A4_Plus" },
	{ DMPAPER_A5_TRANSVERSE      , "A5_Transverse" },
	{ DMPAPER_B5_TRANSVERSE      , "B5_Transverse" },
	{ DMPAPER_A3_EXTRA           , "A3_Extra" },
	{ DMPAPER_A5_EXTRA           , "A5_Extra" },
	{ DMPAPER_B5_EXTRA           , "B5_Extra" },
	{ DMPAPER_A2                 , "A2" },
	{ DMPAPER_A3_TRANSVERSE      , "A3_Transverse" },
	{ DMPAPER_A3_EXTRA_TRANSVERSE, "A3_Extra_Transverse" }
#endif
};

static PrnKey ctx_defsource[] = {
	{ DMBIN_AUTO              , "Auto" },
	{ DMBIN_CASSETTE          , "Cassette" },
	{ DMBIN_ENVELOPE          , "Envelope" },
	{ DMBIN_ENVMANUAL         , "EnvManual" },
	{ DMBIN_FORMSOURCE        , "FormSource" },
	{ DMBIN_LARGECAPACITY     , "LargeCapacity" },
	{ DMBIN_LARGEFMT          , "LargeFmt" },
	{ DMBIN_LOWER             , "Lower" },
	{ DMBIN_MANUAL            , "Manual" },
	{ DMBIN_MIDDLE            , "Middle" },
	{ DMBIN_ONLYONE           , "OnlyOne" },
	{ DMBIN_TRACTOR           , "Tractor" },
	{ DMBIN_SMALLFMT          , "SmallFmt" },
	{ DMBIN_USER+0            , "User0" },
	{ DMBIN_USER+1            , "User1" },
	{ DMBIN_USER+2            , "User2" },
	{ DMBIN_USER+3            , "User3" },
	{ DMBIN_USER+4            , "User4" }
};

static PrnKey ctx_quality[] = {
	{ DMRES_HIGH    , "High" },
	{ DMRES_MEDIUM  , "Medium" },
	{ DMRES_LOW     , "Low" },
	{ DMRES_DRAFT   , "Draft" }
};

static PrnKey ctx_color[] = {
	{ DMCOLOR_COLOR , "Color" },
	{ DMCOLOR_MONOCHROME, "Monochrome" }
};

static PrnKey ctx_duplex[] = {
	{ DMDUP_SIMPLEX ,   "Simplex" },
	{ DMDUP_HORIZONTAL, "Horizontal" },
	{ DMDUP_VERTICAL,   "Vertical" }
};

static PrnKey ctx_ttoption[] = {
	{ DMTT_BITMAP,           "Bitmap" },
	{ DMTT_DOWNLOAD,         "Download" },
#if(WINVER >= 0x0400)
	{ DMTT_DOWNLOAD_OUTLINE, "Download_Outline" },
#endif
	{ DMTT_SUBDEV,           "SubDev" }
};

static char *
ctx_prn_find_string( PrnKey * table, int table_size, long value)
{
	int i;
	for ( i = 0; i < table_size; i++, table++) {
		if ( table-> value == value) 
			return table-> name;
	}
	return nil;
}

#define BADVAL -16384

static long 
ctx_prn_find_value( PrnKey * table, int table_size, char * name)
{
	int i;
	for ( i = 0; i < table_size; i++, table++) {
		if ( strcmp( table-> name, name) == 0)
			return table-> value;
	}
	return BADVAL;
}

Bool  
apc_prn_set_option( Handle self, char * option, char * value) 
{ 
	long v, num;
	char * e;
	LPDEVMODE dev = sys s. prn. ppi. pDevMode;

	objCheck false;
	if ( !dev) return false;

	v = ctx_prn_find_value( ctx_options, sizeof(ctx_options)/sizeof(PrnKey), option);
	if ( v == BADVAL) return false;

	/* DM_FORMNAME string is special because it's a literal string */
	if ( v == DM_FORMNAME) {
		strncpy((char*) dev-> dmFormName, value, CCHFORMNAME);
		dev-> dmFormName[CCHFORMNAME-1] = 0;
		return true;
	}

	/* any other setting may be a number */
	num = strtol( value, &e, 10);

#define LOOKUP_INT(table) \
	if ( *e) { \
		/* not a numerical */ \
		v = ctx_prn_find_value( table, sizeof(table)/sizeof(PrnKey), value); \
		if ( v == BADVAL) return false; \
	} else { \
		v = num;\
	}
	
	switch ( v) {
	case DM_ORIENTATION:
		LOOKUP_INT( ctx_orientation);
		dev-> dmOrientation = v;
		break;
	case DM_PAPERSIZE:
		LOOKUP_INT( ctx_papersize);
		dev-> dmPaperSize = v;
		break;
	case DM_PAPERLENGTH:
		if (*e) return false;
		dev-> dmPaperLength = v;
		break;
	case DM_PAPERWIDTH:
		if (*e) return false;
		dev-> dmPaperWidth = v;
		break;
	case DM_SCALE:
		if (*e) return false;
		dev-> dmScale = v;
		break;
	case DM_COPIES:
		if (*e) return false;
		dev-> dmCopies = v;
		break;
	case DM_DEFAULTSOURCE:
		LOOKUP_INT( ctx_defsource);
		dev-> dmDefaultSource = v;
		break;
	case DM_PRINTQUALITY:
		LOOKUP_INT( ctx_quality);
		dev-> dmPrintQuality = v;
		break;
	case DM_COLOR:
		LOOKUP_INT( ctx_color);
		dev-> dmColor = v;
		break;
	case DM_DUPLEX:
		LOOKUP_INT( ctx_duplex);
		dev-> dmDuplex = v;
		break;
	case DM_TTOPTION:
		LOOKUP_INT( ctx_ttoption);
		dev-> dmTTOption = v;
		break;
	case DM_YRESOLUTION:
		if (*e) return false;
		dev-> dmYResolution = v;
		break;
	case DM_COLLATE:
		if (*e) return false;
		dev-> dmCollate = v;
		break;
	default:
		return false;
	}

	return true; 
}


Bool 
apc_prn_get_option( Handle self, char * option, char ** value) 
{
	long v;
	char * c = nil, buf[256];
	LPDEVMODE dev = sys s. prn. ppi. pDevMode;

	*value = nil;
	
	objCheck false;
	if ( !dev) return false;

	v = ctx_prn_find_value( ctx_options, sizeof(ctx_options)/sizeof(PrnKey), option);
	if ( v == BADVAL) return false;

#define LOOKUP_STR(table,value) \
	/* is a defined string? */ \
	if (( c = ctx_prn_find_string( \
		table, sizeof(table)/sizeof(PrnKey), value) \
	) == nil) { \
		/* return just a number */ \
		sprintf( c = buf, "%d", value); \
	}
	
	switch ( v) {
	case DM_ORIENTATION:
		LOOKUP_STR( ctx_orientation, dev-> dmOrientation);
		break;
	case DM_PAPERSIZE:
		LOOKUP_STR( ctx_papersize, dev-> dmPaperSize);
		break;
	case DM_PAPERLENGTH:
		sprintf( c = buf, "%d", dev-> dmPaperLength);
		break;
	case DM_PAPERWIDTH:
		sprintf( c = buf, "%d", dev-> dmPaperWidth);
		break;
	case DM_SCALE:
		sprintf( c = buf, "%d", dev-> dmScale);
		break;
	case DM_COPIES:
		sprintf( c = buf, "%d", dev-> dmCopies);
		break;
	case DM_DEFAULTSOURCE:
		LOOKUP_STR( ctx_defsource, dev-> dmDefaultSource);
		break;
	case DM_PRINTQUALITY:
		LOOKUP_STR( ctx_quality, dev-> dmPrintQuality);
		break;
	case DM_COLOR:
		LOOKUP_STR( ctx_color, dev-> dmColor);
		break;
	case DM_DUPLEX:
		LOOKUP_STR( ctx_duplex, dev-> dmDuplex);
		break;
	case DM_TTOPTION:
		LOOKUP_STR( ctx_ttoption, dev-> dmTTOption);
		break;
	case DM_YRESOLUTION:
		sprintf( c = buf, "%d", dev-> dmYResolution);
		break;
	case DM_COLLATE:
		sprintf( c = buf, "%d", dev-> dmCollate);
		break;
	case DM_FORMNAME:
		strncpy( c = buf, (char*)dev-> dmFormName, CCHFORMNAME);
		break;
	default:
		return false;
	}

	if ( c) 
		*value = duplicate_string( c);

	return true; 
}

Bool 
apc_prn_enum_options( Handle self, int * count, char *** options) 
{ 
	LPDEVMODE dev = sys s. prn. ppi. pDevMode;
	int i, size;
	PrnKey * table;

	*count = 0;
	objCheck false;
	if ( !dev) return false;

	if ( !(*options = malloc( sizeof(char*) * 32)))
		return false;

	for ( 
		i = 0, 
			size = sizeof( ctx_options) / sizeof( PrnKey),
			table = ctx_options;
		i < size;
		i++, table++
		) {
		if ( dev-> dmFields & table-> value)
			(*options)[(*count)++] = table-> name;
	}

	return true; 
}


#define apiPrnErr       {                  \
	rc = GetLastError();                    \
	if ( rc != 1223 /* ERROR_CANCELLED */)  \
		apiAltErr( rc)                       \
	else                                    \
		apcErr( errUserCancelled);           \
}

Bool
apc_prn_begin_doc( Handle self, const char* docName)
{
	LPPRINTER_INFO_2 ppi = &sys s. prn. ppi;
	DOCINFO doc;
	doc. cbSize = sizeof( DOCINFO);
	doc. lpszDocName = docName;
	doc. lpszOutput = nil;
	doc. lpszDatatype = nil;
	doc. fwType = 0;

	objCheck false;
	if ( !( sys ps = CreateDC( ppi-> pDriverName, ppi-> pPrinterName, ppi-> pPortName, ppi-> pDevMode)))
		apiErrRet;

	if ( StartDoc( sys ps, &doc) <= 0) {
		apiPrnErr;
		DeleteDC( sys ps);
		sys ps = nil;
		return false;
	}
	if ( StartPage( sys ps) <= 0) {
		apiPrnErr;
		DeleteDC( sys ps);
		sys ps = nil;
		return false;
	}

	hwnd_enter_paint( self);
	if (( sys pal = palette_create( self))) {
		SelectPalette( sys ps, sys pal, 0);
		RealizePalette( sys ps);
	}
	return true;
}

Bool
apc_prn_begin_paint_info( Handle self)
{
	LPPRINTER_INFO_2 ppi = &sys s. prn. ppi;

	objCheck false;
	if ( !( sys ps = CreateDC( ppi-> pDriverName, ppi-> pPrinterName, ppi-> pPortName, ppi-> pDevMode)))
		apiErrRet;

	hwnd_enter_paint( self);
	sys pal = palette_create( self);
	return true;
}


Bool
apc_prn_end_doc( Handle self)
{
	apcErrClear;

	objCheck false;
	if ( EndPage( sys ps) < 0) apiPrnErr;
	if ( EndDoc ( sys ps) < 0) apiPrnErr;

	hwnd_leave_paint( self);
	if ( sys pal) DeleteObject( sys pal);
	DeleteDC( sys ps);
	sys pal = nil;
	sys ps = nil;
	return apcError == errOk;
}

Bool
apc_prn_end_paint_info( Handle self)
{
	apcErrClear;
	objCheck false;
	hwnd_leave_paint( self);
	DeleteDC( sys ps);
	sys ps = nil;
	return apcError == errOk;
}

Bool
apc_prn_new_page( Handle self)
{
	apcErrClear;
	objCheck false;
	if ( EndPage( sys ps) < 0) apiPrnErr;
	if ( StartPage( sys ps) < 0) apiPrnErr;
	return apcError == errOk;
}

Bool
apc_prn_abort_doc( Handle self)
{
	objCheck false;
	if ( AbortDoc( sys ps) < 0) apiPrnErr;
	hwnd_leave_paint( self);
	if ( sys pal) DeleteObject( sys pal);
	DeleteDC( sys ps);
	sys pal = nil;
	sys ps = nil;
	return apcError == errOk;
}

#ifdef __cplusplus
}
#endif

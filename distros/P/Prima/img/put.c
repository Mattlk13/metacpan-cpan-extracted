#include "img_conv.h"
#include "Icon.h"

#ifdef __cplusplus
extern "C" {
#endif


typedef void * RegionCallbackFunc( int x, int y, int w, int h, void * param);

static void
region_foreach(
	PBoxRegionRec region, 
	int dstX, int dstY, int dstW, int dstH,
	RegionCallbackFunc * callback, void * param
) {
	Box * r;
	int j, right, top;
	if ( region == NULL ) {
		callback( dstX, dstY, dstW, dstH, param);
		return;
	}
	right = dstX + dstW;
	top   = dstY + dstH;
	r = region-> boxes;
	for ( j = 0; j < region-> n_boxes; j++, r++) {
		int xx = r->x;
		int yy = r->y;
		int ww = r->width;
		int hh = r->height;
		if ( xx + ww > right ) ww = right - xx;
		if ( yy + hh > top   ) hh = top   - yy;
		if ( xx < dstX ) {
			ww -= dstX - xx;
			xx = dstX;
		}
		if ( yy < dstY ) {
			hh -= dstY - yy;
			yy = dstY;
		}
		if ( xx + ww >= dstX && yy + hh >= dstY && ww > 0 && hh > 0 )
			callback( xx, yy, ww, hh, param );
	}
}

typedef void BitBltProc( Byte * src, Byte * dst, int count);
typedef BitBltProc *PBitBltProc;

static void
bitblt_copy( Byte * src, Byte * dst, int count)
{
	memcpy( dst, src, count);
}

static void
bitblt_move( Byte * src, Byte * dst, int count)
{
	memmove( dst, src, count);
}

static void
bitblt_or( Byte * src, Byte * dst, int count)
{
	while ( count--) *(dst++) |= *(src++);
}

static void
bitblt_and( Byte * src, Byte * dst, int count)
{
	while ( count--) *(dst++) &= *(src++);
}

static void
bitblt_xor( Byte * src, Byte * dst, int count)
{
	while ( count--) *(dst++) ^= *(src++);
}

static void
bitblt_not( Byte * src, Byte * dst, int count)
{
	while ( count--) *(dst++) = ~(*(src++));
}

static void
bitblt_notdstand( Byte * src, Byte * dst, int count)
{
	while ( count--) {
		*dst = ~(*dst) & (*(src++));
		dst++;
	}
}

static void
bitblt_notdstor( Byte * src, Byte * dst, int count)
{
	while ( count--) {
		*dst = ~(*dst) | (*(src++));
		dst++;
	}
}

static void
bitblt_notsrcand( Byte * src, Byte * dst, int count)
{
	while ( count--) *(dst++) &= ~(*(src++));
}

static void
bitblt_notsrcor( Byte * src, Byte * dst, int count)
{
	while ( count--) *(dst++) |= ~(*(src++));
}

static void
bitblt_notxor( Byte * src, Byte * dst, int count)
{
	while ( count--) {
		*dst = ~( *(src++) ^ (*dst));
		dst++;
	}
}

static void
bitblt_notand( Byte * src, Byte * dst, int count)
{
	while ( count--) {
		*dst = ~( *(src++) & (*dst));
		dst++;
	}
}

static void
bitblt_notor( Byte * src, Byte * dst, int count)
{
	while ( count--) {
		*dst = ~( *(src++) | (*dst));
		dst++;
	}
}

static void
bitblt_black( Byte * src, Byte * dst, int count)
{
	memset( dst, 0, count);
}

static void
bitblt_white( Byte * src, Byte * dst, int count)
{
	memset( dst, 0xff, count);
}

static void
bitblt_invert( Byte * src, Byte * dst, int count)
{
	while ( count--) {
		*dst = ~(*dst);
		dst++;
	}
}

static PBitBltProc
find_blt_proc( int rop )
{
	PBitBltProc proc = NULL;
	switch ( rop) {
	case ropCopyPut:
		proc = bitblt_copy;
		break;
	case ropAndPut:
		proc = bitblt_and;
		break;
	case ropOrPut:
		proc = bitblt_or;
		break;
	case ropXorPut:
		proc = bitblt_xor;
		break;
	case ropNotPut:
		proc = bitblt_not;
		break;
	case ropNotDestAnd:
		proc = bitblt_notdstand;
		break;
	case ropNotDestOr:
		proc = bitblt_notdstor;
		break;
	case ropNotSrcAnd:
		proc = bitblt_notsrcand;
		break;
	case ropNotSrcOr:
		proc = bitblt_notsrcor;
		break;
	case ropNotXor:
		proc = bitblt_notxor;
		break;
	case ropNotAnd:
		proc = bitblt_notand;
		break;
	case ropNotOr:
		proc = bitblt_notor;
		break;
	case ropBlackness:
		proc = bitblt_black;
		break;
	case ropWhiteness:
		proc = bitblt_white;
		break;
	case ropInvert:
		proc = bitblt_invert;
		break;
	default:
		proc = bitblt_copy;
	}
	return proc;
}

static Bool
img_put_alpha( Handle dest, Handle src, int dstX, int dstY, int srcX, int srcY, int dstW, int dstH, int srcW, int srcH, int rop, PBoxRegionRec region);

typedef struct {
	int srcX;
	int srcY;
	int bpp;
	int srcLS;
	int dstLS;
	int dX;
	int dY;
	Byte * src;
	Byte * dst;
	PBitBltProc proc;
} ImgPutCallbackRec;

static void
img_put_single( int x, int y, int w, int h, ImgPutCallbackRec * ptr)
{
	int i, count;
	Byte *dptr, *sptr;
	sptr  = ptr->src + ptr->srcLS * (ptr->dY + y) + ptr->bpp * (ptr->dX + x);
	dptr  = ptr->dst + ptr->dstLS * y + ptr->bpp * x;
	count = w * ptr->bpp;
	for ( i = 0; i < h; i++, sptr += ptr->srcLS, dptr += ptr->dstLS)
		ptr->proc( sptr, dptr, count);
}

Bool
img_put( Handle dest, Handle src, int dstX, int dstY, int srcX, int srcY, int dstW, int dstH, int srcW, int srcH, int rop, PBoxRegionRec region)
{
	Point srcSz, dstSz;
	int asrcW, asrcH;
	Bool newObject = false;

	if ( dest == nilHandle || src == nilHandle) return false;
	if ( rop == ropNoOper) return false;

	if ( kind_of( src, CIcon)) {
		/* since src is always treated as read-only,
			employ a nasty hack here, re-assigning
			all mask values to data */
		Byte * data  = PImage( src)-> data;
		int dataSize = PImage( src)-> dataSize;
		int lineSize = PImage( src)-> lineSize;
		int palSize  = PImage( src)-> palSize;
		int type     = PImage( src)-> type;
		void *self   = PImage( src)-> self;
		RGBColor palette[2];

		if ( PIcon(src)-> maskType != imbpp1) {
			if ( PIcon(src)-> maskType != imbpp8) croak("panic: bad icon mask type");
			return img_put_alpha( dest, src, dstX, dstY, srcX, srcY, dstW, dstH, srcW, srcH, rop, region);
		}

		PImage( src)-> self     =  CImage;
		PIcon( src)-> data = PIcon( src)-> mask;
		PImage( src)-> lineSize =  PIcon( src)-> maskLine;
		PImage( src)-> dataSize =  PIcon( src)-> maskSize;
		memcpy( palette, PImage( src)-> palette, 6);
		memcpy( PImage( src)-> palette, stdmono_palette, 6);


		PImage( src)-> type     =  imBW;
		PImage( src)-> palSize  = 2;
		img_put( dest, src, dstX, dstY, srcX, srcY, dstW, dstH, srcW, srcH, ropAndPut, region);
		rop = ropXorPut;
		memcpy( PImage( src)-> palette, palette, 6);

		PImage( src)-> self     = self;
		PImage( src)-> type     = type;
		PImage( src)-> data     = data;
		PImage( src)-> lineSize = lineSize;
		PImage( src)-> dataSize = dataSize;
		PImage( src)-> palSize  = palSize;
	} else if ( rop == ropAlphaCopy ) {
		Bool ok;
		Image dummy;
		PIcon i;
		if ( !kind_of( dest, CIcon )) return false;
		if ( PImage(src)-> type != imByte ) {
			Handle dup = CImage(src)->dup(src);
			CImage(dup)->set_type(src, imByte);
			ok = img_put( dest, dup, dstX, dstY, srcX, srcY, dstW, dstH, srcW, srcH, rop, region);
			Object_destroy(dup);
			return ok;
		}
		if ( PIcon(dest)-> maskType != imbpp8) {
			CIcon(dest)-> set_maskType(dest, imbpp8);
			ok = img_put( dest, src, dstX, dstY, srcX, srcY, dstW, dstH, srcW, srcH, rop, region);
			if ( PIcon(dest)-> options. optPreserveType )
				CIcon(dest)-> set_maskType(dest, imbpp1);
			return ok;
		}

		i = (PIcon) dest;
		img_fill_dummy( &dummy, i-> w, i-> h, imByte, i-> mask, NULL);
		return img_put((Handle)&dummy, src, dstX, dstY, srcX, srcY, dstW, dstH, srcW, srcH, ropCopyPut, region);
	} else if ( rop & ropConstantAlpha )
		return img_put_alpha( dest, src, dstX, dstY, srcX, srcY, dstW, dstH, srcW, srcH, rop, region);

	srcSz. x = PImage(src)-> w;
	srcSz. y = PImage(src)-> h;
	dstSz. x = PImage(dest)-> w;
	dstSz. y = PImage(dest)-> h;

	if ( dstW < 0) {
		dstW = abs( dstW);
		srcW = -srcW;
	}
	if ( dstH < 0) {
		dstH = abs( dstH);
		srcH = -srcH;
	}

	asrcW = abs( srcW);
	asrcH = abs( srcH);

	if (
		srcX >= srcSz. x || srcX + srcW <= 0 ||
		srcY >= srcSz. y || srcY + srcH <= 0 ||
		dstX >= dstSz. x || dstX + dstW <= 0 ||
		dstY >= dstSz. y || dstY + dstH <= 0
	)
		return true;

	/* check if we can do it without expensive scalings and extractions */
	if (
		( srcW == dstW) && ( srcH == dstH) &&
		( srcX >= 0) && ( srcY >= 0) && ( srcX + srcW <= srcSz. x) && ( srcY + srcH <= srcSz. y)
	)
		goto NOSCALE;

	if ( srcX != 0 || srcY != 0 || asrcW != srcSz. x || asrcH != srcSz. y) {
	/* extract source rectangle */
		Handle x;
		int ssx = srcX, ssy = srcY, ssw = asrcW, ssh = asrcH;
		if ( ssx < 0) {
			ssw += ssx;
			ssx = 0;
		}
		if ( ssy < 0) {
			ssh += ssy;
			ssy = 0;
		}
		x = CImage( src)-> extract( src, ssx, ssy, ssw, ssh);
		if ( !x) return false;

		if ( srcX < 0 || srcY < 0 || srcX + asrcW >= srcSz. x || srcY + asrcH > srcSz. y) {
			HV * profile;
			Handle dx;
			int dsx = 0, dsy = 0, dsw = PImage(x)-> w, dsh = PImage(x)-> h, type = PImage( dest)-> type;

			if ( asrcW != srcW || asrcH != srcH) { /* reverse before application */
				CImage( x)-> stretch( x, srcW, srcH);
				srcW = asrcW;
				srcH = asrcH;
				if ( PImage(x)-> w != asrcW || PImage(x)-> h != asrcH) {
					Object_destroy( x);
					return true;
				}
			}

			if (( type & imBPP) < 8) type = imbpp8;

			profile = newHV();
			pset_i( type,        type);
			pset_i( width,       asrcW);
			pset_i( height,      asrcH);
			pset_i( conversion,  PImage( src)-> conversion);
			dx = Object_create( "Prima::Image", profile);
			sv_free((SV*)profile);
			if ( !dx) {
				Object_destroy( x);
				return false;
			}
			if ( PImage( dx)-> palSize > 0) {
				PImage( dx)-> palSize = PImage( x)-> palSize;
				memcpy( PImage( dx)-> palette, PImage( x)-> palette, 768);
			}
			memset( PImage( dx)-> data, 0, PImage( dx)-> dataSize);

			if ( srcX < 0) dsx = asrcW - dsw;
			if ( srcY < 0) dsy = asrcH - dsh;
			img_put( dx, x, dsx, dsy, 0, 0, dsw, dsh, dsw, dsh, ropCopyPut, region);
			Object_destroy( x);
			x = dx;
		}

		src = x;
		newObject = true;
		srcX = srcY = 0;
	}

	if ( srcW != dstW || srcH != dstH) {
		/* stretch & reverse */
		if ( !newObject) {
			src = CImage( src)-> dup( src);
			if ( !src) goto EXIT;
			newObject = true;
		}
		if ( srcW != asrcW) {
			dstW = -dstW;
			srcW = asrcW;
		}
		if ( srcH != asrcH) {
			dstH = -dstH;
			srcH = asrcH;
		}
		CImage(src)-> stretch( src, dstW, dstH);
		if ( PImage(src)-> w != dstW || PImage(src)-> h != dstH) goto EXIT;
		dstW = abs( dstW);
		dstH = abs( dstH);
	}

NOSCALE:

	if (( PImage( dest)-> type & imBPP) < 8) {
		PImage i = ( PImage) dest;
		int type = i-> type;
		if (rop != ropCopyPut || i-> conversion == ictNone) {
			Handle b8 = i-> self-> dup( dest);
			PImage j  = ( PImage) b8;
			int mask  = (1 << (type & imBPP)) - 1;
			int sz;
			Byte *dj, *di;
			Byte colorref[256];
			j-> self-> reset( b8, imbpp8, nil, 0);
			sz = j-> dataSize;
			dj = j-> data;
			/* change 0/1 to 0x000/0xfff for correct masking */
			while ( sz--) {
				if ( *dj == mask) *dj = 0xff;
				dj++;
			}
			img_put( b8, src, dstX, dstY, 0, 0, dstW, dstH, PImage(src)-> w, PImage(src)-> h, rop, region);
			for ( sz = 0; sz < 256; sz++) colorref[sz] = ( sz > mask) ? mask : sz;
			dj = j-> data;
			di = i-> data;

			for ( sz = 0; sz < i-> h; sz++, dj += j-> lineSize, di += i-> lineSize) {
				if (( type & imBPP) == 1)
					bc_byte_mono_cr( dj, di, i-> w, colorref);
				else
					bc_byte_nibble_cr( dj, di, i-> w, colorref);
			}
			Object_destroy( b8);
		} else {
			int conv = i-> conversion;
			i-> conversion = PImage( src)-> conversion;
			i-> self-> reset( dest, imbpp8, nil, 0);
			img_put( dest, src, dstX, dstY, 0, 0, dstW, dstH, PImage(src)-> w, PImage(src)-> h, rop, region);
			i-> self-> reset( dest, type, nil, 0);
			i-> conversion = conv;
		}
		goto EXIT;
	}

	if ( PImage( dest)-> type != PImage( src)-> type) {
		int type = PImage( src)-> type & imBPP;
		int mask = (1 << type) - 1;
		/* equalize type */
		if ( !newObject) {
			src = CImage( src)-> dup( src);
			if ( !src) goto EXIT;
			newObject = true;
		}
		CImage( src)-> reset( src, PImage( dest)-> type, nil, 0);
		if ( type < 8 && rop != ropCopyPut) {
			/* change 0/1 to 0x000/0xfff for correct masking */
			int sz   = PImage( src)-> dataSize;
			Byte * d = PImage( src)-> data;
			while ( sz--) {
				if ( *d == mask) *d = 0xff;
				d++;
			}
			memset( PImage( src)-> palette + 255, 0xff, sizeof(RGBColor));
		}
	}

	if ( PImage( dest)-> type == imbpp8) {
		/* equalize palette */
		Byte colorref[256], *s;
		int sz, i = PImage( src)-> dataSize;
		if ( !newObject) {
			src = CImage( src)-> dup( src);
			if ( !src) goto EXIT;
			newObject = true;
		}
		cm_fill_colorref(
			PImage( src)-> palette, PImage( src)-> palSize,
			PImage( dest)-> palette, PImage( dest)-> palSize,
			colorref);
		s = PImage( src)-> data;
		/* identity transform for padded ( 1->xfff, see above ) pixels */
		for ( sz = PImage( src)-> palSize; sz < 256; sz++)
			colorref[sz] = sz;
		while ( i--) {
			*s = colorref[ *s];
			s++;
		}
	}

	if ( dstX < 0 || dstY < 0 || dstX + dstW >= dstSz. x || dstY + dstH >= dstSz. y) {
		/* adjust destination rectangle */
		if ( dstX < 0) {
			dstW += dstX;
			srcX -= dstX;
			dstX = 0;
		}
		if ( dstY < 0) {
			dstH += dstY;
			srcY -= dstY;
			dstY = 0;
		}
		if ( dstX + dstW > dstSz. x)
			dstW = dstSz. x - dstX;
		if ( dstY + dstH > dstSz. y)
			dstH = dstSz. y - dstY;
	}

	/* checks done, do put_image */
	{
		ImgPutCallbackRec rec = {
			srcX  : srcX,
			srcY  : srcY,
			bpp   : ( PImage( dest)-> type & imBPP ) / 8,
			srcLS : PImage( src)-> lineSize,
			dstLS : PImage( dest)-> lineSize,
			dX    : srcX - dstX,
			dY    : srcY - dstY,
			src   : PImage( src )-> data,
			dst   : PImage( dest )-> data,
			proc  : find_blt_proc(rop)
		};
		if ( rec.proc == bitblt_copy && dest == src) /* incredible */
			rec.proc = bitblt_move;
		region_foreach( region,
			dstX, dstY, dstW, dstH,
			(RegionCallbackFunc*)img_put_single, &rec
		);
	}

EXIT:
	if ( newObject) Object_destroy( src);

	return true;
}

#define BLT_BUFSIZE 1024

typedef struct {
	int bpp;
	int count;
	int ls;
	int step;
	Byte * data;
	Byte * buf;
	PBitBltProc proc;
} ImgBarCallbackRec;

#define FILL_PATTERN_SIZE 8

static void
img_bar_single( int x, int y, int w, int h, ImgBarCallbackRec * ptr)
{
	int j, blt_bytes, blt_step, offset;
	Byte lmask, rmask;
	Byte * data;

	switch ( ptr->bpp ) {
	case 1:
		blt_bytes = (( x + w - 1) >> 3) - (x >> 3) + 1;
		lmask = ( x & 7 ) ? 255 << ( 8 - (x & 7)) : 0;
		rmask = (( x + w) & 7 ) ? 255 >> ((x + w) & 7) : 0;
		offset = x >> 3;
		break;
	case 4:
		blt_bytes = (( x + w - 1) >> 1) - (x >> 1) + 1;
		lmask = ( x & 1 )       ? 0xf0 : 0;
		rmask = (( x + w) & 1 ) ? 0x0f : 0;
		offset = x >> 1;
		break;
	case 8:
		blt_bytes = w;
		lmask = rmask = 0;
		offset = x;
		break;
	default:
		blt_bytes = w * ptr->count;
		lmask = rmask = 0;
		offset = x * ptr->count;
	}

	blt_step = (blt_bytes > ptr->step) ? ptr->step : blt_bytes;

	data = ptr->data + ptr->ls * y + offset;
	for ( j = 0; j < h; j++) {
		int bytes = blt_bytes;
		Byte lsave = *data, rsave = data[blt_bytes - 1], *p = data;
		Byte * src = ptr-> buf + ((y + j) % FILL_PATTERN_SIZE) * ptr->step;
		while ( bytes > 0 ) {
			ptr->proc( src, p, ( bytes > blt_step ) ? blt_step : bytes );
			bytes -= blt_step;
			p += blt_step;
		}
		if ( lmask ) *data = (lsave & lmask) | (*data & ~lmask);
		if ( rmask ) data[blt_bytes-1] = (rsave & rmask) | (data[blt_bytes-1] & ~rmask);
		data += ptr->ls;
	}
}

void
img_bar( Handle dest, int x, int y, int w, int h, PImgPaintContext ctx)
{
	PImage i     = (PImage) dest;
	int pixSize  = (i->type & imBPP) / 8;
	Byte blt_buffer[BLT_BUFSIZE];
	int j, k, blt_bytes, blt_step;

	/* check boundaries */
	if ( ctx->rop == ropNoOper) return;

	if ( x < 0 ) {
		w += x;
		x = 0;
	}
	if ( y < 0 ) {
		h += y;
		y = 0;
	}
	if ( x + w > i->w ) w = i->w - x;
	if ( y + h > i->h ) h = i->h - y;
	if ( w <= 0 || h <= 0 ) return;

	while ( ctx->patternOffset.x < 0 ) ctx-> patternOffset.x += FILL_PATTERN_SIZE;
	while ( ctx->patternOffset.y < 0 ) ctx-> patternOffset.y += FILL_PATTERN_SIZE;
	
	if ( memcmp( ctx->pattern, fillPatterns[fpSolid], sizeof(FillPattern)) == 0) {
		/* do nothing */
	} else if (memcmp( ctx->pattern, fillPatterns[fpEmpty], sizeof(FillPattern)) == 0) {
		if ( ctx->transparent ) return;
		/* still do nothing */
	} else if ( ctx->transparent ) {
	/* transparent stippling: if rop is simple enough, adjust parameters to
	execute it as another rop with adjusted input. Otherwise make it into
	two-step operation, such as CopyPut stippling is famously executed by
	And and Xor rops */
		#define FILL(who,val) memset( ctx->who, val, MAX_SIZEOF_PIXEL)
		switch ( ctx-> rop ) {
		case ropBlackness:
			FILL(color,0x00);
			FILL(backColor,0xff);
			ctx->rop = ropAndPut;
			break;
		case ropWhiteness:
			FILL(color,0xff);
			FILL(backColor,0x00);
			ctx->rop = ropOrPut;
			break;
		case ropInvert:
			FILL(color,0xff);
			FILL(backColor,0x00);
			ctx->rop = ropXorPut;
			break;
		case ropNotSrcAnd:
		case ropXorPut:
			FILL(backColor,0x00);
			break;
		default: {
			static int rop1[16] = {
				ropNotOr, ropXorPut, ropInvert, ropNotOr,
				ropNotSrcAnd, ropXorPut, ropNotSrcAnd, ropXorPut,
				ropNotOr, ropNotOr, ropNotSrcAnd, ropInvert,
				ropInvert, ropXorPut, ropNotSrcAnd, ropInvert
			};
			static int rop2[16] = {
				ropNotDestAnd, ropNoOper, ropNotDestAnd, ropInvert,
				ropNotSrcOr, ropNotXor, ropAndPut, ropAndPut,
				ropXorPut, ropNotAnd, ropNoOper, ropNotAnd,
				ropXorPut, ropNotSrcOr, ropNotXor, ropInvert
			};
			int rop = ctx->rop;
			FILL(backColor,0x00);
			ctx->rop = rop1[rop];
			ctx->transparent = false;
			img_bar( dest, x, y, w, h, ctx);
			FILL(backColor,0xff);
			ctx->rop = rop2[rop];
			break;
		}}
	}

	/* render a (minimum) 8x8xPIXEL matrix with pattern, then
	replicate it over blt_buffer as much as possible, to streamline
	byte operations */
	switch ( i->type & imBPP) {
	case imbpp1:
		 blt_bytes = (( x + w - 1) >> 3) - (x >> 3) + 1;
		if ( blt_bytes < FILL_PATTERN_SIZE ) blt_bytes = FILL_PATTERN_SIZE;
		break;
	case imbpp4:
		blt_bytes = (( x + w - 1) >> 1) - (x >> 1) + 1;
		if ( blt_bytes < FILL_PATTERN_SIZE / 2 ) blt_bytes = FILL_PATTERN_SIZE / 2;
		break;
	default:
		blt_bytes = w * pixSize;
		if ( blt_bytes < FILL_PATTERN_SIZE * pixSize ) blt_bytes = FILL_PATTERN_SIZE * pixSize;
	}
	blt_bytes *= FILL_PATTERN_SIZE;
	blt_step = ((blt_bytes > BLT_BUFSIZE) ? BLT_BUFSIZE : blt_bytes) / FILL_PATTERN_SIZE;
	for ( j = 0; j < FILL_PATTERN_SIZE; j++) {
		unsigned int pat, strip_size;
		Byte matrix[MAX_SIZEOF_PIXEL * FILL_PATTERN_SIZE], *buffer;
		pat = (unsigned int) ctx->pattern[(j + ctx->patternOffset. y) % FILL_PATTERN_SIZE];
		pat = (((pat << 8) | pat) >> ((ctx->patternOffset. x + 8 - (x % 8)) % FILL_PATTERN_SIZE)) & 0xff;
		buffer = blt_buffer + j * blt_step;
		switch ( i->type & imBPP) {
		case 1:
			strip_size = 1;
			matrix[0] = ctx->color[0] ? 
				(ctx->backColor[0] ? 0xff : pat) :
				(ctx->backColor[0] ? ~pat : 0);
			memset( buffer, matrix[0], blt_step);
			break;
		case 4: 
			strip_size = FILL_PATTERN_SIZE / 2;
			for ( k = 0; k < FILL_PATTERN_SIZE; ) {
				Byte c1 = *((pat & (0x80 >> k++)) ? ctx->color : ctx->backColor);
				Byte c2 = *((pat & (0x80 >> k++)) ? ctx->color : ctx->backColor);
				matrix[ (k / 2) - 1 ] = (c1 << 4) | (c2 & 0xf);
			}
			break;
		case 8: 
			strip_size = FILL_PATTERN_SIZE;
			for ( k = 0; k < FILL_PATTERN_SIZE; k++)
				matrix[k] = *((pat & (0x80 >> k)) ? ctx->color : ctx->backColor);
			break;
		default: 
			strip_size = FILL_PATTERN_SIZE * pixSize;
			for ( k = 0; k < FILL_PATTERN_SIZE; k++) {
				Byte * color = (pat & (0x80 >> k)) ? ctx->color : ctx->backColor;
				memcpy( matrix + k * pixSize, color, pixSize);
			}
		}
		if ( strip_size > 1 ) {
			Byte * buf = buffer; 
			for ( k = 0; k < blt_step / strip_size; k++, buf += strip_size)
				memcpy( buf, matrix, strip_size);
			if ( blt_step % strip_size != 0)
				memcpy( buf, matrix, blt_step % strip_size);
		}
	}
	/*
	printf("pxs:%d step:%d\n", pixSize, blt_step);
	for ( j = 0; j < blt_bytes / blt_step; j++) {
		printf("%d: ", j);
		for ( k = 0; k < blt_step; k++) {
			printf("%02x ", blt_buffer[ j * blt_step + k]);
		}
		printf("\n");
	}*/
	{
		ImgBarCallbackRec rec = {
			bpp   : (i->type & imBPP),
			count : (i->type & imBPP) / 8,
			ls    : i->lineSize,
			data  : i->data,
			buf   : blt_buffer,
			step  : blt_step,
			proc  : find_blt_proc(ctx->rop)
		};
		region_foreach( ctx->region,
			x, y, w, h,
			(RegionCallbackFunc*)img_bar_single, &rec
		);
	}
}

typedef struct {
	PImage      i;
	PBitBltProc proc;
	Bool        solid, segment_is_fg, skip_pixel;
	int         bpp, bytes, optimized_stride;
	int         current_segment, segment_offset, n_segments;
	PImgPaintContext ctx;
	Byte        *color;
} ImgHLineRec;

static void
setpixel( ImgHLineRec* rec, int x, int y)
{
	switch ( rec->bpp ) {
	case 1: {
		Byte * dst = rec->i->data + rec->i->lineSize * y + x / 8, src = *dst;
		Byte shift = 7 - (x & 7);
		src = (src >> shift) & 1;
		rec->proc( rec->color, &src, 1);
		if ( src & 1 )
			*dst |= 1 << shift;
		else
			*dst &= ~(1 << shift);
		break;
	}
	case 4: {
		Byte * dst = rec->i->data + rec->i->lineSize * y + x / 2, src = *dst, tmp = *dst;
		if ( x & 1 ) {
			rec->proc( rec->color, &src, 1);
			*dst = (tmp & 0xf0) | (src & 0x0f);
		} else {
			src >>= 4;
			rec->proc( rec->color, &src, 1);
			*dst = (tmp & 0x0f) | (src << 4);
		}
		break;
	}
	case 8:
		rec->proc( rec->color, rec->i->data + rec->i->lineSize * y + x, 1);
		break;
	default:
		rec->proc( rec->color, rec->i->data + rec->i->lineSize * y + x * rec->bytes, rec->bytes);
	}
}

static Bool
point_in_region( int x, int y, PBoxRegionRec region)
{
	int i;
	Box * b;
	for ( i = 0, b = region->boxes; i < region->n_boxes; i++, b++) {
		if ( x >= b->x && y >= b->y && x < b->x + b->width && y < b->y + b->height)
			return true;
	}
	return false;
}

#define VISIBILITY_NONE       0
#define VISIBILITY_CLIPPED    1
#define VISIBILITY_UNSURE     2
#define VISIBILITY_CLEAR      3
					
static void
hline( ImgHLineRec *rec, int x1, int x2, int y, int visibility)
{
	int n  = abs(x2 - x1) + 1;
	int dx = (x1 < x2) ? 1 : -1;
	/* printf("(%d,%d)->%d %d\n", x1, y, x2,visibility); */
	if ( rec->skip_pixel ) {
		rec->skip_pixel = false;
		if ( n-- == 1 ) return;
		x1 += dx;
	}
	if ( rec->solid) {
		if ( visibility == VISIBILITY_CLEAR ) {
			switch ( rec->bpp) {
			case 8:
			case 16:
			case 24: {
				/* optimized multipixel set */
				int wn;
				int w = rec->bytes, stride = rec->optimized_stride;
				Byte * dst = rec->i->data + rec->i->lineSize * y + ((x1 < x2) ? x1 : x2) * w;
				for ( wn = w * n; wn > 0; wn -= stride, dst += stride)
					rec->proc( rec->ctx->color, dst,
						( wn >= stride ) ? stride : wn);
				return;
			}
			default: {
				int i;
				for ( i = 0; i < n; i++, x1 += dx) setpixel(rec, x1, y);
			}}
		} else {
			/* VISIBILITY_NONE is not reaching here */
			int i;
			for ( i = 0; i < n; i++, x1 += dx)
				if ( point_in_region(x1, y, rec->ctx->region))
					setpixel(rec, x1, y);
		}
	} else {
		int i;
		for ( i = 0; i < n; i++, x1 += dx) {
			/* calculate color */
			rec->color = rec->segment_is_fg ?
				rec->ctx->color : 
				( rec->ctx->transparent ? NULL : rec->ctx->backColor )
				;
			if ( ++rec->segment_offset >= rec->ctx->linePattern[rec->current_segment]) {
				rec->segment_offset = 0;
				if ( ++rec->current_segment >= rec->n_segments ) {
					rec->current_segment = 0;
					rec->segment_is_fg = true;
				} else {
					rec->segment_is_fg = !rec->segment_is_fg;
				}
			}

			/* put pixel */
			if (
				(visibility > VISIBILITY_NONE) &&
				(rec->color != NULL) &&
				(
					(visibility == VISIBILITY_CLEAR) || 
					point_in_region(x1, y, rec->ctx->region)
				)
			)
				setpixel(rec, x1, y);
		}
	}
}

void
img_polyline( Handle dest, int n_points, Point * points, PImgPaintContext ctx)
{
	PImage i = (PImage) dest;
	int j;
	ImgHLineRec rec;
	BoxRegionRec dummy_region;
	Box dummy_region_box, *pbox;
	Point* pp;
	Rect  enclosure;
	Bool closed;

	if ( ctx->rop == ropNoOper || n_points <= 1) return;

	/* misc */
	rec.ctx     = ctx;
	rec.i       = i;
	rec.bpp     = i->type & imBPP;
	rec.bytes   = rec.bpp / 8;
	rec.proc    = find_blt_proc(ctx->rop);

	rec.solid   = (strcmp((const char*)ctx->linePattern, (const char*)lpSolid) == 0);
	if ( *(ctx->linePattern) == 0) {
		if ( ctx->transparent ) return;
		rec.solid = true;
		memcpy( ctx->color, ctx->backColor, MAX_SIZEOF_PIXEL);
	}
	
	closed  = points[0].x == points[n_points-1].x && points[0].y == points[n_points-1].y && n_points > 2;

	/* colors; optimize 8 16 24 pixels for horizontal line memcpy */
	if ( rec.solid )
		rec.color = ctx->color;
	switch ( rec.bpp ) {
	case 8:
		memset( ctx->color + 1, ctx->color[0], MAX_SIZEOF_PIXEL - 1);
		memset( ctx->backColor + 1, ctx->backColor[0], MAX_SIZEOF_PIXEL - 1);
		rec. optimized_stride = MAX_SIZEOF_PIXEL;
		break;
	case 16:
	case 24: {
		int b = rec.bpp / 8, n = MAX_SIZEOF_PIXEL / b, i;
		for ( i = 1; i < n; i++) {
			memcpy( ctx->color + i * b, ctx->color, b);
			memcpy( ctx->backColor + i * b, ctx->backColor, b);
		}
		rec. optimized_stride = (MAX_SIZEOF_PIXEL / b) * b;
		break;
	}}

	/* patterns */
	rec.n_segments       = strlen(( const char*) ctx->linePattern );
	rec.current_segment  = 0;
	rec.segment_offset   = 0;
	rec.segment_is_fg    = 1;
	if ( ctx->region == NULL ) {
		dummy_region.n_boxes = 1;
		dummy_region.boxes = &dummy_region_box;
		dummy_region_box.x = 0;
		dummy_region_box.y = 0;
		dummy_region_box.width  = i->w;
		dummy_region_box.height = i->h;
		ctx->region = &dummy_region;
	}
	enclosure.left   = ctx->region->boxes[0].x;
	enclosure.bottom = ctx->region->boxes[0].y;
	enclosure.right  = ctx->region->boxes[0].x + ctx->region->boxes[0].width  - 1;
	enclosure.top    = ctx->region->boxes[0].y + ctx->region->boxes[0].height - 1;
	for ( j = 1, pbox = ctx->region->boxes + 1; j < ctx->region->n_boxes; j++, pbox++) {
		int right = pbox->x + pbox->width - 1;
		int top   = pbox->y + pbox->height - 1;
		if ( enclosure.left   > pbox->x ) enclosure.left   = pbox->x;
		if ( enclosure.bottom > pbox->y ) enclosure.bottom = pbox->y;
		if ( enclosure.right  < right   ) enclosure.right  = right;
		if ( enclosure.top    < top     ) enclosure.top    = top;
	}
	for ( j = 0, pp = points; j < n_points - 1; j++, pp++) {
		/* calculate clipping: -1 invisible, 0 definitely clipped, 1 possibly clipped */
		int visibility; 
		int curr_maj, curr_min, to_maj, delta_maj, delta_min;
		int delta_y, delta_x;
		int dir = 0, d, d_inc1, d_inc2;
		int inc_maj, inc_min;
		int x, y, acc_x = 0, acc_y = INT_MIN, ox;
		Point a, b;

		/* printf("* p(%d): (%d,%d)-(%d,%d)\n", j, pp[0].x, pp[0].y, pp[1].x, pp[1].y); */
		a.x = pp[0].x + ctx->translate.x;
		a.y = pp[0].y + ctx->translate.y;
		b.x = pp[1].x + ctx->translate.x;
		b.y = pp[1].y + ctx->translate.y;
		if (a.x == b.x && a.y == b.y && n_points > 2) continue;

		if (
			( a.x < enclosure.left   && b.x < enclosure.left) ||
			( a.x > enclosure.right  && b.x > enclosure.right) ||
			( a.y < enclosure.bottom && b.y < enclosure.bottom) ||
			( a.y > enclosure.top    && b.y > enclosure.top)
		) {
			visibility = VISIBILITY_NONE;
			if ( rec.solid ) continue;
		} else if (
			a.x >= enclosure.left   && b.x >= enclosure.left &&
			a.x <= enclosure.right  && b.x <= enclosure.right &&
			a.y >= enclosure.bottom && b.y >= enclosure.bottom &&
			a.y <= enclosure.top    && b.y <= enclosure.top
		) {
			if ( ctx->region->n_boxes > 1) {
				int i,n;
				Box *e;
				visibility = VISIBILITY_CLIPPED;
				for (
					i = 0, e = ctx->region->boxes, n = ctx->region->n_boxes; 
					i < n; i++, e++
				) {
					int r = e->x + e->width;
					int t = e->y + e->height;
					if (
						a.x >= e->x && a.y >= e->y && a.x < r && a.y < t &&
						b.x >= e->x && b.y >= e->y && b.x < r && b.y < t
					) {
						visibility = VISIBILITY_CLEAR;
						break;
					}
				}
			} else {
				visibility = VISIBILITY_CLEAR;
			}
		} else {
			visibility = VISIBILITY_CLIPPED;
		}

/* 
   Bresenham line plotting, (c) LiloHuang @ 2008, kenwu@cpan.org 
   http://cpansearch.perl.org/src/KENWU/Algorithm-Line-Bresenham-C-0.1/Line/Bresenham/C/C.xs
 */
 		rec.skip_pixel = closed || (j > 0);
		delta_y = b.y - a.y;
		delta_x = b.x - a.x;
		if (abs(delta_y) > abs(delta_x)) dir = 1;
		
		if (dir) {
			curr_maj = a.y;
			curr_min = a.x;
			to_maj = b.y;
			delta_maj = delta_y;
			delta_min = delta_x;
		} else {
			curr_maj = a.x;
			curr_min = a.y;
			to_maj = b.x;
			delta_maj = delta_x;
			delta_min = delta_y;   
		}

		if (delta_maj != 0)
			inc_maj = (abs(delta_maj)==delta_maj ? 1 : -1);
		else
			inc_maj = 0;
		
		if (delta_min != 0)
			inc_min = (abs(delta_min)==delta_min ? 1 : -1);
		else
			inc_min = 0;
		
		delta_maj = abs(delta_maj);
		delta_min = abs(delta_min);
		
		d      = (delta_min << 1) - delta_maj;
		d_inc1 = (delta_min << 1);
		d_inc2 = ((delta_min - delta_maj) << 1);

		while(1) {
			ox = x;
			if (dir) {
				x = curr_min;	 
				y = curr_maj;
			} else {
				x = curr_maj;	 
				y = curr_min;
			}
			if ( acc_y != y ) {
				if ( acc_y > INT_MIN) 
					hline( &rec, acc_x, ox, acc_y, visibility);
				acc_x = x;
				acc_y = y;
			}
	
			if (curr_maj == to_maj) break;
			curr_maj += inc_maj;
			if (d < 0) {
				d += d_inc1;
			} else {
				d += d_inc2;
				curr_min += inc_min;
			}
		}
		if ( acc_y > INT_MIN)
			hline( &rec, acc_x, x, acc_y, visibility);
	}
}

static void
fill_alpha_buf( Byte * dst, Byte * src, int width, int bpp)
{
	register int x = width;
	if ( bpp == 3 ) {
		while (x-- > 0) {
			register Byte a = *src++;
			*dst++ = a;
			*dst++ = a;
			*dst++ = a;
		}
	} else
		memcpy( dst, src, width * bpp);
}

#define dBLEND_FUNC(name) void name( const Byte * src, const Byte * src_a, Byte * dst, const Byte * dst_a, int bytes )

typedef dBLEND_FUNC(BlendFunc);

/* sss + (ddd * (255 - as)) / 255 */
static dBLEND_FUNC(blend_src_over)
{
	while ( bytes-- > 0 ) {
		register int32_t s =
				((int32_t)(*src++) << 8 ) +
				((int32_t)(*dst) << 8) * (255 - *src_a++) / 255
				+ 127;
		s >>= 8;
		*dst++ = ( s > 255 ) ? 255 : s;
	}
}

/* (sss * (255 - ad) + ddd * (255 - as)) / 255 */
static dBLEND_FUNC(blend_xor)
{
	while ( bytes-- > 0 ) {
		register int32_t s = (
				((int32_t)(*src++) << 8) * (255 - *dst_a++) +
				((int32_t)(*dst)   << 8) * (255 - *src_a++)
			) / 255 + 127;
		s >>= 8;
		*dst++ = ( s > 255 ) ? 255 : s;
	}
}

/* sss * (255 - ad) / 255 + ddd */
static dBLEND_FUNC(blend_dst_over)
{
	while ( bytes-- > 0 ) {
		register int32_t s =
				((int32_t)(*dst) << 8 ) +
				((int32_t)(*src++) << 8) * (255 - *dst_a++) / 255
				+ 127;
		s >>= 8;
		*dst++ = ( s > 255 ) ? 255 : s;
	}
}

/* ddd */
static dBLEND_FUNC(blend_dst_copy)
{
}

/* 0 */
static dBLEND_FUNC(blend_clear)
{
	memset( dst, 0, bytes);
}

/* sss * ad / 255 */
static dBLEND_FUNC(blend_src_in)
{
	while ( bytes-- > 0 ) {
		register int32_t s = (((int32_t)(*src++) << 8) * *dst_a++) / 255 + 127;
		s >>= 8;
		*dst++ = ( s > 255 ) ? 255 : s;
	}
}

/* ddd * as / 255 */
static dBLEND_FUNC(blend_dst_in)
{
	while ( bytes-- > 0 ) {
		register int32_t d = (((int32_t)(*dst) << 8) * *src_a++) / 255 + 127;
		d >>= 8;
		*dst++ = ( d > 255 ) ? 255 : d;
	}
}

/* sss * (255 - ad) / 255 */
static dBLEND_FUNC(blend_src_out)
{
	while ( bytes-- > 0 ) {
		register int32_t s = (((int32_t)(*src++) << 8) * ( 255 - *dst_a++)) / 255 + 127;
		s >>= 8;
		*dst++ = ( s > 255 ) ? 255 : s;
	}
}

/* ddd * (255 - as) / 255 */
static dBLEND_FUNC(blend_dst_out)
{
	while ( bytes-- > 0 ) {
		register int32_t d = (((int32_t)(*dst) << 8) * ( 255 - *src_a++)) / 255 + 127;
		d >>= 8;
		*dst++ = ( d > 255 ) ? 255 : d;
	}
}

/* (sss * ad + ddd * (255 - as)) / 255 */
static dBLEND_FUNC(blend_src_atop)
{
	while ( bytes-- > 0 ) {
		register int32_t s = (
			((int32_t)(*src++) << 8) * *dst_a++ +
			((int32_t)(*dst) << 8) * (255 - *src_a++)
		) / 255 + 127;
		s >>= 8;
		*dst++ = ( s > 255 ) ? 255 : s;
	}
}

/* (sss * (255 - ad) + ddd * as) / 255 */
static dBLEND_FUNC(blend_dst_atop)
{
	while ( bytes-- > 0 ) {
		register int32_t s = (
			((int32_t)(*src++) << 8) * ( 255 - *dst_a++) +
			((int32_t)(*dst) << 8) * *src_a++
		) / 255 + 127;
		s >>= 8;
		*dst++ = ( s > 255 ) ? 255 : s;
	}
}

/* sss */
static dBLEND_FUNC(blend_src_copy)
{
	memcpy( dst, src, bytes);
}

static BlendFunc* blend_functions[] = {
	blend_src_over,
	blend_xor,
	blend_dst_over,
	blend_src_copy,
	blend_dst_copy,
	blend_clear,
	blend_src_in,
	blend_dst_in,
	blend_src_out,
	blend_dst_out,
	blend_src_atop,
	blend_dst_atop
};

typedef struct {
	int dX;
	int dY;
	int bpp;
	int sls;
	int dls;
	int mls;
	int als;
	Byte * src;
	Byte * dst;
	Byte * srcMask;
	Byte * dstMask;
	Bool use_src_alpha;
	Bool use_dst_alpha;
	Byte * asbuf;
	Byte * adbuf;
	BlendFunc * blend_func;
} ImgPutAlphaCallbackRec;

static void
img_put_alpha_single( int x, int y, int w, int h, ImgPutAlphaCallbackRec * ptr)
{
	int i;
	const int bpp = ptr->bpp;
	int bytes = w * bpp;
	const int sls = ptr->sls;
	const int dls = ptr->dls;
	const int mls = ptr->mls;
	const int als = ptr->als;
	const Byte * s = ptr->src + (ptr->dY + y) * ptr->sls + (ptr->dX + x) * bpp;
	const Byte * d = ptr->dst + y * ptr->dls + x * bpp;
	const Byte * m = ( mls > 0) ? ptr->srcMask + (ptr->dY + y) * mls + (ptr->dX + x) : NULL;
	const Byte * a = ( als > 0) ? ptr->dstMask + y * als + x : NULL;
#ifdef HAVE_OPENMP
#pragma omp parallel for
#endif
	for ( i = 0; i < h; i++) {
		Byte *asbuf_ptr, *adbuf_ptr, *s_ptr, *m_ptr, *d_ptr, *a_ptr;

		s_ptr = (Byte*)s + sls * i;
		d_ptr = (Byte*)d + dls * i;
		m_ptr = m ? (Byte*)m + mls * i : NULL;
		a_ptr = a ? (Byte*)a + als * i : NULL;

		if ( !ptr->use_src_alpha ) {
			asbuf_ptr = ptr->asbuf + bytes * OMP_THREAD_NUM;
			fill_alpha_buf( asbuf_ptr, m_ptr, w, bpp);
		} else
			asbuf_ptr = ptr->asbuf;

		if ( !ptr->use_dst_alpha ) {
			adbuf_ptr = ptr->adbuf + bytes * OMP_THREAD_NUM;
			fill_alpha_buf( adbuf_ptr, a_ptr, w, bpp);
		} else
			adbuf_ptr = ptr->adbuf;

		ptr->blend_func( s_ptr, asbuf_ptr, d_ptr, adbuf_ptr, bytes);
		if (a) {
			if ( ptr->use_src_alpha )
				ptr->blend_func( ptr->asbuf, ptr->asbuf, (Byte*)a_ptr, a_ptr, w);
			else
				ptr->blend_func( m_ptr, m_ptr, (Byte*)a_ptr, a_ptr, w);
		}
	}
}

/*
	This is basically a lightweight pixman_image_composite() .
	Converts images to either 8 or 24 bits before processing
*/
static Bool
img_put_alpha( Handle dest, Handle src, int dstX, int dstY, int srcX, int srcY, int dstW, int dstH, int srcW, int srcH, int rop, PBoxRegionRec region)
{
	int bpp, bytes, mls, als, x, xrop;
	unsigned int src_alpha = 0, dst_alpha = 0;
	Bool use_src_alpha = false, use_dst_alpha = false;
	Byte *asbuf, *adbuf;

	xrop = rop;

	/* differentiate between per-pixel alpha and a global value */
	if ( rop & ropSrcAlpha ) {
		use_src_alpha = true;
		src_alpha = (rop >> ropSrcAlphaShift) & 0xff;
	}
	if ( rop & ropDstAlpha ) {
		use_dst_alpha = true;
		dst_alpha = (rop >> ropDstAlphaShift) & 0xff;
	}
	rop &= ropPorterDuffMask;
	if ( rop > ropDstAtop || rop < 0 ) return false;

	/* align types and geometry - can only operate over imByte and imRGB */
	bpp = (( PImage(src)->type & imGrayScale) && ( PImage(dest)->type & imGrayScale)) ? imByte : imRGB;

	/* adjust rectangles */
	if ( dstX < 0 || dstY < 0 || dstX + dstW >= PImage(dest)-> w || dstY + dstH >= PImage(dest)-> h) {
		if ( dstX < 0) {
			dstW += dstX;
			srcX -= dstX;
			dstX = 0;
		}
		if ( dstY < 0) {
			dstH += dstY;
			srcY -= dstY;
			dstY = 0;
		}
		if ( dstX + dstW > PImage(dest)-> w)
			dstW = PImage(dest)-> w - dstX;
		if ( dstY + dstH > PImage(dest)-> h)
			dstH = PImage(dest)-> h - dstY;
	}
	if ( srcX + srcW > PImage(src)-> w)
		srcW = PImage(src)-> w - srcX;
	if ( srcY + srcH > PImage(src)-> h)
		srcH = PImage(src)-> h - srcY;
	if ( srcH <= 0 || srcW <= 0 )
		return false;

	/* adjust source type */
	if (PImage(src)-> type != bpp || srcW != dstW || srcH != dstH ) {
		Bool ok;
		Handle dup;

		if ( srcW != PImage(src)-> w || srcH != PImage(src)-> h)
			dup = CImage(src)-> extract( src, srcX, srcY, srcW, srcH );
		else
			dup = CImage(src)-> dup(src);

		if ( srcW != dstW || srcH != dstH )
			CImage(dup)->stretch( dup, dstW, dstH );
		if ( PImage( dup )-> type != bpp )
			CImage(dup)-> set_type( dup, bpp);

		ok = img_put_alpha( dest, dup, dstX, dstY, 0, 0, dstW, dstH, dstW, dstH, xrop, region);

		Object_destroy(dup);
		return ok;
	}

	/* adjust destination type */
	if (PImage(dest)-> type != bpp || ( kind_of( dest, CIcon) && PIcon(dest)->maskType != imbpp8 )) {
		Bool ok;
		Bool icon = kind_of(dest, CIcon);
		int type = PImage(dest)->type;
		int mask = icon ? PIcon(dest)->maskType : 0;

		if ( type != bpp )
			CIcon(dest)-> set_type( dest, bpp );
		if ( icon && mask != imbpp8 )
			CIcon(dest)-> set_maskType( dest, imbpp8 );
		ok = img_put_alpha( dest, src, dstX, dstY, srcX, srcY, dstW, dstH, srcW, srcH, xrop, region);
		if ( PImage(dest)-> options. optPreserveType ) {
			if ( type != bpp )
				CImage(dest)-> set_type( dest, type );
			if ( icon && mask != imbpp8 )
				CIcon(dest)-> set_maskType( dest, mask );
		}
		return ok;
	}

	/* assign pointers */
	if ( srcW != dstW || srcH != dstH ||
		PImage(src)->type != PImage(dest)->type || PImage(src)-> type != bpp)
		croak("panic: assert failed for img_put_alpha: %s", "types and geometry");

	bpp = ( bpp == imByte ) ? 1 : 3;
	if ( kind_of(src, CIcon)) {
		mls = PIcon(src)-> maskLine;
		if ( PIcon(src)-> maskType != imbpp8)
			croak("panic: assert failed for img_put_alpha: %s", "src mask type");
		use_src_alpha = false;
	} else {
		mls = 0;
	}

	if ( kind_of(dest, CIcon)) {
		als = PIcon(dest)-> maskLine;
		if ( PIcon(dest)-> maskType != imbpp8)
			croak("panic: assert failed for img_put_alpha: %s", "dst mask type");
		use_dst_alpha = false;
	} else {
		als = 0;
	}

	if ( !use_src_alpha && mls == 0) {
		use_src_alpha = true;
		src_alpha = 0xff;
	}
	if ( !use_dst_alpha && als == 0) {
		use_dst_alpha = true;
		dst_alpha = 0xff;
	}

	/* make buffers for alpha */
	bytes = dstW * bpp;
	if ( !(asbuf = malloc(bytes * (use_src_alpha ? 1 : OMP_MAX_THREADS)))) {
		warn("not enough memory");
		return false;
	}
	if ( !(adbuf = malloc(bytes * (use_dst_alpha ? 1 : OMP_MAX_THREADS)))) {
		free(asbuf);
		warn("not enough memory");
		return false;
	}

	if ( use_src_alpha )
		for ( x = 0; x < bytes; x++) asbuf[x] = src_alpha;
	if ( use_dst_alpha )
		for ( x = 0; x < bytes; x++) adbuf[x] = dst_alpha;

	/* select function */
	{
		ImgPutAlphaCallbackRec rec = {
			dX            : srcX - dstX,
			dY            : srcY - dstY,
			bpp           : bpp,
			sls           : PImage(src )-> lineSize,
			dls           : PImage(dest)-> lineSize,
			mls           : mls,
			als           : als,
			src           : PImage(src )->data,
			dst           : PImage(dest)->data,
			srcMask       : (mls > 0) ? PIcon(src )->mask : NULL,
			dstMask       : (als > 0) ? PIcon(dest)->mask : NULL,
			use_src_alpha : use_src_alpha,
			use_dst_alpha : use_dst_alpha,
			asbuf         : asbuf,
			adbuf         : adbuf,
			blend_func    : blend_functions[rop]
		};
		region_foreach( region,
			dstX, dstY, dstW, dstH,
			(RegionCallbackFunc*)img_put_alpha_single, &rec
		);
	};

	/* cleanup */
	free(adbuf);
	free(asbuf);

	return true;
}

/* alpha stuff */
void
img_premultiply_alpha_constant( Handle self, int alpha)
{
	Byte * data;
	int i, j, pixels;
	if ( PImage(self)-> type == imByte ) {
		pixels = 1;
	} else if ( PImage(self)-> type == imRGB ) {
		pixels = 3;
	} else {
		croak("Not implemented");
	}

	data = PImage(self)-> data;
	for ( i = 0; i < PImage(self)-> h; i++) {
		register Byte *d = data, k;
		for ( j = 0; j < PImage(self)-> w; j++ ) {
			for ( k = 0; k < pixels; k++, d++)
				*d = (alpha * *d) / 255.0 + .5;
		}
		data += PImage(self)-> lineSize;
	}
}

void img_premultiply_alpha_map( Handle self, Handle alpha)
{
	Byte * data, * mask;
	int i, pixels;
	if ( PImage(self)-> type == imByte ) {
		pixels = 1;
	} else if ( PImage(self)-> type == imRGB ) {
		pixels = 3;
	} else {
		croak("Not implemented");
	}

	if ( PImage(alpha)-> type != imByte )
		croak("Not implemented");

	data = PImage(self)-> data;
	mask = PImage(alpha)-> data;
	for ( i = 0; i < PImage(self)-> h; i++) {
		int j;
		register Byte *d = data, *m = mask, k;
		for ( j = 0; j < PImage(self)-> w; j++ ) {
			register uint16_t alpha = *m++;
			for ( k = 0; k < pixels; k++, d++)
				*d = (alpha * *d) / 255.0 + .5;
		}
		data += PImage(self)-> lineSize;
		mask += PImage(alpha)-> lineSize;
	}
}

#ifdef __cplusplus
}
#endif


#include "img_conv.h"

#ifdef __cplusplus
extern "C" {
#endif

Bool
img_region_foreach(
	PBoxRegionRec region, 
	int dstX, int dstY, int dstW, int dstH,
	RegionCallbackFunc callback, void * param
) {
	Box * r;
	int j, right, top;
	if ( region == NULL )
		return callback( dstX, dstY, dstW, dstH, param);
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
			if ( !callback( xx, yy, ww, hh, param ))
				return false;
	}
	return true;
}

PBoxRegionRec
img_region_alloc(PBoxRegionRec old_region, int n_boxes)
{
	PBoxRegionRec ret = NULL;
	ssize_t size = sizeof(BoxRegionRec) + n_boxes * sizeof(Box);
	if ( old_region ) {
		if (( ret = realloc(old_region, size)) == NULL)
			return NULL;
	} else {
		if (( ret = malloc(size)) == NULL)
			return NULL;
		bzero(ret, sizeof(BoxRegionRec));
	}
	ret->boxes = (Box*) (((Byte*)ret) + sizeof(BoxRegionRec));
	return ret;
}

Box
img_region_box(PBoxRegionRec region)
{
	int i, n = 0;
	Box ret, *curr = NULL;
	Rect r;

	if ( region != NULL && region-> n_boxes > 0 ) {
		n        = region-> n_boxes;
		curr     = region->boxes;
		r.left   = curr->x; 
		r.bottom = curr->y; 
		r.right  = curr->x + curr->width;
		r.top    = curr->y + curr->height;
		curr++;
	} else
		bzero(&r, sizeof(r));

	for ( i = 1; i < n; i++, curr++) {
		int right = curr->x + curr->width, top = curr->y + curr->height;
		if ( curr-> x < r.left)   r.left   = curr->x;
		if ( curr-> y < r.bottom) r.bottom = curr->y;
		if ( right    > r.right)  r.right  = right;
		if ( top      > r.top  )  r.top    = top;
	}
	ret.x      = r.left;
	ret.y      = r.bottom;
	ret.width  = r.right - r.left;
	ret.height = r.top   - r.bottom;
	return ret;
}

Bool
img_point_in_region( int x, int y, PBoxRegionRec region)
{
	int i;
	Box * b;
	for ( i = 0, b = region->boxes; i < region->n_boxes; i++, b++) {
		if ( x >= b->x && y >= b->y && x < b->x + b->width && y < b->y + b->height)
			return true;
	}
	return false;
}


#ifdef __cplusplus
}
#endif


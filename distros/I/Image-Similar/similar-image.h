/*
This file was generated by the following command:

cfunctions similar-image.c

*/
#ifndef CFH_SIMILAR_IMAGE_H
#define CFH_SIMILAR_IMAGE_H

#line 8 "similar-image.c"
#define SIZE 9
#define DIRECTIONS 8
typedef struct point
{
    double average_grey_level;
    int d[DIRECTIONS];
}
point_t;
typedef int (*simage_error_channel_t) (void * s, const char * format, ...);
typedef struct simage
{
    /* The width of the image in pixels. */
    unsigned int width;
    /* The height of the image in pixels. */
    unsigned int height;
    /* The image data. */
    unsigned char * data;
    /* The computed signature. */
    char * signature;
    /* The length of the signature. */
    int signature_length;
    /* The P-value for this image, see equation in article. */
    unsigned int p;
    /* The grid of values. */
    point_t grid[SIZE*SIZE];
    /* width / (SIZE + 1) */
    double w10;
    /* height / (SIZE + 1) */
    double h10;
    /* The number of times malloc/calloc were called related to this
       object. */
    int nmallocs;
    simage_error_channel_t error_channel;
    /* This contains a true value if we have actually loaded image
       data, or a false value if not. This may be false if we just
       loaded a signature rather than the image. */
    unsigned int valid_image : 1;
    /* The grid is already filled. */
    unsigned int grid_filled : 1;
}
simage_t;
typedef enum
{
    simage_ok,
    /* malloc failed. */
    simage_status_memory_failure,
    /* x or y is outside the image dimensions. */
    simage_status_bounds,
    simage_status_bad_image,
    /* Some upstream program did a stupid thing. */
    simage_status_bad_logic,
    /* */
    simage_status_free_underflow,
    /* */
    simage_status_memory_leak,
}
simage_status_t;
typedef enum
{
    much_darker = -2,
    darker = -1,
    same = 0,
    lighter = 1,
    much_lighter = 2,
}
comparison_t;

#line 77 "similar-image.c"
int x_y_to_entry (int x, int y);

#line 95 "similar-image.c"
simage_status_t simage_dump (simage_t* s);

#line 107 "similar-image.c"
simage_status_t simage_init (simage_t* s, unsigned int width, unsigned int height);

#line 135 "similar-image.c"
simage_status_t simage_inc_nmallocs (simage_t* s, void* signature);

#line 143 "similar-image.c"
simage_status_t simage_dec_nmallocs (simage_t* s);

#line 155 "similar-image.c"
simage_status_t simage_free (simage_t* s);

#line 175 "similar-image.c"
simage_status_t simage_set_pixel (simage_t* s, int x, int y, unsigned char grey);

#line 185 "similar-image.c"
simage_status_t simage_fill_entry (simage_t* s, int i, int j);

#line 246 "similar-image.c"
simage_status_t simage_fill_entries (simage_t* s);

#line 265 "similar-image.c"
int xo_yo_to_direction (int xo, int yo);

#line 279 "similar-image.c"
simage_status_t direction_to_xo_yo (int direction, int* xo, int* yo);

#line 309 "similar-image.c"
int diff (int thisgrey, int thatgrey);

#line 338 "similar-image.c"
simage_status_t simage_make_point_diffs (simage_t* s, int x, int y);

#line 380 "similar-image.c"
simage_status_t entry_to_x_y (int entry, int* x_ptr, int* y_ptr);

#line 394 "similar-image.c"
simage_status_t simage_make_differences (simage_t* s);

#line 409 "similar-image.c"
simage_status_t simage_check_image (simage_t* s);

#line 421 "similar-image.c"
simage_status_t simage_fill_grid (simage_t* s);

#line 433 "similar-image.c"
simage_status_t simage_diff (simage_t* s1, simage_t* s2, double* total_diff);

#line 467 "similar-image.c"
int inside (int cell, int direction);

#line 485 "similar-image.c"
simage_status_t simage_allocate_signature (simage_t* s, int size);

#line 495 "similar-image.c"
simage_status_t simage_signature (simage_t* s);

#line 526 "similar-image.c"
simage_status_t simage_fill_from_signature (simage_t* s, char* signature, int signature_length);

#endif /* CFH_SIMILAR_IMAGE_H */

object Prima::DeviceBitmap( Prima::Drawable)
{
	int type;
	property int type;
	method Bool   begin_paint();
	method Bool   begin_paint_info();
	method void   done();
	method void   end_paint();
	method Handle icon();
	method Handle image();
	method SV *   get_handle();
	method int    get_paint_state();
	method void   init( HV * profile);
}

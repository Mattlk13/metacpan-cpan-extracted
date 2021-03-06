/*
 * This file was generated automatically by xsubpp version 1.9507 from the 
 * contents of i2c_ser.xs. Do not edit this file, edit i2c_ser.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST! 
 *
 */

#line 1 "i2c_ser.xs"
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "../../i2c_ser/i2c_ser.h"
#include "../../pcf8574/pcf8574.h"
#include "../../sda3302/sda3302.h"
#include "../../tsa6057/tsa6057.h"
#include "../../pcf8591/pcf8591.h"
#include "../../lcd/lcd.h"

static int 
not_here(char *s)
{
    croak("%s not implemented on this architecture", s);
    return -1;
}

static double
constant(char *name, int arg)
{
    errno = 0;
    switch (*name) {
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}


#line 44 "i2c_ser.c"
XS(XS_i2c_ser_constant)
{
    dXSARGS;
    if (items != 2)
	croak("Usage: i2c_ser::constant(name,arg)");
    {
	char *	name = (char *)SvPV(ST(0),PL_na);
	int	arg = (int)SvIV(ST(1));
	double	RETVAL;

	RETVAL = constant(name, arg);
	ST(0) = sv_newmortal();
	sv_setnv(ST(0), (double)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_init_iic)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::init_iic(a)");
    {
	int	a = (int)SvIV(ST(0));
	int	RETVAL;

	RETVAL = init_iic(a);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_deinit_iic)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::deinit_iic()");
    {
	int	RETVAL;

	RETVAL = deinit_iic();
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_set_port_delay)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::set_port_delay(a)");
    {
	int	a = (int)SvIV(ST(0));
	int	RETVAL;

	RETVAL = set_port_delay(a);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_read_sda)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::read_sda()");
    {
	int	RETVAL;

	RETVAL = read_sda();
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_read_scl)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::read_scl()");
    {
	int	RETVAL;

	RETVAL = read_scl();
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_iic_start)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::iic_start()");
    {
	int	RETVAL;

	RETVAL = iic_start();
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_iic_stop)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::iic_stop()");
    {
	int	RETVAL;

	RETVAL = iic_stop();
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_iic_send_byte)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::iic_send_byte(a)");
    {
	int	a = (int)SvIV(ST(0));
	int	RETVAL;

	RETVAL = iic_send_byte(a);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_iic_read_byte)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::iic_read_byte(a)");
    {
	int	a = (int)SvIV(ST(0));
	int	RETVAL;

	RETVAL = iic_read_byte(a);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_set_strobe)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::set_strobe(a)");
    {
	int	a = (int)SvIV(ST(0));
	int	RETVAL;

	RETVAL = set_strobe(a);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_byte_out)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::byte_out(a)");
    {
	int	a = (int)SvIV(ST(0));
	int	RETVAL;

	RETVAL = byte_out(a);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_byte_in)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::byte_in(a)");
    {
	int	a = (int)SvIV(ST(0));
	int	RETVAL;

	RETVAL = byte_in(a);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_get_status)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::get_status(a)");
    {
	int	a = (int)SvIV(ST(0));
	int	RETVAL;

	RETVAL = get_status(a);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_io_disable)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::io_disable()");
    {
	int	RETVAL;

	RETVAL = io_disable();
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_io_enable)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::io_enable()");
    {
	int	RETVAL;

	RETVAL = io_enable();
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_pcf8574_const)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::pcf8574_const()");
    SP -= items;
    {
	int	RETVAL;
#line 134 "i2c_ser.xs"
 EXTEND(SP,2);
 PUSHs(sv_2mortal(newSViv(PCF8574_TX)));
 PUSHs(sv_2mortal(newSViv(PCF8574_RX)));
#line 307 "i2c_ser.c"
	PUTBACK;
	return;
    }
}

XS(XS_i2c_ser_iic_tx_pcf8574)
{
    dXSARGS;
    if (items != 2)
	croak("Usage: i2c_ser::iic_tx_pcf8574(Data,Adress)");
    {
	int	Data = (int)SvIV(ST(0));
	int	Adress = (int)SvIV(ST(1));
	int	RETVAL;

	RETVAL = iic_tx_pcf8574(Data, Adress);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_iic_rx_pcf8574)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::iic_rx_pcf8574(Adress)");
    SP -= items;
    {
	int	Adress = (int)SvIV(ST(0));
#line 149 "i2c_ser.xs"
	int	status;
	int 	Data;
#line 341 "i2c_ser.c"
	int	RETVAL;
#line 152 "i2c_ser.xs"
 status = iic_rx_pcf8574(&Data,Adress);
 EXTEND(SP,1);
 PUSHs(sv_2mortal(newSViv(Data)));
#line 347 "i2c_ser.c"
	PUTBACK;
	return;
    }
}

XS(XS_i2c_ser_sda3302_const)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::sda3302_const()");
    SP -= items;
    {
	int	RETVAL;
#line 163 "i2c_ser.xs"
 EXTEND(SP,5);
 PUSHs(sv_2mortal(newSViv(SDA3302_ADR)));
 PUSHs(sv_2mortal(newSViv(SDA3302_STEP)));
 PUSHs(sv_2mortal(newSViv(SDA3302_ZF)));
 PUSHs(sv_2mortal(newSViv(SDA3302_PLL)));
 PUSHs(sv_2mortal(newSViv(SDA3302_DIV)));
#line 368 "i2c_ser.c"
	PUTBACK;
	return;
    }
}

XS(XS_i2c_ser_create3302)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::create3302()");
    {
	sda3302 *	RETVAL;
#line 173 "i2c_ser.xs"
sda3302	*s = (sda3302*) malloc(sizeof(sda3302));
s->div1 = 0;
s->div2 = 0;
s->cnt1 = 0;
s->cnt2 = 0;
RETVAL  = s;
#line 388 "i2c_ser.c"
	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "sda3302Ptr", (void*)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_sda3302_init)
{
    dXSARGS;
    if (items != 2)
	croak("Usage: i2c_ser::sda3302_init(sda,mode)");
    {
	sda3302*	sda;
	int	mode = (int)SvIV(ST(1));
	int	RETVAL;

	if (sv_derived_from(ST(0), "sda3302Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    sda = (sda3302 *) tmp;
	}
	else
	    croak("sda is not of type sda3302Ptr");

	RETVAL = sda3302_init(sda, mode);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_sda3302_calc)
{
    dXSARGS;
    if (items != 2)
	croak("Usage: i2c_ser::sda3302_calc(sda,freq)");
    {
	sda3302*	sda;
	long	freq = (long)SvIV(ST(1));
	int	RETVAL;

	if (sv_derived_from(ST(0), "sda3302Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    sda = (sda3302 *) tmp;
	}
	else
	    croak("sda is not of type sda3302Ptr");

	RETVAL = sda3302_calc(sda, freq);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_sda3302_send)
{
    dXSARGS;
    if (items != 2)
	croak("Usage: i2c_ser::sda3302_send(sda,Adresse)");
    {
	sda3302*	sda;
	int	Adresse = (int)SvIV(ST(1));
	int	RETVAL;

	if (sv_derived_from(ST(0), "sda3302Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    sda = (sda3302 *) tmp;
	}
	else
	    croak("sda is not of type sda3302Ptr");

	RETVAL = sda3302_send(sda, Adresse);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_delete3302)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::delete3302(sda)");
    {
	sda3302*	sda;

	if (sv_derived_from(ST(0), "sda3302Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    sda = (sda3302 *) tmp;
	}
	else
	    croak("sda is not of type sda3302Ptr");
#line 224 "i2c_ser.xs"
if (sda != NULL)
{
free(sda);
}
#line 486 "i2c_ser.c"
    }
    XSRETURN_EMPTY;
}

XS(XS_i2c_ser_tsa6057_const)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::tsa6057_const()");
    SP -= items;
    {
	int	RETVAL;
#line 234 "i2c_ser.xs"
 EXTEND(SP,6);
 PUSHs(sv_2mortal(newSViv(TSA6057_ADR)));
 PUSHs(sv_2mortal(newSViv(TSA6057_AM)));
 PUSHs(sv_2mortal(newSViv(TSA6057_FM)));
 PUSHs(sv_2mortal(newSViv(TSA6057_R01)));
 PUSHs(sv_2mortal(newSViv(TSA6057_R10)));
 PUSHs(sv_2mortal(newSViv(TSA6057_R25)));
#line 507 "i2c_ser.c"
	PUTBACK;
	return;
    }
}

XS(XS_i2c_ser_create6057)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::create6057()");
    {
	tsa6057 *	RETVAL;
#line 245 "i2c_ser.xs"
tsa6057	*s = (tsa6057*) malloc(sizeof(tsa6057));
s->sadr = 0;
s->db0 = 0;
s->db1 = 0;
s->db2 = 0;
s->db3 = 0;
RETVAL  = s;
#line 528 "i2c_ser.c"
	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "tsa6057Ptr", (void*)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_tsa6057_init)
{
    dXSARGS;
    if (items != 3)
	croak("Usage: i2c_ser::tsa6057_init(tsa,raster,mode)");
    {
	tsa6057*	tsa;
	int	mode = (int)SvIV(ST(2));
	int	raster = (int)SvIV(ST(1));
	int	RETVAL;

	if (sv_derived_from(ST(0), "tsa6057Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    tsa = (tsa6057 *) tmp;
	}
	else
	    croak("tsa is not of type tsa6057Ptr");

	RETVAL = tsa6057_init(tsa, raster, mode);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_tsa6057_calc)
{
    dXSARGS;
    if (items != 2)
	croak("Usage: i2c_ser::tsa6057_calc(tsa,freq)");
    {
	tsa6057*	tsa;
	long	freq = (long)SvIV(ST(1));
	int	RETVAL;

	if (sv_derived_from(ST(0), "tsa6057Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    tsa = (tsa6057 *) tmp;
	}
	else
	    croak("tsa is not of type tsa6057Ptr");

	RETVAL = tsa6057_calc(tsa, freq);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_tsa6057_send)
{
    dXSARGS;
    if (items != 2)
	croak("Usage: i2c_ser::tsa6057_send(tsa,Adresse)");
    {
	tsa6057*	tsa;
	int	Adresse = (int)SvIV(ST(1));
	int	RETVAL;

	if (sv_derived_from(ST(0), "tsa6057Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    tsa = (tsa6057 *) tmp;
	}
	else
	    croak("tsa is not of type tsa6057Ptr");

	RETVAL = tsa6057_send(tsa, Adresse);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_delete6057)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::delete6057(tsa)");
    {
	tsa6057*	tsa;

	if (sv_derived_from(ST(0), "tsa6057Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    tsa = (tsa6057 *) tmp;
	}
	else
	    croak("tsa is not of type tsa6057Ptr");
#line 282 "i2c_ser.xs"
if (tsa != NULL)
{
free(tsa);
}
#line 627 "i2c_ser.c"
    }
    XSRETURN_EMPTY;
}

XS(XS_i2c_ser_pcf8591_const)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::pcf8591_const()");
    SP -= items;
    {
	int	RETVAL;
#line 294 "i2c_ser.xs"
 EXTEND(SP,7);
 PUSHs(sv_2mortal(newSViv(PCF8591_ADR)));
 PUSHs(sv_2mortal(newSViv(PCF8591_RX)));
 PUSHs(sv_2mortal(newSViv(PCF8591_C4S)));
 PUSHs(sv_2mortal(newSViv(PCF8591_C3D)));
 PUSHs(sv_2mortal(newSViv(PCF8591_C2S)));
 PUSHs(sv_2mortal(newSViv(PCF8591_C2D)));
 PUSHs(sv_2mortal(newSViv(PCF8591_C3D)));
#line 649 "i2c_ser.c"
	PUTBACK;
	return;
    }
}

XS(XS_i2c_ser_create8591)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::create8591()");
    {
	pcf8591 *	RETVAL;
#line 306 "i2c_ser.xs"
pcf8591	*s = (pcf8591*) malloc(sizeof(pcf8591));
	s->chan_mode = 0;
	s->REF 	     = 0.0;
	s->da_val    = 0;
RETVAL  = s;
#line 668 "i2c_ser.c"
	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "pcf8591Ptr", (void*)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_pcf8591_init)
{
    dXSARGS;
    if (items != 3)
	croak("Usage: i2c_ser::pcf8591_init(adda,mode,ref)");
    {
	pcf8591*	adda;
	int	mode = (int)SvIV(ST(1));
	double	ref = (double)SvNV(ST(2));
	int	RETVAL;

	if (sv_derived_from(ST(0), "pcf8591Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    adda = (pcf8591 *) tmp;
	}
	else
	    croak("adda is not of type pcf8591Ptr");

	RETVAL = pcf8591_init(adda, mode, ref);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_pcf8591_readchan)
{
    dXSARGS;
    if (items != 2)
	croak("Usage: i2c_ser::pcf8591_readchan(adda,Kanal)");
    SP -= items;
    {
	pcf8591*	adda;
	int	Kanal = (int)SvIV(ST(1));
#line 330 "i2c_ser.xs"
	int	status;
#line 711 "i2c_ser.c"
	int	RETVAL;

	if (sv_derived_from(ST(0), "pcf8591Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    adda = (pcf8591 *) tmp;
	}
	else
	    croak("adda is not of type pcf8591Ptr");
#line 332 "i2c_ser.xs"
 status = pcf8591_readchan(adda,Kanal);
 EXTEND(SP,1);
 PUSHs(sv_2mortal(newSViv(adda->data[Kanal])));
#line 724 "i2c_ser.c"
	PUTBACK;
	return;
    }
}

XS(XS_i2c_ser_pcf8591_read4chan)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::pcf8591_read4chan(adda)");
    SP -= items;
    {
	pcf8591*	adda;
#line 341 "i2c_ser.xs"
	int	status;
#line 740 "i2c_ser.c"
	int	RETVAL;

	if (sv_derived_from(ST(0), "pcf8591Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    adda = (pcf8591 *) tmp;
	}
	else
	    croak("adda is not of type pcf8591Ptr");
#line 343 "i2c_ser.xs"
 status = pcf8591_read4chan(adda);
 EXTEND(SP,4);
 PUSHs(sv_2mortal(newSViv(adda->data[0])));
 PUSHs(sv_2mortal(newSViv(adda->data[1])));
 PUSHs(sv_2mortal(newSViv(adda->data[2])));
 PUSHs(sv_2mortal(newSViv(adda->data[3])));
#line 756 "i2c_ser.c"
	PUTBACK;
	return;
    }
}

XS(XS_i2c_ser_pcf8591_setda)
{
    dXSARGS;
    if (items != 2)
	croak("Usage: i2c_ser::pcf8591_setda(adda,outval)");
    {
	pcf8591*	adda;
	double	outval = (double)SvNV(ST(1));
	int	RETVAL;

	if (sv_derived_from(ST(0), "pcf8591Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    adda = (pcf8591 *) tmp;
	}
	else
	    croak("adda is not of type pcf8591Ptr");

	RETVAL = pcf8591_setda(adda, outval);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_pcf8591_aout)
{
    dXSARGS;
    if (items != 2)
	croak("Usage: i2c_ser::pcf8591_aout(adda,Kanal)");
    {
	pcf8591*	adda;
	int	Kanal = (int)SvIV(ST(1));
	double	RETVAL;

	if (sv_derived_from(ST(0), "pcf8591Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    adda = (pcf8591 *) tmp;
	}
	else
	    croak("adda is not of type pcf8591Ptr");

	RETVAL = pcf8591_aout(adda, Kanal);
	ST(0) = sv_newmortal();
	sv_setnv(ST(0), (double)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_delete8591)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::delete8591(adda)");
    {
	pcf8591*	adda;

	if (sv_derived_from(ST(0), "pcf8591Ptr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    adda = (pcf8591 *) tmp;
	}
	else
	    croak("adda is not of type pcf8591Ptr");
#line 371 "i2c_ser.xs"
if (adda != NULL)
{
free(adda);
}
#line 829 "i2c_ser.c"
    }
    XSRETURN_EMPTY;
}

XS(XS_i2c_ser_lcd_init)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::lcd_init()");
    {
	int	RETVAL;

	RETVAL = lcd_init();
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_lcd_instr)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::lcd_instr(command)");
    {
	int	command = (int)SvIV(ST(0));
	int	RETVAL;

	RETVAL = lcd_instr(command);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_lcd_wchar)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::lcd_wchar(wchar)");
    {
	int	wchar = (int)SvIV(ST(0));
	int	RETVAL;

	RETVAL = lcd_wchar(wchar);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_lcd_rchar)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::lcd_rchar(adr)");
    SP -= items;
    {
	int	adr = (int)SvIV(ST(0));
#line 398 "i2c_ser.xs"
	int	status;
	int	rchar;
#line 892 "i2c_ser.c"
	int	RETVAL;
#line 401 "i2c_ser.xs"
 status = lcd_rchar(&rchar,adr);
 EXTEND(SP,1);
 PUSHs(sv_2mortal(newSViv(rchar)));
#line 898 "i2c_ser.c"
	PUTBACK;
	return;
    }
}

XS(XS_i2c_ser_lcd_read_str)
{
    dXSARGS;
    if (items != 2)
	croak("Usage: i2c_ser::lcd_read_str(slen,adr)");
    SP -= items;
    {
	int	slen = (int)SvIV(ST(0));
	int	adr = (int)SvIV(ST(1));
#line 410 "i2c_ser.xs"
	int	status;
#line 915 "i2c_ser.c"
	int	RETVAL;
#line 412 "i2c_ser.xs"
 status = lcd_read_str(slen,adr);
 EXTEND(SP,1); 	
 PUSHs(sv_2mortal(newSVpv(lcd_STRING,0)));
#line 921 "i2c_ser.c"
	PUTBACK;
	return;
    }
}

XS(XS_i2c_ser_lcd_write_str)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::lcd_write_str(string)");
    {
	char*	string = (char *)SvPV(ST(0),PL_na);
	int	RETVAL;

	RETVAL = lcd_write_str(string);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_lcd_backlight)
{
    dXSARGS;
    if (items != 1)
	croak("Usage: i2c_ser::lcd_backlight(on_off)");
    {
	int	on_off = (int)SvIV(ST(0));
	int	RETVAL;

	RETVAL = lcd_backlight(on_off);
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

XS(XS_i2c_ser_lcd_get_adress)
{
    dXSARGS;
    if (items != 0)
	croak("Usage: i2c_ser::lcd_get_adress()");
    {
	int	RETVAL;

	RETVAL = lcd_get_adress();
	ST(0) = sv_newmortal();
	sv_setiv(ST(0), (IV)RETVAL);
    }
    XSRETURN(1);
}

#ifdef __cplusplus
extern "C"
#endif
XS(boot_i2c_ser)
{
    dXSARGS;
    char* file = __FILE__;

    XS_VERSION_BOOTCHECK ;

        newXS("i2c_ser::constant", XS_i2c_ser_constant, file);
        newXS("i2c_ser::init_iic", XS_i2c_ser_init_iic, file);
        newXS("i2c_ser::deinit_iic", XS_i2c_ser_deinit_iic, file);
        newXS("i2c_ser::set_port_delay", XS_i2c_ser_set_port_delay, file);
        newXS("i2c_ser::read_sda", XS_i2c_ser_read_sda, file);
        newXS("i2c_ser::read_scl", XS_i2c_ser_read_scl, file);
        newXS("i2c_ser::iic_start", XS_i2c_ser_iic_start, file);
        newXS("i2c_ser::iic_stop", XS_i2c_ser_iic_stop, file);
        newXS("i2c_ser::iic_send_byte", XS_i2c_ser_iic_send_byte, file);
        newXS("i2c_ser::iic_read_byte", XS_i2c_ser_iic_read_byte, file);
        newXS("i2c_ser::set_strobe", XS_i2c_ser_set_strobe, file);
        newXS("i2c_ser::byte_out", XS_i2c_ser_byte_out, file);
        newXS("i2c_ser::byte_in", XS_i2c_ser_byte_in, file);
        newXS("i2c_ser::get_status", XS_i2c_ser_get_status, file);
        newXS("i2c_ser::io_disable", XS_i2c_ser_io_disable, file);
        newXS("i2c_ser::io_enable", XS_i2c_ser_io_enable, file);
        newXS("i2c_ser::pcf8574_const", XS_i2c_ser_pcf8574_const, file);
        newXS("i2c_ser::iic_tx_pcf8574", XS_i2c_ser_iic_tx_pcf8574, file);
        newXS("i2c_ser::iic_rx_pcf8574", XS_i2c_ser_iic_rx_pcf8574, file);
        newXS("i2c_ser::sda3302_const", XS_i2c_ser_sda3302_const, file);
        newXS("i2c_ser::create3302", XS_i2c_ser_create3302, file);
        newXS("i2c_ser::sda3302_init", XS_i2c_ser_sda3302_init, file);
        newXS("i2c_ser::sda3302_calc", XS_i2c_ser_sda3302_calc, file);
        newXS("i2c_ser::sda3302_send", XS_i2c_ser_sda3302_send, file);
        newXS("i2c_ser::delete3302", XS_i2c_ser_delete3302, file);
        newXS("i2c_ser::tsa6057_const", XS_i2c_ser_tsa6057_const, file);
        newXS("i2c_ser::create6057", XS_i2c_ser_create6057, file);
        newXS("i2c_ser::tsa6057_init", XS_i2c_ser_tsa6057_init, file);
        newXS("i2c_ser::tsa6057_calc", XS_i2c_ser_tsa6057_calc, file);
        newXS("i2c_ser::tsa6057_send", XS_i2c_ser_tsa6057_send, file);
        newXS("i2c_ser::delete6057", XS_i2c_ser_delete6057, file);
        newXS("i2c_ser::pcf8591_const", XS_i2c_ser_pcf8591_const, file);
        newXS("i2c_ser::create8591", XS_i2c_ser_create8591, file);
        newXS("i2c_ser::pcf8591_init", XS_i2c_ser_pcf8591_init, file);
        newXS("i2c_ser::pcf8591_readchan", XS_i2c_ser_pcf8591_readchan, file);
        newXS("i2c_ser::pcf8591_read4chan", XS_i2c_ser_pcf8591_read4chan, file);
        newXS("i2c_ser::pcf8591_setda", XS_i2c_ser_pcf8591_setda, file);
        newXS("i2c_ser::pcf8591_aout", XS_i2c_ser_pcf8591_aout, file);
        newXS("i2c_ser::delete8591", XS_i2c_ser_delete8591, file);
        newXS("i2c_ser::lcd_init", XS_i2c_ser_lcd_init, file);
        newXS("i2c_ser::lcd_instr", XS_i2c_ser_lcd_instr, file);
        newXS("i2c_ser::lcd_wchar", XS_i2c_ser_lcd_wchar, file);
        newXS("i2c_ser::lcd_rchar", XS_i2c_ser_lcd_rchar, file);
        newXS("i2c_ser::lcd_read_str", XS_i2c_ser_lcd_read_str, file);
        newXS("i2c_ser::lcd_write_str", XS_i2c_ser_lcd_write_str, file);
        newXS("i2c_ser::lcd_backlight", XS_i2c_ser_lcd_backlight, file);
        newXS("i2c_ser::lcd_get_adress", XS_i2c_ser_lcd_get_adress, file);
    XSRETURN_YES;
}


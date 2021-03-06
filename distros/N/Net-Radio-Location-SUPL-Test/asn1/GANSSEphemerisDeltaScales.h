/*
 * Generated by asn1c-0.9.23 (http://lionet.info/asn1c)
 * From ASN.1 module "RRLP-Components"
 * 	found in "../asn1src/RRLP-Components.asn"
 * 	`asn1c -gen-PER -fskeletons-copy -fnative-types`
 */

#ifndef	_GANSSEphemerisDeltaScales_H_
#define	_GANSSEphemerisDeltaScales_H_


#include <asn_application.h>

/* Including external dependencies */
#include <NativeInteger.h>
#include <constr_SEQUENCE.h>

#ifdef __cplusplus
extern "C" {
#endif

/* GANSSEphemerisDeltaScales */
typedef struct GANSSEphemerisDeltaScales {
	long	 scale_delta_omega;
	long	 scale_delta_deltaN;
	long	 scale_delta_m0;
	long	 scale_delta_omegadot;
	long	 scale_delta_e;
	long	 scale_delta_idot;
	long	 scale_delta_sqrtA;
	long	 scale_delta_i0;
	long	 scale_delta_omega0;
	long	 scale_delta_crs;
	long	 scale_delta_cis;
	long	 scale_delta_cus;
	long	 scale_delta_crc;
	long	 scale_delta_cic;
	long	 scale_delta_cuc;
	long	 scale_delta_tgd1;
	long	 scale_delta_tgd2;
	/*
	 * This type is extensible,
	 * possible extensions are below.
	 */
	
	/* Context for parsing across buffer boundaries */
	asn_struct_ctx_t _asn_ctx;
} GANSSEphemerisDeltaScales_t;

/* Implementation */
extern asn_TYPE_descriptor_t asn_DEF_GANSSEphemerisDeltaScales;

#ifdef __cplusplus
}
#endif

#endif	/* _GANSSEphemerisDeltaScales_H_ */
#include <asn_internal.h>

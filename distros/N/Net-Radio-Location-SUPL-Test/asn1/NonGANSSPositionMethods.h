/*
 * Generated by asn1c-0.9.23 (http://lionet.info/asn1c)
 * From ASN.1 module "RRLP-Components"
 * 	found in "../asn1src/RRLP-Components.asn"
 * 	`asn1c -gen-PER -fskeletons-copy -fnative-types`
 */

#ifndef	_NonGANSSPositionMethods_H_
#define	_NonGANSSPositionMethods_H_


#include <asn_application.h>

/* Including external dependencies */
#include <BIT_STRING.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Dependencies */
typedef enum NonGANSSPositionMethods {
	NonGANSSPositionMethods_msAssistedEOTD	= 0,
	NonGANSSPositionMethods_msBasedEOTD	= 1,
	NonGANSSPositionMethods_msAssistedGPS	= 2,
	NonGANSSPositionMethods_msBasedGPS	= 3,
	NonGANSSPositionMethods_standaloneGPS	= 4
} e_NonGANSSPositionMethods;

/* NonGANSSPositionMethods */
typedef BIT_STRING_t	 NonGANSSPositionMethods_t;

/* Implementation */
extern asn_TYPE_descriptor_t asn_DEF_NonGANSSPositionMethods;
asn_struct_free_f NonGANSSPositionMethods_free;
asn_struct_print_f NonGANSSPositionMethods_print;
asn_constr_check_f NonGANSSPositionMethods_constraint;
ber_type_decoder_f NonGANSSPositionMethods_decode_ber;
der_type_encoder_f NonGANSSPositionMethods_encode_der;
xer_type_decoder_f NonGANSSPositionMethods_decode_xer;
xer_type_encoder_f NonGANSSPositionMethods_encode_xer;
per_type_decoder_f NonGANSSPositionMethods_decode_uper;
per_type_encoder_f NonGANSSPositionMethods_encode_uper;

#ifdef __cplusplus
}
#endif

#endif	/* _NonGANSSPositionMethods_H_ */
#include <asn_internal.h>

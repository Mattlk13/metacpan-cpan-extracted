/*
 * Generated by asn1c-0.9.23 (http://lionet.info/asn1c)
 * From ASN.1 module "MAP-MS-DataTypes"
 * 	found in "../asn1src/MAP-MS-DataTypes.asn"
 * 	`asn1c -gen-PER -fskeletons-copy -fnative-types`
 */

#include "ODB-Data.h"

static asn_TYPE_member_t asn_MBR_ODB_Data_1[] = {
	{ ATF_NOFLAGS, 0, offsetof(struct ODB_Data, odb_GeneralData),
		(ASN_TAG_CLASS_UNIVERSAL | (3 << 2)),
		0,
		&asn_DEF_ODB_GeneralData,
		0,	/* Defer constraints checking to the member type */
		0,	/* No PER visible constraints */
		0,
		"odb-GeneralData"
		},
	{ ATF_POINTER, 2, offsetof(struct ODB_Data, odb_HPLMN_Data),
		(ASN_TAG_CLASS_UNIVERSAL | (3 << 2)),
		0,
		&asn_DEF_ODB_HPLMN_Data,
		0,	/* Defer constraints checking to the member type */
		0,	/* No PER visible constraints */
		0,
		"odb-HPLMN-Data"
		},
	{ ATF_POINTER, 1, offsetof(struct ODB_Data, extensionContainer),
		(ASN_TAG_CLASS_UNIVERSAL | (16 << 2)),
		0,
		&asn_DEF_ExtensionContainer,
		0,	/* Defer constraints checking to the member type */
		0,	/* No PER visible constraints */
		0,
		"extensionContainer"
		},
};
static int asn_MAP_ODB_Data_oms_1[] = { 1, 2 };
static ber_tlv_tag_t asn_DEF_ODB_Data_tags_1[] = {
	(ASN_TAG_CLASS_UNIVERSAL | (16 << 2))
};
static asn_TYPE_tag2member_t asn_MAP_ODB_Data_tag2el_1[] = {
    { (ASN_TAG_CLASS_UNIVERSAL | (3 << 2)), 0, 0, 1 }, /* odb-GeneralData at 1528 */
    { (ASN_TAG_CLASS_UNIVERSAL | (3 << 2)), 1, -1, 0 }, /* odb-HPLMN-Data at 1529 */
    { (ASN_TAG_CLASS_UNIVERSAL | (16 << 2)), 2, 0, 0 } /* extensionContainer at 1530 */
};
static asn_SEQUENCE_specifics_t asn_SPC_ODB_Data_specs_1 = {
	sizeof(struct ODB_Data),
	offsetof(struct ODB_Data, _asn_ctx),
	asn_MAP_ODB_Data_tag2el_1,
	3,	/* Count of tags in the map */
	asn_MAP_ODB_Data_oms_1,	/* Optional members */
	2, 0,	/* Root/Additions */
	2,	/* Start extensions */
	4	/* Stop extensions */
};
asn_TYPE_descriptor_t asn_DEF_ODB_Data = {
	"ODB-Data",
	"ODB-Data",
	SEQUENCE_free,
	SEQUENCE_print,
	SEQUENCE_constraint,
	SEQUENCE_decode_ber,
	SEQUENCE_encode_der,
	SEQUENCE_decode_xer,
	SEQUENCE_encode_xer,
	SEQUENCE_decode_uper,
	SEQUENCE_encode_uper,
	0,	/* Use generic outmost tag fetcher */
	asn_DEF_ODB_Data_tags_1,
	sizeof(asn_DEF_ODB_Data_tags_1)
		/sizeof(asn_DEF_ODB_Data_tags_1[0]), /* 1 */
	asn_DEF_ODB_Data_tags_1,	/* Same as above */
	sizeof(asn_DEF_ODB_Data_tags_1)
		/sizeof(asn_DEF_ODB_Data_tags_1[0]), /* 1 */
	0,	/* No PER visible constraints */
	asn_MBR_ODB_Data_1,
	3,	/* Elements count */
	&asn_SPC_ODB_Data_specs_1	/* Additional specs */
};


/* c/zx-xenc-dec.c - WARNING: This file was auto generated by xsd2sg.pl. DO NOT EDIT!
 * $Id$ */
/* Code generation design Copyright (c) 2006 Sampo Kellomaki (sampo@iki.fi),
 * All Rights Reserved. NO WARRANTY. See file COPYING for terms and conditions
 * of use. Some aspects of code generation were driven by schema
 * descriptions that were used as input and may be subject to their own copyright.
 * Code generation uses a template, whose copyright statement follows. */

/** dec-templ.c  -  XML decoder template, used in code generation
 ** Copyright (c) 2010 Sampo Kellomaki (sampo@iki.fi), All Rights Reserved.
 ** Copyright (c) 2006-2007 Symlabs (symlabs@symlabs.com), All Rights Reserved.
 ** Author: Sampo Kellomaki (sampo@iki.fi)
 ** This is confidential unpublished proprietary source code of the author.
 ** NO WARRANTY, not even implied warranties. Contains trade secrets.
 ** Distribution prohibited unless authorized in writing.
 ** Licensed under Apache License 2.0, see file COPYING.
 ** Id: dec-templ.c,v 1.30 2008-10-04 23:42:14 sampo Exp $
 **
 ** 28.5.2006, created, Sampo Kellomaki (sampo@iki.fi)
 ** 8.8.2006,  reworked namespace handling --Sampo
 ** 12.8.2006, added special scanning of xmlns to avoid backtracking elem recognition --Sampo
 ** 23.9.2006, added collection of WO information --Sampo
 ** 21.6.2007, improved handling of undeclared namespace prefixes --Sampo
 ** 27.10.2010, CSE refactoring, re-engineered namespace handling --Sampo
 ** 21.11.2010, re-engineered to extract most code to zx_DEC_elem, leaving just switches --Sampo
 **
 ** N.B: This template is meant to be processed by pd/xsd2sg.pl. Beware
 ** of special markers that xsd2sg.pl expects to find and understand.
 **/

#include "errmac.h"
#include "zx.h"
#include "c/zx-const.h"
#include "c/zx-data.h"
#include "c/zx-xenc-data.h"
#define TPF zx_
#include "zx_ext_pt.h"



int zx_DEC_ATTR_xenc_AgreementMethod(struct zx_ctx* c, struct zx_xenc_AgreementMethod_s* x)
{
  switch (x->gg.attr->g.tok) {
    case zx_Algorithm_ATTR:  x->Algorithm = x->gg.attr; return 1;

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_AgreementMethod(struct zx_ctx* c, struct zx_xenc_AgreementMethod_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {
  case zx_xenc_KA_Nonce_ELEM:
    if (!x->KA_Nonce)
      x->KA_Nonce = el;
    return 1;
  case zx_xenc_OriginatorKeyInfo_ELEM:
    if (!x->OriginatorKeyInfo)
      x->OriginatorKeyInfo = (struct zx_xenc_OriginatorKeyInfo_s*)el;
    return 1;
  case zx_xenc_RecipientKeyInfo_ELEM:
    if (!x->RecipientKeyInfo)
      x->RecipientKeyInfo = (struct zx_xenc_RecipientKeyInfo_s*)el;
    return 1;

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_CipherData(struct zx_ctx* c, struct zx_xenc_CipherData_s* x)
{
  switch (x->gg.attr->g.tok) {

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_CipherData(struct zx_ctx* c, struct zx_xenc_CipherData_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {
  case zx_xenc_CipherValue_ELEM:
    if (!x->CipherValue)
      x->CipherValue = el;
    return 1;
  case zx_xenc_CipherReference_ELEM:
    if (!x->CipherReference)
      x->CipherReference = (struct zx_xenc_CipherReference_s*)el;
    return 1;

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_CipherReference(struct zx_ctx* c, struct zx_xenc_CipherReference_s* x)
{
  switch (x->gg.attr->g.tok) {
    case zx_URI_ATTR:  x->URI = x->gg.attr; return 1;

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_CipherReference(struct zx_ctx* c, struct zx_xenc_CipherReference_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {
  case zx_xenc_Transforms_ELEM:
    if (!x->Transforms)
      x->Transforms = (struct zx_xenc_Transforms_s*)el;
    return 1;

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_DataReference(struct zx_ctx* c, struct zx_xenc_DataReference_s* x)
{
  switch (x->gg.attr->g.tok) {
    case zx_URI_ATTR:  x->URI = x->gg.attr; return 1;

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_DataReference(struct zx_ctx* c, struct zx_xenc_DataReference_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_EncryptedData(struct zx_ctx* c, struct zx_xenc_EncryptedData_s* x)
{
  switch (x->gg.attr->g.tok) {
    case zx_Encoding_ATTR:  x->Encoding = x->gg.attr; return 1;
    case zx_Id_ATTR:  x->Id = x->gg.attr; return 1;
    case zx_MimeType_ATTR:  x->MimeType = x->gg.attr; return 1;
    case zx_Type_ATTR:  x->Type = x->gg.attr; return 1;

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_EncryptedData(struct zx_ctx* c, struct zx_xenc_EncryptedData_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {
  case zx_xenc_EncryptionMethod_ELEM:
    if (!x->EncryptionMethod)
      x->EncryptionMethod = (struct zx_xenc_EncryptionMethod_s*)el;
    return 1;
  case zx_ds_KeyInfo_ELEM:
    if (!x->KeyInfo)
      x->KeyInfo = (struct zx_ds_KeyInfo_s*)el;
    return 1;
  case zx_xenc_CipherData_ELEM:
    if (!x->CipherData)
      x->CipherData = (struct zx_xenc_CipherData_s*)el;
    return 1;
  case zx_xenc_EncryptionProperties_ELEM:
    if (!x->EncryptionProperties)
      x->EncryptionProperties = (struct zx_xenc_EncryptionProperties_s*)el;
    return 1;

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_EncryptedKey(struct zx_ctx* c, struct zx_xenc_EncryptedKey_s* x)
{
  switch (x->gg.attr->g.tok) {
    case zx_Encoding_ATTR:  x->Encoding = x->gg.attr; return 1;
    case zx_Id_ATTR:  x->Id = x->gg.attr; return 1;
    case zx_MimeType_ATTR:  x->MimeType = x->gg.attr; return 1;
    case zx_Recipient_ATTR:  x->Recipient = x->gg.attr; return 1;
    case zx_Type_ATTR:  x->Type = x->gg.attr; return 1;

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_EncryptedKey(struct zx_ctx* c, struct zx_xenc_EncryptedKey_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {
  case zx_xenc_EncryptionMethod_ELEM:
    if (!x->EncryptionMethod)
      x->EncryptionMethod = (struct zx_xenc_EncryptionMethod_s*)el;
    return 1;
  case zx_ds_KeyInfo_ELEM:
    if (!x->KeyInfo)
      x->KeyInfo = (struct zx_ds_KeyInfo_s*)el;
    return 1;
  case zx_xenc_CipherData_ELEM:
    if (!x->CipherData)
      x->CipherData = (struct zx_xenc_CipherData_s*)el;
    return 1;
  case zx_xenc_EncryptionProperties_ELEM:
    if (!x->EncryptionProperties)
      x->EncryptionProperties = (struct zx_xenc_EncryptionProperties_s*)el;
    return 1;
  case zx_xenc_ReferenceList_ELEM:
    if (!x->ReferenceList)
      x->ReferenceList = (struct zx_xenc_ReferenceList_s*)el;
    return 1;
  case zx_xenc_CarriedKeyName_ELEM:
    if (!x->CarriedKeyName)
      x->CarriedKeyName = el;
    return 1;

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_EncryptionMethod(struct zx_ctx* c, struct zx_xenc_EncryptionMethod_s* x)
{
  switch (x->gg.attr->g.tok) {
    case zx_Algorithm_ATTR:  x->Algorithm = x->gg.attr; return 1;

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_EncryptionMethod(struct zx_ctx* c, struct zx_xenc_EncryptionMethod_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {
  case zx_xenc_KeySize_ELEM:
    if (!x->KeySize)
      x->KeySize = el;
    return 1;
  case zx_xenc_OAEPparams_ELEM:
    if (!x->OAEPparams)
      x->OAEPparams = el;
    return 1;

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_EncryptionProperties(struct zx_ctx* c, struct zx_xenc_EncryptionProperties_s* x)
{
  switch (x->gg.attr->g.tok) {
    case zx_Id_ATTR:  x->Id = x->gg.attr; return 1;

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_EncryptionProperties(struct zx_ctx* c, struct zx_xenc_EncryptionProperties_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {
  case zx_xenc_EncryptionProperty_ELEM:
    if (!x->EncryptionProperty)
      x->EncryptionProperty = (struct zx_xenc_EncryptionProperty_s*)el;
    return 1;

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_EncryptionProperty(struct zx_ctx* c, struct zx_xenc_EncryptionProperty_s* x)
{
  switch (x->gg.attr->g.tok) {
    case zx_Id_ATTR:  x->Id = x->gg.attr; return 1;
    case zx_Target_ATTR:  x->Target = x->gg.attr; return 1;

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_EncryptionProperty(struct zx_ctx* c, struct zx_xenc_EncryptionProperty_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_KeyReference(struct zx_ctx* c, struct zx_xenc_KeyReference_s* x)
{
  switch (x->gg.attr->g.tok) {
    case zx_URI_ATTR:  x->URI = x->gg.attr; return 1;

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_KeyReference(struct zx_ctx* c, struct zx_xenc_KeyReference_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_OriginatorKeyInfo(struct zx_ctx* c, struct zx_xenc_OriginatorKeyInfo_s* x)
{
  switch (x->gg.attr->g.tok) {
    case zx_Id_ATTR:  x->Id = x->gg.attr; return 1;

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_OriginatorKeyInfo(struct zx_ctx* c, struct zx_xenc_OriginatorKeyInfo_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {
  case zx_ds_KeyName_ELEM:
    if (!x->KeyName)
      x->KeyName = el;
    return 1;
  case zx_ds_KeyValue_ELEM:
    if (!x->KeyValue)
      x->KeyValue = (struct zx_ds_KeyValue_s*)el;
    return 1;
  case zx_ds_RetrievalMethod_ELEM:
    if (!x->RetrievalMethod)
      x->RetrievalMethod = (struct zx_ds_RetrievalMethod_s*)el;
    return 1;
  case zx_ds_X509Data_ELEM:
    if (!x->X509Data)
      x->X509Data = (struct zx_ds_X509Data_s*)el;
    return 1;
  case zx_ds_PGPData_ELEM:
    if (!x->PGPData)
      x->PGPData = (struct zx_ds_PGPData_s*)el;
    return 1;
  case zx_ds_SPKIData_ELEM:
    if (!x->SPKIData)
      x->SPKIData = (struct zx_ds_SPKIData_s*)el;
    return 1;
  case zx_ds_MgmtData_ELEM:
    if (!x->MgmtData)
      x->MgmtData = el;
    return 1;
  case zx_xenc_EncryptedKey_ELEM:
    if (!x->EncryptedKey)
      x->EncryptedKey = (struct zx_xenc_EncryptedKey_s*)el;
    return 1;

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_RecipientKeyInfo(struct zx_ctx* c, struct zx_xenc_RecipientKeyInfo_s* x)
{
  switch (x->gg.attr->g.tok) {
    case zx_Id_ATTR:  x->Id = x->gg.attr; return 1;

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_RecipientKeyInfo(struct zx_ctx* c, struct zx_xenc_RecipientKeyInfo_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {
  case zx_ds_KeyName_ELEM:
    if (!x->KeyName)
      x->KeyName = el;
    return 1;
  case zx_ds_KeyValue_ELEM:
    if (!x->KeyValue)
      x->KeyValue = (struct zx_ds_KeyValue_s*)el;
    return 1;
  case zx_ds_RetrievalMethod_ELEM:
    if (!x->RetrievalMethod)
      x->RetrievalMethod = (struct zx_ds_RetrievalMethod_s*)el;
    return 1;
  case zx_ds_X509Data_ELEM:
    if (!x->X509Data)
      x->X509Data = (struct zx_ds_X509Data_s*)el;
    return 1;
  case zx_ds_PGPData_ELEM:
    if (!x->PGPData)
      x->PGPData = (struct zx_ds_PGPData_s*)el;
    return 1;
  case zx_ds_SPKIData_ELEM:
    if (!x->SPKIData)
      x->SPKIData = (struct zx_ds_SPKIData_s*)el;
    return 1;
  case zx_ds_MgmtData_ELEM:
    if (!x->MgmtData)
      x->MgmtData = el;
    return 1;
  case zx_xenc_EncryptedKey_ELEM:
    if (!x->EncryptedKey)
      x->EncryptedKey = (struct zx_xenc_EncryptedKey_s*)el;
    return 1;

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_ReferenceList(struct zx_ctx* c, struct zx_xenc_ReferenceList_s* x)
{
  switch (x->gg.attr->g.tok) {

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_ReferenceList(struct zx_ctx* c, struct zx_xenc_ReferenceList_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {
  case zx_xenc_DataReference_ELEM:
    if (!x->DataReference)
      x->DataReference = (struct zx_xenc_DataReference_s*)el;
    return 1;
  case zx_xenc_KeyReference_ELEM:
    if (!x->KeyReference)
      x->KeyReference = (struct zx_xenc_KeyReference_s*)el;
    return 1;

  default: return 0;
  }
}




int zx_DEC_ATTR_xenc_Transforms(struct zx_ctx* c, struct zx_xenc_Transforms_s* x)
{
  switch (x->gg.attr->g.tok) {

  default: return 0;
  }
}

int zx_DEC_ELEM_xenc_Transforms(struct zx_ctx* c, struct zx_xenc_Transforms_s* x)
{
  struct zx_elem_s* el = x->gg.kids;
  switch (el->g.tok) {
  case zx_ds_Transform_ELEM:
    if (!x->Transform)
      x->Transform = (struct zx_ds_Transform_s*)el;
    return 1;

  default: return 0;
  }
}


/* EOF -- c/zx-xenc-dec.c */

/* ****************************************************************************

 * eID Middleware Project.
 * Copyright (C) 2008-2009 FedICT.
 * Copyright (C) 2019 Caixa Magica Software.
 * Copyright (C) 2011 Vasco Silva - <vasco.silva@caixamagica.pt>
 * Copyright (C) 2012 lmcm - <lmcm@caixamagica.pt>
 * Copyright (C) 2016 André Guerreiro - <aguerreiro1985@gmail.com>
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License version
 * 3.0 as published by the Free Software Foundation.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this software; if not, see
 * http://www.gnu.org/licenses/.

**************************************************************************** */
#pragma once

#ifndef __INTERNALUTIL_H__
#define __INTERNALUTIL_H__

#include "eidlibdefines.h"
#include "APLReader.h"
#include "APLCertif.h"
#include "APLCard.h"

#include "eidlibException.h"
#include "MWException.h"
#include "LogBase.h"

#define BEGIN_TRY_CATCH										\
	if(m_context->mutex) m_context->mutex->Lock();			\
															\
	try														\
	{														\
		checkContextStillOk();								\
	}														\
	catch(PTEID_Exception &e)								\
	{							\
		e.GetError();				         \
		if(m_context->mutex) m_context->mutex->Unlock();	\
		throw;												\
	}														\
															\
	try														\
	{

#define END_TRY_CATCH										\
	}														\
	catch(PTEID_Exception &e)								\
	{														\
		e.GetError();										\
		if(m_context->mutex) m_context->mutex->Unlock();	\
		throw;												\
	}														\
	catch(CBatchSignFailedException &e)						\
	{														\
		if(m_context->mutex) m_context->mutex->Unlock();	\
		throw PTEID_ExBatchSignatureFailed(e.GetError(),	\
			e.GetFailedSignatureIndex());					\
	}														\
	catch(CMWException &e)									\
	{														\
		e.GetError();										\
		if(m_context->mutex) m_context->mutex->Unlock();	\
		throw PTEID_Exception::THROWException(e);			\
	}														\
	catch(...)												\
	{														\
		if(m_context->mutex) m_context->mutex->Unlock();	\
		throw;												\
	}														\
	if(m_context->mutex) m_context->mutex->Unlock();		\

namespace eIDMW
{

class APL_ReaderContext;

struct SDK_Context
{
	unsigned long contextid;
	APL_ReaderContext *reader;
	unsigned long cardid;
	CMutex *mutex;
};

PTEID_CardType ConvertCardType(APL_CardType eCardType);
PTEID_CertifStatus ConvertCertStatus(APL_CertifStatus eStatus);
PTEID_CertifType ConvertCertType(APL_CertifType eType);


APL_HashAlgo ConvertHashAlgo(PTEID_HashAlgo eAlgo);

tLOG_Level ConvertLogLevel(PTEID_LogLevel level);

APL_SignatureLevel ConvertSignatureLevel(PTEID_SignatureLevel level);
}

#endif //__INTERNALUTIL_H__

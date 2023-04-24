/* ****************************************************************************

 * eID Middleware Project.
 * Copyright (C) 2008-2009 FedICT.
 * Copyright (C) 2019 Caixa Magica Software.
 * Copyright (C) 2011 Vasco Silva - <vasco.silva@caixamagica.pt>
 * Copyright (C) 2016, 2018 André Guerreiro - <aguerreiro1985@gmail.com>
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

#include "langUtil.h"
#include "dialogs.h"
#include "Config.h"
#include "Util.h"

namespace eIDMW
{

bool CLang::ms_InitOk=false;
tLanguage CLang::ms_Lang=LANG_EN;

const wchar_t *CLang::GetLangW()
{
	if(!ms_InitOk) 
		Init();

	switch(ms_Lang)
	{
	case LANG_EN:
		return LANG_STRCODE_EN;
	case LANG_NL:
		return LANG_STRCODE_NL;
	default:
		return LANG_STRCODE_EN;
	}
}

unsigned long CLang::GetLangL()
{
	if(!ms_InitOk) 
		Init();

	switch(ms_Lang)
	{
	case LANG_EN:
		return DLG_LANG_EN;
	case LANG_NL:
		return DLG_LANG_NL;
	default:
		return DLG_LANG_EN;
	}
}
void CLang::SetLangW(const wchar_t *lang)
{
	ms_InitOk=true;

	if(wcscmp(lang,LANG_STRCODE_EN)==0)
		ms_Lang=LANG_EN;
	else if(wcscmp(lang,LANG_STRCODE_NL)==0)
		ms_Lang=LANG_NL;
	else
		ms_InitOk=false;
}

void CLang::SetLangL(unsigned long lang)
{

	switch(lang)
	{
	case DLG_LANG_EN:
		ms_Lang=LANG_EN;
		break;
	case DLG_LANG_NL:
		ms_Lang=LANG_NL;
		break;
	default:
		ms_Lang=LANG_EN;
		break;
	}
}

void CLang::Init()
{
	std::wstring lang = CConfig::GetString(CConfig::EIDMW_CONFIG_PARAM_GENERAL_LANGUAGE);

	if(wcscmp(L"nl",lang.c_str())==0)
		ms_Lang=LANG_NL;
	else
		ms_Lang=LANG_EN;

	ms_InitOk=true;
}

}

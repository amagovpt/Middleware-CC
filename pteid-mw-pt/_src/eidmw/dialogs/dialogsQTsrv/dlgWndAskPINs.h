/* ****************************************************************************

 * eID Middleware Project.
 * Copyright (C) 2008-2009 FedICT.
 * Copyright (C) 2019 Caixa Magica Software.
 * Copyright (C) 2011 Vasco Silva - <vasco.silva@caixamagica.pt>
 * Copyright (C) 2016, 2018 André Guerreiro - <aguerreiro1985@gmail.com>
 * Copyright (C) 2017 Luiz Lemos - <luiz.lemos@caixamagica.pt>
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

#ifndef DLGWNDASKPINS_H
#define DLGWNDASKPINS_H

#include <QDialog>
#include <QIntValidator>
#include "ui_dlgWndAskPINs.h"
#include "dlgWndAskPIN.h"
#include "dlgWndBase.h"
#include "../dialogs.h"

using namespace eIDMW;

#define INPUTFIELD_OLD 0
#define INPUTFIELD_NEW 1
#define INPUTFIELD_CONFIRM 2

class dlgWndAskPINs : public dlgWndBase
{
	Q_OBJECT

public:
	dlgWndAskPINs( DlgPinInfo pinInfo1, DlgPinInfo pinInfo2, QString & Header, QString & PINName, bool UseKeypad, QWidget *parent = 0, Type_WndGeometry *pParentWndGeometry = 0 );
	~dlgWndAskPINs();

	std::wstring getPIN1(){ return QString(ui.txtOldPIN->text()).toStdWString(); };
	std::wstring getPIN2(){ return QString(ui.txtNewPIN1->text()).toStdWString(); };

private:
	Ui::dlgWndAskPINsClass ui;
	bool OldPIN_OK, NewPIN1_OK, NewPIN2_OK;
	bool TestPINs(){ return ( OldPIN_OK && NewPIN1_OK && NewPIN2_OK ); }
	void updateColors( QLineEdit* lineEdit, bool bOk );
	unsigned int m_ulPin1MinLen;
	unsigned int m_ulPin2MinLen;
	unsigned int m_ulPin1MaxLen;
	unsigned int m_ulPin2MaxLen;
	unsigned int m_ulPinMaxLen;
	unsigned int m_ulPin2Flags;
	bool m_UseKeypad;
	QRegExpValidator *m_Pin1Validator;
	QRegExpValidator *m_Pin2Validator;

private Q_SLOTS:
	void on_txtOldPIN_textChanged( const QString & );
	void on_txtNewPIN1_textChanged( const QString & );
	void on_txtNewPIN2_textChanged( const QString & );
	void FinalCheck();
};

#endif // DLGWNDASKPINS_H

/*-****************************************************************************

 * Copyright (C) 2017-2020 Adriano Campos - <adrianoribeirocampos@gmail.com>
 * Copyright (C) 2018-2020 Miguel Figueira - <miguelblcfigueira@gmail.com>
 * Copyright (C) 2019 João Pinheiro - <joao.pinheiro@caixamagica.pt>
 * Copyright (C) 2019-2020 José Pinto - <jose.pinto@caixamagica.pt>
 *
 * Licensed under the EUPL V.1.2

****************************************************************************-*/

/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.6
import QtQuick.Window 2.2

/* Constants imports */
import "../scripts/Constants.js" as Constants

Item {
    id: titleBar

    property alias propertyTitleBar: container
    property alias propertyModeText: modeText
    property alias propertyMouseRegion: mouseRegion

    property variant clickPos: ""
    property variant appStartPos: ""
    property variant appStartPosBackup: ""

    Rectangle {
        id: container
        width: parent.width
        height: parent.height
        color: Constants.COLOR_MAIN_BLUE
        Item {
            width:  mainFormID.propertyMainMenuView.width
            height: parent.height
            Text {
                id: categoryText
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
                text: mainWindow.title
                font.pixelSize: Constants.SIZE_TEXT_BODY
                font.family: lato.name
                color: "white"
            }
            Text {
                id: modeText
                property string propertyTestModeText: controler.getTestMode() ?
                    "  [" + qsTr("STR_RUN_MODE") + "]" + controler.autoTr : ""
                property string propertyDebugModeText: controler.getDebugModeValue() ?
                    "  [" + qsTr("STR_RUN_DEBUG_MODE") + "]" + controler.autoTr : ""

                text: propertyTestModeText + propertyDebugModeText
                anchors.left: categoryText.right
                anchors {
                    verticalCenter: parent.verticalCenter
                }
                font.pixelSize: Constants.SIZE_TEXT_BODY
                font.family: lato.name
                color: "white"
            }
        }

        Item {
            id: minimizeRect
            width: Constants.SIZE_IMAGE_ICON_TITLE_BAR + Constants.TITLE_BAR_H_ICON_SPACE
            height: parent.height
            anchors.right: fullScreenRect.left
            Image {
                id: minimizeButton
                width: Constants.SIZE_IMAGE_ICON_TITLE_BAR
                height: Constants.SIZE_IMAGE_ICON_TITLE_BAR
                fillMode: Image.PreserveAspectFit
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                source: mouseAreaMinimizeButton.containsMouse ?
                            "../images/titleBar/minimize_hover.png" :
                            "../images/titleBar/minimize.png"
            }
            MouseArea {
                id: mouseAreaMinimizeButton
                anchors.fill: parent
                hoverEnabled: true
                onClicked:{
                    if (Qt.platform.os === "osx")
                        mainWindow.flags = Qt.Window | Qt.CustomizeWindowHint | Qt.WindowMinMaxButtonsHint;
                    mainWindow.showMinimized();
                }
            }
        }
        Item {
            id: fullScreenRect
            width: Constants.SIZE_IMAGE_ICON_TITLE_BAR + Constants.TITLE_BAR_H_ICON_SPACE
            height: parent.height
            anchors.right: quitRect.left
            Image {
                id: fullScreentButton
                width: Constants.SIZE_IMAGE_ICON_TITLE_BAR
                height: Constants.SIZE_IMAGE_ICON_TITLE_BAR
                fillMode: Image.PreserveAspectFit
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                source: getFullScreentButtonIcon()
            }
            MouseArea {
                id: mouseAreaFullScreentButton
                anchors.fill: parent
                hoverEnabled: true
                onClicked: getScreenState()
            }
        }
        Item {
            id: quitRect
            width: Constants.SIZE_IMAGE_ICON_TITLE_BAR + Constants.TITLE_BAR_H_ICON_SPACE
            height: parent.height
            anchors.right: parent.right
            Image {
                id: quitButton
                width: Constants.SIZE_IMAGE_ICON_TITLE_BAR
                height: Constants.SIZE_IMAGE_ICON_TITLE_BAR
                fillMode: Image.PreserveAspectFit
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                source: mouseAreaQuitButton.containsMouse ?
                            "../images/titleBar/quit_hover.png" :
                            "../images/titleBar/quit.png"
            }
            MouseArea {
                id: mouseAreaQuitButton
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    mainWindow.close()
                }
            }
        }
        MouseArea {
            id: mouseRegion
            anchors.left: parent.left
            anchors.right: minimizeRect.left
            anchors.bottom: parent.bottom
            height: parent.height - Constants.FRAME_WINDOW_SIZE

            cursorShape: Qt.OpenHandCursor

            onPressed: {
                // fetch global position
                clickPos = controler.getCursorPos()
                appStartPos = Qt.point(mainWindow.x, mainWindow.y)
                if(appStartPos.x != 0 && appStartPos.y != 0)
                    appStartPosBackup = appStartPos
            }
            onDoubleClicked: {
                getScreenState()
            }
            onPositionChanged: {
                var newPos = controler.getCursorPos()
                var delta = Qt.point(newPos.x-clickPos.x, newPos.y-clickPos.y)
                mainWindow.x = appStartPos.x+delta.x;
                mainWindow.y = appStartPos.y+delta.y;
            }
        }
    }
    function getScreenState(){
        if(mainWindow.visibility === Window.Maximized
            || mainWindow.visibility === Window.FullScreen){
            appStartPos = appStartPosBackup
            mainWindow.showNormal()
        }else{
            console.log("Screen is not Maximized" + mainWindow.visibility)
            appStartPos = Qt.point(Screen.virtualX, Screen.virtualY)
            mainWindow.showMaximized()
        }
    }

    function getFullScreentButtonIcon(){
        if(mainWindow.visibility === Window.Maximized
            || mainWindow.visibility === Window.FullScreen){
            return mouseAreaFullScreentButton.containsMouse ?
                    "../images/titleBar/restore_hover.png" :
                    "../images/titleBar/restore.png"
        }else{
            return mouseAreaFullScreentButton.containsMouse ?
                    "../images/titleBar/maximize_hover.png" :
                    "../images/titleBar/maximize.png"
        }        
    }

}
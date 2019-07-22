import QtQuick 2.6
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

import "../../scripts/Constants.js" as Constants


Item {

    property alias propertyrectAppCache: rectAppCache
    property alias propertyButtonRemoveAppCache: buttonRemoveAppCache
    property alias propertyBusyIndicator : busyIndication
    property alias propertyButtonRemoveSCAPCache: buttonRemoveSCAPCache
    property alias propertyCacheAppSizeTextField : cacheAppSizeTextField
    property alias propertyCacheSCAPSizeTextField : cacheSCAPSizeTextField

    property alias propertyMainItem: dateAppCache

    anchors.fill: parent

    Item {
        id: rowTop
        width: parent.width
        height: parent.height * Constants.HEIGHT_DEFINITIONS_APP_ROW_TOP_V_RELATIVE
                + (parent.height + Constants.TITLE_BAR_SIZE - Constants.SCREEN_MINIMUM_HEIGHT)
                * Constants.HEIGHT_DEFINITIONS_APP_ROW_TOP_INC_RELATIVE
    }

    Item {
        id: rowMain
        width: parent.width
        height: parent.height
        anchors.topMargin: Constants.SIZE_ROW_V_SPACE
        anchors.top: rowTop.bottom
        
        BusyIndicator {
            id: busyIndication
            running: false
            anchors.centerIn: parent
            // BusyIndicator should be on top of all other content
            z: 1
        }

        
        Item{
            id: rectAppCache
            width: parent.width
            height: 5*Constants.SIZE_TEXT_FIELD + 3*Constants.SIZE_ROW_V_SPACE
            anchors.leftMargin: Constants.SIZE_ROW_H_SPACE
            anchors.topMargin: Constants.SIZE_ROW_V_SPACE_DEFINITIONS_APP

            Text {
                id: dateAppCache
                x: Constants.SIZE_TEXT_FIELD_H_SPACE
                font.pixelSize: activeFocus
                                ? Constants.SIZE_TEXT_LABEL_FOCUS
                                : Constants.SIZE_TEXT_LABEL
                font.family: lato.name
                font.bold: focus
                color: Constants.COLOR_TEXT_LABEL
                height: Constants.SIZE_TEXT_LABEL
                text: qsTranslate("PageDataApp","STR_CACHE_TITLE") + controler.autoTr
                Accessible.role: Accessible.TitleBar
                Accessible.name: text
                KeyNavigation.tab: cacheAppTextField
                KeyNavigation.down: cacheAppTextField
                KeyNavigation.right: cacheAppTextField
                KeyNavigation.backtab: buttonRemoveSCAPCache
                KeyNavigation.up: buttonRemoveSCAPCache
            }
            DropShadow {
                anchors.fill: rowAppCache
                horizontalOffset: Constants.FORM_SHADOW_H_OFFSET
                verticalOffset: Constants.FORM_SHADOW_V_OFFSET
                radius: Constants.FORM_SHADOW_RADIUS
                samples: Constants.FORM_SHADOW_SAMPLES
                color: Constants.COLOR_FORM_SHADOW
                source: rowAppCache
                spread: Constants.FORM_SHADOW_SPREAD
                opacity: Constants.FORM_SHADOW_OPACITY_FORM_EFFECT
            }
            RectangularGlow {
                anchors.fill: rowAppCache
                glowRadius: Constants.FORM_GLOW_RADIUS
                spread: Constants.FORM_GLOW_SPREAD
                color: Constants.COLOR_FORM_GLOW
                cornerRadius: Constants.FORM_GLOW_CORNER_RADIUS
                opacity: Constants.FORM_GLOW_OPACITY_FORM_EFFECT
            }
            Rectangle {
                id: rowAppCache
                width: parent.width
                height: 4*Constants.SIZE_TEXT_FIELD + 3*Constants.SIZE_ROW_V_SPACE
                anchors.top: dateAppCache.bottom
                anchors.topMargin: Constants.SIZE_TEXT_V_SPACE
                Rectangle {
                    id: rectAppCacheDesc
                    height: 2*Constants.SIZE_TEXT_FIELD
                    width: parent.width - 2*Constants.SIZE_ROW_H_SPACE
                    anchors.top: rowAppCache.top
                    anchors.topMargin: Constants.SIZE_ROW_V_SPACE
                    anchors.left:rowAppCache.left
                    anchors.leftMargin: Constants.SIZE_ROW_H_SPACE 
                    Text {
                        id: cacheAppTextField
                        text: qsTranslate("PageDataApp","STR_APP_CACHE_TEXT")
                        width: parent.width
                        height: parent.height
                        font.capitalization: Font.MixedCase
                        font.pixelSize: Constants.SIZE_TEXT_FIELD
                        font.family: lato.name
                        font.bold: focus
                        wrapMode: Text.WordWrap
                        Accessible.role: Accessible.StaticText
                        Accessible.name: text
                        KeyNavigation.tab: cacheAppSizeTextField
                        KeyNavigation.down: cacheAppSizeTextField
                        KeyNavigation.right: cacheAppSizeTextField
                        KeyNavigation.backtab: dateAppCache
                        KeyNavigation.up: dateAppCache
                    }
                }

                Rectangle {
                    id: rectAppCacheRemove
                    width: parent.width
                    height: 2*Constants.SIZE_TEXT_FIELD
                    anchors.top: rectAppCacheDesc.bottom
                    anchors.topMargin: Constants.SIZE_ROW_V_SPACE 
                
                    Rectangle {
                        id: rectAppCacheText
                        width: (parent.width - 3 * Constants.SIZE_ROW_H_SPACE) * 0.50
                        anchors.left: rectAppCacheRemove.left
                        anchors.leftMargin: Constants.SIZE_ROW_H_SPACE
                        Text {
                            id: cacheAppSizeTextField
                            text: qsTranslate("PageDataApp","STR_CLEAR_CACHE_NO_INFO") + controler.autoTr
                            width: parent.width
                            height: parent.height
                            font.capitalization: Font.MixedCase
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            font.family: lato.name
                            font.bold: focus
                            wrapMode: Text.WordWrap
                            topPadding: Constants.SIZE_ROW_V_SPACE
                            Accessible.role: Accessible.StaticText
                            Accessible.name: text
                            KeyNavigation.tab: buttonRemoveAppCache
                            KeyNavigation.down: buttonRemoveAppCache
                            KeyNavigation.right: buttonRemoveAppCache
                            KeyNavigation.backtab: cacheAppTextField
                            KeyNavigation.up: cacheAppTextField
                        }
                    }
                    Rectangle {
                        id: rectAppCacheButton
                        width: (parent.width - 3 * Constants.SIZE_ROW_H_SPACE) * 0.50
                        anchors.right: rectAppCacheRemove.right
                        anchors.rightMargin: Constants.SIZE_ROW_H_SPACE
                        Button {
                            id: buttonRemoveAppCache
                            text: qsTranslate("PageDataApp","STR_CLEAR_CACHE") + controler.autoTr
                            width: parent.width
                            height: Constants.HEIGHT_BOTTOM_COMPONENT
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            font.family: lato.name
                            font.capitalization: Font.MixedCase
                            highlighted: activeFocus ? true : false
                            KeyNavigation.tab: dateSCAPCache
                            KeyNavigation.down: dateSCAPCache
                            KeyNavigation.right: dateSCAPCache
                            KeyNavigation.backtab: cacheAppSizeTextField
                            KeyNavigation.up: cacheAppSizeTextField
                        }
                    }
                }
            }
        }
        Item{
            id: rectSCAPCache
            width: parent.width
            height: 5*Constants.SIZE_TEXT_FIELD + 3*Constants.SIZE_ROW_V_SPACE
            anchors.leftMargin: Constants.SIZE_ROW_H_SPACE
            anchors.topMargin: 3*Constants.SIZE_ROW_V_SPACE
            anchors.top : rectAppCache.bottom

            Text {
                id: dateSCAPCache
                x: Constants.SIZE_TEXT_FIELD_H_SPACE
                font.pixelSize: activeFocus
                                ? Constants.SIZE_TEXT_LABEL_FOCUS
                                : Constants.SIZE_TEXT_LABEL
                font.family: lato.name
                font.bold: focus
                color: Constants.COLOR_TEXT_LABEL
                height: Constants.SIZE_TEXT_LABEL
                text: qsTranslate("PageDataApp","STR_SCAP_CACHE_TITLE") + controler.autoTr
                Accessible.role: Accessible.TitleBar
                Accessible.name: text
                KeyNavigation.tab: cacheSCAPTextField
                KeyNavigation.down: cacheSCAPTextField
                KeyNavigation.right: cacheSCAPTextField
                KeyNavigation.backtab: buttonRemoveAppCache
                KeyNavigation.up: buttonRemoveAppCache
            }
            DropShadow {
                anchors.fill: rowSCAPCache
                horizontalOffset: Constants.FORM_SHADOW_H_OFFSET
                verticalOffset: Constants.FORM_SHADOW_V_OFFSET
                radius: Constants.FORM_SHADOW_RADIUS
                samples: Constants.FORM_SHADOW_SAMPLES
                color: Constants.COLOR_FORM_SHADOW
                source: rowSCAPCache
                spread: Constants.FORM_SHADOW_SPREAD
                opacity: Constants.FORM_SHADOW_OPACITY_FORM_EFFECT
            }
            RectangularGlow {
                anchors.fill: rowSCAPCache
                glowRadius: Constants.FORM_GLOW_RADIUS
                spread: Constants.FORM_GLOW_SPREAD
                color: Constants.COLOR_FORM_GLOW
                cornerRadius: Constants.FORM_GLOW_CORNER_RADIUS
                opacity: Constants.FORM_GLOW_OPACITY_FORM_EFFECT
            }
            Rectangle {
                id: rowSCAPCache
                width: parent.width
                height: 4*Constants.SIZE_TEXT_FIELD + 3*Constants.SIZE_ROW_V_SPACE
                anchors.top: dateSCAPCache.bottom
                anchors.topMargin: Constants.SIZE_TEXT_V_SPACE
                Rectangle {
                    id: rectSCAPCacheDesc
                    height: 2*Constants.SIZE_TEXT_FIELD
                    width: parent.width - 2*Constants.SIZE_ROW_H_SPACE
                    anchors.top: rowSCAPCache.top
                    anchors.topMargin: Constants.SIZE_ROW_V_SPACE
                    anchors.left:rowSCAPCache.left
                    anchors.leftMargin: Constants.SIZE_ROW_H_SPACE 
                    Text {
                        id: cacheSCAPTextField
                        width: parent.width
                        height: parent.height
                        text: qsTranslate("PageDataApp","STR_SCAP_CACHE_TEXT")
                        font.capitalization: Font.MixedCase
                        font.pixelSize: Constants.SIZE_TEXT_FIELD
                        font.family: lato.name
                        font.bold: focus
                        wrapMode: Text.WordWrap
                        Accessible.role: Accessible.StaticText
                        Accessible.name: text
                        KeyNavigation.tab: cacheSCAPSizeTextField
                        KeyNavigation.down: cacheSCAPSizeTextField
                        KeyNavigation.right: cacheSCAPSizeTextField
                        KeyNavigation.backtab: dateSCAPCache
                        KeyNavigation.up: dateSCAPCache
                        
                    }
                }
                
                Rectangle {
                    id: rectSCAPCacheRemove
                    width: parent.width
                    height: 2*Constants.SIZE_TEXT_FIELD
                    anchors.top: rectSCAPCacheDesc.bottom
                    anchors.topMargin: Constants.SIZE_ROW_V_SPACE 
                
                    Rectangle {
                        id: rectSCAPCacheText
                        width: (parent.width - 3 * Constants.SIZE_ROW_H_SPACE) * 0.50
                        anchors.left: rectSCAPCacheRemove.left
                        anchors.leftMargin: Constants.SIZE_ROW_H_SPACE
                        Text {
                            id: cacheSCAPSizeTextField
                            text: qsTranslate("PageDataApp","STR_CLEAR_CACHE_NO_INFO") + controler.autoTr
                            width: parent.width
                            height: parent.height
                            font.capitalization: Font.MixedCase
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            font.family: lato.name
                            font.bold: focus
                            wrapMode: Text.WordWrap
                            topPadding: Constants.SIZE_ROW_V_SPACE
                            Accessible.role: Accessible.StaticText
                            Accessible.name: text
                            KeyNavigation.tab: buttonRemoveSCAPCache
                            KeyNavigation.down: buttonRemoveSCAPCache
                            KeyNavigation.right: buttonRemoveSCAPCache
                            KeyNavigation.backtab: cacheSCAPTextField
                            KeyNavigation.up: cacheSCAPTextField
                        }
                    }
                    Rectangle {
                        id: rectSCAPCacheButton
                        width: (parent.width - 3 * Constants.SIZE_ROW_H_SPACE) * 0.50
                        anchors.right: rectSCAPCacheRemove.right
                        anchors.rightMargin: Constants.SIZE_ROW_H_SPACE
                        Button {
                            id: buttonRemoveSCAPCache
                            text: qsTranslate("PageDefinitionsSCAP","STR_SCAP_ATTRIBUTES_BUTTON_REMOVE") + controler.autoTr
                            width: parent.width
                            height: Constants.HEIGHT_BOTTOM_COMPONENT
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            font.family: lato.name
                            font.capitalization: Font.MixedCase
                            highlighted: activeFocus ? true : false
                            KeyNavigation.tab: propertyMainItem
                            KeyNavigation.down: propertyMainItem
                            KeyNavigation.right: propertyMainItem
                            KeyNavigation.backtab: cacheSCAPSizeTextField
                            KeyNavigation.up: cacheSCAPSizeTextField
                        }
                    }
                }
            }
        }
    }
}

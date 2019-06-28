import QtQuick 2.6
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

/* Constants imports */
import "../../scripts/Constants.js" as Constants
import "../../components" as Components

Item {
    property alias propertyComboBoxReader: comboBoxReader
    property alias propertyRectReader: rectReader
    property alias propertyTextReader: textReader
    property alias propertyRectAppStart: rectAppStart
    property alias propertyRectAppStartCheckBox: rectAppStartCheckBox
    property alias propertyCheckboxAutoStart: checkboxAutoStart
    property alias propertyRectAppLanguage: rectAppLanguage
    property alias propertyRadioButtonPT: radioButtonPT
    property alias propertyRadioButtonUK: radioButtonUK
    property alias propertyRectAppLook: rectAppLook
    property alias propertyCheckboxShowAnime: checkboxShowAnime
    property alias propertyCheckBoxDebugMode: checkboxDebugMode
    property alias propertyGraphicsTextField: graphicsTextField
    property alias propertyCheckboxAccelGraphics: checkboxAccelGraphics
    property alias propertyRectAppNetworkCheckBox: rectAppNetworkCheckBox
    property alias propertyCheckboxSystemProxy: checkboxSystemProxy
    property alias propertyCheckboxProxy: checkboxProxy
    property alias propertyTextFieldAdress: textFieldAdress
    property alias propertyTextFieldPort: textFieldPort
    property alias propertyCheckboxAutProxy: checkboxAutProxy
    property alias propertyTextFieldAutUser: textFieldAutUser
    property alias propertyTextFieldAutPass: textFieldAutPass
    anchors.fill: parent

    Item {
        id: rowTop
        width: parent.width
        height: parent.height * Constants.HEIGHT_DEFINITIONS_APP_ROW_TOP_V_RELATIVE
                + (parent.height + Constants.TITLE_BAR_SIZE - Constants.SCREEN_MINIMUM_HEIGHT)
                * Constants.HEIGHT_DEFINITIONS_APP_ROW_TOP_INC_RELATIVE
    }

    Flickable {
        id: rowMain
        width: parent.width + Constants.SIZE_ROW_H_SPACE
        height: parent.height - 2*Constants.SIZE_ROW_V_SPACE
        anchors.top: rowTop.bottom
        anchors.right: parent.right
        anchors.topMargin: Constants.SIZE_ROW_V_SPACE
        clip:true
        contentHeight: content.childrenRect.height + 2*Constants.SIZE_ROW_V_SPACE

        ScrollBar.vertical: ScrollBar {
            id: settingsScroll
            parent: rowMain.parent
            visible: true
            active: rowMain.moving || !rowMain.moving // QtQuick.Controls 2.1 does not have AlwaysOn prop
            width: Constants.SIZE_TEXT_FIELD_H_SPACE
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
        /* This column was added because the rowMain component was cliping the left border of the rectangles.
           So we increased the width of the rowMain by SIZE_ROW_H_SPACE and filled the gap with the column. */
        Item { 
            id: column
            anchors.top: rowMain.top
            width: Constants.SIZE_ROW_H_SPACE
            height: rowMain.height
            anchors.left: rowMain.left
        }
        Item{
            id: content
            anchors.top: rowMain.top
            anchors.left: column.right
            width: rowMain.parent.width - Constants.SIZE_ROW_H_SPACE

            Item{
                id: rectReader
                width: parent.width
                height: textReader.height + rectReaderCombo.height + Constants.SIZE_TEXT_V_SPACE
                anchors.leftMargin: Constants.SIZE_ROW_H_SPACE

                Text {
                    id: textReader
                    x: Constants.SIZE_TEXT_FIELD_H_SPACE
                    font.pixelSize: Constants.SIZE_TEXT_LABEL
                    font.family: lato.name
                    font.bold: focus

                    color: Constants.COLOR_TEXT_LABEL
                    height: Constants.SIZE_TEXT_LABEL
                    text: qsTranslate("PageDefinitionsApp","STR_CARD_READER_TITLE") + controler.autoTr
                    Accessible.role: Accessible.TitleBar
                    Accessible.name: textReader.text
                    KeyNavigation.tab: comboBoxReader
                }

                DropShadow {
                    anchors.fill: rectReaderCombo
                    horizontalOffset: Constants.FORM_SHADOW_H_OFFSET
                    verticalOffset: Constants.FORM_SHADOW_V_OFFSET
                    radius: Constants.FORM_SHADOW_RADIUS
                    samples: Constants.FORM_SHADOW_SAMPLES
                    color: Constants.COLOR_FORM_SHADOW
                    source: rectReaderCombo
                    spread: Constants.FORM_SHADOW_SPREAD
                    opacity: Constants.FORM_SHADOW_OPACITY_FORM_EFFECT
                }
                RectangularGlow {
                    anchors.fill: rectReaderCombo
                    glowRadius: Constants.FORM_GLOW_RADIUS
                    spread: Constants.FORM_GLOW_SPREAD
                    color: Constants.COLOR_FORM_GLOW
                    cornerRadius: Constants.FORM_GLOW_CORNER_RADIUS
                    opacity: Constants.FORM_GLOW_OPACITY_FORM_EFFECT
                }
                Rectangle {
                    id: rectReaderCombo
                    width: parent.width
                    color: "white"
                    height: 3 * Constants.SIZE_TEXT_FIELD
                    anchors.top : textReader.bottom
                    anchors.topMargin: Constants.SIZE_TEXT_V_SPACE

                    ComboBox {
                        id: comboBoxReader
                        width: parent.width - 2 * Constants.SIZE_TEXT_V_SPACE
                        height: 3 * Constants.SIZE_TEXT_FIELD
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: lato.name
                        font.pixelSize: Constants.SIZE_TEXT_FIELD
                        font.capitalization: Font.MixedCase
                        visible: true
                        Accessible.role: Accessible.ComboBox
                        Accessible.name: textReader.text
                        KeyNavigation.tab: dateAppStart
                    }
                }
            }

            Item{
                id: rectAppStart
                width: parent.width
                height: dateAppStart.height + rectAppStartCheckBox.height + Constants.SIZE_TEXT_V_SPACE
                anchors.leftMargin: Constants.SIZE_ROW_H_SPACE
                anchors.top: rectReader.bottom
                anchors.topMargin: Constants.SIZE_ROW_V_SPACE_DEFINITIONS_APP
                Text {
                    id: dateAppStart
                    x: Constants.SIZE_TEXT_FIELD_H_SPACE
                    font.pixelSize: Constants.SIZE_TEXT_LABEL
                    font.family: lato.name
                    font.bold: focus
                    color: Constants.COLOR_TEXT_LABEL
                    height: Constants.SIZE_TEXT_LABEL
                    text: qsTranslate("PageDefinitionsApp","STR_START_TITLE") + controler.autoTr
                    Accessible.role: Accessible.TitleBar
                    Accessible.name: text
                    KeyNavigation.tab: checkboxAutoStart
                }
                DropShadow {
                    anchors.fill: rectAppStartCheckBox
                    horizontalOffset: Constants.FORM_SHADOW_H_OFFSET
                    verticalOffset: Constants.FORM_SHADOW_V_OFFSET
                    radius: Constants.FORM_SHADOW_RADIUS
                    samples: Constants.FORM_SHADOW_SAMPLES
                    color: Constants.COLOR_FORM_SHADOW
                    source: rectAppStartCheckBox
                    spread: Constants.FORM_SHADOW_SPREAD
                    opacity: Constants.FORM_SHADOW_OPACITY_FORM_EFFECT
                }
                RectangularGlow {
                    anchors.fill: rectAppStartCheckBox
                    glowRadius: Constants.FORM_GLOW_RADIUS
                    spread: Constants.FORM_GLOW_SPREAD
                    color: Constants.COLOR_FORM_GLOW
                    cornerRadius: Constants.FORM_GLOW_CORNER_RADIUS
                    opacity: Constants.FORM_GLOW_OPACITY_FORM_EFFECT
                }
                Rectangle {
                    id: rectAppStartCheckBox
                    width: parent.width
                    color: "white"
                    height: 25 + Constants.SIZE_TEXT_V_SPACE
                    anchors.top : dateAppStart.bottom
                    anchors.topMargin: Constants.SIZE_TEXT_V_SPACE

                    CheckBox {
                        id: checkboxAutoStart
                        text: qsTranslate("PageDefinitionsApp","STR_AUTO_START_OP") + controler.autoTr
                        height: 25
                        font.family: lato.name
                        font.pixelSize: Constants.SIZE_TEXT_FIELD
                        font.capitalization: Font.MixedCase
                        anchors.topMargin: Constants.SIZE_TEXT_V_SPACE
                        Accessible.role: Accessible.CheckBox
                        Accessible.name: text
                        KeyNavigation.tab: dateAppLanguage
                    }
                }
            }
            Item{
                id: rectAppLanguage
                width: parent.width
                height: dateAppLanguage.height + rectAppLanguageCheckBox.height + Constants.SIZE_TEXT_V_SPACE
                anchors.leftMargin: Constants.SIZE_ROW_H_SPACE
                anchors.top: rectAppStart.bottom
                anchors.topMargin: Constants.SIZE_ROW_V_SPACE_DEFINITIONS_APP

                Text {
                    id: dateAppLanguage
                    x: Constants.SIZE_TEXT_FIELD_H_SPACE
                    font.pixelSize: Constants.SIZE_TEXT_LABEL
                    font.family: lato.name
                    font.bold: focus
                    color: Constants.COLOR_TEXT_LABEL
                    height: Constants.SIZE_TEXT_LABEL
                    text: qsTranslate("PageDefinitionsApp","STR_LANGUAGE_TITLE") + controler.autoTr
                    Accessible.role: Accessible.TitleBar
                    Accessible.name: text
                    KeyNavigation.tab: radioButtonPT
                }

                DropShadow {
                    anchors.fill: rectAppLanguageCheckBox
                    horizontalOffset: Constants.FORM_SHADOW_H_OFFSET
                    verticalOffset: Constants.FORM_SHADOW_V_OFFSET
                    radius: Constants.FORM_SHADOW_RADIUS
                    samples: Constants.FORM_SHADOW_SAMPLES
                    color: Constants.COLOR_FORM_SHADOW
                    source: rectAppLanguageCheckBox
                    spread: Constants.FORM_SHADOW_SPREAD
                    opacity: Constants.FORM_SHADOW_OPACITY_FORM_EFFECT
                }
                RectangularGlow {
                    anchors.fill: rectAppLanguageCheckBox
                    glowRadius: Constants.FORM_GLOW_RADIUS
                    spread: Constants.FORM_GLOW_SPREAD
                    color: Constants.COLOR_FORM_GLOW
                    cornerRadius: Constants.FORM_GLOW_CORNER_RADIUS
                    opacity: Constants.FORM_GLOW_OPACITY_FORM_EFFECT
                }
                Rectangle {
                    id: rectAppLanguageCheckBox
                    width: parent.width
                    color: "white"
                    height: radioButtonPT.height
                    anchors.top: dateAppLanguage.bottom
                    anchors.topMargin: Constants.SIZE_TEXT_V_SPACE

                    Rectangle {
                        id: rectLeft
                        width: parent.width/2
                        height: parent.height
                        RadioButton {
                            id: radioButtonPT
                            height: Constants.HEIGHT_RADIO_BOTTOM_COMPONENT
                            text: qsTranslate("PageDefinitionsApp",
                                              "STR_PT_NAME_OP") + controler.autoTr
                            font.family: lato.name
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            font.capitalization: Font.MixedCase
                            Accessible.role: Accessible.RadioButton
                            Accessible.name: text
                            KeyNavigation.tab: radioButtonUK
                        }
                    }
                    Rectangle {
                        id: rectRight
                        width: parent.width/2
                        height: parent.height
                        anchors.left: rectLeft.right
                        RadioButton {
                            id: radioButtonUK
                            height: Constants.HEIGHT_RADIO_BOTTOM_COMPONENT
                            text: qsTranslate("PageDefinitionsApp",
                                              "STR_UK_NAME_OP") + controler.autoTr
                            font.family: lato.name
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            font.capitalization: Font.MixedCase
                            Accessible.role: Accessible.RadioButton
                            Accessible.name: text
                            KeyNavigation.tab: dateAppLook
                        }
                    }
                }
            }
            Item {
                id: rectAppLook
                width: parent.width
                height: dateAppLook.height + rectAppLookCheckBox.height + Constants.SIZE_TEXT_V_SPACE
                anchors.leftMargin: Constants.SIZE_ROW_H_SPACE
                anchors.top: rectAppLanguage.bottom
                anchors.topMargin: Constants.SIZE_ROW_V_SPACE_DEFINITIONS_APP

                Text {
                    id: dateAppLook
                    x: Constants.SIZE_TEXT_FIELD_H_SPACE
                    font.pixelSize: Constants.SIZE_TEXT_LABEL
                    font.family: lato.name
                    font.bold: focus
                    color: Constants.COLOR_TEXT_LABEL
                    height: Constants.SIZE_TEXT_LABEL
                    text: qsTranslate("PageDefinitionsApp",
                                      "STR_APP_LOOK_TITLE") + controler.autoTr
                    Accessible.role: Accessible.TitleBar
                    Accessible.name: text
                    KeyNavigation.tab: checkboxShowAnime
                }
                DropShadow {
                    anchors.fill: rectAppLookCheckBox
                    horizontalOffset: Constants.FORM_SHADOW_H_OFFSET
                    verticalOffset: Constants.FORM_SHADOW_V_OFFSET
                    radius: Constants.FORM_SHADOW_RADIUS
                    samples: Constants.FORM_SHADOW_SAMPLES
                    color: Constants.COLOR_FORM_SHADOW
                    source: rectAppLookCheckBox
                    spread: Constants.FORM_SHADOW_SPREAD
                    opacity: Constants.FORM_SHADOW_OPACITY_FORM_EFFECT
                }
                RectangularGlow {
                    anchors.fill: rectAppLookCheckBox
                    glowRadius: Constants.FORM_GLOW_RADIUS
                    spread: Constants.FORM_GLOW_SPREAD
                    color: Constants.COLOR_FORM_GLOW
                    cornerRadius: Constants.FORM_GLOW_CORNER_RADIUS
                    opacity: Constants.FORM_GLOW_OPACITY_FORM_EFFECT
                }
                Rectangle {
                    id: rectAppLookCheckBox
                    width: parent.width
                    color: "white"
                    height: 25 + Constants.SIZE_TEXT_V_SPACE
                    anchors.top: dateAppLook.bottom
                    anchors.topMargin: Constants.SIZE_TEXT_V_SPACE

                    CheckBox {
                        id: checkboxShowAnime
                        text: qsTranslate("PageDefinitionsApp",
                                          "STR_SHOW_ANIME_OP") + controler.autoTr
                        height: 25
                        font.family: lato.name
                        font.pixelSize: Constants.SIZE_TEXT_FIELD
                        font.capitalization: Font.MixedCase
                        anchors.topMargin: Constants.SIZE_TEXT_V_SPACE
                        Accessible.role: Accessible.CheckBox
                        Accessible.name: text
                        KeyNavigation.tab: dateDebugMode
                    }
                }
            }

            Item {
                id: rectDebugMode
                width: parent.width
                height: dateDebugMode.height + rectDebugModeCheckBox.height + 3 * Constants.SIZE_TEXT_V_SPACE
                anchors.leftMargin: Constants.SIZE_ROW_H_SPACE
                anchors.top: rectAppLook.bottom
                anchors.topMargin: Constants.SIZE_ROW_V_SPACE_DEFINITIONS_APP

                Text {
                    id: dateDebugMode
                    x: Constants.SIZE_TEXT_FIELD_H_SPACE
                    font.pixelSize: Constants.SIZE_TEXT_LABEL
                    font.family: lato.name
                    color: Constants.COLOR_TEXT_LABEL
                    height: Constants.SIZE_TEXT_LABEL
                    text: qsTranslate("PageDefinitionsApp", "STR_DEBUG_MODE_TITLE") + controler.autoTr
                    Accessible.role: Accessible.TitleBar
                    Accessible.name: text
                    KeyNavigation.tab: debugModeTextField
                }

                DropShadow {
                    anchors.fill: rectDebugModeCheckBox
                    horizontalOffset: Constants.FORM_SHADOW_H_OFFSET
                    verticalOffset: Constants.FORM_SHADOW_V_OFFSET
                    radius: Constants.FORM_SHADOW_RADIUS
                    samples: Constants.FORM_SHADOW_SAMPLES
                    color: Constants.COLOR_FORM_SHADOW
                    source: rectDebugModeCheckBox
                    spread: Constants.FORM_SHADOW_SPREAD
                    opacity: Constants.FORM_SHADOW_OPACITY_FORM_EFFECT
                }
                RectangularGlow {
                    anchors.fill: rectDebugModeCheckBox
                    glowRadius: Constants.FORM_GLOW_RADIUS
                    spread: Constants.FORM_GLOW_SPREAD
                    color: Constants.COLOR_FORM_GLOW
                    cornerRadius: Constants.FORM_GLOW_CORNER_RADIUS
                    opacity: Constants.FORM_GLOW_OPACITY_FORM_EFFECT
                }
                Rectangle {
                    id: rectDebugModeCheckBox
                    width: parent.width
                    color: "white"
                    height: debugModeTextField.height + checkboxDebugMode.height + 3*Constants.SIZE_TEXT_V_SPACE
                    anchors.top: dateDebugMode.bottom
                    anchors.topMargin: Constants.SIZE_TEXT_V_SPACE

                    Text {
                        id: debugModeTextField
                        width: parent.width - 20
                        x: 10
                        y: Constants.SIZE_TEXT_V_SPACE
                        font.capitalization: Font.MixedCase
                        font.pixelSize: Constants.SIZE_TEXT_FIELD
                        font.family: lato.name
                        font.bold: focus
                        wrapMode: Text.WordWrap
                        Accessible.role: Accessible.TitleBar
                        Accessible.name: text
                        KeyNavigation.tab: checkboxDebugMode
                        text: qsTranslate("PageDefinitionsApp", "STR_DEBUG_MODE_DESCRIPTION") + controler.autoTr
                    }

                    CheckBox {
                        id: checkboxDebugMode
                        enabled: false
                        text: qsTranslate("PageDefinitionsApp", "STR_DEBUG_MODE_ENABLE") + controler.autoTr
                        height: 25
                        font.family: lato.name
                        font.pixelSize: Constants.SIZE_TEXT_FIELD
                        font.capitalization: Font.MixedCase
                        anchors.top: debugModeTextField.bottom
                        anchors.topMargin: Constants.SIZE_TEXT_V_SPACE
                        Accessible.role: Accessible.CheckBox
                        Accessible.name: text
                        KeyNavigation.tab: dateAppGraphics
                    }
                }
            }

            Item {
                id: rectAppGraphics
                width: parent.width
                height: dateAppGraphics.height + rectAppGraphicsCheckBox.height
                        + 3 * Constants.SIZE_TEXT_V_SPACE
                anchors.leftMargin: Constants.SIZE_ROW_H_SPACE
                anchors.top: rectDebugMode.bottom
                anchors.topMargin: Constants.SIZE_ROW_V_SPACE_DEFINITIONS_APP

                Text {
                    id: dateAppGraphics
                    x: Constants.SIZE_TEXT_FIELD_H_SPACE
                    font.pixelSize: Constants.SIZE_TEXT_LABEL
                    font.family: lato.name
                    font.bold: focus
                    color: Constants.COLOR_TEXT_LABEL
                    height: Constants.SIZE_TEXT_LABEL
                    text: qsTranslate("PageDefinitionsApp",
                                      "STR_APP_GRAPHICS_TITLE") + controler.autoTr
                    Accessible.role: Accessible.TitleBar
                    Accessible.name: text
                    KeyNavigation.tab: graphicsTextField
                }
                DropShadow {
                    anchors.fill: rectAppGraphicsCheckBox
                    horizontalOffset: Constants.FORM_SHADOW_H_OFFSET
                    verticalOffset: Constants.FORM_SHADOW_V_OFFSET
                    radius: Constants.FORM_SHADOW_RADIUS
                    samples: Constants.FORM_SHADOW_SAMPLES
                    color: Constants.COLOR_FORM_SHADOW
                    source: rectAppLookCheckBox
                    spread: Constants.FORM_SHADOW_SPREAD
                    opacity: Constants.FORM_SHADOW_OPACITY_FORM_EFFECT
                }
                RectangularGlow {
                    anchors.fill: rectAppGraphicsCheckBox
                    glowRadius: Constants.FORM_GLOW_RADIUS
                    spread: Constants.FORM_GLOW_SPREAD
                    color: Constants.COLOR_FORM_GLOW
                    cornerRadius: Constants.FORM_GLOW_CORNER_RADIUS
                    opacity: Constants.FORM_GLOW_OPACITY_FORM_EFFECT
                }
                Rectangle {
                    id: rectAppGraphicsCheckBox
                    width: parent.width
                    color: "white"
                    height: graphicsTextField.height + checkboxAccelGraphics.height
                            + 3 * Constants.SIZE_TEXT_V_SPACE
                    anchors.top: dateAppGraphics.bottom
                    anchors.topMargin: Constants.SIZE_TEXT_V_SPACE

                    Text {
                        id: graphicsTextField
                        width: parent.width - 20
                        x: 10
                        y: Constants.SIZE_TEXT_V_SPACE
                        font.capitalization: Font.MixedCase
                        font.pixelSize: Constants.SIZE_TEXT_FIELD
                        font.family: lato.name
                        font.bold: focus
                        wrapMode: Text.WordWrap
                        Accessible.role: Accessible.TitleBar
                        Accessible.name: text
                        KeyNavigation.tab: checkboxAccelGraphics
                    }
                    CheckBox {
                        id: checkboxAccelGraphics
                        enabled: false
                        text: qsTranslate("PageDefinitionsApp",
                                          "STR_ACCEL_ENABLE")
                              + controler.autoTr
                        height: 25
                        font.family: lato.name
                        font.pixelSize: Constants.SIZE_TEXT_FIELD
                        font.capitalization: Font.MixedCase
                        anchors.top: graphicsTextField.bottom
                        anchors.topMargin: Constants.SIZE_TEXT_V_SPACE
                        Accessible.role: Accessible.CheckBox
                        Accessible.name: text
                        KeyNavigation.tab: dateAppNetwork
                    }
                }
            }

            Item {
                id: rectAppNetwork
                width: parent.width
                height: dateAppNetwork.height + rectAppNetworkCheckBox.height
                anchors.leftMargin: Constants.SIZE_ROW_H_SPACE
                anchors.topMargin: Constants.SIZE_ROW_V_SPACE_DEFINITIONS_APP
                anchors.top: rectAppGraphics.bottom

                Text {
                    id: dateAppNetwork
                    x: Constants.SIZE_TEXT_FIELD_H_SPACE
                    font.pixelSize: Constants.SIZE_TEXT_LABEL
                    font.family: lato.name
                    font.bold: focus
                    color: Constants.COLOR_TEXT_LABEL
                    height: Constants.SIZE_TEXT_LABEL
                    text: qsTranslate("PageDefinitionsApp",
                                      "STR_NETWORK_TITLE") + controler.autoTr
                    Accessible.role: Accessible.TitleBar
                    Accessible.name: text
                    KeyNavigation.tab: checkboxSystemProxy.visible ? checkboxSystemProxy : checkboxProxy
                }
                DropShadow {
                    anchors.fill: rectAppNetworkCheckBox
                    horizontalOffset: Constants.FORM_SHADOW_H_OFFSET
                    verticalOffset: Constants.FORM_SHADOW_V_OFFSET
                    radius: Constants.FORM_SHADOW_RADIUS
                    samples: Constants.FORM_SHADOW_SAMPLES
                    color: Constants.COLOR_FORM_SHADOW
                    source: rectAppNetworkCheckBox
                    spread: Constants.FORM_SHADOW_SPREAD
                    opacity: Constants.FORM_SHADOW_OPACITY_FORM_EFFECT
                }
                RectangularGlow {
                    anchors.fill: rectAppNetworkCheckBox
                    glowRadius: Constants.FORM_GLOW_RADIUS
                    spread: Constants.FORM_GLOW_SPREAD
                    color: Constants.COLOR_FORM_GLOW
                    cornerRadius: Constants.FORM_GLOW_CORNER_RADIUS
                    opacity: Constants.FORM_GLOW_OPACITY_FORM_EFFECT
                }
                Rectangle {
                    id: rectAppNetworkCheckBox
                    width: parent.width
                    color: "white"
                    anchors.topMargin: Constants.SIZE_TEXT_V_SPACE
                    height: checkboxProxy.height + checkboxSystemProxy.height
                            + boxAppAdress.height + Constants.SIZE_TEXT_V_SPACE
                    anchors.top: dateAppNetwork.bottom

                    CheckBox {
                        id: checkboxSystemProxy
                        text: qsTranslate(
                                  "PageDefinitionsApp",
                                  "STR_NETWORK_SYSTEM_PROXY_OP") + controler.autoTr
                        height: 25
                        font.family: lato.name
                        font.pixelSize: Constants.SIZE_TEXT_FIELD
                        font.capitalization: Font.MixedCase
                        anchors.topMargin: Constants.SIZE_TEXT_V_SPACE
                        checked: false
                        Accessible.role: Accessible.CheckBox
                        Accessible.name: text
                        KeyNavigation.tab: checkboxProxy
                    }

                    CheckBox {
                        id: checkboxProxy
                        text: qsTranslate("PageDefinitionsApp",
                                          "STR_NETWORK_PROXY_OP") + controler.autoTr
                        height: 25
                        font.family: lato.name
                        font.pixelSize: Constants.SIZE_TEXT_FIELD
                        font.capitalization: Font.MixedCase
                        anchors.top: checkboxSystemProxy.bottom
                        anchors.topMargin: Constants.SIZE_TEXT_V_SPACE
                        checked: false
                        Accessible.role: Accessible.CheckBox
                        Accessible.name: text
                        KeyNavigation.tab: checkboxProxy.checked ? textFieldAdress : checkboxAutProxy
                    }
                    Item {
                        id: boxAppAdress
                        width: 120
                        height: textFieldAdress.height
                        anchors.top: checkboxProxy.bottom
                        x: Constants.SIZE_TEXT_FIELD_H_SPACE

                        TextField {
                            id: textFieldAdress
                            width: parent.width
                            font.italic: textFieldAdress.text === "" ? true : false
                            placeholderText: qsTranslate(
                                                 "PageDefinitionsApp",
                                                 "STR_NETWORK_PROXY_ADDRESS_OP") + controler.autoTr
                            font.family: lato.name
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            enabled: checkboxProxy.checked
                            opacity: checkboxProxy.checked ? 1.0 : Constants.OPACITY_DEFINITIONS_APP_OPTION_DISABLED
                            validator: RegExpValidator {
                                //validates IPV4/IPV6 host
                                regExp: /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$|^(([a-zA-Z]|[a-zA-Z][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$|^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*/
                            }
                            Accessible.role: Accessible.EditableText
                            Accessible.name: text
                            KeyNavigation.tab: textFieldPort
                        }
                    }
                    Item {
                        id: boxAppPort
                        width: 37
                        height: textFieldPort.height
                        anchors.leftMargin: Constants.SIZE_TEXT_FIELD_H_SPACE
                        anchors.top: checkboxProxy.bottom
                        anchors.left: boxAppAdress.right
                        TextField {
                            id: textFieldPort
                            width: parent.width
                            font.italic: textFieldPort.text === "" ? true : false
                            placeholderText: qsTranslate(
                                                 "PageDefinitionsApp",
                                                 "STR_NETWORK_PROXY_PORT_OP") + controler.autoTr
                            validator: RegExpValidator {
                                regExp: /[0-9]+/
                            }
                            font.family: lato.name
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            clip: true
                            maximumLength: 5
                            enabled: checkboxProxy.checked
                            opacity: checkboxProxy.checked ? 1.0 : Constants.OPACITY_DEFINITIONS_APP_OPTION_DISABLED
                            Accessible.role: Accessible.EditableText
                            Accessible.name: text
                            KeyNavigation.tab: checkboxAutProxy
                        }
                    }
                    CheckBox {
                        id: checkboxAutProxy
                        x: parent.width * 0.40
                        text: qsTranslate("PageDefinitionsApp",
                                          "STR_NETWORK_AUTH_OP") + controler.autoTr
                        height: 25
                        font.family: lato.name
                        font.pixelSize: Constants.SIZE_TEXT_FIELD
                        font.capitalization: Font.MixedCase
                        anchors.top: checkboxSystemProxy.bottom
                        anchors.topMargin: Constants.SIZE_TEXT_V_SPACE
                        checked: false
                        Accessible.role: Accessible.CheckBox
                        Accessible.name: text
                        KeyNavigation.tab: checkboxAutProxy.checked? textFieldAutUser: textReader
                    }
                    Item {
                        id: boxAppAutUser
                        width: parent.width * 0.3 - 2 * Constants.SIZE_TEXT_FIELD_H_SPACE
                        height: textFieldAutUser.height
                        anchors.top: checkboxAutProxy.bottom
                        anchors.left: checkboxAutProxy.left
                        anchors.leftMargin: Constants.SIZE_TEXT_FIELD_H_SPACE
                        TextField {
                            id: textFieldAutUser
                            width: parent.width
                            font.italic: textFieldAutUser.text === "" ? true : false
                            placeholderText: qsTranslate(
                                                 "PageDefinitionsApp",
                                                 "STR_NETWORK_AUTH_USERNAME_OP") + controler.autoTr
                            font.family: lato.name
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            clip: false
                            enabled: checkboxAutProxy.checked
                            opacity: checkboxAutProxy.checked ? 1.0 : Constants.OPACITY_DEFINITIONS_APP_OPTION_DISABLED
                            Accessible.role: Accessible.EditableText
                            Accessible.name: text
                            KeyNavigation.tab: textFieldAutPass
                        }
                    }
                    Item {
                        id: boxAppAutPass
                        width: parent.width * 0.3 - 2 * Constants.SIZE_TEXT_FIELD_H_SPACE
                        height: textFieldAutPass.height
                        anchors.top: checkboxAutProxy.bottom
                        anchors.left: boxAppAutUser.right
                        anchors.leftMargin: Constants.SIZE_TEXT_FIELD_H_SPACE
                        TextField {
                            id: textFieldAutPass
                            width: parent.width
                            font.italic: textFieldAutPass.text === "" ? true : false
                            placeholderText: qsTranslate(
                                                 "PageDefinitionsApp",
                                                 "STR_NETWORK_AUTH_PASSWORD_OP") + controler.autoTr
                            echoMode: TextInput.Password
                            font.family: lato.name
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            clip: false
                            enabled: checkboxAutProxy.checked
                            opacity: checkboxAutProxy.checked ? 1.0 : Constants.OPACITY_DEFINITIONS_APP_OPTION_DISABLED
                            Accessible.role: Accessible.EditableText
                            Accessible.name: text
                            KeyNavigation.tab: textReader
                        }
                    }
                }
            }
        }
    }
}

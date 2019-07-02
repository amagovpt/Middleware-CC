import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

/* Constants imports */
import "../../scripts/Constants.js" as Constants
import "../../components" as Components

Item {
    id: mainWindow

    property alias protertyStackLayout: stackLayout

    property alias propertyButtonModifyAuth : buttonModifyAuth
    property alias propertyButtonTestAuth: buttonTestAuth
    property alias propertyTriesLeftAuthPin: triesLeftAuthPin

    property alias propertyButtonModifySign : buttonModifySign
    property alias propertyButtonTestSign: buttonTestSign
    property alias propertyTriesLeftSignPin: triesLeftSignPin

    property alias propertyButtonModifyAddress : buttonModifyAddress
    property alias propertyButtonTestAddress: buttonTestAddress
    property alias propertyTriesLeftAddressPin: triesLeftAddressPin

    property alias propertyBusyIndicator: busyIndicator

    property alias propertyTabAuth: tabButtonAuth
    property alias propertyTabSign: tabButtonSign
    property alias propertyTabAddr: tabButtonAddress
    
    property bool wasOnAuthTab: false
    property bool wasOnSignTab:false
    property bool wasOnAddrTab: false

    anchors.fill: parent
    Item {
        width: parent.width * 0.8
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter

        BusyIndicator {
            id: busyIndicator
            running: false
            anchors.centerIn: parent
            // BusyIndicator should be on top of all other content
            z: 1
        }
        Item {
            id: rowTop
            width: parent.width
            height: parent.height * Constants.HEIGHT_SECURITY_PIN_ROW_TOP_V_RELATIVE
                    + (parent.height + Constants.TITLE_BAR_SIZE - Constants.SCREEN_MINIMUM_HEIGHT)
                    * Constants.HEIGHT_SECURITY_PIN_ROW_TOP_INC_RELATIVE
        }

        TabBar {
            id: bar
            anchors.top: rowTop.bottom
            width: parent.width
            currentIndex: 0
            TabButton {
                id: tabButtonAuth
                text: qsTranslate("Popup PIN","STR_PIN_AUTH")
                rightPadding: 2
                leftPadding: 2
                Accessible.role: Accessible.MenuItem
                Accessible.name: text
                KeyNavigation.tab: tabButtonSign
                KeyNavigation.right: tabButtonSign
                KeyNavigation.left: tabButtonAddress
                Keys.onUpPressed: {}
                Keys.onDownPressed: {
                    stackLayout.currentIndex = 0
                    bar.currentIndex = 0
                    rowAuth.forceActiveFocus()
                }
                Keys.onReturnPressed: {
                    stackLayout.currentIndex = 0
                    bar.currentIndex = 0
                    rowAuth.forceActiveFocus()
                }
                Keys.onSpacePressed: {
                    stackLayout.currentIndex = 0
                    bar.currentIndex = 0
                    rowAuth.forceActiveFocus()
                }
            }
            TabButton {
                id: tabButtonSign
                text: qsTranslate("Popup PIN","STR_PIN_SIGN")
                rightPadding: 2
                leftPadding: 2
                Accessible.role: Accessible.MenuItem
                Accessible.name: text
                KeyNavigation.tab: tabButtonAddress
                KeyNavigation.right: tabButtonAddress
                KeyNavigation.left: tabButtonAuth
                Keys.onUpPressed: {}
                Keys.onDownPressed: {
                    stackLayout.currentIndex = 1
                    bar.currentIndex = 1
                    rowSign.forceActiveFocus()
                }
                Keys.onReturnPressed: {
                    stackLayout.currentIndex = 1
                    bar.currentIndex = 1
                    rowSign.forceActiveFocus()
                }
                Keys.onSpacePressed: {
                    stackLayout.currentIndex = 1
                    bar.currentIndex = 1
                    rowSign.forceActiveFocus()
                }
            }
            TabButton {
                id: tabButtonAddress
                text: qsTranslate("Popup PIN","STR_PIN_ADDRESS")
                rightPadding: 2
                leftPadding: 2
                Accessible.role: Accessible.MenuItem
                Accessible.name: text
                KeyNavigation.tab: tabButtonAuth
                KeyNavigation.right: tabButtonAuth
                KeyNavigation.left: tabButtonSign
                Keys.onUpPressed: {}
                Keys.onDownPressed: {
                    stackLayout.currentIndex = 2
                    bar.currentIndex = 2
                    rowAddress.forceActiveFocus()
                }
                Keys.onReturnPressed: {
                    stackLayout.currentIndex = 2
                    bar.currentIndex = 2
                    rowAddress.forceActiveFocus()
                }
                Keys.onSpacePressed: {
                    stackLayout.currentIndex = 2
                    bar.currentIndex = 2
                    rowAddress.forceActiveFocus()
                }
            }
            Accessible.role: Accessible.MenuBar
        }

        StackLayout {
            id: stackLayout
            width: parent.width
            height: parent.height - rowTop.height
            currentIndex: bar.currentIndex
            anchors.top: bar.bottom
            anchors.topMargin: 3 * Constants.SIZE_ROW_V_SPACE

            Item {
                id: tabAuthentication
                Item {
                    id: rowAuth
                    width: parent.width
                    height: Constants.SIZE_TEXT_LABEL
                            + Constants.SIZE_TEXT_V_SPACE
                            + 2 * Constants.SIZE_TEXT_FIELD
                    Text {
                        id: authText
                        anchors.topMargin: Constants.SIZE_TEXT_BODY
                        font.pixelSize: Constants.SIZE_TEXT_BODY
                        font.family: lato.name
                        text: qsTranslate("Popup PIN","STR_PIN_AUTH_TEXT")
                        wrapMode: Text.Wrap
                        width: parent.width
                        color: Constants.COLOR_MAIN_BLUE
                        Layout.fillWidth: true
                        font.bold: parent.focus ? true : false   
                    }
                    Accessible.role: Accessible.StaticText
                    Accessible.name: authText.text
                    KeyNavigation.tab: rowStateAuth
                    KeyNavigation.down: rowStateAuth
                    KeyNavigation.right: rowStateAuth
                    KeyNavigation.up: buttonModifyAuth
                }
                Item {
                    id: rowStateAuth
                    width: parent.width
                    height: Constants.SIZE_TEXT_LABEL
                            + Constants.SIZE_TEXT_V_SPACE
                            + 2 * Constants.SIZE_TEXT_FIELD
                    anchors.top: rowAuth.bottom
                    anchors.topMargin: Constants.SIZE_ROW_V_SPACE
                    Text {
                        id: triesLeftAuthPin
                        anchors.topMargin: Constants.SIZE_TEXT_BODY
                        font.pixelSize: Constants.SIZE_TEXT_BODY
                        font.family: lato.name
                        wrapMode: Text.Wrap
                        width: parent.width
                        color: Constants.COLOR_MAIN_BLUE
                        Layout.fillWidth: true
                        font.bold: parent.focus ? true : false
                        
                    }
                    Accessible.role: Accessible.StaticText
                    Accessible.name: triesLeftAuthPin.text
                    KeyNavigation.tab: buttonTestAuth
                    KeyNavigation.down: buttonTestAuth
                    KeyNavigation.right: buttonTestAuth
                    KeyNavigation.up: rowAuth
                    
                }
                Item {
                    id: rowButtonsAuth
                    width: bar.width
                    height: Constants.SIZE_V_BOTTOM_COMPONENT
                    anchors.top: rowStateAuth.bottom
                    anchors.topMargin: Constants.SIZE_ROW_V_SPACE
                    Item {
                        id: rectButtonsAuthleft
                        width: parent.width * 0.5
                        Button {
                            id: buttonTestAuth
                            width: Constants.WIDTH_BUTTON
                            height:Constants.HEIGHT_BOTTOM_COMPONENT
                            text: qsTranslate("Popup PIN","STR_PIN_TEST")
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            font.family: lato.name
                            font.capitalization: Font.MixedCase
                            highlighted: activeFocus ? true : false
                            enabled: false
                            Accessible.role: Accessible.Button
                            Accessible.name: text
                            KeyNavigation.tab: buttonModifyAuth
                            KeyNavigation.down: buttonModifyAuth
                            KeyNavigation.right: buttonModifyAuth
                            KeyNavigation.up: rowStateAuth
                        }
                    }
                    Item{
                        id: rectButtonsAuthRight
                        width: parent.width * 0.5
                        anchors.left: rectButtonsAuthleft.right
                        Button {
                            id: buttonModifyAuth
                            width: Constants.WIDTH_BUTTON
                            height:Constants.HEIGHT_BOTTOM_COMPONENT
                            text: qsTranslate("Popup PIN","STR_PIN_MODIFY")
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            font.family: lato.name
                            font.capitalization: Font.MixedCase
                            highlighted: activeFocus ? true : false
                            enabled: false
                            Accessible.role: Accessible.Button
                            Accessible.name: text
                            KeyNavigation.tab: rowAuth
                            KeyNavigation.down: rowAuth
                            KeyNavigation.right: rowAuth
                            KeyNavigation.up: buttonTestAuth
                        }
                    }
                }
            }
            Item {
                id: tabSign

                Item {
                    id: rowSign
                    width: parent.width
                    height: Constants.SIZE_TEXT_LABEL
                            + Constants.SIZE_TEXT_V_SPACE
                            + 2 * Constants.SIZE_TEXT_FIELD
                    Text {
                        id: signText
                        anchors.topMargin: Constants.SIZE_TEXT_BODY
                        font.pixelSize: Constants.SIZE_TEXT_BODY
                        font.family: lato.name
                        text: qsTranslate("Popup PIN","STR_PIN_SIGN_TEXT")
                        wrapMode: Text.Wrap
                        width: parent.width
                        color: Constants.COLOR_MAIN_BLUE
                        Layout.fillWidth: true
                        font.bold: parent.focus ? true : false
                    }
                    Accessible.role: Accessible.StaticText
                    Accessible.name: signText.text
                    KeyNavigation.tab: rowStateSign
                    KeyNavigation.down: rowStateSign
                    KeyNavigation.right: rowStateSign
                    KeyNavigation.up: buttonModifySign
                }

                Item {
                    id: rowStateSign
                    width: parent.width
                    height: Constants.SIZE_TEXT_LABEL
                            + Constants.SIZE_TEXT_V_SPACE
                            + 2 * Constants.SIZE_TEXT_FIELD
                    anchors.top: rowSign.bottom
                    anchors.topMargin: Constants.SIZE_ROW_V_SPACE
                    Text {
                        id: triesLeftSignPin
                        anchors.topMargin: Constants.SIZE_TEXT_BODY
                        font.pixelSize: Constants.SIZE_TEXT_BODY
                        font.family: lato.name
                        wrapMode: Text.Wrap
                        width: parent.width
                        color: Constants.COLOR_MAIN_BLUE
                        Layout.fillWidth: true
                        font.bold: parent.focus ? true : false
                    }
                    Accessible.role: Accessible.StaticText
                    Accessible.name: triesLeftSignPin.text
                    KeyNavigation.tab: buttonTestSign
                    KeyNavigation.down: buttonTestSign
                    KeyNavigation.right: buttonTestSign
                    KeyNavigation.up: rowSign
                }

                Item {
                    id: rowButtonsSign
                    width: bar.width
                    height: Constants.SIZE_V_BOTTOM_COMPONENT
                    anchors.top: rowStateSign.bottom
                    anchors.topMargin: Constants.SIZE_ROW_V_SPACE
                    Item {
                        id: rectButtonsSignleft
                        width: parent.width * 0.5
                        Button {
                            id: buttonTestSign
                            width: Constants.WIDTH_BUTTON
                            height:Constants.HEIGHT_BOTTOM_COMPONENT
                            text: qsTranslate("Popup PIN","STR_PIN_TEST")
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            font.family: lato.name
                            font.capitalization: Font.MixedCase
                            highlighted: activeFocus ? true : false
                            enabled: false
                            Accessible.role: Accessible.Button
                            Accessible.name: text
                            KeyNavigation.tab: buttonModifySign
                            KeyNavigation.down: buttonModifySign
                            KeyNavigation.right: buttonModifySign
                            KeyNavigation.up: rowStateSign
                        }
                    }
                    Item{
                        id: rectButtonsRight
                        width: parent.width * 0.5
                        anchors.left: rectButtonsSignleft.right
                        Button {
                            id: buttonModifySign
                            width: Constants.WIDTH_BUTTON
                            height:Constants.HEIGHT_BOTTOM_COMPONENT
                            text: qsTranslate("Popup PIN","STR_PIN_MODIFY")
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            font.family: lato.name
                            font.capitalization: Font.MixedCase
                            highlighted: activeFocus ? true : false
                            enabled: false
                            Accessible.role: Accessible.Button
                            Accessible.name: text
                            KeyNavigation.tab: rowSign
                            KeyNavigation.down: rowSign
                            KeyNavigation.right: rowSign
                            KeyNavigation.up: buttonTestSign
                        }
                    }
                }
            }
            Item {
                id: tabAddress

                Item {
                    id: rowAddress
                    width: parent.width
                    height: Constants.SIZE_TEXT_LABEL
                            + Constants.SIZE_TEXT_V_SPACE
                            + 2 * Constants.SIZE_TEXT_FIELD
                    Text {
                        id: addrText
                        anchors.topMargin: Constants.SIZE_TEXT_BODY
                        font.pixelSize: Constants.SIZE_TEXT_BODY
                        font.family: lato.name
                        text: qsTranslate("Popup PIN","STR_PIN_ADDRESS_TEXT")
                        wrapMode: Text.Wrap
                        width: parent.width
                        color: Constants.COLOR_MAIN_BLUE
                        Layout.fillWidth: true
                        font.bold: parent.focus ? true : false
                    }
                    Accessible.role: Accessible.StaticText
                    Accessible.name: addrText.text
                    KeyNavigation.tab: rowStateAddress
                    KeyNavigation.down: rowStateAddress
                    KeyNavigation.right: rowStateAddress
                    KeyNavigation.up: buttonModifyAddress
                }

                Item {
                    id: rowStateAddress
                    width: parent.width
                    height: Constants.SIZE_TEXT_LABEL
                            + Constants.SIZE_TEXT_V_SPACE
                            + 2 * Constants.SIZE_TEXT_FIELD
                    anchors.top: rowAddress.bottom
                    anchors.topMargin: Constants.SIZE_ROW_V_SPACE
                    Text {
                        id: triesLeftAddressPin
                        anchors.topMargin: Constants.SIZE_TEXT_BODY
                        font.pixelSize: Constants.SIZE_TEXT_BODY
                        font.family: lato.name
                        wrapMode: Text.Wrap
                        width: parent.width
                        color: Constants.COLOR_MAIN_BLUE
                        Layout.fillWidth: true
                        font.bold: parent.focus ? true : false
                    }
                    Accessible.role: Accessible.StaticText
                    Accessible.name: triesLeftAddressPin.text
                    KeyNavigation.tab: buttonTestAddress
                    KeyNavigation.down: buttonTestAddress
                    KeyNavigation.right: buttonTestAddress
                    KeyNavigation.up: rowAddress
                }
                Item {
                    id: rowButtonsAddress
                    width: bar.width
                    height: Constants.SIZE_V_BOTTOM_COMPONENT
                    anchors.top: rowStateAddress.bottom
                    anchors.topMargin: Constants.SIZE_ROW_V_SPACE
                    Item {
                        id: rectButtonsAddressleft
                        width: parent.width * 0.5
                        Button {
                            id: buttonTestAddress
                            width: Constants.WIDTH_BUTTON
                            height:Constants.HEIGHT_BOTTOM_COMPONENT
                            text: qsTranslate("Popup PIN","STR_PIN_TEST")
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            font.family: lato.name
                            font.capitalization: Font.MixedCase
                            highlighted: activeFocus ? true : false
                            enabled: false
                            Accessible.role: Accessible.Button
                            Accessible.name: text
                            KeyNavigation.tab: buttonModifyAddress
                            KeyNavigation.down: buttonModifyAddress
                            KeyNavigation.right: buttonModifyAddress
                            KeyNavigation.up: rowStateAddress
                        }
                    }
                    Item{
                        id: rectButtonsAddressRight
                        width: parent.width * 0.5
                        anchors.left: rectButtonsAddressleft.right
                        Button {
                            id: buttonModifyAddress
                            width: Constants.WIDTH_BUTTON
                            height:Constants.HEIGHT_BOTTOM_COMPONENT
                            text: qsTranslate("Popup PIN","STR_PIN_MODIFY")
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: Constants.SIZE_TEXT_FIELD
                            font.family: lato.name
                            font.capitalization: Font.MixedCase
                            highlighted: activeFocus ? true : false
                            enabled: false
                            Accessible.role: Accessible.Button
                            Accessible.name: text
                            KeyNavigation.tab: rowAddress
                            KeyNavigation.down: rowAddress
                            KeyNavigation.right: rowAddress
                            KeyNavigation.up: buttonTestAddress
                        }
                    }
                }
            }
        }
    }
}

import QtQuick 2.6
import QtQuick.Controls 2.1

import "../../scripts/Constants.js" as Constants
import "../../scripts/Functions.js" as Functions

//Import C++ defined enums
import eidguiV2 1.0

PageDefinitionsSignSettingsForm {

    Keys.onPressed: {
        console.log("PageDefinitionsSignSettingsForm onPressed:" + event.key)
        Functions.detectBackKeys(event.key, Constants.MenuState.SUB_MENU)
    }

    Connections {
        target: gapi
    }
    Connections {
        target: controler
    }

    propertyCheckboxRegister{
        onCheckedChanged: propertyCheckboxRegister.checked ? gapi.setRegCertValue(true) :
                                                             gapi.setRegCertValue(false)
    }
    propertyCheckboxRemove{
        onCheckedChanged: propertyCheckboxRemove.checked ? gapi.setRemoveCertValue(true) :
                                                           gapi.setRemoveCertValue(false)
    }
    propertyCheckboxDisable{
        onCheckedChanged: controler.setOutlookSuppressNameChecks(propertyCheckboxDisable.checked);
    }
    Connections {
        target: propertyTextFieldTimeStamp
        onEditingFinished: {
            console.log("Editing TimeStamp finished host: " + propertyTextFieldTimeStamp.text);
            controler.setTimeStampHostValue(propertyTextFieldTimeStamp.text)
        }
    }
    propertyCheckboxTimeStamp{
        onCheckedChanged: if (!propertyCheckboxTimeStamp.checked ){
                              controler.setTimeStampHostValue("http://ts.cartaodecidadao.pt/tsa/server")
                              propertyTextFieldTimeStamp.text = ""
                          }
    }   

    Component.onCompleted: {
        console.log("Page definitionsSignSettings onCompleted")

        if (Qt.platform.os === "windows") {
            propertyCheckboxRegister.checked = gapi.getRegCertValue()
            propertyCheckboxRemove.checked = gapi.getRemoveCertValue()
        }else{
            propertyRectAppCertificates.visible = false
            propertyRectAppTimeStamp.anchors.top = propertyRectAppCertificates.top
        }

        if (controler.getTimeStampHostValue().length > 0
                && controler.getTimeStampHostValue() !== "http://ts.cartaodecidadao.pt/tsa/server"){
            propertyCheckboxTimeStamp.checked = true
            propertyTextFieldTimeStamp.text = controler.getTimeStampHostValue()
        }else{
            propertyCheckboxTimeStamp.checked = false
        }

        if (Qt.platform.os === "windows") {
            propertyCheckboxDisable.enabled = controler.isOutlookInstalled()
            if (propertyCheckboxDisable.enabled)
                propertyCheckboxDisable.checked = controler.getOutlookSuppressNameChecks()
        } else {
            propertyRectOffice.visible = false
        }
        
        if(propertyRectAppCertificates.visible){
            propertyDateAppCertificates.forceActiveFocus()
        }else{
            propertyDateAppTimeStamp.forceActiveFocus()
        }

        console.log("Page definitionsSignSettings onCompleted finished")
    }
}

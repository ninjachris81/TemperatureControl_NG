import QtQuick 2.0

import "qrc:/qml/components/acx"

MessagePopupBase {
    id: root

    buttonCount: 2

    theme: themeInfo

    label1.text: qsTr("No")
    label2.text: qsTr("Yes")

    onHandleChoice: {
        if (choiceIndex===1) postResult(ACXPopupManager.resultCancel)
        if (choiceIndex===2) postResult(ACXPopupManager.resultOK)
    }

}

import QtQuick 2.0

import "qrc:/qml/components/acx"

MessagePopupBase {
    id: root

    title: "ABORT"

    buttonCount: 2

    theme: themeWarning

    label1.text: qsTr("No")
    label2.text: qsTr("Abort")

    onHandleChoice: {
        if (choiceIndex===1) root.postResult(ACXPopupManager.resultCancel);
        if (choiceIndex===2) root.postResult(ACXPopupManager.resultOK);
    }

}

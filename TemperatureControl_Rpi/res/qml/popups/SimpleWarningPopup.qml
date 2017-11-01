import QtQuick 2.0

import "qrc:/qml/components/acx"

MessagePopupBase {
    id: root

    title: "Warning"

    buttonCount: 1

    theme: themeWarning

    label1.text: qsTr("OK")

    onHandleChoice: {
        root.postResult(ACXPopupManager.resultOK)
    }
}

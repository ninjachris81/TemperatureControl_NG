import QtQuick 2.0

import "qrc:/qml/components/acx"

MessagePopupBase {
    id: root

    title: "Info"

    buttonCount: 1

    theme: themeInfo

    label1.text: qsTr("OK")

    onHandleChoice: {
        root.postResult(ACXPopupManager.resultOK)
    }
}

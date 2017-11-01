import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import "qrc:/qml/Paths.js" as Paths

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/label"

MessagePopupBase {
    id: root

    property var valueFunc
    property bool indeterminate: false
    property bool autoClose: false

    buttonCount: 1
    theme: themeInfo
    label1.text: qsTr("Abort")

    onHandleChoice: {
        if (choiceIndex===1) postResult(ACXPopupManager.resultCancel)
    }

    ACXProgressBar {
        id: progressBar
        anchors.centerIn: parent

        width: 500
        height: 30

        indeterminate: root.indeterminate

        from: 0
        to: 100

        value: typeof(valueFunc)==="function" ? valueFunc() : 0

        onValueChanged: {
            if (root.autoClose && value>=100) {
                postResult(ACXPopupManager.resultOK)
            }
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 500

        onTriggered: {
            if (typeof(valueFunc)==="function") progressBar.value = valueFunc()
        }
    }
}

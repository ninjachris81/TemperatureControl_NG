import QtQuick 2.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/speller"

Item {
    id: root

    signal postResult(int result)

    property alias prompt: textInput.previewText
    property alias text: textInput.text
    property alias title: textInput.text
    property alias maximumLength: textInput.maximumLength
    property alias inputMethodHints: textInput.inputMethodHints

    ACXTextInput {
        id: textInput

        anchors.left: parent.left
        anchors.right: parent.right

        onAccepted: {
            postResult(ACXPopupManager.resultOK)
        }

        onCanceledInput: {
            postResult(ACXPopupManager.resultCancel)
        }
    }

    Timer {
        running: true
        repeat: false
        interval: 100

        onTriggered: {
            textInput.forceActiveFocus()
        }
    }
}

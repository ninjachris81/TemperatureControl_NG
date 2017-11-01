import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.VirtualKeyboard 2.2

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/speller"

ACXTextInput {
    id: root

    //anchors.fill: parent

    inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhHiddenText

    maximumLength: expectedPin.length

    property string expectedPin: ""
    property var resultFunc

    signal postResult(int result)

    onAccepted: {
        //console.log("Expected: " + expectedPin);
        //console.log("Actual: " + text)

        ACXSpellerContainer.showTextLabels = false

        if (expectedPin===text) {
            postResult(ACXPopupManager.resultOK);
        } else {
            postResult(ACXPopupManager.resultWrong);
        }
    }

    onCanceledInput: {
        ACXSpellerContainer.showTextLabels = false
        postResult(ACXPopupManager.resultCancel);
    }

    Component.onCompleted: {
        ACXSpellerContainer.currentItem = root
        updateInputTimer.start()
    }

    Timer {
        id: updateInputTimer

        repeat: false
        interval: 100
        onTriggered: {
            root.focus = true
            root.forceActiveFocus();
            Qt.inputMethod.show();
            ACXSpellerContainer.showTextLabels = (inputMethodHints & Qt.ImhDigitsOnly)
        }

    }
}

pragma Singleton
import QtQuick 2.0

Item {
    id: root

    signal cancelInput

    readonly property int spellerTypeGeneral: 0

    property var currentItem
    property int currentSpellerType: spellerTypeGeneral
    property string initialText
    property string currentText: currentItem ? currentItem.text : ""
    property string previewText: currentItem ? currentItem.previewText : ""
    readonly property bool containsDot: currentText.indexOf('.')!==-1

    property bool showTextLabels: false

    function clearCurrentText() {
        if (currentItem) {
            currentItem.text = "";
        }
    }

    onCurrentItemChanged: {
        if (!currentItem) return;

        console.log("Current Item:" + currentItem)
        initialText = currentItem.text

        showTextLabels = false
    }

    onCancelInput: {
        if (!currentItem) return;

        console.log("Cancel input");
        currentItem.text = initialText
        currentItem.canceledInput();
        currentItem.focus = false

        showTextLabels = false
    }

    Connections {
        target: Qt.inputMethod

        onVisibleChanged: {
            console.log("IM: " + Qt.inputMethod.visible)
            if (Qt.inputMethod.visible && currentItem) {
                initialText = currentItem.text
            }
            //if (!Qt.inputMethod.visible) currentItem = null;
        }
    }
}

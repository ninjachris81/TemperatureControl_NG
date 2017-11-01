import QtQuick 2.8
import QtQuick.VirtualKeyboard 2.2
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/speller"
import "qrc:/qml/components/acx/label"

import "qrc:/qml/DefaultStyle.js" as DefaultStyle

TextInput {
    id: root

    property alias backgroundColor: backgroundRect.color

    text: ""
    property string previewText
    property bool showAsEnabled: false

    signal canceledInput

    verticalAlignment: TextInput.AlignVCenter

    font.family: DefaultStyle.fontFamily
    font.pointSize: DefaultStyle.fontSize
    color: DefaultStyle.fontColor

    padding: 5

    onFocusChanged: {
        if (focus) {
            ACXSpellerContainer.currentItem = root
        } else {
            ACXSpellerContainer.currentItem = null
        }

        console.log("Focus Changed to " + ACXSpellerContainer.currentItem)
    }

    onAccepted: {
        console.log("ACCEPTED")
        focus = false
    }

    ACXLabel {
        id: textLabel
        anchors.verticalCenter: parent.verticalCenter

        leftPadding: 5

        visible: root.text===""

        color: DefaultStyle.fontColor
        opacity: root.enabled || showAsEnabled ? 0.7 : 0.4
    }

    Rectangle {
        id: backgroundRect
        color: "white"

        anchors.fill: parent
        z: root.z - 1

        radius: 3

        layer.enabled: root.enabled || showAsEnabled
        layer.effect: DropShadow  {
            spread: 0
            fast: true
            color: DefaultStyle.fontColor
        }
    }

    Component.onCompleted: {
        textLabel.text = Qt.binding(function() { return root.text===""?previewText:root.text});
    }
}

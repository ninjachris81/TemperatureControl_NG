import QtQuick 2.8
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"

import "qrc:/qml/Paths.js" as Paths

Item {
    id: root

    property bool enabled: true

    signal triggered
    signal triggeredDisabled

    property bool isForward: false
    property bool isAbort: false
    property bool isFinish: false
    property bool isStart: false

    width: background.paintedWidth
    height: background.paintedHeight

    Image {
        id: background
        source: Paths.image("common/buttons/back_button/back_button_bg" + (backButtonMA.pressed ? "_pressed" : "") + ".png")

        MouseArea {
            id: backButtonMA
            anchors.fill: parent
            anchors.topMargin: -6          // make it a bit larger

            onClicked: {
                if (root.enabled) {
                    root.triggered()
                } else {
                    root.triggeredDisabled()
                }
            }
        }

        mirror: root.isForward

        opacity: root.enabled ? 1 : 0.5
    }

    Image {
        anchors.centerIn: parent
        source: Paths.image("common/buttons/back_button/" + (isAbort ? "back_button_abort.png" : isFinish ? "back_button_checkmark.png" : isStart ? "back_button_play.png" : "back_button_arrow.png"))

        mirror: root.isForward && !root.isFinish && !root.isStart

        opacity: root.enabled ? 1 : 0.5

        layer.enabled: true
        layer.effect: ColorOverlay {
            color: "#52aa47"
        }
    }
}

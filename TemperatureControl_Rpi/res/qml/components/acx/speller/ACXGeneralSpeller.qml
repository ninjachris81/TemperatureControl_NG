import QtQuick 2.0
import QtQuick.VirtualKeyboard 2.2
import QtQuick.VirtualKeyboard.Settings 2.2

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/label"

import "qrc:/qml/Paths.js" as Paths

ACXSpellerBase {
    id: root

    readonly property string resourcePrefix: "qrc:/QtQuick/VirtualKeyboard/content/styles/acx/"

    Timer {
        id: selectAllTimer
        interval: 400       // must be after animation
        running: false
        repeat: false
        onTriggered: {
            console.log("Select all")
            if (ACXSpellerContainer.currentItem && Qt.inputMethod.visible) ACXSpellerContainer.currentItem.selectAll();
        }
    }

    InputPanel {
        id: inputPanel
        //y: Qt.inputMethod.visible ? parent.height - inputPanel.height : parent.height
        y: parent.height// - inputPanel.height
        anchors.left: parent.left
        anchors.right: parent.right

        onVisibleChanged: {
            if (visible) {
                console.log("Input Panel visible")
                selectAllTimer.start()
            } else {
                if (ACXSpellerContainer.currentItem) ACXSpellerContainer.currentItem.deselect();
            }
        }

        states: State {
            name: "visible"
            when: root.visible
            PropertyChanges {
                target: inputPanel
                y: parent.height - inputPanel.height
            }
        }

        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 300
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    ACXButton {
        id: backspaceKeyIcon
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

        height: 60
        width: 94

        isFlat: true

        iconSource: resourcePrefix + "images/delete_char.svg"
        icon.sourceSize.width: 50
        icon.sourceSize.height: 80
        icon.anchors.centerIn: backspaceKeyIcon
        iconColor: "white"

        onTriggered: {
            InputContext.sendKeyClick(Qt.Key_Backspace, "")
        }

        onTriggeredLong: {
            ACXSpellerContainer.clearCurrentText()
        }
    }

    ACXNavButton {
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        onTriggered: {
            ACXSpellerContainer.cancelInput()
        }
    }

    ACXLabel {
        visible: ACXSpellerContainer.currentText==="" && ACXSpellerContainer.previewText!==""

        text: ACXSpellerContainer.previewText
        anchors.top: parent.top
        anchors.topMargin: -2
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: backspaceKeyIcon.left

        verticalAlignment: Text.AlignVCenter

        font.pointSize: 22

        opacity: 0.4

        height: 80
    }

    Component.onCompleted: {
        VirtualKeyboardSettings.styleName = "acx"
        VirtualKeyboardSettings.fullScreenMode = true;
    }

}

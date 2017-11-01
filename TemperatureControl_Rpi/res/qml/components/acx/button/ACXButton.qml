import QtQuick 2.0
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/label"

import "qrc:/qml/Paths.js" as Paths
import "qrc:/qml/DefaultStyle.js" as DefaultStyle

Item {
    id: root

    property bool enabled: true

    property alias label: textLabel
    property int labelMargin: 0
    property alias fontSize: textLabel.font.pointSize

    property alias icon: iconImg
    property alias iconSource: iconImg.source
    property color iconColor: DefaultStyle.fontColor
    property int iconMargin: 0

    property alias pressed: mouseArea.pressed

    property bool autoRepeat: false
    property int autoRepeatInterval: 200

    property bool showArrow: false

    property bool isVertical: false

    property bool isFlat: false

    signal triggered
    signal triggeredLong
    signal triggeredDisabled

    property int stepSize: 1
    property int stepCount: 0

    BorderImage {
        id: buttonImg
        anchors.fill: parent
        source: Paths.image("common/buttons/roundbutton" + (mouseArea.pressed && root.enabled ? "_pressed" : "") + ".png")
        border.left: 3; border.top: 3
        border.right: 3; border.bottom: 3

        visible: !isFlat
    }

    Rectangle {
        radius: 5
        color: "#11100e"
        anchors.fill: parent

        visible: isFlat

        opacity: mouseArea.pressed ? 0.75 : 1
    }

    Image {
        id: iconImg

        anchors.fill: parent

        verticalAlignment: isVertical ? Image.AlignTop : Image.AlignVCenter
        horizontalAlignment: textLabel.text && !isVertical ? Image.AlignLeft : Image.AlignHCenter

        anchors.leftMargin: horizontalAlignment===Image.AlignLeft ? root.iconMargin : 0
        anchors.topMargin: isVertical ? root.iconMargin : 0

        fillMode: Image.Pad

        opacity: root.enabled ? 1 : 0.2

        layer.enabled: iconColor
        layer.effect: ColorOverlay {
            color: mouseArea.pressed && root.enabled ? "white" : root.iconColor
        }
    }

    Timer {
        id: autoRepeatTimer
        running: false
        repeat: true
        interval: root.autoRepeatInterval

        onRunningChanged: {
            console.log("RUNING: " + running)
        }

        onTriggered: {
            stepCount++;

            if (stepCount>5 && stepCount<10) {
                stepSize=5
            } else if (stepCount>20) {
                stepCount = 10
            }

            root.triggered()
        }
    }

    Image {
        visible: root.showArrow
        source: Paths.image("common/icons/list_arrow.png")

        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter

        opacity: root.enabled ? 1 : 0.2

        layer.enabled: true
        layer.effect: ColorOverlay {
            color: "grey"
        }
    }

    ACXLabel {
        id: textLabel
        visible: text.length>0

        opacity: root.enabled ? 1 : 0.2

        anchors.verticalCenter: !isVertical ? parent.verticalCenter : undefined
        anchors.bottom: isVertical ? parent.bottom : undefined
        anchors.verticalCenterOffset: isVertical ? 0 : -2

        horizontalAlignment: iconImg.status!==Image.Null && !isVertical ? Text.AlignRight : Text.AlignHCenter
        verticalAlignment: isVertical ? Text.AlignBottom : Text.AlignVCenter

        anchors.leftMargin: horizontalAlignment===Text.AlignLeft ? root.labelMargin : 0
        anchors.rightMargin: horizontalAlignment===Text.AlignRight ? root.labelMargin : 0
        anchors.bottomMargin: isVertical ? root.labelMargin : 0

        anchors.left: parent.left
        anchors.right: parent.right

        color: mouseArea.pressed && root.enabled ? "white" : "grey"
   }


    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {
            console.log("clicked " + root.label.text)
            if (root.enabled) {
                root.triggered();
            } else {
                root.triggeredDisabled();
            }
        }

        function abortAutoRepeat() {
            autoRepeatTimer.stop()
            autoRepeatTimer.interval = root.autoRepeatInterval
            stepSize = 1
            stepCount = 0
        }

        onPressAndHold: {
            if (root.autoRepeat) autoRepeatTimer.restart()
            root.triggeredLong()
        }

        onPressedChanged: {
            if (!pressed) abortAutoRepeat()
        }
    }
}

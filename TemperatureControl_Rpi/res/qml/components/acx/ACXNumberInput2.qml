import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/label"
import "qrc:/qml/components/acx/speller"

import "qrc:/qml/DefaultStyle.js" as DefaultStyle

Item {
    id: root

    property alias padZero: valueBox.padZero

    property alias value: valueBox.value
    property alias label: unitLabel.text

    property alias from: valueBox.from
    property alias to: valueBox.to

    Column {
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        spacing: 10

        ACXButton {
            id: increaseButton

            width: parent.width
            height: 80

            label.text: "+"
            label.font.pointSize: 30
            label.color: DefaultStyle.fontColor

            autoRepeat: true

            onTriggered: {
                valueBox.stepSize = stepSize;
                valueBox.increase()
            }
        }

        SpinBox {
            id: valueBox

            width: parent.width

            leftMargin: 10
            rightMargin: 10

            height: 60

            //verticalAlignment: Text.AlignVCenter
            //horizontalAlignment: Text.AlignHCenter

            font.family: DefaultStyle.fontFamily
            font.pointSize: DefaultStyle.fontSize

            showIndicators: false

            editable: false

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    mouse.accepted = true       // block mouse events
                }
            }
        }

        ACXButton {
            id: decreaseButton

            width: parent.width
            height: 80

            label.text: "-"
            label.font.pointSize: 30
            label.color: DefaultStyle.fontColor

            autoRepeat: true

            onTriggered: {
                valueBox.stepSize = stepSize;
                valueBox.decrease()
            }
        }

        ACXLabel {
            id: unitLabel
            width: parent.width
            height: 30

            horizontalAlignment: Text.AlignHCenter

            text: "day"
        }

    }
}

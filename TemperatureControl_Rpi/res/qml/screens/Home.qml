import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/label"

import "qrc:/qml/Paths.js" as Paths
import "qrc:/qml/components/acx/ACXStackViewParams.js" as ACXStackViewParams

ACXScreenBase {
    id: root

    //ACXItemTracer {}

    GridLayout {
        anchors.fill: parent
        anchors.margins: 20

        columns: 2
        columnSpacing: 60

        ACX2CompLabel {
            Layout.preferredWidth: parent.width/2
            Layout.preferredHeight: 50

            leftPart: qsTr("Free RAM")
            rightPart: DeviceState.freeRam
        }

        ACX2CompLabel {
            Layout.fillWidth: true
            Layout.preferredHeight: 50

            leftPart: qsTr("Temp HC")
            rightPart: DeviceState.tempHC.toFixed(2)
        }

        ACX2CompLabel {
            Layout.preferredWidth: parent.width/2
            Layout.preferredHeight: 50

            leftPart: qsTr("Device Time")
            rightPart: Qt.formatDateTime(new Date(DeviceState.timestamp * 1000))
        }

        ACX2CompLabel {
            Layout.fillWidth: true
            Layout.preferredHeight: 50

            leftPart: qsTr("Temp Water")
            rightPart: DeviceState.tempWater.toFixed(2)
        }


        ACX2CompLabel {
            Layout.preferredWidth: parent.width/2
            Layout.preferredHeight: 50

            leftPart: qsTr("Uptime")
            rightPart: (DeviceState.uptime / 1000).toFixed(0) + " sec"
        }

        ACX2CompLabel {
            Layout.fillWidth: true
            Layout.preferredHeight: 50

            leftPart: qsTr("Temp Tank")
            rightPart: DeviceState.tempTank.toFixed(2)
        }

        Item {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }



}

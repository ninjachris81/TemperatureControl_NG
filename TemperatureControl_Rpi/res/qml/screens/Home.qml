import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import de.tempcontrol 1.0

import "qrc:/qml/."
import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/label"

import "qrc:/qml/Paths.js" as Paths
import "qrc:/qml/components/acx/ACXStackViewParams.js" as ACXStackViewParams

ACXScreenBase {
    id: root

    //ACXItemTracer {}

    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: -60

        visible: SerialComm.isConnected
        source: Paths.image("common/icons/exchange.png")
    }

    GridLayout {
        anchors.fill: parent
        anchors.margins: 20

        columns: 2

        ACX2CompLabel {
            Layout.preferredWidth: parent.width/2
            Layout.preferredHeight: 50

            leftPart: qsTr("Free RAM")
            rightPart: DeviceState.freeRam
        }

        Item {
            Layout.minimumWidth: 10
            Layout.fillWidth: true
            Layout.preferredHeight: 10
        }

        ACX2CompLabel {
            Layout.preferredWidth: parent.width/2
            Layout.preferredHeight: 50

            leftPart: qsTr("Device Time")
            rightPart: Qt.formatDateTime(new Date(DeviceState.timestamp * 1000))
        }

        Item {
            Layout.minimumWidth: 10
            Layout.fillWidth: true
            Layout.preferredHeight: 10
        }

        ACX2CompLabel {
            Layout.preferredWidth: parent.width/2
            Layout.preferredHeight: 50

            leftPart: qsTr("Uptime")
            rightPart: DeviceState.uptime / 1000 + " sec"
        }

        Item {
            Layout.minimumWidth: 10
            Layout.fillWidth: true
            Layout.preferredHeight: 10
        }

        Item {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }



}

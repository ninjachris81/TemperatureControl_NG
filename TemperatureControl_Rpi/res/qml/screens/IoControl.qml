import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import de.tempcontrol 1.0

import "."
import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/label"

import "qrc:/qml/Paths.js" as Paths
import "qrc:/qml/components/acx/ACXStackViewParams.js" as ACXStackViewParams

ACXScreenBase {
    id: root

    nextScreen: ScreenNames.SCREEN_INVALID

    GridLayout {
        anchors.fill: parent
        anchors.leftMargin: menuLeftMargin - 10
        anchors.rightMargin: 40
        anchors.topMargin: 30

        columns: 3

        ACXLabel {
            Layout.preferredWidth: parent.width/3
            Layout.fillWidth: true
            Layout.preferredHeight: 60

            text: qsTr("Solar Pump")

            verticalAlignment: Text.AlignVCenter
        }

        ACXToggleButton {
            Layout.preferredWidth: parent.width/3
            Layout.preferredHeight: 60

            enabled: false

            model: [
                qsTr("Off"),
                qsTr("On")
            ]
            currentIndex: DeviceState.solarPump
        }

        ACXButton {
            Layout.minimumWidth: 200
            Layout.preferredHeight: 60

            label.text: qsTr("Toggle")

            enabled: SerialComm.isConnected

            onTriggered:  {
                DeviceState.toggleAndSendIOState(DeviceState.IOD_SOLAR_PUMP)
            }
        }

        ACXLabel {
            Layout.preferredWidth: parent.width/3
            Layout.preferredHeight: 60

            text: qsTr("Radiator Pump")

            verticalAlignment: Text.AlignVCenter
        }

        ACXToggleButton {
            Layout.preferredWidth: parent.width/3
            Layout.preferredHeight: 60

            enabled: false

            model: [
                qsTr("Off"),
                qsTr("On")
            ]
            currentIndex: DeviceState.radiatorPump
        }

        ACXButton {
            Layout.minimumWidth: 200
            Layout.preferredHeight: 60

            label.text: qsTr("Toggle")

            enabled: SerialComm.isConnected

            onTriggered:  {
                DeviceState.toggleAndSendIOState(DeviceState.IOD_RADIATOR_PUMP)
            }
        }

        ACXLabel {
            Layout.preferredWidth: parent.width/3
            Layout.preferredHeight: 60

            text: qsTr("Gas Burner")

            verticalAlignment: Text.AlignVCenter
        }

        ACXToggleButton {
            Layout.preferredWidth: parent.width/3
            Layout.preferredHeight: 60

            enabled: false

            model: [
                qsTr("Off"),
                qsTr("On")
            ]
            currentIndex: DeviceState.gasBurner
        }

        ACXButton {
            Layout.minimumWidth: 200
            Layout.preferredHeight: 60

            label.text: qsTr("Toggle")

            enabled: SerialComm.isConnected

            onTriggered:  {
                DeviceState.toggleAndSendIOState(DeviceState.IOD_GAS_BURNER)
            }
        }

        ACXLabel {
            Layout.preferredWidth: parent.width/3
            Layout.preferredHeight: 60

            text: qsTr("Circulation Pump")

            verticalAlignment: Text.AlignVCenter
        }

        ACXToggleButton {
            Layout.preferredWidth: parent.width/3
            Layout.preferredHeight: 60

            enabled: false

            model: [
                qsTr("Off"),
                qsTr("On")
            ]
            currentIndex: DeviceState.circulationPump
        }

        ACXButton {
            Layout.minimumWidth: 200
            Layout.preferredHeight: 60

            label.text: qsTr("Toggle")

            enabled: SerialComm.isConnected

            onTriggered:  {
                DeviceState.toggleAndSendIOState(DeviceState.IOD_CIRCULATION_PUMP)
            }
        }

        ACXLabel {
            Layout.preferredWidth: parent.width/3
            Layout.preferredHeight: 60

            text: qsTr("Heat Changer Pump")

            verticalAlignment: Text.AlignVCenter
        }

        ACXToggleButton {
            Layout.preferredWidth: parent.width/3
            Layout.preferredHeight: 60

            enabled: false

            model: [
                qsTr("Off"),
                qsTr("On")
            ]
            currentIndex: DeviceState.heatChangerPump
        }

        ACXButton {
            Layout.minimumWidth: 200
            Layout.preferredHeight: 60

            label.text: qsTr("Toggle")

            enabled: SerialComm.isConnected

            onTriggered:  {
                DeviceState.toggleAndSendIOState(DeviceState.IOD_HEAT_CHANGER_PUMP)
            }
        }

        Item {
            Layout.columnSpan: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    ACXNavButton {
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        isForward: true
        isAbort: true

        onTriggered: {
            DeviceState.disableIOSimulations()
        }
    }

}

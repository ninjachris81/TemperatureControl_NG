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

    property date deviceDate
    nextScreen: ScreenNames.SCREEN_MANUAL_NEXT
    nextDisabledReason: !SerialComm.isConnected ? "Not connected" : ""

    isFinishScreen: true

    onNextTriggered: {
        DeviceState.sendTimestamp(Date.UTC(yearInput.value, monthInput.value-1, dayInput.value, hourInput.value, minuteInput.value, 0, 0) / 1000);
        popStack()
    }

    ACXButton {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        height: 50
        width: 80

        label.text: qsTr("Sync")

        onTriggered: {
            DeviceState.syncNTPTime()
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: menuLeftMargin
        anchors.rightMargin: 40
        anchors.topMargin: 30
        anchors.bottomMargin: 20

        spacing: 10

        ACXNumberInput2 {
            id: hourInput
            Layout.minimumHeight: 220
            Layout.fillHeight: true
            Layout.preferredWidth: 40
            Layout.fillWidth: true
            label: qsTr("Hour")

            value: deviceDate.getHours()

            from: 0
            to: 23
        }

        ACXLabel {
            id: sep1
            Layout.bottomMargin: 43
            font.pointSize: 22
            text: ":"
        }

        ACXNumberInput2 {
            id: minuteInput
            Layout.minimumHeight: 220
            Layout.fillHeight: true
            Layout.preferredWidth: 40
            Layout.fillWidth: true
            label: qsTr("Minute")

            value: deviceDate.getMinutes()

            from: 0
            to: 59
            padZero: 2
        }

        ACXLabel {
            Layout.bottomMargin: 43
            font.pointSize: 22
        }

        ACXNumberInput2 {
            id: dayInput
            Layout.minimumHeight: 220
            Layout.fillHeight: true
            Layout.preferredWidth: 40
            Layout.fillWidth: true
            label: qsTr("Day")

            value: deviceDate.getDate()

            from: 1
            to: 31
        }

        ACXLabel {
            Layout.bottomMargin: 43
            font.pointSize: 22
            text: "."
        }

        ACXNumberInput2 {
            id: monthInput

            Layout.minimumHeight: 220
            Layout.fillHeight: true
            Layout.preferredWidth: 40
            Layout.fillWidth: true
            label: qsTr("Month")

            value: deviceDate.getMonth() + 1

            from: 1
            to: 12
        }

        ACXLabel {
            Layout.bottomMargin: 43
            font.pointSize: 22
            text: "."
        }

        ACXNumberInput2 {
            id: yearInput

            Layout.minimumHeight: 200
            Layout.fillHeight: true
            Layout.preferredWidth: 40
            Layout.fillWidth: true
            label: qsTr("Year")

            value: deviceDate.getFullYear()

            from: 1970
            to: 3000
        }
    }

    Component.onCompleted: {
        deviceDate = new Date(DeviceState.timestamp * 1000)
    }

    Connections {
        target: DeviceState

        onNtpTimeSynced: {
            deviceDate = new Date(DeviceState.timestamp * 1000)
        }
    }

}

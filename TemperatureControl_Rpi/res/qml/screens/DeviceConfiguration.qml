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

            text: qsTr("Holiday Mode")

            verticalAlignment: Text.AlignVCenter
        }

        ACXToggleButton {
            Layout.preferredWidth: parent.width/3
            Layout.preferredHeight: 60

            model: [
                qsTr("Off"),
                qsTr("On")
            ]
            currentIndex: DeviceState.holidayMode

            onCurrentIndexChanged:  {
                DeviceState.setConfig(DeviceState.CONF_HOLIDAY_MODE, currentIndex)
            }
        }

        Item {
            Layout.columnSpan: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

}

import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import de.tempcontrol 1.0

import "qrc:/qml/."
import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/label"
import "qrc:/qml/components/acx/speller"

import "qrc:/qml/Paths.js" as Paths
import "qrc:/qml/components/acx/ACXStackViewParams.js" as ACXStackViewParams

ACXScreenBase {
    id: root

    GridLayout {
        anchors.fill: parent
        anchors.leftMargin: menuLeftMargin + 10
        anchors.rightMargin: 40
        anchors.topMargin: 10

        columns: 2

        ACXLabel {
            Layout.preferredWidth: 200
            Layout.preferredHeight: 40

            text: qsTr("Radiator Level")
        }

        ACXLabel {
            Layout.fillWidth: true
            Layout.preferredHeight: 40

            text: DeviceState.radiatorLevel
        }

        ACXCheckBox {
            Layout.preferredHeight: 50
            Layout.preferredWidth: 200

            id: radiatorLevel

            onToggled: {
                if (!checked) {
                    DeviceState.sendRadiatorLevel(0)
                } else {
                    DeviceState.sendRadiatorLevel(slider.value)
                }
            }
        }

        Slider {
            id: slider
            Layout.fillWidth: true
            Layout.preferredHeight: 50

            enabled: radiatorLevel.checked

            snapMode: Slider.SnapAlways

            stepSize: 1

            from: 1
            to: 8

            onMoved: {
                DeviceState.sendRadiatorLevel(slider.value)
            }
        }

        Item {
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}

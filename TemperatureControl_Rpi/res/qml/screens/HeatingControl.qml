import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import de.tempcontrol 1.0

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
            Layout.preferredWidth: 230
            Layout.preferredHeight: 40

            text: qsTr("Radiator Level Day")
        }

        ACXLabel {
            Layout.fillWidth: true
            Layout.preferredHeight: 40

            text: DeviceState.radiatorLevelDay
        }

        ACXCheckBox {
            id: radiatorLevelDay

            Layout.preferredHeight: 50
            Layout.preferredWidth: 230

            checked: DeviceState.radiatorLevelDay>0

            onToggled: {
                if (!checked) {
                    DeviceState.sendRadiatorLevelDay(0)
                } else {
                    DeviceState.sendRadiatorLevelDay(sliderDay.value)
                }
            }
        }

        Slider {
            id: sliderDay
            Layout.fillWidth: true
            Layout.preferredHeight: 50

            enabled: radiatorLevelDay.checked

            snapMode: Slider.SnapAlways

            stepSize: 1

            from: 1
            to: 8

            onMoved: {
                DeviceState.sendRadiatorLevelDay(sliderDay.value)
            }
        }

        ACXLabel {
            Layout.topMargin: 40
            Layout.preferredWidth: 230
            Layout.preferredHeight: 40

            text: qsTr("Radiator Level Night")
        }

        ACXLabel {
            Layout.fillWidth: true
            Layout.preferredHeight: 40

            text: DeviceState.radiatorLevelNight
        }

        ACXCheckBox {
            id: radiatorLevelNight

            Layout.preferredHeight: 50
            Layout.preferredWidth: 230

            checked: DeviceState.radiatorLevelNight>0

            onToggled: {
                if (!checked) {
                    DeviceState.sendRadiatorLevelNight(0)
                } else {
                    DeviceState.sendRadiatorLevelNight(sliderNight.value)
                }
            }
        }

        Slider {
            id: sliderNight
            Layout.fillWidth: true
            Layout.preferredHeight: 50

            enabled: radiatorLevelNight.checked

            snapMode: Slider.SnapAlways

            stepSize: 1

            from: 1
            to: 8

            onMoved: {
                DeviceState.sendRadiatorLevelNight(sliderNight.value)
            }
        }

        Item {
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}

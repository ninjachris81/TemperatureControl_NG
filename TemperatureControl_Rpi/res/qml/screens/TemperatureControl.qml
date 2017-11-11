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

    nextScreen: ScreenNames.SCREEN_INVALID

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: menuLeftMargin + 10
        anchors.rightMargin: 40
        anchors.topMargin: 10

        Repeater {
            model: 7

            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 50

                ACXLabel {
                    id: label
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 200
                    Layout.fillWidth: true

                    text: qsTr("Temp HC")
                }

                ACXTextInput {
                    id: textInput
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 200

                    inputMethodHints: Qt.ImhFormattedNumbersOnly

                    text: DeviceState.getSimulatedValue(index)

                    onAccepted: {
                        tempSimu.checked = true
                        DeviceState.simulateTemp(index, parseFloat(textInput.text))
                    }
                }

                ACXCheckBox {
                    id: tempSimu

                    enabled: textInput.text!==""

                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 150

                    checked: DeviceState.isSimulated(index)

                    onToggled: {
                        if (checked) {
                            DeviceState.simulateTemp(index, parseFloat(textInput.text))
                        } else {
                            DeviceState.disableTempSimulation(index)
                        }
                    }
                }

                Component.onCompleted: {
                    switch(index) {
                    case DeviceState.TEMP_HC:
                        label.text = Qt.binding(function() { return DeviceState.tempHC })
                        break;
                    case DeviceState.TEMP_WATER:
                        label.text = Qt.binding(function() { return DeviceState.tempWater })
                        break;
                    case DeviceState.TEMP_TANK:
                        label.text = Qt.binding(function() { return DeviceState.tempTank })
                        break;
                    case DeviceState.TEMP_TANK2:
                        label.text = Qt.binding(function() { return DeviceState.tempTank2 })
                        break;
                    case DeviceState.TEMP_BOILER:
                        label.text = Qt.binding(function() { return DeviceState.tempBoiler })
                        break;
                    case DeviceState.TEMP_OUTSIDE:
                        label.text = Qt.binding(function() { return DeviceState.tempOutside })
                        break;
                    case DeviceState.TEMP_SOLAR:
                        label.text = Qt.binding(function() { return DeviceState.tempSolar })
                        break;
                    }
                }
            }
        }
    }


}

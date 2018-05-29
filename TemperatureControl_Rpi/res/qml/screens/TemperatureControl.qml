import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import de.tempcontrol 1.0

import "."
import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/label"
import "qrc:/qml/components/acx/speller"

import "qrc:/qml/Paths.js" as Paths
import "qrc:/qml/components/acx/ACXStackViewParams.js" as ACXStackViewParams

ACXScreenBase {
    id: root

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: menuLeftMargin + 10
        anchors.rightMargin: 40
        anchors.topMargin: 10

        Repeater {
            model: 8

            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 40

                ACXLabel {
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 70

                    text: DeviceState.getTempName(index)
                }

                ACXLabel {
                    id: label
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 200
                    Layout.fillWidth: true

                    text: ""
                }

                ACXTextInput {
                    id: textInput
                    Layout.preferredHeight: 40
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

                    Layout.preferredHeight: 40
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
                        label.text = Qt.binding(function() { return DeviceState.tempHC.toFixed(2) })
                        break;
                    case DeviceState.TEMP_WATER:
                        label.text = Qt.binding(function() { return DeviceState.tempWater.toFixed(2) })
                        break;
                    case DeviceState.TEMP_TANK:
                        label.text = Qt.binding(function() { return DeviceState.tempTank.toFixed(2) })
                        break;
                    case DeviceState.TEMP_SOLAR_BACK:
                        label.text = Qt.binding(function() { return DeviceState.tempSolarBack.toFixed(2) })
                        break;
                    case DeviceState.TEMP_TANK2:
                        label.text = Qt.binding(function() { return DeviceState.tempTank2.toFixed(2) })
                        break;
                    case DeviceState.TEMP_BOILER:
                        label.text = Qt.binding(function() { return DeviceState.tempBoiler.toFixed(2) })
                        break;
                    case DeviceState.TEMP_OUTSIDE:
                        label.text = Qt.binding(function() { return DeviceState.tempOutside.toFixed(2) })
                        break;
                    case DeviceState.TEMP_SOLAR:
                        label.text = Qt.binding(function() { return DeviceState.tempSolar.toFixed(2) })
                        break;
                    }
                }
            }
        }
    }


}

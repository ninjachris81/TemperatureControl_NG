import QtQuick 2.8
import QtQuick.Layouts 1.3

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/label"

Item {
    id: root

    property alias previewText: textInput.previewText
    property int inputFieldWidth: 100
    property int value
    property int type: -1
    property int typeUnit: -1

    onValueChanged: applyText()
    onTypeChanged: {
        if (typeUnit===-1) typeUnit = UnitConversion.getDefaultUnit(root.type)
    }
    onTypeUnitChanged: applyText()

    function applyText() {
        textInput.text = calculateText(value);
    }

    function calculateText(thisValue) {
        return roundValue(UnitConversion.translateToTargetUnit(type, typeUnit, thisValue));
    }

    function roundValue(thisValue) {
        return UnitConversion.roundValue(type, typeUnit, thisValue);
    }

    function calculateValue(thisText) {
        return thisText==="" ? 0 : UnitConversion.translateFromUnit(type, typeUnit, parseFloat(thisText))
    }

    RowLayout {
        anchors.fill: parent

        ACXTextInput {
            id: textInput

            Layout.preferredWidth: root.inputFieldWidth

            horizontalAlignment: Text.AlignRight

            inputMethodHints: {
                UnitConversion.supportsDecimal(type, typeUnit) ?
                Qt.ImhFormattedNumbersOnly :
                Qt.ImhDigitsOnly
            }

            onAccepted: {
                var t1 = calculateText(parseInt(calculateValue(parseFloat(textInput.text))))
                var t2 = roundValue(parseFloat(textInput.text))

                console.log(t1);
                console.log(t2);

                if (t1!==t2) {
                    NotificationManager.toastManager.pushToast(qsTr("Your input has been converted to the closed possible number"))
                }

                value = calculateValue(parseFloat(textInput.text))
            }
        }

        ACXLabel {
            id: unitLabel

            Layout.minimumWidth: 40
            Layout.fillWidth: true

            Layout.leftMargin: 20
            Layout.rightMargin: 20

            horizontalAlignment: Text.AlignRight

            text: UnitConversion.formatValue(type, typeUnit, value)[1]

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    typeUnit = UnitConversion.getNextUnit(type, typeUnit)
                }
            }
        }
    }

    Connections {
        target: UnitConversion

        onDefaultWeightUnitChanged: {
            if (type===UnitConversion.TYPE_WEIGHT) typeUnit = UnitConversion.defaultWeightUnit;
        }

        onDefaultTempUnitChanged: {
            if (type===UnitConversion.TYPE_TEMP) typeUnit = UnitConversion.defaultTempUnit;
        }

        onDefaultVolumeUnitChanged: {
            if (type===UnitConversion.TYPE_VOLUME) typeUnit = UnitConversion.defaultVolumeUnit;
        }

        onDefaultPressureUnitChanged: {
            if (type===UnitConversion.TYPE_PRESSURE) typeUnit = UnitConversion.defaultPressureUnit;
        }

        onDefaultDurationUnitChanged: {
            if (type===UnitConversion.TYPE_DURATION) typeUnit = UnitConversion.defaultDurationUnit;
        }
    }

}

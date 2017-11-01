import QtQuick 2.8
import QtQuick.Templates 2.2 as T
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/label"
import "qrc:/qml/components/acx/speller"

import "qrc:/qml/DefaultStyle.js" as DefaultStyle

/* THIS COMPONENT NEEDS REFACTORING */

T.SpinBox {
    id: control

    property int padZero: 0

    property string previewText: ""
    property bool showIndicators: true

    property int leftMargin: decreaseButton.width + 10
    property int rightMargin: increaseButton.width + 10

    font.family: DefaultStyle.fontFamily
    font.pointSize: DefaultStyle.fontSize

    focus: textInput.focus

    //ACXItemTracer {}

    function pad (str, max) {
        return str.length < max ? pad("0" + str, max) : str;
    }

    contentItem: ACXTextInput {
        id: textInput

        anchors.fill: parent
        anchors.leftMargin: control.leftMargin
        anchors.rightMargin: control.rightMargin
        anchors.topMargin: 10
        anchors.bottomMargin: 8

        //ACXItemTracer {}

        text: pad(control.value + "", control.padZero)

        previewText: control.previewText

        onAccepted: {
            control.value = parseInt(text)
            control.focus = false
        }

        onCanceledInput: {
            control.focus = false
        }

        font: control.font
        color: DefaultStyle.fontColor
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: control.inputMethodHints
    }

    down.indicator: ACXButton {
        id: decreaseButton
        anchors.verticalCenter: control.verticalCenter

        visible: control.showIndicators

        x: control.mirrored ? parent.width - width : 0
        height: parent.height
        width: height

        label.text: "-"
        label.font.pointSize: 30
        label.color: DefaultStyle.fontColor

        autoRepeat: true

        onTriggered: {
            control.stepSize = stepSize;
            control.decrease()
        }
    }

    up.indicator: ACXButton {
        id: increaseButton
        anchors.verticalCenter: control.verticalCenter

        visible: control.showIndicators

        x: control.mirrored ? 0 : parent.width - width
        height: parent.height
        width: height

        label.text: "+"
        label.font.pointSize: 30
        label.color: DefaultStyle.fontColor

        autoRepeat: true

        onTriggered: {
            control.stepSize = stepSize;
            control.increase()
        }
    }

    /*
    background: Rectangle {
        id: backgroundRect
        color: "white"

        anchors.fill: parent
        anchors.leftMargin: decreaseButton.width + 10
        anchors.rightMargin: increaseButton.width + 10
        anchors.topMargin: 10
        anchors.bottomMargin: 8

        z: control.z - 1

        radius: 3

        layer.enabled: true
        layer.effect: DropShadow {
            spread: 0
            fast: true
            color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_TEXT)
        }
    }*/
}

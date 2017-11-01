import QtQuick 2.8

import de.tempcontrol 1.0

ACXLabel {
    id: root

    property var numberInput
    property string unitName
    property string prefix: ""
    property string postfix: ""

    text: numberInput ? prefix + qsTr("Value Range") + ": " + numberInput.from + " - " + numberInput.to  + " " + unitName + postfix : ""
}

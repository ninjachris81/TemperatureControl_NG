import QtQuick 2.0

import de.tempcontrol 1.0

ACX2CompLabel {
    id: root

    property string labelText: ""
    property var value
    property int type: -1
    property int typeUnit: -1

    property bool negativeWarning: false

    //ACXItemTracer {}

    leftPart: labelText
    rightPart: {
        var v = UnitConversion.formatValue(type, typeUnit, value);
        return v[0] + " " + v[1];
    }

    rightColor: negativeWarning && value<0 ? VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_ERROR) : root.color

}

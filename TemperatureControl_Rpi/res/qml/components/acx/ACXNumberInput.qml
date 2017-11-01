import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/speller"
import "qrc:/qml/components/acx/label"

SpinBox {
    id: root

    //ACXItemTracer {}

    editable: true

    inputMethodHints: Qt.ImhDigitsOnly

    font.family: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_FONT_FAMILY)
    font.pointSize: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_FONT_SIZE)
}

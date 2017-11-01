import QtQuick 2.8
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/Paths.js" as Paths

Item {
    id: root

    property alias text: textLabel.text
    property int labelMargin: 0

    property alias iconSource: iconImg.source
    property int iconMargin: 0
    property color iconColor: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_TEXT)

    Rectangle {
        anchors.fill: parent

        radius: 3

        color: "transparent"

        //border.width: 1

        //border.color: Qt.darker(VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_BACKGROUND_BRIGHT), 1.5)
    }

    Image {
        id: iconImg

        anchors.fill: parent

        verticalAlignment: Image.AlignVCenter
        horizontalAlignment: textLabel.text ? Image.AlignLeft : Image.AlignHCenter

        anchors.leftMargin: horizontalAlignment===Image.AlignLeft ? root.iconMargin : 0

        fillMode: Image.Pad

        //opacity: 0.5

        layer.enabled: root.iconColor
        layer.effect: ColorOverlay {
            color: root.iconColor
        }
    }

    ACXLabel {
        id: textLabel
        visible: text.length>0

        //opacity: 0.2

        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -2

        horizontalAlignment: iconImg.status!==Image.Null ? Text.AlignRight : Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        anchors.leftMargin: horizontalAlignment===Text.AlignLeft ? root.labelMargin : 0
        anchors.rightMargin: horizontalAlignment===Text.AlignRight ? root.labelMargin : 0

        anchors.left: parent.left
        anchors.right: parent.right

        color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_TEXT)
   }
}

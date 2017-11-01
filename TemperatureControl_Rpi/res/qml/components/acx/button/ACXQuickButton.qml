import QtQuick 2.0
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/Paths.js" as Paths

ACXButton {
    id: root

    property string iconName

    anchors.left: parent.left
    anchors.leftMargin: 10

    anchors.right: parent.right
    anchors.rightMargin: 10

    height: 62

    labelMargin: 20
    label.horizontalAlignment: Text.AlignRight

    fontSize: 18

    Image {
        id: carBackgroundImage
        source: Paths.image("home/quick_access/icons/car.png")

        layer.enabled: root.enabled && !root.pressed
        layer.effect: ColorOverlay {
            color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_TEXT)
        }
    }

    Image {
        source: Paths.image("home/quick_access/icons/" + root.iconName + ".png")
        layer.enabled: root.enabled && !root.pressed
        layer.effect: ColorOverlay {
            color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_BRIGHT)
        }
    }

}


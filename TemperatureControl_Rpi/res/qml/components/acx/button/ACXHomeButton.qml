import QtQuick 2.0
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/Paths.js" as Paths

Item {
    id: root

    signal triggered

    height: backgroundImage.paintedHeight
    width: backgroundImage.width

    Image {
        id: backgroundImage

        source: Paths.image("common/buttons/home_button/home_bg.png")

        layer.enabled: true
        layer.effect: ColorOverlay {
            color: homeButtonMA.pressed ? "black" : "#005387"
        }

        MouseArea {
            id: homeButtonMA

            anchors.fill: parent

            onClicked: root.triggered()
        }
    }

    Image {
        source: Paths.image("common/buttons/home_button/home_effects" + (homeButtonMA.pressed ? "_pressed" : "") + ".png")
    }

    Image {
        source: Paths.image("common/buttons/home_button/home_icon.png")
    }

}

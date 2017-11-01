import QtQuick 2.0
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"

import "qrc:/qml/Paths.js" as Paths

Item {
    id: root

    signal triggered

    property string name
    property string activeOverlay
    property string iconSource
    property bool isOpen: activeOverlay===name

    width: pressedImage.paintedWidth
    height: pressedImage.paintedHeight

    onTriggered: {
        console.log("Activate overlay " + name)
        parent.activateOverlay(name)
    }

    MaskedMouseArea {
        id: mouseArea

        anchors.fill: parent

        maskSource: pressedImage.source

        onClicked: {
            root.triggered();
        }
    }

    Image {
        id: pressedImage
        source: Paths.image("statusbar/03_item_pressed.png")
        smooth: true
        visible: false
    }

    ColorOverlay {
        anchors.fill: pressedImage
        source: pressedImage
        color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_DARK)
        visible: root.isOpen
    }

    Image {
        source: root.iconSource
        anchors.centerIn: mouseArea
    }
}

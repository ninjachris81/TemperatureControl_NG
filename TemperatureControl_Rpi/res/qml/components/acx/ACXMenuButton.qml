import QtQuick 2.0

import de.tempcontrol 1.0

import "label"

import "qrc:/qml/Paths.js" as Paths

Item {
    id: root

    property alias iconSource: iconImg.source
    property alias label: textLabel.text
    property alias fontSize: textLabel.font.pointSize

    signal triggered

    BorderImage {
        id: buttonImg
        anchors.fill: parent
        //source: "/res/images/common/buttons/mainbutton" + (mouseArea.pressed ? "_pressed" : "") + ".png"
        source: Paths.image("common/buttons/mainbutton.png")
        border.left: 1; border.top: 3
        border.right: 1; border.bottom: 3
    }

    Image {
        id: iconImg
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {
            console.log("menu " + root.label)
            root.triggered();
        }
    }

    ACXLabel {
        id: textLabel
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter

        //font.pointSize: root.fontSize ? root.fontSize : VariantConfigurationManager.defaultFontSize
    }

}

import QtQuick 2.0
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/Paths.js" as Paths

Item {
    id: root

    property alias iconSource: iconImg.source
    property color iconColor
    property bool isCurrentItem: false
    property bool isLastItem: false
    property int currentIndex

    property color backgroundColor

    property alias pressed: mouseArea.pressed

    signal triggered

    BorderImage {
        id: buttonImg
        anchors.fill: parent

        visible: root.isCurrentItem || mouseArea.pressed

        source: Paths.image("common/buttons/roundbutton" + (mouseArea.pressed ? "_pressed" : root.isCurrentItem ? "_effect": "") + ".png")
        border.left: 3; border.top: 3
        border.right: 0; border.bottom: 3

        Rectangle {
            width: 2
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 2
            anchors.bottomMargin: 2

            color: backgroundColor
        }
    }

    Rectangle {
        height: 2

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        color: "#787272"

        opacity: 0.5
        visible:  !(root.isCurrentItem || root.isLastItem || root.currentIndex-index===1)
    }

    Rectangle {
        width: 2

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        color: "#787272"

        opacity: 0.5
        visible: !root.isCurrentItem
    }

    Image {
        id: iconImg

        anchors.centerIn: parent
        layer.enabled: true
        layer.effect: ColorOverlay {
            color: iconColor
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {
            root.triggered();
        }
    }
}

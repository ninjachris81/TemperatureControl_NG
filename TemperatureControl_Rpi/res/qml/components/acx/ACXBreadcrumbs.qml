import QtQuick 2.0

import de.tempcontrol 1.0

import "label"

Item {
    id: root

    property var stackView
    property var currentScreen

    ACXLabel {
        text: currentScreen.name
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 10
        font.pointSize: 14

        elide: Text.ElideRight
    }

    //ACXItemTracer {}

    Component.onCompleted: {
        if (!stackView) console.error("stackView not set !");
        if (!currentScreen) console.error("currentScreen not set !");
    }

}

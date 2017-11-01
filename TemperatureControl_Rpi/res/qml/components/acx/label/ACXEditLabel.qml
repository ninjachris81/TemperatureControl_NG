import QtQuick 2.8

import "qrc:/qml/components/acx/button"

ACX2CompLabel {
    id: root

    property alias iconSource: button.iconSource
    property alias iconColor: button.iconColor

    signal editTriggered()

    verticalAlignment: Text.AlignVCenter

    rightPadding: button.width + 10

    ACXButton {
        id: button

        anchors.right: parent.right

        height: root.height
        width: root.height

        onTriggered: {
            root.editTriggered()
        }
    }
}

import QtQuick 2.8

Item {
    id: root

    property alias inputField: textInput

    signal triggered

    ACXTextInput {
        id: textInput

        anchors.fill: parent

        enabled: false
        showAsEnabled: true
    }

    MouseArea {
        anchors.fill: textInput

        onClicked: {
            root.triggered()
        }
    }
}

import QtQuick 2.0

import "qrc:/qml/Paths.js" as Paths
import "label"

ACXListViewDelegateBase {
    id: root

    //ACXItemTracer {}

    Component.onCompleted: {
        label.text = Qt.binding(function() { return ListView.view.model[index].liLabel})
        subLabel.text = Qt.binding(function() { return ListView.view.model[index].liSubLabel})
        icon.source = Qt.binding(function() { return Paths.image(ListView.view.model[index].liIcon)})
    }

    ACXHDivider {
        anchors.rightMargin: 12
    }

    ACXLabel {
        id: label
        anchors.top: parent.top
        anchors.topMargin: 12
        anchors.left: parent.left
        anchors.leftMargin: parent.ListView.view.leftMargin

        text: "" // liLabel ? liLabel : ""
    }

    ACXLabel {
        id: subLabel
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8

        anchors.left: parent.left
        anchors.leftMargin: parent.ListView.view.leftMargin

        //text: liSubLabel ? liSubLabel : ""

        font.pointSize: 12
        opacity: 0.8
    }

    Image {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 18

        //source: Paths.image(liIcon)
    }

    MouseArea {
        anchors.fill: parent

        onClicked: root.triggered()
    }

}

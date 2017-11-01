import QtQuick 2.8
import QtQuick.Layouts 1.3

import de.tempcontrol 1.0


import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/label"

import "qrc:/qml/Paths.js" as Paths
import "qrc:/qml/DefaultStyle.js" as DefaultStyle

Item {
    id: root

    property int currentIndex: 0
    property alias model: repeater.model

    //ACXItemTracer {}

    RowLayout {
        anchors.fill: parent

        spacing: 0

        Repeater {
            id: repeater

            delegate: Item {

                Layout.fillHeight: true
                Layout.fillWidth: true

                Rectangle {
                    anchors.fill: parent

                    radius: 6

                    color: DefaultStyle.brightColor
                    visible: root.currentIndex === index

                    Rectangle {
                        height: parent.height
                        anchors.right: index===0 ? parent.right : undefined
                        anchors.left: index>0 ? parent.left : undefined
                        width: parent.radius

                        color: DefaultStyle.brightColor
                        visible: root.currentIndex === index
                    }
                }

                BorderImage {
                    source: Paths.image("common/buttons/toggle_button/toggle_" + (index===root.currentIndex ? "" : "in") + "active.png")

                    anchors.fill: parent

                    mirror: index>0

                    border.left: 3; border.top: 3
                    border.right: 3; border.bottom: 3
                }

                ACXLabel {
                    anchors.fill: parent

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: root.currentIndex === index ? "white" : DefaultStyle.fontColor

                    text: modelData
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        root.currentIndex = index
                    }
                }
            }
        }
    }

}

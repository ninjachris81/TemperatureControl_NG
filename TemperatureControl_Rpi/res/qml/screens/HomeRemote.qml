import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/label"

import "qrc:/qml/Paths.js" as Paths
import "qrc:/qml/components/acx/ACXStackViewParams.js" as ACXStackViewParams

ACXScreenBase {
    id: root

    //ACXItemTracer {}

    showHome: false

    ListModel {
        id: gridModel

        ListElement {
            liLabel: qsTr("Solar")
            liIcon: "solar-panel-in-sunlight.png"
            liIndex: ScreenNames.SCREEN_SOLAR_CONTROL
        }
        ListElement {
            liLabel: qsTr("Heating")
            liIcon: "vintage-mercury-thermometer-.png"
            liIndex: ScreenNames.SCREEN_HEATING_CONTROL
        }
        ListElement {
            liLabel: qsTr("")
            liIcon: ""
            liIndex: ScreenNames.SCREEN_INVALID
        }
        ListElement {
            liLabel: qsTr("")
            liIcon: ""
            liIndex: ScreenNames.SCREEN_INVALID
        }

        ListElement {
            liLabel: qsTr("")
            liIcon: ""
            liIndex: ScreenNames.SCREEN_INVALID
        }
        ListElement {
            liLabel: qsTr("")
            liIcon: ""
            liIndex: ScreenNames.SCREEN_INVALID
        }
        ListElement {
            liLabel: qsTr("")
            liIcon: ""
            liIndex: ScreenNames.SCREEN_INVALID
        }
        ListElement {
            liLabel: qsTr("")
            liIcon: ""
            liIndex: ScreenNames.SCREEN_INVALID
        }
    }

    Component {
        id: gridDelegate

        Item {
            width: gridView.cellWidth
            height: gridView.cellHeight

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if (liIndex!==ScreenNames.SCREEN_INVALID) pushStack(liIndex, false)
                }
            }

            Rectangle {
                anchors.fill: parent
                anchors.margins: 10

                color: "transparent"

                border.color: "black"
                border.width: liLabel ? 2 : 0
                radius: 10

                Image {
                    id: icon

                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -20
                    source: liIcon ? Paths.image("icons/" + liIcon) :""
                }

                ACXLabel {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10

                    font.pointSize: 28

                    horizontalAlignment: Text.AlignHCenter

                    text: liLabel
                }
            }
        }
    }

    GridView {
        id: gridView

        anchors.fill: parent
        anchors.margins: 20

        model: gridModel

        //ACXItemTracer {}

        cellWidth: (root.width - (gridView.anchors.margins*2)) / 4
        cellHeight: (root.height - (gridView.anchors.margins*2)) / 2

        interactive: false

        delegate: gridDelegate
    }

}

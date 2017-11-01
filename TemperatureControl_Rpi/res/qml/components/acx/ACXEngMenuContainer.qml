import QtQuick 2.0
import QtQuick.Layouts 1.3

import de.tempcontrol 1.0

import "button"
import "label"

import "qrc:/qml/Paths.js" as Paths

Rectangle {
    id: root

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#e5e5e5" }
        GradientStop { position: 1.0; color: "white" }
    }

    Rectangle {
        id: titleBar
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40

        color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_DARK)

        ACXLabel {
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Engineering Menu")
            color: "white"
        }

        ACXButton {
            width: 50
            height: 30

            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5

            iconSource: Paths.image("common/icons/close_overlay_toast.png")

            onTriggered: {
                root.visible = false
            }
        }
    }

    RowLayout {
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        ACXListView {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Layout.minimumHeight: 200
            Layout.minimumWidth: 400

            model: ListModel {
                ListElement {
                    liLabel: "Debug Mode"
                }
                ListElement {
                    liLabel: "EOL Interface"
                }
                ListElement {
                    liLabel: "Combo Filter"
                }
            }

            onTriggered: stackLayout.currentIndex = index
        }

        StackLayout {
            id: stackLayout
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 200
            Layout.minimumWidth: 400

            Layout.topMargin: 20
            Layout.leftMargin: 20

            Item {
                anchors.fill: parent

                ACXCheckBox {
                    text: "Enabled"

                    anchors.right: parent.right
                    anchors.rightMargin: 40
                    anchors.left: parent.left
                    height: 40
                }
            }

            Item {
                anchors.fill: parent

                ACXCheckBox {
                    text: "EOL Enabled"

                    anchors.right: parent.right
                    anchors.rightMargin: 40
                    anchors.left: parent.left
                    height: 40
                }
            }

            Item {
                anchors.fill: parent

                ACXButton {
                    label.text: "Reset Combo Filters"

                    width: 300
                    height: 60

                    onTriggered: {
                        ReminderManager.resetComboFilterIDs()
                    }
                }
            }
        }
    }

}

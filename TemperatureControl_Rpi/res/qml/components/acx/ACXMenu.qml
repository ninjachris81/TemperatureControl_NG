import QtQuick 2.0

import de.tempcontrol 1.0

import "qrc:/qml/Paths.js" as Paths

Item {
    id: root

    signal navigateTo(int screenIndex)

    property bool menuOpen: false

    function toggleMenu() {
        menuOpen = !menuOpen;
    }

    Rectangle {
        anchors.fill: parent

        color: "white"

        opacity: 0.6

        visible: root.menuOpen

        MouseArea {
            anchors.fill: parent

            onClicked: root.menuOpen = false
        }
    }

    Rectangle {
        anchors.rightMargin: menuOpen ? 0 : -width

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        width: 455

        //ACXItemTracer {}

        color: "grey"

        Behavior on anchors.rightMargin {
            NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
        }

        ListModel {
            id: listModel

            ListElement {
                liLabel: ""
                liScreenIndex: ScreenNames.SCREEN_DEVICE_LOG
            }
            ListElement {
                liLabel: ""
                liScreenIndex: ScreenNames.SCREEN_TIME_SETTINGS
            }
            ListElement {
                liLabel: ""
                liScreenIndex: ScreenNames.SCREEN_IO_CONTROL
            }
            ListElement {
                liLabel: ""
                liScreenIndex: ScreenNames.SCREEN_TEMPERATURE_CONTROL
            }
            ListElement {
                liLabel: ""
                liScreenIndex: ScreenNames.SCREEN_DEVICE_CONFIGURATION
            }
        }

        ListModel {
            id: emptyListModel
        }

        ACXListView {
            id: listView

            anchors.fill: parent

            //ACXItemTracer{}

            model: listModel

            delegate: ACXMenuListViewDelegate {}

            clip: true

            onNavigateTo: {
                root.menuOpen = false
                root.navigateTo(screenIndex)
            }
        }

        Image {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            source: Paths.image("statusbar/shadow_fly-in_menu.png")

            Component.onCompleted: {
                anchors.leftMargin = -paintedWidth
            }
        }
    }
}

import QtQuick 2.0
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/"
import "label"

import "qrc:/qml/Paths.js" as Paths

Item {
    id: root
    visible: name!==""

    readonly property string name: _internal.name

    signal navigateTo(int screenIndex)

    QtObject {
        id: _internal

        property string name
    }

    function setName(newName) {
        _internal.name = newName;
    }

    Rectangle {
        anchors.fill: parent
        visible: root.visible

        color: "white"
        opacity: 0.6

        MouseArea {
            anchors.fill: parent
        }
    }

    BorderImage {
        id: contentImage
        anchors.top: headerImage.bottom
        anchors.topMargin: -(border.top + headerImage.border.bottom)

        anchors.bottom: parent.bottom

        anchors.left: parent.left
        anchors.leftMargin: 10 - border.left
        anchors.right: parent.right
        anchors.rightMargin: 10 - border.right

        border.left: 8; border.top: 6
        border.right: 8; border.bottom: 10

        source: Paths.image("home/overlays/background.png")
    }

    Component {
        id: connectionsOverlay

        ConnectionsOverlay {
        }
    }

    Component {
        id: infoOverlay

        InfoOverlay {
        }
    }

    Component {
        id: unitConversionOverlay

        UnitConversionOverlay {
        }
    }

    Component {
        id: helpOverlay

        HelpOverlay {
        }
    }

    Loader {
        id: overlayLoader

        sourceComponent: connectionsOverlay

        state: root.name

        anchors.fill: contentImage
        anchors.leftMargin: contentImage.border.left - 2
        anchors.rightMargin: contentImage.border.right - 2
        anchors.topMargin: contentImage.border.top
        anchors.bottomMargin: contentImage.border.bottom - 2

        states: [
            State {
                name: "Connections"
                PropertyChanges { target: overlayLoader; sourceComponent: connectionsOverlay }
            },
            State {
                name: "Info"
                PropertyChanges { target: overlayLoader; sourceComponent: infoOverlay }
            },
            State {
                name: "UnitConversion"
                PropertyChanges { target: overlayLoader; sourceComponent: unitConversionOverlay }
            },
            State {
                name: "Help"
                PropertyChanges { target: overlayLoader; sourceComponent: helpOverlay }
            }
        ]

        Connections {
            target: overlayLoader.item

            onForceClose: {
                console.log("Force closing overlay")
                root.setName("")
            }

            onNavigateTo: {
                console.log("Nav to " + screenIndex)
                root.navigateTo(screenIndex)
            }

            onErrorCodeHelp: {
                console.log("Error code help " + errorCode)
                root.setName("Help")
                overlayLoader.item.openErrorCodeHelp(errorCode)
            }

            onErrorHelp: {
                console.log("Error help " + errorType)
                root.setName("Help")
                overlayLoader.item.openErrorHelp(errorType)
            }
        }
    }

    BorderImage {
        id: headerImage

        anchors.left: parent.left
        anchors.leftMargin: 10 - border.left
        anchors.right: parent.right
        anchors.rightMargin: 10 - border.right

        height: 60

        border.left: 3; border.top: 3
        border.right: 3; border.bottom: 3

        source: Paths.image("home/overlays/header.png")

        layer.enabled: true
        layer.effect: ColorOverlay {
            color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_DARK)
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                setName("");
            }
        }
    }

    ACXLabel {
        id: headerLabel

        anchors.fill: headerImage

        color: "white"

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        text: overlayLoader.item ? overlayLoader.item.title : ""
    }

    /*
    ACXLabel {
        anchors.left: parent.left
        anchors.top: parent.top


        height: 60

        anchors.leftMargin: 30

        color: "white"

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        text: "\u2bb9"
    }*/

    /*
    Image {
        source: Paths.image("common/icons/close_overlay_toast.png")

        anchors.right: headerImage.right
        anchors.rightMargin: 20

        height: headerImage.height
        width: headerImage.height

        verticalAlignment: Image.AlignVCenter
        fillMode: Image.Pad
    }*/

}

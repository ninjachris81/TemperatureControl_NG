import QtQuick 2.8
import QtQuick.Window 2.2

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/statusbar"
import "qrc:/qml/components/acx/speller"
import "qrc:/qml/components/acx/button"
import "qrc:/qml/."

import "qrc:/qml/components/acx/ACXStackViewParams.js" as ACXStackViewParams

//import acx 1.0

Window {
    id: root

    visible: true
    width: 800
    height: 480

    Rectangle {
        id: backgroundRect
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#e5e5e5" }
            GradientStop { position: 1.0; color: "white" }
        }

        focus: true
    }

    ACXStackView {
        id: stackView

        anchors.fill: parent

        //ACXItemTracer {}

        Component.onCompleted: {
            pushStack(ScreenNames.SCREEN_HOME)

        }
    }

    ACXMenu {
        id: menu

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: menuBtn.bottom
        //anchors.topMargin: -10

        width: root.width

        //ACXItemTracer {}

        onNavigateTo: {
            stackView.pushStack(screenIndex, ACXStackViewParams.clearStackCompletely)
        }

        onMenuOpenChanged: {
            if (menuOpen) {
            }
        }
    }

    MouseArea {
        id: menuBtn
        anchors.right: parent.right
        anchors.top: parent.top

        width: 70
        height: 70

        onClicked: menu.toggleMenu()

        //ACXItemTracer {}

        Image {
            anchors.centerIn: parent

            id: menuBarIcon
            source: Paths.image("statusbar/icons/menu.png")
        }
    }

    ACXPopupContainer {
        id: popupContainer
        anchors.fill: parent

        z: 2

        Component.onCompleted: {
            ACXPopupManager.popupContainer = popupContainer;
        }
    }

    ACXGeneralSpeller {
        id: generalSpeller
        anchors.fill: parent

        z: 2

        visible: Qt.inputMethod.visible && ACXSpellerContainer.currentSpellerType===ACXSpellerContainer.spellerTypeGeneral
    }

    Connections {
        target: SerialComm

        onIsConnectedChanged: {
            console.log("Sync All Data")
            if (SerialComm.isConnected) DeviceState.syncData()
        }
    }

    Component.onCompleted: {
        console.log("Sync All Data")
        DeviceState.syncData()
    }

    /*
    ACXToast {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        z: 2

        width: 600
        height: 80
    }*/
}

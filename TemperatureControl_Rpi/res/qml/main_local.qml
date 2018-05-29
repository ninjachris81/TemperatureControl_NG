import QtQuick 2.8
import QtQuick.Window 2.2

import de.tempcontrol 1.0

import "./components/acx"
import "./components/acx/statusbar"
import "./components/acx/speller"
import "./components/acx/button"
import "."

import "./components/acx/ACXStackViewParams.js" as ACXStackViewParams

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

    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10

        visible: SerialComm.isConnected
        source: Paths.image("common/icons/exchange.png")

        MouseArea {
            anchors.fill: parent
            anchors.margins: -10

            onClicked: {
                console.log("Sync All Data")
                DeviceState.syncData()
            }
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

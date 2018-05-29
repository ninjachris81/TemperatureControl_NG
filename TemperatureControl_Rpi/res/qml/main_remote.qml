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
    width: 1024
    height: 600

    Rectangle {
        id: backgroundRect
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#e5e5e5" }
            GradientStop { position: 1.0; color: "white" }
        }

        focus: true
    }

    ACXStatusBar {
        id: statusBar

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 60
    }

    ACXStackView {
        id: stackView

        anchors.fill: parent
        anchors.topMargin: statusBar.height


        //ACXItemTracer {}

        Component.onCompleted: {
            pushStack(ScreenNames.SCREEN_HOME)

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
        target: RestComm

        onIsConnectedChanged: {
            console.log("Sync All Data")
            if (RestComm.isConnected) DeviceState.syncData()
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

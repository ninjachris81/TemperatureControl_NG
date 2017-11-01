import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/"
import "qrc:/qml/components/acx"

import "qrc:/qml/Paths.js" as Paths

Item {
    id: root

    height: barBackground.paintedHeight
    width: barBackground.paintedWidth

    readonly property int buttonLeftMargin: -59

    property int wifiSignalStrength: 1
    property bool bluetoothEnabled: true
    property bool ethernetEnabled: false

    property string activeOverlay

    signal activateOverlay(string name)
    signal enterEM
    signal menuPressed

    Image {
        id: buttonBarBackground
        smooth: true
        visible: false
        source: Paths.image("statusbar/01_topbar_bg.png")
    }

    ColorOverlay {
        anchors.fill: buttonBarBackground
        source: buttonBarBackground
        color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_BRIGHT)
    }

    Image {
        source: Paths.image("statusbar/02_divider_reflection.png")
    }

    ACXStatusBarButton {
        id: connectionsBtn
        x: 127
        y: 14

        name: "Connections"
        iconSource: Paths.image("statusbar/icons/wlan_" + root.wifiSignalStrength + ".png")

        activeOverlay: root.activeOverlay

        Image {
            visible: root.ethernetEnabled
            source: Paths.image("statusbar/icons/ethernet.png")
        }

        Image {
            source: Paths.image("statusbar/icons/bluetooth_" + (root.bluetoothEnabled ? "white" : "grey") + ".png")
        }
    }

    ACXStatusBarButton {
        id: infoBtn
        anchors.left: connectionsBtn.right
        anchors.leftMargin: root.buttonLeftMargin
        anchors.top: connectionsBtn.top

        name: "Info"
        iconSource: Paths.image("statusbar/icons/info.png")
        activeOverlay: root.activeOverlay

        Image {
            visible: NotificationManager.hasNotifications
            source: Paths.image("statusbar/icons/info_warning.png")
        }
    }

    ACXStatusBarButton {
        id: unitsBtn
        anchors.left: infoBtn.right
        anchors.leftMargin: root.buttonLeftMargin
        anchors.top: infoBtn.top

        name: "UnitConversion"
        iconSource: Paths.image("statusbar/icons/unit_conversion.png")
        activeOverlay: root.activeOverlay
    }

    ACXStatusBarButton {
        id: helpBtn
        anchors.left: unitsBtn.right
        anchors.leftMargin: root.buttonLeftMargin
        anchors.top: unitsBtn.top

        name: "Help"
        iconSource: Paths.image("statusbar/icons/questionmark.png")
        activeOverlay: root.activeOverlay
    }

    Image {
        id: barBackground
        source: Paths.image("statusbar/04_topbar_bg2.png")

        Image {
            id: menuBarIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -5
            anchors.right: parent.right
            anchors.rightMargin: 30
            smooth: true
            visible: false

            source: Paths.image("statusbar/icons/menu.png")
        }

        ColorOverlay {
            anchors.fill: menuBarIcon
            source: menuBarIcon
            color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_BRIGHT)
        }

        MouseArea {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            width: 95

            onClicked: {
                menuPressed();
            }

            //ACXItemTracer {}
        }
    }

    ACXLogo {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10

        onEnterEM: {
            root.enterEM()
        }
    }

    ACXStatusBarClock {
        anchors.left: parent.left
        anchors.leftMargin: 14
        anchors.top: parent.top
        anchors.topMargin: 53

        height: 28
        width: 100

        //ACXItemTracer {}
    }

}

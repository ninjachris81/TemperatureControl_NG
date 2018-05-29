import QtQuick 2.0
import QtQuick.Layouts 1.3

import de.tempcontrol 1.0

import "qrc:/qml/"
import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/button"

import "qrc:/qml/Paths.js" as Paths

Rectangle {
    id: root

    readonly property int buttonLeftMargin: -59

    property int wifiSignalStrength: 1

    property string activeOverlay

    signal navigateTo(int menuIndex)

    color: "#005387"

    /*
    ACXButton {
        id: connectionsBtn
        x: 127
        y: 14

        iconSource: Paths.image("statusbar/icons/wlan_" + root.wifiSignalStrength + ".png")
    }*/

    ACXStatusBarClock {
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        width: 260

        //ACXItemTracer {}
    }

}

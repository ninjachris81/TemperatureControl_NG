import QtQuick 2.0
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "label"

import "qrc:/qml/Paths.js" as Paths

BorderImage {
    id: root

    state: "inactive"

    anchors.bottomMargin: -root.height

    source: Paths.image("common/toast/toast_bg.png")

    border.left: 72; border.top: 0
    border.right: 72; border.bottom: 0

    //color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_BACKGROUND_BRIGHT)

    //ACXItemTracer {}

    states: [
        State {
            name: "active"
            PropertyChanges { target: timeoutTimer; running: true}
            PropertyChanges { target: root; anchors.bottomMargin: 0}
        },
        State {
            name: "inactive"
            PropertyChanges { target: timeoutTimer; running: false}
            PropertyChanges { target: root; anchors.bottomMargin: -root.height}
        }
    ]

    Behavior on anchors.bottomMargin {
        NumberAnimation {}
    }

    function dispose() {
        root.state = "inactive";
        NotificationManager.toastManager.toastActive = false
    }

    Timer {
        id: timeoutTimer

        interval: NotificationManager.toastManager.toastTimeout
        repeat: false
        onTriggered: dispose();
    }

    Connections {
        target: NotificationManager.toastManager

        onShowToast: {
            label.text = msg
            root.state = "active"
        }
    }

    ACXLabel {
        id: label

        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        anchors.leftMargin: 100
        anchors.rightMargin: 100

        topPadding: 20
        bottomPadding: 10
        leftPadding: 10
        rightPadding: 10

        //ACXItemTracer {}
        fontSizeMode: Text.Fit

        wrapMode: Text.Wrap
    }

    /*
    Image {
        anchors.left: label.right
        anchors.verticalCenter: label.verticalCenter

        source: Paths.image("common/icons/close_overlay_toast.png")

        layer.enabled: true
        layer.effect: ColorOverlay {
            color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_TEXT)
        }
    }*/

    Image {
        anchors.right: label.left
        anchors.verticalCenter: label.verticalCenter

        source: Paths.image("common/icons/info.png")

        layer.enabled: true
        layer.effect: ColorOverlay {
            color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_TEXT)
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: dispose()
    }

}

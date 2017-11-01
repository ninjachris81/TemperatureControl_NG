import QtQuick 2.8
import QtQuick.Templates 2.2 as T
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx/label"

/* THIS COMPONENT NEEDS REFACTORING */

T.CheckBox {
    id: control

    property bool showAsButton: false

    background: Rectangle {
        visible: control.showAsButton
        color: "#f1f0ea"

        anchors.fill: parent

        radius: 3

        layer.enabled: control.enabled
        layer.effect: DropShadow  {
            spread: 0.2
            radius: 6.0
            fast: true
            samples: 12
            color: "#50000000" //VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_TEXT)
            //opacity: 0.2
        }
    }


    indicator: Item {
        width: control.width
        height: control.height

        opacity: control.enabled ? 1 : 0.3

        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            height: 32
            width: 74

            color: control.checked ? VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_BRIGHT) : VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_TEXT)
            radius: 360

            Rectangle {
                anchors.left: parent.left
                anchors.leftMargin: control.checked ? parent.width - width - 4 : 4
                anchors.top: parent.top
                anchors.topMargin: 4

                Behavior on anchors.leftMargin {
                    NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                }

                height: 24
                width: 24

                radius: 360
                color: "#e8e7e2"
            }
        }
    }

    contentItem: Item {
        width: control.width
        height: control.height

        ACXLabel {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10

            opacity: control.enabled ? 1 : 0.2

            text: control.text
        }
    }
}


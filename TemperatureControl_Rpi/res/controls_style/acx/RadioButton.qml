import QtQuick 2.8
import QtQuick.Templates 2.2 as T

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/label"

/* THIS COMPONENT NEEDS REFACTORING */

T.RadioButton {
    id: control

    //ACXItemTracer {}

    property bool showDivider: false
    property bool isHorizontal: false

    indicator: Item {

        width: control.width
        height: control.height

        //ACXItemTracer {}

        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            height: 32
            width: 32

            //ACXItemTracer {}

            radius: 360
            color: "transparent"
            border.color: "#4f5358"
            border.width: 1

            Rectangle {
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 4

                visible: control.checked

                height: 24
                width: 24

                radius: 360
                color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_BRIGHT)
            }
        }
    }

    contentItem: Item {
        width: control.width
        height: control.height

        ACXLabel {
            //ACXItemTracer {}

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left

            text: control.text
        }
    }

    background: Item {
        ACXHDivider {
            visible: control.showDivider
        }
    }
}

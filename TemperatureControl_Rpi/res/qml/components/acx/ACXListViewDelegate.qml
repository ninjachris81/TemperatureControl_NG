import QtQuick 2.0
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "label"

import "qrc:/qml/Paths.js" as Paths

ACXListViewDelegateBase {
    id: root

    //ACXItemTracer {}

    property bool hasSubLevel: (typeof(liHasSubLevel)==="undefined")  ? false : liHasSubLevel
    property string label: (typeof(liLabel)==="undefined" ? modelData : (liLabel==="" ? ScreenNames.resolveScreenName(liScreenIndex) : liLabel))
    readonly property string checkedExpression: (typeof(liCheckedExpression)==="undefined")  ? "" : liCheckedExpression
    readonly property bool isCheckBox: checkedExpression
    readonly property bool hasPin: (typeof(liPin)==="undefined" ? false : true)
    readonly property bool pinIsValid: hasPin ? liPin : true
    property alias fontSize: labelItem.font.pointSize

    property bool showDivider: true

    visible: DeviceConfigurationManager.requireOperatorPasswords && hasPin ? pinIsValid : true

    ACXHListDivider {
        visible: root.showDivider
    }

    ACXLabel {
        id: labelItem
        anchors.left: parent.left
        anchors.leftMargin: root.ListView.view.leftMargin
        anchors.verticalCenter: parent.verticalCenter

        //text: liLabel==="" ? ScreenNames.resolveScreenName(liScreenIndex) : liLabel
        text:root.label
    }

    Rectangle {
        visible: root.ListView.view.showRadioButton

        anchors.right: parent.right
        anchors.rightMargin: root.ListView.view.rightMargin
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

            visible: root.ListView.view.currentIndex === index

            height: 24
            width: 24

            radius: 360
            color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_BRIGHT)
        }
    }

    Image {
        visible: root.hasSubLevel
        source: Paths.image("common/icons/list_arrow.png")

        anchors.right: parent.right
        anchors.rightMargin: root.ListView.view.rightMargin
        anchors.verticalCenter: parent.verticalCenter

        layer.enabled: true
        layer.effect: ColorOverlay {
            color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_TEXT)
        }
    }

    ACXCheckBox {
        id: checkBox
        visible: root.isCheckBox

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: root.ListView.view.rightMargin

        Component.onCompleted: {
            if (root.isCheckBox) {
                checked = Qt.binding(function() {
                    return eval(checkedExpression);
                })
            }
        }

        onCheckedChanged: {
            if (root.isCheckBox) {
                eval(checkedExpression + "=" + checked)
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (root.isCheckBox) {
                checkBox.checked = !checkBox.checked
            } else {
                root.triggered()
            }
        }
    }

}

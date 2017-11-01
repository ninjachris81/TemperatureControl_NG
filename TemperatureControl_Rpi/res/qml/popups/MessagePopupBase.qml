import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import "qrc:/qml/Paths.js" as Paths

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/label"

Item {
    id: root

    signal postResult(int result)
    signal handleChoice(int choiceIndex)

    readonly property int themeInfo: 0
    readonly property int themeWarning: 1
    readonly property int themeError: 2

    property alias title: titleLabel.text
    property alias prompt: prompt.text
    property int theme: themeInfo

    property int buttonCount: 2

    property alias label1: button1.label
    property alias label2: button2.label
    property alias label3: button3.label

    readonly property color textColor: theme===themeInfo | theme===themeError ? "white" :  VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_TEXT)

    Rectangle {
        id: headerRect
        width: parent.width - (10)
        anchors.horizontalCenter: parent.horizontalCenter

        height: 80

        radius: 2

        gradient: Gradient {
            GradientStop { position: 0.0; color: theme===themeInfo ? VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_DARK) : theme===themeWarning ? VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_WARN) : VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_ERROR) }
            GradientStop { position: 1.0; color: theme===themeInfo ? VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_BRIGHT) : theme===themeWarning ? VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_WARN) : VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_ERROR) }
        }

        ACXLabel {
            id: titleLabel

            color: root.textColor

            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font.pointSize: 24
        }

        Image {
            anchors.right: parent.right
            anchors.rightMargin: 20

            anchors.verticalCenter: parent.verticalCenter

            source: theme===themeInfo ? Paths.image("common/popup/icons/info.png") : theme===themeWarning ? Paths.image("common/popup/icons/warning.png") : Paths.image("common/popup/icons/error.png")

            layer.enabled: root.textColor!=="white"
            layer.effect: ColorOverlay {
                color: root.textColor
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.bottomMargin: 20
        anchors.topMargin: headerRect.height + 20

        ACXLabel {
            id: prompt

            text: ""

            Layout.fillWidth: true
            Layout.preferredHeight: 120
            //Layout.fillHeight: true

            wrapMode: Text.Wrap

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 80

            spacing: 10

            ACXButton {
                id: button1
                Layout.minimumHeight: 60
                Layout.minimumWidth: 100
                Layout.fillWidth: true

                label.text: qsTr("Cancel")

                onTriggered: root.handleChoice(1)
            }
            ACXButton {
                id: button2
                Layout.minimumHeight: 60
                Layout.minimumWidth: 100
                Layout.fillWidth: true

                visible: root.buttonCount>1

                label.text: qsTr("More")

                onTriggered: root.handleChoice(2)
            }
            ACXButton {
                id: button3
                Layout.minimumHeight: 60
                Layout.minimumWidth: 100
                Layout.fillWidth: true

                visible: root.buttonCount>2

                label.text: qsTr("OK")

                onTriggered: root.handleChoice(3)
            }
        }
    }
}

import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/Paths.js" as Paths

Item {
    id: root

    property alias model: buttonRepeater.model
    property alias content: stackLayout.children
    property alias currentIndex: stackLayout.currentIndex

    property int buttonBarTopMargin: 0
    property int buttonBarBottomMargin: 0

    property color backgroundColor

    RowLayout {
        anchors.fill: parent

        spacing: 0

        ColumnLayout {
            //ACXItemTracer{}

            Layout.preferredWidth: 60
            Layout.preferredHeight: 340
            Layout.fillHeight: true
            Layout.topMargin: root.buttonBarTopMargin
            Layout.bottomMargin: root.buttonBarBottomMargin

            spacing: 0

            Repeater {
                id: buttonRepeater

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumHeight: 100

                    ACXVTabBarButton {
                        anchors.fill: parent
                        iconSource: Paths.image(liIcon)
                        iconColor: liColor
                        isCurrentItem: index===root.currentIndex
                        isLastItem: index===buttonRepeater.count-1
                        currentIndex: root.currentIndex

                        backgroundColor: root.backgroundColor

                        onTriggered: stackLayout.currentIndex = index
                    }
                }
            }
        }

        StackLayout {
            id: stackLayout

            Layout.fillHeight: true
            Layout.preferredHeight: 340
            Layout.fillWidth: true
            Layout.preferredWidth: 720

            currentIndex: 0
        }
    }
}

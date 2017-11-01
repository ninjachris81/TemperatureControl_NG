import QtQuick 2.8
import QtQuick.Layouts 1.3

Item {
    id: root

    property int currentIndex: 0

    readonly property int itemHeight: 58

    property alias model: repeater.model
    property alias count: repeater.count
    property alias columnSpacing: gridView.columnSpacing
    property alias rowSpacing: gridView.rowSpacing

    function itemAt(index) {
        return repeater.itemAt(index);
    }

    property bool showDivider: false

    property bool isHorizontal: false

    GridLayout {
        id: gridView

        property alias itemHeight: root.itemHeight

        columnSpacing: root.isHorizontal ? 40 : 0

        anchors.fill: parent

        rows: root.isHorizontal ? 1 : repeater.count
        columns: root.isHorizontal ? repeater.count : 1

        //ACXItemTracer {}

        Repeater {
            id: repeater

            ACXRadioButton {
                text: modelData

                isHorizontal: root.isHorizontal

                //anchors.left: !root.isHorizontal ? parent.left : undefined
                //anchors.right: !root.isHorizontal ? parent.right : undefined

                Layout.fillHeight: true
                Layout.fillWidth: true

                checked: index===root.currentIndex

                showDivider: root.showDivider && !root.isHorizontal

                onCheckedChanged: {
                    if (checked) root.currentIndex = index
                }
            }
        }
    }
}

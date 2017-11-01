import QtQuick 2.0
import QtQuick.Controls 2.2

import de.tempcontrol 1.0

import "qrc:/qml/components/acx/label"

ListView {
    id: root

    signal triggered(int index, var triggerParams)
    signal navigateTo(int screenIndex)

    property int rowHeight: 75
    property alias scrollIndicatorWidth: vScrollIndicator.width
    property int leftMargin: 50
    property int rightMargin: 50
    property bool showRadioButton: false
    property bool disableScroll: false

    property bool showEmpty: root.count===0
    property string emptyMessage

    snapMode: ListView.SnapToItem
    //boundsBehavior: Flickable.OvershootBounds

    ScrollIndicator.vertical: ACXScrollIndicator {
        id: vScrollIndicator
        visible: !root.disableScroll && contentHeight > root.height
    }

    delegate: ACXListViewDelegate {
    }

    clip: true

    onCurrentIndexChanged: {
        root.positionViewAtIndex(currentIndex, ListView.Center)
    }

    ACXLabel {
        visible: root.showEmpty && root.emptyMessage

        anchors.centerIn: parent

        text: root.emptyMessage
    }

}

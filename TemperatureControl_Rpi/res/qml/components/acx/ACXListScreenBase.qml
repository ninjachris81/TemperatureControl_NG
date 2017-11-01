import QtQuick 2.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"

ACXScreenBase {
    id: root

    property alias currentIndex: listView.currentIndex
    property alias count: listView.count
    property alias model: listView.model
    property alias view: listView
    property alias showRadioButton: listView.showRadioButton

    property alias emptyMessage: listView.emptyMessage

    signal triggered(int index, var triggerParams)

    function positionViewAtIndex(delayed) {
        console.log("Positioning at " + listView.currentIndex)
        if (delayed) {
            delayedPositionTimer.start()
        } else {
            listView.positionViewAtIndex(listView.currentIndex, ListView.Center);
        }
    }

    Timer {
        id: delayedPositionTimer

        repeat: false
        running: false

        interval: 500

        onTriggered: positionViewAtIndex(false)
    }

    ACXListView {
        id: listView

        anchors.fill: parent

        leftMargin: root.menuLabelLeftMargin
        anchors.leftMargin: root.menuLeftMargin

        currentIndex: 0

        anchors.rightMargin: root.hasNextScreen ? root.menuRightMargin : 0

        onNavigateTo: {
            pushStack(screenIndex);
        }

        onTriggered: {
            root.triggered(index, triggerParams)
        }
    }

    Component.onCompleted: {
        if (root.showRadioButton) {
            positionViewAtIndex(false);
        }

        if (listView.count===0) root.nextScreen=ScreenNames.SCREEN_INVALID
    }
}

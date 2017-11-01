import QtQuick 2.0

import de.tempcontrol 1.0

Item {
    id: root

    property var triggerParams

    signal triggered

    height: visible ? ListView.view.rowHeight : 0
    width: ListView.view.width - ListView.view.scrollIndicatorWidth

    onTriggered: {
        console.log("clicked " + index)

        var i =  ScreenNames.SCREEN_INVALID;
        if (typeof(liScreenIndex) !== "undefined") i = liScreenIndex;

        if (i!==ScreenNames.SCREEN_INVALID) {
            ListView.view.navigateTo(i)
        } else {
            ListView.view.triggered(index, triggerParams)
        }
    }

}

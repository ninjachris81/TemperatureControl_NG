import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import "qrc:/qml/Paths.js" as Paths

ScrollIndicator {
    id: root

    //policy: ScrollBar.AsNeeded

    orientation: Qt.Vertical

    width: 16

    background: BorderImage {
        source: Paths.image("common/scrollbar/scrollbar_small/scrollbar_bg.png")
        border.left: 2; border.top: 1
        border.right: 2; border.bottom: 1
        width: root.width
    }

    contentItem: BorderImage {
        id: handle
        source: Paths.image("common/scrollbar/scrollbar_small/scrollbar.png")
        border.left: 0; border.top: 7
        border.right: 0; border.bottom: 7
        width: root.width - (border.left + border.right)

        onHeightChanged: {
            if (height<30) height = 30;
        }

        //ACXItemTracer {}
    }
}

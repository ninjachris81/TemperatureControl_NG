import QtQuick 2.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/label"

ACXLabel {
    id: timeLabel

    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter

    text: Qt.formatTime(TimeServiceManager.currentDateTime, TimeServiceManager.currentTimeFormat)

    font.pointSize: 13
    color: "white"
}

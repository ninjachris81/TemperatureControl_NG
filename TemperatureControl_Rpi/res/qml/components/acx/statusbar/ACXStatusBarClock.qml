import QtQuick 2.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/label"

ACXLabel {
    id: timeLabel

    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter

    text: Qt.formatDateTime(LocalConfig.currentDateTime)

    //font.pointSize: 18
    color: "black"

    Component.onCompleted: {
        console.log(LocalConfig.currentDateTime + "bw")
    }
}

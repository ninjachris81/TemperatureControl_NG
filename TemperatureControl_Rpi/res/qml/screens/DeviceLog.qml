import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import de.tempcontrol 1.0

import "qrc:/qml/."
import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/button"
import "qrc:/qml/components/acx/label"

import "qrc:/qml/Paths.js" as Paths
import "qrc:/qml/components/acx/ACXStackViewParams.js" as ACXStackViewParams

ACXScreenBase {
    id: root

    Flickable {
        id: flickable

        anchors.fill: parent
        anchors.leftMargin: menuLeftMargin

        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AlwaysOn
        }

        TextArea {
            anchors.fill: parent

            readOnly: true

            text: DeviceLog.log
        }
    }
}

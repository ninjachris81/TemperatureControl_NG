import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/Paths.js" as Paths

Item {
    id: root

    property alias value: progressBar.value
    property alias from: progressBar.from
    property alias to: progressBar.to
    property alias indeterminate: progressBar.indeterminate

    ProgressBar {
        id: progressBar
        anchors.fill: parent

        visible: false
    }

    BorderImage {
        id: mask
        source: Paths.image("common/progressbar/progress_bar_bg.png")
        border.left: 44; border.top: 0
        border.right: 24; border.bottom: 0

        anchors.fill: parent
    }

    OpacityMask {
        anchors.fill: parent
        source: progressBar
        maskSource: mask
    }

}

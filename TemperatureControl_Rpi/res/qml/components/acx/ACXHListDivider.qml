import QtQuick 2.0

import "qrc:/qml/Paths.js" as Paths

BorderImage {
    id: root
    source: Paths.image("common/divider/divider.png")

    anchors.left: parent ? parent.left : undefined
    anchors.right: parent ? parent.right : undefined

    height: visible ? 2 : 0
    border.left: 127; border.top: 0
    border.right: 127; border.bottom: 0
}

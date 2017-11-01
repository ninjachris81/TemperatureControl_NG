import QtQuick 2.8

import "qrc:/qml/DefaultStyle.js" as DefaultStyle

Text {
    id: root

    font.family: DefaultStyle.fontFamily
    font.pointSize: DefaultStyle.fontSize
    color: DefaultStyle.fontColor

}

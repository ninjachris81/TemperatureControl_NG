import QtQuick 2.8

import de.tempcontrol 1.0

import "qrc:/qml/DefaultStyle.js" as DefaultStyle

TextEdit {
    id: root

    readOnly: true

    textFormat: Text.RichText

    font.family: DefaultStyle.fontFamily
    font.pointSize: DefaultStyle.fontSize
    color: DefaultStyle.fontColor

    property string leftPart: ""
    property string rightPart: ""

    property color leftColor: color
    property color rightColor: color

    text: "<table width='100%'><tr><td align='left'>" + (leftColor ? "<font color='" + leftColor + "'>" : "") + leftPart + (leftColor ? "</font>" : "") + (leftPart ? ":" : "") + "</td><td align='right'>" + (rightColor ? "<font color='" + rightColor + "'>" : "") + rightPart + (rightColor ? "</font>" : "") + "</td></tr></table>"

}

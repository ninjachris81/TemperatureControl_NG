/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Virtual Keyboard module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.VirtualKeyboard 2.1

import "qrc:/qml/components/acx/speller"

KeyboardLayoutLoader {
    property bool secondPage
    onVisibleChanged: if (!visible) secondPage = false
    sourceComponent: secondPage ? page2 : page1
    Component {
        id: page1
        KeyboardLayout {
            keyWeight: 160
            KeyboardRow {
                Key {
                    key: Qt.Key_1
                    text: "1"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_2
                    text: "2"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_3
                    text: "3"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_4
                    text: "4"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_5
                    text: "5"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_6
                    text: "6"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_7
                    text: "7"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_8
                    text: "8"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_9
                    text: "9"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_0
                    text: "0"
                    showPreview: false
                }
            }
            KeyboardRow {
                FillerKey {
                    weight: 56
                }
                Key {
                    key: Qt.Key_At
                    text: "@"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_NumberSign
                    text: "#"
                    showPreview: false
                }
                Key {
                    key:  Qt.Key_Percent
                    text: "%"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Ampersand
                    text: "&"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Asterisk
                    text: "*"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Minus
                    text: "-"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Plus
                    text: "+"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_ParenLeft
                    text: "("
                    showPreview: false
                }
                Key {
                    key: Qt.Key_ParenRight
                    text: ")"
                    showPreview: false
                }
            }
            KeyboardRow {
                keyWeight: 156
                Key {
                    displayText: "1/2"
                    functionKey: true
                    onClicked: secondPage = !secondPage
                }
                Key {
                    key: Qt.Key_Exclam
                    text: "!"
                    showPreview: false
                }
                Key {
                    key:  Qt.Key_QuoteDbl
                    text: '"'
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Less
                    text: "<"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Greater
                    text: ">"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Apostrophe
                    text: "'"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Colon
                    text: ":"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Semicolon
                    text: ";"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Slash
                    text: "/"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Question
                    text: "?"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Period
                    text: "."
                    alternativeKeys: ".,"
                    showPreview: false
                }
            }
            KeyboardRow {
                keyWeight: 154
                FillerKey {
                    weight: 130
                }
                SymbolModeKey {
                    weight: 200
                    displayText: "ABC"
                    showPreview: false
                }
                SpaceKey {
                    weight: 500
                }
                EnterKey {
                    weight: 300
                    displayText: "OK"
                }
            }
        }
    }
    Component {
        id: page2
        KeyboardLayout {
            keyWeight: 160
            KeyboardRow {
                Key {
                    key: Qt.Key_AsciiTilde
                    text: "~"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Agrave
                    text: "`"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Bar
                    text: "|"
                    showPreview: false
                }
                Key {
                    key: 0x7B
                    text: "·"
                    showPreview: false
                }
                Key {
                    key: 0x221A
                    text: "√"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_division
                    text: "÷"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_multiply
                    text: "×"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_onehalf
                    text: "½"
                    showPreview: false
                    alternativeKeys: "¼⅓½¾⅞"
                }
                Key {
                    key: Qt.Key_BraceLeft
                    text: "{"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_BraceRight
                    text: "}"
                    showPreview: false
                }
            }
            KeyboardRow {
                FillerKey {
                    weight: 56
                }
                Key {
                    key: Qt.Key_Dollar
                    text: "$"
                    showPreview: false
                }
                Key {
                    key: 0x20AC
                    text: "€"
                    showPreview: false
                }
                Key {
                    key: 0xC2
                    text: "£"
                    showPreview: false
                }
                Key {
                    key: 0xA2
                    text: "¢"
                    showPreview: false
                }
                Key {
                    key: 0xA5
                    text: "¥"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Equal
                    text: "="
                    showPreview: false
                }
                Key {
                    key: Qt.Key_section
                    text: "§"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_BracketLeft
                    text: "["
                    showPreview: false
                }
                Key {
                    key: Qt.Key_BracketRight
                    text: "]"
                    showPreview: false
                }
            }
            KeyboardRow {
                keyWeight: 156
                Key {
                    displayText: "2/2"
                    functionKey: true
                    onClicked: secondPage = !secondPage
                }
                Key {
                    key: Qt.Key_Underscore
                    text: "_"
                    showPreview: false
                }
                Key {
                    key: 0x2122
                    text: '™'
                    showPreview: false
                }
                Key {
                    key: 0x00AE
                    text: '®'
                    showPreview: false
                }
                Key {
                    key: Qt.Key_guillemotleft
                    text: '«'
                    showPreview: false
                }
                Key {
                    key: Qt.Key_guillemotright
                    text: '»'
                    showPreview: false
                }
                Key {
                    key: 0x201C
                    text: '“'
                    showPreview: false
                }
                Key {
                    key: 0x201D
                    text: '”'
                    showPreview: false
                }
                Key {
                    key: Qt.Key_Backslash
                    text: "\\"
                    showPreview: false
                }
                Key {
                    key: Qt.Key_AsciiCircum
                    text: "^"
                    showPreview: false
                }
            }
            KeyboardRow {
                keyWeight: 154
                FillerKey {
                    weight: 130
                }
                SymbolModeKey {
                    weight: 200
                    displayText: "ABC"
                }
                SpaceKey {
                    weight: 500
                }
                EnterKey {
                    weight: 300
                    displayText: "OK"
                }
            }
        }
    }
}

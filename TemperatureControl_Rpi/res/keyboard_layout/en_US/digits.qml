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

import "qrc:/qml/components/acx/label"
import "qrc:/qml/components/acx/speller"

KeyboardLayout {
    inputMethod: PlainInputMethod {}
    inputMode: InputEngine.Numeric

    readonly property color textLabelColor: "#80FFFFFF"

    KeyboardColumn {
        Layout.fillWidth: false
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: height
        KeyboardRow {
            Key {
                key: Qt.Key_7
                text: "7"
                showPreview: false
                ACXLabel {
                    visible: ACXSpellerContainer.showTextLabels
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 24
                    font.pointSize: 10
                    color: textLabelColor
                    text: "PQRS"
                }
            }
            Key {
                key: Qt.Key_8
                text: "8"
                showPreview: false
                ACXLabel {
                    visible: ACXSpellerContainer.showTextLabels
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 24
                    font.pointSize: 10
                    color: textLabelColor
                    text: "TUV"
                }
            }
            Key {
                key: Qt.Key_9
                text: "9"
                showPreview: false
                ACXLabel {
                    visible: ACXSpellerContainer.showTextLabels
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 24
                    font.pointSize: 10
                    color: textLabelColor
                    text: "WXYZ"
                }
            }
            //BackspaceKey {}
        }
        KeyboardRow {
            Key {
                key: Qt.Key_4
                text: "4"
                showPreview: false
                ACXLabel {
                    visible: ACXSpellerContainer.showTextLabels
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 24
                    font.pointSize: 10
                    color: textLabelColor
                    text: "GHI"
                }
            }
            Key {
                key: Qt.Key_5
                text: "5"
                showPreview: false
                ACXLabel {
                    visible: ACXSpellerContainer.showTextLabels
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 24
                    font.pointSize: 10
                    color: textLabelColor
                    text: "JKL"
                }
            }
            Key {
                key: Qt.Key_6
                text: "6"
                showPreview: false
                ACXLabel {
                    visible: ACXSpellerContainer.showTextLabels
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 24
                    font.pointSize: 10
                    color: textLabelColor
                    text: "MNO"
                }
            }
            /*
            Key {
                text: " "
                displayText: "\u2423"
                repeat: true
                showPreview: false
                key: Qt.Key_Space
            }*/
        }
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

                ACXLabel {
                    visible: ACXSpellerContainer.showTextLabels
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 24
                    font.pointSize: 10
                    color: textLabelColor
                    text: "ABC"
                }
            }
            Key {
                key: Qt.Key_3
                text: "3"
                showPreview: false

                ACXLabel {
                    visible: ACXSpellerContainer.showTextLabels
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 24
                    font.pointSize: 10
                    color: textLabelColor
                    text: "DEF"
                }
            }
        }
        KeyboardRow {
            /*
            ChangeLanguageKey {
                customLayoutsOnly: true
            }*/
            /*
            HideKeyboardKey {
                onClicked: ACXSpellerContainer.cancelInput()
            }*/

            Key {
                key: Qt.Key_0
                text: "0"
                showPreview: false
                weight: 175
            }
            /*
            Key {
                // The decimal key, if it is not "," then we fallback to
                // "." in case it is an unhandled different result
                key: Qt.locale().decimalPoint === "," ? Qt.Key_Comma : Qt.Key_Period
                text: Qt.locale().decimalPoint === "," ? "," : "."
            }*/
            EnterKey {
                weight: 425
                displayText: "OK"
            }
        }
    }
}

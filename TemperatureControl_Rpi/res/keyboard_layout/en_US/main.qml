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
import QtQuick.VirtualKeyboard 2.1

import "qrc:/qml/components/acx/speller"

KeyboardLayout {
    inputMode: InputEngine.Latin
    keyWeight: 160

    KeyboardRow {
        Key {
            key: Qt.Key_Q
            text: "q"
            showPreview: false
        }
        Key {
            key: Qt.Key_W
            text: "w"
            showPreview: false
        }
        Key {
            key: Qt.Key_E
            text: "e"
            alternativeKeys: "êeëèé"
            showPreview: false
        }
        Key {
            key: Qt.Key_R
            text: "r"
            alternativeKeys: "ŕrř"
            showPreview: false
        }
        Key {
            key: Qt.Key_T
            text: "t"
            alternativeKeys: "ţtŧť"
            showPreview: false
        }
        Key {
            key: Qt.Key_Y
            text: "y"
            alternativeKeys: "ÿyýŷ"
            showPreview: false
        }
        Key {
            key: Qt.Key_U
            text: "u"
            alternativeKeys: "űūũûüuùú"
            showPreview: false
        }
        Key {
            key: Qt.Key_I
            text: "i"
            alternativeKeys: "îïīĩiìí"
            showPreview: false
        }
        Key {
            key: Qt.Key_O
            text: "o"
            alternativeKeys: "œøõôöòóo"
            showPreview: false
        }
        Key {
            key: Qt.Key_P
            text: "p"
            showPreview: false
        }
        //BackspaceKey {}
    }
    KeyboardRow {
        FillerKey {
            weight: 56
        }
        Key {
            key: Qt.Key_A
            text: "a"
            alternativeKeys: "aäåãâàá"
            showPreview: false
        }
        Key {
            key: Qt.Key_S
            text: "s"
            alternativeKeys: "šsşś"
            showPreview: false
        }
        Key {
            key: Qt.Key_D
            text: "d"
            alternativeKeys: "dđď"
            showPreview: false
        }
        Key {
            key: Qt.Key_F
            text: "f"
            showPreview: false
        }
        Key {
            key: Qt.Key_G
            text: "g"
            alternativeKeys: "ġgģĝğ"
            showPreview: false
        }
        Key {
            key: Qt.Key_H
            text: "h"
            showPreview: false
        }
        Key {
            key: Qt.Key_J
            text: "j"
            showPreview: false
        }
        Key {
            key: Qt.Key_K
            text: "k"
            showPreview: false
        }
        Key {
            key: Qt.Key_L
            text: "l"
            alternativeKeys: "ĺŀłļľl"
            showPreview: false
        }
        Key {
            key: Qt.Key_Apostrophe
            text: "'"
            showPreview: false
        }
    }
    KeyboardRow {
        keyWeight: 156
        ShiftKey {
            weight: 204
        }
        Key {
            key: Qt.Key_Z
            text: "z"
            alternativeKeys: "zžż"
            showPreview: false
        }
        Key {
            key: Qt.Key_X
            text: "x"
            showPreview: false
        }
        Key {
            key: Qt.Key_C
            text: "c"
            alternativeKeys: "çcċčć"
            showPreview: false
        }
        Key {
            key: Qt.Key_V
            text: "v"
            showPreview: false
        }
        Key {
            key: Qt.Key_B
            text: "b"
            showPreview: false
        }
        Key {
            key: Qt.Key_N
            text: "n"
            alternativeKeys: "ņńnň"
            showPreview: false
        }
        Key {
            key: Qt.Key_M
            text: "m"
            showPreview: false
        }
        Key {
            key: Qt.Key_Comma
            text: ","
            showPreview: false
        }
        Key {
            key: Qt.Key_Period
            text: "."
            showPreview: false
        }
    }
    KeyboardRow {
        keyWeight: 154
        /*
        HideKeyboardKey {
            weight: 200
            onClicked: ACXSpellerContainer.cancelInput()
        }*/
        FillerKey {
            weight: 130
        }

        SymbolModeKey {
            weight: 200
        }
        /*
        ChangeLanguageKey {
            weight: 154
        }
        HandwritingModeKey {
            weight: 154
        }*/
        SpaceKey {
            weight: 500
        }
        EnterKey {
            weight: 300
            displayText: "OK"
        }
        /*
        Key {
            key: 0xE000
            text: ":-)"
            alternativeKeys: [ ";-)", ":-)", ":-D", ":-(", "<3" ]
        }*/
    }
}

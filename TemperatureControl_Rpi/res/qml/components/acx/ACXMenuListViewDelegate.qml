import QtQuick 2.0

import de.tempcontrol 1.0

ACXListViewDelegateBase {
    id: root

    ACXMenuButton {
        height: 80
        width: root.width

        iconSource: ""
        label: liLabel==="" ? ScreenNames.resolveScreenName(liScreenIndex) : liLabel

        onTriggered: {
            root.triggered()
        }
    }

}

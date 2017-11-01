pragma Singleton
import QtQuick 2.0

Item {
    id: root

    readonly property int resultOK: 1
    readonly property int resultCancel: 2
    readonly property int resultWrong: 3

    property var popupContainer

    function showPasswordPopup(title, expectedPin, returnFunc, params) {
        return popupContainer.showPasswordPopup(title, expectedPin, returnFunc, params);
    }

    function showMessagePopup(prompt, popupName, returnFunc, title, valueFunc, params) {
        return popupContainer.showMessagePopup(prompt, popupName, returnFunc, title, valueFunc, params);
    }

    function closePopup(id) {
        return popupContainer.closePopup(id);
    }

    function showSpellerPopup(previewText, currentText, returnFunc, params) {
        return popupContainer.showSpellerPopup(previewText, currentText, returnFunc, params);
    }

}

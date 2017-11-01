import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/popups"
import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/label"
import "qrc:/qml/components/acx/speller"

import "qrc:/qml/Paths.js" as Paths

StackView {
    id: root

    visible: root.depth>0

    pushEnter: Transition {}
    pushExit: Transition {}
    popEnter: Transition {}
    popExit: Transition {}

    function showPasswordPopup(title, thisExpectedPin, returnFunc, params) {
        console.log("Showing Password Popup");
        var popupItem = enterPasswordComp.createObject();
        popupItem.expectedPin = thisExpectedPin;
        popupItem.resultFunc = returnFunc;
        popupItem.previewText = title;
        popupItem.id = new Date().getTime();

        if (params) {
            for (var key in params) {
                console.log("Applying param " + key)
                if (popupItem.hasOwnProperty(key)) {
                    popupItem[key] = params[key]
                } else {
                    console.warn("Property " + key + " cannot be applied")
                }
            }
        }

        root.push(popupItem, StackView.Immediate);

        return popupItem.id;
    }

    function showMessagePopup(prompt, popupName, returnFunc, title, valueFunc, params) {
        var cis = "qrc:/qml/popups/" + popupName + ".qml";
        var messageItem = popupComp.createObject();
        messageItem.prompt = prompt;
        messageItem.resultFunc = returnFunc;
        messageItem.contentItemSource = cis;
        messageItem.id = new Date().getTime();

        if (title) messageItem.title = title;
        if (valueFunc) messageItem.valueFunc = valueFunc;
        if (params) messageItem.params = params;

        console.log("Pushing new message " + messageItem + " (" + prompt + ", " + params + ")");
        root.push(messageItem, StackView.Immediate);

        return messageItem.id;
    }

    function showSpellerPopup(previewText, currentText, returnFunc, params) {
        showMessagePopup(previewText, "SpellerPopup", returnFunc, currentText, undefined, params);
    }

    function closePopup(id) {

        var foundItem = root.find(function(thisItem, thisIndex) {
            return thisItem.id===id
        }, StackView.DontLoad)

        if (foundItem) {
            var itemsToRepush = [];

            foundItem.isPopped = true;

            for (var i=0;i<root.depth;i++) {
                var tmpItem = root.get(i, StackView.DontLoad);
                console.log(i)
                console.log(tmpItem + ", " + tmpItem.isPopped)
                if (!tmpItem.isPopped) itemsToRepush.push(tmpItem);
            }

            console.log("Re-pushing items: " + itemsToRepush);

            root.clear();

            if (itemsToRepush.length>0) {
                itemsToRepush.forEach(function(thisItem) {
                    console.log("Pushing " + thisItem.prompt);
                    root.push(thisItem);
                });
            }
            return true;
        } else {
            console.warn("Popup with ID " + id + " not found")
            return false;
        }
    }

    QtObject {
        id: _internal

        function popPopup(item, resultFunc, result, text) {
            item.isPopped = true;

            var foundItem = root.find(function(thisItem, thisIndex) {
                return item===thisItem
            }, StackView.DontLoad)

            if (foundItem) {
                var itemsToRepush = [];

                console.log("Depth: " + root.depth)

                for (var i=0;i<root.depth;i++) {
                    var tmpItem = root.get(i, StackView.DontLoad);
                    console.log(i)
                    console.log(tmpItem + ", " + tmpItem.isPopped)
                    if (!tmpItem.isPopped) itemsToRepush.push(tmpItem);
                }

                console.log("Re-pushing items: " + itemsToRepush);

                root.clear();

                if (itemsToRepush.length>0) {
                    itemsToRepush.forEach(function(thisItem) {
                        console.log("Pushing " + thisItem.prompt);
                        root.push(thisItem);
                    });
                }
            } else {
                console.warn("Item not found: " + item.prompt)
                //root.pop();
            }

            console.log("Depth: " + root.depth);
            if (root.depth>0) {
                console.log("Active is " + root.get(root.depth-1).prompt);
                console.log("Active is " + root.get(root.depth-1));
                console.log("Current is " + root.currentItem);
                console.log("Current is " + root.currentItem.visible);
                console.log("Current is " + root.currentItem.z);
                console.log("Current is " + root.visible);
            }

            console.log("TEXT: " + text)

            resultFunc(result, text);
        }
    }

    Component {
        id: enterPasswordComp

        EnterPassword {
            id: enterPassword

            property bool isPopped: false
            property int id

            onPostResult: {
                _internal.popPopup(enterPassword, resultFunc, result, text);
            }

            onCanceledInput: {
                _internal.popPopup(enterPassword, resultFunc, ACXPopupManager.resultCancel);
            }

            StackView.onRemoved: destroy()      // manually created -> so destroy manually
        }
    }

    Component {
        id: popupComp

        Item {
            id: popupRoot

            property bool isPopped: false
            property int id

            property var resultFunc
            property var valueFunc
            property string prompt: ""
            property string title: ""
            property var params

            property alias contentItemSource: contentItemLoader.source

            //anchors.fill: parent

            onTitleChanged: {
                if (title && contentItemLoader.item) contentItemLoader.item.title = title;
            }

            onPromptChanged: {
                if (contentItemLoader.item) contentItemLoader.item.prompt = prompt;
            }

            onValueFuncChanged: {
                if (contentItemLoader.item && contentItemLoader.item.hasOwnProperty("valueFunc")) contentItemLoader.item.valueFunc = valueFunc;
            }

            onParamsChanged: {
                if (params && contentItemLoader.item) {
                    for (var key in params) {
                        console.log("Applying param " + key)
                        if (contentItemLoader.item.hasOwnProperty(key)) {
                            contentItemLoader.item[key] = params[key]
                        } else {
                            console.warn("Property " + key + " cannot be applied")
                        }
                    }
                }
            }

            Rectangle {
                anchors.fill: parent
                color: "white"
                opacity: 0.6
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    console.log("Clicked outside of Popup")
                }
            }

            BorderImage {
                source: Paths.image("common/popup/popup_bg.png")
                border.left: 6; border.top: 4
                border.right: 6; border.bottom: 13

                anchors.centerIn: parent
                width: 600
                height: 360

                Loader {
                    id: contentItemLoader
                    anchors.fill: parent

                    onItemChanged: {
                        if (popupRoot.title) item.title = popupRoot.title
                        if (popupRoot.valueFunc && item.hasOwnProperty("valueFunc")) item.valueFunc = popupRoot.valueFunc
                        if (popupRoot.params) {
                            console.log("Applying params " + popupRoot.params)
                            item.apply(popupRoot.params)
                        }
                        item.prompt = popupRoot.prompt
                    }
                }

                Connections {
                    target: contentItemLoader.item

                    onPostResult: {
                        var tmpText
                        if (contentItemLoader.item.hasOwnProperty("text")) {
                            console.log("Using Text property");
                            tmpText = contentItemLoader.item.text;
                        }

                        _internal.popPopup(popupRoot, popupRoot.resultFunc, result, tmpText);
                    }
                }
            }

            StackView.onRemoved: {
                if (popupRoot.isPopped) {
                    console.log("Destroying " + popupRoot + " (" + prompt + ")")
                    destroy()      // manually created -> so destroy manually
                }
            }
        }
    }
}

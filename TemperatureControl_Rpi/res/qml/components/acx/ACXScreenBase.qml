import QtQuick 2.8
import QtQuick.Controls 2.2

import de.tempcontrol 1.0

import "qrc:/qml/components/acx/button"

Item {
    property var stackView

    property int screenIndex: ScreenNames.SCREEN_INVALID
    property string name: ""            // dont bind this to screenIndex, since the stackView will set this - might be different !

    property bool showHome: true

    property int jumpBackIndex: ScreenNames.SCREEN_INVALID

    property int prevScreen: stackView.depth>1 ? stackView.get(stackView.depth-2, true).screenIndex : ScreenNames.SCREEN_INVALID

    property int nextScreen: ScreenNames.SCREEN_INVALID
    readonly property bool hasNextScreen: (nextScreen!==ScreenNames.SCREEN_INVALID && !(isSelectionScreen && nextScreen===ScreenNames.SCREEN_POP))
    property string nextPassword: ""
    property string nextPasswordPrompt: qsTr("Enter Password")
    property int nextPasswordResult
    property string nextDisabledReason: ""
    readonly property bool nextEnabled: nextDisabledReason===""
    property bool nextIsStart: false

    property var pushAction
    property var popAction
    property var leaveAction
    property var abortAction
    property var jumpBackAction

    property bool isProcessScreen: false
    property bool prevScreenWasProcessScreen: stackView.depth>1 ? stackView.get(stackView.depth-2, true).isProcessScreen : false
    property bool isSelectionScreen: false
    property bool isFinishScreen: false

    property bool showAbort: false

    readonly property int menuLeftMargin: 120
    readonly property int menuRightMargin: 136
    readonly property int menuLabelLeftMargin: 50

    signal nextTriggered
    signal popTriggered

    anchors.top: parent ? parent.top : undefined
    anchors.topMargin: homeButton.visible ? 65: 0
    anchors.left: parent ? parent.left : undefined

    //ACXItemTracer {}

    anchors.bottom: parent ? parent.bottom : undefined

    onNextEnabledChanged: {
        console.log("DISABLED REASON: " + root.nextDisabledReason)
        console.log("NEXT ENABLED: " + root.nextEnabled)
    }

    QtObject {
        id: _internal

        property bool executedLeaveAction: false
    }

    StackView.onRemoved:{
        console.log("On Removed - check leave action");
        checkLeaveAction();
    }

    function getPrevScreen() {
        return stackView.depth>1 ? stackView.get(stackView.depth-2, true) : null;
    }

    function checkLeaveAction(screenIndex) {
        if (_internal.executedLeaveAction) return;

        if (typeof(root.leaveAction)==="function") {
            console.log("Executing leave action");
            root.leaveAction(screenIndex);
            console.log("Finished leave action");
        }
        _internal.executedLeaveAction = true
    }

    function pushStack(screenIndex, clearStack, parameters) {
        if (screenIndex===ScreenNames.SCREEN_INVALID) {
            console.warn("Called push stack on INVALID");
        } else if (screenIndex===ScreenNames.SCREEN_POP) {
            popStack();
        } else {
            if (typeof(root.pushAction)==="function") {
                console.log("Executing push action");
                root.pushAction(screenIndex);
                console.log("Finished push action");
            }
            checkLeaveAction(screenIndex);

            root.stackView.pushStack(screenIndex, clearStack, parameters);
        }
    }

    function popStack(isCancel) {
        root.popTriggered();
        if (typeof(root.popAction)==="function") popAction(isCancel);
        checkLeaveAction(ScreenNames.SCREEN_POP);
        root.stackView.pop();
    }

    function goHome() {
        checkLeaveAction(ScreenNames.SCREEN_HOME);
        root.stackView.pushStack(ScreenNames.SCREEN_HOME, true);
    }

    function processAbort() {
        ACXPopupManager.showMessagePopup(qsTr("Would you like to abort the process ?"), "AbortPopup", function(result) {
            switch(result) {
            case ACXPopupManager.resultCancel:
                break;
            case ACXPopupManager.resultOK:
                if (typeof(root.abortAction)==="function") abortAction();
                goHome();
                break;
            }
        })
    }

    onNextTriggered: {
        if (root.nextScreen===ScreenNames.SCREEN_MANUAL_NEXT) return;

        console.log("onNextTriggered @ " + root.name + ", next: " + root.nextScreen)

        if (root.nextScreen!==ScreenNames.SCREEN_INVALID) {
            if (nextPassword) {
                ACXPopupManager.showPasswordPopup(root.nextPasswordPrompt, root.nextPassword, function(result){
                    root.nextPasswordResult = result;

                    switch(result) {
                    case ACXPopupManager.resultOK:
                        pushStack(root.nextScreen);
                        break;
                    case ACXPopupManager.resultWrong:
                        NotificationManager.toastManager.pushToast(ToastManager.TOAST_INVALID_PASSWORD);
                        break;
                    case ACXPopupManager.resultCancel:
                        break;
                    }
                })
            } else {
                pushStack(root.nextScreen);
            }
        }
    }

    ACXNavButton {
        id: backButton
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        z: root.z + 1

        isAbort: root.isProcessScreen || root.showAbort

        //ACXItemTracer {}

        visible: stackView.depth>1 && !root.prevScreenWasProcessScreen

        onTriggered: {
            if (root.isProcessScreen) {
                root.processAbort()
            } else {
                popStack(true)
            }
        }
    }

    ACXNavButton {
        id: forwardButton

        anchors.bottom: parent.bottom
        anchors.right: parent.right

        isForward: true
        isStart: root.nextIsStart

        z: root.z + 1

        enabled: root.nextEnabled

        //ACXItemTracer {}

        visible: root.hasNextScreen && !root.isProcessScreen

        isFinish: root.isFinishScreen

        onTriggered: {
            root.nextTriggered()
        }

        onTriggeredDisabled: {
            NotificationManager.toastManager.pushToast(root.nextDisabledReason)
        }
    }

    ACXHomeButton {
        id: homeButton

        z: root.z + 1

        visible: root.showHome

        anchors.top: parent.top
        anchors.topMargin: -parent.anchors.topMargin

        anchors.left: parent.left
        anchors.leftMargin: -parent.anchors.leftMargin

        //visible: stackView.depth>1
        onTriggered: {
            if (root.isProcessScreen) {
                root.processAbort();
            } else {
                goHome();
            }
        }
    }

    ACXBreadcrumbs {
        id: breadCrumbs

        stackView: root.stackView
        currentScreen: root

        visible: stackView.depth>1

        anchors.top: parent.top
        anchors.topMargin: -parent.anchors.topMargin

        anchors.left: homeButton.right
        anchors.leftMargin: -12

        anchors.right: parent.right

        height: homeButton.height
    }

    //ACXItemTracer {}

    Component.onCompleted: {
        if (root.name==="") {
            console.warn("Screen has no name !");
        }
    }

}

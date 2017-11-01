import QtQuick 2.0
import QtQuick.Controls 2.2

import de.tempcontrol 1.0

import "qrc:/qml/Paths.js" as Paths
import "qrc:/qml/components/acx/ACXStackViewParams.js" as ACXStackViewParams

StackView {
    id: root

    pushEnter: Transition {}
    pushExit: Transition {}
    popEnter: Transition {}
    popExit: Transition {}

    function pushStack(screenIndex, clearStack, parameters) {
        var oldScreenIndex = root.currentItem ? root.currentItem.screenIndex : ScreenNames.SCREEN_INVALID
        var oldJumpBackIndex = root.currentItem ? root.currentItem.jumpBackIndex : ScreenNames.SCREEN_INVALID

        if (screenIndex===ScreenNames.SCREEN_HOME) {
            root.clear();
            clearStack = ACXStackViewParams.clearStackNone;     // skip this, as not needed any more
        }

        if (clearStack===ACXStackViewParams.clearStackCompletely) {
            console.log("clear stack")
            //root.clear();
            root.pop(root.get(0), StackView.Immediate);      // always keep root in stack
        } else if (clearStack===ACXStackViewParams.clearStackJumpBack) {
            var foundItem = root.find(function(item, index) {
                return item.screenIndex===screenIndex;
            })

            if (foundItem) {
                console.log("Pre-Jump depth: " + root.depth)

                root.pop(foundItem, StackView.Immediate);

                if (typeof(foundItem.jumpBackAction)==="function") {
                    console.log("Executing jump back action");
                    foundItem.jumpBackAction(oldScreenIndex);
                }
                console.log("Post-Jump depth: " + root.depth)
            } else {
                console.warn("Could not find item with screenIndex " + screenIndex)
            }
        }

        if (clearStack!==ACXStackViewParams.clearStackJumpBack) {
            root.push(resolveScreenUrl(screenIndex), {stackView: root, screenIndex: screenIndex, name: ScreenNames.resolveScreenName(screenIndex), jumpBackIndex: oldJumpBackIndex}, StackView.Immediate);

            if (parameters) {
                if (typeof(parameters)=="object") {
                    for (var param in parameters) {
                        if (parameters.hasOwnProperty(param)) {
                            if (root.get(root.depth-1).hasOwnProperty(param)) {
                                console.log("Setting param " + param + " to " + parameters[param]);
                                root.get(root.depth-1)[param] = parameters[param];
                            } else {
                                console.warn("Unable to set parameter " + param + " to screen " + root.get(root.depth-1));
                            }
                        }
                    }
                }
            }
        }

    }

    function resolveScreenUrl(screenIndex) {
        return Paths.screen(ScreenNames.resolveScreenUrl(screenIndex) + ".qml");
    }

}

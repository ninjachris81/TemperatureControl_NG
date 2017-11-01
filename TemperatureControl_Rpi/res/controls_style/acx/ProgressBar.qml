import QtQuick 2.8
import QtQuick.Templates 2.2 as T
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/Paths.js" as Paths

/* THIS COMPONENT NEEDS REFACTORING */


T.ProgressBar {
    id: control

    background: Item {

        BorderImage {
            source: Paths.image("common/progressbar/progress_bar_bg.png")
            border.left: 44; border.top: 0
            border.right: 24; border.bottom: 0

            width: control.width
        }
    }

    contentItem: Item {

        BorderImage {
            id: progressIndicator
            source: Paths.image("common/progressbar/progress_bar.png")
            anchors.left: parent.left
            //anchors.leftMargin: 10

            //width: 60 + (parent.width * ((control.width) / (control.width + 28)))
            width: 30 + (control.visualPosition * parent.width * 0.95)
            //width: parent.width

            border.left: 0; border.top: 0
            border.right: 25; border.bottom: 0

            visible: false
            smooth: true

            Behavior on width {
                NumberAnimation {
                    easing.type: Easing.OutCubic
                }
            }
        }

        ColorOverlay {
            anchors.fill: progressIndicator
            source: progressIndicator
            color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_BRIGHT)
        }

        Image {
            id: indeterminateRect
            opacity: 0.5

            visible: control.indeterminate

            x: 0

            source: Paths.image("common/progressbar/progress_bar_indeterminate.png")

            NumberAnimation  {
                id: animateBack
                target: indeterminateRect
                properties: "x"
                from: control.width
                to: 0
                duration: 1500

                onStopped: {
                    animateFwd.start()
                }
           }

            NumberAnimation {
                id: animateFwd
                target: indeterminateRect
                running: true
                properties: "x"
                from: 0
                to: control.width
                duration: 1500

                onStopped: {
                    animateBack.start()
                }
           }
        }

        BorderImage {
            source: Paths.image("common/progressbar/progress_bar_gradient.png")
            width: progressIndicator.width
            anchors.left: progressIndicator.left
            //anchors.leftMargin: progressIndicator.anchors.leftMargin

            //height: parent.height

            border.left: 0; border.top: 0
            border.right: 25; border.bottom: 0
        }
    }


}

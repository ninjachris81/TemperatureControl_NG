import QtQuick 2.0
import QtCharts 2.0
import QtGraphicalEffects 1.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/label"

import "qrc:/qml/Paths.js" as Paths

Item {
    id: root

    readonly property bool flowAnimationActive: flowAnimationBottleDevice | flowAnimationDeviceCar | flowAnimationCarDevice | flowAnimationDevice
    property bool flowAnimationBottleDevice: false
    property bool flowAnimationDeviceCar: false
    property bool flowAnimationCarDevice: false
    property bool flowAnimationDevice: false

    Image {
        visible: flowAnimationActive
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        source: Paths.image("process/process_bg.png")

        AnimatedSprite {
            id: leftAnimation
            source: Paths.animation("process/left.png")

            visible: flowAnimationBottleDevice

            x: 125
            y: 29

            layer.enabled: true
            layer.effect: ColorOverlay {
                color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_BRIGHT)
            }

            frameCount: 12
            frameHeight: height
            frameWidth: width

            width: 99
            height: 62

            interpolate: false

            frameRate: 15
        }

        Rectangle {
            visible: !leftAnimation.visible
            color: "white"
            opacity: 0.7

            x: 100
            y: 80
            width: 60
            height: 80
        }

        AnimatedSprite {
            id: machineAnimation
            source: Paths.animation("process/machine.png")

            visible: flowAnimationDevice

            x: 201
            y: 65

            frameCount: 32
            frameHeight: height
            frameWidth: width

            width: 69
            height: 88

            interpolate: false

            frameRate: 15
        }

        AnimatedSprite {
            id: rightAnimation
            source: Paths.animation("process/right.png")

            visible: flowAnimationCarDevice | flowAnimationDeviceCar

            x: 233
            y: 38

            frameCount: 11
            frameHeight: height
            frameWidth: width

            reverse: flowAnimationCarDevice

            width: 90
            height: 83

            layer.enabled: true
            layer.effect: ColorOverlay {
                color: VariantConfigurationManager.getValue(VariantConfigurationManager.KEY_COLOR_BRIGHT)
            }

            interpolate: false

            frameRate: 15
        }

        Rectangle {
            visible: !rightAnimation.visible
            color: "white"
            opacity: 0.7

            anchors.right: parent.right
            anchors.bottom: parent.bottom

            width: 80
            height: 70
        }

    }


}

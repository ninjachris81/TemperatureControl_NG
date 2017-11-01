pragma Singleton
import QtQuick 2.0


// replace my with Qt Component
QtObject {
    id: root

    property bool animate: false

    property double comboFilterRemaining: 30000
    readonly property double comboFilterLifetime: 75000
    property double comboFilterStatus: comboFilterRemaining / comboFilterLifetime
    readonly property double comboFilterStatusWarn: 0.15
    readonly property double comboFilterStatusError: 0.01
    readonly property bool comboFilterHasWarn: !comboFilterHasError && (comboFilterStatus < comboFilterStatusWarn)
    readonly property bool comboFilterHasError: comboFilterStatus < comboFilterStatusError

    readonly property int internalTankOffset: 600
    readonly property int internalTankWeightMax: 6000
    readonly property int internalTankUsableAmount: (internalTankWeightMax - internalTankOffset) * internalTankStatus
    property double internalTankStatus: 0.7
    readonly property double internalTankStatusWarnHigh: 0.8
    readonly property double internalTankStatusWarnLow: 0.2
    readonly property double internalTankStatusErrorHigh: 0.9
    readonly property double internalTankStatusErrorLow: 0.1

    readonly property bool internalTankFull: internalTankStatus > internalTankStatusErrorHigh
    readonly property bool internalTankEmpty: internalTankStatus < internalTankStatusErrorLow
    readonly property bool internalTankHasWarn: !internalTankHasError && (internalTankStatus > internalTankStatusWarnHigh || internalTankStatus < internalTankStatusWarnLow)
    readonly property bool internalTankHasError: internalTankStatus > internalTankStatusErrorHigh || internalTankStatus < internalTankStatusErrorLow

    property double bottleTemp: 24.732
    property double ambientTemp: 23.132

    property double usedOil: 412

    NumberAnimation on comboFilterRemaining {
        from: comboFilterLifetime
        to: 0
        running: animate
        duration: 20000
        loops: Animation.Infinite
        easing.type: Easing.OutCubic
    }

    NumberAnimation on internalTankStatus {
        from: 1
        to: 0
        running: animate
        duration: 13000
        loops: Animation.Infinite
        easing.type: Easing.InOutQuad
    }
}

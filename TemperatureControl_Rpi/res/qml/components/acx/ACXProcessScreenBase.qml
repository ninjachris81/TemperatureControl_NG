import QtQuick 2.0
import QtCharts 2.0

import de.tempcontrol 1.0

import "qrc:/qml/components/acx"
import "qrc:/qml/components/acx/label"
import "qrc:/qml/processes"

ACXScreenBase {
    id: root

    property bool isServiceProcess: false
    property bool isRoutingProcess: false

    isProcessScreen: true

    pushAction: function() {
        if (isServiceProcess) {
            ReportManager.currentReport.setTime(true)
            ReportManager.currentReport.setValue(ServiceReport.RVK_STATE, ServiceReport.RS_SUCCESS);
        } else if (isRoutingProcess) {
            ReportManager.resetCurrentRoutineReport()
        }
    }

    abortAction: function () {
        if (isServiceProcess) {
            ReportManager.currentReport.setTime(true)
            ReportManager.currentReport.setValue(ServiceReport.RVK_STATE, ServiceReport.RS_ERROR);
            console.log("Fail report")
            ReportManager.failCurrentReport(100)
        }
    }

    readonly property string processResourceChecking: "resourceChecking"
    readonly property string processVacuuming: "vacuuming"
    readonly property string processFlushing: "flushing"
    readonly property string processRfIdPrechecking: "rfidPrechecking"
    readonly property string processRfIdAnalysing: "rfidAnalysing"
    readonly property string processInternalBottleFilling: "internalBottleFilling"
    readonly property string processSystemLeakTesting: "systemLeakTesting"

    Component {
        id: vacuuming

        Vacuuming {}
    }

    Component {
        id: resourceChecking

        ResourceChecking {}
    }

    Component {
        id: flushing

        Flushing{}
    }

    Component {
        id: rfidPrechecking

        RefrigerantIdentificationPrechecking {}
    }

    Component {
        id: rfidAnalysing

        RefrigerantIdentificationAnalysing {}
    }

    Component {
        id: ibFilling

        InternalBottleFilling {}
    }

    Component {
        id: systemLeakTesting

        SystemLeakTesting {}
    }

    states: [
        State {
            name: processResourceChecking
            PropertyChanges {
                target: loader
                sourceComponent: resourceChecking
            }
        },
        State {
            name: processVacuuming
            PropertyChanges {
                target: loader
                sourceComponent: vacuuming
            }
        },
        State {
            name: processFlushing
            PropertyChanges {
                target: loader
                sourceComponent: flushing
            }
        },
        State {
            name: processRfIdPrechecking

            PropertyChanges {
                target: loader
                sourceComponent: rfidPrechecking
            }
        },
        State {
            name: processRfIdAnalysing

            PropertyChanges {
                target: loader
                sourceComponent: rfidAnalysing
            }
        },
        State {
            name: processInternalBottleFilling

            PropertyChanges {
                target: loader
                sourceComponent: ibFilling
            }
        },
        State {
            name: processSystemLeakTesting

            PropertyChanges {
                target: loader
                sourceComponent: systemLeakTesting
            }
        }

    ]

    Loader {
        id: loader
        anchors.fill: parent

    }

    Component.onCompleted: {
        if (isServiceProcess) {
            ReportManager.currentReport.setTime()
        }
    }

    // REMOVE ME IN PROD
    Timer {
        running: true
        interval: 3000
        repeat: false
        onTriggered: nextTriggered()
    }


}

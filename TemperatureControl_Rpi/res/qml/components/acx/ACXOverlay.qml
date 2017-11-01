import QtQuick 2.0

Item {
    anchors.fill: parent

    property string title

    signal forceClose()
    signal navigateTo(int screenIndex)
    signal errorCodeHelp(int errorCode)
    signal errorHelp(int errorType)

}

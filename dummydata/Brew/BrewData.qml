import QtQuick 6.5

QtObject {
    property bool isDesigner: true

    property StateGroup s: any
    function setDesignerParams(stateGroup) {
        s = stateGroup
    }

    function refreshData() {
        refreshDataTimer.start()
    }

    property Timer refreshDataTimer: Timer {
        running: true
        repeat: false
        onTriggered: s.state = "Preview"
        interval: 1000
    }
}

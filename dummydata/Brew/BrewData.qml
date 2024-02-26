import QtQuick 6.5

QtObject {
    property bool isDesigner: true

    function asyncRefreshData(cb) {
        timerCb = cb
        refreshDataTimer.start()
    }

    property var timerCb: () => {}
    property Timer refreshDataTimer: Timer {
        running: true
        repeat: false
        onTriggered: timerCb()
        interval: 1000
    }

    property var caskBodyList: [{
            "cellType": "linkBtn",
            "cellText": "anaconda",
            "fillWidth": false,
            "filterString": "anaconda"
        }, {
            "cellType": "text",
            "cellText": "Distribution of the Python and R programming languages for scientific computing",
            "fillWidth": true,
            "filterString": "anaconda"
        }, {
            "cellType": "text",
            "cellText": "homebrew/tap",
            "fillWidth": false,
            "filterString": "anaconda"
        }, {
            "cellType": "text",
            "cellText": "1.3.5",
            "fillWidth": false,
            "filterString": "anaconda"
        }, {
            "cellType": "checkbox",
            "cellText": "1.3.6",
            "fillWidth": false,
            "onToggled": "anaconda",
            "filterString": "anaconda"
        }]

    property var formulaBodyList: [{
            "cellType": "linkBtn",
            "cellText": "libxext",
            "fillWidth": false,
            "filterString": "libxext"
        }, {
            "cellType": "text",
            "cellText": "X.Org: Library for common extensions to the X11 protocol",
            "fillWidth": true,
            "filterString": "libxext"
        }, {
            "cellType": "text",
            "cellText": "homebrew/tap",
            "fillWidth": false,
            "filterString": "libxext"
        }, {
            "cellType": "text",
            "cellText": "1.3.5",
            "fillWidth": false,
            "filterString": "libxext"
        }, {
            "cellType": "checkbox",
            "cellText": "1.3.6",
            "fillWidth": false,
            "onToggled": "linkBtn",
            "filterString": "libxext"
        }, {
            "cellType": "text",
            "cellText": ".",
            "fillWidth": false,
            "hoverText": "<h3>Used in</h3><p>item 1</p><h3>Used by</h3><p>item 2</p>",
            "filterString": "libxext"
        }]

    property var servicesBodyList: [{
            "cellType": "text",
            "cellText": "unbound",
            "fillWidth": false,
            "filterString": "unbound"
        }, {
            "cellType": "text",
            "cellText": "none",
            "fillWidth": false,
            "filterString": "unbound"
        }, {
            "cellType": "text",
            "cellText": "",
            "fillWidth": false,
            "filterString": "unbound"
        }, {
            "cellType": "text",
            "cellText": "/usr/local/opt/unbound/homebrew.mxcl.unbound.plist",
            "fillWidth": true,
            "filterString": "unbound"
        }, {
            "cellType": "linkBtn",
            "cellText": "stop",
            "fillWidth": false,
            "filterString": "unbound"
        }]

    readonly property int upgradableItems: {
        return formulaBodyList.filter(row => {
                                          return row.cellType === "checkbox"
                                      }).length + caskBodyList.filter(row => {
                                                                          return row.cellType
                                                                          === "checkbox"
                                                                      }).length
    }

    readonly property string lastUpdateDateStr: "02-24 13:34"
}

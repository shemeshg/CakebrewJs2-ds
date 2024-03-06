import QtQuick 6.5

QtObject {


    /*
    function asyncRefreshData(cb) {
        timerCb = cb
        refreshDataTimer.start()
    }
    */
    function asyncSearch(cb, textSearch, isCask) {
        if (isCask) {
            return
        }
        searchStatusCaskText = "Searching casks"
        searchStatusCaskVisible = true

        searchStatusFormulaText = "Searching formula"
        searchStatusFormulaVisible = true

        searchCaskRunning = true
        searchFormulaRunning = true

        timerCb = () => {
            searchItemsCask = []
            for (var i = 0; i < 40; i++) {
                searchItemsCask.push({
                                         "token": "a" + i,
                                         "name": "Cakebrewjs",
                                         "version": "2.0.0",
                                         "homepage": "https://google.com",
                                         "desc": "Do things",
                                         "installed": true
                                     })
                searchItemsCask.push({
                                         "token": "b" + i,
                                         "name": "Cakebrewjgpgp",
                                         "version": "2.0.0",
                                         "homepage": "https://hjksadf.com",
                                         "desc": "Do things",
                                         "installed": true
                                     })
            }
            searchItemsCask = [...searchItemsCask]

            searchStatusCaskText = ""
            searchStatusCaskVisible = false

            searchItemsFormula = [{
                                      "token": "d",
                                      "name": "Cakebrewjs",
                                      "version": "2.0.0",
                                      "homepage": "https://google.com",
                                      "desc": "Do things",
                                      "installed": true
                                  }, {
                                      "token": "e",
                                      "name": "Cakebrewjs",
                                      "version": "2.0.0",
                                      "homepage": "https://google.com",
                                      "desc": "Do things",
                                      "installed": true
                                  }]
            searchStatusFormulaText = ""
            searchStatusFormulaVisible = false

            searchCaskRunning = false
            searchFormulaRunning = false
            cb()
        }

        refreshDataTimer.start()
    }

    property var searchItemsCask: []
    property string searchStatusCaskText: ""
    property bool searchStatusCaskVisible: false
    property bool searchCaskRunning: false

    property var searchItemsFormula: []
    property string searchStatusFormulaText: ""
    property bool searchStatusFormulaVisible: false
    property bool searchFormulaRunning: false

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

    property string brewLocation: "/whatever/brew"

    property string normalFontPointSize: "14"

    property string terminalApp: "iTerm"

    function saveNormalFontPointSize(s) {
        normalFontPointSize = s
    }
    function saveBrewLocation(s) {
        brewLocation = s
    }
    function saveTerminalApp(s) {
        terminalApp = s
    }

    property string refreshStatusServicesText: ""
    property bool refreshStatusServicesVisible: false
    property bool refreshServicesRunning: false

    property string refreshStatusFormulaText: ""
    property bool refreshStatusFormulaVisible: false
    property bool refreshFormulaRunning: false

    property string refreshStatusCaskText: ""
    property bool refreshStatusCaskVisible: false
    property bool refreshCaskRunning: false

    function asyncRefreshServices(cb) {
        refreshStatusServicesText = "Refresh services"
        refreshStatusServicesVisible = true
        refreshServicesRunning = true
        servicesBodyList = []

        refreshStatusCaskText = "Refresh cask"
        refreshStatusCaskVisible = true
        refreshCaskRunning = true
        caskBodyList = []

        refreshStatusFormulaText = "Refresh Formula"
        refreshStatusFormulaVisible = true
        refreshFormulaRunning = true
        formulaBodyList = []

        timerCb = () => {

            servicesBodyList = [{
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
                                    "cellText": "Refreshed",
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

            caskBodyList = [{
                                "cellType": "linkBtn",
                                "cellText": "anaconda",
                                "fillWidth": false,
                                "filterString": "anaconda"
                            }, {
                                "cellType": "text",
                                "cellText": "REFRESHED Distribution of the Python and R programming languages for scientific computing",
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

            formulaBodyList = [{
                                   "cellType": "linkBtn",
                                   "cellText": "libxext",
                                   "fillWidth": false,
                                   "filterString": "libxext"
                               }, {
                                   "cellType": "text",
                                   "cellText": "REFRESHED X.Org: Library for common extensions to the X11 protocol",
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

            refreshStatusServicesText = ""
            refreshStatusServicesVisible = false
            refreshServicesRunning = false

            refreshStatusFormulaText = ""
            refreshStatusFormulaVisible = false
            refreshFormulaRunning = false

            refreshStatusCaskText = ""
            refreshStatusCaskVisible = false
            refreshCaskRunning = false
            cb()
        }

        refreshDataTimer.start()
    }

    function asyncRefreshCaskAndFormula(cb) {
        cb()
    }

    function asyncServicesAction(cb, name, action) {
        console.log("starting/stoping " + name)
    }

    property int servicesSortedColIdx: 0
    property int servicesSortedColOrder: 2
    function servicesSort() {
        console.log("Re-returned sorted")
    }

    property int caskSortedColIdx: 4
    property int caskSortedColOrder: 2
    function caskSort() {
        console.log("Re-returned sorted")
    }
}

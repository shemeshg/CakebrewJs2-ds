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
        interval: 200
    }

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

    property string refreshStatusServiceText: ""
    property bool refreshStatusServiceVisible: false
    property bool refreshServiceRunning: false

    property string refreshStatusFormulaText: ""
    property bool refreshStatusFormulaVisible: false
    property bool refreshFormulaRunning: false

    property string refreshStatusCaskText: ""
    property bool refreshStatusCaskVisible: false
    property bool refreshCaskRunning: false

    function asyncRefreshService(cb) {
        refreshStatusServiceText = "Refresh service"
        refreshStatusServiceVisible = true
        refreshServiceRunning = true

        refreshStatusCaskText = "Refresh cask"
        refreshStatusCaskVisible = true
        refreshCaskRunning = true

        refreshStatusFormulaText = "Refresh Formula"
        refreshStatusFormulaVisible = true
        refreshFormulaRunning = true

        timerCb = () => {

            refreshStatusServiceText = ""
            refreshStatusServiceVisible = false
            refreshServiceRunning = false

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

    function asyncServiceAction(cb, name, action) {
        console.log("starting/stoping " + name)
    }

    property int serviceSortedColIdx: 0
    property int serviceSortedColOrder: 2
    function serviceSort() {
        console.log("Re-returned sorted")
    }

    property int caskSortedColIdx: 4
    property int caskSortedColOrder: 2
    function caskSort() {
        console.log("Re-returned sorted")
    }

    property int formulaSortedColIdx: 4
    property int formulaSortedColOrder: 2
    function formulaSort() {
        console.log("Re-returned sorted")
    }

    property var serviceTableBodyList: [{
            "name": {
                "text": "Name"
            },
            "status": {
                "text": "Status"
            },
            "user": {
                "text": "User"
            },
            "plist": {
                "text": "Plist"
            },
            "action": {
                "text": "Action"
            },
            "filterString": "" //header must filter empty
        }, {
            "name": {
                "text": "aaa"
            },
            "status": {
                "text": "runnng"
            },
            "user": {
                "text": "User"
            },
            "plist": {
                "text": "Plistasd asdfasdfasdfasdfasdfadsf"
            },
            "action": {
                "text": "stop"
            },
            "filterString": "" //header must filter empty
        }]

    property var caskTableBodyList: [{
            "token": {
                "text": "Token"
            },
            "desc": {
                "text": "Description"
            },
            "tap": {
                "text": "Tap"
            },
            "version": {
                "text": "Version"
            },
            "outdated": {
                "text": "Outdated"
            },
            "filterString": "" //header must filter empty
        }, {
            "token": {
                "text": "libext"
            },
            "desc": {
                "text": "very asdfhaksdgflkagdsfasdlflhkg Description"
            },
            "tap": {
                "text": "Tap"
            },
            "version": {
                "text": "1.23"
            },
            "outdated": {
                "text": "2.00",
                "tsChecked": false
            },
            "leaf": {
                "text": "*",
                "hoverText": "shalom\nolam"
            },
            "filterString": "abc"
        }]

    property var formulaTableBodyList: [{
            "name": {
                "text": "Name"
            },
            "desc": {
                "text": "Description"
            },
            "tap": {
                "text": "Tap"
            },
            "version": {
                "text": "Version"
            },
            "outdated": {
                "text": "Outdated"
            },
            "leaf": {
                "text": "Leaf"
            },
            "filterString": "" //header must filter empty
        }, {
            "name": {
                "text": "libext"
            },
            "desc": {
                "text": "very asdfhaksdgflkagdsfasdlflhkg Description"
            },
            "tap": {
                "text": "Tap"
            },
            "version": {
                "text": "1.23"
            },
            "outdated": {
                "text": "2.00",
                "tsChecked": false
            },
            "leaf": {
                "text": "*",
                "hoverText": "shalom\nolam"
            },
            "filterString": "abc"
        }, {
            "name": {
                "text": "libext"
            },
            "desc": {
                "text": "very pioutyoiuyrt Description"
            },
            "tap": {
                "text": "Tap"
            },
            "version": {
                "text": "1.23"
            },
            "outdated": {
                "text": "2.00",
                "tsChecked": false
            },
            "leaf": {
                "text": "*",
                "hoverText": "shalom\nolam"
            },
            "filterString": "abc"
        }, {
            "name": {
                "text": "libext"
            },
            "desc": {
                "text": "very pioutyoiuyrt Description"
            },
            "tap": {
                "text": "Tap"
            },
            "version": {
                "text": "1.23"
            },
            "outdated": {
                "text": "2.00",
                "tsChecked": false
            },
            "leaf": {
                "text": "*",
                "hoverText": "shalom\nolam"
            },
            "filterString": "abc"
        }, {
            "name": {
                "text": "libext"
            },
            "desc": {
                "text": "very pioutyoiuyrt Description"
            },
            "tap": {
                "text": "Tap"
            },
            "version": {
                "text": "1.23"
            },
            "outdated": {
                "text": "2.00",
                "tsChecked": false
            },
            "leaf": {
                "text": "*",
                "hoverText": "shalom\nolam"
            },
            "filterString": "abc"
        }, {
            "name": {
                "text": "libext"
            },
            "desc": {
                "text": "very pioutyoiuyrt Description"
            },
            "tap": {
                "text": "Tap"
            },
            "version": {
                "text": "1.23"
            },
            "outdated": {
                "text": "",
                "tsChecked": false
            },
            "leaf": {
                "text": "*",
                "hoverText": "shalom\nolam"
            },
            "filterString": "abc"
        }]

    function asyncFormulaSort(cb) {}

    enum InfoStatus {
        Idile,
        Running,
        CaskFound,
        FormulaFound,
        CaskNotFound,
        FormulaNotFound
    }

    function asyncGetInfo(tokent, isCask, cb) {
        //var i = isCask ? BrewData.InfoStatus.CaskFound : BrewData.InfoStatus.FormulaFound
        if (isCask) {
            cb({
                   "artifacts": "cakebrewjs.app (app)\n",
                   "caskroomSize": "170M total",
                   "desc": "Homebrew GUI app written in electron",
                   "err": "",
                   "homepage": "https://sourceforge.net/projects/cakebrewjs/",
                   "infoStatus": 2,
                   "isInstalled": true,
                   "isOutdated": false,
                   "name": "cakebrewjs",
                   "outdated": "1.4.4",
                   "ruby_source_path": "Casks/c/cakebrewjs.rb",
                   "tap": "homebrew/cask",
                   "token": "cakebrewjs",
                   "version": "1.4.4"
               })
        } else {
            cb({
                   "infoStatus": BrewData.InfoStatus.FormulaFound
               })
        }
    }
}

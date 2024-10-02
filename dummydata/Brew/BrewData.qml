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
    property bool updateForce: true
    function saveNormalFontPointSize(s) {
        normalFontPointSize = s
    }
    function saveBrewLocation(s) {
        brewLocation = s
    }
    function saveTerminalApp(s) {
        terminalApp = s
    }
    property bool isExtendedCask: true
    function saveIsExtendedCask(s) {
        isExtendedCask = s
    }
    property bool isExtendedFormula: true
    function saveIsExtendedFormula(s) {
        isExtendedFormula = s
    }
    property bool isExtendedService: true
    function saveIsExtendedService(s) {
        isExtendedService = s
    }
    property bool isShowBrewInfoText: false
    function saveIsShowBrewInfoText(s) {
        isShowBrewInfoText = s
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

    function asyncRefreshCaskAndFormula(b, cb) {
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
                "text": "libext1"
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
                "text": "libext2"
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
                "text": "libext3"
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
                "text": "libext4"
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
    property int infoStatus: BrewData.InfoStatus.Idile

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
                   "buildDependencies": ["pkg-config", "python@3.12"],
                   "cellarSize": "71M total",
                   "dependencies": ["brotli", "c-ares", "icu4c", "libnghttp2", "libuv", "openssl@3"],
                   "desc": "Platform built on V8 to build network applications",
                   "err": "",
                   "fullName": "node",
                   "homepage": "https://nodejs.org/",
                   "infoStatus": 3,
                   "installedOnRequest": true,
                   "isInstalled": true,
                   "isOutdated": false,
                   "leafText": "",
                   "license": "MIT",
                   "outdated": "21.7.1",
                   "ruby_source_path": "Formula/n/node.rb",
                   "tap": "homebrew/core",
                   "token": "node",
                   "usedIn": [],
                   "version": "21.7.1"
               })
        }
    }

    function asyncGetInfoText(tokent, isCask, cb) {
        cb(`==> node: stable 21.7.1 (bottled), HEAD
           Platform built on V8 to build network applications
           https://nodejs.org/
           /usr/local/Cellar/node/21.7.1 (2,133 files, 65.8MB) *
           Poured from bottle using the formulae.brew.sh API on 2024-03-14 at 22:07:27
           From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/n/node.rb
           License: MIT
           ==> Dependencies
           Build: pkg-config ✔, python@3.12 ✔
           Required: brotli ✔, c-ares ✔, icu4c ✔, libnghttp2 ✔, libuv ✔, openssl@3 ✔
           ==> Options
           --HEAD
           Install HEAD version
           ==> Analytics
           install: 242,795 (30 days), 636,903 (90 days), 2,446,258 (365 days)
           install-on-request: 212,526 (30 days), 556,150 (90 days), 2,143,934 (365 days)
           build-error: 441 (30 days)
           `)
    }

    property bool isInfoShowPin: false
    property bool isInfoShowUnpin: false
    property bool isInfoShowUpgrade: false
    property bool isInfoShowInstall: false
    property bool isInfoShowUninstall: false
    property bool isInfoShowUninstallZap: false

    property int x: 0
    property int y: 0
    property int width: 1000
    property int height: 800
    function saveWidth(s) {}
    function saveHeight(s) {}
    function saveX(s) {}
    function saveY(s) {}

    function asyncBrewDoctor(cb) {
        cb()
    }

    function asyncBrewUpgradeAll(cb) {
        cb()
    }

    function asyncBrewUpgradeSelected(cb, casks, formulas) {
        cb()
    }

    function asyncPin(s, cb) {
        cb()
    }
    function asyncUnpin(s, cb) {
        cb()
    }

    function asyncRefreshServices(cb) {
        cb()
    }

    function qtVer() {
        return "6.6.2"
    }
}

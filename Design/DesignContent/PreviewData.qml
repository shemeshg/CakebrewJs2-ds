import Design
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    id: previewData
    HeaderToolbar {
        id: headerToolbarId
        visible: previewData.state !== "About"
    }

    Component.onCompleted: {
        Constants.caskSelected = []
        Constants.formulaSelected = []

        Constants.brewData.asyncRefreshServices(() => {}, true)

        Constants.brewData.asyncRefreshCaskAndFormula(true, () => {
                                                          home.ctvc.filterTableByFilter()
                                                          home.ctvf.filterTableByFilter()
                                                          home.ctvs.filterTableByFilter()
                                                      }, true)

    }

    states: [
        State {
            name: "Home"
            when: headerToolbarId.btnHomeId.checked
            PropertyChanges {
                target: bottomBar
                selectedPreview: "Home"
            }
        },
        State {
            name: "Info"
            when: headerToolbarId.btnInfoId.checked
            PropertyChanges {
                target: bottomBar
                selectedPreview: "Info"
            }
        },
        State {
            name: "Search"
            when: headerToolbarId.btnSearchId.checked
        },
        State {
            name: "Settings"
            when: headerToolbarId.btnSettingsId.checked
            PropertyChanges {
                target: bottomBar
                selectedPreview: "Settings"
            }
        },
        State {
            name: "About"
            PropertyChanges {
                target: bottomBar
                selectedPreview: "back"
            }
        }
    ]

    ScrollView {

        Layout.fillHeight: true
        Layout.fillWidth: true
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        ColumnLayout {
            id: clid
            anchors.margins: 30
            width: previewData.width
            height: previewData.height
            Settings {
                id: settings
                visible: previewData.state === "Settings"
            }

            Search {
                visible: previewData.state === "Search"
            }

            About {
                id: aboutScreenId
                visible: previewData.state === "About"
            }
            Info {
                id: info
                visible: previewData.state === "Info"
            }

            Home {
                id: home
                visible: previewData.state === "Home"
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }

    BottomBar {
        id: bottomBar
        onSaveSettingsClicked: {
            settings.saveSettings()
        }

        onBackClicked: {
            previewData.state = "Home"
            headerToolbarId.btnHomeId.checked = true
        }

        onAboutClicked: {
            previewData.state = "About"
            Constants.brewData.asyncGetBrewVersion((txt)=>{
                                                    aboutScreenId.homebrewVersion = txt
                                                   })

        }

        onRefreshClicked: {
            home.ctvc.filterTableByFilter()
            home.ctvf.filterTableByFilter()
            home.ctvs.filterTableByFilter()
        }
    }
}

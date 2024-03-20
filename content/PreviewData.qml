import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    id: previewData
    HeaderToolbar {
        id: headerToolbarId
        visible: previewData.state !== "About"
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
                visible: previewData.state === "About"
            }
            Info {
                visible: previewData.state === "Info"
            }

            Home {
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
        }

        onRefreshClicked: {


            /*
            stateGroup.state = "LoadingData"
            Constants.brewData.asyncRefreshData(() => {
                                                    stateGroup.state = "Preview"
                                                })
            */
            Constants.caskSelected = []
            Constants.formulaSelected = []
            Constants.brewData.asyncRefreshServices(() => {})
            Constants.brewData.asyncRefreshCaskAndFormula(() => {})
        }
    }
}

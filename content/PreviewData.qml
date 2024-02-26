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
                selectedPreview: "Info-cask"
            }
        },
        State {
            name: "Search"
            when: headerToolbarId.btnSearchId.checked
        },
        State {
            name: "Settings"
            when: headerToolbarId.btnSettingsId.checked
        },
        State {
            name: "About"
            PropertyChanges {
                target: bottomBar
                selectedPreview: "back"
            }
        }
    ]

    ColumnLayout {

        Settings {
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

    BottomBar {
        id: bottomBar
        onBackClicked: {
            previewData.state = "Home"
            headerToolbarId.btnHomeId.checked = true
        }

        onAboutClicked: {
            previewData.state = "About"
        }

        onRefreshClicked: {
            stateGroup.state = "LoadingData"
            Constants.brewData.refreshData()
        }
    }
}

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
                target: label
                text: "Home"
            }
            PropertyChanges {
                target: bottomBar
                selectedPreview: "Home"
            }
        },
        State {
            name: "Info"
            when: headerToolbarId.btnInfoId.checked
            PropertyChanges {
                target: label
                text: "Info"
            }
            PropertyChanges {
                target: bottomBar
                selectedPreview: "Info-cask"
            }
        },
        State {
            name: "Search"
            when: headerToolbarId.btnSearchId.checked
            PropertyChanges {
                target: label
                text: "Search"
            }
        },
        State {
            name: "Settings"
            when: headerToolbarId.btnSettingsId.checked
            PropertyChanges {
                target: label
                text: "Settings"
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

    ColumnLayout {

        Label {
            id: label
            text: ""
            color: Constants.systemPalette.text
            visible: previewData.state !== "Settings"
        }
        Settings {
            visible: previewData.state === "Settings"
        }

        About {
            visible: previewData.state === "About"
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
            Constants.refreshData()
        }
    }
}

import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    HeaderToolbar {
        id: headerToolbarId
        visible: !aboutId.visible
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
        }
    ]

    RowLayout {
        visible: !aboutId.visible
        Label {
            id: label
            text: ""
            color: Constants.systemPalette.text
        }
    }
    About {
        id: aboutId
        visible: false
    }
    Item {
        Layout.fillHeight: true
    }

    BottomBar {
        id: bottomBar
        onBackClicked: {
            aboutId.visible = false
        }

        onAboutClicked: {
            aboutId.visible = true
            bottomBar.selectedPreview = "back"
        }

        onRefreshClicked: {
            stateGroup.state = "LoadingData"
            Constants.refreshData()
        }
    }
}

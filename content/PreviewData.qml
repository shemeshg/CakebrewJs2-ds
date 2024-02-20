import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    HeaderToolbar {
        id: headerToolbarId
    }

    states: [
        State {
            name: "Home"
            when: headerToolbarId.btnHomeId.checked
            PropertyChanges {
                target: label
                text: "Home"
            }
        },
        State {
            name: "Info"
            when: headerToolbarId.btnInfoId.checked
            PropertyChanges {
                target: label
                text: "Info"
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
        Label {
            id: label
            text: ""
            color: systemPalette.text
        }
    }
}

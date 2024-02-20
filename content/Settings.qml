import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    Label {
        text: "Brew location"
        color: Constants.systemPalette.text
    }
    TextField {
        text: "/usr/local/bin/brew"
        Layout.fillWidth: true
        onActiveFocusChanged: {
            if (activeFocus) {
                selectAll()
            }
        }
    }
    Label {
        text: "Terminal application"
        color: Constants.systemPalette.text
    }
    ComboBox {
        id: cmb
        Layout.fillWidth: true
        model: ListModel {
            ListElement {
                text: "Terminal"
            }
            ListElement {
                text: "iTerm"
            }
        }
    }
    Label {
        text: "Font size"
        color: Constants.systemPalette.text
    }
    TextField {
        text: "14"
        Layout.fillWidth: true
        onActiveFocusChanged: {
            if (activeFocus) {
                selectAll()
            }
        }
    }
    Switch {
        text: "Refresh on startup"
    }
}

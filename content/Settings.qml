import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {
    CoreLabel {
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
    CoreLabel {
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
    CoreLabel {
        text: "Font size"
        color: Constants.systemPalette.text
        id: lblFontSize
    }
    TextField {
        text: lblFontSize.font.pointSize
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

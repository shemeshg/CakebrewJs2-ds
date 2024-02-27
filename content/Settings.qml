import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {
    CoreLabel {
        text: "Brew location"
        color: CoreSystemPalette.text
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
        color: CoreSystemPalette.text
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
        color: CoreSystemPalette.text
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

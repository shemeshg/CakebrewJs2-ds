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
    CoreTextField {
        text: Constants.brewData.brewLocation
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
    CoreComboBox {
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
    }
    CoreTextField {
        text: Constants.fontSizeNormal()
        Layout.fillWidth: true
    }
    CoreSwitch {
        text: "Refresh on startup"
    }
}

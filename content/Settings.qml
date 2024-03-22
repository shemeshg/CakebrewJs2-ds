import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {
    Layout.margins: 10
    function saveSettings() {
        Constants.brewData.saveNormalFontPointSize(fontSizeInput.text)
        Constants.brewData.saveBrewLocation(brewLocation.text)
        Constants.brewData.saveTerminalApp(terminalApp.currentText)
    }

    CoreLabel {
        text: "Brew location"
        color: CoreSystemPalette.text
    }
    CoreTextField {
        id: brewLocation
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
        id: terminalApp
        Layout.fillWidth: true
        textRole: "text"
        valueRole: "value"
        model: ListModel {
            ListElement {
                value: "Terminal"
                text: "Terminal"
            }
            ListElement {
                value: "iTerm"
                text: "iTerm"
            }
        }
        Component.onCompleted: currentIndex = indexOfValue(
                                   Constants.brewData.terminalApp)
    }
    CoreLabel {
        text: "Font size"
        color: CoreSystemPalette.text
    }
    CoreTextField {
        id: fontSizeInput
        text: Constants.fontSizeNormal()
        Layout.fillWidth: true
    }
}

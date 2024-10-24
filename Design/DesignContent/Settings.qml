import Design
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {
    Layout.leftMargin: 10
    Layout.rightMargin: 20

    function saveSettings() {
        Constants.brewData.saveNormalFontPointSize(fontSizeInput.text)
        Constants.brewData.saveBrewLocation(brewLocation.text)
        Constants.brewData.saveTerminalApp(terminalApp.currentText)
        Constants.brewData.saveUpdateForce(updateForce.checked)
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

    CoreSwitch {
        id: updateForce
        text: "Always do a slower, full update check (even
if unnecessary)"
        checked: Constants.brewData.updateForce
    }
}

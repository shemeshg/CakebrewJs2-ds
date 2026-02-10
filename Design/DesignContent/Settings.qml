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
        if (Qt.platform.os === "osx") {
            Constants.brewData.saveTerminalApp(terminalApp.currentText)
        } else {
            Constants.brewData.saveTerminalApp(terminalAppLinux.text)
        }

        Constants.brewData.saveUpdateForce(updateForce.checked)
        Constants.brewData.savePauseTerminalClose(pauseTerminalClose.checked)
        Constants.brewData.saveRefreshOnStartup(refreshOnStartup.checked)
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
        visible: Qt.platform.os === "osx"
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
    CoreTextField {
        id: terminalAppLinux
        visible: Qt.platform.os !== "osx"
        text: Constants.brewData.terminalApp
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
        id: pauseTerminalClose
        text: "Pause on terminal close"
        checked: Constants.brewData.pauseTerminalClose
    }

    CoreSwitch {
        id: refreshOnStartup
        text: "Refresh on app startup"
        checked: Constants.brewData.refreshOnStartup
    }

    CoreSwitch {
        id: updateForce
        text: "Always do a slower, full update check (even
if unnecessary)"
        checked: Constants.brewData.updateForce
    }

    CoreLabel {
        text: "SelfSigned Casks:"
        color: CoreSystemPalette.text
    }

    Repeater {
            model: Constants.brewData.selfSignList
            RowLayout {
                HyperlinkBtnInfo {
                    isCask: true
                    leftPadding: 10
                    urlText: modelData
                    urlRef: modelData
                }
                CoreButton {
                    text: "del"
                    onClicked: {
                        let a = Constants.brewData.selfSignList;
                        a.splice(index, 1);
                        Constants.brewData.saveSelfSignList( a)
                    }
                }
            }

    }

}

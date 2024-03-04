import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

GroupBox {
    id: bottomBarId
    Layout.fillWidth: true
    signal refreshClicked
    signal aboutClicked
    signal backClicked
    signal saveSettingsClicked
    property string selectedPreview: ""

    readonly property int upgradableItems: {
        return Constants.brewData.formulaBodyList.filter(row => {
                                                             return row.cellType === "checkbox"
                                                         }).length
                + Constants.brewData.caskBodyList.filter(row => {
                                                             return row.cellType === "checkbox"
                                                         }).length
    }

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        RowLayout {
            visible: selectedPreview === "Home"
            CoreButton {
                text: "Refresh"
                onClicked: {
                    refreshClicked()
                }
            }
            CoreButton {
                text: "Upgrade all (" + upgradableItems + ")"
            }
            CoreButton {
                text: "Upgrade selected (" + Number(
                          Constants.selectedFormulaItems.length
                          + Constants.selectedCaskItems.length) + ")"
            }
            CoreButton {
                text: "Doctor"
            }
        }
        RowLayout {
            visible: selectedPreview === "Info-cask"
            CoreButton {
                text: "Uninstall"
            }
            CoreButton {
                text: "Uninstall zap"
            }
        }
        RowLayout {
            visible: selectedPreview === "Settings"
            CoreButton {
                text: "Save Settings"
                onClicked: saveSettingsClicked()
            }
        }
        Item {
            Layout.fillWidth: true
        }
        CoreButton {
            visible: selectedPreview === "back"
            text: "Back"
            onClicked: {
                backClicked()
            }
        }
        CoreButton {
            visible: selectedPreview === "Home"
            text: "://brew.sh"
        }
        CoreButton {
            visible: selectedPreview === "Home"
            text: "About"
            onClicked: {
                aboutClicked()
            }
        }
    }
}

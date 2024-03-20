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

        /* return Constants.brewData.caskBodyList.filter(row => {
                                                          return row.cellType === "checkbox"
                                                      }).length
                                                      */
        return 0
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
            visible: selectedPreview === "Info"
            CoreButton {
                text: "Pin"
                visible: Constants.brewData.isInfoShowPin
            }
            CoreButton {
                text: "Unpin"
                visible: Constants.brewData.isInfoShowUnpin
            }
            CoreButton {
                text: "Upgrade"
                visible: Constants.brewData.isInfoShowUpgrade
            }
            CoreButton {
                text: "Install"
                visible: Constants.brewData.isInfoShowInstall
            }
            CoreButton {
                text: "Uninstall"
                visible: Constants.brewData.isInfoShowUninstall
            }
            CoreButton {
                text: "Uninstall zap"
                visible: Constants.brewData.isInfoShowUninstallZap
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

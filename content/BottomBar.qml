import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core
import Brew

GroupBox {
    id: bottomBarId
    Layout.fillWidth: true
    signal refreshClicked
    signal aboutClicked
    signal backClicked
    signal saveSettingsClicked
    property string selectedPreview: ""

    readonly property int upgradableItems: {

        return Constants.brewData.caskTableBodyList.filter(row => {
                                                               return Boolean(
                                                                   row.outdated.text)
                                                               && "tsChecked" in row.outdated
                                                           }).length
                + Constants.brewData.formulaTableBodyList.filter(row => {
                                                                     return Boolean(
                                                                         row.outdated.text)
                                                                     && "tsChecked" in row.outdated
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
                    Constants.caskSelected = []
                    Constants.formulaSelected = []
                    Constants.brewData.asyncRefreshServices(() => {})
                    Constants.brewData.asyncRefreshCaskAndFormula(() => {
                                                                      bottomBarId.refreshClicked()
                                                                  })
                }
            }
            CoreButton {
                text: "Upgrade all (" + upgradableItems + ")"
                onClicked: () => {
                               Constants.caskSelected = []
                               Constants.formulaSelected = []
                               Constants.brewData.asyncBrewUpgradeAll(() => {
                                                                          bottomBarId.refreshClicked()
                                                                      })
                           }
            }
            CoreButton {
                text: "Upgrade selected (" + Number(
                          Constants.caskSelected.length + Constants.formulaSelected.length) + ")"
                onClicked: () => {
                               var caskSelected = [...Constants.caskSelected]
                               var formulaSelected = [...Constants.formulaSelected]
                               Constants.caskSelected = []
                               Constants.formulaSelected = []

                               Constants.brewData.asyncBrewUpgradeSelected(
                                   caskSelected, formulaSelected, () => {
                                       bottomBarId.refreshClicked()
                                   })
                           }
                enabled: Number(
                             Constants.caskSelected.length + Constants.formulaSelected.length) > 0
            }
            CoreButton {
                text: "Doctor"
                onClicked: {
                    Constants.brewData.asyncBrewDoctor(() => {})
                }
            }
        }
        RowLayout {
            visible: selectedPreview === "Info"
            CoreButton {
                text: "Pin"
                visible: Constants.brewData.isInfoShowPin
                onClicked: () => {
                               Constants.brewData.isInfoShowPin = false
                               Constants.brewData.isInfoShowUnpin = false
                               Constants.brewData.isInfoShowUpgrade = false
                               Constants.brewData.isInfoShowInstall = false
                               Constants.brewData.isInfoShowUninstall = false
                               Constants.brewData.isInfoShowUninstallZap = false
                               Constants.brewData.infoStatus = BrewData.InfoStatus.Running
                               Constants.brewData.asyncPin(
                                   Constants.brewData.infoToken, () => {
                                       Constants.caskSelected = []
                                       Constants.formulaSelected = []
                                       Constants.brewData.asyncRefreshServices(
                                           () => {})
                                       Constants.brewData.asyncRefreshCaskAndFormula(
                                           () => {
                                               info.infoBtn.clicked()
                                               bottomBarId.refreshClicked()
                                           })
                                   })
                           }
            }
            CoreButton {
                text: "Unpin"
                visible: Constants.brewData.isInfoShowUnpin
                onClicked: () => {
                               Constants.brewData.isInfoShowPin = false
                               Constants.brewData.isInfoShowUnpin = false
                               Constants.brewData.isInfoShowUpgrade = false
                               Constants.brewData.isInfoShowInstall = false
                               Constants.brewData.isInfoShowUninstall = false
                               Constants.brewData.isInfoShowUninstallZap = false
                               Constants.brewData.infoStatus = BrewData.InfoStatus.Running
                               Constants.brewData.asyncUnpin(
                                   Constants.brewData.infoToken, () => {
                                       Constants.caskSelected = []
                                       Constants.formulaSelected = []
                                       Constants.brewData.asyncRefreshServices(
                                           () => {})
                                       Constants.brewData.asyncRefreshCaskAndFormula(
                                           () => {
                                               info.infoBtn.clicked()
                                               bottomBarId.refreshClicked()
                                           })
                                   })
                           }
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
            onClicked: () => {
                           Qt.openUrlExternally("https://brew.sh")
                       }
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

import Design
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core
import Bal

GroupBox {
    id: bottomBarId
    Layout.fillWidth: true
    signal refreshClicked
    signal aboutClicked
    signal backClicked
    signal saveSettingsClicked
    property string selectedPreview: ""

    function beforeInfoAction() {
        Constants.brewData.isInfoShowPin = false
        Constants.brewData.isInfoShowUnpin = false
        Constants.brewData.isInfoShowUpgrade = false
        Constants.brewData.isInfoShowInstall = false
        Constants.brewData.isInfoShowUninstall = false
        Constants.brewData.isInfoShowUninstallZap = false
        Constants.brewData.infoStatus = BrewData.InfoStatus.Running
    }
    function afterInfoAction() {
        Constants.caskSelected = []
        Constants.formulaSelected = []
        Constants.brewData.asyncRefreshServices(() => {})
        Constants.brewData.asyncRefreshCaskAndFormula(false, () => {
                                                          info.infoBtn.clicked()
                                                          bottomBarId.refreshClicked()
                                                      })
    }

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        RowLayout {
            visible: selectedPreview === "Home"
            CoreButton {

                text: "Refresh"
                hooverText: "brew update"
                enabled: !Constants.brewData.refreshServiceRunning
                         && !Constants.brewData.refreshFormulaRunning
                onClicked: {
                    Constants.caskSelected = []
                    Constants.formulaSelected = []
                    Constants.brewData.asyncRefreshServices(() => {})
                    Constants.brewData.asyncRefreshCaskAndFormula(true, () => {
                                                                      bottomBarId.refreshClicked()
                                                                  })
                }
            }
            CoreButton {
                text: "Upgrade all (" + Number(
                          Constants.upgradableItemsCask + Constants.upgradableItemsFormula) + ")"
                onClicked: () => {
                               Constants.caskSelected = []
                               Constants.formulaSelected = []
                               Constants.brewData.asyncBrewUpgradeAll(() => {
                                                                          bottomBarId.refreshClicked()
                                                                      })
                           }
                hooverText: "<b>Cask </b>" + Constants.upgradableItemsCask
                            + "<br/><b>Formula </b>" + Constants.upgradableItemsFormula
                enabled: !Constants.brewData.refreshServiceRunning
                         && !Constants.brewData.refreshFormulaRunning && Number(
                             Constants.upgradableItemsCask + Constants.upgradableItemsFormula) > 0
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
                enabled: !Constants.brewData.refreshServiceRunning
                         && !Constants.brewData.refreshFormulaRunning && Number(
                             Constants.caskSelected.length + Constants.formulaSelected.length) > 0
                hooverText: "<b>Cask </b>" + Constants.caskSelected.length
                            + " / " + Constants.upgradableItemsCask
                            + "<br/><b>Formula </b>" + Constants.formulaSelected.length
                            + " / " + Constants.upgradableItemsFormula
            }
        }
        RowLayout {
            visible: selectedPreview === "Info"

            CoreButton {
                text: "Pin"
                visible: Constants.brewData.isInfoShowPin
                onClicked: () => {
                               beforeInfoAction()
                               Constants.brewData.asyncPin(
                                   Constants.brewData.infoToken, () => {
                                       afterInfoAction()
                                   })
                           }
                enabled: !Constants.brewData.refreshServiceRunning
                         && !Constants.brewData.refreshFormulaRunning
            }
            CoreButton {
                text: "Unpin"
                visible: Constants.brewData.isInfoShowUnpin
                onClicked: () => {
                               beforeInfoAction()
                               Constants.brewData.asyncUnpin(
                                   Constants.brewData.infoToken, () => {
                                       afterInfoAction()
                                   })
                           }
                enabled: !Constants.brewData.refreshServiceRunning
                         && !Constants.brewData.refreshFormulaRunning
            }
            CoreButton {
                text: "Upgrade"
                visible: Constants.brewData.isInfoShowUpgrade
                onClicked: {
                    if (Constants.brewData.infoStatus === BrewData.InfoStatus.CaskFound) {
                        beforeInfoAction()
                        Constants.brewData.asyncBrewUpgradeSelected(
                                    [Constants.brewData.infoToken], [], () => {
                                        afterInfoAction()
                                    })
                    } else if (Constants.brewData.infoStatus === BrewData.InfoStatus.FormulaFound) {
                        beforeInfoAction()
                        Constants.brewData.asyncBrewUpgradeSelected(
                                    [], [Constants.brewData.infoToken], () => {
                                        afterInfoAction()
                                    })
                    }
                }
                enabled: !Constants.brewData.refreshServiceRunning
                         && !Constants.brewData.refreshFormulaRunning
            }
            CoreButton {
                text: "Install"
                visible: Constants.brewData.isInfoShowInstall
                onClicked: {
                    if (Constants.brewData.infoStatus === BrewData.InfoStatus.CaskFound) {
                        beforeInfoAction()
                        Constants.brewData.asyncBrewActionSelected(
                                    [Constants.brewData.infoToken], [],
                                    "install", () => {
                                        afterInfoAction()
                                    })
                    } else if (Constants.brewData.infoStatus === BrewData.InfoStatus.FormulaFound) {
                        beforeInfoAction()
                        Constants.brewData.asyncBrewActionSelected(
                                    [], [Constants.brewData.infoToken],
                                    "install", () => {
                                        afterInfoAction()
                                    })
                    }
                }
                enabled: !Constants.brewData.refreshServiceRunning
                         && !Constants.brewData.refreshFormulaRunning
            }
            CoreButton {
                text: "Uninstall"
                visible: Constants.brewData.isInfoShowUninstall
                onClicked: {
                    if (Constants.brewData.infoStatus === BrewData.InfoStatus.CaskFound) {
                        beforeInfoAction()
                        Constants.brewData.asyncBrewActionSelected(
                                    [Constants.brewData.infoToken], [],
                                    "uninstall", () => {
                                        afterInfoAction()
                                    })
                    } else if (Constants.brewData.infoStatus === BrewData.InfoStatus.FormulaFound) {
                        beforeInfoAction()
                        Constants.brewData.asyncBrewActionSelected(
                                    [], [Constants.brewData.infoToken],
                                    "uninstall", () => {
                                        afterInfoAction()
                                    })
                    }
                }
                enabled: !Constants.brewData.refreshServiceRunning
                         && !Constants.brewData.refreshFormulaRunning
            }
            CoreButton {
                text: "Uninstall zap"
                visible: Constants.brewData.isInfoShowUninstallZap
                onClicked: {
                    if (Constants.brewData.infoStatus === BrewData.InfoStatus.CaskFound) {
                        beforeInfoAction()
                        Constants.brewData.asyncBrewActionSelected(
                                    [Constants.brewData.infoToken], [],
                                    "uninstall --zap", () => {
                                        afterInfoAction()
                                    })
                    }
                }
                enabled: !Constants.brewData.refreshServiceRunning
                         && !Constants.brewData.refreshFormulaRunning
            }
            CoreSwitch {
                function foundSelfSign(){
                    let list = Constants.brewData.selfSignList.map(item => {
                                                                          let parts = item.split("/");
                                                                          return parts.slice(-1)[0];
                                                                      });
                    let target = Constants.brewData.infoToken.split("/").slice(-1)[0];
                    return list.indexOf(target) !== -1
                }

                text: "SelfSign"
                visible: Constants.brewData.isInfoShowUninstallZap
                enabled: !Constants.brewData.refreshServiceRunning
                         && !Constants.brewData.refreshFormulaRunning
                checked:  foundSelfSign()
                onToggled:  {
                    let a = Constants.brewData.selfSignList;
                    if(checked) {
                        if (a.indexOf(Constants.brewData.infoToken) === -1) {
                            a.push(Constants.brewData.infoToken);
                            Constants.brewData.saveSelfSignList(a);

                            if (Constants.brewData.infoStatus === BrewData.InfoStatus.CaskFound) {
                                beforeInfoAction()
                                Constants.brewData.selfSignCasks(Constants.brewData.infoToken,() => {
                                                                      afterInfoAction()
                                                                 })
                            }
                        }
                    } else {
                        let i = a.indexOf(Constants.brewData.infoToken);
                        if (i !== -1) {
                            a.splice(i, 1);  // Remove the item at index i
                            Constants.brewData.saveSelfSignList(a);
                        }
                    }
                }
            }
        }


        RowLayout {
            visible: selectedPreview === "Settings"
            CoreButton {
                text: "Save Settings"
                onClicked: saveSettingsClicked()
            }
        }

        CoreButton {
            visible: selectedPreview === "back"
            text: "://brew.sh"
            hooverText: "https://brew.sh"
            onClicked: () => {
                           Qt.openUrlExternally("https://brew.sh")
                       }
        }
        CoreButton {
            text: "Doctor"
            visible: selectedPreview === "back"
            hooverText: "brew doctor"
            onClicked: {
                Constants.brewData.asyncBrewDoctor(() => {})
            }
            enabled: !Constants.brewData.refreshServiceRunning
                     && !Constants.brewData.refreshFormulaRunning
        }
        CoreButton {
            text: "Cleanup"
            visible: selectedPreview === "back"
            hooverText: "brew cleanup --prune=all"
            onClicked: {
                Constants.brewData.asyncBrewCleanup(() => {})
            }
            enabled: !Constants.brewData.refreshServiceRunning
                     && !Constants.brewData.refreshFormulaRunning
        }
        Item {
            Layout.fillWidth: true
        }
        CoreButton {
            visible: selectedPreview === "back"
            text: "←"
            hooverText: "back"
            onClicked: {
                backClicked()
            }
        }
        CoreButton {
            visible: selectedPreview === "Home"
            text: "⋮"
            hooverText: "About and brew actions"
            onClicked: {
                aboutClicked()
            }
        }
    }
}

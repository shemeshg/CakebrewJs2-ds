import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core
import Brew

ColumnLayout {
    property alias cmb: cmb
    property alias token: token
    property alias infoBtn: infoBtn
    Layout.leftMargin: 10
    Layout.rightMargin: 20

    function infoTextLookup() {
        if (!isShowBrewInfoText.checked || !token.text) {
            return
        }
        var isCask = cmb.currentText === "Cask"
        brewInfoText.text = ""
        busyBrewInfoText.visible = true
        Constants.brewData.asyncGetInfoText(token.text, isCask, result => {
                                                brewInfoText.text = result
                                                busyBrewInfoText.visible = false
                                            })
    }

    RowLayout {

        CoreComboBox {
            id: cmb
            model: ListModel {
                ListElement {
                    text: "Cask"
                }
                ListElement {
                    text: "Formula"
                }
            }
        }
        CoreTextField {
            id: token
            text: ""
            Layout.fillWidth: true
            onActiveFocusChanged: {
                if (activeFocus) {
                    selectAll()
                }
            }
            onAccepted: {
                if (infoBtn.enabled) {
                    infoBtn.clicked()
                }
            }
        }
        CoreButton {
            id: infoBtn
            text: "Info"
            onClicked: () => {
                           Constants.brewData.isInfoShowPin = false
                           Constants.brewData.isInfoShowUnpin = false
                           Constants.brewData.isInfoShowUpgrade = false
                           Constants.brewData.isInfoShowInstall = false
                           Constants.brewData.isInfoShowUninstall = false
                           Constants.brewData.isInfoShowUninstallZap = false
                           Constants.brewData.infoStatus = BrewData.InfoStatus.Running
                           infoTextLookup()

                           var isCask = cmb.currentText === "Cask"
                           Constants.brewData.asyncGetInfo(token.text, isCask,
                                                           result => {

                                                               Constants.brewData.infoStatus
                                                               = result.infoStatus
                                                               err.text = result.err

                                                               if (isCask) {

                                                                   infoCask.token = result.token
                                                                   infoCask.version = result.version
                                                                   infoCask.outdated
                                                                   = result.outdated

                                                                   infoCask.name = result.name

                                                                   infoCask.isOutdated
                                                                   = result.isOutdated
                                                                   infoCask.isInstalled
                                                                   = result.isInstalled
                                                                   infoCask.isDeprecated
                                                                   = result.isDeprecated
                                                                   infoCask.desc = result.desc
                                                                   infoCask.homepage
                                                                   = result.homepage

                                                                   infoCask.caskRbGithub = `https://github.com/${result.tap.split("/")[0]}/homebrew-${result.tap.split("/")[1]}/blob/HEAD/${result.ruby_source_path}`
                                                                   infoCask.caskroomSize
                                                                   = result.caskroomSize
                                                                   infoCask.artifacts
                                                                   = result.artifacts
                                                                   infoCask.caveats = result.caveats

                                                                   if (infoCask.isInstalled
                                                                       && infoCask.isOutdated) {
                                                                       Constants.brewData.isInfoShowUpgrade = true
                                                                   }
                                                                   if (infoCask.isInstalled) {
                                                                       Constants.brewData.isInfoShowUninstall = true
                                                                       Constants.brewData.isInfoShowUninstallZap = true
                                                                   } else {
                                                                       Constants.brewData.isInfoShowInstall = true
                                                                   }
                                                               } else {

                                                                   infoFormula.token = result.token
                                                                   infoFormula.fullName
                                                                   = result.fullName
                                                                   infoFormula.desc = result.desc
                                                                   infoFormula.version
                                                                   = result.version
                                                                   infoFormula.outdated
                                                                   = result.outdated
                                                                   infoFormula.isOutdated
                                                                   = result.isOutdated
                                                                   infoFormula.isInstalled
                                                                   = result.isInstalled
                                                                   infoFormula.cellarSize
                                                                   = result.cellarSize
                                                                   infoFormula.isDeprecated
                                                                   = result.isDeprecated
                                                                   infoFormula.homepage
                                                                   = result.homepage
                                                                   infoFormula.license
                                                                   = result.license
                                                                   infoFormula.usedIn
                                                                   = result.usedIn
                                                                   infoFormula.buildDependencies
                                                                   = result.buildDependencies
                                                                   infoFormula.dependencies
                                                                   = result.dependencies
                                                                   infoFormula.isPinned
                                                                   = result.isPinned
                                                                   infoFormula.caveats
                                                                   = result.caveats

                                                                   if (infoFormula.isInstalled
                                                                       && !infoFormula.isPinned) {
                                                                       Constants.brewData.isInfoShowPin = true
                                                                   }
                                                                   if (infoFormula.isInstalled
                                                                       && infoFormula.isPinned) {
                                                                       Constants.brewData.isInfoShowUnpin = true
                                                                   }
                                                                   if (infoFormula.isInstalled
                                                                       && infoFormula.isOutdated
                                                                       && !infoFormula.isPinned) {
                                                                       Constants.brewData.isInfoShowUpgrade = true
                                                                   }
                                                                   if (infoFormula.isInstalled) {
                                                                       Constants.brewData.isInfoShowUninstall = true
                                                                   } else {
                                                                       Constants.brewData.isInfoShowInstall = true
                                                                   }
                                                                   infoFormula.caskRbGithub = `https://github.com/${result.tap.split("/")[0]}/homebrew-${result.tap.split("/")[1]}/blob/HEAD/${result.ruby_source_path}`
                                                               }
                                                           })
                       }
            enabled: Boolean(
                         token.text.trim()
                         && Constants.brewData.infoStatus !== BrewData.InfoStatus.Running)
        }
    }

    CoreBusyIndicator {
        visible: Constants.brewData.infoStatus === BrewData.InfoStatus.Running
    }

    CoreLabel {
        id: err
        visible: Constants.brewData.infoStatus === BrewData.InfoStatus.CaskNotFound
                 || Constants.brewData.infoStatus === BrewData.InfoStatus.FormulaNotFound
    }

    InfoCask {
        id: infoCask
        visible: Constants.brewData.infoStatus === BrewData.InfoStatus.CaskFound
    }

    InfoFormula {
        id: infoFormula
        visible: Constants.brewData.infoStatus === BrewData.InfoStatus.FormulaFound
    }

    CoreSwitch {
        id: isShowBrewInfoText
        topPadding: 30
        text: "Show brew info"
        checked: Constants.brewData.isShowBrewInfoText
        onToggled: () => {
                       Constants.brewData.saveIsShowBrewInfoText(
                           isShowBrewInfoText.checked)
                       infoTextLookup()
                   }
    }
    CoreBusyIndicator {
        id: busyBrewInfoText
        visible: false
    }

    CoreTextArea {
        id: brewInfoText
        visible: isShowBrewInfoText.checked
                 && Constants.brewData.infoStatus !== BrewData.InfoStatus.Running
                 && text
        readOnly: true
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
    }
}

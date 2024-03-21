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
    Layout.margins: 10

    function infoTextLookup() {
        if (!isShowBrewInfoText.checked || !token.text) {
            return
        }
        var isCask = cmb.currentText === "Cask"
        brewInfoText.text = "running"
        Constants.brewData.asyncGetInfoText(token.text, isCask, result => {
                                                brewInfoText.text = result
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
                                                                   infoCask.desc = result.desc
                                                                   infoCask.homepage
                                                                   = result.homepage

                                                                   infoCask.caskRbGithub = `https://github.com/${result.tap.split("/")[0]}/homebrew-${result.tap.split("/")[1]}/blob/HEAD/${result.ruby_source_path}`
                                                                   infoCask.caskroomSize
                                                                   = result.caskroomSize
                                                                   infoCask.artifacts
                                                                   = result.artifacts

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

    CoreLabel {
        text: "Running"
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
        onToggled: () => {
                       infoTextLookup()
                   }
    }
    CoreTextArea {
        id: brewInfoText
        visible: isShowBrewInfoText.checked
                 && Constants.brewData.infoStatus !== BrewData.InfoStatus.Running
        readOnly: true
    }
}

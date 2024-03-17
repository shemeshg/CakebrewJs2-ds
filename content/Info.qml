import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core
import Brew

ColumnLayout {

    property int infoStatus: BrewData.InfoStatus.Idile

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
        }
        CoreButton {
            text: "Info"
            onClicked: () => {
                           infoStatus = BrewData.InfoStatus.Running
                           var isCask = cmb.currentText === "Cask"
                           Constants.brewData.asyncGetInfo(token.text, isCask,
                                                           result => {

                                                               infoStatus = result.infoStatus
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

                                                                   infoCask.caskRbGithub = `https://github.com/${result.tap.split("/")[0]}/homebrew-${result.tap.split("/")[1]}/blob/master/${result.ruby_source_path}`
                                                                   infoCask.caskroomSize
                                                                   = result.caskroomSize

                                                                   console.log(
                                                                       JSON.stringify(
                                                                           result))
                                                               }
                                                           })
                       }
            enabled: Boolean(token.text.trim())
        }
    }

    CoreLabel {
        text: "Running"
        visible: infoStatus === BrewData.InfoStatus.Running
    }

    CoreLabel {
        id: err
        visible: infoStatus === BrewData.InfoStatus.CaskNotFound
                 || infoStatus === BrewData.InfoStatus.FormulaNotFound
    }

    InfoCask {
        id: infoCask
        visible: infoStatus === BrewData.InfoStatus.CaskFound
    }

    InfoFormula {
        visible: infoStatus === BrewData.InfoStatus.FormulaFound
    }
}

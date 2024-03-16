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
        visible: infoStatus === BrewData.InfoStatus.CaskFound
    }

    InfoFormula {
        visible: infoStatus === BrewData.InfoStatus.FormulaFound
    }
}

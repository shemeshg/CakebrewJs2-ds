import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core





    ColumnLayout {

        enum InfoStatus {
            Idile,
            Running,
            CaskFound,
            FormulaFound,
            CaskNotFound,
            FormulaNotFound

        }
        property int status: Info.InfoStatus.Idile;

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
                enabled: Boolean( text.trim())
            }
            CoreButton {
                text: "Info"
                onClicked:
                    ()=>{
                        var isCask = cmb.currentText === "Cask";
                        Constants.brewData.asyncGetInfo(token.text,isCask,(result)=>{
                                                            if (result.found){
                                                                if (result.isCask){
                                                                    status = Info.InfoStatus.CaskFound
                                                                } else {
                                                                    status = Info.InfoStatus.FormulaFound
                                                                }
                                                            } else {
                                                                if (result.isCask){
                                                                    status = Info.InfoStatus.CaskNotFound
                                                                } else {
                                                                    status = Info.InfoStatus.FormulaNotFound
                                                                }
                                                            }
                                                        });
                    }
            }
        }

        InfoCask {
            visible: status === Info.InfoStatus.CaskFound
        }

        InfoFormula {
            visible: status === Info.InfoStatus.FormulaFound
        }
    }

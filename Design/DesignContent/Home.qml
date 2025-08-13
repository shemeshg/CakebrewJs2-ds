import Design
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core
import Qt.labs.qmlmodels

ColumnLayout {

    property alias ctvc: ctvc
    property alias ctvf: ctvf
    property alias ctvs: ctvs

    CoreLabel {
        text: Constants.brewData.refreshStatusCaskText
        visible: Constants.brewData.refreshStatusCaskVisible
                 && !Constants.brewData.refreshFormulaRunning
    }

    CollapseableTableView {
        id: ctvc
        onIsExtendedChanged: {
            Constants.brewData.saveIsExtendedCask(ctvc.isExtended)
        }

        headerText: "Cask " + (Constants.upgradableItemsCask
                               !== 0 ? "(" + Constants.upgradableItemsCask + ")" : "")
        isLoading: Constants.brewData.refreshFormulaRunning
        rowsModel: [...Constants.brewData.caskTableBodyList]
        isExtended: Constants.brewData.isExtendedCask

        tableView.model: TableModel {

            TableModelColumn {
                display: "token"
            }
            TableModelColumn {
                display: "desc"
            }
            TableModelColumn {
                display: "tap"
            }
            TableModelColumn {
                display: "version"
            }
            TableModelColumn {
                display: "outdated"
            }

            // Each row is one type of fruit that can be ordered
            rows: ctvc.filteredModel
        }

        tableView.delegate: DelegateChooser {
            DelegateChoice {
                index: 0
                TableHeaderLabel {
                    sortedColOrder: ctvc.sortedColOrder
                    sortedColIdx: ctvc.sortedColIdx
                    onHeaderClicked: (idx, sortOrder) => {
                                         Constants.brewData.caskSortedColIdx = idx
                                         Constants.brewData.caskSortedColOrder = sortOrder
                                         ctvc.sortedColIdx = idx
                                         ctvc.sortedColOrder = sortOrder
                                         Constants.brewData.asyncCaskSort(
                                             () => {
                                                 ctvc.filterTableByFilter()
                                             })
                                     }
                }
            }

            DelegateChoice {
                column: 0
                delegate: HyperlinkBtnInfo {
                    isCask: true
                    leftPadding: 10
                    urlText: model.display.text
                             + (ctvc.filteredModel[model.row].isDeprecated ? " ⚠️" : "")
                    urlRef: model.display.text
                }
            }

            DelegateChoice {
                column: 4
                delegate: CoreCheckBox {
                    enabled: !Constants.brewData.refreshFormulaRunning
                    visible: model.display.text
                    checked: {
                        if (ctvc.filteredModel[model.row]) {
                            return Constants.caskSelected.indexOf(
                                        ctvc.filteredModel[model.row].token.text) > -1
                        }
                        return false
                    }

                    leftPadding: 10
                    text: model.display.text
                    onToggled: {
                        model.display.tsChecked = checked
                        if (checked) {
                            Constants.caskSelected.push(
                                        ctvc.filteredModel[model.row].token.text)
                        } else {
                            const indexToRemove = Constants.caskSelected.indexOf(
                                                    ctvc.filteredModel[model.row].token.text)
                            if (indexToRemove !== -1) {
                                Constants.caskSelected.splice(indexToRemove, 1)
                            }
                        }
                        Constants.caskSelected = [...Constants.caskSelected]
                    }
                }
            }

            DelegateChoice {
                column: ctvc.autoExtendCol
                CoreLabel {
                    text: model.display.text
                    wrapMode: Text.WordWrap
                    leftPadding: 10
                }
            }
            DelegateChoice {
                CoreLabel {
                    text: model.display.text
                    leftPadding: 10
                }
            }
        }
    }

    CoreLabel {
        text: Constants.brewData.refreshStatusFormulaText
        visible: Constants.brewData.refreshStatusFormulaVisible
                 && !Constants.brewData.refreshFormulaRunning
    }

    CollapseableTableView {
        id: ctvf
        isExtended: Constants.brewData.isExtendedFormula
        onIsExtendedChanged: {
            Constants.brewData.saveIsExtendedFormula(ctvf.isExtended)
        }
        isLoading: Constants.brewData.refreshFormulaRunning
        headerText: "Formula " + (Constants.upgradableItemsFormula
                                  !== 0 ? "(" + Constants.upgradableItemsFormula + ")" : "")
        rowsModel: [...Constants.brewData.formulaTableBodyList]
        tableView.model: TableModel {

            TableModelColumn {
                display: "name"
            }
            TableModelColumn {
                display: "desc"
            }
            TableModelColumn {
                display: "tap"
            }
            TableModelColumn {
                display: "version"
            }
            TableModelColumn {
                display: "outdated"
            }
            TableModelColumn {
                display: "leaf"
            }

            // Each row is one type of fruit that can be ordered
            rows: ctvf.filteredModel
        }

        tableView.delegate: DelegateChooser {
            DelegateChoice {
                index: 0
                TableHeaderLabel {
                    sortedColOrder: ctvf.sortedColOrder
                    sortedColIdx: ctvf.sortedColIdx
                    onHeaderClicked: (idx, sortOrder) => {
                                         Constants.brewData.formulaSortedColIdx = idx
                                         Constants.brewData.formulaSortedColOrder = sortOrder
                                         ctvf.sortedColIdx = idx
                                         ctvf.sortedColOrder = sortOrder
                                         Constants.brewData.asyncFormulaSort(
                                             () => {
                                                 ctvf.filterTableByFilter()
                                             })
                                     }
                }
            }

            DelegateChoice {
                column: 0
                delegate: HyperlinkBtnInfo {
                    isCask: false
                    leftPadding: 10
                    urlText: model.display.text
                             + (ctvf.filteredModel[model.row].isDeprecated ? " ⚠️" : "")
                    urlRef: model.display.text
                }
            }

            DelegateChoice {
                column: 4
                delegate: CoreCheckBox {
                    enabled: !Constants.brewData.refreshFormulaRunning
                    visible: model.display.text
                    checked: {
                        if (ctvf.filteredModel[model.row]) {
                            return Constants.formulaSelected.indexOf(
                                        ctvf.filteredModel[model.row].name.text) > -1
                        }
                        return false
                    }
                    leftPadding: 10
                    text: model.display.text
                    onToggled: {
                        model.display.tsChecked = checked
                        if (checked) {
                            Constants.formulaSelected.push(
                                        ctvf.filteredModel[model.row].name.text)
                        } else {
                            const indexToRemove = Constants.formulaSelected.indexOf(
                                                    ctvf.filteredModel[model.row].name.text)
                            if (indexToRemove !== -1) {
                                Constants.formulaSelected.splice(indexToRemove,
                                                                 1)
                            }
                        }
                        Constants.formulaSelected = [...Constants.formulaSelected]
                    }
                }
            }

            DelegateChoice {
                column: 5
                delegate: CoreLabel {
                    leftPadding: 10
                    text: model.display.text
                    color: CoreSystemPalette.text
                    CoreToolTip {
                        id: toolTip
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: modelData.hoverText ? Qt.PointingHandCursor : cursorShape
                        hoverEnabled: true
                        onClicked: {
                            if (modelData.hoverText) {
                                toolTip.show(model.display.hoverText, 3000)
                            }
                        }
                    }
                }
            }

            DelegateChoice {
                column: ctvf.autoExtendCol
                CoreLabel {
                    text: model.display.text
                    wrapMode: Text.WordWrap
                    leftPadding: 10
                }
            }
            DelegateChoice {
                CoreLabel {
                    text: model.display.text
                    leftPadding: 10
                }
            }
        }
    }

    CoreLabel {
        text: Constants.brewData.refreshStatusServiceText
        visible: Constants.brewData.refreshStatusServiceVisible
                 && !Constants.brewData.refreshServiceRunning
    }

    CollapseableTableView {
        id: ctvs
        isExtended: Constants.brewData.isExtendedService
        onIsExtendedChanged: {
            Constants.brewData.saveIsExtendedService(ctvs.isExtended)
        }

        autoExtendCol: 3

        headerText: "Service"
        isLoading: Constants.brewData.refreshServiceRunning
        rowsModel: [...Constants.brewData.serviceTableBodyList]
        tableView.model: TableModel {

            TableModelColumn {
                display: "name"
            }
            TableModelColumn {
                display: "action"
            }
            TableModelColumn {
                display: "status"
            }
            TableModelColumn {
                display: "user"
            }
            TableModelColumn {
                display: "plist"
            }


            // Each row is one type of fruit that can be ordered
            rows: ctvs.filteredModel
        }

        tableView.delegate: DelegateChooser {
            DelegateChoice {
                index: 0
                TableHeaderLabel {
                    sortedColOrder: ctvs.sortedColOrder
                    sortedColIdx: ctvs.sortedColIdx
                    onHeaderClicked: (idx, sortOrder) => {
                                         Constants.brewData.serviceSortedColIdx = idx
                                         Constants.brewData.serviceSortedColOrder = sortOrder
                                         ctvs.sortedColIdx = idx
                                         ctvs.sortedColOrder = sortOrder
                                         Constants.brewData.asyncServiceSort(
                                             () => {
                                                 ctvs.filterTableByFilter()
                                             })
                                     }
                }
            }

            DelegateChoice {
                column: 1
                delegate: HyperlinkBtn {
                    leftPadding: 10
                    enabled: !Constants.brewData.refreshServiceRunning
                             && !Constants.brewData.refreshFormulaRunning
                    urlText: model.display.text
                             === "start" ? "⏵ " + model.display.text : "⏹ " + model.display.text
                    onLinkActivated: data => {
                                         Constants.brewData.asyncServiceAction(
                                             () => {
                                                 Constants.brewData.asyncRefreshServices(
                                                     () => {
                                                         home.ctvs.filterTableByFilter()
                                                     })
                                             }, model.display.name,
                                             model.display.text)
                                     }
                    urlRef: model.display.text
                }
            }

            DelegateChoice {
                column: ctvs.autoExtendCol
                CoreLabel {
                    text: model.display.text
                    wrapMode: Text.WordWrap
                    leftPadding: 10
                }
            }
            DelegateChoice {
                CoreLabel {
                    text: model.display.text
                    leftPadding: 10
                }
            }
        }
    }
}

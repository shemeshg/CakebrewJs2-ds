import CakebrewJs2
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
    }

    CollapseableTableView {
        id: ctvc
        onIsExtendedChanged: {
            Constants.brewData.saveIsExtendedCask(ctvc.isExtended)
        }

        headerText: "Cask"
        rowsModel: Constants.brewData.caskTableBodyList
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
                    urlRef: model.display.text
                }
            }

            DelegateChoice {
                column: 4
                delegate: CheckBox {
                    enabled: !Constants.brewData.refreshFormulaRunning
                    visible: model.display.text
                    checked: {
                        return Constants.caskSelected.indexOf(
                                    Constants.brewData.caskTableBodyList[model.row].token.text) > -1
                    }

                    leftPadding: 10
                    text: model.display.text
                    onToggled: {
                        model.display.tsChecked = checked
                        if (checked) {
                            Constants.caskSelected.push(
                                        Constants.brewData.caskTableBodyList[model.row].token.text)
                        } else {
                            const indexToRemove = Constants.caskSelected.indexOf(
                                                    Constants.brewData.caskTableBodyList[model.row].token.text)
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
    }

    CollapseableTableView {
        id: ctvf
        isExtended: Constants.brewData.isExtendedFormula
        onIsExtendedChanged: {
            Constants.brewData.saveIsExtendedFormula(ctvf.isExtended)
        }

        headerText: "Formula"
        rowsModel: Constants.brewData.formulaTableBodyList
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
                    urlRef: model.display.text
                }
            }

            DelegateChoice {
                column: 4
                delegate: CheckBox {
                    enabled: !Constants.brewData.refreshFormulaRunning
                    visible: model.display.text
                    checked: {
                        return Constants.formulaSelected.indexOf(
                                    Constants.brewData.formulaTableBodyList[model.row].name.text)
                                > -1
                    }
                    leftPadding: 10
                    text: model.display.text
                    onToggled: {
                        model.display.tsChecked = checked
                        if (checked) {
                            Constants.formulaSelected.push(
                                        Constants.brewData.formulaTableBodyList[model.row].name.text)
                        } else {
                            const indexToRemove = Constants.formulaSelected.indexOf(
                                                    Constants.brewData.formulaTableBodyList[model.row].name.text)
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
    }

    CollapseableTableView {
        id: ctvs
        isExtended: Constants.brewData.isExtendedService
        onIsExtendedChanged: {
            Constants.brewData.saveIsExtendedService(ctvs.isExtended)
        }

        autoExtendCol: 3

        headerText: "Service"
        rowsModel: Constants.brewData.serviceTableBodyList
        tableView.model: TableModel {

            TableModelColumn {
                display: "name"
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
            TableModelColumn {
                display: "action"
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
                column: 4
                delegate: HyperlinkBtn {
                    leftPadding: 10
                    urlText: model.display.text
                    onLinkActivated: data => {
                                         Constants.brewData.asyncServiceAction(
                                             () => {}, model.display.name,
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

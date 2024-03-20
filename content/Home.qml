import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core
import Qt.labs.qmlmodels

ColumnLayout {

    CoreLabel {
        text: Constants.brewData.refreshStatusCaskText
        visible: Constants.brewData.refreshStatusCaskVisible
    }

    CollapseableTableView {
        id: ctvc
        visible: !Constants.brewData.refreshCaskRunning


        headerText: "Cask (" + Constants.caskSelected + ")"
        rowsModel: Constants.brewData.caskTableBodyList
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
                delegate: HyperlinkBtn {
                    leftPadding: 10
                    urlText: model.display.text
                    onLinkActivated: data => {
                                         console.log(data)
                                     }
                    urlRef: model.display.text
                }
            }

            DelegateChoice {
                column: 4
                delegate: CheckBox {
                    visible: model.display.text
                    checked: model.display.tsChecked
                    leftPadding: 10
                    text: model.display.text
                    onToggled: {
                        model.display.tsChecked = checked
                        Constants.brewData.caskTableBodyList[model.row].outdated.tsChecked = checked
                        Constants.caskSelected = Constants.selectedCaskItems().length
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
        visible: !Constants.brewData.refreshFormulaRunning


        headerText: "Formula (" + Constants.formulaSelected + ")"
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
                delegate: HyperlinkBtn {
                    leftPadding: 10
                    urlText: model.display.text
                    onLinkActivated: data => {
                                         console.log(data)
                                     }
                    urlRef: model.display.text
                }
            }

            DelegateChoice {
                column: 4
                delegate: CheckBox {
                    visible: model.display.text
                    checked: model.display.tsChecked
                    leftPadding: 10
                    text: model.display.text
                    onToggled: {
                        model.display.tsChecked = checked
                        Constants.brewData.formulaTableBodyList[model.row].outdated.tsChecked = checked
                        Constants.formulaSelected = Constants.selectedFormulaItems().length
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
        autoExtendCol: 3
        visible: !Constants.brewData.refreshServiceRunning

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

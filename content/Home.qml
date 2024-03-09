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

    CollapseableGrid {
        visible: !Constants.brewData.refreshCaskRunning

        onCheckboxClicked: (c, v) => {
                               if (c) {
                                   Constants.selectedCaskItems.push(v)
                                   Constants.selectedCaskItems = [...Constants.selectedCaskItems]
                               } else {
                                   Constants.selectedCaskItems.splice(
                                       Constants.selectedCaskItems.indexOf(v),
                                       1)
                                   Constants.selectedCaskItems = [...Constants.selectedCaskItems]
                               }
                           }
        headerText: "Cask (" + Constants.selectedCaskItems.length + ")"

        isExtended: true

        headerList: ["Token", "Desk", "Tap", "Version", "outdated"]

        bodyList: Constants.brewData.caskBodyList

        sortedColIdx: Constants.brewData.caskSortedColIdx
        sortedColOrder: Constants.brewData.caskSortedColOrder

        onHeaderClicked: (colId, sortOrder) => {
                             Constants.brewData.caskSortedColIdx = colId
                             Constants.brewData.caskSortedColOrder = sortOrder
                             Constants.brewData.caskSort()
                         }
    }



    CoreLabel {
        text: Constants.brewData.refreshStatusFormulaText
        visible: Constants.brewData.refreshStatusFormulaVisible
    }

    CollapseableTableView {
        id: ctvf
        visible: !Constants.brewData.refreshFormulaRunning

        headerText: "Formula (" + Constants.selectedFormulaItems.length + ")"
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
                                         Constants.brewData.asyncFormulaSort(()=>{
                                                                         ctvf.filterTableByFilter();
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
                    onToggled: model.display.tsChecked = checked
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
                        onHoveredChanged: {
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
        text: Constants.brewData.refreshStatusServicesText
        visible: Constants.brewData.refreshStatusServicesVisible
    }


    CollapseableGrid {
        visible: !Constants.brewData.refreshServicesRunning
        isExtended: true
        headerText: "Services"

        headerList: ["Name", "Status", "User", "Plist", "Actions"]

        bodyList: Constants.brewData.servicesBodyList

        sortedColIdx: Constants.brewData.servicesSortedColIdx
        sortedColOrder: Constants.brewData.servicesSortedColOrder
        onHeaderClicked: (colId, sortOrder) => {
                             Constants.brewData.servicesSortedColIdx = colId
                             Constants.brewData.servicesSortedColOrder = sortOrder
                             Constants.brewData.servicesSort()
                         }

        onHyperlinkBtnClicked: (filterString, cellText) => {
                                   Constants.brewData.asyncServicesAction(
                                       () => {}, filterString, cellText)
                               }
    }

}

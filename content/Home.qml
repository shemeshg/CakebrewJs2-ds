import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

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

        onHeaderClicked: (colId,sortOrder)=>{
            Constants.brewData.caskSortedColIdx =  colId;
            Constants.brewData.caskSortedColOrder = sortOrder
            Constants.brewData.caskSort()
                          }
    }

    CoreLabel {
        text: Constants.brewData.refreshStatusFormulaText
        visible: Constants.brewData.refreshStatusFormulaVisible
    }

    CollapseableGrid {
        visible: !Constants.brewData.refreshFormulaRunning

        onCheckboxClicked: (c, v) => {
                               if (c) {
                                   Constants.selectedFormulaItems.push(v)
                                   Constants.selectedFormulaItems
                                   = [...Constants.selectedFormulaItems]
                               } else {
                                   Constants.selectedFormulaItems.splice(
                                       Constants.selectedFormulaItems.indexOf(
                                           v), 1)
                                   Constants.selectedFormulaItems
                                   = [...Constants.selectedFormulaItems]
                               }
                           }
        headerText: "Formula (" + Constants.selectedFormulaItems.length + ")"

        isExtended: true

        headerList: ["Name", "Desk", "Tap", "Version", "outdated", "Leaf"]

        bodyList: Constants.brewData.formulaBodyList



        sortedColIdx: Constants.brewData.formulaSortedColIdx
        sortedColOrder: Constants.brewData.formulaSortedColOrder

        onHeaderClicked: (colId,sortOrder)=>{
            Constants.brewData.formulaSortedColIdx =  colId;
            Constants.brewData.formulaSortedColOrder = sortOrder
            Constants.brewData.formulaSort()
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
        onHeaderClicked: (colId,sortOrder)=>{
            Constants.brewData.servicesSortedColIdx =  colId;
            Constants.brewData.servicesSortedColOrder = sortOrder
            Constants.brewData.servicesSort()
                          }

        onHyperlinkBtnClicked: (filterString, cellText) => {
                                   Constants.brewData.asyncServicesAction(
                                       () => {}, filterString, cellText)
                               }
    }
}

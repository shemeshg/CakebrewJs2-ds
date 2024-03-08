import CakebrewJs2
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core

ColumnLayout {
    id: collapseableGrid
    property string headerText: ""
    property bool isExtended: true
    Layout.rightMargin:  20
    Layout.leftMargin:  20

    signal checkboxClicked(bool checked, var val)
    signal headerClicked(int idx,int sortOrder)
    signal hyperlinkBtnClicked(string filterString, string cellText)

    property var headerList: []
    property var bodyList: []
    property int sortedColIdx: -1
    property int sortedColOrder: GridLayoutHeader.SortOrder.No

    ExtendableHeader {
        id: formulaHeader
        isExtended: collapseableGrid.isExtended
        headerText: collapseableGrid.headerText
    }
    CoreTextField {
        id: filterByExp
        visible: formulaHeader.isExtended
        text: ""
        Layout.fillWidth: true
        Layout.rightMargin:  5
        placeholderText: "Filter"
        onActiveFocusChanged: {
            if (activeFocus) {
                selectAll()
            }
        }
        onTextChanged: {
            filterSetTimer.start()
        }

        Timer {
            id: filterSetTimer
            running: true
            repeat: false
            onTriggered: homeGrid.filterString = filterByExp.text
            interval: 800
        }
    }
    HomeGrid {
        id: homeGrid
        visible: formulaHeader.isExtended
        //filterString: filterByExp.text
        onHeaderClicked: idx => {
                             if (sortedColIdx !== idx) {
                                 sortedColOrder = GridLayoutHeader.SortOrder.No
                             }

                             sortedColIdx = idx
                             if (sortedColOrder === GridLayoutHeader.SortOrder.Asc) {
                                 sortedColOrder = GridLayoutHeader.SortOrder.Dsc
                             } else if (sortedColOrder === GridLayoutHeader.SortOrder.Dsc) {
                                 sortedColOrder = GridLayoutHeader.SortOrder.No
                             } else {
                                 sortedColOrder = GridLayoutHeader.SortOrder.Asc
                             }
                             collapseableGrid.headerClicked(idx, sortedColOrder)
                         }
        headerList: collapseableGrid.headerList

        bodyList: collapseableGrid.bodyList

        sortedColIdx: collapseableGrid.sortedColIdx
        sortedColOrder: collapseableGrid.sortedColOrder

        onCheckboxClicked: (c, v) => {
                               collapseableGrid.checkboxClicked(c, v)
                           }
        onHyperlinkBtnClicked: (filterString, cellText) => {
                                   collapseableGrid.hyperlinkBtnClicked(
                                       filterString, cellText)
                               }
    }
}

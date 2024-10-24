import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core
import Qt.labs.qmlmodels

CoreLabel {
    signal headerClicked(int column, int sortedColOrder)
    property int sortedColOrder: 0
    property int sortedColIdx: 0
    function getOrderSymble(col) {
        if (col === sortedColIdx) {
            if (sortedColOrder === CollapseableTableView.SortOrder.Asc) {
                return " ↑"
            } else if (sortedColOrder === CollapseableTableView.SortOrder.Dsc) {
                return " ↓"
            } else {
                return ""
            }
        }

        return ""
    }

    id: tableHeaderLabel
    text: "<h4>" + model.display.text + getOrderSymble(column) + "</h4>"
    leftPadding: 10
    rightPadding: 10
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: () => {

                       if (sortedColIdx !== column) {
                           sortedColOrder = CollapseableTableView.SortOrder.No
                       }
                       sortedColIdx = column
                       if (sortedColOrder === CollapseableTableView.SortOrder.Asc) {
                           sortedColOrder = CollapseableTableView.SortOrder.Dsc
                       } else if (sortedColOrder === CollapseableTableView.SortOrder.Dsc) {
                           sortedColOrder = CollapseableTableView.SortOrder.No
                       } else {
                           sortedColOrder = CollapseableTableView.SortOrder.Asc
                       }
                       tableHeaderLabel.headerClicked(sortedColIdx, sortedColOrder)
                   }
    }
}

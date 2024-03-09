import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core
import Qt.labs.qmlmodels

CoreLabel {
    signal headerClicked(int column)
    property int sortedColOrder: 0
    property int sortedColIdx: 0
    function getOrderSymble(col) {
        if (col === sortedColIdx) {
            if (sortedColOrder === CollapseableTableViewFormula.SortOrder.Asc) {
                return " ↑"
            } else if (sortedColOrder === CollapseableTableViewFormula.SortOrder.Dsc) {
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
                           sortedColOrder = CollapseableTableViewFormula.SortOrder.No
                       }
                       sortedColIdx = column
                       if (sortedColOrder === CollapseableTableViewFormula.SortOrder.Asc) {
                           sortedColOrder = CollapseableTableViewFormula.SortOrder.Dsc
                       } else if (sortedColOrder === CollapseableTableViewFormula.SortOrder.Dsc) {
                           sortedColOrder = CollapseableTableViewFormula.SortOrder.No
                       } else {
                           sortedColOrder = CollapseableTableViewFormula.SortOrder.Asc
                       }
                       tableHeaderLabel.headerClicked(column)
                   }
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Core
import Qt.labs.qmlmodels

ColumnLayout {

    id: collapseableTableViewFormula
    property int autoExtendCol: 1
    property int sortedColOrder: CollapseableTableViewFormula.SortOrder.Asc
    property int sortedColIdx: 2
    property string headerText: ""
    property bool isExtended: true
    property var rowsModel: []
    property alias tableView: tableView
    property var filteredModel: rowsModel

    Layout.fillWidth: true

    enum SortOrder {
        No,
        Asc,
        Dsc
    }

    function getRowsModel() {
        return rowsModel.filter(row => {
                                    return row.filterString.toLowerCase(
                                        ).includes(
                                        filterByExp.text.toLowerCase())
                                    || row.filterString === ""
                                })
    }

    ExtendableHeader {
        id: formulaHeader
        isExtended: collapseableTableViewFormula.isExtended
        headerText: collapseableTableViewFormula.headerText
    }

    CoreTextField {
        id: filterByExp
        visible: formulaHeader.isExtended
        text: ""
        Layout.fillWidth: true
        Layout.rightMargin: 5
        placeholderText: "Filter"
        onTextChanged: {
            filteredModel = []
            filteredModel = getRowsModel()
            tableView.visible = false
            tableView.forceLayout()

            filterSetTimer.start()
        }
        Timer {
            id: filterSetTimer
            running: true
            repeat: false
            onTriggered: {
                tableView.forceLayout()
                tableView.height = tableView.contentHeight
                tableView.visible = true
            }

            interval: 0
        }
    }

    TableView {
        property var calWids: [] //[0,0,0,0,0,0]

        Layout.fillWidth: true
        visible: formulaHeader.isExtended
        implicitHeight: contentHeight
        columnSpacing: 1
        rowSpacing: 1
        clip: true
        id: tableView

        onWidthChanged: tableView.forceLayout()
        columnWidthProvider: function (column) {
            tableView.calWids[column] = implicitColumnWidth(column)
            let total = 0
            if (column === autoExtendCol) {
                for (var i = 0; i < tableView.calWids.length; i++) {
                    if (i !== autoExtendCol) {
                        if (tableView.calWids[i] <= 0) {
                            return implicitColumnWidth(column)
                        }

                        total = total + tableView.calWids[i]
                    }
                }
                return tableView.width - total - 30
            }
            return implicitColumnWidth(column)
        }

        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AsNeeded
        }
    }
}
